/*
 * 2 state, 4 symbol current runner-up, http://www.logique.jussieu.fr/~michel/ha.html#tm24
 *
 * halts after 7195 steps
 */

#define sym_1(sym, _1) sym
#define sym_2(sym, _2) sym
#define sym_3(sym, _3) sym

#define A__ (1, R, B)
#define A_1 (3, L, A)
#define A_2 (1, L, A)
#define A_3 (1, R, A)

#define B__ (2, L, A)
#define B_1 (1,break)
#define B_2 (3, R, A)
#define B_3 (3, R, B)
