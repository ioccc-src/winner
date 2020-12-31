Best Game:

	Chris Mills
	Wyse Technology
	3471 N. 1st St.
	San Jose CA 95134
	USA


Judges notes:

    Compile notes:

       cc -DM=500 -DN=52 -DX="srand((int)time(0L))" -DV=void -o cmills cmills.c

	-DM=<max bet allowed>
	-DN=<52 * number of decks used>
	-DX=<how to seed the rand() generator>
	-DV=<void ot int>

    Usage: cmills [starting_cash]


Selected notes from the author:

    This is a blackjack program.  It does splits, doubling down,
    insurance, etc.  

    As best I can figure, it should be ANSI-compliant, as well as
    portable to BSD & sysV (as well as the irritating compiler I
    was using which assumes x=*p++ means x*=p++!).  It is
    reasonably robust in its error handling---it won't let you
    split, double, etc. unless you actually have the cash, etc.  To
    terminate the program, hit EOF or type 0 or a negative number
    for you wager.

    The way it deals with splits is particularly cool (IMHO).  You
    can split many times, and it will show all hands as they are
    played.

Copyright (c) 1990, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
