/*
 * counting machine, http://www.drb.insel.de/~heiner/BB/mabu90.html
 *
 * does not halt
 */

#define sym_1(sym, _1) sym

#define A__ (1, L, B)
#define A_1 (1, R, A)

#define B__ (_, R, A)
#define B_1 (_, L, C)

#define C__ (_, R, A)
#define C_1 (1, L, D)

#define D__ (_, L, E)
#define D_1 (1, R, B)

#define E__ (_, R, B)
#define E_1 (1,break)
