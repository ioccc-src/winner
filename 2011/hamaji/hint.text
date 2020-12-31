# Best solved puzzle

Shinichiro Hamaji  
<shinichiro.hamaji@gmail.com>  

bsoup  


## Judges' comments:
### To build:

    make hamaji

### To run:

    ./hamaji < a_nonogram_file

### Try:

    ./hamaji < dragon.nono
    ./hamaji < random.nono
    ./hamaji < soccer.nono
    ./hamaji < codegolf.nono
    ./hamaji < face.nono
    ./hamaji < penguin.nono
    ./hamaji < samurai.nono

### Selected Judges Remarks:

This program solves "Nonogram", which also known as "Paint by Numbers":

<http://en.wikipedia.org/wiki/Nonogram>

This entry roar as the Year of the Dragon: A year considered
some to be good luck.  Well it was certainly true that the
IOCCC was lucky to get such a fine submission!

The source code is a solution to a Paint by Numbers puzzle when you
paint by C.  Try your hand at solving a few of the other .nono
files and then compare your solution with this program!

NOTE: NONOGRAM (r) is a registered Trademark and is used with permission.
      See http://nonogram.com/ for more information.

## Author's comments:
The format of the input files are as same as this site:

<http://codegolf.com/paint-by-numbers>

For example, for a simple problem which shows a glider of [conway's
lifegame](http://en.wikipedia.org/wiki/Conway's_Game_of_Life).

       1
       .
      112
    
    1  X
    1   X
    3 XXX

the input should be

    1
    1
    3
    -
    1
    1.1
    2

The width and the height of an input puzzle should be less than or
equal to 60.

When this solver finds the problem has no solution, it prints "invalid".
This means the problem is indeed broken. For example, this happens for
an input like

    2
    -
    2

When this solver cannot find a solution, it prints "failed". This
failure can happen when the problem has more than one solution or the
solver cannot solve the input problem. Here is an example input of the
former:

    1
    1
    -
    1
    1

There are two solutions:

      11
    
    1 X 
    1  X

and

      11
    
    1  X
    1 X 

### Detail

Solving Nonogram is known NP-complete, so we cannot make a solver
which solves all puzzles. However, we can write a solver which solves
most problems solvable by humans. There are a bunch of ways to write
such programs. The two most obvious approaches are:

1. Check all possible solutions with backtracking.
2. Implement all techniques which humans use.

The former, brute-force approach is easy to implement. However, it
works only for smaller problems (width and height should be at most 30
or so). Similarly, using generic probabilistic metaheuristics such as
simulated annealing doesn't work for big problems.

<http://ccl.northwestern.edu/netlogo/models/community/Nonogram>

By its definition, the latter works for all human-solvable
problems. The issue of the latter approach is this kind of programs
tends to be lengthy. This approach still requires some recursions. The
most difficult problems which are considered human-solvable may
require some "guesses". For this kind of problems, we need to assume a
cell is a space or a box, go ahead some steps with simple methods,
mark the tried cell as a box (or a space if we assumed the tried cell
is a box) if a contradiction is found.

My program uses an approach like "Set based solver" introduced in
[http://www.haskell.org/haskellwiki/Nonogram](http://www.haskell.org/haskellwiki/Nonogram) .
This should be equivalent to the combinations of simple methods (no
advanced reasoning with guess). My solver also runs non-recursive
guess for each undetermined cells. So, my program should be able to
solve most human-solvable problems (assuming humans cannot execute
deeper recursions).

### Obfuscation

First of all, as you see, my program looks like a nonogram puzzle
which results a dragon. This puzzle is "dragon.nono" in this
directory. Note that whitespaces in character literals, a string
literal, and around the last comment are considered as a boxed cell.

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

This program uses two C99 features. One line comments and "long long".
GCC's "-ansi -pedantic" check should pass:

    $ gcc -ansi -pedantic -std=c99 hamaji.c

I checked my program with gcc-4.6.2 on linux, llvm-gcc-4.2 on mac, and
clang-3.0 on mac.

Note that the behavior of scanf differs on linux and mac, but this
program supports both semantics.

This program should not depend on sizeof(int), sizeof(void*), ASCII,
memory layout, undefined evaluation order (e.g., a[i++]=i), etc. 
This program won't work if the size of long long literal is less than 8.
By grepping the source code of gcc

    grep LONG_LONG_TYPE_SIZE gcc/config/*/*

I found long long may be 32bit integers only on AVR.

### A few more

This code is considered as a new year's postcard in Japan. We chose
the dragon because 2012 is the year of dragon.

<http://en.wikipedia.org/wiki/Japanese_New_Year#Postcards>

The second author wrote the picture, and the first author did
everything else.

The dragon.nono, samurai.nono, and penguin.nono was written by the
second author.  The soccer.nono was from a wikipedia entry.  This file
is important because it requires some guesses.  The random.nono file
was randomly generated. The codegolf.nono and face.nono have borrowed
from this site:

<http://codegolf.com/paint-by-numbers>

You can reproduce dragon.nono from hamaji.c using c2nono.pl:

    perl c2nono.pl hamaji.c | ./hamaji

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
