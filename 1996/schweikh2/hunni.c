#include<stdio.h>

/* $Id: hunni.c,v 1.5 1996/11/17 20:58:04 schweikh Exp schweikh $ */

/* usage: hunni [n_op [start [increment [goal]]]] */

/* Up to 20! = 2432902008176640000 */
/*          < 9223372036854775807 = 2^63-1 */
/* n! fits in signed long long ints, */
/* with 19 operators there are 4^19 = 274,877,906,944 combinations, */

/* up to 12! =  479001600 */
/*          < 2147483647 = 2^31-1 */
/* n! fits in signed long ints, */
/* with 11 operators there are 4^11 = 4,194,304 combinations. */

/*@-loopswitchbreak@*/
/*@-protoparamprefix p_@*/
/*@-pointerarith@*/
/*@+ignorequals@*/

#define FMT     "%ld"   /* printf and scanf format for this type */
#define LONGEST long    /* longest type of this implementation */


typedef struct { LONGEST num, den; } fraction;
typedef unsigned LONGEST bitvec;

static fraction init[20], work[20], param[4] = {
    { 9, 1 } ,
    { 1, 1 } ,
    { 1, 1 } ,
    { 6 * 7, 1 }
};

static int J;

    static void
out (fraction f)
{
    if (f.den - 1) {
	    J = printf (FMT "/" FMT, f.num, f.den);
    } else {
	    J = printf (FMT, f.num);
    }
}

    static void
normalize (fraction *p_f)
{
    LONGEST a = (*p_f).num, b = (*p_f).den;

    if (b) {
	    while (a) {
		    LONGEST i = b % a;
		    b = a;
		    a = i;
	    }
	    b = b < 0 ? - b : b ;
	    (*p_f).num /= b;
	    (*p_f).den /= b;
    }
}

    int
main (int argc, char *argv[])
{
    bitvec m, mask;
    int i, cursor;

    for (i = 1; i < 5; i = i + 1) {
	    if (argc > i) {
		    J = sscanf (argv[i], FMT "/" FMT,
		    &param[i-1].num, &param[i-1].den);
	    }
	    normalize (param + i - 1);
    }
    init[0] = param[1];
    for (i = 0; i < param[0].num; i = i + 1) {
	    init[i+1].num = init[i].num * param[2].den
	    + param[2].num * init[i].den;
	    init[i+1].den = init[i].den * param[2].den;
	    normalize (init + i + 1);
    }
    for (mask = ~(~0 << param[0].num*2); ~(bitvec)0 - mask; mask = mask - 1) {
	    /* Pass one computes mult and div. */
	    /* For add and sub the right operand is copied. */
	    work[cursor = 0] = init[0];
	    for (m = mask, i = 1; ! (i > param[0].num); i = i + 1, m = m / 4) {
		    if ((m & 3) < 2) {
			    if (m & 1) {
				    work[cursor].num *= init[i].den;
				    if ((work[cursor].den *= init[i].num) < 0) {
					    work[cursor].num *= -1;
					    work[cursor].den *= -1;
				    }
			    } else {
				    work[cursor].num *= init[i].num;
				    work[cursor].den *= init[i].den;
			    }
		    } else {
			    work[cursor = cursor + 1] = init[i];
		    }
	    }
	    /* Pass two computes the remaining adds and subs. */
	    for (m = mask, i = cursor = 0; i < param[0].num; i = i + 1, m = m / 4) {
		    if ((m & 3) > 1) {
			    work[0].num = work[0].num * work[cursor+1].den +
			    ((m & 1) ? -1 : +1) * work[cursor+1].num * work[0].den;
			    work[0].den = work[0].den * work[cursor = cursor + 1].den;
		    }
	    }
	    normalize (work);
	    /* output result */
	    if (!param[3].den
		    || (!(param[3].num - work[0].num)
		    && !(param[3].den - work[0].den))) {
		    for (m = mask, i = 0; i < param[0].num; i = i + 1, m = m / 4) {
			    out (init[i]);
			    J = printf (" %c ", "*/+-"[m & 3]);
		    }
		    out (init[i]);
		    J = printf (" = ");
		    out (work[0]);
		    J = printf ("%c", 10); /* newline */
	    }

    }
    return J - 1;
}
