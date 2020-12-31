# Best way to lose a life

J. David Lowe  
434 Tenney Drive  
Rogue River, OR  
97537  
<j.david.lowe@gmail.com>  
<http://www.pootpoot.net/>  


## Judges' comments:
### To build:

    make dlowe

### To run:

    ./dlowe

### Try:

    ./dlowe
    # Watch for a while if you like, then press a key within the window
    # Use up and down keys to escape death

### Selected Judges Remarks:

The judges lose playing this game. This entry wins!

OS X users running Mountain Lion and later will need to download and install:

	http://xquartz.macosforge.org/landing/

Q: How did we get past the variadic macro problem on a Mac?

A: Don't use -pedantic-errors in the Makefile.


## Author's comments:
# Conway's Game of DEATH

This is a challenging, fast-paced arcade game, based on the famous Game of
Life.

## Story

In the game, you are Mr.C, a lightweight spaceship making a futile dash for
escape from the rigid rules and predictability of life in the B3/S23 universe.

Use the up and down arrow keys to steer: collisions are fatal for Mr.C! Learn
to spot incoming gliders, skim the surfaces of beehives and blocks, and give
blinkers plenty of space. Things get crazier as Mr.C picks up speed... can he
escape?

No. There is no winning. Sadly for Mr.C, this universe goes on forever. Just
see how far you can make it!

Press 'q' any time to quit.

## Features

* casual gameplay
* infinite, procedurally generated universe
* progressive difficulty
* animated splash screens

## Limitations

* Flicker, especially at high speeds, and in spite of "double-buffering" (X11
  doesn't make it possible to lock drawing to the display refresh rate.)
* Cannot be run outside of the directory containing the data files (splash.d,
  dead.d and sprites.d).
* Cannot build or run without X11 (or an X11 compatibility layer).

## Wish List

* Score keeping
* Color
* In-game instructions
* Sound

## Hosts Tested

* Darwin 10.8.0 i386 (clang 1.6 and gcc 4.2.1)
* Linux 2.6.32 i686 (clang 1.1 and gcc 4.4.3)
* Linux 3.2.0 x86\_64 (clang 3.0 and gcc 4.6.3)

## Obfuscations

The code is formatted into a 14-cell shape which will evolve into a glider in
19 generations.

Lots of globals, including a global struct whose members have the same names
as global variables.

Global variables getting reused in different contexts.

Huge and convoluted expressions, abusing ternary operators and operator
precedence.

Lots of magic numbers, abuse of the relationships between magic numbers, and
abuse of the arithmetic properties of magic numbers.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
