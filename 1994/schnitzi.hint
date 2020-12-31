Best Layout:

	Mark Schnitzius
	ISX Corporation
	1165 Northchase Pkwy, Suite 120
	Marietta, GA 30067
	USA


Judges' comments:

    To use:
	make schnitzi
	./schnitzi < textfile

    Try:
	./schnitzi < /etc/motd
	./schnitzi < schnitzi.c

    Compare the output of the program with its source.  Sure the output
    is different, but there is more than meets the diff's eye.  Can you
    find out why?


Selected notes from the author:

    SPOILER:

    This is a program which takes any text file as input and 'flips'
    the input file along a diagonal running from the top left corner
    down to the bottom right.  In other words, the first row in the
    file ends up written down the first column of the result, the
    second row is written down the second column, etc. The program
    is run by redirecting a file into the executable on the command
    line; for instance, for the included 'info' file, the program
    would be run as follows:
    
    	schnitzi < info
    
    The program generates interesting results when its source file is
    used as input:
    
    	schnitzi < schnitzi.c
    
    The result of this command is a program which does the exact same
    thing -- in other words, both the program and the "flipped"
    version of itself work identically (you'll need to redirect the
    output of the above command into a separate file and compile it).
    You might notice some differences in the flipped version, though.
    First off, a secret message becomes visible that was not visible
    in the original program.  Also, much of the code shows up in 
    different places in the flipped program than it appeared in the
    first program.  My first version of this program was perfectly 
    symmetrical along the diagonal, but later found out there were
    interesting ways to break the symmetry.  The best way to see this 
    is to load both the original and flipped versions of the program
    into an editor and switch back and forth between them rapidly.
    
    C tokens longer than a character (such as "main") proved difficult
    to use in both the original and flipped versions (after flipping,
    they show up as a string of single letters on successive lines).
    However, I found that it was possible to get around this through
    a few well-placed comments.  An earlier version of this program
    used nearly every single-character token in the "shared" area;
    however, it proved to be too large for contest guidelines (although
    the code itself is only about 300 characters, the extra whitespace
    needed to pad it put it over the limit -- it nearly filled a 79 by
    79 area, adding up to over 4000 total characters).  I will provide
    this other version to anyone interested -- contact me by email
    at schnitzi@east.isx.com.

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
