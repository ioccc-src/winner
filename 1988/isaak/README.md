# Best visuals:

    	Mark Isaak
	Imagen Corporation
	2650 San Tomas Expy.
	Santa Clara, CA 
	95052-8101
	USA

## To build:

        make all

### To run

	./isaak

### Alternate code

An alternate version of this entry, `isaak.alt.c`.

The original entry starts with the line:

	main(){};

This works on some systems.  Why?  Note that `#include <stdio.h>` is given on
the last line.  Why is this needed?  Note the unusual calls to sprintf.

## Judges' comments

NOTE:  The program relies heavily on ASCII.  Don't even think of running it on
an EBCDIC machine.  If you name the file anything other than "isaak.c", you must
change the `#include` on line 7.

NOTE: The use of null comments to separate macros to construct different tokens
from a single macro (e.g., `"O/**/O"` creates either `++` or `--` by defining
`O` to be `+` or `-`) may cause some strict ANSI C preprocessors to object.

NOTE: Most System V machines will not be able to execute this program correctly
due to the fact that BSD style systems have an sprintf() that returns a `char *`.

Due to the above problems, we have placed the output of this program
in the file: isaak.encode.  To read this file do:

	uudecode < isaak.encode
	cat isaak.output

FYI: We are likely to be more strict about portability in the future.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
