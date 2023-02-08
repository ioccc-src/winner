Best small program:

	Maarten Litmaath
	Free University (VU) Amsterdam
	Department of computer science
	Uilenstede 72
	1183 AK Amstelveen
	The Netherlands

Try: litmaath eschew obfuscation

Note the unusual structure:

	 while (<condition>)
		 ;

Did you notice that the body is empty?

The best one can do to understand how the program works is to give it
two small strings as arguments, and follow the program closely.  One
could make the body of the 'while' loop an 'fprintf' with interesting
variables like:

    fprintf(stderr,
	     "argv=%lo *argv=%lo **argv=%c argv[1]=%lo *argv[1]=%c argc=%d\n",
	     (long) argv, (long) *argv, *argv && **argv ? **argv : '@',
	     (long) argv[1], argv[1] && *argv[1] ? *argv[1] : '@', argc);

Furthermore, it's interesting to note that only two variables are
used to achieve everything.

Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
