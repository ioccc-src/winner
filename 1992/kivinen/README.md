Best X Program:

	Tero Kivinen
	Helsinki University of Technology
	Klovinrinne 6b
	02180 Espoo
	Finland


Judges' comments:

    If your machine support the X Window System, Version 11:
	make kivinen

    The type of entertainment depends on number of arguments
    you have with the program.  :-)

    NOTE: Some systems do not need (or have) -lsocket -lresolv -lnsl.
	  Such systems should compile using -lX11.

    NOTE: The original winning source kivinen.orig.c assumed that
	  exit returned a value which cause problems for some
	  systems where exit returned a void.  The file kivinen.c
	  avoids this problem.
	

Selected notes from the author:

    X Entertainment Kit

    This kit includes three games from the early of video games for
    The X Window System Version 11 Release 5. It should work with
    earlier releases, though.


    Space Invaders

    The classic game of shooting aliens from outer space, trying to
    exterminate all life on earth. The game ends when the first line
    of aliens touches the ground, or destroy you. To win the game you
    must destroy all the aliens. If you evade out from the screen you
    lose.

        Controls:
                Button 1 = Move left
                Button 2 = Fire missile
                Button 3 = Move right


    Breakout

    Break all the bricks with the ball, using your paddle. If you miss
    the ball the game ends.

        Controls:
                Button 1 = Move left
                Button 3 = Move right


    Dropout

    Catch all the falling pieces, before they reach the ground. If you
    miss it, game ends. To win you must catch all 30 pieces.

        Controls:
                Button 1 = Move left
                Button 3 = Move right



    Starting the game

    The type of the game is determined by the number of arguments
    given to the program.

        no arguments = Space Invaders
        1 argument   = Breakout
        2 arguments  = Dropout
        3 arguments  = double sized Breakout
        4 arguments  = triple sized Space Invaders
        5 arguments  = triple sized Breakout
        6 arguments  = double sized Dropout
        7 arguments  = quadruple sized Breakout
        and so on...


    Scores

    The exit value of the game is your score. The smaller the score
    the better it is. The exit value of zero means you have won.


    Features

    The game has a cheat system, which can be found after examining the
    event loop at the end of program. It is not a bug, it's a feature!


Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
