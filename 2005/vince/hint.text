# Most beauteous visuals

Vincent Weaver
Ithaca, NY
USA
vince@deater.net
<http://www.deater.net/weave/>

## Judges' comments

This beauteous entry makes use of visual {}'s and whitespace to instruct
the OpenGL development libraries to create beauteous visuals.  Even
hitting the space bar while the program runs produces a "spacey" effect! :-)

Challenge: Try modifying the texture to something of your own design.

## Improved Version

This following improved version of the submission will run on SGI Irix and
also has the recursive CPP macro (which snuck in accidentally) removed.

### To build

Before building, make sure that you have the OpenGL development libraries
installed.

        cc -Wall -O2 -o vince vince.c -L/usr/X11R6/lib -lGL -lGLU -lX11

If you are on a 64 bit platform you might need to substitute `-L/usr/X11R6/lib64`.

### To run

        vince

Under MacOSX run from within an xterm while the X11 server is running.

## Author's comments

### ABUSE OF RULES

  * The executable needs to read in its own source code in order to run. As
long as the source is in the same directory as the executable it should be
able to find it...

  * The program requires the OpenGL library.

  * The program abuses severely the whitespace and { } ; exceptions in the
filesize limits.

### Requirements

  * OpenGL. It works (slowly) with Mesa.

  * 16bpp graphics capability (but might work at other depths)

  * The original source needs to be in the same directory as the executable,
and the source's name should be the same as the executable but with .c on the
end.

### Background

I was annoyed after the last IOCCC because I slaved away on a clever text
based game only to find all of the game winners used X11. X11 isn't standard
C!

So to one up them, I decided to use OpenGL. It's standard, and most Unix-like
systems these days have either accelerated graphics or else software
rendering.

### Obfuscation

It was a challenge getting the source code below the 2k limit. OpenGL has way
too many GRATUITOUSLY_LONG_CONSTANTS and glLongStudlyFunctionNames();

Therefore, much of the obfuscation comes secondary to just reducing the code
size to fit under the limit while still having some semblance of a demo.

There are some interesting abuses scattered about.

### Usage

Try hitting the spacebar when the program is running.

### For Fun

Try modifying the texture to your own custom design...

### Thanks

Many thanks to John Clemens for testing this on various machines for me.

### Errors you can get

        0 = no error
        1 = X problem
        2 = Can't open glx
        3 = Can't open 16bpp visual
        4 = can't open source file
