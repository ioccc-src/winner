Best of Show:

	Adrian Mariano
	University of Washington
	2729 72nd Ave SE
	Mercer Island, WA 98040
	USA


Judges' comments:

    The program's source implements four functions, all from the
    same source file!

    Usage:

	theorem expression x1 x2 h y1

	where:
		expression - function f(x,y)  (see below)
		x1 - start of interval
		x2 - end of interval
		h - step size
		y1 - initial value  (y(x1) == y1)

    When you compile theorem.c as is and run with 5 args, it numerically
    solves the equation y'=f(x,y), with a step size of h, over the interval 
    x=[x1,x2], with the initial condition of y(x1)=y1.

    The 'expression' f(x,y), is any function of 'x' and 'y' with the
    operators:
    
		+	-	*	/	^

    The symbol '^' is the power operator.  Note that it only supports
    integer powers.  Also note that all expressions are evaluated strictly 
    left to right.  (i.e., parenthesis aren't supported).

    Try running the program with the following args:

	theorem y 0 1 0.1 1
	theorem 1/x 1 2 0.1 0
	theorem 'x^2/y+x' 0 1 0.1 6
    
    But wait, there is more!  You also get, free of charge, a 
    reversing filter!  Try:

	theorem -r 0 0 0 0 < theorem.c > sorter.c
    
    Still not impressed?  The author throws in for free, a 
    sort program! Try:

	cc sorter.c -o sorter
	ls | sorter
    
    This program is safe for home use as well.  The author has
    included a safety feature in case you misplace the original
    program source:

	sorter -r 0 0 0 0 < sorter.c > theorem_bkp.c
    
    And finally, as a special offer to users of this entry,
    the author provides a Fibonacci sequence generator!  Try:

	sorter 0 0 0 0 < theorem.c > fibonacci.c
	cc fibonacci.c -o fibonacci
	fibonacci 1 1
	fibonacci 2 1

    Program available 9 track and cartridge cassette.  Gensu knife
    not included!  :-)

    When this program was first shown at the 1990 Summer Usenix 
    conference, it received a standing ovation; a first for
    a contest entry.

    It should be noted that the 4 trailing args '0 0 0 0', are
    required on systems that dump core when NULL is dereferenced.


Selected notes from the author:

    Differential equations are solved via the Runge-Kutta method, 
    which guarantees local error proportional to h^5, and total
    error across a finite interval is at most a constant times h^4.
    
    Sorting is accomplished with a standard shell sort.

    Note that the sorting and reversing is limited to files with 
    fewer than 500 lines, each less than 99 characters long.  

Copyright (c) 1990, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
