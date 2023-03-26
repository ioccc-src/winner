# Most Well Rounded Obfuscation:

	Andrew T. Shapiro
	CSES/CIRES University of Colorado
	Campus Box 216
	Boulder, CO 80309-0216
	USA

## To build:

        make all

### To run

	./shapiro &

## Judges' comments

    This entry has many different levels of obfuscation, and yet the
    source file is self documenting.  :-)

    From time to time, run ps and look at the new processes.

    See shapiro.info for more information in the internals of this program.
    The file shapiro.alt contains a non-obfuscated version of this program.

## Author's comments

     The basic theme (pun) of this program is:
     
       "This time (everything) is not where it should be."
             ~~~~
     My entry (shapiro.c) is mostly comment, formatted in the shape of a 
     clock. If you strip out the comments and look at the code you will 
     quickly realize that the comments were the important part and that 
     the code does very little (see pun above). It writes (to stdout) 
     another C program (shapiro_t2.c). This is the first level of 
     obfuscation.
     
     The second program (shapiro_t2.c if you use the build/make file) 
     prints a clock in the upper right hand corner of your VTxxx/ANSI 
     display. 
     
     Most of the surface obfuscation in the second program (shapiro_t2.c) 
     was an attempt to make it as small as possible. You should be able to 
     see around this with cb(1) and some more intelligent variable names. 
     Once you get past this you will realize that the third level of 
     obfuscation is a six member client/server hierarchy. 
     (See the second info file for a detailed description of the algorithm.)
     
     Lint complains about: precedence confusion, K may be used before set,
       main() returns random value to invocation environment, value type used 
       inconsistently, value type declared inconsistently, function argument 
       ( number ) used inconsistently, function returns value which is always 
       ignored, function returns value which is sometimes ignored
     All of which are harmless (famous last words). 
     
     This may or may not work on non ASCII systems (I could not find one to
     test it on.)

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
