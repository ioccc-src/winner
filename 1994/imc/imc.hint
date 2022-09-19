Most Obfuscated Algorithm:

	Ian Collier
	Oxford University
	57 Wyndham Avenue        (home address)
	BOLTON
	BL3 4LG
	England


Judges' comments:

    To use:
	make imc
	./imc INTEGER

    Try:
	./imc 3
	./imc 3
	./imc 4
	./imc 4
	./imc 6

    This entry's algorithm is as magic as its output!


Selected notes from the author:

    This program may be compiled with an ANSI or K&R compiler.  A few
    harmless warnings are displayed only if "gcc -Wall" is used.

    This entry is really a set of library functions, but an example
    main function has been added so that the library can be tested.  If
    the program appears too large, consider that functions o and s can
    each be separated from the rest of the program (except for the short
    functions p and r, which they require) and used alone.  However, the
    main part of the program is the function e, which does require all the
    other functions (apart from main).

    The program should be supplied with an integer parameter.  If no
    parameter or an invalid parameter is given, then 5 is assumed.  The
    maximum parameter is determined only by the amount of cpu time, virtual
    memory and display (or file) space available.

    SPOILER:

    OK, so you have probably seen magic square printers before.  But what
    about one that deals with even sizes as well as odd ones, or one that
    prints out a different one each time (or attempts to, at any rate)?

    I have formatted the important functions o, s and e to show how useful
    the word "for" is, and (in function e) how useful the words "if" and
    "else" are.  In fact, hardly anything happens that isn't in one of these
    instructions.  I did this in order to simplify the code - the algorithms
    used to make the random squares are quite complex without being shrouded
    in obfuscated code! :-)  Incidentally, I was surprised to find out how
    useful the exclusive-or operator was while writing function s.

    Here are the descriptions of the functions in the library:

    o(n,a,q,d): makes a magic square of order n when n is odd and at least 3.
    s(n,a,q,d): makes a magic square of order n when n equals 4.
    e(n,a,q,d): makes a magic square of order n when n is even and at least 6.

    In the above, a (of type int*) points to an area of memory in which
    the magic square will be stored and q (also of type int*) points to
    an area of memory of length at least n*sizeof(int) bytes which can be
    used as a work space.  Both a and q must be allocated by the caller.
    The integer parameter d, usually zero, indicates the length of a gap
    which will be left between adjacent rows of the magic square.

    The square which is returned will (or should) be a permutation of the
    numbers 1 to n*n in which all rows and columns and the two diagonals
    add up to n*(n*n+1)/2.

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
