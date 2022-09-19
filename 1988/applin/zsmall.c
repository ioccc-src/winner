#ifdef a
#undef a
#ifdef b
#undef b
#ifdef c
#undef c
#ifdef e
#undef e
#ifdef f
#undef f
#ifdef g
#undef g
#ifdef h
#undef h
#ifdef i
#undef i
#ifdef j
#undef j
#ifdef k
#undef k
#else
#define k
#endif
#else
#define j
#endif
#else
#define i
#endif
#else
#define h
#endif
#else
#define g
#endif
#else
#define f
#endif
#else
#define e
#endif
#else
#define c
#endif
#else
#define b
#endif
#else
#define a
#endif
#ifdef k
#define p (1<<7)
#else
#define p 0
#endif
#ifdef j
#define q (1<<6)
#else
#define q 0
#endif
#ifdef i
#define r (1<<5)
#else
#define r 0
#endif
#ifdef h
#define s (1<<4)
#else
#define s 0
#endif
#ifdef g
#define t (1<<3)
#else
#define t 0
#endif
#ifdef f
#define u (1<<2)
#else
#define u 0
#endif
#ifdef e
#define v (1<<1)
#else
#define v 0
#endif
#define vv (p+q+r+s+t+u+v+1)
#define ff \
 (defined(c)*8+defined(b)*4+defined(a)*2+1)
#if vv==1
#undef vv
#define vv 2
#endif
#if ff<vv 
#if ff!=1
#if (vv/ff)*ff==vv 
#ifndef dd
#define dd
#endif
#endif
#endif
#endif
#if ff==15
#ifdef dd
#undef dd
#else
printf("%d\n", vv);
#endif
#endif
#undef ff
#undef vv
#undef p
#undef q
#undef r
#undef s
#undef t
#undef u
#undef v
#ifdef w
#ifdef x
#ifdef y
#ifndef z
#define z
#endif
#else
#define y
#endif
#else
#define x
#endif
#else
#define w
#include <stdio.h>
main(){
#endif
#ifndef z
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#include "zsmall.c"
#endif
#ifdef z
#undef z
#else
#ifdef y
#undef y
#else
#ifdef x
#undef x
#else
#ifdef w
#undef w
}
#endif
#endif
#endif
#endif
