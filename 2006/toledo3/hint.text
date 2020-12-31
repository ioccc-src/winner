# Most Portable Chess Set

Oscar Toledo
Av. Santa Cruz del Monte 9-304
Ciudad Satelite. Edo. de Mexico
CP. 53110
Mexico

## Judges' Comments:

### To build:

        make toledo3

NOTE: You may have to alter the paths suitably, and you do need X. Modify the makefile as needed.

### To run:

        ./toledo3 1

It's pretty obvious from looking at it what this program does,
since it's clearly spelled out in the code.  The interesting
question is whether this is easier or harder to understand than
the code for Deep Blue.

## Selected Author's Comments:

There are so many text-based chess programs, what is that of
A1, H5, C4, D5?  The queen is really pointing to the king?

So I managed to do a graphical X11 chess program (WYSIAIE, or
What You See Is An IOCCC Entry), point'n'click to move pieces
is the only required action, and of course the command-line
options:

        ./toledo3        Two-players mode
                                (useful if you don't have a board at hand)
        ./toledo3 1      Human white - Computer black, level 1 (fast)
        ./toledo3 2      Human white - Computer black, level 2 (medium)
        ./toledo3 3      Human white - Computer black, level 3 (slow)
        ./toledo3 1 b    Human black - Computer white, level 1 (fast)
        ./toledo3 2 b    Human black - Computer white, level 2 (medium)
        ./toledo3 3 b    Human black - Computer white, level 3 (slow)

The computer will check that your moves are legal, full legal
chess moves are allowed, except minor promotions on human side.

The game will continue up to its logical conclusion, you make
a mistake and the computer surpasses you. ;)

### WHAT ABOUT THE ENGINE

Uses an alpha-beta search up to a depth of 3+level ply, extended
with quiescence search, that helps playing strength, something
around 1500 ELO (level 1) to 1700 ELO (level 3)

It searches the board and generates moves for each piece located,
a lot of comparisons are used for empassant, castling and
promotion. Would be faster with optimizations, but that
optimizations use valuable IOCCC characters.

It plays a different game every time, using the C library random
number generator.

Because it is resource-hungry, I strongly recommend to compile it
using maximum optimization, on GCC you can use:

        gcc -O3 -fexpensive-optimizations prog.c -o prog -lX11


### KNOWN "FEATURES"

1. Because this is my second X11 program (the first was
   point'n'click happy face), I added sentences everywhere
   until it worked. :)

2. It is portable to Wind*ws (using the supplied layer.c file)
   Change #include <X11/Xlib.h> to #include "layer.c" and
   use a Wind*ws compiler (only tested with Dev C/C++ 4.9.9.2)
   The play level is fixed, though you can change it easily.
   Of course, this is an example of an obfuscated Wind*ws
   program (there exists another way of write them?)

3. It will give warnings on compilation, so you can be sure
   that your compiler works.

4. It will not update the window while it is "thinking"

5. The space character has many useful applications, specially
   when it comes about the character limit. 8)

6. I still don't understand what to do after semicolons. :P

### CHALLENGES

It is possible to convert this code into Javascript with a
graphical interface.  Can you do it?

Can the evaluation function be enhanced to make the program
play stronger?

### UPGRADES

Using toledo3-sbar.c (which is too large for this IOCCC size
rules) creates a status display about gameplay on the window title bar,

Using toledo3-txt.c turns this into being purely text based.
