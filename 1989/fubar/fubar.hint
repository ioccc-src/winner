Best self-modifying program:

	Jay Vosburgh
        Sequent Computer Systems, Inc
        15450 SW Koll Parkway
        Beaverton, OR
        97006
        USA

Judges notes:

	Run this with a single digit argument (or wait a long time).

	There are 2 versions of this program, the one that was entered,
	and one that was changed by the judges to be more portable. The
	makefile runs the latter version by default.

	The blank line at the beginning of the source is mandatory.
	Do you know why?

	The shell script run by the makefile joins lines that may be
	cut up by mailers.  The file "fubar.orig.c", for example, needs
	the 6th and 7th lines joined together (with a space between
	them) to recreate the original entry.  If you fix the file, you
	will need to change the last 8 linnes of "fubar.orig.sh" to read:

		cp fubar.orig.c ouroboros.c
		chmod +x ouroboros.c
		csh ouroboros.c $1
		rm -f ouroboros.c x1 x

	The more portable version, "fubar.c", can be fixed by joining the
	7th and 8th lines in the same way.  As well, if you fix "fubar.c"
	you will need to also change the last 8 lines to "fubar.sh" to read:

		cp fubar.c ouroboros.c
		chmod +x ouroboros.c
		csh ouroboros.c $1
		rm -f ouroboros.c x1 x

Selected notes from the author:

	In a nutshell, this is probably the slowest and most
	obnoxious factorial program ever written.  Unfortunately, 
	the name of the C source must be "ouroboros.c"; the name is 
	hard-coded into the program.  

	The source is a legal shell script and a legal C program.  
	The shell script compiles itself, and then executes the
	resulting binary, giving the source as input.  The program 
	works by successively modifying #define lines each pass through.

	Both "indent" and "cb" will damage the program, "indent" 
	much more so.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
