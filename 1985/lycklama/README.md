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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
