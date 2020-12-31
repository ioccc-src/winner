Best Object Orientation:

    Alan De Smet
    8531 Greenway Blvd. #206
    Middleton, WI 53562
    USA

    http://www.upl.cs.wisc.edu/~chaos/


Judge's Comments:

    To build:

	make chaos

    To use:

	./chaos

    This is the authors first IOCCC entry.  We thought the entry was
    a nice example of a compact collection of obfuscations.

    Can you figure our why, in some cases, it wants to read itself?

    Some systems do not implement halfdelay() in their libcurses.
    You might try compiling with -lncurses of you have that library.
    Or you can build this entry without the halfdelay() call by:

	make chaos_nohalf


Selected Author's Comments:


    * Usage

    The executable takes a single argument for the data file to use.
    If no argument is given, it will find a data file by itself, don't
    worry about it...


    * Summary

    This is a simple ncurses 3D object viewer. The keys 'y', 'u', 'i',
    'h', 'j', and 'k' rotate.  'a' and 'z' zoom in and out.  'q' quits.
    Given about 3 seconds of no input, it will start rotating until
    interrupted by user input.


    * Features (aka Bugs):

    Memory malloced is never freed.  This shouldn't be a big deal,
    since only one block is ever allocated, and the OS should recover it.

    My local flavor of lint doesn't seem to like the fact that I never
    "return" from main.  Feh, what does it know?  Otherwise, ignoring
    lint's over protectiveness ("Of course I'm not using all of the
    functions defined in curses.h!"), it's lint clean.

    If the compiler happens to generate the byte sequence "AlWuzEre"
    in the executable by chance, the program may be unable to locate
    the embedded string.  As a result, running the program without an
    external data file may act in undefined ways.

    If the compiler doesn't store char * P's data in a nice contiguous
    stream, it would be bad.  As above, it would break running the
    program without an external data file.

    If the incoming data is corrupt, the results are undefined.
    (Although dumping core is a popular result.)

    When a point passes behind the camera, it is still plotted.
    The object will "bounce" off the camera, but the result (some points
    in front, some reflected from the rear) looks really odd.  And it
    sometimes hangs.  So just don't fly through objects.  You'll be
    happier.
