## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [1998/schnitzi in bugs.html](../../bugs.html#1998_schnitzi).


## To use:

``` <!---sh-->
    ./schnitzi n > sort.c
    make sort
    ./sort
    # enter three numbers, space separated

    echo x y z | ./sort
```

where `n` and `x`, `y` and `z` are numbers.


## Try:

``` <!---sh-->
    ./try.sh
```

What happens if at the command line you don't specify `n` numbers that the
program expects? For instance try:

``` <!---sh-->
    ./schnitzi 5 > sort.c
    make sort

    # try running the next command four or five times:
    echo 2 5 3 1 | ./sort
```

Why does this happen?


## Judges' remarks:

This is a beautiful program.  How can a program with no conditional (except for
the fixes for modern systems) behavior at all have output which
depends on anything?

For hints on deciphering this, see below past the Author's remarks;
they're a nice summary, but they leave the mystery intact.

BTW: the author notes an incredible lipogram story called
[Gadsby](https://www.gutenberg.org/cache/epub/47342/pg47342.txt) which has no
letter E in the story. He did not note this but it has over 50000 (50 thousand)
(!!) words without the letter E which is one of the most common letters!


## Author's remarks:

In literary circles, there is a poetic form called a "lipogram",
which is a poem in which a specific letter has been distinctly
avoided.  This principle can be applied in other ways.  For
instance, in this paragraph, the vowel which immediately follows
`t` in the alphabet is nowhere to be seen.  There is even an
entire novel (E. V. Wright's "Gadsby") in which no word contains
the letter `e`.

The IOCCC has been no stranger to this concept.  Several winning entries from
years past have accomplished interesting feats while completely avoiding the use
of certain C constructs thought to be essential (e.g.,
[1988/robison.c](%%REPO_URL%%/1988/robison/robison.c) file).  If you have to ask why they would
do it this way, then this contest just isn't for you.

In continuing with this fine tradition, this program suggests to the ANSI
committee some new practical simplifications for the C language.  For instance,
it appears that CONDITIONAL BRANCHING isn't really necessary.  So, we can do
away with `while`, `do...while`, `for`, `if`/`else`, `switch`, `?:`, or anything
else that might cause any kind of non-deterministic jump in the code.  There's
too much uncertainty in the world anyway.

Function parameters and return types just confuse people anyway, so
get rid of them.  Same with local variables.  In fact, all you really
need are assignment statements, and maybe one `printf(3)` and one `goto`.

This style of programming is also ideal for systems with limited
memory capacity, since the function call stack never goes beyond
a depth of one.

So what does it do?  Give it an integer `(1 < n < 27)` on the command
line, such as

``` <!---sh-->
    ./schnitzi 5
```

The output will itself be a lipographic program, one which expects input of
(in this case) five numbers and prints them out sorted.  It sorts
them, however, using only `if/else` statements, without arrays or
looping.  To see the resulting program run, redirect the output from
`schnitzi` into another file, like this

``` <!---sh-->
    ./schnitzi 4 > sort.c
```

and then compile it.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### Obfuscation hints:

The big key to this program is figuring out what the names of the
functions ought to be; a bit of research may allow you to guess at
a few crucial ones.

The only function ever called is `O`, but `O` is just set to point to
other functions all the time.  Or, almost all the time.

So how does `h` get set, and what to?


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
