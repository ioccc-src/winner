# Most Obfuscated X Program:

	Jon Thingvold
	University of Oslo
	Sogn Studentby 8231
	N 0858 Oslo
	Norway

## To build:

        make all


[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so that it
will work with modern systems. Thank you Cody for your assistance!


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

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
