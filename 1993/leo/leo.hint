Best Game:

	Leonid A. Broukhis
	Moscow Centre of SPARC Technology
	123481 Liberty St.,
	89-1-95 Moscow
	Russia


Judges' comments:

    To make:
	make leo

    To have the computer guess:
	leo [colors]

    To guess the computer's number:
	mind [colors]

    where:
	colors		number of possible colors (1 to 15) (default: 6)
    
    By default, the number of colors if 6.  You may specify a
    value of between 1 and 15 colors.  See the author's notes
    for instructions of how to play.

    We look forward to more entries from the newer members of the 
    International Internet community.

    On some systems, you may need to remove the line:

	#include <malloc.h>
    
    or replace that line with:

	#include <sys/types.h>
	#include <sys/malloc.h>

    to successfully build this entry.


Selected notes from the author:

    This program plays mastermind, if you call it by a name ending by
    'd', otherwise it _solves_ mastermind. Call it without parameters
    to use 6 digits (colors), or indicate the number of possible digits
    (you cannot change the number of positions so easily).

    The number in parentheses is the number of possible combinations,
    based on previous questions and answers.  If you solve the puzzle,
    "(1)" indicates that your previous moves are enough to give correct
    answer.  If the program acts as solver and terminates prematurely,
    it means that you have mistaken in your answers to its guesses.
    Question marks indicate the number of digits you have to enter
    (either 4 when you guess or 2 when computer guesses).

    Note that the program uses the same code for both player and
    solver, and the only place where it makes difference is the
    interactive part. Many obfuscations have been made to achieve
    this.  An expression giving (bulls * 16 + cows) from two numbers
    is, however, quite straightforward :-) , as well as the arithmetic
    of binary coded colors-base numbers is.

    Limitations: maximum number of digits (colors) is 14 (1..F).

    Suggestions: Use terminal (or emulator) with non-destructive
    backspaces. Do "disable scrolling" on cmdtool or similar emulators.

    Bugs: Please don't type ^D at the prompt!!

    EXAMPLE: Suppose we think of 1234:

    judges-385> leo
	(1296): 6433
	?? 12       # one 3 is a bull, another is a cow, and 4 is a cow
	(160): 5363
	?? 02       # both 3's are cows
	(21): 4231
	?? 22       # 2 and 3 are bulls, 4 and 1 are cows
	(2): 4132
	?? 13       # 3 is a bull; 1, 2 and 4 are cows
	(1): 1234
	?? 40       # you may enter everything there

    EXAMPLE: Guess the computer's number:

    judges-387> mind
	(1296): ???? 1122   # my strategy isn't the best, just as example
	00
	(256): ???? 3344
	20
	(18): ???? 5566
	02
	(6): ???? 3654
	11
	(2): ???? 3355
	00
	(1): ???? 6444
	40		   # we have guessed the number

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
