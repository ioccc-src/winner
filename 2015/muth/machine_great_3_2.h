/*
 * greater machine, http://www.drb.insel.de/~heiner/BB/mabu90.html
 *
 * does not halt
 */

#define sym_1(sym, _1) sym

#define A__ (1, L, B)
#define A_1 (1, R, A)

#define B__ (_, R, C)
#define B_1 (1, L, B)

#define C__ (1,break)
#define C_1 (1, R, A)
