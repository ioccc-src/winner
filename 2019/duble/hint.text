# Best collaborative graphics

Etienne Duble  
<https://lig-membres.imag.fr/duble>  
Twitter: @etienne_duble  


## Judges' comments:
### To use:

    make

### Try:

    ./prog /tmp/drawing

    (open another window / terminal)

    ./prog /tmp/drawing

    (open more terminals....)

    ./prog /tmp/drawing

### Selected Judges Remarks:

After starting the program, use the cursor keys, then try some modes, like "p"
or "l" (they toggle).

## Author's comments:
### Introduction

This program is a **graphics editor**, running on the terminal.

It provides **collaborative** features: one can join the drawing session
of someone else by just opening the same file!

### Getting started

The program can run on Linux, FreeBSD, Mac OS X, and in most terminals.
See section 'Limits, Portability' for more info.

To build, type `make` (assuming gcc) or `make CC=clang`.

Then you can start the program. It expects a file path as its first argument:

    $ ./prog /tmp/drawing

(If not started this way, `prog` will refuse to start.)

If the file does not exist, you will start with a blank drawing.

If someone else (or another *instance of yourself*, maybe??) is already
editing this file, you will join the session!

### Edition features

* **arrow keys**: move cursor.
* **p** key: enter *pen* mode (type **p** again to return to the default *move* mode).
* **l** key: enter *line* mode (type **l** again to validate the line and return to the *move* mode).
* **c** key: cycle through a small set of different *colors*.
* **q** key: quit the editor. The drawing is automatically saved.

The mode and current color is indicated at the bottom left corner of
the editor.

### Bonus features

* If you just want to display the content of a drawing file, you do not
  need to start the editor. Just **execute the drawing file**: `./<the-file>`.
  (This will fail if someone is still editing the file, though.)
* `ls --color <drawing-files...>` will probably select different colors
  to indicate whether a drawing file is being edited or not. :-)

### Obfuscation

You will probably have a hard time analyzing this entry, because:

*   Analyzing a system made of several communicating programs is known to
    be a complex task. (And if you think that observing a single-user drawing
    session will be a good starting point, read on.)
*   Code coverage of single vs multi-user sessions is more or less the same. :-)
*   Code coverage when using *move*, *pen* or *line* modes is almost the same.
    (so, is there a Bresenham algorithm somewhere??)
*   Some OS resource values and stdlib call results are inferred.
*   Whenever possible, variable names are reused.
*   You might start analyzing escape code sequences right now, but warming up
    your brain is actually recommended. Start with a simple question such as:
    *in inverse video mode, will a space char show the foreground color or
    background color?*

### A few more things

Did you notice the `enum` declaration? Could it be just an `int` or `const int`
variable, instead? (spoiler: http://c-faq.com/ansi/constasconst.html)

If your keyboard has no arrow keys, you can probably find alternate keys by
reading the source code.

### Limits, Portability

I tested the program on several Linux systems, on FreeBSD 12, and on
Mac OS X (mojave).

On Linux, the program uses an OS-specific detail to hide communication
artefacts, and avoids the need to remove them on exit.
Since this is Linux-specific, it was not possible on FreeBSD or Mac OS.
Its behavior is a little more *dirty* there.

The program should work on most terminals that support 8-bit colors,
inverse video mode, and movement escape codes, e.g. `xterm`, `gnome-terminal`,
`terminator`, etc.

Note: the drawing files `prog` generates are probably even more portable than
`prog` itself!

### Drawing area size

*The drawing area size is set at compilation time*.

The default size is the one of my xterm (see top of Makefile).
You may set it to the full size of your terminal window by typing:

    $ make fullscreen

IMPORTANT NOTES:

*   **The program compiled with a given size will fail to reload a drawing file
    with a different size!**
*   No scrolling is implemented (sorry but that would be too much for rule2!),
    so any peer reaching the session should have a terminal with the same
    size or larger.

### prog.c vs prog.orig.c

The file `prog.orig.c` is the one I submitted.

Judges proposed a small update: the program was using macro `FD_SET` inside an
expression, which breaks compilation on Mac OS X. Wrapping this macro into a
function was enough to fix this compilation issue.

However, that was not enough to make the program work on Mac OS X. If you analyse
the program you will see that it heavily relies on OS resources. And, for this
first version of the program, you even needed to increase default `sysctl`
parameters to make it work on FreeBSD (this was the purpose of file `check-os.sh`).
I tried hard to tune Mac OS X the same, but failed.

The simple fact Judges proposed this update meant they wish it could work on Mac.
And if judges wish something, it **has to** be done. ;)
So I refactored a little more the program to reduce OS resources consumption.
Or maybe not reduce consumption, but consume them differently...
And I obtained `prog.c`. With this version, no need to touch `sysctl` parameters,
and it works on Mac OS X too!
I must confess it was challenging to remain below the size limit with this little
change.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
