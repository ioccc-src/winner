Most Fun:

    David Lowe				Neil Mix
    Pootpoot				Pootpoot
    67-D Manchester Street		1490 Sacramento Street #4G
    San Francisco, CA 94110		San Francisco, CA 94110
    USA					USA

    http://pootpoot.com/


Judge's Comments:

    To build:

	make dloweneil

    To use:

	./dloweneil

    Read the the Author's comments below.  We believe that your experience
    may mirror one of our experiences:

	Originally, I didn't appreciate the game.  Then I actually read the
	description of the controls.  I started playing.  I struggled.
	I spelled my first "poot".  I was hooked ...


Selected Author's comments:

    Usage:
	pootris [X size of board] [Y size of board]

    Synopsis:
     The object of this game is to spell "POOT" as much as possible.  There
     is no time pressure.  You're given one letter at a time (sort of randomly
     chosen from the set 'P', 'O', and 'T') and you get to move it freely
     around the border of the playing board, and decide when and where to drop
     it into the board.  Sound easy?  Of course, there's a catch...

    Controls:
     . Only three controls:
        'a' moves the current letter one position counterclockwise around
            the border of the playing field.
        's' moves the current letter one position clockwise around the border
            of the playing field.
        'd' drops the current letter onto the board.
     . To quit, send a fatal signal to the process.

    Rules of motion:
     . The different letters move in different directions once dropped onto
       the board:
        'P' moves diagonally, at a 45 degree angle and in a clockwise
            direction around the board once dropped.
        'O' moves in a straight line perpendicular to the border from which
            it is dropped.
        'T' moves diagonally, at a 45 degree angle and in a counterclockwise
            direction around the board once dropped.
     . The letters bounce off the top and sides of the board.  They bounce
       in a 'natural' way, with the exception that 'O's will fall straight
       down if they hit a side wall.
     . The letters stop when they hit another letter or the bottom of the
       board.

    Rules of spelling:
     . When you spell 'POOT' on the board, in any direction, the letters
       comprising the word will disappear, and any letters which may have
       accumulated above the disappeared letters will 'fall'.
     . Letters can be used in multiple spellings of 'POOT'.
     . Chain reactions are possible.

    Rules of scoring:
     . You get one (1) point for each letter you drop onto the board.
     . You get a bunch of points for spelling 'POOT'.  More if you spell
       it in more than one way simultaneously.

    Some of the obfuscations:
     . Several different coordinate systems are used.  There's the "real" X
       by Y system used for curses, the "inside the box" X by Y system used
       for moving things around and finding instances of "POOT" inside the
       box, and the position of the current letter, which is a single value
       from 0 to 2 * xsize + 2 * ysize - 1.
     . The fact that x%3 is a perfect hash function for x values 'P', 'O'
       and 'T' is used.
     . Of course, the code is as hideous as possible, and spells poot for
       fun (It's also exactly 3217 bytes in length, with exactly 1536
       counted characters for purposes of this contest.)
     . Love that modulus operator!  Mmmm...
     . There are some equations used which are really unnecessarily ugly,
       which served the dual purposes of compacting the code and making it
       trickier to understand.  I'm thinking of the equations used to convert
       between coordinate systems when dropping pieces into the game board.
     . Simple and silly ones: short, meaningless (and sometimes misleading
       (see 'x')) variable names; hard-coded ASCII numeric values used for
       character constants; using goto for fun and profit; reusing and
       re-purposing variables in different places.
     . The game itself is simple, but still weird and quite difficult.

    Some things I wish I could have fit into this, but didn't have the space:
     . Seeding the random number generator (doh!)
     . Something to detect when the game is over.
     . Some kind of scoreboard.
     . Sound.
     . Some way of quitting gracefully.

    Good Luck!
