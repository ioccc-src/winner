Best layout:

    	Merlyn LeRoy (Brian Westley)
	Rosemount, Inc.
	1121 Hamline Ave. N. #17
	St. Paul, MN  
	55108
	U.S.A.

Compile and execute without arguments.

Note: Your compiler must parse

		#define _ -a
		-_

      as "--a" and not "-(-a)" or some other tokenized form.  Some strictly
      conforming ANSI C Preprocessors may object to this: for such
      compilers, you can elide the nonstandard token-pasting requirement
      by changing the #define line to:

		#define _ F-->00||F-OO--;

You might enjoy looking at the output of:

	cc -E westley.c

Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
