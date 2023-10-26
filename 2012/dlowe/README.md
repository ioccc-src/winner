# Best way to lose a life

J. David Lowe\
US
<j.david.lowe@gmail.com>\
<https://github.com/dlowe>

## To build:

```sh
make
```

NOTE: this entry requires `X11/Xlib.h` header file and the X11 library to
compile. macOS users running Mountain Lion and later will need to download and
install [XQuartz](https://www.xquartz.org) in order to compile and run this
entry.

## To use:

```sh
./dlowe
```

## Try:

```sh
./dlowe
```

Watch for a while if you like, then press a key within the window.

Use up and down keys to escape death.

## Judges' remarks:

The judges lose playing this game. This entry wins!

Q: How did we get past the variadic macro problem on a Mac?

A: Don't use `-pedantic-errors` in the Makefile.


## Author's remarks:

### Conway's Game of DEATH

This is a challenging, fast-paced arcade game, based on the famous [Game of
Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

### Story

In the game, you are Mr.C, a lightweight spaceship making a futile dash for
escape from the rigid rules and predictability of life in the B3/S23 universe.

Use the up and down arrow keys to steer: collisions are fatal for Mr.C! Learn
to spot incoming gliders, skim the surfaces of beehives and blocks, and give
blinkers plenty of space. Things get crazier as Mr.C picks up speed... can he
escape?

No. There is no winning. Sadly for Mr.C, this universe goes on forever. Just
see how far you can make it!

Press `q` any time to quit.

### Features

* casual gameplay
* infinite, procedurally generated universe
* progressive difficulty
* animated splash screens

### Limitations

* Flicker, especially at high speeds, and in spite of "double-buffering" (X11
  doesn't make it possible to lock drawing to the display refresh rate.)
* Cannot be run outside of the directory containing the data files (splash.d,
  dead.d and sprites.d).
* Cannot build or run without X11 (or an X11 compatibility layer).

### Wish List

* Score keeping
* Color
* In-game instructions
* Sound

### Hosts Tested

* Darwin 10.8.0 i386 (clang 1.6 and gcc 4.2.1)
* Linux 2.6.32 i686 (clang 1.1 and gcc 4.4.3)
* Linux 3.2.0 x86\_64 (clang 3.0 and gcc 4.6.3)

### Obfuscations

The code is formatted into a 14-cell shape which will evolve into a glider in
19 generations.

Lots of globals, including a global struct whose members have the same names
as global variables.

Global variables getting reused in different contexts.

Huge and convoluted expressions, abusing ternary operators and operator
precedence.

Lots of magic numbers, abuse of the relationships between magic numbers, and
abuse of the arithmetic properties of magic numbers.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
