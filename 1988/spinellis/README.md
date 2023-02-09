Best abuse of the rules:

    	Diomidis Spinellis (currently at Imperial College, London, England)
	1 Myrsinis Str.
	GR-145 62 Kifissia
	GREECE

How to compile:

	/lib/cpp spinellis.c > spin.c

and type the following text followed by an EOF ('^D'):

	main()
	{
	    printf("Hello world\n");
	}

The author says:

    This program can be configured to do almost everything.
    The configuration is done during compile time by typing
    in, C code, that one would like the program to perform.
    A trivial example is given in the `how to compile' section
    but the possibilities are clearly limited only by your
    imagination and programming skills.

FYI: We enjoyed this entry this year, however in the future programs 
     must be able to be compiled from within a makefile without the
     need of human intervention.

Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
