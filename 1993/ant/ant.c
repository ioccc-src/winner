#define D ++*p
#define B **p
#define W while
#define R return 
#define E else
#define Q if
#define G fprintf(stderr,


#include <stdio.h>

#ifndef A
#define A	512
#endif

typedef int I;
typedef char C;
typedef void V;

I z;
I f;
I x;
I a[A], b;


I d[A][A];
I m[A], n, o;

I N();
I M();
I P();
I U();
V X();
V T();
V F();
V L();
V O();

I
main(c, p)
I c;
C B;
{
	I i;
	FILE *j;
	C *k, l[BUFSIZ+1];

	Q (--c < 1) {
		G "usage:  ag <pattern> [js...]\n");
		R 2;
	}

	
	N(-3);
	N(-6-b);
	N(0);
	N(-3-b);

	X(&(*++p));

	*l = '\n';
	o = 1;
	i = 1;
	do {
		k = "-";
		j = stdin;
		Q (1 < c && **++p != '-') {
			Q (!(j = fopen(k = *p, "r"))) {
				G 
					"ag: Failed to open '%s'.\n", k);
				i = 3;
				continue;
			}
		}
		W (fgets(l+1, BUFSIZ, j)) {
			Q (M(l)) {
				printf("%s:%s", k, l+1);
				i = 0; 
			}
		}
		fclose(j);
	} W (1 < --c);
	R i;
}


V
X(p)
C B;
{
	I i, j;
	i = N(-3);
	T(p);
	W (B == '|') {
		D;
		j = N(-3);
		N('\n');
		a[i] = -4-b;
		i = N(-3);
		T(p);
		a[j] = -4-b;
	}
}


V
T(p)
C B;
{
	W (B != '|' && (!x || B != ')')  && B)
		F(p);
}


V
F(p)
C B;
{
	I i = N(-3);
	Q (B == '^') {
		D;
		N('\n');
	} E Q (B == '$') {
		D;
		N('\n');
	} E Q (B == '(') { 
		D; 
		++x;
		X(p); 
		Q (B != ')') { 
			G "ag: Missing ')'.\n"); 
			exit(3); 
		}
		--x;
		D;
	} E {
		L(p);
	}
	Q (B == '*') {
		D;
		a[i] = -4-b;
		N(-5-i);
	} E Q (B == '?') {
		D;
		a[i] = -4-b;
	}
}


V
L(p)
C B;
{
	I i, j;
	Q (B == '.') {
		N(0);
	} E Q (B == '[') {
		D;
		i = N(-2);
		Q (B == '^') {
			D;
			a[i] = -1;
		}
		Q (B == ']') {
			D;
			N(']');
		}
		W ((i = B) != ']') {
			Q ((*p)[1] == '-' && i < (j = (*p)[2])) {
				W (i <= j)
					N(i++);
				*p += 3;
			} E {
				N(i);
				D;
			}
		}
		N('\n');
	} E {
		Q (B == '\\')
			D;
		N(B);
	}
	D;
}


I
N(c)
I c;
{
	Q (A <= b) {
		G "ag: Pattern too long.\n");
		exit(3);
	}
	a[b] = c;
	R b++;
}


V
O(p)
I p;
{
	I i = n;
	Q (b <= p)
		R;
	Q (a[p] < -2) {
		Q (a[p] != -3)
			O(-4-a[p]);
		O(p+1);
	} E Q (!a[p] || a[p] == z || P(&p)) {
		
		W (i < o)
			Q (m[i++] == p)
				R;
		
		f = U(p+1);

		Q (A <= o) {
			G "ag: Out of space.\n");
			exit(3);
		}
		
		m[o++] = p;
	}
}


I
P(p)
I *p;
{
	I i = 0, j = 0;
	Q (a[*p] == -2 || (j = a[*p] == -1)) {
		W (a[D] != '\n')
			Q (a[*p] == z)
				i = 1;
	}
	R i ^ j;
}


I
U(p)
I p;
{
	R (
		f || p == b || (
			a[p] < -2 && (
				(a[p] != -3 && U(-4-a[p])) 
				|| U(p+1)
			)
		)
	);
}


I
M(p)
C *p;
{
	I c, i, j, k;
	f = c = 0;
	W (*p && 0 <= c) {
		Q (0 < (i = d[c][*p])) {
			
			c = i;
		} E {
			
			z = *p;
			i = d[c][0];
			j = n = o;
			do 
				O(m[i++]+1);
			W (m[i] != 2);

			
			i = k = 0;
			W (i < n) {
				Q (m[i] == 2) {
					j = n;
					++k;
				}
				Q (m[i++] == m[j]) {
					Q (o <= ++j) {
						j = n;
						Q (m[i] == 2) {
							
							o = n;
							break;
						}
					}
				} E {
					j = n;
				}
			}
			Q (n < o) 
				
				d[++k][0] = n;
			c = d[c][*p] = f ? -1 : k;
		}
		++p;
	}
	R c < 0;
}

