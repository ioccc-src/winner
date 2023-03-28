## Best small program

	Maarten Litmaath
	Free University (VU) Amsterdam
	Department of computer science
	Uilenstede 72
	1183 AK Amstelveen
	The Netherlands

## Try:

	./litmaath eschew obfuscation


## Judges' comments:

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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
