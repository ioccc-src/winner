ANSI Committee's Worst Abuse of C:

	Larry Jones
	SDRC
	2000 Eastman Dr
	Milford, OH 45150  
	USA


Judges' comments:

    The addition of trigraphs has made it easier to make programs 
    hard to read.  It was a dark and stormy night for C when the
    ANSI C committee added trigraphs to the standard.  Too bad
    that they didn't just simply require a more reasonable ISO
    character set.

    The common.mk (non-ANSI) makefile uses sed to form scjones.alt.c.
    The scjones.alt.c is similar to the original scjones.c source,
    but with all the trigraphs converted.  You might want to try:

		make -f common.mk scjones.alt.c

    even if you only have an ANSI compiler, just to see how
    the trigrapsh are converted.

WARNING: In the future, we will be passing ANSI programs through a
	 trigraph filter before reading.  Trigraph-ifacation will
	 not be a major consideration in future contests.  People 
	 should exploit more interesting features of ANSI C.


Selected notes from the author:

    Since this year's contest is dedicated to ANSI C, here is a
    strictly conforming entry.  In accordance with the ANSI
    definition of a strictly conforming program it does not produce
    output dependent on any unspecified, undefined, or implementation
    defined behavior, and it does not exceed any of the minimum
    implementation limits.  It adheres to all of the syntactic and
    semantic constraints of the standard, #includes the relevant
    headers for the functions it uses, and uses the EXIT_SUCCESS and
    EXIT_FAILURE macros to return a correct success/fail status to
    the invoking program.  It also uses trigraphs for characters
    which are not in the Invariant Code Set of ISO 646:1983, so it
    will be portable to machines with deficient (from C's standpoint)
    character sets.  In short, it should be very widely portable.  As
    an extra added attraction, all of the lines are under 72
    characters long, which would allow for sequence numbers to be
    punched in columns 73-80 :-).

    [[ The Author sent us this note after he was informed that he won ]]

    Although I am quite grateful for the "ANSI Committee's Worst Abuse
    of C" title (were you aware that I am a member of the committee or
    is the double meaning unintentional?), I was really hoping for
    something more along the lines of "Closest Resemblance to Line Noise."  :-)

    [[ ... it was unintentional ]]

Copyright (c) 1990, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
