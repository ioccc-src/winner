#/*
  * this is a guide how to choose names for states and symbols
  *
  * state names must be valid to start a macro identifier, e.g., # is
  * invalid, 0 is invalid, _0 is valid (an empty string is also valid)
  *
  * tape symbols must not be empty and must be valid to end a macro
  * name, e.g., # is invalid, 0 is valid, _0 is valid
  *
  * exception: you can write almost any other sequence of tokens to the
  * tape, but you can not scan them back (you can not even define them
  * as symbols using the
  *
  */ define sym_SYMBOL(sym, _SYMBOL) sym
#/*
  * syntax)
  *
  * finally its perfectly ok to define macros for your states like this
  *
  */ define ANOTHER_NAME_FOR_A A
#/*
  * and for your symbols like this
  *
  */ define FQDN www.ioccc.org.

#define you can run this example on an empty tape

#define A__      (SYMBOL, L,)
#define __       (__, ,)
#define ___      (, R, ANOTHER_NAME_FOR_A)
#define A_SYMBOL (\x1b[4mhttp, R, I)
#define I__      (:, R, O )
#define O__      (/\x2f, R, C)
#define C__      (FQDN, R, Z)
#define Z__      (/, R, L)
#define L__      (index.html, R, _2)
#define _2__     (#enter\x1b[0m, R, _0)
#define _0__     (R(A, tape), R, _1)
#define _1__     ((,), R, _5)
#define _5__     (W(You you!!!), break)
