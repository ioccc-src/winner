/**
 * \file prog.c
 *
 * \brief Renders an HTML chart from JSON data
 *
 * \author Qiming HOU
 *
 *  Copyright (C) 2017-2018, Qiming HOU
 *
 *  Licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported
 *  (CC BY-SA 3.0), you may not use this file except in compliance with the
 *  License. You may obtain a copy of the License at
 *
 *  http://creativecommons.org/licenses/by-sa/3.0/
 *
 *  This file is an IOCCC submission.
 *
 *  This thing wouldn't be possible without the advent of C / HTML standards.
 *  We all love the new math functions in C99 and the inclusion of SVG in
 *  HTML5.
 *
 *  Changelog:
 *    2018-04-16 fixed the rounding bug
 */
#include <math.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

/* Macros are named after fashionable jargon */

#define J ceil(log(erfc(1)))
#define S calloc(3, 1)
#define O strcat(strcat(S, m(37)), m(102))
#define N I(T(6))
#define _(X) mmap(fopen(S, S), 64, 3, 1,  X, 0)
#define H(X) dup2(fileno(tmpfile()), X); m(ftruncate(X, 64))
#define T(X) getenv(L(r(1, X, 64)))
#define M(X, Y) memcmp(T(X), L(Y), 1)
#define L(X) memset(S, X, 1)

#define m(X) memset(S, X, N)
#define o(X) r(copysign(1, X), exp2(J), exp2(J))
#define b(X) o(r(abs(X), J, 0))
#define i(X) setenv(L(70), L(r(1, X, 48)), 1)
#define l(X, Y) setenv(m(r(1, X, 64)), L(Y), 1)
#define e(X) setenv(m(r(1, X, 64)), \
	strcat(strcpy(malloc(r(p(T(X)), 1, 2)), T(X)), T(4)), 1)

#define W(X) printf(O, fabs(X))
#define E(X) putchar(r(N, X, 32))
#define B(X, Y) sprintf(_(r(N, X, 3)), O, Y)

#define j(X) t; E(55); E(41); E(36); E(52); E(40); E(29); W(X); t; E(40); \
	E(37); E(41); E(39); E(40); E(52); E(29); W(X)
#define a(X) l(8, 0); i(o(M(8, X)))
#define v t; E(16); t
#define A E(52); E(37); E(56); E(52)
#define s W(r(200, sin(I(_(4))), 250)); t; W(r(200, cos(I(_(4))), 250))
#define c E(38); E(41); E(44); E(44); E(29); E(50); E(39); E(34); E(8); \
	W(r(cos(p(T(2))), 48, 48)); E(5); E(12); E(16); E(5); E(12); \
	W(r(sin(p(T(2))), 48, 48)); E(5); E(9); t; E(15); E(30); e(2)
#define r fma
#define I atof
#define p strlen
#define t E(0)

#define rulez o(r(J, exp2(N), p(T(1))))

/**
 * @brief Renders the chart from JSON input
 *
 * Expected input format:
 *   [ {"foo": string, "bar": number}, ... ]
 *
 * @return nothing
 */
int C(){
	i(1);
	l(4, getchar());
	l(8, r(
		I(T(5)), 4,
		r(N, o(M(4, 33)), r(N, b(M(4, 44)), r(b(M(4, 34)), 2, 1)))
	));
	i(0);
	a(13);
	E(28);
	E(48);
	E(33);
	E(52);
	E(40);
	t;
	E(36);
	E(29);
	E(7);
	E(45);
	W(250);
	t;
	W(250);
	E(44);
	s;
	B(1, r(
		exp2(r(J, log2(I(_(5))), log2(I(T(1))))), 
		r(2, acos(J), 0), 
		I(_(4))
	));
	E(33);
	W(200);
	t;
	W(200);
	v;
	E(r(1, o(r(2, I(T(1)), r(J, I(_(5)), 0))), 16));
	v;
	s;
	E(58);
	E(7);
	c;
	setenv(m(65), strchr(T(1), r(1, I(T(7)), 9)), 1);
	l(7, r(J, I(T(7)), 49));
	fflush(fopen(S, S));
	assert(rulez);
	a(12);
	l(5, 48);
	E(28);
	E(15);
	A;
	E(30);
	a(9);
	m(write(1, T(4), N));
	a(8);
	l(5, 50);
	E(28);
	E(50);
	E(37);
	E(35);
	E(52);
	j(16);
	t;
	E(56);
	E(29);
	W(472);
	t;
	E(57);
	E(29);
	W(r(p(T(2)), 28, 0));
	t;
	c;
	E(28);
	A;
	t;
	E(56);
	E(29);
	W(500);
	t;
	E(57);
	E(29);
	W(r(p(T(2)), 28, r(J, 16, 0)));
	E(30);
	a(7);
	l(5, 48);
	l(4, r(1, I(T(7)), 9));
	e(1);
	l(7, r(J, I(T(7)), 49));
	B(2, r(1, I(_(5)), I(strrchr(T(r(N, J, 2)), r(N, I(T(7)), 9)))));
	a(6);
	e(1);
	a(1);
	i(r(N, b(M(4, 58)), 0));
	l(5, 49);
	a(1);
	i(r(N, b(M(4, J)), 0));
	l(7, 9);
	l(5, 51);
	l(2, 9);
	return C();
}

int main(){
	i(1);
	E(28);
	E(51);
	E(54);
	E(39);
	j(r(2, 250, 250));
	E(30);
	l(1, 10);
	l(2, 9);
	l(8, 9);
	l(4, 9);
	l(5, 9);
	l(7, 9);
	H(3);
	H(4);
	H(5);
	return C();
}
