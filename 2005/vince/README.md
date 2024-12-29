## To build:

Before building, make sure that you have the OpenGL development libraries
installed.

``` <!---sh-->
    make
```

**NOTE**: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".

There is an alternate version of this entry. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./vince
```


## Try:

When running this in the program's window try hitting space a few times and see
what happens!


## Alternate code:

The [vince.alt.c](%%REPO_URL%%/2005/vince/vince.alt.c) code will run on SGI IRIX
and also has the recursive `CPP` macro (which sneaked in accidentally) removed.


### Alternate build:

To compile this alternate version:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `vince.alt` as you would `vince` above.


### Alternate try:

Try it just like `vince` as above.


## Judges' remarks:

This beauteous entry makes use of visual `{}`s and whitespace to instruct the
[OpenGL](https://www.opengl.org) development libraries to create beauteous
visuals.  Even hitting the space bar while the program runs produces a "spacey"
effect! :-)

**NOTE**: when hitting space bar make sure that the program window is in focus!

Challenge: Try modifying the texture to something of your own design.


## Author's remarks:

### ABUSE OF RULES

* The executable needs to read in its own source code in order to run. As
long as the source is in the same directory as the executable it should be
able to find it...

* The program requires the OpenGL library.

* The program abuses severely the whitespace and `{ } ;` exceptions in the
file size limits.


### Requirements

* OpenGL. It works (slowly) with Mesa.

* 16bpp graphics capability (but might work at other depths)

* The original source needs to be in the same directory as the executable,
and the source's name should be the same as the executable but with `.c` on the
end.


### Background

I was annoyed after the last IOCCC because I slaved away on a clever text
based game only to find all of the game entries used X11. X11 isn't standard
C!

So to one up them, I decided to use OpenGL. It's standard, and most Unix-like
systems these days have either accelerated graphics or else software
rendering.


### Obfuscation

It was a challenge getting the source code below the 2k limit. OpenGL has way
too many '`GRATUITOUSLY_LONG_CONSTANTS`' and '`glLongStudlyFunctionNames();`'.

Therefore, much of the obfuscation comes secondary to just reducing the code
size to fit under the limit while still having some semblance of a demo.

There are some interesting abuses scattered about.


### Usage

Try hitting the space bar when the program is running.


### For Fun


Try modifying the texture to your own custom design...


### Thanks

Many thanks to John Clemens for testing this on various machines for me.


### Errors you can get

- 0 = no error.
- 1 =
[X](https://en.wikipedia.org/wiki/X_Window_System_protocols_and_architecture)
problem.
- 2 = can't open [GLX](https://en.wikipedia.org/wiki/GLX).
- 3 = can't open 16bpp visual.
- 4 = can't open source file.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
