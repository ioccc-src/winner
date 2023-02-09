Best Short Program:

	Jeff Weisberg
	University of Rochester
	Dept of Electrical Engineering
	Computer Studies Bldg
	Rochester, NY 14627
	USA


Judges' comments:

    To use:
	make weisberg
	./weisberg

    This entry confuses some C-preprocessors and some C-beautifiers.
    We found one cpp that processed this source differently when
    it was read on stdin instead of via cc -E.

    If you liked what you saw from the above program, and happen to
    have some 512 Megabytes of virtual memory laying around with to do,
    you could try:

	make weisberg.alt
	./weisberg.alt

    Lesser systems will find this alternative version a good way to create
    a core file.  :-)


Selected notes from the author:

    Description:
	The following short program implements the "Yet Another" algorithm for
	generating prime numbers.  It will generate all primes up to 33554432,
	displaying them to the standard output as it churns along.  As 33554432
	is rather large on most machines, this code may take quite some time to
	run to completion, so as an added feature, it will cease execution upon
	reception of a signal (any will do equally well), as well as in the
	event of a system shutdown or reboot.
	
    Bugs:
	The alternative version (weisberg.alt) has never actually run
	to completion. After running for close to a week it had reached
	somewhere around 250e6, when it became necessary to test the
	reboot feature (which worked remarkably well) As there are
	quite a lot of primes to be found before reaching MAXINT, the
	output produced can be quite overwhelming, it recommended to
	pipe the output through your favorite pager (more or less), and not 
	output to a paper output device (unless you have *LOTS* of paper).

    Technical:
	The original "Yet Another Prime Program" algorithm used here was
	developed as a Computer Architecture course micro-programing exercise,
	and was designed to take full advantage of the UR300
	micro-architecture to achieve blindingly fast speed. It was ported to
	C specifically for the IOCCC. In the conversion/obfuscation step some
	of (much of) the blazing speed was lost, but as a bonus, the
	understandability of the code was reduced to zero.

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
