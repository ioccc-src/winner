# Most playfully versatile

Yves-Marie Morgan  
<yves-marie.morgan@parrot.com>  


## Judges' comments:
### To build:

        make morgan2

### To run:

    ./morgan2

For the console version (ncurses)

or

    ./morgan2 X

For the graphical version (X11)

### Selected Judges Remarks:

The judges enjoyed playing the game almost to completion; if we remember correctly, 
we managed to place 59 or 60 dominos. We wonder, what would be faster: to play the game to completion
or to write an unobfuscated version of it?



## Author's comments:

This program is a domino game. The goal is to place dominos on the 8x8 grid.
Each domino is made of 6 squares of the color red or green. To place a domino,
at least one of it side shall match the other side of another domino.

# How to play

## Start of the game

At the start of the game, the first domino is placed randomly on the grid. You
get another domino to place by selecting one empty position in the stack on the
right. You can have to 8 dominos pending at any time.

## Moving in the stack

Use `Up` and `Down` key to move the cursor in the stack. Press `Enter` to either

* reveal a new domino if the position was empty.
* select the domino to try to place it if the position was not empty.

The currently selected domino is indicated on the top right.

## Placing a domino

Once a domino has been selected, the cursor moves to the grid. Use `Up`, `Down`,
`Left` and `Right` keys to move in the grid. Press `Enter` on an empty position
to place the domino.

To go back to selection mode, press `Enter` on an occupied position.

The domino can be place in an empty position if all its neighbour have matching
sides and the domino has at least one neighbour.

## Scoring

First, depending on the number of dominos pending in the stack, a bonus is
accorded :
* 1 domino in the stack : 8 points.
* 2 dominos in the stack : 4 points.
* 3 or 4 dominos in the stack : 2 points.
* 5 or more dominos in the stack : 0 point.

Then the bonus is multiplied by the number of matching neighbor the placed domino
has (1, 2, 3 or 4). This is added to the score.

Finally, the total score is divided by the number of dominos placed (1 - 64).

The 3 numbers on display represent : the total score, the fill count and the
final score (total score divided by fill count).

## End of the game

The game is finished when no more domino can be placed and you either :
* filled the complete grid.
* have 8 pending dominos in the stack.
* no more domino can be revealed in the stack (more than 56 dominos placed on
  the grid).

**Note** There is no real end of game detection implemented in the program,
simply press `q` when you have finished...

## Strategy

* Try to minimize the number of dominos revealed in the stack. The lower the number,
the higher the bonus.
* Each domino is unique and all combination of colors exists, so keep track
  of what is already place and what is left.
* Make sure you don't render dead some positions by preventing a future placement
  If the corner of domino does not match another corner in diagonal, the move
  is valid but will prevent some future moves.

# Limitations

* ASCII character set is assumed.
* Requires both ncurses and X11 at compilation and runtime, but selection could
  be done at compilation with some extra code (mainly empty stubs).

# Obfuscation

* 1 letter identifier, reused when possible.
* 1 algorithm, 2 different kind of display (ncurses and X11) mixed.
* No parameters to functions, all variables are global and shared.
* Some variables are not initialized if they have a known value at the time of use.

# Compilation warnings

with gcc 4.7.2 on Linux Ubuntu 12.10 :
* prog.c:46:65: warning: value computed is not used [-Wunused-value]

with clang 3.1 on Linux Ubuntu 12.10 :
* prog.c:23:24: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]


**!!!!! HAVE FUN !!!!!**


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
