# Most Obfuscated X Program:

	Jon Thingvold
	University of Oslo
	Sogn Studentby 8231
	N 0858 Oslo
	Norway

## To build:

        make all


Both [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) and [Yusuke
Endoh](/winners.html#Yusuke_Endoh) fixed this so that it
will work with modern systems. Yusuke provided some fixes of the X code and Cody
fixed the C pre-processor directives so that it would compile. It used to be
that you could get away with code like:

```c
G        int i,j
K        case
```

and expect `G;` to equate to `int i, j;` (though it's now a long) and `K` to mean
`case` but that's no longer the case so the offending lines had `#define`
prepended to them. Thank you Yusuke and Cody for your assistance!


### To run

	./jonth			# must be run on an X11 server

## Judges' comments

Use 'h' and 'l' to shift objects left or right.  Use 'k' to
rotate and press SPACE to drop.

This program's output may be even more obfuscated when played 
on inverse video.  :-)


## Author's comments

This is jonth (jon's t(h)etris) for the X Window System.

This program is also an example of data abstraction.  The X array is 
after initialization hidden by the well defined macros t, u and F.

This program is highly portable as it runs on a "Notebook" size SPARC.
This program will not work on machines with `sizeof(int)!=sizeof(void *)`.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
