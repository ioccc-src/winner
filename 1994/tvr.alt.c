#include <X11/Xlib.h>
#define M     typedef
#define N(	 a)=r=(a)+j
#define S f(; G; )D[B[H=i[--G]]=F+=F<p]++
#define	f for
#define g [H]
#define Z f(H=0; H<j; H++)
#define X H < j && h g<j*4
#define E h g + j*(T+a g>V)*2
#define o b F; b G = 0; c H = 0; c R

M int b;
M unsigned c;
M unsigned char *d;
M XPoint *e;
M void _;
short *a;
b *h, *i, j, k, l, m, n, p, V;
c T;
b O;
d A, B, C;
_ *q, *r, *calloc ();
e s, t;
Window u, v;
GC x[256];
b D[256];
b w, y, z;
_
Q (b F)
{
  XMapWindow (q, v = XCreateSimpleWindow (q, XRootWindow (q, z = XDefaultScreen (q)), !v * n, 0, n, n, 0, 0, 0));
  XSelectInput (q, v, F);
}
_
P ()
{
  C N (h N (i N (a N (s N (t N (A N (B = calloc (C - B + 256, 1))))))));
}
_
J ()
{
  o;
  R = w % 5;
  F = G = m;
  V = n * !R - 1;
  Z
  {
    h g = l + (R - 4 ? R - 2 ? R - 3 ? (a g = 2 * (F * F - G * G) / m) + 4 * F * G / m * n + (F * F > j / 4 - G * G) * j * !R * 8 : G + F * n : (G * G - F * F) / m * n + 2 * F * G / m : (G - F * F / n) + F * n);
    (s g.x = m - F--, s + H)->y = m - G;
    F = F + m ? F : (G--, m);
  }
}
_
K ()
{
  b H;
  c R;
  Z D[B g = X ? (R = E) < j ? (A[R] < p) + A[R] : 1 : 0]++;
}
_
I (d F)
{
  F || gets (F = B);
  y = atoi (F);
}
_
Y ()
{
  o;
  K ();
  f (H = k + l;
     X && (F = B g) < p;
     H = E)
  {
    D[F]--;
    B[i[G++] = H] = p;
  }
  if (H >= j)
    F = 1;
  S;
}
_
L ()
{
  o;
  Z B g = 0;
  O = -1;
  Z
  {
    f (;
       X && !(F = B g);
       H = E) B[i[G++] = H] = p;
    S;
  }
}
_
U ()
{
  o;
  e L[256], W = t;
  f (H = 0;
     H < y;
     H++)
  {
    L g = W;
    W += D g;
  }
  Z if (A g - B g)
     *L[B g]++ = s g;
  {
    XMotionEvent *R = r = t;
    W = t;
    f (H = 0;
       H < y;
       H++)
    {
      XDrawPoints (q, v, x g, W, L g - W, CoordModeOrigin);
      W += D g;
      D g = 0;
    }
    f (F = k;
       XPending (q) + !++O;
       R->type - ButtonPress ? (k = (T = R->x) + R->y * n - l) : (O = -42)) XNextEvent (q, r = R);
    Z h g += k - F;
  }
}
_
main (b i, d * W)
{
  o;
  if (i > 2)
    {
      P ();
      I (*++W);
      w = y;
      I (*++W);
      n = y * 2;
      j = n * n;
      P ();
      m = y;
      l = j / 2 + m;
      q = XOpenDisplay (0);
      Q (0);
      u = v;
      Q (PointerMotionMask | ButtonPressMask);
      I (0);
      p = y;
      {
	XColor F;
	Colormap G;
	f (H = 0;
	   H < p;
	   H++)
	{
	  I (0);
	  XParseColor (q, G = XDefaultColormap (q, z), r = B, &F);
	  XAllocColor (q, G, &F);
	  XSetForeground (q, x g = XCreateGC (q, u, 0, 0), F.pixel);
	}
      }
      y = p--;
      P ();
      J ();
      f (F = R = H = 0;
	 R < j;
	)++ F < p && X ? (T = R % n, H = G + E) : (D[B[R] = F]++, H = l, G = ++R - H, F = 0);
      T = m;
      G = j;
      U ();
      v = u;
      f (F = w / 5; ;
	 A += G -= G + G, B -= G) (O < 0 ? L : *("tvr@cs.hut.fi." + 7 * F) ? F ^ 1 ? Y : K : L) (), (U) ();
    }
  puts ("tvr: mode size < cmap");
}
