Best X11 Game:

    Daniel Vik
    926 Genter Street
    La Jolla, Ca 92037
    USA

    http://www.vik.cc/


Judges' Comments:

    To build:

	# you may have to edit the Makefile to set X11_LIBDIR correctly
	make vik1

    Try:

	# requires an X11 server
    	./vik1
	./vik1 a
	./vik1 d2
	./vik1 ad3

    Danial Vik has presented a tour de force feature rich X11-based
    racing game that fit within the contest size limits.  Take a
    glace at the feature list he provided below.  Amazing!

    Happy touring on the road and in the code!


Selected Author's Comments:

    Features
    ========

    This program is a complete car race game with a lot of nice features:

       *  Drive on a road in a 3-d landscape with hills and curves

       *  Mountains in the horizon

       *  A sun in the sky when driving during the day.

       *  Dark sky and reduced visibility when driving at night.

       *  Snow when driving in the winter.

       *  Slippery road when driving in the winter.

       *  When driving off the road, the car slows down to a halt

       *  Three different race tracks that takes about one minute to
          complete.

       *  Speed meter.

       *  Computer driven opponent cars.

       *  Collision detection when driving into other cars.

       *  Lap time measurement.

       *  The best lap time is stored as reference.


    Build and Run
    =============

    Compile the source code and link x libraries if necessary.
    The program takes  three  options which have  to be  typed in a specific
    order as described below.

          Usage: vik1 ['a']['d'][#]

             a   - Advanced racing in a winter landscape
             d   - Racing in at night in the dark
             #   - Race track selection 1-3 are valid numbers

    Here are a few examples:

          Command line:               Description:
          $ ./vik1                    Run track 1 at daytime in the summer
          $ ./vik1 a                  Run track 1 at daytime in the winter
          $ ./vik1 d                  Run track 1 at night in the summer
          $ ./vik1 3                  Run track 3 at daytime in the summer
          $ ./vik1 d3                 Run track 3 at night in the summer
          $ ./vik1 ad2                Run track 2 at night in the winter

    Note that the  order  in which the  argument  characters are  entered is
    important. It is for example not possible to type ./vik1 da. (Well it is
    possible, but the result will not be as expected.)

    The space key  accelerates  the car.   Releasing  the space  key  slowly
    reduces the speed.  The left and right  arrow keys are used to steer the
    car.


    Obfuscation
    ===========

    The main obfuscation  is the fact that the program is extremely compact.
    There are a few things  I didn't want to do,  e.g. define #define  to a
    single letter to save some space, or to remove casts to save some space.

    The program  uses a lot of variables.  In fact, all letters a-z are used
    and most letters A-Z.

    The constants are chosen very  carefully and thy have multiple purposes,
    e.g. a constant can be both the length of the track and a color.

    Most of the code is kept  inside five for loops  without body.  Each for
    loop  does many things.   One for  loop draws  all cars  by restarting a
    couple of times. Another draws the road, mountains, and the sun.

    Main is called recursively.  The return value  and output depends on the
    arguments. main can return the current time, draw lines and of course be
    the entrypoint of the application.

    The program  frequently  uses the ? operator mainly to save space but it
    makes the program more obscure.


    Compiler warnings
    =================

    There  are no compiler warnings when compiling with -ansi  but there are
    quite  many  warnings from lclint.  Mainly because  the program  is very
    optimized for code size.


    Limitations
    ===========

    The program only compiles and runs on X based systems.

    The program requires a display with 24 bit color depth.  It  also assumes
    that the byte order of the colors  are as on my Linux PC.  That is,  The
    colors are represented  by a 32 bit value where the bytes  (from high to
    low) are { 0, RED, GREEN, BLUE }.

