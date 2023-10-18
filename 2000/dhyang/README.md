# Best Layout

Don Yang\
UCSD\
259 E. Bellbrook St.\
Covina, CA 91722\
US\
<http://uguu.org>

## To build:

```sh
make
```

## To run:

```sh
./dhyang
```

## Try:

```sh
make saitou
./saitou > aku.c
cat aku.c

make soku
./soku > soku.c
cat soku.c

make zan
./zan > zan.c
cat zan.c

make aku
./aku | diff - aku.c
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

1. Compile [dhyang.c](dhyang.c).
2. Run `./dhyang` and pipe output to another .c file
3. Compile that file
4. Repeat steps 2 and 3 until eventually the output cycles

To interpret the output: the [dhyang.c](dhyang.c.c) is an image of Saitou
Hajime, which eventually generates three sources files that are images of "aku
soku zan" (sin swift slay), Saitou's motto ;)

For best viewing, set tab spaces to 8 characters, and set your
terminal fonts to as close to square as possible.  I hate to do this
but you know, size...

[dhyang.c](dhyang.c) and all its output compiles with gcc if your OS uses ASCII
character set.  No file is included and all functions assume default int return
type (a source of compile warnings).

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
