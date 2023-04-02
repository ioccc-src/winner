# Most Portable Output:

    Thaddaeus Frogley
    Creature Labs
    164 Hornbeams,
    Harlow, Essex,
    UK

    Gavin Buttimore
    Creature Labs
    9 Elizabeth Way,
    Cambridge,
    UK, CB4 1DE

## To build:

```sh
make
```

## To run:

```sh
./thadgavin
```

## Try:

```sh
echo "Do or do not. There is no try."
```

## Judges' comments:

This entry is a nice play by the rules. It can use curses, if the
SDL graphic library is not present, and is quite good at that,
but the colors used in graphic mode (16 bit depth) are unfortunately
less than dazzling. We could not test this entry in DOS mode.

## Author's comments:

To run under DOS:

    Compile using DJGPP as follows:

    gcc thadgavin.c -o thadgavin.exe -Wall -lm -O6 -mpentium -fomit-frame-pointer
-ffast-math

To run under Windows, X-Windows or MacOS using the
Simple DirectMedia Layer:

    For example:

    gcc -O6 -lpthread -g -o thadgavin thadgavin.c -lSDL -DSDL -lm


In gcc you may get the following warning:

    prog.c:46: warning: passing arg 2 of `SDL_SetColors' from incompatible
    pointer type

In Microsoft Visual Studio you may get warnings as follows:

    prog.c(46) : warning C4133: 'function' : incompatible types - from 'unsigned
    char *' to 'struct SDL_Color *'
    prog.c(63) : warning C4026: function declared with formal parameter list
    prog.c(77) : warning C4244: '=' : conversion from 'double ' to 'unsigned
    char ', possible loss of data


But don't worry, this is completely normal.

Recommended dosage:

    At least 3 minutes taken 3 times a day when tired.

    Do not exceed 3 times recommended dose.  May cause
    sickness, dizziness, nausea.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
