/*
 * chaos machine, http://www.drb.insel.de/~heiner/BB/mabu90.html
 *
 * does not halt (http://www.drb.insel.de/~heiner/BB/TM4-proof.txt)
 */

#define sym_1(sym, _1) sym

#define A__ (1, L, B)
#define A_1 (1, R, B)

#define B__ (1, R, C)
#define B_1 (_, L, E)

#define C__ (_, R, D)
#define C_1 (_, L, A)

#define D__ (1, L, A)
#define D_1 (_, R, D)

#define E__ (1,break)
#define E_1 (_, L, C)
