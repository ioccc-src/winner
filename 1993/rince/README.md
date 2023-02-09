Most Well Rounded:

	James Bonfield
	MRC Laboratory of Molecular Biology,
	Hills Road,
	Cambridge,
	England


Judges' comments:

    To run:
	make rince
	rince [cabbage]

    where:
	[cabbage]	a CABBAGE description file  (default: rince.c)
    
    The author has provided several CABBAGE files for your amusement:

	rince.data1	plays breakout.  Keys are ',' for left, '/' 
			for right, and '.' for 'fire the ball'.

	rince.data2	plays the old rince game from IOCCC 1991

	rince.data3	Sokoban screen 11. You are the 'o' character. You 
			must push the money 'm' into the dotted region of 
			the screen. The game is considered finished when 
			all the 'm's are then 'M's.

	rince.data4	Sokoban screen 13. Same rules as above.

    For a brief design description, see rince.design.

    The select(2) from SunOS says:

	BUGS

	...

	select() should probably return the time remaining from  the
	original  timeout,  if  any,  by modifying the time value in
	place.  This may be implemented in future  versions  of  the
	system.   Thus,  it  is  unwise  to  assume that the timeout
	pointer will be unmodified by the select() call.

	Systems such as Linux does return the remaining time in timeout
	field (0 if no keys were pressed), but `rince' assumes that
	timeout remains unmodified.

	It has been suggested that:

	    select(k,&y,0,0,&v)
	
	should be replaced with:

	    select(k,&y,0,0,(v.tv_usec=1<<whatever_you_want,&v))
	
	where whatever_you_want is some integer such as 17 or 19.

    WARNING:

	If you are running SunOS 4.1.x (assuming you can find an ANSI
	compiler in the first place), this program may be used to log
	out very quickly.  Unfortunately, you can't do anything else
	with it.

	Some people may want to slow down the game by increasing the
	value 17 in the line:

	    struct timeval v= {0,1<<17} ;
	
	to something like 18 or 19.

	One may also need to do a "stty sane" if you kill the program
	to restore your terminal state.

	Some people report that rince dumps core on their system.

	On some systems that use gcc, the curses.h used by gcc
	(typically /usr/local/include/curses.h) is not compatible with
	the curses library (typically /lib/libcurses.a) used.  It has
	been suggested that the following gcc command may help:

	    gcc -fno-builtin -I/usr/include -o rince rince.c -lcurses -ltermcap
    

Selected notes from the author:

    This is a Cellular Automata Based, Beautifully Abysmal Game Environment (or
    CABBAGE for short). To execute the program simply type 'jkb gamefile',
    where `gamefile' is a game description file. A couple are supplied for
    your enjoyment. Alternatively, with no arguments it will default to using
    it's own datafile (the source code infact). This happens to be a game of
    space invaders. To prevent people from firing too often a very simple
    method is employed; you must move after firing to be able to fire again.

    Keys are:   Left  :	j
    		Right :	l
    		Fire  :	k

    This is a new breed of generic games. For instance:
    Game play   : Whatever you define
    Keys        : Whatever you define
    Score       : If you can figure out how to update it!
    Levels      : Ahh well... it's not *totally* generic.

    The proper definition for usage would be:
    jkb [data_filename]

    Portability
    -----------

    I have compiled in on the following systems:

    System              OS              Compiler        
    -------------------------------------------------------------------------
    DECstation 5000/240 Ultrix 4.2A     c89 -std
    SPARCstation 1+     SunOS 4.1       gcc -ansi -pedantic
    SPARCstation 10/31  Solaris 2.1     gcc -ansi -pedantic     (*)
    DECAlpha 3000/500   OSF/1 V1.2      c89 -std
    SGI Indigo (R4000)  IRIX 4.0.5F     cc -ansi
    Alliant FX2800      Conentrix 3.0.0 fxc

    (*) I never said it worked! The guidelines state that you dislike programs
        that won't *compile* under both BSD or SYS V Un*x. This compiles, and
        indeed runs on all the others (both BSD and SYS V) correctly.

    Alas, on Solaris it compiles, but mysteriously stops displaying output
    after a while until you quit with control C, when it all catches up again.
    I think the problem may lie in either select(), or curses, (or perhaps
    conflict of the two).

    The use of select() no doubt makes it less portable to STRICT system V
    machines. However I have tested this on several so-called system V
    machines, and all of them support select(). In fact, the select() they
    support appears to be more portable between them than their poll() call.

    Obfuscation details
    -------------------

    I have tried to use as many different obfuscation techniques, including
    some of which (such as sizeof confusion) I have not seen in any winners
    (hmmm - perhaps there's a reason for that...) so far. Also, very poor
    structure (yes, I use goto's) has lead to apparently having an fgets() as
    the last line of main. Note that I have still tried to aim at least some
    efficiency (provided it makes things slightly more obfuscated of course).
    One such thing is the way I dynamically allocate a 2-dimensional array
    using only ONE malloc(). Hence this program could be used as a tutorial
    for all those people who consistently ask this question in the C
    newsgroups.

    Also, the program does require a volatile type (especially when
    optimising) to perform correctly. This is the first time I have ever
    truly needed this when not accessing memory external to this process :-)

    Of course, all the usual obfuscation lurks within, such as combining
    multiple for loops into single ones; warped and twisted logic; plus a
    plethora of other minor oddities. It's up to you to discover some of them
    of course... Sometimes I have sacrificed length for obfuscation. It is all
    too easy to change the arguments in main to one character identifiers, but
    in my opinion they add to obfuscation in this case by being longer.

    Lint complains about lots of things. Firstly the use of curses immediately
    makes lint complain. The Alpha's lint gave me some positive encouragement!
    'precedence confusion possible: parenthesize!' :-) :-)
    main() does not return correctly, because, basically, it doesn't return.

    Bugs
    ----

    Very little error checking is performed. I do check for not being able to
    open the requested filename and return 1 upon failure. However, badly
    formatted data files will cause major problems. No other checking (such as
    insufficient memory) is performed.

    There is no 'end of game' checking method. Hence games like sokoban rely
    on the user to decide when they have had enough. Also, there is no quit
    mechanism other than control C.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
