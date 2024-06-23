## To build:

``` <!---sh-->
    make
```

There is an alternate version based on the author's remarks. See [alternate
code](#alternate-code).


## To use:

``` <!---sh-->
    ./aidan < puzzle

    ./aidan seed
```

where `seed` is a number.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This code is formatted differently and is not the approach used by the author
which is slower, inelegant and not as obscure, as the author put it.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `aidan.alt` as you would `aidan` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Are you puzzled about puzzles?  This entry might puzzle you
more while it puzzles out some puzzles: all in a puzzling way!

`goto` the source and notice the lack of functions.  Jump
to the `switch` statement.  And if you think you can puzzle
it out better, try solving [insane1.sudoku](%%REPO_URL%%/2005/aidan/insane1.sudoku) all by yourself!

NOTE: the tarball named by the author was removed after the files were extracted
into the directory instead. These files were added to the list.


## Author's remarks:

This program can solve a type of logic puzzle known as a
[Sudoku](https://en.wikipedia.org/wiki/Sudoku), and also
generate new ones.


### Contents

* program file: [aidan.c](%%REPO_URL%%/2005/aidan/aidan.c) - sudoku solver and generator
* test suite: [test-su.perl](%%REPO_URL%%/2005/aidan/test-su.perl) - optional test script (written for Perl5)
* sudoku file: [blank.sudoku](%%REPO_URL%%/2005/aidan/blank.sudoku)
* sudoku file: [insane1.sudoku](%%REPO_URL%%/2005/aidan/insane1.sudoku)
* sudoku file: [insane2.sudoku](%%REPO_URL%%/2005/aidan/insane2.sudoku)
* sudoku file: [insane3.sudoku](%%REPO_URL%%/2005/aidan/insane3.sudoku)
* sudoku file: [insane4.sudoku](%%REPO_URL%%/2005/aidan/insane4.sudoku)
* sudoku file: [insane5.sudoku](%%REPO_URL%%/2005/aidan/insane5.sudoku)
* sudoku file: [tough1.sudoku](%%REPO_URL%%/2005/aidan/tough1.sudoku)
* sudoku file: [wp.sudoku](%%REPO_URL%%/2005/aidan/wp.sudoku)


Yes, the test suite really is 5 times larger than the actual program. You
**did** say this was a parody of the software development process...


### IMPORTANT

[test.perl](%%REPO_URL%%/2005/aidan/test-su.perl) expects the `sudoku-sf` executable to be
`./sudoku-sf`. If you rename it, please change the definition of `$sf_exe` to the
new name.

**Judges' note**: this was done.


### Legal blurb

This program comes with NO WARRANTY, not even that it'll do what I say it
should. Any misfortunes that occur as a result of using this are not my fault.
Go find some unpopular multinational to sue instead.

This program is not copyrighted and is entirely my work. Distribute or modify
it as you wish, though please give me credit.


### What is a sudoku?

(If you know, feel free to skip this section. Get more details from [the
wikipedia entry](http://en.wikipedia.org/wiki/Sudoku).

A sudoku is a type of logic puzzle. You are given a grid of 9x9 boxes, some
of which contain digits. This is divided into a 3x3 set up, e.g. (from the
Wikipedia article - fairly easy):

```
        . . . | 1 . . | 7 4 .
        . 5 . | . 9 . | . 3 2
        . . 6 | 7 . . | 9 . .
        ------+-------+------
        4 . . | 8 . . | . . .
        . 2 . | . . . | . 1 .
        . . . | . . 9 | . . 5
        ------+-------+------
        . . 4 | . . 7 | 3 . .
        7 3 . | . 2 . | . 6 .
        . 6 5 | . . 4 | . . .
```

You have to fill in the remaining boxes so that each row, column, and smaller
box contains all of the digits 1-9. That's all the information I needed to
figure out how to solve them, but there's a useful tutorial on
<http://www.sudoku.org.uk/>, which is roughly affiliated with the [Daily
Telegraph](https://www.telegraph.co.uk/), a UK newspaper.

Now, with modern computers this **can** be solved using brute force, e.g.:

``` <!---c-->
    #include <stdio.h> /* sudoku-bfi.c */
    #define S(t) for(n=0;n<9;v[n++]=0);for(n=0;n<81;n++)if(i[n]){z=1<<i[n];if(v[t]\\
    &z)for(;;){if(p<0)goto d;if(i[p]++<9)goto f;i[p]=0;p=s[p];}v[t]|=z;}
    int i[82],s[81],v[9],n,p,z;int main(void){for(n=0;n<81;){p=getchar()^48;if(p==
    30)p=0;if(p<10)i[n++]=p;}i[81]=0;p=-1;f:S(n%9)S(n/9)S(n%9/3+n/27*3)if(p>80)goto
    d;for(n=p;i[++p];);s[p]=n;i[p]=1;goto f;d:z=p<81;printf("\n%s!\n\n",z?"Fail":
    "Success");for(n=0;n<81;){p=i[n];printf("%c %s",(p?p|48:'.'),(++n%3?"":n%9?"| "
    :n%27?"\n":n%81?"\n------+-------+------\n":"\n\n"));}return z;}
```

**Judges' note**: this was added as [aidan.alt.c](%%REPO_URL%%/2005/aidan/aidan.alt.c).

That isn't the approach I've used; it's slow (particularly in worst-case or
nearly so scenarios), inelegant, and not a good starting point for sudoku
generation. It's also much too easy to understand ;-) Instead, I've written a
program which solves them in much the same way as I do, only a lot faster (and
hopefully more reliably).

Oh, and if you think that example sudoku is too easy, try this one (which my
program generated):

```
    --- insane1.sudoku --
    . . 4 | . . . | . 5 6
    5 . . | . 7 2 | . . .
    . . 1 | . . . | 8 . .
    ------+-------+------
    . . . | . . . | . . .
    . . . | 6 9 3 | . . 5
    . . . | . . . | 7 3 4
    ------+-------+------
    . 5 . | 2 . 1 | 4 . 8
    3 . . | . . . | . . .
    . . . | . . . | . 6 1
```

Be warned - it's evil! (I certainly haven't been able to solve it by hand. The
brute-force program given above, `sudoku-bfi.c`, [aidan.alt.c](%%REPO_URL%%/2005/aidan/aidan.alt.c),
also has trouble - it took 66 seconds to solve it - but probably for different
reasons. That's the worst performance I've had from brute-force so far!)


### Usage

#### Building

``` <!---sh-->
    cc -o sudoku-sf sudoku-sf.c
```

or, if using gcc, try:

``` <!---sh-->
    gcc -O2 -Wall -Wextra -ansi -pedantic-errors -o sudoku-sf sudoku-sf.c
```


#### Testing (optional)

``` <!---sh-->
    perl ./test-su.perl
```

Note that this requires Perl 5 (I use 5.8.5, earlier versions untested) and is
somewhat slow (should take under a minute on a fairly modern PC - try
appending `-n 0` if you're in a hurry). I wrote it mostly for my own benefit,
really.


#### Solving

``` <!---sh-->
    ./aidan < somefile.txt
```

Input should be the numbers of each row in turn. Empty spaces can be
represented as a full stop (`.`) or zero (`0`). Other characters are ignored, so you
can cut-and-paste either example sudoku puzzle from above into a file and feed that
in. The program has coped with every input I've thrown at it so far, including
an [empty grid](%%REPO_URL%%/2005/aidan/blank.sudoku).

Output consists of the problem, then the solution, then a message of
success/failure.

`./aidan U` may also be useful, or perhaps not. It only took
an extra 15 bytes of (very simple) code to add, so it doesn't really matter to
me. (It's the same as the normal mode for most input you're likely to feed it,
though slightly slower. See if you can figure out what it does.)


#### Generating

``` <!---sh-->
    ./sudoku <seed>
```

Output is a blank grid, then the solution, then the problem. There's no
control over the difficulty. Sorry. However, all generated sudokus should have
exactly one solution - if one doesn't, that's a bug.


### Speed

Fast enough. Solving and generating are practically instant on my 1Ghz Duron.
Of course, there could be some cases which take longer...

More precisely - 400 random sudokus are generated and solved in about 45 seconds
in tests on my PC (1Ghz Duron, gcc 3.4.1, `-O2` optimisation - takes about 60
seconds with no optimisation). If that isn't fast enough, what on Earth are you
doing with it?


### Bugs

None known - hopefully I've worked out all the major ones. Nothing has come up
in testing since the last bug fix, but what does that mean?

Tested on:

- `gcc 3.4.1-3mdk`, Linux/x86

*RETEST* Borland C 4.5, 16-bit DOS .exe (small memory model)

I don't count the fact that it first prints a blank grid whenever asked to
generate a sudoku as a bug - just a minor quirk. The fix is slightly awkward
and would make the program slightly longer, so I haven't bothered - it's not
important.


### Missing Features

* No control over the difficulty of generated sudokus - they vary from easy to
hair-tugging near-impossibility. Solver beware. Seeing as apparently one program
[took six years](http://news.bbc.co.uk/1/hi/magazine/4469719.stm), I'm in no
hurry.


* Some sort of curses-based UI to let you solve interactively might be cool,
but I don't feel like learning curses just for this. Besides, I spent enough
of the time swearing as it is.

* If you mistype a sudoku (e.g. from a paper/magazine) - and you will - it
can't help you figure out where the mistake is, sadly.


### Portability

Dependant on ASCII, requires that an `int` is at least 15 bits and a `long` at
least 32. (No, that isn't a typo - I did say 15, not 16).

Also requires that `cpp` can properly handle something like:

``` <!---c-->
    #define foo(x,y) x y
    foo(bar,)
```

Apparently, a few can't (ANSI C specifically doesn't require that this works,
though it usually does). Unfortunately, I didn't discover this issue until too
late. (It was mentioned in the notes for people modifying GCC in the "beware
of obscure compiler limitations" section, so I'm figuring it's quite unusual.)


### Compiler warnings

Some when compiled with `gcc -Wall -Wextra -ansi -pedantic`:

* The left-hand operand of a comma has no effect in two places.
* Parentheses are suggested around a `+` in an operand of `&` in the `i` macro
definition.

Borland C also spots some code in expressions which has no effect, and some
uses of `=` where you'd expect a comparison operator.


### Obfuscation

Let's see now:

* Squint-inducing variable naming.
* Slightly odd `#defines` (which will be cleaned up by `cpp` + a code
beautifier, but see the next item).
* No functions but `main()` - all code reuse via `#define`s, or by various other
methods (usually somewhat icky ones). This wasn't deliberate - it just ended up
that way somehow...
* `goto`s from everywhere to everywhere else.
* A slightly... interesting `switch` statement.
* Generally odd flow of control (see above items).
* Plenty of bit-twiddling.
* To save space, no `'A'`-style char constants - hard-coded numbers are used.
(There's one, but it isn't used to make things **clearer**).
* `array[index]` notation, because:
    - it's traditional
    - take a look at how the `s` and `N(I,l)` macros are used
* various other little things not worth mentioning.

So basically, just what you'd normally expect in an IOCCC entry.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
