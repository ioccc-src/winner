## To build:

``` <!---sh-->
    make
```

**NOTE**: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".

The author provided two alternate versions, one which adds a status bar and
another that makes it text only. The author also provided a version that they
tested with Windows.  See [Alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./toledo3 [1 | 2 | 3 [b]]
```


## Try:

``` <!---sh-->
    ./toledo3 1
```


## Alternate code:

The author provided two additional versions, [toledo3-sbar.c](%%REPO_URL%%/2006/toledo3/toledo3-sbar.c)
and [toledo3-txt.c](%%REPO_URL%%/2006/toledo3/toledo3-txt.c). Respectively these create a status bar and
make the game text only.


### Alternate build:

With the exception of the Windows version, these are built by default. To build
the Windows version, [toledo3.alt.c](%%REPO_URL%%/2006/toledo3/toledo3.alt.c), you will have to figure out
how to compile Windows code.


### Alternate use:

Use `toledo3-sbar` and `toledo3-txt` as you would `toledo3` above.

As for the Windows version, `toledo3.alt`, we presume you can open it like any
other application.


## Judges' remarks:

It's pretty obvious from looking at it what this program does,
since it's clearly spelled out in the code.  The interesting
question is whether this is easier or harder to understand than
the code for Deep Blue.


## Author's remarks:

There are so many text-based chess programs, what is that of
`A1`, `H5`, `C4`, `D5`?  The queen is really pointing to the king?

So I managed to do a graphical X11 chess program ('`WYSIAIE`', or 'What You See
Is An IOCCC Entry'). Pointing and clicking to move pieces is the only required
action, and of course the command-line options:

``` <!---sh-->
    ./toledo3        # Two-players mode (useful if you don't have a board at hand)
    ./toledo3 1      # Human white - Computer black, level 1 (fast)
    ./toledo3 2      # Human white - Computer black, level 2 (medium)
    ./toledo3 3      # Human white - Computer black, level 3 (slow)
    ./toledo3 1 b    # Human black - Computer white, level 1 (fast)
    ./toledo3 2 b    # Human black - Computer white, level 2 (medium)
    ./toledo3 3 b    # Human black - Computer white, level 3 (slow)
```

The computer will check that your moves are legal. Full legal
chess moves are allowed, except minor promotions on human side.

The game will continue up to its logical conclusion, you make
a mistake and the computer surpasses you. ;)


### WHAT ABOUT THE ENGINE

Uses an [alpha-beta](https://en.wikipedia.org/wiki/Alpha_Beta) search up to a
depth of 3+level [ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;),
extended with quiescence search, that helps playing strength, something around
1500 ELO (level 1) to 1700 ELO (level 3).

It searches the board and generates moves for each piece located.  A lot of
comparisons are used for [en passant](https://en.wikipedia.org/wiki/En_passant),
castling and promotion. Would be faster with optimizations, but that
optimizations use valuable IOCCC characters.

It plays a different game every time, using the C library random
number generator.

Because it is resource-hungry, I strongly recommend to compile it
using maximum optimization. With GCC you can use:

``` <!---sh-->
    gcc -O3 -fexpensive-optimizations prog.c -o prog -lX11
```

### KNOWN "FEATURES"

1. Because this is my second X11 program (the first was
   point n click happy face), I added sentences everywhere
   until it worked. :)

2. It is portable to Windows (using the supplied layer.c file)
   Change `#include <X11/Xlib.h> to #include "layer.c"` and
   use a Windows compiler (only tested with Dev C/C++ 4.9.9.2)
   The play level is fixed, though you can change it easily.
   Of course, this is an example of an obfuscated Windows
   program (there exists another way of write them?).

3. It will give warnings on compilation, so you can be sure
   that your compiler works.

4. It will not update the window while it is "thinking"

5. The space character has many useful applications, especially
   when it comes to the character limit (8).

6. I still don't understand what to do after semicolons. :P


### CHALLENGES

It is possible to convert this code into JavaScript with a
graphical interface.  Can you do it?

Can the evaluation function be enhanced to make the program
play stronger?


### UPGRADES

Using [toledo3-sbar.c](%%REPO_URL%%/2006/toledo3/toledo3-sbar.c) (which is too
large for this IOCCC's size rules) creates a status display about gameplay on
the window title bar.

Using [toledo3-txt.c](%%REPO_URL%%/2006/toledo3/toledo3-txt.c) turns this into
being purely text based.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
