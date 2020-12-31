Best visuals:

    	Mark Isaak
	Imagen Corporation
	2650 San Tomas Expy.
	Santa Clara, CA 
	95052-8101
	USA

Compile with:

	cc -DI=B -DO=- -Dy isaak.c -o isaak

Execute without arguments.

The original entry starts with the line:

	main(){};

This works on some 4.3BSD systems.  Why?  Note that #include <stdio.h>
is given on the last line.  Why is this needed?  Note the unusual calls
to sprintf.

NOTE:  The program relies heavily on ASCII.  Don't even think of
       running it on an EBCDIC machine.  If you name the file anything 
       other than "isaak.c", you must change the #include on line 7.

NOTE: The use of null comments to separate macros to construct different 
      tokens from a single macro (e.g., "O/**/O" creates either "++" or "--" 
      by defining "O" to be "+" or "-") may cause some strict ANSI
      C preprocessors to object.

NOTE: Most System V machines will not be able to execute this program
      correctly due to the fact that BSD style systems have an sprintf()
      that returns a char *.

Due to the above problems, we have replaced the output of this program
in the file: isaak.encode.  To read this file do:

	uudecode < isaak.encode
	cat isaak.output

FYI: We are likely to be more strict about portability in the future.

Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
