# Grand Prize

Roemer B. Lievaart  
Netherlands   

## To build:

```sh
make all
```

NOTE: The original entry may be built with "make alt" if you have an old enough
compiler.

## To run:

```sh
./lievaart
# enter a level and start playing as described below
```

### INABIAF - it's not a bug it's a feature! :-)

If you enter invalid input the program will enter an infinite loop displaying a
string like `"You:"` repeatedly (for instance if you input `.`). If you enter an
incorrect value it will prompt you again until you input a proper value.

## Try:

To see what it would have looked like without the size restrictions:

```sh
./lievaart2
# enter a level and start playing as described below
```


## Judges' remarks:

We believe that you too will be amazed at just how much power Mr. Lievaart
packed into 1024 bytes!

This Plays the game of Reversi (Othello)!  Compile and run.  It then
asks for a playing level. Enter 0-10 (easy-hard).  It then asks for
your move. A move is a number within 11-88, or a 99 to pass.  Illegal
moves (except for an illegal pass) are rejected.  Then the computer
does its move (or a 0 to pass), until the board is full.

It plays rather well, for such a small program!  Lievaart had to leave out the
board printing routine, so you'll have to take a real game board to play it (or
see below). ...  Also due to space-limitations (the rules for 1987 had a limit
of 1024 byes), Lievaart took out the passing-handler, which makes its
ending-game rather poor.  But further it knows all the rules, uses alpha-beta
pruning, and it plays f.i. on mobility(!).  Most important: it can play a pretty
good game of Reversi!

The Author was kind enough to supply the fully functional version of the
program.  The file lievaart2.c contains what the program would have
been without the size restriction.  This version has the full end game 
logic and displays the board after each move!


## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
