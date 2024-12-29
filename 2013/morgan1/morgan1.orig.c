
#include <stdio.h>
#include <math.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>

int main()
{
	Display *D;
	Window W;
	GC G;
	double l, r, a, b, o[7];
	int j, y, m, d;
	XWindowAttributes A;
	XEvent V;

	char n[444] =
		"NfVS6>7TYBC>Rm=8K\\QWiAR98iBX13>\\X[oN;W"
		"fXLULQJ^dS[PiLhDX`;<iNbR<4Xk5E7ZEY>GF"
		"bZ000=N4R6:9?TDoQH2aiN6MK[Zh[doSKGi;N"
		"bZQQ84ROVaYP2<BVVFM1eL:k<<[B?`TX_3gCK"
		"v^C?E_PSI\\XNLeQ:VIX=<FO2Wb[P5CPZ`1cFT"
		"b`<E?ePa[TlPI9jjYOUHBD<Rb`WLe_bZnknBV"
		"sb<`7fPOm\\GL^Q=8\\?;KP@[FJPZ]oVNZBWNfO"
		"fbhAc8L9F[NNnROJ^7jdX>]MZI[O41c\\9VWNI"
		"bb7aRCXkd7b\\JW6:Z9O@6@fZ;5ZllOgZ0mFjI"
		"chMPc<XoGl>ZSi2FJ^_fG6`eS7_043Q^>hG`T"
		"v00000&15e0&13e0&13e\1&e0&e0&e\1&\\TQneTv00000", *c = n;

	for (j = DefaultScreen((D = XOpenDisplay(0))),
		G = XCreateGC(D, W = RootWindow(D, j), 0, 0); (*c++)--; );
	XMapWindow(D, W = XCreateSimpleWindow(D, W, 0, 0, 400, 400, 0,
		BlackPixel(D, j), WhitePixel(D, j)));
	XSelectInput(D, W, KeyPressMask|ExposureMask);
	j = scanf(n + 392, &y, &m, &d);
	j > m++ ? y--, m += 12 : j--;
	for (j = (int)(365.25 * y) + (int)(30.6001 * m) + d - 730550 +
		(1582 > y || y == 0x62e && (11 > m || 11 == m && d < 5) ?
			0 : 2 - y / 'd' + y / 400);
		XGetWindowAttributes(D, W, &A) && XClearWindow(D, W),
		b = floor((y = j + 0x8ead + (-152385 < j ?
			(a = floor(j / 36524.25 + 1.9983778) + 14,
			1 + a - floor(a / 4)) : d)) / 365.25 + .802601),
		m = floor((l = y - floor(365.25 * b + .750001) + 416) / 30.6001),
		d = l - floor(30.6001 * m),
		y = b + 0x76c, 13 < m-- ? m -= 12 : y--,
		!XDrawString(D, W, G, 0, 10, n + 0x1a0,
			sprintf(n + 416, n + 377, y, m, d));
		XNextEvent(D, &V) || (j += -(V.type == KeyPress) &
			((y = XLookupKeysym(&V.xkey, d = 0)) == XK_Left ? -1 :
			y == XK_Right ? 1 :
			y == XK_Up ? 20 :
			y == XK_Down ? -20 : d)))
		for (m = !m; m++ ^ 12;
			!(m == 9 && 150 < fabs(j + 0x13d2) ||
					m == 10 && fabs(j + 1005) > 0x96) &&
			XDrawArc(D, W, G, d += r * cos(l) - 4,
				y -= r * sin(l) + 4, 8, 8, 0, 63 * 365 + 45) &&
			XDrawString(D, W, G, d + 7, ++y, c - ' ', 2)) {
			for (d = !m; 7 > d; d++[o] = (r + !!r) *
				exp2((*c - 0x2f >> 1) - 21) * (2 * (*c & 1) - 1))
				for (r = 0, c = n + 37 * m + (y = 5) * d - 31;
					--y; r = (r - 47 + *c--) / 64);
			b = o[3] + o[4] * j;
			for (l = b + (a = o[1]) * sin(b); 1e-6 < fabs(r);
				l += r = (b - l + a * sin(l)) / (1 - a * cos(l)));
			r = log1p(*o * (1 - a * a) / (1 + a * cos(
				l = 2 * atan(sqrt((1 + a) / (1 - a)) * tan(l / 2)))));
			r *= fmin(d = A.width / 2, y = A.height / 2) *
				cos(asin(sin(l += o[5]) * sin(o[2]))) / log(32);
			l = atan2(sin(l) * cos(o[2]), cos(l)) + o[6];
		}
	return 0;
}
