# Worst Abuse of the C Preprocessor:

	Ed Luke
	Mississippi State University
	P.O. Box 6176
	Mississippi State, MS 39762, USA

## To build:

        make all

### To run

	make lush.again 2>&1 | ./lush

	NOTE: This entry requires a non-standard K&R C compiler to compile.

## Judges' comments

    The program uses error messages issued by the C Proproessor to
    generate its message to the world.  One program's error is another 
    program's data!

## Author's comments

    This program is yet another "Hello World." program with a twist.  The
    string Hello World has been encoded in the error messages the compiler
    generates when compiling the source.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
