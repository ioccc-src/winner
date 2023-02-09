Best X11 Graphics:

	David Applegate			Guy Jacobson
	School of Computer Science	AT&T Bell Laboratories
	Carnegie Mellon University	600 Mountain Avenue
	Pittsburgh PA 15213		Murray Hill NJ 07974
	USA				USA


Judges' comments:

    Make and run as follows:

	make davidguy
	davidguy ip_address:server.screen

    where 'ip_address' in an IP address of an X server.  For example, try:

	davidguy 127.0.0.1:0.0

    Of course, may need to supply a more reasonable address.  :-)

    Also try:

	cp davidguy guydavid
	guydavid 127.0.0.1:0.0

    Can you determine why this makes a difference.

    We permitted this type of entry to win because:

	- it did not require X to be on the host system
	- both BSD and SVR4 have sockets
    
    Now that X11 and sockets have become 'standard', we plan to open
    up the contest to programs that use them.  Future rules will
    explain this further.

    We are pleased that this entry has helped bring new 'life' into
    the contest.

    NOTE: The orignal program that won may be found in davidguy.orig.c.
	  The author supplied a second version of the program, which
	  we have placed in the default location davidguy.c.
 

Selected notes from the authors:

    The program is a fully-functional X client.  It talks directly to
    the X server through a socket without using Xlib, Xt or any other
    wussie toolkit junk.  With no arguments, it will try to run
    locally using the unix-domain socket (only on BSD :-( ) or you can
    give it a command line argument identifying a display host address
    (in dotted octet notation, like 127.0.0.1:0.0) where the X server
    is running.  It handles color and monochrome displays, and
    performs whatever byte-swapping and bit-reversal is needed (so
    that the program works even when the server and the client have
    different architectures).  It buffers communication to the X
    server for efficiency.

    [[ NOTE: The original source in davidguy.c used only an IP address
	     argument (assumed :0.0) and assumed the color of black
	     and white. ]]

    The program doesn't require any user interaction; you can just sit
    back and watch it run.  All the action takes place in the root
    window of the display.

    We think the program is interesting for these reasons:

	1) It belongs to a class of programs that programmers make 
	   the following complaints about:  they require a mountain 
	   of code to implement even the simplest program; and they 
	   must be linked with giant libraries of hard-to-understand 
	   functions.  In contrast to these complaints (made by wimps,
	   in our humble opinion), our program fits in under 1536 
	   bytes, doesn't need any external functions except for a few 
	   system calls, and doesn't need to include any header files.

	2) It implements an extremely efficient algorithm for the 
	   computation it performs.  One cool feature of the algorithm 
	   (at least as far as this contest is concerned) is that its 
	   obscurity is fundamentally necessary for its efficiency.  
	   In other words, even if we took steps to present the algorithm 
	   clearly, (we haven't) the relation of the computation performed 
	   to the specification of what the program was supposed to do 
	   would still be hard to understand.

    Quasi-spoiler on internals:

    The program plays Conway's game of Life in the root window's
    background pixmap.  It starts by setting the background to random
    bits, and then plays Life, with one Life cell for each pixel of the
    screen.  In the game of Life, a cell survives to the next round if
    2 or 3 of its 8 neighbors are also alive, and a cell is born if
    exactly 3 of its neighbors are alive.  Otherwise, a cell dies of
    exposure if it has only 0 or 1 neighbors, and dies of overcrowding
    if it has 4 or more neighbors.

    The algorithm used to compute the next generation is based on the
    observation that a cell's state in the next generation is a boolean
    function of its current state, and the states of its 8 neighbors
    (ie, a boolean function from 9 bits to 1 bit).  This function can
    be computed by a boolean circuit.  In addition, intermediate values
    computed by the circuit can be shared between neighboring cells,
    reducing the number of gates per cell required.  These ideas
    have been used before, to compute the next generation through a
    series of bit blits.  Instead of doing this, we map values in the
    circuit to bits in registers, so that the next generation can be
    computed efficiently within registers, minimizing memory accesses.
    As a result, the computation of the next generation is performed
    with about 1.6 instructions per life cell, consisting of .125
    memory accesses, .17 shifts, and 1.3 logic operations.  The net
    result is that the time to transfer the bits to the X server, and
    for the X server to draw them on the screen, dominates the time to
    compute the next generation.

Copyright (c) 1991, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
