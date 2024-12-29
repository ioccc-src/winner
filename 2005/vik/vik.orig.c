#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<X11/Xlib.h>
#include<X11/keysym.h>
Window L;
GC N;
Display *K;
XEvent O;
XImage *Q;
float w, x, y[7 << 16];
struct timeval S, U;
int a, b, c, d =
  92, e, f, g, h, i, j, k, l, m, n, o, p, *q[96], r[7 << 16], s[96], *t,
  *u = r, *v, P = 256, R[64], T, J = 12288;
struct
{
  int a, b, c, d, e;
} A[9999], *B, *G, *H;
unsigned char C, D[9999], *E = D, F[] = " .bmp";
FILE *I;

#define Q(o,X,Y,C)B->b=b+32*o,B->c=c+32*X,B->d=Y,B->e=C,B++->a=l,
#define D(o,X)(int)((X*(B->b-e)-o*(B->c-f))/(x*B->e-w*B->d))

int
main (int X, char **Y)
{
  for (j = J << 8, x = y[i], w = y[i + 32], B = A; k = D (x, w), B->b;
       k >> 8 ? 0 : (l = D (B->d, B->e), l > 0
		     && l < j) ? j = l, h = k, g = B->a : 0, B++);
  for (;
       X
       && (p =
	   1 | 3 * (o = (--X < 2 || 119 - 1[Y[1]] ? 320 : atoi (2[Y]))) / 4);)
    {
      for (e = f = J / 2, K = XOpenDisplay (0); m < o << 8;
	   y[m] =
	   sin ((m & 255) / 20.4 + asin ((m / P - o / 2) / 3.2 / o)),
	   D[m & 511] = 10 + d * !(1 & (m >> 3 & m)), r[m++] =
	   m / 18 << (16 & (m >> 6 ^ m)));
      for (N =
	   XCreateGC (K, L =
		      XCreateSimpleWindow (K, RootWindow (K, 0), 0, 0, o, p,
					   0, 0, 0), 0, 0), ((I =
							      fopen (X ?
								     Y[X]
								     : "",
								     "r")) ?
							     fread (E + 1,
								    1,
								    1 << 15,
								    I),
							     fclose (I) :
							     0), B = G =
	   A + J / 3; *++E; f = l == 32 ? e = b + 99, c + 99 : f)
	for (l = *E - 10, *F = *E, k = !l, b *= !k, c += P * k, b += P;
	     l > 54 && l < 96
	     && (Q (0, 0, 1, 0) Q (8, 0, 0, 1) Q (8, 8, -1, 0)
		 Q (0, 8, 0, -1)
		 ! q[l] && (s[l] = 1, q[l] = u, I = fopen (F, "r"))); l = J)
	  for (q[l] = ++u + 19, m = 2;
	       n = (m++ % 3 ? n : 0 ** ++u) >> 8 | C << 16, *u =
	       n, 0 < fread (&C, 1, 1, I)
	       || (m /= J, s[l] = m ? m : 1) * fclose (I););
      for (XMapWindow (K, L),
	   XSelectInput (K, L, KeyPressMask | KeyReleaseMask), H = A; G->b;
	   *H = *G++, H += !B->b)
	for (B = A + J / 3;
	     B->b && !(B != G && B->b == G->b - 128 * (B->d - G->d)
		       && B->c == G->c - 128 * (B->e - G->e)); B++);
      for (Q =
	   XCreateImage (K, DefaultVisual (K, 0), DefaultDepth (K, 0),
			 ZPixmap, 0, (char *) (v =
					       malloc (4 * o * p)), o, p,
			 32, 0);
	   d = (d + R[19] - R[17]) & 127, n = R[18] - R[20], n ? (i =
								  o * 128 +
								  d + (n <
								       0) *
								  64, main (0,
									    Y)
								  >
								  200) ? e +=
	   (int) (y[i] * 64), f += (int) (y[i + 32] * 64) : 1 : 1;
	   XSync (K, 0), gettimeofday (&S, 0), m = T - S.tv_usec)
	{
	  for (T -=
	       (m > 0
		&& m < J * 4 ? U.tv_usec =
		m, select (0, 0, 0, 0, &U) : m) - 4 * J, a =
	       a + 1 & -1 >> 1, m = 0;
	       k =
	       1 +
	       (int) (p * 512 /
		      ((i = m * P + d, g = n =
			0, main (0, Y)) * y[m * P + 32])), m < o; m++)
	    for (t = g ? c =
		 64 * s[g], q[g] + h / 4 + 64 * (a / 3 % s[g]) : t;
		 l = 32 - (17 << (k < 2)) * (2 * n - p) / k, n < p;
		 v[m + o * n++] = l >> 6 ? 4477904 << (l < 0) : t[c * l]);
	  for (XPutImage (K, L, N, Q, 0, 0, 0, 0, o, p); XPending (K);
	       R[63 & XLookupKeysym (&O.xkey, 0 & XNextEvent (K, &O))] ^=
	       O.type == KeyPress || O.type == KeyRelease);
	}
    }
  return j;
}
