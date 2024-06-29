## To build:

``` <!---sh-->
    make all
```

There is an [alternate version](#alternate-code) which might feel more at home
for vi(m) users in navigation and which has an easy way to exit.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [1991/buzzard in bugs.html](../../bugs.html#1991_buzzard).


## To use:

``` <!---sh-->
    ./buzzard
```


## Alternate code:

This version changes the keys `f` for forward, `l` for left and `r` for right by
default to `k` for forward, `l` for right and `h` for left, which is more
natural for those who use vi(m). Also one can just hit `q` followed by enter to
quit the maze. It is problematic to reconfigure the keys except by modifying the
code directly so the keys are not made a `-D` at the compiler.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./buzzard.alt
```


## Judges' remarks:

You will be A-mazed.

You are invited to try to cheat ... if you can figure out how!  :-)


## Author's remarks:

### How to play

When the game starts, you are at the far end of the maze from the exit, looking
down a corridor.  To move forward, type `f` and press return.  To turn 90
degrees right, type `r`; and for left, `l`.  You can put multiple commands on
one line, and the new view will be drawn after all the moves.

The game ends if you get out the exit (you'll know it when you see
it) or when you type `^D` (EOF).

### Hints on how to cheat

You can, of course, cheat by looking at the maze map.  The question
you need to ask yourself, though, is what sequence of characters
marks the place where you can escape the maze?

The algorithm is quite bizarre--the primary nested loop that
generates it goes top to bottom on the display, looping forward
then backward from the current position to draw the left side and
then the right side.

### Advanced usage notes

The program can also be run from other files containing mazes.  The
maze should be laid out graphically in the obvious format; newlines
separate physical rows in the maze; a space indicates a corridor,
and any other character is a wall.  Tabs are also considered walls,
so make sure to convert tabs to spaces before using it.

Usage:

``` <!---sh-->
    ./buzzard [filename [escape-char \
	    [start-x start-yNNN
```

Filename is the name of the file containing the maze.  This
defaults to `buzzard.c` or rather `__FILE__`.

Escape-char is the character in the maze that represents the exit.
You can put more than one exit in the maze (for example, you could
make all '!'s in the maze be exits).

Start-x and start-y mark the coordinates where you begin playing.
Y coordinate is down the rows in the files, X is to the right
through the characters of each line.  Both X and Y begin counting
from 0.  The default is start-x = 4, start-y = 5, which is needed
for the buzzard.c, but would probably be inappropriate for other
mazes.

### BUGS:

You can't change that at start you're facing down ("south").

The drawing algorithm cannot handle open spaces (two successive
side-corridors with no wall between them).  In fact, it cannot handle
small dog-legs properly, although the error is subtle.

The exit is drawn like a normal corridor from the side view;
it's only displayed as the exit when you are facing it.

Improper command line arguments are not handled nicely.

Mazes with openings at the edges will cause the drawing program
to reach into arbitrary parcels of memory.

The program assumes that tabs are set to 8 characters.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
