Best X11 Entry:

    Jon Thingvold
    University of Oslo
    Gaustadveien 10B
    N 0372 Oslo
    Norway

    http://www.uio.no/~jonth/


Judges' comments:

    To use:
	make jonth

	./jonth

    Also try:

	./jonth host1:0 host2:0

    NOTE: You may need to change the Makefile depending on where X11
	  include files are found and what libs are required.  For
	  example Solaris and Slowlaris need -lsocket.  :-)

    For extra credit, figure out how you can cheat by taking over
    a square already occupied by an opponent.


Selected notes from the author:

    This is mulituser tictactoe for X Windows. You may give one or two X
    displays as arguments to this game.
    
    Known bugs:
    
    Sometimes on Solaris X gets confused and this program core dumps,
    solution: give two display arguments (prog host:0 host:0)
    
    If one (or both) windows look like a copy of the window(s) below,
    try xrefresh command.
    
    Have a nice(1) day.
    
