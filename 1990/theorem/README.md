# Best of Show

	Adrian Mariano
	University of Washington
	2729 72nd Ave SE
	Mercer Island, WA 98040
	USA


## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed some segfaults
under modern (and in some cases earier) systems with this entry. Thank you Cody!

[Yusuke Endoh](/winners.html#Yusuke_Endoh) pointed out that `atof` nowadays
needs `#include <stdlib.h>` which was used in order to get this to work
initially. Thank you Yusuke!


## To run:

	./mariano expression x1 x2 h y1

where:

	expression - function f(x,y)  (see below)
	x1 - start of interval
	x2 - end of interval
	h - step size
	y1 - initial value  (y(x1) == y1)


## Try:

	./mariano y 0 1 0.1 1



## Judges' comments:

The program's source implements four functions, all from the
same source file!

When you compile mariano.c as is and run with 5 args, it numerically
solves the equation y'=f(x,y), with a step size of h, over the interval 
x=[x1,x2], with the initial condition of y(x1)=y1.

The 'expression' f(x,y), is any function of 'x' and 'y' with the
operators:

	    +	-	*	/	^

The symbol '^' is the power operator.  Note that it only supports
integer powers.  Also note that all expressions are evaluated strictly 
left to right.  (i.e., parenthesis aren't supported).

Try running the program with the following args:

	./mariano y 0 1 0.1 1
	./mariano 1/x 1 2 0.1 0
	./mariano 'x^2/y+x' 0 1 0.1 6

But wait, there is more!  You also get, free of charge, a 
reversing filter!  Try:

	./mariano -r 0 0 0 0 < mariano.c > sorter.c

Still not impressed?  The author throws in for free, a 
sort program! Try:

	cc sorter.c -o sorter
	ls | ./sorter

This program is safe for home use as well.  The author has
included a safety feature in case you misplace the original
program source:

    ./sorter -r 0 0 0 0 < sorter.c > mariano_bkp.c

And finally, as a special offer to users of this entry,
the author provides a Fibonacci sequence generator!  Try:

    ./sorter 0 0 0 0 < mariano.c > fibonacci.c
    cc fibonacci.c -o fibonacci
    ./fibonacci 1 1
    ./fibonacci 2 1

Program available 9 track and cartridge cassette.  Gensu knife
not included!  :-)

When this program was first shown at the 1990 Summer Usenix 
conference, it received a standing ovation; a first for
a contest entry.

Originally we noted that the 4 trailing args '0 0 0 0' were required on systems
that dump core when NULL is dereferenced but this problem showed itself in
modern systems even with the 4 '0 0 0 0'. To make this easier for users Cody
Boone Ferguson kindly fixed this problem.


## Author's comments

Differential equations are solved via the Runge-Kutta method, 
which guarantees local error proportional to h^5, and total
error across a finite interval is at most a constant times h^4.

Sorting is accomplished with a standard shell sort.

Note that the sorting and reversing is limited to files with 
fewer than 500 lines, each less than 99 characters long.  

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
