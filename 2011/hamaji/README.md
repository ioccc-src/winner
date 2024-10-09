## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./hamaji < a_nonogram_file
```


## Try:

``` <!---sh-->
    ./try.sh
```

If you have perl installed you should be able to reproduce
[dragon.nono](%%REPO_URL%%/2011/hamaji/dragon.nono) like:

``` <!---sh-->
    perl c2nono.pl hamaji.c | ./hamaji
```


## Judges' remarks:

This program solves [Nonograms](http://en.wikipedia.org/wiki/Nonogram) which is
also known as "Paint by Numbers".

This entry roars as the Year of the Dragon: A year considered
some to be good luck.  Well it was certainly true that the
IOCCC was lucky to get such a fine submission!

The source code is a solution to a Paint by Numbers puzzle when you
paint by C.  Try your hand at solving a few of the other `.nono`
files and then compare your solution with this program!

**NOTE**: NONOGRAM (r) is a registered Trademark and is used with permission. See
<https://nonogram.com> for more information.


## Author's remarks:

The format of the input files are as same as this site:
<https://web.archive.org/web/20130218055139/http://codegolf.com/paint-by-numbers>.

For example, for a simple problem which shows a glider of [Conway's
Game of Life](http://en.wikipedia.org/wiki/Conway's_Game_of_Life):

```
       1
       .
      112

    1  X
    1   X
    3 XXX
```

the input should be

```
    1
    1
    3
    -
    1
    1.1
    2
```

The width and the height of an input puzzle should be less than or
equal to 60.

When this solver finds the problem has no solution, it prints "`invalid`".
This means the problem is indeed broken. For example, this happens for
an input like

```
    2
    -
    2
```

When this solver cannot find a solution, it prints "`failed`". This
failure can happen when the problem has more than one solution or the
solver cannot solve the input problem. Here is an example input of the
former:

```
    1
    1
    -
    1
    1
```

There are two solutions:

```
      11

    1 X
    1  X
```

and

```
      11

    1  X
    1 X
```

### Detail

Solving Nonogram is
[NP-complete](https://en.wikipedia.org/wiki/NP-completeness), so we cannot make
a solver which solves all puzzles. However, we can write a solver which solves
most problems solvable by humans. There are a bunch of ways to write such
programs. The two most obvious approaches are:

1. Check all possible solutions with backtracking.
2. Implement all techniques which humans use.

The former, brute-force approach is easy to implement. However, it
works only for smaller problems (width and height should be at most 30
or so). Similarly, using generic probabilistic
[metaheuristics](https://en.wikipedia.org/wiki/Metaheuristic) such as
[simulated annealing](https://en.wikipedia.org/wiki/Simulated_annealing) doesn't
work for big problems.

See: <http://ccl.northwestern.edu/netlogo/models/community/Nonogram>.

By its definition, the latter method works for all human-solvable
problems. The issue of the latter approach is this kind of program
tends to be lengthy. This approach still requires some
[recursions](https://en.wikipedia.org/wiki/Recursion). The
most difficult problems which are considered human-solvable may
require some "guesses". For these kinds of problems, we need to assume a
cell is a space or a box, go ahead some steps with simple methods and
mark the tried cell as a box (or a space if we assumed the tried cell
is a box) if a contradiction is found.

My program uses an approach like "Set based solver" introduced in
<https://wiki.haskell.org/Nonogram#Set_based_solver>. This should be equivalent
to the combinations of simple methods (no advanced reasoning with guess). My
solver also runs a non-recursive guess for each undetermined cells. So, my
program should be able to solve most human-solvable problems (assuming humans
cannot execute deeper recursions).


### Obfuscation

First of all, as you see, my program looks like a nonogram puzzle which results
in a [dragon](https://www.draconika.com/what). This puzzle is
[dragon.nono](%%REPO_URL%%/2011/hamaji/dragon.nono) in this directory. Note that whitespaces in character
literals, a string literal, and around the last comment are considered as a
boxed cell.

My program is based on bit operations for speed. Many values are
stored using negative logic (0 means on and 1 means off) to utilize
the initial value of global variables. Thus, it might be difficult to
figure out how it works.

My program is decently shortened, because the size of source code is
limited by IOCCC's rule (2048 non-whitespace characters) and a lot of
characters are just wasted for numbers around the picture.

The three requirements (dragon, speed, and size) naturally ended up
with the well obfuscated code.


### Portability

This program uses two C99 features. One line comments and `long long`.
GCC's `-ansi -pedantic` check should pass:

``` <!---sh-->
    cc -ansi -pedantic -std=c99 hamaji.c
```

I checked my program with gcc-4.6.2 on linux, llvm-gcc-4.2 on Mac, and
clang-3.0 on Mac.

Note that the behavior of `scanf(3)` differs on linux and mac, but this
program supports both semantics.

This program should not depend on `sizeof(int)`, `sizeof(void*)`, ASCII,
memory layout, undefined evaluation order (e.g., `a[i++]=i`), etc.
This program won't work if the size of `long long` literal is less than 8.
By grepping the source code of gcc

``` <!---sh-->
    grep LONG_LONG_TYPE_SIZE gcc/config/*/*
```

I found long long may be 32bit integers only on AVR.


### A few more things

This code is considered as a [new year's postcard in
Japan](http://en.wikipedia.org/wiki/Japanese_New_Year#Postcards). We chose
the dragon because 2012 is the [year of
dragon](https://japanesezodiac.com/japanese-year-of-the-dragon).

The second author wrote the picture, and the first author did
everything else.

The [dragon.nono](%%REPO_URL%%/2011/hamaji/dragon.nono), [samurai.nono](%%REPO_URL%%/2011/hamaji/samurai.nono), and
[penguin.nono](%%REPO_URL%%/2011/hamaji/penguin.nono) were written by the
second author.  The [soccer.nono](%%REPO_URL%%/2011/hamaji/soccer.nono) was from a wikipedia entry.  This file
is important because it requires some guesses.  The [random.nono](%%REPO_URL%%/2011/hamaji/random.nono) file
was randomly generated. The [codegolf.nono](%%REPO_URL%%/2011/hamaji/codegolf.nono) and
[face.nono](%%REPO_URL%%/2011/hamaji/face.nono) were taken from
<https://web.archive.org/web/20130218055139/http://codegolf.com/paint-by-numbers>.

You can reproduce [dragon.nono](%%REPO_URL%%/2011/hamaji/dragon.nono) from [hamaji.c](%%REPO_URL%%/2011/hamaji/hamaji.c) using
[c2nono.pl](%%REPO_URL%%/2011/hamaji/c2nono.pl):

``` <!---sh-->
    perl c2nono.pl hamaji.c | ./hamaji
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
