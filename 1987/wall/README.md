# Most Useful Obfuscation

Larry Wall  
Unisys - System Development Group Santa Monica  
9132 Kester Ave  
Panorama City, CA  91402  USA  

## To build:

        make all

## To run:


	./wall
	# enter some strings

	./wall | some_command
	# enter some strings

### Try:

	./wall | bc | ./wall

and input the following:

	x*x
	c^2
	m*m

	# can you figure out what this does?
	500

### Also try:

	./wall | bc

	./wall | cat


and enter some input like:

	x*x
	2^x
	quit # for the cat version


## Judges' comments:


What we found amazing was how the flow of control was transferred
between subroutines.  Careful inspection will show that the array of
pointers to functions named 'vi' refers to functions which seem to not
be directly called.  Even so, these pointers to functions are being
used as an argument to signal.  Can you determine why this is being
done and how it is being exploited?

Some compilers complained about this file, so we changed: '=++I' to '= ++I'.


## Author's comments:

No comments were provided by the author.

Copyright (c) 1987, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
