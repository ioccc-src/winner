## Best layout:

    	Merlyn LeRoy (Brian Westley)
	Rosemount, Inc.
	1121 Hamline Ave. N. #17
	St. Paul, MN  
	55108
	U.S.A.

	http://www.westley.org

## Try:

	make all
	./westley


## Judges' comments

Your compiler must parse

		#define _ -a
		-_

as "--a" and not "-(-a)" or some other tokenized form.  Some strictly
conforming ANSI C Preprocessors may object to this: for such
compilers, you can elide the non-standard token-pasting requirement
by changing the #define line to:

		#define _ F-->00||F-OO--;

You might enjoy looking at the output of:

	cc -E westley.c

Misha Dynin provided a fix for westley.c so that it may compile on 
both K&R and more modern C compilers.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
