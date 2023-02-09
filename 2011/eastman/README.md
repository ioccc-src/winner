# Best ball

Peter Eastman  
<peter.eastman@gmail.com>  


## Judges' comments:
### To build:

    make eastman

### To run:

    ./eastman

### Try:

    Quit the program.  Resize your terminal window.  Run it again.

### Selected Judges Remarks:

This round program will generate a classic spherical result!

You will need a terminal capable of displaying coloured ANSI
characters (for example an xterm or a Terminal.app window).

You might also want to turn off any scrollback history. The program will
size itself to the initial geometry of your terminal.

If you are ambitious, make the font really small and the window really
large for hi-rez graphics!

## Author's comments:
This program uses ANSI graphics to recreate the classic Boing Ball demo from
the Commodore Amiga.  See http://www.youtube.com/watch?v=-ga41edXw3A if you
aren't familiar with it.  Back in its day, this demo inspired lust and awe in
geeks around the world.

The graphics are raytraced, with procedural textures on the ball and the back
wall.  I did cheat a little to simplify the calculations: it uses a parallel
projection, but textures the back wall to look as if there were a floor being
viewed in perspective.  The shadow is also just part of the texture, not an
actual raytraced shadow.

This program automatically adapts to the size of the terminal it is running in,
so try enlarging the window to get higher resolution.  Don't resize while the
program is running, though.  It only checks the size once, when it starts up.

To compile:

cc -lm ball.c

Portability:

It should be completely portable.  I've tested with gcc on Mac OS X 10.7 and
Fedora 10.  I would expect it to work in any Unix-like environment.

Obfuscation:

I have merged expressions wherever possible, making extensive use of ternary
operators, commas, return values of assignment operators, etc.  The entire
raytracing computation, include ray intersection tests and procedural texture
evaluations, is a single expression involving 41 operators.

Variables are named alphabetically in the order they are declared.

The third argument to ioctl() should really be a "struct winsize", and I should
then look up the ws_row and ws_col fields, but that makes it way too obvious
what I'm doing there.  Since a winsize just contains four unsigned shorts, I
replaced it with an array.  And since all the values will be much less than
32767, I further simplified the type to just short[].

A wonderful thing about ANSI graphics is that it produces nearly unintelligible
code.  Consider the printf spec to print a single space in a desired color:
"\x1B[%dm ".  I could have done something to further obfuscate it, but it's
already indistinguishable from line noise, so why bother?

There are lots of other minor obfuscations to make the code less obvious.  For
example, I could have written the outer loop as while(1), but why write a 1
when I can calculate it from the return value of usleep() instead?  And I could
have written usleep(80000), but usleep(79383) just looks so much better.  And
so on.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
