## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./dhyang
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

A beautiful combination of solving several different problems, but
mostly, the single most impressive layout we've ever seen.  Many
programs have *one* interesting layout; this one has four.

It may be informative to run the code through a "beautifier", to
study it, but the layout itself is where most of the interest lies.


## Author's remarks:

This one is dedicated to Saitou Hajime fans `^_^x`

Instead of making one self reproducing program, what I made was a
program that generates a set of mutually reproducing programs, all of
them with cool layout!

For your enjoyment:

1. Compile [dhyang.c](%%REPO_URL%%/2000/dhyang/dhyang.c).
2. Run `./dhyang` and redirect output to another `.c` file.
3. Compile that file.
4. Repeat steps 2 and 3 until eventually the output cycles.

To interpret the output: the [dhyang.c](%%REPO_URL%%/2000/dhyang/dhyang.c) is an image of Saitou
Hajime, which eventually generates three sources files that are images of "aku
soku zan" (sin swift slay), Saitou's motto ;)

For best viewing, set tab spaces to 8 characters, and set your
terminal fonts to as close to square as possible.  I hate to do this
but you know, size...

[dhyang.c](%%REPO_URL%%/2000/dhyang/dhyang.c) and all its output compiles with gcc if your OS uses ASCII
character set.  No file is included and all functions assume default `int` return
type (a source of compile warnings).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
