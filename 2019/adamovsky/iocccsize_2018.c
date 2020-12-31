/*
 * iocccsize - IOCCC Source Size Tool
 *
 * This IOCCC size tool source file is version 2017-12-25-v25.
 *
 * "You are not expected to understand this" :-)
 *
 * Public Domain 1992, 2015 by Anthony Howe.  All rights released.
 * With IOCCC minor mods in 2013-2017 by chongo (Landon Curt Noll) ^oo^
 *
 * SYNOPSIS
 *
 * 	ioccc [-kirs] < input
 *
 *	-k	keep comment blocks
 *	-i	IOCCC size rule (overall size, modified)
 *	-r	count C reserved words as 1 byte
 *	-s	suppress source output, write only the IOCCC 2nd size count
 *
 * DESCRIPTION
 *
 *	Taking input from standard input, apply the IOCCC Source Size Rule
 *	for 2001.  The program's official length is written to standard error.
 *	Also filter out C comment blocks (-k to keep) sending the modified
 *	source to standard output.
 *
 *	The 2001 Source Size Rule was:
 *
 *	Your entry must be <= 4096 bytes in length.  The number of octets
 *	excluding whitespace (tab, space, newline, form-feed, return), and
 *	excluding any ';', '{' or '}' followed by whitespace or end of file,
 *	must be <= 2048.
 *
 *	2013 Source Size Rule is (-r):
 *
 *	Your entry must be <= 4096 bytes in length.  The number of octets
 *	excluding whitespace (tab, space, newline, form-feed, return), and
 *	excluding any ';', '{' or '}' followed by whitespace or end of file,
 *	and where C reserved words, including a subset of preprocessor words,
 *	count as 1 byte, must be <= 2053 (first prime after 2048).
 */

/*
 * The official IOCCC rule 2 secondary limit on C code size
 *
 * The IOCCC size tool should be compiled as:
 *
 *      cc -pedantic -Wall -std=c99 iocccsize.c -o iocccsize
 *
 * This tool computes a 2nd size C code.  To check your program source
 * against the 2nd limit of rule 2, use the -i command line option.
 *
 * For example:
 *
 *      ./iocccsize -i < prog.c
 *
 * The IOCCC size tool, when using the -i option, may be summarized as:
 *
 *      The size tool counts C language keywords (primary, secondary, and
 *      selected preprocessor keywords) as 1.  The size tool counts all
 *      other octets as 1 excluding ASCII whitespace, and excluding any
 *      ';', '{' or '}' followed by ASCII whitespace, and excluding any
 *      ';', '{' or '}' octet immediately before the end of file.
 *
 * ASCII whitespace includes ASCII tab, ASCII space, ASCII newline,
 * ASCII form-feed, and ASCII carriage return.
 *
 * In cases where the above summary and the algorithm implemented by
 * the IOCCC size tool source code conflict, the algorithm implemented
 * by the IOCCC size tool source code is preferred by the judges.
 *
 * See the current IOCCC rules and guidelines for more information.
 * In particular, see the current IOCCC size rule for information about
 * the maximum value that this tool should print for an entry to be valid.
 */

/*
 * IOCCC Judge's remarks:
 *
 * This code contains undocumented features.  On the other hand, this code
 * is RTFS (for certain values of RTFS). One might say that this code
 * perfectly documents itself. :-)
 *
 * Many thanks to Anthony Howe for taking the time to put his OCD
 * (Obfuscated Coding Determination) into this code!
 */

/*
 * HINT: The algorithm implemented by this code may or not be obfuscated.
 *       The algorithm may not or may appear to be obfuscated.
 *
 * In particular:
 *
 *      We did not invent the algorithm.
 *      The algorithm consistently finds Obfuscation.
 *      The algorithm killed Obfuscation.
 *      The algorithm is banned in C.
 *      The algorithm is from Bell Labs in Jersey.
 *      The algorithm constantly finds Obfuscation.
 *      This is not the algorithm.
 *      This is close.
 */

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <getopt.h>

#define FLAG_SILENCE		1
#define FLAG_KEEP		2
#define FLAG_RESERVED		4
#define FLAG_IOCCC		8
#define FLAG_SILLY_C		16
#define FLAG_SILLY_H		32

#define BUFFER_SIZE		521
#define MAX_SIZE		4096	/* IOCCC Rule 2 */
#define MAX_COUNT		2053	/* IOCCC Rule 2 */

static char usage[] =
"usage:  ioccc [-kirsch] < prog.c\n"
"\n"
"-k\t\tkeep block comments\n"
"-i\t\tprint official secondary IOCCC size to stdout\n"
"\t\tmax.size warnings to stderr, NOTE: implies -r -s\n"
"-r\t\tcount C reserved words as 1 byte\n"
"-s\t\tsuppress source output, write only the official size\n"
"-c\t\tan undocumented feature\n"
"-h\t\tyet another undocumented feature\n"
;

#define STRLEN(s)		(sizeof (s)-1)

typedef struct {
	size_t length;
	const char *word;
} Word;

/*
 * C reserved words, plus a few #preprocessor tokens, that count as 1
 *
 * NOTE: For a good list of reserved words in C, see:
 *
 *	http://www.bezem.de/pdf/ReservedWordsInC.pdf
 *
 * by Johan Bezem of JB Enterprises:
 *
 *	See http://www.bezem.de/en/
 */
/*
 * The following editorial plea expresses a view shared by more than zero
 * IOCCC judges. It may not represent the opinion of all those involved
 * with this code nor the International Obfuscated C Code Contest as a whole:
 *
 * The long list of reserved words below should be a source
 * of embarrassment to some of those involved in standardizing C.
 * The growing list of reserved words, along with an expanding set of
 * linguistic inventions has the appearance of feature
 * creep that, if left unchecked, risks turning a beautifully elegant
 * language into a steaming pile of biological excretion.
 *
 * The history of the IOCCC has taught us that even minor changes
 * to the language are not always well understood by compiler writers,
 * let alone the standards body who publishes them. We have enormous
 * sympathy for C compiler writers who must keep up with the creeping
 * featurism.  We are aware of some C standards members who share
 * these concerns.  Alas, they seem to be a minority.
 *
 * The C standards body as a whole, before they emit yet more mountains of new
 * standardese, might wish consider the option of moth-balling their committee.
 * Or if they must produce a new standard, consider naming whatever
 * follows c11 as CNC (C's Not C).  :-)
 */
static Word cwords[] = {
	/* Yes Virginia, we left #define off the list on purpose! */
	{ STRLEN("#elif"), "#elif" },
	{ STRLEN("#else"), "#else" },
	{ STRLEN("#endif"), "#endif" },
	{ STRLEN("#error"), "#error" },
	{ STRLEN("#ident"), "#ident" },
	{ STRLEN("#if"), "#if" },
	{ STRLEN("#ifdef"), "#ifdef" },
	{ STRLEN("#include"), "#include" },
	{ STRLEN("#line"), "#line" },
	{ STRLEN("#pragma"), "#pragma" },
	{ STRLEN("#sccs"), "#sccs" },
	{ STRLEN("#warning"), "#warning" },
	/**/
	{ STRLEN("_Alignas"), "_Alignas" },
	{ STRLEN("_Alignof"), "_Alignof" },
	{ STRLEN("_Atomic"), "_Atomic" },
	{ STRLEN("_Bool"), "_Bool" },
	{ STRLEN("_Complex"), "_Complex" },
	{ STRLEN("_Generic"), "_Generic" },
	{ STRLEN("_Imaginary"), "_Imaginary" },
	{ STRLEN("_Noreturn"), "_Noreturn" },
	{ STRLEN("_Pragma"), "_Pragma" },
	{ STRLEN("_Static_assert"), "_Static_assert" },
	{ STRLEN("_Thread_local"), "_Thread_local" },
	/*
	 * this comment is not expected to understand itself
	 */
	{ STRLEN("alignas"), "alignas" },
	{ STRLEN("alignof"), "alignof" },
	{ STRLEN("and"), "and" },
	{ STRLEN("and_eq"), "and_eq" },
	{ STRLEN("auto"), "auto" },
	{ STRLEN("bitand"), "bitand" },
	{ STRLEN("bitor"), "bitor" },
	{ STRLEN("bool"), "bool" },
	{ STRLEN("break"), "break" },
	{ STRLEN("case"), "case" },
	{ STRLEN("char"), "char" },
	{ STRLEN("compl"), "compl" },
	{ STRLEN("const"), "const" },
	{ STRLEN("continue"), "continue" },
	{ STRLEN("default"), "default" },
	{ STRLEN("do"), "do" },
	{ STRLEN("double"), "double" },
	{ STRLEN("else"), "else" },
	{ STRLEN("enum"), "enum" },
	{ STRLEN("extern"), "extern" },
	{ STRLEN("false"), "false" },
	{ STRLEN("float"), "float" },
	{ STRLEN("for"), "for" },
	{ STRLEN("goto"), "goto" },
	{ STRLEN("I"), "I" },
	{ STRLEN("if"), "if" },
	{ STRLEN("inline"), "inline" },
	{ STRLEN("int"), "int" },
	{ STRLEN("long"), "long" },
	{ STRLEN("noreturn"), "noreturn" },
	{ STRLEN("not"), "not" },
	{ STRLEN("not_eq"), "not_eq" },
	{ STRLEN("or"), "or" },
	{ STRLEN("or_eq"), "or_eq" },
	{ STRLEN("register"), "register" },
	{ STRLEN("restrict"), "restrict" },
	{ STRLEN("return"), "return" },
	{ STRLEN("short"), "short" },
	{ STRLEN("signed"), "signed" },
	{ STRLEN("sizeof"), "sizeof" },
	{ STRLEN("static"), "static" },
	{ STRLEN("static_assert"), "static_assert" },
	{ STRLEN("struct"), "struct" },
	{ STRLEN("switch"), "switch" },
	{ STRLEN("thread_local"), "thread_local" },
	{ STRLEN("true"), "true" },
	{ STRLEN("typedef"), "typedef" },
	{ STRLEN("union"), "union" },
	{ STRLEN("unsigned"), "unsigned" },
	{ STRLEN("void"), "void" },
	{ STRLEN("volatile"), "volatile" },
	{ STRLEN("while"), "while" },
	{ STRLEN("xor"), "xor" },
	{ STRLEN("xor_eq"), "xor_eq" },
	/**/
	{ 0, NULL }
};

/*
 * Keep track of discarded bytes by read_line() so count() can report
 * correct wc(1) equivalent counts.
 */
static int xlcount = 0;
static int xwcount = 0;
static int xbcount = 0;

static Word *
find_member(Word *table, const char *string)
{
	Word *w;
	for (w = table; w->length != 0; w++) {
		if (strncmp(string, w->word, w->length) == 0
		&& !isalnum(string[w->length]) && string[w->length] != '_')
			return w;
	}
	return NULL;
}

/*
 * ISO C11 section 5.2.1.1 Trigraph Sequences, leading sequence "??"
 */
static char trigraph[] = "=(/)'<!>-";
static char asciimap[] = "#[\\]^{|}~";

static size_t
read_line(char *buf, size_t size)
{
	int ch;
	size_t length;

	if (buf == NULL || size == 0)
		return 0;

	for (size--, length = 0; length < size; ) {
		if ((ch = fgetc(stdin)) == EOF)
			break;
		/* Map NUL bytes to space, though ideally I should chuck'em. */
		if (ch == '\0')
			ch = ' ';
		/* Discard bare CR and those part of CRLF. */
		if (ch == '\r') {
			xbcount++;
			continue;
		}
		/* Trigraph mapping? */
		if (2 <= length && buf[length-2] == '?' && buf[length-1] == '?') {
			char *tri;
			if ((tri = strchr(trigraph, ch)) != NULL) {
				/* Mapped trigraphs count as 1 byte. */
				ch = asciimap[tri - trigraph];
				xbcount += 2;
				length -= 2;
			}
		}
		if (ch == '\n' && 1 <= length && buf[length-1] == '\\') {
			/* ISO C11 section 5.1.1.2 Translation Phases
			 * point 2 discards backslash newlines.
			 */
			xbcount += 2;
			xwcount++;
			xlcount++;
			length--;
			continue;
		}
		buf[length++] = (char) ch;
		if (ch == '\n') {
			break;
		}
	}

	buf[length] = '\0';

	return length;
}

/*
 * Count octets and strip comments.  The stripped C input is sent to
 * standard output.  If -s is set, then suppress the source output.
 * The various counters are sent to standard error.
 *
 * The counter output format is:
 *
 *	lcount wcount bcount icount isaved rcount rsaved
 *
 * where
 *	lcount	line count (same as wc)
 *	wcount	word count (same as wc)
 *	bcount	byte count (same as wc)
 *	icount	IOCCC secondary size rule count
 *
 * No longer reported:
 *	isaved	bytes saved by secondary size rule (bcount - icount)
 *	rcount	number of C reserved words
 *	rsaved	number of octets saved with -r
 */
static int
count(int flags)
{
	Word *w;
	unsigned long span;
	char *p, buf[BUFFER_SIZE];
	int lcount, wcount, bcount;
	int is_comment, is_word, dquote, escape;
	int count, keywords, saved, kw_saved;

	/* Start of buffer sentinel. */
	buf[0] = ' ';
	buf[BUFFER_SIZE - 1] = 0;     /* paranoia */

	count = saved = 0;
	keywords = kw_saved = 0;
	lcount = wcount = bcount = 0;
	is_comment = is_word = dquote = escape = 0;

	/*
	 * "no matter how well you may think you understand this code,
	 *  you don't, so don't mess with it." :-)
	 */
	while (0 < read_line(buf+1, sizeof (buf)-1)) {
		if (!(flags & FLAG_KEEP)) {
			/* Leading whitespace before comment block? */
			span = strspn(buf+1, "\t ");

			/* Split / * across reads? */
			if (buf[1 + span] == '/' && buf[2 + span] == '\0') {
				(void) ungetc('/', stdin);
				continue;
			}

			/*
			 * no comment is a comment
			 */
			if (buf[1 + span] == '/' && buf[2 + span] == '/') {
				continue;
			}

			if (buf[1 + span] == '/' && buf[2 + span] == '*') {
				/* Strip leading whitespace before comment block. */
				is_comment = 1;
			}
		}

		for (p = buf+1; *p != '\0'; p++) {
			/* Within quoted string? */
			if (dquote) {
				/* Escape _this_ character. */
				if (escape) {
					escape = 0;
				}

				/* Escape next character. */
				else if (*p == '\\') {
					escape = 1;
				}

				/* Close quoted string? */
				else if (*p == '"') {
					dquote = 0;
				}
			}

			/* Not quote string. */
			else {
				/* In C comment block? */
				if (is_comment) {
					/* Split * / across reads? */
					if (*p == '*' && p[1] == '\0') {
						ungetc('*', stdin);
						break;
					}

					/* End of comment block? */
					if (*p == '*' && p[1] == '/') {
						is_comment = 0;

						if (!(flags & FLAG_KEEP)) {
							/* Strip whitespace and newline
							 * trailing closing comment.
							 */
							p += 1 + strspn(p+2, " \t\r\n");
						}
					}

					if (!(flags & FLAG_KEEP)) {
						/* Strip octets in comment block. */
						continue;
					}
				}

				/* Split / / or / * across reads? */
				else if (*p == '/' && p[1] == '\0') {
					ungetc('/', stdin);
					break;
				}

				/* Start of comment line? */
				else if (*p == '/' && p[1] == '/') {
					if (!(flags & FLAG_KEEP)) {
						/* Strip comment to end of buffer. */
						break;
					}
				}

				/* Start of comment block? */
				else if (*p == '/' && p[1] == '*') {
					/* Begin comment block. */
					is_comment = 1;

					if (!(flags & FLAG_KEEP)) {
						/* Strip comment block. */
						p++;
						continue;
					}
				}

				/* C reserved word? */
				else if (!isalnum(p[-1]) && p[-1] != '_'
				&& (w = find_member(cwords, p)) != NULL) {
					keywords++;
					if (flags & FLAG_RESERVED) {
						bcount += w->length;
						if (!is_word) {
							is_word = 1;
							wcount++;
						}

						if (!(flags & FLAG_SILENCE)) {
							fputs(w->word, stdout);
						}

						/* Count reserved word as one. */
						kw_saved += w->length - 1;
						p += w->length - 1;
						count++;
						continue;
					}
				}

				/* Open quoted string? */
				else if (*p == '"') {
					dquote = 1;
				}
			}

			if (!(flags & FLAG_SILENCE)) {
				fputc(*p, stdout);
			}

			bcount++;
			if (*p == '\n') {
				lcount++;
			}

			/* Ignore all whitespace.
			 *
			 * Well not ALL in the Universe, just all here.
			 */
			if (isspace(*p)) {
				is_word = 0;
				saved++;
				continue;
			} else if (!is_word) {
				is_word = 1;
				wcount++;
			}

			/* Ignore curly braces and semicolons when followed
			 * by any whitespace or EOF.
			 */
			if (strchr("{;}", *p) != NULL && (isspace(p[1]) || p[1] == '\0')) {
				saved++;
				continue;
			}

			/* Count this octet. */
			count++;
		}
	}

	if (flags & FLAG_IOCCC) {
		/* Output the official IOCCC size tool size to standard out */
		printf("%d\n", count);
		if (MAX_SIZE < bcount) {
			fprintf(stderr, "WARNING: program size (%d) exceeds IOCCC Rule 2a max. size (%d)\n", bcount, MAX_SIZE);
		}
		if (MAX_COUNT < count) {
			fprintf(stderr, "WARNING: iocccsize count (%d) exceeds IOCCC Rule 2b max. count (%d)\n", count, MAX_COUNT);
		}
	} else {
		/* The Ugly Truth */
		fprintf(
			stderr, "%d %d %d %d %d %d %d\n",
			lcount + xlcount, wcount + xwcount, bcount + xbcount, count,
			saved, keywords, kw_saved
		);
	}

	return count;
}

int
main(int argc, char **argv)
{
	int ch;
	int flags = 0;

	while ((ch = getopt(argc, argv, "kirsch")) != -1) {
		switch (ch) {
		case 'k':
			flags |= FLAG_KEEP;
			break;
		case 'i':
			flags |= FLAG_IOCCC | FLAG_RESERVED | FLAG_SILENCE;
			break;
		case 'r':
			flags |= FLAG_RESERVED;
			break;
		case 's':
			flags |= FLAG_SILENCE;
			break;
		case 'c':
			flags |= FLAG_SILLY_C;
			break;
		case 'h':
			flags |= FLAG_SILLY_H;
			break;
		default:
			fprintf(stderr, "%s\n", usage);
			return 2;
		}
	}
	// make test hack: while for do until goto if else switch case default continue return break
	if (flags == (FLAG_KEEP | FLAG_IOCCC | FLAG_RESERVED | FLAG_SILENCE | FLAG_SILLY_C | FLAG_SILLY_H)) {
		fprintf(stderr, "The source toasts you a glass to your health!\n"
				"BTW: judges have toasted a glass of this at the South Pole.\n"
				"Now try using useful flags.\n\n"
				"%s\n", usage);
		return 3;
	} else if (flags & FLAG_SILLY_C) {
		fprintf(stderr, "Do you not see this is C?\n\n"
				"%s\n", usage);
		return 4;
	} else if (flags & FLAG_SILLY_H) {
		fprintf(stderr, "%s\n", usage);
		return 5;
	}

	/*
	 * count as directed - 1 Muha .. 2 Muhaha .. 3 Muhahaha ...
	 */
	(void) count(flags);

	/*
	 * All Done!!! All Done!!! -- Jessica Noll, age 2
	 */
	return 0;
}
