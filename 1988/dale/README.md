## Best abuse of system calls

    	Paul Dale
	University of Queensland
	Computer Science Dept
	Dept of Computer Science
	Uni of Qld, 4067
	Australia

## To build:

	    make all

NOTE: for modern compilers we had to change the C pre-processor lines like:

	    #define _ define
	    -#_ foo bar

to be:

	    #define foo bar

Even so this entry requires a compiler that supports the `-traditional-cpp`
option.

## Try:


	./dale hello world
	./dale these files are in this directory: *


## Judges' comments

This entry has a very twisted flow of control via recursion, iteration 
and multi-processing.  Try to understand what is being done with the
system calls.

NOTE: This program assumes the ASCII character set is being used.


Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
