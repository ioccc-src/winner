## To build:

``` <!---sh-->
    make all
```

NOTE: there are two alternate versions of this program, both allowing one to
slow down the game and the second one with movements more familiar to vi users.
See the [Alternate code](#alternate-code) section below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [bugs report with 1993/rince](../../bugs.html#1993_rince).


## To use:

``` <!---sh-->
    ./rince [cabbage]
```

where:

`[cabbage]` is a CABBAGE description file  (default: `rince.c`)


## Alternate code:

Some people may want to slow down the game by increasing the
value 17 in the lines:


``` <!---c-->
    struct timeval v= {0,1<<17} ;
```

and

``` <!---c-->
    refresh(),c=select(k,&y,0,0,(v.tv_usec=1<<17,&v))?getch():0;
```

to another value like 18 or 19 which you can do with the alternate code.

In the case of [rince.alt2.c](%%REPO_URL%%/1993/rince/rince.alt2.c) the movement keys for the default
game are slightly different and will feel more familiar to vi users: `h` for
left, `l` for right (that was not changed) and `k` for fire (that was also not
changed).


### Alternate build:

``` <!---sh-->
    make SLEEP=18 clobber alt
```

Replace 18 with whatever number you wish.


### Alternate use:

Use `rince.alt` or `rince.alt2` as you would `rince` above.


## Judges' remarks:

The author has provided several CABBAGE files for your amusement:

- [rince.data1](%%REPO_URL%%/1993/rince/rince.data1) plays
[Breakout](https://en.wikipedia.org/wiki/Breakout_&#x28;video_game&#x29;).  Keys are `,`
for left, `/` for right, and `.` for 'fire the ball'.

- [rince.data2](%%REPO_URL%%/1993/rince/rince.data2) plays the old [James Bonfield](../../authors.html#James_Bonfield)'s
([1991/rince](../../1991/rince/index.html) game from [IOCCC
1991](../../1991/index.html)).

- [rince.data3](%%REPO_URL%%/1993/rince/rince.data3) Sokoban screen 11. You are the `o` character.
You must push the money `m` into the dotted region of the screen. The game is
considered finished when all the `m`s are then `M`s.

- [rince.data4](%%REPO_URL%%/1993/rince/rince.data4) Sokoban screen 13. Same rules as above.

For a brief design description, see [design.html](design.html).


### WARNING for SunOS 4.1.x:

If you are running SunOS 4.1.x (assuming you can find an ANSI
compiler in the first place), this program may be used to log
out very quickly.  Unfortunately, you can't do anything else
with it.


### Additional notes

Some people report that `rince` dumps core on their system.

On some systems that use gcc, the `curses.h` used by gcc (typically
`/usr/local/include/curses.h` if not `/usr/include/curses.h`) is not compatible
with the curses library (typically `/lib/libcurses.a` for static libraries)
used. It has been suggested that the following gcc command may help:


``` <!---sh-->
    gcc -fno-builtin -I/usr/include -o rince rince.c -lcurses -ltermcap
```


## Author's remarks:

This is a Cellular Automata Based, Beautifully Abysmal Game Environment (or
CABBAGE for short). To execute the program simply type `./rince gamefile`,
where `gamefile` is a game description file. A few are supplied for your
enjoyment. Alternatively, with no arguments it will default to using it's own
datafile (the source code in fact). This happens to be a game of [Space
Invaders](https://en.wikipedia.org/wiki/Space_Invaders).
To prevent people from firing too often a very simple method is employed; you
must move after firing to be able to fire again.

### Keys

- `j`   -           Left
- `l`   -           Right
- `k`   -           Fire

This is a new breed of generic games. For instance:


Game play   : Whatever you define
Keys        : Whatever you define
Score       : If you can figure out how to update it!
Levels      : Ahh well... it's not *totally* generic.

The proper definition for usage would be: `./rince [data_filename]`


### Portability

I have compiled in on the following systems:

```
    System              OS              Compiler (and flags)
    DECstation 5000/240 Ultrix 4.2A     c89 -std
    SPARCstation 1+     SunOS 4.1       gcc -ansi -pedantic
    SPARCstation 10/31  Solaris 2.1     gcc -ansi -pedantic     (*)
    DECAlpha 3000/500   OSF/1 V1.2      c89 -std
    SGI Indigo (R4000)  IRIX 4.0.5F     cc -ansi
    Alliant FX2800      Conentrix 3.0.0 fxc
```

\* I never said it worked! The guidelines state that you dislike programs that
won't *compile* under both BSD or SysV `Unix`. This compiles, and indeed runs
on all the others (both BSD and SysV) correctly.

Alas, on Solaris it compiles, but mysteriously stops displaying output
after a while until you quit with control-c, when it all catches up again.
I think the problem may lie in either `select(2)`, or curses, (or perhaps
conflict of the two).

The use of `select(2)` no doubt makes it less portable to STRICT SysV machines.
However I have tested this on several so-called SysV machines, and all of them
support `select(2)`. In fact, the `select(2)` they support appears to be more
portable between them than their `poll(2)` call.


### Obfuscation

I have tried to use as many different obfuscation techniques, including
some of which (such as `sizeof` confusion) I have not seen in any entries
(hmmm - perhaps there's a reason for that...) so far. Also, very poor
structure (yes, I use `goto`'s) has led to apparently having an `fgets(3)` as
the last line of main. Note that I have still tried to aim at least some
efficiency (provided it makes things slightly more obfuscated of course).
One such thing is the way I dynamically allocate a 2-dimensional array
using only ONE `malloc(3)`. Hence this program could be used as a tutorial
for all those people who consistently ask this question in the C
newsgroups.

Also, the program does require a volatile type (especially when
optimising) to perform correctly. This is the first time I have ever
truly needed this when not accessing memory external to this process :-)

Of course, all the usual obfuscation lurks within, such as combining
multiple for loops into single ones; warped and twisted logic; plus a
plethora of other minor oddities. It's up to you to discover some of them
of course... Sometimes I have sacrificed length for obfuscation. It is all
too easy to change the arguments in `main()` to one character identifiers, but
in my opinion they add to obfuscation in this case by being longer.

`lint` complains about lots of things. Firstly the use of curses immediately
makes `lint` complain. The Alpha's `lint` gave me some positive encouragement!
`precedence confusion possible: parenthesize!` :-) :-)
`main()` does not return correctly, because, basically, it doesn't return.

### Bugs

Very little error checking is performed. I do check for not being able to
open the requested filename and return 1 upon failure. However, badly
formatted data files will cause major problems. No other checking (such as
insufficient memory) is performed.

There is no 'end of game' checking method. Hence games like Sokoban rely
on the user to decide when they have had enough. Also, there is no quit
mechanism other than control-c.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
