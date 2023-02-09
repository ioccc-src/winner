Best Game:

	Marangoni Andrea
	Department of Computer Science at Milano
	Via Pausula, 72
	62014 Corridonia (MC)
	Italy


Judges' comments:

    Make and run.

    The object is to refill the table with 5's, by incrementing
    or decrementing numbers as needed.  It is the side effects
    that get you into trouble.  If you are not careful, you may
    find things "at 6's and 7's".  :-)

    NOTE: Some compilers have had trouble optimizing this entry.

    NOTE: Some systems need to compile with -ltermcap as well as -lcurses.

    NOTE: The original winning source marangon.orig.c assumed that
	  exit returned a value which cause problems for some
	  systems where exit returned a void.  The file marangon.c
	  avoids this problem.


Selected notes from the author:

    It starts off by creating a table with number 5 in all places.  The
    CPU melts the numbers and you must return them in original state.
    When you increase a number, all the other eight numbers next to it
    decrease and vice-versa.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
