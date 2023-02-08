Strangest abuse of the rules:

	Jari Arkko
	Laboratory of Information Processing Science
	Helsinki University of Technology
	Otakaari 1
	02150 Espoo
	Finland

Judges notes:

	On many systems the compiler will not allow you to send the
	object file to /dev/tty.  The author suggested:

		cc -c -o /dev/tty jar.1.c

	On systems that have symbolic links, we suggest:

		ln -s /dev/tty jar.1.o
		cc -c jar.1.c
	
	if your system has symbolic links.  The shell script run
	by the makefile simply cats the .o file to the terminal
	which can be used as a last resort.

	Abuse of the rules winners usually result in a change of the
	rules.  Starting in 1990, compiling entries must result an
	regular file which can be executed.

Selected notes from the author:

	This program is (supposedly) the smallest C program able to
	print "Hello world.". The compilation itself produces the
	desired printout and the program need not be actually run.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
