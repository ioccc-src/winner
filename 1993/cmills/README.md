"Bill Gates" Award:

	Chris Mills
	Pagine Corporation
	1961-A Concourse Drive
	San Jose, CA 95131
	USA


Judges' comments:

    From the San Jose Mercury News (May 15, 1993 page 20A "West Hackers 
    trounce East in computer quiz game"): 

	"Since 1984, a contest has been held on Usenet for the most
	unreadable, creative, bizarre but working C program", Gates
	said. "What is the name of this contest?"

	"Windows," shot back Gassee, naming Microsoft's premier product
	- a product over which Apple sued Microsoft five years ago. Not
	the right answer - it's "The Obfuscated C Contest [sic]" - but
	it brought down the house of Apple partisans...

    [The expression on Bill Gates' face was a sight to behold, as reported
    to us by several who were there].

    To use:
	make cmills 		# requires the X11 library
	DISPLAY="your_X_server_display" 
	export DISPLAY
	./cmills [speed]	# must be run on an X11 server

    where:
	speed	update speed from 1 to 9 (default is 9)

    Csh users should use:
	make cmills 		# requires the X11 library
	setenv DISPLAY "your_X_server_display" 
	./cmills [speed]	# must be run on an X11 server

    You must set $DISPLAY in your environment or the program will 
    dump core.  This is not a bug as the author documented it as
    a feature.  :-)

    The optional argument is integer which controls the speed of the
    program.  By default the speed is 9.  You may want to try 1.

    You will have to kill the program (i.e., ^C) to stop it.

    WARNING: Slow servers or servers with long request queues will
	     continue to 'run' for a while after you have killed
	     the program.

    This program makes your windows about as useful as their windows. :-)


Selected notes from the author:

    The program uses a single backing pixmap (which is the size of the
    screen) for all of its subwindows (with a little bit of trickery to
    move the offset around).  This is much better (and faster) than the
    obvious implementation which would require a full-screen pixmap and
    a separate backing pixmap for each subwindow.

    The chance that a window breaks is based on it's kinetic energy,
    which in turn is based on it's area and speed.  How silly!

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
