#define W while
#define S strspn 
#define R return 
#define F fprintf(stderr,
#define C continue;

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

#ifndef RULES
#define RULES	500
#endif

#define N(p, i)	(p += i, p += S(p, w), i = strcspn(p, w))

char *b, l[BUFSIZ], *t[RULES], *d[RULES], *c[RULES], w[] = "\n\t ";

time_t M();
int T();
void U();


time_t
M(f)
char *f;
{
	int j, x;
	size_t i = 0;
	struct stat s;
	N(f, i);
	x = f[i];
	f[i] = 0; 
	j = stat(f, &s);
	f[i] = x;
	R j < 0 ? 0 : s.st_mtime;
}

int
T(f)
char *f;
{
	char *q;
	size_t i = 0, j, k = 1;
	N(f, i);
	W ((q = t[k])) {
		j = 0;
		W (N(q, j)) {
			if (i == j && !strncmp(f, q, i))
				R k;
		}
		++k;
	}
	R 0;
}

void
U(f)
char *f;
{
	time_t t = M(f);
	size_t i = 0, j = !t, k = T(f);
	char *p = d[k], *q = c[k];
	if (!N(p, i) && q && *q != '\t' && j) {
		F "am: Don't know how to make '%s'.\n", f);
		exit(1);
	}
	W (0 < i) {
		U(p);
		if (t < M(p))
			j = 1;
		N(p, i);
	}
	if (j && q && *q == '\t') {
		sleep(1);
		W (*q++ == '\t') {
			i = j = 1;
			W (0 < S(q, "-+@")) {
				if (*q == '@')
					
					i = 0;
				if (*q++ == '-')
					
					j = 0;
			}
			if (i)
				puts(q);
			if (system(q) && j) {
				F "am: Error making '%s'\n", f);
				exit(1);
			}
			q += strlen(q) + 1;
		}
		c[k] = 0;
	}
}

int
main(u, v)
int u;
char **v;
{
	FILE *f;
	struct stat s;
	size_t i, j, k;
	char *m, *n, *p, *q, *r;
	if (u < 2) {
		F "usage: am <makefile> [target]\n");
		R 2;
	}
	if (stat(*++v, &s) || !(f = fopen(*v, "r")))
		R 3;
	q = b = malloc(2*s.st_size);
	if (!b)
		R 4;
	i = 1;
	k = 0;
	m = 0;
	*t = *d = *c = "";
	W ((r = fgets(l, BUFSIZ, f))) {
		if (RULES <= i) {
			F "am: Number of target-rules exceeds %d.\n", RULES);
			R 1;
		}
		if (k) {
			*q++ = ' ';
			r += S(r, w);
		} else {
			if (t[i])
				c[i++] = q;
			if (m && putenv(m))
				F "am: No more environment space.\n");
			m = 0;
			if (*l == '#' || *l == '\n')
				C
			p = q;
		}
		W (!(k = *r == '\\' && r[1] == '\n') && *r) {
			if (*r == '$') {
				if (r[1] == '(') {
					n = r+2;
					r += strcspn(r, ")");
					*r++ = 0;
					n = getenv(n);
					if (n) 
						q = strcpy(q, n) + strlen(n);
					C
				}
				if (*r == r[1])
					++r;
			} 
			if (*r == '=' && *l != '\t' && !m) {
				*q = 0;
				m = p;
				j = 0;
				q = N(m, j) + m;
				*q++ = *r;
				j = 1;
				if (!N(r, j))
					*q++ = 0;
				C
			}
			if (*r == ':') {
				t[i] = p;
				*r = 0;
				d[i] = q+1;
			}
			if (*r == '\n')
				*r = 0;
			*q++ = *r++;
		}
	}
	fclose(f);
	U(2 < u ? *++v : t[1]);
	R 0;
}

