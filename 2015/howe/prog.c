#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
typedef struct e {
	int op;				int x;				int y;				long a;				long b;				struct e *n;
} E;
typedef struct {
	int y;
	E *e;
} X;
typedef struct {
	long q;
	unsigned long long y;
} h;
typedef struct {
	unsigned long z;
	unsigned long j;
	h b[1];
} H;
int I;
int P;
H *A, *B;
FILE *f, *g;
X *Q, *q;
H *
N(H *O)
{
	unsigned long z;
	H *Y;
	z = O ? O->z << 1 : 65536;
	if (!(Y = realloc(O, sizeof (*O) + z * sizeof (O->b))))
		err(2, 0);
	Y->z = z;
	if (!O)
		Y->j = 0;
	return Y;
}
H *
F(FILE *Q)
{
	unsigned long long h;
	H *y;
	long L, o, n;
	unsigned char buf[65536], *b;
	y = N(0);
	L = 1;
	o = 0;
	h = 14695981039346656037ULL;
	y->b[L].q = o;
	while (0 < (n = fread(buf, 1, sizeof (buf), Q))) {
		b = buf;
		while (0 < n--) {
			h ^= *b;
			h += (h<<1) + (h<<4) + (h<<5) + (h<<7) + (h<<8) + (h<<40);
			o++;
			if (*b++ == '\n') {
				y->b[L++].y = h;
				if (y->z <= L)
					y = N(y);
				y->b[L].q = o;
				h = 14695981039346656037ULL;
			}
		}
	}
	y->j = L-1;
	rewind(Q);
	return y;
}
FILE *
O(char *u)
{
	int i;
	FILE *Q;
	if (!(Q = fopen(u, "r")) && !strcmp("-", u)) {
		if ((Q = tmpfile())) {
			while ((i = getchar()) != EOF)
				fputc(i, Q);
			rewind(Q);
		}
	}
	if (!Q) err(2, "%s", u);
	return Q;
}
void
W(FILE *Q)
{
	int i;
	while ((i = fgetc(Q)) != EOF) {
		putchar(i);						
		if (i == '\n')
			break;
	}
}
E *
R(E *K)
{
	E *a, *b;
	b = 0;
	while (K) {
		a = K->n;
		K->n = b;
		b = K;
		K = a;
	}
	return b;
}
void
D(E *K)
{
	E *a, *b;
	for (K = R(K); K; ) {
		b = K;
		if (K->op) {
			do {
				a = b;
				b = b->n;
			} while (b && b->op && a->y+1 == b->y);
			if (K->y < a->y)
				printf("%da%d,%d\n", K->x, K->y, a->y);
			else
				printf("%da%d\n", K->x, K->y);
			fseek(g, K->b, SEEK_SET);
			for ( ; K != b; K = K->n) {
				printf("> ");
				W(g);
			}
		} else {
			do {
				a = b;
				b = b->n;
			} while (b && !b->op && a->x+1 == b->x);
			if (K->x < a->x)
				printf("%d,%dd%d\n", K->x, a->x, K->y);
			else
				printf("%dd%d\n", K->x, K->y);
			fseek(f, K->a, SEEK_SET);
			for ( ; K != b; K = K->n) {
				printf("< ");
				W(f);
			}
		}
	}	
}
void
K(int k)
{
	X h = Q[k-1];
	X v = Q[k+1];
	int x, y, op;
	E *p;
	if (v.y < h.y+1) {
		op = 1;
		y = h.y+1;
		p = h.e;
	} else {
		op = 0;
		y = v.y;
		p = v.e;
	}
	x = y - k;
	if (0 < y || 0 < x) {
		E *e = malloc(sizeof (*e));	
		e->x = x;
		e->y = y;		
		e->n = p;
		e->op = op ^ I;
		e->a = A->b[x].q;
		e->b = B->b[y].q;
		if (I) {
			long c = e->a;
			e->a = e->b;
			e->b = c;
			e->x = y;
			e->y = x;
		}
		Q[k].e = e;
	}
	while (x < A->j && y < B->j && A->b[x+1].y == B->b[y+1].y) {
		x++;
		y++;
	}
	Q[k].y = y;
}
int
T(void)
{
	int k, p, d;
	if (A->j > B->j) {
		void *t = A;
		A = B;
		B = t;
		I = 1;
	}
	d = B->j - A->j;
	if (!(q = calloc(A->j + B->j + 3, sizeof (*Q))))
		err(2, 0);		
	for (k = 0; k < A->j + B->j + 3; k++)
		q[k].y = -1;
	Q = q + A->j + 1;
	p = -1;
	do {
		p++;
		for (k = -p; k < d; k++) {
			K(k);
		}
		for (k = d + p; d <= k; k--) {
			K(k);
		}
	} while (Q[d].y != B->j);
	if (!P)
		D(Q[d].e);
	free(q);
	return d + 2 * p;
}
int
main(int x, char **y)
{
	int i;
	while ((i = getopt(x, y, "d")) != -1) {
		switch (i) {
		case 'd':
			P = 1;
			break;
		default:
			optind = x;
			break;
		}
	}
	if (x <= optind)
		errx(2, "usage: %s [-d] file1 file2", *y);
	f = O(y[optind]);
	g = O(y[optind+1]);
	if (!(A = F(f)))
		err(2, "%s", y[optind]);
	if (!(B = F(g)))
		err(2, "%s", y[optind+1]);
	i = T();
	if (P) printf("%d\n", i);
	return 0 < i;
}
