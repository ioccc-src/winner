Best Obfuscated Algorithm:

	E. Jay Berkenbilt
	Engineering Research Associates
	1595 Springhill Road
	Vienna, VA 22182-2235
	USA


Judges' comments:

    To run:
	make ejb
	./ejb level

    where:
	level   a value from -128 to 127

     A negative argument plays the patience puzzle.  An argument
     greater than 0 plays the Tower of Hanoi puzzle.  In either case
     the absolute value of the argument specifies the size of the
     respective puzzle.  Refer to the files ejb.explain1 and
     ejb.explain2 for more information on these puzzles.

     Of course, you need a different kind of "patience" if you give
     the argument 127 to this program and want to see it finish!


Selected notes from the author:

    WHAT THIS PROGRAM DOES
    ======================

    ./ejb 5		Output: solution to Towers of Hanoi for five rings
    ./ejb -6		Output: solution to the Patience puzzle for six rings

    The format of the output for the Towers of Hanoi case is simply a
    text description of how to solve the puzzle.  For the patience
    puzzle, the output is a sequence binary codes representing
    successive states of the puzzle.  The rightmost digit represents
    the first ring.  A "1" means the ring is on the U; a "0" means it
    is off the U.  The program prints the word "Invalid" in response to
    illegal command line parameters.

    MOTIVATION
    ==========
    Most people who have written software for other people have been
    asked to count lines of code.  Naturally, this brings up the
    controversial question of exactly what defines a line of code.
    This program serves to show that counting semicolons will not
    always provide a meaningful measure of code size.  This is
    especially true in this program where the number of semicolons
    itself is ambiguous.  Does it have two or three?  In addition, the
    only "C" keyword this program uses besides type names and
    qualifiers is "return", and the only function defined in the code
    is "main".  The level of complexity of the program without multiple
    semicolons, statements, and functions is achieved by abusing C
    operators, especially the comma operator.  Considerable use of ||,
    &&, and ? : helps too.  In addition, main is called recursively.
    The null pointer that terminates argv is used to pass additional
    information into main.  Even though the algorithms used by this
    code are simple, this program is still hard to follow even when
    indented properly.  (It is pretty hard to indent this code
    reasonably, however.)

    Although this program is has only been tested on UNIX systems but
    will probably run on just about any machine with an ANSI C
    compiler.  It does not use the C preprocessor at all.  The only
    functions it uses are atoi, malloc, memset, printf, and puts.  It
    does, however, require that the architecture it runs on have bytes
    that are at least eight bits long and pointers that are at least
    four bytes long.  In addition, it requires an ANSI compiler since
    it uses "signed char" and ANSI-style function declarations.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
