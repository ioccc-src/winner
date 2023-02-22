# Best self-modifying program:

	Jay Vosburgh
        Sequent Computer Systems, Inc
        15450 SW Koll Parkway
        Beaverton, OR
        97006
        USA

## To build:

        make all

### To run

	./fubar 2

## Judges' comments

	Run this with a single digit argument (or wait a long time).

	The blank line at the beginning of the source is mandatory.
	Do you know why?

## Author's comments

	In a nutshell, this is probably the slowest and most
	obnoxious factorial program ever written.  Unfortunately, 
	the name of the C source must be "ouroboros.c"; the name is 
	hard-coded into the program.  

	The source is a legal shell script and a legal C program.  
	The shell script compiles itself, and then executes the
	resulting binary, giving the source as input.  The program 
	works by successively modifying #define lines each pass through.

	Both "indent" and "cb" will damage the program, "indent" 
	much more so.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
