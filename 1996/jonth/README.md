# Best X11 Entry:

    Jon Thingvold
    University of Oslo
    Gaustadveien 10B
    N 0372 Oslo
    Norway

    http://www.uio.no/~jonth/

## To build:

        make all

### To run:

	./jonth

## Try:

	./jonth host1:0 host2:0

## Judges' comments:


For extra credit, figure out how you can cheat by taking over
a square already occupied by an opponent.

## Author's comments:

This is multi-user tic-tac-toe for X Windows. You may give one or two X
displays as arguments to this game.

### Known bugs:

Sometimes on Solaris X gets confused and this program core dumps,
solution: give two display arguments (prog host:0 host:0)

If one (or both) windows look like a copy of the window(s) below,
try xrefresh command.

Have a nice(1) day.

