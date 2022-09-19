Worst Abuse of the C Preprocessor:

	Brian Westley (Merlyn LeRoy on Usenet)
	Digi International
	1906 James Ave.
	St. Paul, MN  55105
	USA


Judges' comments:

    To use:
	make westley
	./westley

    But for something more interesting try compiling it with
    different cc arguments.  For example:

	cc -Describe -Door westley.c
	cc -Describe -Drain westley.c

    Not all compiler errors are bad.

    For spoilers see the end of the notes from the author below.

		
Selected notes from the author:

    This program, in accordance with the rules, compiles into a legal
    C program without human intervention.  However, it simply compiles
    into "main(){}", which does nothing and exits, so you don't need
    to actually compile the program.

    This program is a simple adventure game which uses only C preprocessor
    error messages (for missing #include files) as output.  To begin,
    try to compile the program with no options:

    cc westley.c

    This will fail, producing an error message for a missing #include
    file as the opening description.  Your terminal should be set for
    80 columns, 8 character tabs, and wraparound, as there is no way
    to reliably output newlines.  You should see something like this
    (text massaged to change wraparound to separate lines):

    westley.c
    westley.c(87) : fatal error C1024: cannot open include file '

     You are in a debris-filled
      dungeon; a door bars the
      way, and sludge trickles into
      a floor drain

     '
    Your compiler error message will vary, but the important part is the
    missing include file name, which functions as the game text.

    To "do" things, all words must start with "-D".  For example, to
    look at the door, do:

    cc -Describe -Door prog.c

    ...and you will get another error message telling you about the door.
    (note: some compilers will stop after the first missing include file,
    while others will continue to try compiling; the latter will repeat
    the opening message each time, as if you are playing an adventure game
    with "verbose" turned on).

    The goal of the game is to escape the dungeon.

    Here is a walk-through for the game, including a few dead-ends:
    ---SPOILER---
    
    -Describe -Door
    -Describe -Drain
    -Describe -Dwarf
    -Describe -Debris (or -Dungeon)
    -Describe -Desk
    -Describe -Dime
    -Describe -Directory
    -Dial -DUNgeon0614
    -Drink -Daiquiri
    -Drop -Daiquiri
    -Drop -Dwarf -Daiquiri (or -Drop -Down -Daiquiri)
    -Describe -Document
    -Depress -Dotted -Dog
    -Depress -Dalmatian (also accepts "Dalmation" [sic])
    -Deposit -Dime
    -Drop -Donut
    -Drop -Donut -Down -Drain (or -Drop -Dwarf -Donut)
    (at this point, you win!)

    Note that the game has no real state information; you can type these
    commands in any order, at any time.  Also note that word order is
    unimportant.

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
