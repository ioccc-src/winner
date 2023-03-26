## Best abuse of system calls

    	Paul Dale
	University of Queensland
	Computer Science Dept
	Dept of Computer Science
	Uni of Qld, 4067
	Australia

## To build:

	    make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. Modern compilers do not allow directives like:

	    #define _ define
	    -#_ foo bar

so Cody changed the lines to be in the form of:

	    #define foo bar

Even so this entry requires a compiler that supports the `-traditional-cpp`
option. Thank you Cody for your assistance!


## Try:


	./dale hello world
	./dale these files are in this directory: *


## Judges' comments

This entry has a very twisted flow of control via recursion, iteration 
and multi-processing.  Try to understand what is being done with the
system calls.

NOTE: This program assumes the ASCII character set is being used.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
