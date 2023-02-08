Best One Liner:

    Brian Westley (Merlyn LeRoy on Usenet)
    1906 James Ave.
    St. Paul, MN  55105
    USA

    http://www.visi.com/~westley/index.html


Judges' comments:

    To use:
	make westley
	sh ./clock1

    Also try:

	sh ./clock2

    And for a good time, try:

	sh ./clock3

    Time and time again, Brian Westley seems to come up with a winner!
    We are amazed at how much is being done with only one relatively
    short line.  We think you will as well if you take the time to
    understand it.


Selected notes from the author:

    This 1-line program allows various analog ASCII clocks
    to print out the time; the ASCII clock is built from
    the command line arguments, so many different types of
    clocks can be generated.  Three different scripts are
    supplied to print out a grandfather clock, a mantle
    clock that runs backwards, and a linear-style clock.
    (they are clock1, clock2, and clock3)

    The program makes the following (possibly non-portable) assumptions:

	1) Command line strings can be written to

	2) argv[0] can be written to as if it were a long *

	3) The first three elements of the struct * returned by
	   localtime() are seconds, minutes, hours, and all are ints

	4) My sample scripts assume ASCII, though this is not
	   inherent in the code, just my sample scripts

    These assumptions are pretty reasonable. 2) can be eliminated
    by makes the code larger.

    The code is simple; the arguments passed are:

        prog minute_map hour_map hand_symbol clock_image

    The program merely takes the minute (0-59) and the hour (0-23)
    values, looks up the offsets in minute_map and hour_map
    and writes the hand_symbol for each into the clock_image
    string.  This string is then printed.

    The for() loop starts by calling time() with argv[0], so
    the time value (a long) is written into the program name.
    The for() control value is argc, which starts at 5, but
    the /=2 statement is executed before the test, so the for()
    loop is executed twice, with h=2, then h=1 (for hour & minute).

    The statement of the for() loop takes the hour or minute
    field of the struct returned by localtime() by casting it
    to an int* and dereferencing element [h].  It is slightly
    smaller to use the trick h[(int*)localtime(*m)] instead of
    ((int*)localtime(*m))[h].

    This value is in turn indexed into the hour_map or minute_map
    parameter to determine where the 'hand' symbol should be
    written into the clock_image.

    Note that the hands move in a quantum fashion; 3:59 looks
    deceptively like 2:59, since the hour hand will be at the 3
    position.  It won't move until both hands click over at 4:00.
