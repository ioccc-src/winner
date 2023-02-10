# The strangest appearing program 

Ed Lycklama

## To build:

        make all

NOTE: This entry uses non-standard args to main() that do not work with modern compilers.

## Judges' comments:

Run the program, redirecting a file into it, and notice how it redisplays it.
For instance try:

	./lycklama < lycklama.c

The program itself looks like tty noise. In the past 'define' in `#define` could
even be defined but to get this to work on modern systems we had to change the
`#o` lines to `#define`.


Copyright (c) 1985, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
