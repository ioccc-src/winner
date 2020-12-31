/*
 * greatest common divisor
 *
 * based on http://www.ioccc.org/2001/herrmann1.gcd
 */

// try tape_15_50.h or tape_77_55.h

#define A__  (_, R, A )
#define A_1  (1, L, x9)

#define x0_1 (_, R, x1)

#define x1__ (_, R, xa)
#define x1_1 (1, R, x2)

#define x2__ (_, R, x3)
#define x2_1 (1, R, x2)

#define x3__ (_, R, x3)
#define x3_1 (1, R, x4)

#define x4__ (1, L, x5)
#define x4_1 (1, R, x4)

#define x5_1 (_, L, x6)

#define x6__ (_, R, xc)
#define x6_1 (1, L, x7)

#define x7__ (_, L, x8)
#define x7_1 (1, L, x7)

#define x8__ (_, L, x8)
#define x8_1 (1, L, x9)

#define x9__ (1, R, x0)
#define x9_1 (1, L, x9)

#define xa__ (_, R, xa)
#define xa_1 (_, R, xb)

#define xb__ (_, R, xf)
#define xb_1 (1, R, xc)

#define xc__ (_, R, xd)
#define xc_1 (1, R, xc)

#define xd__ (_, L, xe)
#define xd_1 (_, R, xd)

#define xe__ (_, L, xe)
#define xe_1 (1, L, x7)

#define xf__ (_, break)
#define xf_1 (_, R, xf)
