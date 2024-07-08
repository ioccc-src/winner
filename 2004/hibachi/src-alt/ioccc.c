/*
 *	ioccc.c		IOCCC 2001 Source Size Rule
 *
 *	Public Domain 1992 by Anthony Howe.  All rights released.
 *
 *
 *	SYNOPSIS
 *
 *		ioccc [-s]
 *
 *	DESCRIPION
 *
 *	Taking input from standard input, apply the IOCCC Source Size
 *	Rule for 2001.  The program's offical length is written to
 *	standard error.  Also filter out C comment blocks sending the
 *	modified source to standard output.
 *
 *	The 2001 Source Size Rule is:
 *
 *	Your entry must be <= 4096 bytes in length.  The number of characters
 *	excluding whitespace (tab, space, newline, formfeed, return), and
 *	excluding any ';', '{' or '}' followed by whitespace or end of file,
 *	must be <= 2048.
 *
 *	The -s option siliences standard output.
 *
 *	NOTE the overall length is not counted since this can be checked
 *	with "ls -l".
 */

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

char usage_err[] = "usage:  ioccc [-s]\n";

int count(int silience);

int
main(int argc, char **argv)
{
	char *ap;
	int silence = 0;
	for (--argc, ++argv; 0 < argc && **argv == '-'; --argc, ++argv) {
		ap = &argv[0][1];
		if (*ap == '-' && ap[1] == '\0') {
			--argc;
			++argv;
			break;
		}
		while (*ap != '\0') {
			switch (*ap++) {
			case 's':
				silence = 1;
				break;
			default:
				fprintf(stderr, usage_err);
				return (2);
			}
			break;
		}
	}
	(void) count(silence);
	return (0);
}

/*
 *	Count chacacters and strip comments.  The stripped input is
 *	sent to standard output.  The count of character is sent to
 *	to standard error.
 *
 *	If silence is true, then do not print anything to standard output.
 */
int
count(int silence)
{
	int i, j, k;
	char *p, buf[256];

	for (i = k = 0; fgets(buf, 256, stdin) != NULL;) {
		for (p = buf; *p != '\0'; ++p) {
			if (k == 1) {
				if (*p == '*' && p[1] == '/') {
					/* End of comment. */
					k = 0;
					++p;
				}
				/* Skip characters in comment block. */
				continue;
			}
			if (*p == '/' && p[1] == '*') {
				/* Begin comment block. */
				k = 1;
				++p;
				continue;
			}
			/* Everything above here is stripped from the input. */
			if (!silence)
				putchar(*p);
			/* Ignore all whitespace. */
			if (isspace(*p))
				continue;
			/* Ignore curly braces and semicolons when followed
			 * by any whitspace or EOF.
			 */
			if (strchr("{;}", *p) != NULL
			&& (isspace(p[1]) || p[1] == '\0'))
				continue;
			/* Count this character. */
			++i;
		}
	}
	fprintf(stderr, "%d\n", i);
	return (i);
}

