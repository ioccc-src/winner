/*
 * 4 state, 2 symbol busy beaver, http://www.logique.jussieu.fr/~michel/ha.html#tm42
 *
 * halts after 107 steps
 */

#define sym_1(sym, _1) sym

#define A__ (1, R, B)
#define A_1 (1, L, B)

#define B__ (1, L, A)
#define B_1 (_, L, C)

#define C__ (1,break)
#define C_1 (1, L, D)

#define D__ (1, R, D)
#define D_1 (_, R, A)
