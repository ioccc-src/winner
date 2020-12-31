/* @(#)mkentry.c	1.32 9/27/96 17:16:36 */
/*
 * Copyright (c) Landon Curt Noll & Larry Bassel, 1996.
 * All Rights Reserved.  Permission for personal, education or non-profit use
 * is granted provided this this copyright and notice are included in its
 * entirety and remains unaltered.  All other uses must receive prior
 * permission in writing from both Landon Curt Noll and Larry Bassel.
 */
/*
 * mkentry - make an International Obfuscated C Code Contest entry
 *
 * usage:
 *	mkentry -r remarks -b build -p prog.c -o ioccc.entry
 *
 *	-r remarks		file with remarks about the entry
 *	-b build		file containing how prog.c should be built
 *	-p prog.c		the obfuscated program source file
 *	-o ioccc.entry		ioccc entry output file
 *
 * compile by:
 *	cc mkentry.c -o mkentry
 */
/*
 * Placed in the public domain by Landon Curt Noll, 1992.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */
/*
 * WARNING:
 *
 * This program attempts to implement the IOCCC rules.  Every attempt
 * has been made to make sure that this program produces an entry that
 * conforms to the contest rules.  In all cases, where this program
 * differs from the contest rules, the contest rules will be used.  Be
 * sure to check with the contest rules before submitting an entry.
 *
 * FOR MORE INFORMATION:
 *
 *   You may contact the judges by sending EMail to the following address:
 *
 *	...!{apple,sun,uunet}!hoptoad!judges		(not the address for
 *	judges@toad.com					 submitting entries)
 *
 *   Questions and comments about the contest are welcome.
 *
 *  The rules and the guidelines may (and often do) change from year to
 *  year.  You should be sure you have the current rules and guidelines
 *  prior to submitting entries.
 *
 * Because contest rules change from year to year, one should only use this
 * program for the year that it was intended.  Be sure that the RULE_YEAR
 * define below matches this current year.
 */

#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>

/* logic */
#ifndef TRUE
# define TRUE 1
#endif /* TRUE */
#ifndef FALSE
# define FALSE 0
#endif /* FALSE */
#define EOF_OK TRUE
#define EOF_NOT_OK FALSE

/* global limits */
#define RULE_YEAR 1996		/* NOTE: should match the current year */
#define START_DATE "4Mar92 0:00 UTC"	/* first confirmation received */
#define MAX_COL 79		/* max column a line should hit */
#define MAX_BUILD_SIZE 256	/* max how to build size */
#define MAX_PROGRAM_SIZE 3217	/* max program source size */
#define MAX_PROGRAM_SIZE2 1536	/* max program source size not counting
				   whitespace and {}; not followed by
				   whitespace or EOF */
#define MAX_TITLE_LEN 12	/* max chars in the title */
#define MAX_ENTRY_LEN 1		/* max length in the entry input line */
#define MAX_ENTRY 8		/* max number of entries per person per year */
#define MAX_FILE_LEN 1024	/* max filename length for a info file */

/* where to send entries */
#define ENTRY_ADDR1 "...!{apple,sun,uunet}!hoptoad!obfuscate"
#define ENTRY_ADDR2 "obfuscate@toad.com"

/* uuencode process - assumes ASCII */
#define UUENCODE(c) ((c) ? encode_str[(int)(c)&0x3f] : '`')
#define UUENCODE_LEN 45		/* max uuencode chunk size */
#define UUINFO_MODE 0444	/* mode of an info file's uuencode file */
#define UUBUILD_MODE 0444	/* mode of the build file's uuencode file */
#define UUBUILD_NAME "build"	/* name for the build file's uuencode file */
#define UUPROG_MODE 0444	/* mode of the program's uuencode file */
#define UUPROG_NAME "prog.c"	/* name for the program's uuencode file */

/* encode_str[(char)val] is the uuencoded character of val */
char encode_str[] = "`!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_";

/* global declarations */
char *program;			/* our name */
long start_time;		/* the startup time */

/* forward declarations */
void parse_args();
void usage();
FILE *open_remark();
FILE *open_build();
FILE *open_program();
FILE *open_output();
void output_entry();
void output_remark();
void output_author();
void output_info();
void output_build();
void output_program();
void output_end();
int get_line();
void output_till_dot();
int col_len();
void check_io();
void uuencode();

main(argc, argv)
    int argc;		/* arg count */
    char **argv;	/* the args */
{
    FILE *remark=NULL;	/* open remarks stream */
    FILE *build=NULL;	/* open build file stream */
    FILE *prog=NULL;	/* open program stream */
    FILE *output=NULL;	/* open output stream */
    char *rname=NULL;	/* file with remarks about the entry */
    char *bname=NULL;	/* file containing how prog.c should be built */
    char *pname=NULL;	/* the obfuscated program source file */
    char *oname=NULL;	/* ioccc entry output file */
    struct tm *tm;	/* startup time structure */

    /*
     * check on the year
     */
    start_time = time((long *)0);
    tm = gmtime(&start_time);
    if (tm->tm_year != RULE_YEAR-1900) {
	fprintf(stderr,
	"%s: WARNING: this program applies to %d, which may differ from %d\n\n",
	    argv[0], RULE_YEAR, 1900+tm->tm_year);
    }

    /*
     * parse the command line args
     */
    parse_args(argc, argv, &rname, &bname, &pname, &oname);

    /*
     * open/check the input and output files
     *
     * We open and truncate the output file first, in case it is the same
     * as one of the input files.
     */
    output = open_output(oname);
    remark = open_remark(rname);
    build = open_build(bname);
    prog = open_program(pname);
    if (output==NULL || remark==NULL || build==NULL || prog==NULL) {
	exit(1);
    }

    /*
     * output each section
     */
    output_entry(output, oname);
    output_remark(output, oname, remark, rname);
    output_author(output, oname);
    output_info(output, oname);
    output_build(output, oname, build, bname);
    output_program(output, oname, prog, pname);
    output_end(output, oname);

    /*
     * flush the output
     */
    if (fflush(output) == EOF) {
	fprintf(stderr, "%s: flush error in %s: ", program, oname);
	perror("");
	exit(2);
    }

    /*
     * final words
     */
    printf("\nYour entry can be found in %s.  You should check this file\n",
	oname);
    printf("correct any problems and verify that the uudecode utility will\n");
    printf("correctly decode your build file and program.\n\n");
    printf("This program has been provided as a guide for submitters.  In\n");
    printf("cases where it conflicts with the rules, the rules shall apply.\n");
    printf("It is your responsibility to ensure that your entry conforms to\n");
    printf("the current rules.\n\n");
    printf("EMail your entries to:\n");
    printf("\t%s\n", ENTRY_ADDR1);
    printf("\t%s\n\n", ENTRY_ADDR2);
    printf("Please use the following subject when you EMail your entry:\n");
    printf("\tioccc entry\n\n");
    /* all done */
    exit(0);
}

/*
 * parse_args - parse the command line args
 *
 * Given the command line args, this function parses them and sets the
 * required name flags.  This function will return only if the command
 * line syntax is correct.
 */
void
parse_args(argc, argv, rname, bname, pname, oname)
    int argc;		/* arg count */
    char **argv;	/* the args */
    char **rname;	/* file with remarks about the entry */
    char **bname;	/* file containing how prog.c should be built */
    char **pname;	/* the obfuscated program source file */
    char **oname;	/* ioccc entry output file */
{
    char *optarg;	/* -flag option operand */
    int flagname;	/* the name of the -flag */
    int i;

    /*
     * Not everyone has getopt, so we must parse args by hand.
     */
    program = argv[0];
    for (i=1; i < argc; ++i) {

	/* determine the flagname */
	if (argv[i][0] != '-') {
	    usage(1);
	    /*NOTREACHED*/
	}
	flagname = (int)argv[i][1];

	/* determine the flag's operand */
	if (flagname != '\0' && argv[i][2] != '\0') {
	    optarg = &argv[i][2];
	} else {
	    if (i+1 >= argc) {
		usage(2);
		/*NOTREACHED*/
	    } else {
		optarg = argv[++i];
	    }
	}

	/* save the flag's operand in the correct global variable */
	switch (flagname) {
	case 'r':
	    *rname = optarg;
	    break;
	case 'b':
	    *bname = optarg;
	    break;
	case 'p':
	    *pname = optarg;
	    break;
	case 'o':
	    *oname = optarg;
	    break;
	default:
	    usage(3);
	    /*NOTREACHED*/
	}
    }

    /*
     * verify that we have all of the required flags
     */
    if (*rname == NULL || *bname == NULL || *pname == NULL || *oname == NULL) {
	usage(4);
	/*NOTREACHED*/
    }
    return;
}

/*
 * usage - print a usage message and exit
 *
 * This function does not return.
 */
void
usage(exitval)
    int exitval;		/* exit with this value */
{
    fprintf(stderr,
	"usage: %s -r remarks -b build -p prog.c -o ioccc.entry\n\n", program);
    fprintf(stderr, "\t-r remarks\tfile with remarks about the entry\n");
    fprintf(stderr, "\t-b build\tfile containing how prog.c should be built\n");
    fprintf(stderr, "\t-p prog.c\tthe obfuscated program source file\n");
    fprintf(stderr, "\t-o ioccc.entry\tioccc entry output file\n");
    exit(exitval);
}

/*
 * open_remark - open/check the remark file
 *
 * The remark file should be indented by 4 spaces, and should not extend
 * beyond column MAX_COL.  These are not requirements, so we only warn.
 *
 * This function returns NULL on I/O or format error.
 */
FILE *
open_remark(filename)
    char *filename;
{
    FILE *stream;		/* the opened file stream */
    char buf[BUFSIZ+1];		/* input buffer */
    int toolong=0;		/* number of lines that are too long */
    int non_indent=0;		/* number of lines not indented by 4 spaces */

    /*
     * open the remark input file
     */
    stream = fopen(filename, "r");
    if (stream == NULL) {
	fprintf(stderr, "%s: cannot open remark file: %s: ",
	    program, filename);
	perror("");
	return(NULL);
    }

    /*
     * look at each line
     */
    while (fgets(buf, BUFSIZ, stream) != NULL) {

	/* count lines that do not start with 4 spaces */
	if (buf[0] != '\n' && strncmp(buf, "    ", 4) != 0) {
	    ++non_indent;
	}

	/* count long lines */
	if (col_len(buf) > MAX_COL) {
	    /* found a line that is too long */
	    ++toolong;
	}
    }

    /* watch for I/O errors */
    check_io(stream, filename, EOF_OK);

    /* note long lines if needed */
    if (toolong > 0) {
	fprintf(stderr,
	    "%s: WARNING: %d line(s) from %s extend beyond the 80th column\n",
	    program, toolong, filename);
	fprintf(stderr,
	    "%s:          This is ok, but it would be nice to avoid\n\n",
	    program);
    }

    /* note non-indented lines, if needed */
    if (non_indent > 0) {
	fprintf(stderr,
	    "%s: WARNING: %d line(s) from %s are not indented by 4 spaces\n",
	    program, non_indent, filename);
	fprintf(stderr,
	    "%s:          This is ok, but it would be nice to avoid\n\n",
	    program);
    }

    /* return the open file */
    rewind(stream);
    return(stream);
}

/*
 * open_build - open/check the build file
 *
 * The how to build file must not be longer than MAX_BUILD_SIZE bytes.
 *
 * This function returns NULL on I/O or size error.
 */
FILE *
open_build(filename)
    char *filename;
{
    FILE *stream;		/* the opened file stream */
    struct stat statbuf;	/* the status of the open file */

    /*
     * open the how to build input file
     */
    stream = fopen(filename, "r");
    if (stream == NULL) {
	fprintf(stderr, "%s: cannot open how to build file: %s: ",
	    program, filename);
	perror("");
	return(NULL);
    }

    /*
     * determine the size of the file
     */
    if (fstat(fileno(stream), &statbuf) < 0) {
	fprintf(stderr, "%s: cannot stat how to build file: %s: ",
	    program, filename);
	perror("");
	return(NULL);
    }
    if (statbuf.st_size > MAX_BUILD_SIZE) {
	fprintf(stderr,
	    "%s: FATAL: the how to build file: %s, is %d bytes long\n",
	    program, filename, statbuf.st_size);
	fprintf(stderr,
	    "%s:        it may not be longer than %d bytes\n",
	    program, MAX_BUILD_SIZE);
	return(NULL);
    }

    /* return the open file */
    return(stream);
}

/*
 * open_program - open/check the program source file
 *
 * The program source file must be <= 3217 bytes.  The number of
 * non-whitespace and }{; chars not followed by whitespace must
 * be <= 1536 bytes.
 *
 * This function returns NULL on I/O or size error.
 */
FILE *
open_program(filename)
    char *filename;
{
    FILE *stream;		/* the opened file stream */
    struct stat statbuf;	/* the status of the open file */
    int count;			/* special count size */
    int c;			/* the character read */

    /*
     * open the program source input file
     */
    stream = fopen(filename, "r");
    if (stream == NULL) {
	fprintf(stderr, "%s: cannot open program source file: %s: ",
	    program, filename);
	perror("");
	exit(7);
    }

    /*
     * determine the size of the file
     */
    if (fstat(fileno(stream), &statbuf) < 0) {
	fprintf(stderr, "%s: cannot stat program source file: %s: ",
	    program, filename);
	perror("");
	return(NULL);
    }
    if (statbuf.st_size > MAX_PROGRAM_SIZE) {
	fprintf(stderr,
	    "%s: FATAL: the program source file: %s, is %d bytes long\n",
	    program, filename, statbuf.st_size);
	fprintf(stderr,
	    "%s:        it may not be longer than %d bytes\n",
	    program, MAX_PROGRAM_SIZE);
	return(NULL);
    }

    /*
     * count the non-whitespace, non {}; followed by whitespace chars
     */
    count = 0;
    c = 0;
    while ((c=fgetc(stream)) != EOF) {
	/* look at non-whitespace */
	if (!isascii(c) || !isspace(c)) {
	    switch (c) {
	    case '{':		/* count if not followed by EOF or whitespace */
	    case '}':
	    case ';':
		/* peek at next char */
		c = fgetc(stream);
		if (c != EOF && isascii(c) && !isspace(c)) {
		    /* not followed by whitespace or EOF, count it */
		    ungetc(c, stream);
		    ++count;
		}
		break;
	    default:
		++count;
		break;
	    }
	}
    }

    /* watch for I/O errors */
    check_io(stream, filename, EOF_OK);

    /* look at the special size */
    if (count > MAX_PROGRAM_SIZE2) {
	fprintf(stderr,
	    "%s: FATAL: the number of bytes that are non-whitespace, and\n",
	    program);
	fprintf(stderr,
	    "%s:        that are not '{', '}', ';' followed by whitespace\n",
	    program);
	fprintf(stderr,
	    "%s:        or EOF must be <= %d bytes\n",
	    program, MAX_PROGRAM_SIZE2);
	fprintf(stderr,
	    "%s:        in %s, %d bytes were found\n",
	    program, filename, count);
	return(NULL);
    }

    /* return the open file */
    rewind(stream);
    return(stream);
}

/*
 * open_output - open/check the entry output file
 *
 * This function returns NULL on open error.
 */
FILE *
open_output(filename)
    char *filename;
{
    FILE *stream;		/* the opened file stream */

    /*
     * open the ioccc entry output file
     */
    stream = fopen(filename, "w");
    if (stream == NULL) {
	fprintf(stderr, "%s: cannot open ioccc entry file for output: %s: ",
	    program, filename);
	perror("");
	exit(8);
    }

    /* return the open file */
    return(stream);
}

/*
 * output_entry - output the ---entry--- section
 *
 * Read the needed information form stdin, and write the entry section.
 */
void
output_entry(output, oname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
{
    char title[MAX_TITLE_LEN+1+1];	/* the entry's title */
    char buf[MAX_COL+1+1];		/* I/O buffer */
    int entry=0;			/* entry number */
    int ret;				/* fields processed by fscanf */
    int ok_line=0;			/* 0 => the line is not ok */
    char skip;				/* input to skip */
    FILE *date_pipe;			/* pipe to a date command */
    time_t epoch_sec;			/* seconds since the epoch */
    char *p;

    /*
     * write the start of the section
     */
    fprintf(output, "---entry---\n");
    check_io(output, oname, EOF_NOT_OK);

    /*
     * write the rule year
     */
    fprintf(output, "rule:\t%d-1\n", RULE_YEAR);
    check_io(output, oname, EOF_NOT_OK);

    /* determine if this is a fix */
    printf("Is this a fix, update or resubmittion to a ");
    printf("previous entry (enter y or n)? ");
    while (get_line(buf, 1+1, 0) <= 0 || !(buf[0]=='y' || buf[0]=='n')) {
	printf("\nplease answer y or n: ");
    }
    if (buf[0] == 'y') {
	fprintf(output, "fix:\ty\n");
	check_io(output, oname, EOF_NOT_OK);
	printf("\nBe sure that the title and entry number that you give\n");
	printf("are the same of as the entry you are replacing\n");
    } else {
	fprintf(output, "fix:\tn\n");
	check_io(output, oname, EOF_NOT_OK);
    }

    /*
     * write the title
     */
    printf("\nThe first character of your title should match [a-zA-Z0-9_=]\n");
    printf("The next 0 to %d characters should match [a-zA-Z0-9_=+-]\n\n",
	MAX_TITLE_LEN-1);
    printf("It is suggested, but not required, that the title should\n");
    printf("incorporate your username; in the\n");
    printf("case of multiple authors, consider using parts of the usernames\n");
    printf("of the authors.\n\n");
    printf("enter your title: ");
    do {
	/* prompt and read a line */
	if ((ok_line = get_line(title, MAX_TITLE_LEN+1, MAX_COL-9)) <= 0) {
	    printf("\ntitle is too long, please re-enter: ");
	    continue;
	}

	/* verify the pattern, not everyone has regexp, so do it by hand */
	if (!isascii((int)title[0]) ||
	    !(isalnum((int)title[0]) || title[0] == '_' || title[0] == '=')) {
	    printf("\ninvalid first character in the title\n\n");
	    printf("enter your title: ");
	    ok_line = 0;
	} else {
	    for (p=(&title[1]); *p != '\0' && *p != '\n'; ++p) {
		if (!isascii((int)*p) ||
		    !(isalnum((int)*p) ||
		      *p == '_' || *p == '=' || *p == '+' || *p == '-')) {
		    printf("\ninvalid character in the title\n\n");
		    printf("enter your title: ");
		    ok_line = 0;
		}
	    }
	}
    } while (ok_line <= 0);
    fprintf(output, "title:\t%s", title);
    check_io(output, oname, EOF_NOT_OK);

    /*
     * write the entry number
     */
    printf("\nEach person may submit up to %d entries per year.\n\n",
	MAX_ENTRY);
    printf("enter an entry number from 0 to %d inclusive: ", MAX_ENTRY-1);
    do {
	/* get a valid input line */
	fflush(stdout);
	ret = fscanf(stdin, "%d[\n]", &entry);
	check_io(stdin, "stdin", EOF_NOT_OK);
	/* skip over input until newline is found */
	do {
	    skip = fgetc(stdin);
	    check_io(stdin, "stdin", EOF_NOT_OK);
	    if (skip != '\n') {
		/* bad text in input, invalidate entry number */
		entry = -1;
	    }
	} while (skip != '\n');

	/* check if we have a number, and if it is in range */
	if (ret != 1 || entry < 0 || entry > MAX_ENTRY-1) {
	    printf(
	      "\nThe entry number must be between 0 and %d inclusive\n\n",
		MAX_ENTRY-1);
	    printf("enter the entry number: ");
	}
    } while (ret != 1 || entry < 0 || entry > MAX_ENTRY-1);
    fprintf(output, "entry:\t%d\n", entry);
    check_io(output, oname, EOF_NOT_OK);

    /*
     * write the submission date
     */
    /* returns a newline */
    epoch_sec = time(NULL);
    fprintf(output, "date:\t%s", asctime(gmtime(&epoch_sec)));
    check_io(output, oname, EOF_NOT_OK);

    /*
     * write the OS/machine host information
     */
    printf(
      "\nEnter the machine(s) and OS(s) under which your entry was tested.\n");
    output_till_dot(output, oname, "host:");
}

/*
 * output_remark - output the ---remark--- section
 *
 * Read the needed information form stdin, and write the entry section.
 */
void
output_remark(output, oname, remark, rname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
    FILE *remark;		/* stream to the file containing remark text */
    char *rname;		/* name of the remark file */
{
    char buf[BUFSIZ+1];		/* input/output buffer */

    /*
     * write the start of the section
     */
    fprintf(output, "---remark---\n");
    check_io(output, oname, EOF_NOT_OK);

    /*
     * copy the remark file to the section
     */
    while (fgets(buf, BUFSIZ, remark) != NULL) {
	fputs(buf, output);
	check_io(output, oname, EOF_NOT_OK);
    }
    check_io(remark, rname, EOF_OK);

    /* be sure that the remark section ends with a newline */
    if (buf[strlen(buf)-1] != '\n') {
	fputc('\n', output);
	check_io(output, oname, EOF_NOT_OK);
    }
}

/*
 * output_author - output the ---author--- section
 *
 * Read the needed information from stdin, and write the author section.
 * If multiple authors exist, multiple author sections will be written.
 */
void
output_author(output, oname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
{
    char buf[MAX_COL+1+1];	/* I/O buffer */
    int more_auths;		/* TRUE => more authors to note */
    int auth_cnt=0;		/* number of authors processed */

    /*
     * prompt the user for the author section
     */
    printf("\nEnter information about each author.  If your entry is after\n");
    printf("%s and before the contest deadline, the judges\n", START_DATE);
    printf("will attempt to EMail back a confirmation to the first author\n");

    /*
     * place author information for each author in an individual section
     */
    do {

	/* write the start of the section */
	fprintf(output, "---author---\n");
	check_io(output, oname, EOF_NOT_OK);

	/* write the author */
	printf("\nAuthor #%d name: ", ++auth_cnt);
	while (get_line(buf, MAX_COL+1, MAX_COL-9) <= 0) {
	    printf("\nname too long, please re-enter: ");
	}
	fprintf(output, "name:\t%s", buf);
	check_io(output, oname, EOF_NOT_OK);

	/* write the organization */
	printf("\nEnter the School/Company/Organization of author #%d\n",
	    auth_cnt);
	printf("\nAuthor #%d org: ", auth_cnt);
	while (get_line(buf, MAX_COL+1, MAX_COL-9) <= 0) {
	    printf("\nline too long, please re-enter: ");
	}
	fprintf(output, "org:\t%s", buf);
	check_io(output, oname, EOF_NOT_OK);

	/* write the address */
	printf(
	    "\nEnter the postal address for author #%d.  Be sure to include\n",
	    auth_cnt);
	printf("your country and do not include your name.\n");
	output_till_dot(output, oname, "addr:");

	/* write the EMail address */
	printf(
	    "\nEnter the EMail address for author #%d.  Use an address from\n",
	    auth_cnt);
	printf(
	    "a registered domain or well known site.  If you give several\n");
	printf("forms, list them one per line.\n");
	output_till_dot(output, oname, "email:");

	/* write the home page URL */
	printf(
	    "\nEnter the fully qualified home page URL for author #%d\n",
	    auth_cnt);
	printf("including the http: part or type none: ");
	while (get_line(buf, MAX_COL+1, MAX_COL-9) <= 0 ||
	       (strncmp(buf, "http://", sizeof("http://")-1) != 0 &&
		strcmp(buf, "none\n") != 0)) {
	      printf("\nURL too long, does not begin with http:// or\n");
	      printf("is not the word none\n");
	}
	fprintf(output, "url:\t%s", buf);
	check_io(output, oname, EOF_NOT_OK);

	/* write the anonymous status */
	printf("\nShould author #%d remain anonymous (enter y or n)? ",
	    auth_cnt);
	while (get_line(buf, 1+1, 0) <= 0 || !(buf[0]=='y' || buf[0]=='n')) {
	    printf("\nplease answer y or n: ");
	}
	fprintf(output, "anon:\t%s", buf);
	check_io(output, oname, EOF_NOT_OK);

	/* determine if there is another author */
	printf("\nIs there another author (enter y or n)? ");
	while (get_line(buf, 1+1, 0) <= 0 || !(buf[0]=='y' || buf[0]=='n')) {
	    printf("\nplease answer y or n: ");
	}
	if (buf[0] == 'y') {
	    more_auths = TRUE;
	} else {
	    more_auths = FALSE;
	}
    } while (more_auths == TRUE);
    return;
}

/*
 * output_info - output the ---info--- section(s)
 *
 * Read the needed information from stdin, and write the info section.
 * If multiple info files exist, multiple info sections will be written.
 */
void
output_info(output, oname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
{
    char infoname[MAX_FILE_LEN+1];	/* filename buffer */
    char yorn[1+1];		/* y or n answer */
    char *uuname;		/* name to uuencode as */
    FILE *infile;		/* info file stream */

    /*
     * prompt the user for info information
     */
    printf("\nInfo files should be used only to supplement your entry.\n");
    printf("For example, info files may provide sample input or detailed\n");
    printf("information about your entry.  Because they are supplemental,\n");
    printf("the entry should not require them to exist.\n\n");

    /*
     * while there is another info file to save, uuencode it
     */
    printf("Do you have a info file to include (enter y or n)? ");
    while (get_line(yorn, 1+1, 0) <= 0 || !(yorn[0]=='y' || yorn[0]=='n')) {
	printf("\nplease answer y or n: ");
    }
    while (yorn[0] == 'y') {

	/* read the filename */
	printf("\nEnter the info filename: ");
	while (get_line(infoname, MAX_FILE_LEN+1, 0) <= 0) {
	    printf("\nInfo filename too long, please re-enter: ");
	}

	/* compute the basename of the info filename */
	/* remove the trailing newline */
	uuname = &infoname[strlen(infoname)-1];
	*uuname = '\0';
	/* avoid rindex/shrrchr compat issues, do it by hand */
	for (--uuname; uuname > infoname; --uuname) {
	    if (*uuname == '/') {
		++uuname;
		break;
	    }
	}

	/* attempt to open the info file */
	infile = fopen(infoname, "r");
	if (infile == NULL) {
	    fprintf(stderr, "\n%s: cannot open info file: %s: ",
		program, infoname);
	    perror("");
	    continue;
	}

	/*
	 * write the start of the section
	 */
	fprintf(output, "---info---\n");
	check_io(output, oname, EOF_NOT_OK);

	/* uuencode the info file */
	uuencode(output, oname, infile, infoname, UUINFO_MODE, uuname);

	printf("\nDo you have another info file to include (enter y or n)? ");
	while (get_line(yorn, 1+1, 0) <= 0 || !(yorn[0]=='y' || yorn[0]=='n')) {
	    printf("\nplease answer y or n: ");
	}
    };
    return;
}

/*
 * output_build - output the ---build--- section
 *
 * Read the needed information from stdin, and write the build section.
 */
void
output_build(output, oname, build, bname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
    FILE *build;		/* open build file stream */
    char *bname;		/* name of the build file */
{
    /*
     * write the start of the section
     */
    fprintf(output, "---build---\n");
    check_io(output, oname, EOF_NOT_OK);

    /*
     * uuencode the program file
     */
    uuencode(output, oname, build, bname, UUBUILD_MODE, UUBUILD_NAME);
    return;
}

/*
 * output_program - output the ---program--- section
 *
 * Read the needed information form stdin, and write the program section.
 */
void
output_program(output, oname, prog, pname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
    FILE *prog;			/* open program stream */
    char *pname;		/* name of program file */
{
    /*
     * write the start of the section
     */
    fprintf(output, "---program---\n");
    check_io(output, oname, EOF_NOT_OK);

    /*
     * uuencode the program file
     */
    uuencode(output, oname, prog, pname, UUPROG_MODE, UUPROG_NAME);
    return;
}

/*
 * output_end - output the ---end--- section
 *
 * Read the needed information form stdin, and write the 'end section'.
 */
void
output_end(output, oname)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
{
    /*
     * write the final section terminator
     */
    fprintf(output, "---end---\n");
    check_io(output, oname, EOF_NOT_OK);
    return;
}

/*
 * get_line - get an answer from stdin
 *
 * This function will flush stdout, in case a prompt is pending, and
 * read in the answer.
 *
 * This function returns 0 if the line is too long, of the length of the
 * line (including the newline) of the line was ok.  This function does
 * not return if ERROR or EOF.
 */
int
get_line(buf, siz, maxcol)
    char *buf;			/* input buffer */
    int siz;			/* length of input, including the newline */
    int maxcol;			/* max col allowed, 0 => disable check */
{
    int length;			/* the length of the input line */

    /* flush terminal output */
    fflush(stdout);

    /* read the line */
    if (fgets(buf, siz+1, stdin) == NULL) {
	/* report the problem */
	check_io(stdin, "stdin", EOF_NOT_OK);
    }

    /* look for the newline */
    length = strlen(buf);
    if (buf[length-1] != '\n') {
	int eatchar;		/* the char being eaten */

	/* no newline found, line must be too long, eat the rest of the line */
	do {
	    eatchar = fgetc(stdin);
	} while (eatchar != EOF && eatchar != '\n');
	check_io(stdin, "stdin", EOF_NOT_OK);

	/* report the situation */
	return 0;
    }

    /* watch for long lines, if needed */
    if (maxcol > 0 && (length > maxcol || col_len(buf) > maxcol)) {
	/* report the situation */
	return 0;
    }

    /* return length */
    return length;
}

/*
 * output_till_dot - output a set of lines until '.' by itself is read
 *
 * This routine will read a set of lines until (but not including)
 * a single line with '.' is read.  The format of the output is:
 *
 *	leader:\tfirst line
 *	\tnext line
 *	\tnext line
 *	   ...
 *
 * This routine will not return if I/O error or EOF.
 */
void
output_till_dot(output, oname, leader)
    FILE *output;		/* entry's output file stream */
    char *oname;		/* name of the output file */
    char *leader;		/* the lead text for the first line */
{
    char buf[BUFSIZ+1];		/* input buffer */
    int count;			/* lines read */
    int done=FALSE;		/* TRUE => finished reading input */

    /* instruct the user on how to input */
    printf("\nTo end input, enter a line with a single period.\n");

    /* read lines until '.' or EOF */
    count = 0;
    while (!done) {
	/* issue the prompt */
	printf("%s\t", (count>0) ? "" : leader);
	fflush(stdout);

	/* get the line */
	if (get_line(buf, BUFSIZ, MAX_COL-9) <= 0) {
	    printf("\nline too long, please re-enter:\n\t");
	    continue;
	}

	/* note if '.' was read */
	if (strcmp(buf, ".\n") == 0) {
	    done = TRUE;
	}

	/* write line if we read something */
	if (!done) {
	    fprintf(output, "%s\t%s", (count++>0) ? "" : leader, buf);
	    check_io(output, oname, EOF_NOT_OK);
	}
    }

    /* if no lines read, at least output something */
    if (count <= 0) {
	fprintf(output, "%s\t.\n", leader);
	check_io(output, oname, EOF_NOT_OK);
    }
    return;
}

/*
 * col_len - determine the highest that a string would reach
 *
 * Given a string, this routine returns that a string would reach
 * if the string were printed at column 1.  Tab stops are assumed
 * to start at 9, 17, 25, 33, ...
 */
int
col_len(string)
    char *string;		/* the string to examine */
{
    int col;	/* current column */
    char *p;	/* current char */

    /* scan the string */
    for (col=0, p=string; *p != '\0' && *p != '\n'; ++p) {
	/* note the column shift */
	col = (*p=='\t') ? 1+((col+8)/8*8) : col+1;
    }
    if (*p == '\n') {
	--col;
    }

    /* return the highest column */
    return col;
}

/*
 * check_io - check for EOF or I/O error on a stream
 *
 * Does not return if EOF or I/O error.
 */
void
check_io(stream, name, eof_ok)
    FILE *stream;		/* the stream to check */
    char *name;			/* the name of this stream */
    int eof_ok;			/* EOF_OK or EOF_NOT_OK */
{
    /* test for I/O error */
    if (ferror(stream)) {
	fprintf(stderr, "%s: error on %s: ", program, name);
	perror("");
	exit(1);

    /* test for EOF */
    } else if (eof_ok == EOF_NOT_OK && feof(stream)) {
	fprintf(stderr, "%s: EOF on %s\n", program, name);
	exit(1);
    }
    return;
}

/*
 * uuencode - uuencode a file
 *
 * Perform the uuencoding process identical to the process performed
 * by the uuencode(1) utility.
 *
 * This routine implements the algorithm described in the uuencode(5)
 * 4.3BSD Reno man page.
 */
void
uuencode(output, oname, infile, iname, umode, uname)
    FILE *output;		/* output file stream */
    char *oname;		/* output filename */
    FILE *infile;		/* input file stream */
    char *iname;		/* input filename */
    int umode;			/* the mode to put on the uuencode file */
    char *uname;		/* name to put on the uuencode file */
{
    char buf[UUENCODE_LEN+1];	/* the uuencode buffer */
    int read_len;		/* actual number of chars read */
    int val;			/* 6 bit chunk from buf */
    char filler='\0';		/* filler uuencode pad text */
    char *p;

    /*
     * output the initial uuencode header
     */
    fprintf(output, "begin %o %s\n", umode, uname);
    check_io(output, oname, EOF_NOT_OK);

    /*
     * clear out the input buffer
     */
    for (p=buf; p < &buf[sizeof(buf)/sizeof(buf[0])]; ++p) {
	*p = '\0';
    }

    /*
     * We will process UUENCODE_LEN chars at a time, forming
     * a single output line each time.
     */
    while ((read_len=fread(buf,sizeof(buf[0]),UUENCODE_LEN,infile)) > 0) {

	/*
	 * the first character is the length character
	 */
	fputc(UUENCODE(read_len), output);
	check_io(output, oname, EOF_NOT_OK);

	/*
	 * We will convert 24 bits at a time.  Thus we will convert
	 * 3 sets of 8 bits into 4 sets of uuencoded 6 bits.
	 */
	for (p=buf; read_len>0; read_len-=3, p+=3) {

	    /* bits 0 to 5 */
	    val = (p[0]>>2)&0x3f;
	    fputc(UUENCODE(val), output);
	    check_io(output, oname, EOF_NOT_OK);

	    /* bits 6 to 11 */
	    val = ((p[0]<<4)&0x30) | ((p[1]>>4)&0x0f);
	    fputc(UUENCODE(val), output);
	    check_io(output, oname, EOF_NOT_OK);

	    /* bits 12 to 17 */
	    val = ((p[1]<<2)&0x3c) | ((p[2]>>6)&0x03);
	    fputc(UUENCODE(val), output);
	    check_io(output, oname, EOF_NOT_OK);

	    /* bits 18 to 23 */
	    val = p[2]&0x3f;
	    fputc(UUENCODE(val), output);
	    check_io(output, oname, EOF_NOT_OK);
	}

	/* end of UUENCODE_LEN line */
	fputc('\n', output);
	check_io(output, oname, EOF_NOT_OK);

	/*
	 * clear out the input buffer  (don't depend on bzero() or memset())
	 */
	for (p=buf; p < &buf[sizeof(buf)/sizeof(buf[0])]; ++p) {
	    *p = '\0';
	}
    }

    /* check the last read on the input file */
    check_io(infile, iname, EOF_OK);

    /* write end of uuencode file */
    fprintf(output, "%c\nend\n", UUENCODE(filler));
    check_io(output, oname, EOF_NOT_OK);
}
