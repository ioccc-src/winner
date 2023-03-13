# The strangest appearing program 

Ed Lycklama

## To build:

        make all


## To run:

	./lycklama < some_file

## Try:


	./lycklama < lycklama.c

	# notice the difference between the above and this one:
	./lycklama < lycklama.alt.c

	./lycklama < README.md

	./lycklama < Makefile


## Judges' comments:

Run the program, redirecting a file into it, and notice how it redisplays it.
The program itself looks like tty noise.

In the past 'define' in `#define` could even be defined but to get this to work
on modern systems we had to change the `#o` lines to `#define`.

## Author's comments:

No comments were provided by the author.



Copyright (c) 1985, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
