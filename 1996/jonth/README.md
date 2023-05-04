# Best X11 Entry

Jon Thingvold  
University of Oslo  
Gaustadveien 10B  
N 0372 Oslo  
Norway  
http://www.uio.no/~jonth/  

## To build:

```sh
make all
```

NOTE: this entry requires `X11/Xlib.h` header file and the X11 library to
compile. macOS users running Mountain Lion and later will need to download and
install [XQuartz](https://www.xquartz.org) in order to compile and run this
entry. But see [bugs.md](/bugs.md) for a known problem with running this under
macOS and with a workaround of sorts plus more information on where it fails.


## To run:

```sh
./jonth :0 :0
```

## Try:

```sh
./jonth host1:0 host2:0
```

## Judges' remarks:


For extra credit, figure out how you can cheat by taking over a square already
occupied by an opponent.

## Author's remarks:

This is multi-user tic-tac-toe for X Windows. You may give one or two X displays
as arguments to this game.

### Known bugs:

Sometimes on Solaris X gets confused and this program core dumps. The solution:
give two display arguments (`./jonth host:0 host:0`).

If one (or both) windows look like a copy of the window(s) below, try
`xrefresh(1)` command.

Have a `nice(1)` day.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
