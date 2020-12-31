/*
 * complex machine, http://www.drb.insel.de/~heiner/BB/mabu90.html
 */

#define sym_1(sym, _1) sym

#define A__ (1, L, B)
#define A_1 (1, R, A)

#define B__ (_, R, A)
#define B_1 (_, L, C)

#define C__ (_, R, C)
#define C_1 (1, L, D)

#define D__ (1, L, E)
#define D_1 (_, R, A)

#define E__ (_, L, B)
#define E_1 (1,break)
