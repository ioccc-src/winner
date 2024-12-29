/*
 *	am.c		Anthony's Make
 *
 *	Public Domain 1992 by Anthony Howe.  All rights released.
 *
 *
 *	SYNOPSIS
 *
 *	am <makefile> [target]
 *
 *
 *	REFERENCES
 *
 *	[Mil87]	Webb Miller, "A Software Tools Sampler", Prentic Hall, 87
 *		ISBN 0-13-822305-X, chaper 2
 *
 *	[POSIX]	POSIX.2 draft 11.2 MAKE
 */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifndef RULES
#define RULES	500
#endif

#define next(p, i)	(p += i, p += strspn(p, white), i = strcspn(p, white))

char *buf, line[BUFSIZ]; 
char *tar[RULES], *dep[RULES], *cmd[RULES], white[] = "\n\t ";

time_t mtime();
int target();
void update();

/*
 *	Return the modification time for file.
 *	If file does not exist then return zero.
 */
time_t
mtime(f)
char *f;
{
	int j, x;
	size_t i = 0;
	struct stat s;
	next(f, i);
	x = f[i];
	f[i] = '\0'; 
	j = stat(f, &s);
	f[i] = x;
	return (j < 0 ? 0 : s.st_mtime);
}

/*
 *	Find first occurence of target f.  All subsequent occurences
 *	are ignored.  Return the rule number, zero (0) is the empty
 *	rule and indicates no target found.
 */
int
target(f)
char *f;
{
	char *q;
	size_t i = 0, j, k = 1;
	next(f, i);
	while ((q = tar[k]) != NULL) {
		j = 0;
		while (next(q, j) != 0) {
			if (i == j && strncmp(f, q, i) == 0)
				return (k);
		}
		++k;
	}
	return (0);
}

/*
 *	Try to update a file's dependencies, then the file itself.
 *	If the file does not exist, has no dependencies, and no 
 *	known commands, then exit with an error.
 */
void
update(f)
char *f;
{
	time_t t = mtime(f);
	size_t i = 0, j = t == 0, k = target(f);
	char *p = dep[k], *q = cmd[k];
	if (next(p, i) == 0 && q != NULL && *q != '\t' && j) {
		fprintf(stderr, "am: Don't know how to make '%s'.\n", f);
		exit(1);
	}
	/* Try and update all out-of-date dependencies first. */
	while (0 < i) {
		update(p);
		if (t < mtime(p))
			j = 1;
		next(p, i);
	}
	if (j && q != NULL && *q == '\t') {
		/* Some systems do not record a file's modification times
		 * with enough precision.  This sleep() guarantees that
		 * each file has a unique modification time.
		 */
		sleep(1);
		while (*q++ == '\t') {
			i = j = 1;
			while (0 < strspn(q, "-+@")) {
				if (*q == '@')
					/* Be silent. */
					i = 0;
				if (*q++ == '-')
					/* Ignore errors. */
					j = 0;
			}
			if (i)
				puts(q);
			if (system(q) != 0 && j) {
				fprintf(stderr, "am: Error making '%s'\n", f);
				exit(1);
			}
			q += strlen(q) + 1;
		}
		cmd[k] = NULL;
	}
}

int
main(argc, argv)
int argc;
char **argv;
{
	FILE *f;
	struct stat s;
	size_t i, j, k;
	char *m, *n, *p, *q, *r;
	if (argc < 2) {
		fprintf(stderr, "usage:  am <makefile> [target]\n");
		return (2);
	}
	if (stat(*++argv, &s) != 0 || (f = fopen(*argv, "r")) == NULL)
		return (3);
	/* Allocate room for expanded target rules. */
	q = buf = malloc(2*s.st_size);
	if (buf == NULL)
		return (4);
	/* Facts:
	 *
	 *  o	When a C program starts, all uninitialized data will be
	 *	zero or NULL.
	 *
	 *  o	line[] contains the current makefile line and r points 
	 *	into line[].  line <= r < line + BUFSIZ
	 *
	 *  o	p points to the start of text copied from line[].
	 *	q points to the next free storage location.
	 *  	buf <= p <= q <= buf + s.st_size; 
	 *
	 *  o	m points to start of a temporarily stored macro definition.
	 *
	 *  o	i is the number of rules stored.  0 < i < RULES
	 *
	 *  o	When a C program terminates, all open files are closed and
	 *	any allocated memory is freed.
	 */
	i = 1;
	k = 0;
	m = NULL;
	/* The empty rule. */
	*tar = *dep = *cmd = "";
	while ((r = fgets(line, BUFSIZ, f)) != NULL) {
		if (RULES <= i) {
			fprintf(stderr, 
				"am: Number of target-rules exceeds %d.\n", 
				RULES
			);
			return (1);
		}
		if (k) {
			*q++ = ' ';
			r += strspn(r, white);
		} else {
			/* If a target list was saved and we've terminated
			 * the dependency list, then line[] may be the first
			 * command in the target recipe.
			 */
			if (tar[i] != NULL)
				cmd[i++] = q;
			if (m != NULL && putenv(m))
				fprintf(stderr, 
					"am: No more environment space.\n");
			m = NULL;
			/* Skip comment or blank lines. */
			if (*line == '#' || *line == '\n')
				continue;
			p = q;
		}
		while (!(k = *r == '\\' && r[1] == '\n') && *r != '\0') {
			if (*r == '$') {
				if (r[1] == '(') {
					n = r+2;
					r += strcspn(r, ")");
					*r++ = '\0';
					n = getenv(n);
					if (n != NULL) 
						q = strcpy(q, n) + strlen(n);
					continue;
				}
				if (*r == r[1])
					++r;
			} 
			if (*r == '=' && *line != '\t' && m == NULL) {
				*q = '\0';
				m = p;
				j = 0;
				q = next(m, j) + m;
				*q++ = *r;
				j = 1;
				if (next(r, j) == 0)
					*q++ = '\0';
				continue;
			}
			if (*r == ':') {
				tar[i] = p;
				*r = '\0';
				dep[i] = q+1;
			}
			if (*r == '\n')
				*r = '\0';
			*q++ = *r++;
		}
	}
	fclose(f);
	update(2 < argc ? *++argv : tar[1]);
	return (0);
}

