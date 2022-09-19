Best X11 Program:

	Teemu Rantanen
	Helsinki University of Technology
	Melkonkatu 5 A 8
	00210 Helsinki
	Finland


Judges' comments:

    To use:
	make tvr
	./tvr mode screensize/2 < colormapfile

    Try:
	./tvr 0 128 < tvr.color		(for color displays)
	./tvr 0 128 < tvr.bw		(for Black & White displays)

    Mode may be a value from 0 to 12.

    This entry requires the use of X11.  It will form two windows
    (hopefully your window mangler will ask you to place these
    your display) which you should place side by side.  Move the 
    cursor around in one of the two windows and watch what happens.

    The fractally minded may be able to detect that mode 0 does not
    calculate Mandelbrot/Julian sets correctly.  Can you find the bug?
    Better still, can you fix it without breaking something else?

    The author has provided us a spoiler version:

	make tvr.alt
	./tvr.alt altmode screensize/2 < colormapfile
    
    where altmode 1-4 correspond to mode 0-3 in the original entry
    and altmode 0 calculates Mandelbrot/Julian sets correctly.


Selected notes from the author:


		Interactive Fractals for X Window System


    This program contains 4 pairs of fractals/effects and 3 methods of
    animating them. There are two windows for a pair of fractals, one
    of which contains static fractal (eg. Mandelbrot set) and the
    other an animating one (eg. Julian set) which is derived from the
    same formula as the static one. Only one pair of fractals can be
    displayed on one process.


    To animate the fractal, you must move your mouse on the static
    fractal -window and the animated fractal will be calculated based
    on mouse coordinates. If you are on one of the two non-stable
    modes (more about them later) you can stabilize the picture by
    pressing a mouse button. Pressing it does nothing on stable mode.



    The three modes are:
      - non-stable mode with simple 'attractor searcher'
      - non-stable mode
      - stable mode

    On Mandelbrot/Julian mode the stable mode calculates normal Julian
    set according to the Mandelbrot coordinates (mouse position). On
    non-stable modes the picture slowly transforms to the same picture
    as on the stable mode but transformation can take some
    time. Usually, and especially if changes are relatively small
    between mouse movements or frame rate is high, the non-stable mode
    makes much more interesting effects IMHO. The difference between
    2 non-stable modes is that the first tries to stabilize
    picture. It doesn't stabilize much, but it helps on some cases
    quite a lot. One notable case where help can be seen is when you
    first move your mouse to non-black areas of Mandelbrot set, then
    back to near the center. On some cases 'attractor searcher' can be
    seen as noise.


    First of the fractal pairs is Mandelbrot/Julianset as mentioned
    before. Second is a variation of that. Third makes nice
    3d-look-a-like effects and fourth is variation of that with more
    nice effects.



    Usage:
              tvr mode screensize/2 < colormapfile

    The first parameter is the operating-mode of the program. There
    are 4 fractal pairs, 3 display modes, making total of 12
    modes. Screensize is half of the actual screenlength/width. ie. If
    you use 128 as a second parameter, you will get two 256x256
    windows.

    Program needs reasonable values for both of these parameters to
    operate. Good first try could be "0 128" or "8 128". Colormap has
    to be piped into the programs standard input.

    Note that you will need approximately (secondparameter^2)*64 bytes
    of free main memory or machine will swap heavily (memory
    references are quite random and may confuse paging algorithms
    easily).  This means that for 512x512 windows you will need 4M of
    memory.


    Colormapfile:

    This is the file from which program reads colors for screen
    colormap. First line of the file must be a number between
    3..254. This informs the program how many colors there are to be
    expected. This is also the maximum number of iterations used on
    picture calculations. Lines after that are X11 color
    names. Program expects to find, and uses, the number of colors
    reported on first line.

    There are 2 colormapfiles to start with. One with colors and
    another with only black and white. If you have enough colors on
    your display you can use the one with colors (even on
    grayscale). The other is meant mainly for 1 bitplane display
    (on which the picture looks terrible compared to 8 bitplane
    display).


    Compilation:

    You should compile this entry with optimizing compiler with the
    highest level of optimization possible. You will also need an ansi
    compatible compiler (gcc -ansi -pedantic will do fine).



    This entry has been tested on wide variety of machines including:

	 Machine	       OS
	 -------               --
	 Decstation 5000/240   Ultrix 4.3A
	 DECAlpha 3000/300     OSF/1 v1.3 and v2.0
	 IBM RS6000	       AIX v3
	 SPARCStation IPX      SunOS 4.1.3
	 i486		       Linux v1.1.8  (binarysize 3576 bytes
				              using gcc -O6 -s -N ;)
	 HP 9000/730	       HP-UX

    Also, many of X-server and Xlibrary version have been tested and
    the program should be highly portable. Program may slow down
    considerably on machines where table references are slow as the
    program makes extensive use of them. Also, due to the huge amount
    of data sent to the X-server, considerable slowdown can be noticed
    if the Xserver is slow or especially if the connection between the
    Xserver and the client is slow. (Don't try this on 9600 bps modem
    line. I did ;)


    Obfuscation is done on different levels. Almost none of it is made
    at the macro level, so cpp:ing the code won't give you
    much. Perhaps most notable is the algorithmic obfuscation. Simple
    formula has been turned into something completely different. Also
    it may be a surprise to find out which piece of the code
    calculates non-stable fractals and how it does that. Many
    obfuscations were left out of the program because speed of
    animation was one of the key issues. Well, obfuscated or not,
    some of the effects are very nice ;)


    Memory refreshment:

	   Mandelbrot set is calculated from formula

			     2
		      Z   = Z  + Z
		       n+1   n    0

           and Julian set is calculated from formula

			     2
		      Z   = Z  + C
		       n+1   n

	   where C is the same throughout the picture.  Both
	   calculation are finished when |Z| >= 2.0.  For the other
	   fractals, the basic methods are the same but formula is
	   different (look from the source ;)

	   Note that Mandelbrot and Julian on this program aren't
	   exactly correct. Find out why ;)


    Bugs:

      - No error checking. If DISPLAY is not set program dumps core.
        This may also happen if a request of some of the resources
        fails. eg. getting colors.

      - No expose event handling

      - It may be possible that the program starts drawing before
        window is mapped as there is no XSync(). In that case drawn
        data is lost. Also, some window manager configurations places
        the second window on top of the first and and again drawn data
        will be lost. By default, windows are placed next to the other
        in the topleft corner of the screen.

      - Zooming is not possible

      - Eats LOTS of memory on BIG pictures. Also lot's of CPU.

      - Under mode 0, the boundary condition is not checked properly.
	The condition |Z| >= 2.0 should be checked exactly (by comparing 
	x*x+y*y with 2*2), or else artifacts are introduced.  The result
	of this error is a "bubbly" appearance (at least in mono).

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
