Most humorous output:

	Oskar von der Luehe
	Institut fuer Astronomie
	ETH - Zentrum
	8092 Zuerich
	Switzerland

Judges notes:

	Run this program using your favorite text file as input.  Files
	such as mailboxes, man pages and usenet articles are especially
	recommended.  You will get different output each time you run it.

	Run the program this way:

		ovdluhe < textfile

	The program stops when it reaches the end of the template buffer 
	by chance or is killed.

Selected notes from the author:

	This program implements an "Eddington ape" - it generates
	random text from a supplied template.  The template text file
	is read through stdin.  The larger the template, the better the
	result.  A maximum of 2**12 chars are used. From the template,
	the program calculates the statistics of chars that immediately
	follow a given string (correlator string) of a certain length
	(currently 4 - can be varied by changing the definition for P
	accordingly).  A character is randomly chosen, weighted by its
	probability to occur after the correlator string.  That
	character is printed to stdout and placed at the end of the
	correlator string, whose first character is discarded.
	Meaningful words are therefore usually preserved, the effect on
	sentences can be dramatically random.

	You might want to vary the definition of P between 2 and 10 and
	observe the result.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
