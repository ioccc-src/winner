/*
 * multiply by 2
 *
 * based on http://www.ioccc.org/2001/herrmann1.times2
 */
 
// try tape_five.h

#define A__ (_, R, A)
#define A_1 (_, L, B)

#define B__ (1, L, C)

#define C__ (1, R, D)
#define C_1 (1, L, C)

#define D__ (_, R, E)
#define D_1 (1, R, D)

#define E__ (_,break)
#define E_1 (_, L, B)
