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

To use the SDL version that works independently from the curses version:

```sh
make thadgavin_sdl
```

Use `thadgavin_sdl` as you would `thadgavin` below.


## To run:

```sh
./thadgavin
```

WARNING: if you are sensitive to rapid movement or if you want to see better
what is going on then please see the Alternate code section.

NOTE: in curses mode you might want to type `reset` after execution of this
program as the program does not call `endwin()`. Using `reset` will clear the
screen.


## Try:

```sh
echo "Do or do not. There is no try."
```

## Alternate code:

An alternate version exists which allows you to slow down the printing of the
characters, useful for those with modern systems or those who are sensitive to
rapid moving swirling. To use:


```sh
make alt
```

To make the SDL version:

```sh
make thadgavin.alt_sdl
```

If you wish to reconfigure the delay you can do so like:

```sh
make -DZ=50 clobber alt
make -DZS=5000 clobber thadgavin.alt_sdl
```

Use `thadgavin.alt` and `thadgavin.alt_sdl` as you would `thadgavin` and
`thadgavin_sdl` above.

The default for the curses alt version is 30 and for SDL it is 150000. The
different macros is because the curses version is already slower but it's better
to not tie the two values together. The reason for such drastically different
numbers is because curses is already slower than SDL.


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
