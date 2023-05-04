# Most Portable Output

Thaddaeus Frogley  
Creature Labs  
164 Hornbeams  
Harlow, Essex  
UK  
  
Gavin Buttimore  
Creature Labs  
9 Elizabeth Way   
Cambridge   
UK, CB4 1DE  

## To build:

```sh
make
```

NOTE: the author suggested `-O6` but at least some gcc versions support no more
than level 3 which is what the Makefile has.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the code and
added an appropriate make rule so that the SDL version works independent from
the curses version (using the same code). To use it:


```sh
make thadgavin_sdl
```

Use `thadgavin_sdl` as you would `thadgavin` below.

Thank you Cody for your assistance!

To see the craziness of the SDL fix (because of a design choice of the SDL1
developers) see the log for commit dd0b26b5d6325e8b6fdef1232156c8bb8c66613f. Be
prepared for a surprise.

## To run:

```sh
./thadgavin
```

WARNING: if you are sensitive to rapid movement you should probably avoid
this entry, both the SDL version and the curses version.

NOTE: in curses mode you might want to type `reset` after execution of this
program as the program does not call `endwin()`. Using `reset` will clear the
screen.


## Try:

```sh
echo "Do or do not. There is no try."
```

## Judges' remarks:

This entry is a nice play by the rules. It can use curses, if the
SDL graphic library is not present, and is quite good at that,
but the colors used in graphic mode (16 bit depth) are unfortunately
less than dazzling. We could not test this entry in DOS mode.

## Authors' remarks:

### To run under DOS:

Compile using DJGPP as follows:

```sh
gcc thadgavin.c -o thadgavin.exe -Wall -lm -O6 -mpentium -fomit-frame-pointer -ffast-math
```

### To run under Windows, X-Windows or MacOS using the Simple DirectMedia Layer:

```sh
gcc -O6 -lpthread -g -o thadgavin thadgavin.c -lSDL -DSDL -lm
```


### Warnings

In gcc you might get the following warning:

```
thadgavin.c.c:46: warning: passing arg 2 of `SDL_SetColors' from incompatible pointer type
```

In Microsoft Visual Studio you may get warnings as follows:

```
thadgavin.c(46) : warning C4133: 'function' : incompatible types - from 'unsigned
char *' to 'struct SDL_Color *'
thadgavin.c(63) : warning C4026: function declared with formal parameter list
thadgavin.c(77) : warning C4244: '=' : conversion from 'double ' to 'unsigned
char ', possible loss of data

```

But don't worry, this is completely normal.

Recommended dosage:

At least 3 minutes taken 3 times a day when tired.

Do not exceed 3 times recommended dose.  May cause sickness, dizziness, nausea.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
