# "Bill Gates" Award

Chris Mills  
Pagine Corporation  
1961-A Concourse Drive  
San Jose, CA 95131  
US  

## To build:

```sh
make all
```

NOTE: this entry requires `X11/Xlib.h` header file and the X11 library to
compile. macOS users running Mountain Lion and later will need to download and
install [XQuartz](https://www.xquartz.org) in order to compile and run this
entry.

## To run:

```sh
DISPLAY="your_X_server_display" 
export DISPLAY
./cmills [speed]	# must be run on an X11 server
```

where:

`speed` is update speed from 1 to 9 (default is 9).

## Judges' remarks:

From the San Jose Mercury News (May 15, 1993 page 20A "West Hackers 
trounce East in computer quiz game"): 


>	"Since 1984, a contest has been held on Usenet for the most
>	unreadable, creative, bizarre but working C program", Gates
>	said. "What is the name of this contest?"
>
>	"Windows," shot back Gassee, naming Microsoft's premier product
>	- a product over which Apple sued Microsoft five years ago. Not
>	the right answer - it's "The Obfuscated C Contest [sic]" - but
>	it brought down the house of Apple partisans...

[The expression on Bill Gates' face was a sight to behold, as reported
to us by several who were there].

You must set `$DISPLAY` in your environment or the program will 
dump core.  This is not a bug as the author documented it as
a feature.  :-)

The optional argument is integer which controls the speed of the
program.  By default the speed is 9.  You may want to try 1.

You will have to kill the program (i.e., ^C) to stop it.

WARNING: Slow servers or servers with long request queues will
continue to 'run' for a while after you have killed
the program.

This program makes your windows about as useful as their windows. :-)

## Author's remarks:

The program uses a single backing pixmap (which is the size of the
screen) for all of its subwindows (with a little bit of trickery to
move the offset around).  This is much better (and faster) than the
obvious implementation which would require a full-screen pixmap and
a separate backing pixmap for each subwindow.

The chance that a window breaks is based on it's kinetic energy,
which in turn is based on it's area and speed.  How silly!

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
