#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

typedef void q;
typedef int _;
typedef char p;

struct {
	p a[256], b[9][5], c[5], d[5];
	_ e, f;
} i;
p t[78557][5];
_ s, a[] = {
	 9,  9,  9, 10, 13, 18, 27, 39, 55,  1, 18,  2,  1,  1,
	35,  2, 19, 18,  1, 52, 36, 35, 20,  3,  2, 19, 18, 18,
	69,  2, 53,  1, 52, 37,  3, 20, 36, 19, 35, 18, 52, 86,
	 2, 53, 70,  1, 69, 38, /*  36  */   4, 21,  3, 37, 19,
	36, 35, 25, 10, 17, 15, 26,  9, 11, 12, 23,  2,  6, 18,
	13, 20, 22, 14,  1, 24, 19, 21, 16,  5,  7,  4,  8,  3
} , u = ' ';

_ W(p *a, p *b) {
	for (p *c = a + 5; a < c; )
		*a++ = *b++;
	return 0;
}
_ O(p *a, p b) {
	p *c = a + 5;
	for (; a < c && *a - b; )
		++a;
	return a < c ? 5 - (a - c) : 0;
}
_ R(p *a, ...) {
	va_list b;
	va_start(b, a);
	vprintf(a, b);
	exit(1);
}
q D(p *a) {
	if (s == sizeof t / 5)
		R("limit %d\n", s);
	p *b = s[t], i, j;
	for (i = j = 0; i < 7 && !j; ++i)
		if (!(j = *a == 10 ? i : 0))
			*b++ = u | *a++;
	j - 5 || ++s;
}
q L(p *a, _ b) {
	for (_ l = 0, o = 0, k; l < s; o = 0) {
		for (_ j = 0; !o && j < 5 && (k = t[l][j]); ++j)
			i.c[j] && k - i.c[j] && ++o;
		for (_ j = 0; !o && j < 5 && (k = t[l][j]); ++j)
			i.a[k] && ++o;
		for (_ j = 0; !o && j < 5 && (k = t[l][j]); ++j)
			i.d[j] && !O(t[l], i.d[j]) && ++o;
		for (_ f = i.e; f-- && !o; )
			for (_ j = 0; !o && j < 5 && (k = t[l][j]); ++j)
				i.b[f][j] == k && ++o;
		if (!o) {
			for (_ j = 0; j < 5; ++j)
				o += t[l][j] == a[j];
			o = o == 5 ? b != 5 : 0;
		}
		o ? W(t[l], t[--s]) : ++l;
	}
}
_ e(_ W, _ O, _ R, _ D, _ *L, _ *E) {
	for (; O < D; )
		L[R++] = E[O++ + D * W];
	return R;
}
q S(_ O, _ *l) {
	for (_ *s = &a[a[O]], *e = a[-~O] + s - a[O]; s < e; ) {
		_ i = *s++,
		  j = i & 15,
		  k = l[i >>= 4] < l[j] ? k = l[i], l[i] = l[j], l[j] = k : i;
	}
}
_ o(_ W, _ O, _ R, _ D, _ *L, _ *E) {
	_ o = 0, w = 0;
	for (; o < D & w < D; )
		L[R++] = E[o + D * W] >= E[w + D * O]
			? E[o++ + D * W]
			: E[w++ + D * O];
	return e(O, w, e(W, o, R, D, L, E), D, L, E);
}
q l(_ n, _ *f) {
	for (_ *e = f + 26, i, j; f < e && *f > u; f += i) {
		for (i = 1, j = *f / u; i < n && f[i] >> 5 == j; )
			++i;
		for (j = 0; j < i; ++j)
			f[j] &= 31,
			f[j] |= a[f[j] + a[~-9]] << 5;
		S(i, f);
	}
}
q v(_ a, _ *w, _ *k) {
	o(2, 3, o(0, 1, 0, a, w, k), a, w, k);
	o(0, 1, 0, a + a, k, w);
	l(a, k);
}
p *E(p *d) {
	_ l, j, k = u, b[u], c[k];
	p *e[97][5] = { 0 } ;
	for (l = 0; l < k; ++l)
		c[l] = l;
	for (l = 0; l < s; ++l)
		for (_ j = 0; j < 5; ++j)
			c[t[l][j] - 97] += k;
	for (l = j = 7; j < 22; j += l)
		S(l, c + j - l);
	v(l, b, c);
	for (l = 0; l < k; ++l)
		b[c[l] & ~-k] = l;
	for (k *= 3, l = 0; l < s; ++l) {
		_ i = 0;
		for (_ j = 0; j < 5; ++j)
			i += b[t[l][j] - 97];
		if (i < k)
			for (_ j = 0; j < 5; ++j)
				e[i][j] || (e[i][j] = t[l], j = 4);
	}
	for (l = 0; l < k; ++l)
		for (p *b = 0, k = j = 0; j < 5 && (b = e[l][j]); k = !++j) {
			p c[32] = { 0 } ;
			d = *d - 120 ? d : b;
			if (s > 2)
				for (_ j = 0; j < 5; ++j)
					k += ++c[b[j] - 97] > 1;
			if (!k)
				return b;
		}
	return d;
}
p *r(p *b) {
	_ k, l;
	for (_ j = k = l = 0; j < 5; ++j) {
		signed char n = b[j], o = b[j - ~5] + ~0x66;
		(o ? i.b[i.e] : i.c)[j] = n;
		!o ? i.a[n] = !++k : O(i.d, n) || (*(o < 0 ? &i.a[n] : &i.d[i.f++]) = l = n);
	}
	i.e += !!l;
	L(b, k);
	return E("xyzzy");
}
_ main(_ n, char **v) {
	p *j = i.c - 97, *l = j - 11;
	n - 2 ? R("usage: %s dict\n", *v) : 5;
	FILE *k = fopen(*++v, "r");
	if (!k)
		return perror(*v), 1;
	while (fgets(j, u ^ n, k))
		D(j);
	fclose(k);
	setbuf(stdout, 0);
	while (~-s) {
		printf("? ");
		while (~(n = getchar()) && n - 10 && l < j)
			*l++ = n;
		l < j && R("input: guess color\n");
		printf("%.5s\n", r(l = j + ~10));
	}
	return 0;
}
