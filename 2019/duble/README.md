## To build:

``` <!---sh-->
    make
```

There is an alternate version, the original, which does not work well in macOS.
See [Alternate code](#alternate-code) below if you are curious.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2019/duble in bugs.html](../../bugs.html#2019_duble).


## To use:

``` <!---sh-->
    ./prog file
```


## Try:

``` <!---sh-->
    ./prog /tmp/drawing
```

Open another window / terminal.

``` <!---sh-->
    ./prog /tmp/drawing
```

Open more terminals and repeat...

You might also wish to try a full screen size. For this try:

``` <!---sh-->
    make clobber fullscreen
```

Alternatively, if you want to change the size, do something like:

``` <!---sh-->
    make clobber LINES=20 COLUMNS=20 all
```

The author provided us with the following table for use:

<hr style="width:10%;text-align:left;margin-left:0">

* **Arrow keys**: move cursor.
* `p` key: enter *pen* mode (type **p** again to return to the default *move*
mode).
* `l` key: enter *line* mode (type **l** again to validate the line and return
to the *move* mode).
* `c` key: cycle through a small set of different *colors*.
* `q` key: quit the editor. The drawing is automatically saved.

The mode and current color is indicated at the bottom left corner of
the editor.

After editing the file and quitting, try:

``` <!---sh-->
    /tmp/drawing
```

i.e. execute the file.


<hr style="width:10%;text-align:left;margin-left:0">

WARNING: if the file is deleted it might lock any session still in use. These
will have to be killed from another shell session or by closing the terminal tab
(in other words don't do this from the console!). If the file cannot be opened
in the beginning this will also happen. This is discussed in
[2019/duble in bugs.html](../../bugs.html#2019_duble).

NOTE: this entry might leave sockets lying about in the current working
directory which you'll have to delete manually. This is also discussed in
[2019/duble in bugs.html](../../bugs.html#2019_duble).


## Alternate code:

An alternate version of this entry, [prog.alt.c](%%REPO_URL%%/2019/duble/prog.alt.c), is provided.  This
alternate code might not work as well in macOS.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


## Judges' remarks:

After starting the program, use the cursor keys, then try some modes, like `p`
or `l` (they toggle).


## Author's remarks:

### Introduction:

This program is a **graphics editor**, running in the terminal.

It provides **collaborative** features: one can join the drawing session
of someone else by just opening the same file!


### Getting started:

The program can run on Linux, FreeBSD, macOS, and in most terminals.
See section [Limits, Portability](#limits-portability) for more info.

To build, type `make` (assuming gcc) or `make CC=clang`.

Then you can start the program. It expects a file path as its first argument:

``` <!---sh-->
    ./prog /tmp/drawing
```

(If not started this way, with a file, `prog` will refuse to start.)

If the file does not exist, you will start with a blank drawing.

If someone else (or another *instance of yourself*, maybe?) is already
editing this file, you will join the session!


### Edit features:

* **arrow keys**: move cursor.
* `p` key: enter *pen* mode (type **p** again to return to the default *move* mode).
* `l` key: enter *line* mode (type **l** again to validate the line and return to the *move* mode).
* `c` key: cycle through a small set of different *colors*.
* `q` key: quit the editor. The drawing is automatically saved.

The mode and current color is indicated at the bottom left corner of
the editor.


### Bonus features:

* If you just want to display the content of a drawing file, you do not
  need to start the editor. Just **execute the drawing file**: `./<the-file>`.
  (This will fail if someone is still editing the file, though.)
* `ls --color <drawing-files...>` will probably select different colors
  to indicate whether a drawing file is being edited or not. :-)

### Obfuscation:

You will probably have a hard time analyzing this entry, because:

*   Analyzing a system made of several communicating programs is known to
    be a complex task. (And if you think that observing a single-user drawing
    session will be a good starting point, read on.)
*   Code coverage of single vs multi-user sessions is more or less the same. :-)
*   Code coverage when using *move*, *pen* or *line* modes is almost the same.
    (so, is there a Bresenham algorithm somewhere??)
*   Some OS resource values and `stdlib.h` call results are inferred.
*   Whenever possible, variable names are reused.
*   You might start analyzing escape code sequences right now, but warming up
    your brain is actually recommended. Start with a simple question such as:
    *in inverse video mode, will a space char show the foreground color or
    background color?*

### A few more things:

Did you notice the `enum` declaration? Could it be just an `int` or `const int`
variable, instead? (spoiler: <http://c-faq.com/ansi/constasconst.html>)

If your keyboard has no arrow keys, you can probably find alternate keys by
reading the source code.


### Limits, Portability:

I tested the program on several Linux systems, on FreeBSD 12, and on
macOS (Mojave).

On Linux, the program uses an OS-specific detail to hide communication
artefacts, and avoids the need to remove them on exit.
Since this is Linux-specific, it was not possible on FreeBSD or macOS.
Its behavior is a little more *dirty* there.

The program should work on most terminals that support 8-bit colors,
inverse video mode, and movement escape codes, e.g. `xterm`, `gnome-terminal`,
`terminator`, etc.

Note: the drawing files `prog` generates are probably even more portable than
`prog` itself!


### Drawing area size:


#### The drawing area size is set at compilation time:

The default size is the one of my xterm (see top of Makefile).
You may set it to the full size of your terminal window by typing:

``` <!---sh-->
    make clobber fullscreen
```

IMPORTANT NOTES:

*   **The program compiled with a given size will fail to reload a drawing file
    with a different size!**
*   No scrolling is implemented (sorry but that would be too much for rule2!),
    so any peer reaching the session should have a terminal with the same
    size or larger.

### [prog.c](%%REPO_URL%%/2019/duble/prog.c) vs [prog.alt.c](%%REPO_URL%%/2019/duble/prog.alt.c)

The file [prog.alt.c](%%REPO_URL%%/2019/duble/prog.alt.c) is the one I submitted.

The judges proposed a small update: the program was using macro `FD_SET` inside an
expression, which breaks compilation on macOS. Wrapping this macro into a
function was enough to fix this compilation issue.

However, that was not enough to make the program work on macOS. If you analyse
the program you will see that it heavily relies on OS resources. And, for this
first version of the program, you even needed to increase default `sysctl`
parameters to make it work on FreeBSD (this was the purpose of the
[check-os.sh](%%REPO_URL%%/2019/duble/check-os.sh) file). I tried hard to tune macOS the same, but failed.

The simple fact the Judges proposed this update meant they wish it could work on
Mac.  And if the judges wish something, it **has to** be done. ;) So I
refactored a little more the program to reduce OS resources consumption.  Or
maybe not reduce consumption, but consume them differently...  And I obtained
[prog.c](%%REPO_URL%%/2019/duble/prog.c). With this version, no need to touch `sysctl` parameters, and
it works on macOS too!  I must confess it was challenging to remain below the
size limit with this little change.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
