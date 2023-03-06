## Best abuse of the rules:

    	Diomidis Spinellis (currently at Imperial College, London, England)
	1 Myrsinis Str.
	GR-145 62 Kifissia
	GREECE

## To build:


	make all

and then type a C program into followed by EOF two times (`^D^D`).

NOTE: this entry will not compile with clang. Also be advised that gcc in macOS
is actually clang so this will not work even with the default compiler in macOS.


## Try:

	make clobber all
	main()
	{
	    printf("Hello world\n");
	}
	^D
	^D
	./spinellis

	make clobber all
	int main()
	{
	    int i;
	    for (i = 0; i < 5; ++i)
		printf("%d\n", i);
	}
	^D
	^D
	./spinellis


## Judges' comments

We enjoyed this entry this year, however in the future programs must be able to
be compiled from within a Makefile without the need of human intervention.

The author originally wrote:

    This program can be configured to do almost everything.
    The configuration is done during compile time by typing
    in, C code, that one would like the program to perform.
    A trivial example is given in the `how to compile' section
    but the possibilities are clearly limited only by your
    imagination and programming skills.



Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
