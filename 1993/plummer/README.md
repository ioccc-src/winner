## To build:

``` <!---sh-->
    make alt
```

We recommend that you try the alternate version first to get a better idea of
what this entry looked like back in 1993. The alternate version sleeps (via
`usleep(3)`) in between writes, defaulting at 1000 microseconds (but
reconfigurable). If you wish to see the original entry then see [original
code](#original-code) below.

If you wish to speed the entry up, say to 500 microseconds between writes, try:

``` <!---sh-->
    make clobber SLEEP=500 alt
```

Alternatively if you wish to slow it down, say to 1500 microseconds between
writes, try:

``` <!---sh-->
    make clobber SLEEP=1500 alt
```


## To use:

``` <!---sh-->
    ./plummer.alt number arg
```

where:

- number is a number    (try 21701)
- arg is any argument

Wait until you're bored enough to send intr/ctrl-c to exit or until the
[Vogons](https://hitchhikers.fandom.com/wiki/Vogon) build that [hyperspace
bypass](https://hitchhikers.fandom.com/wiki/Bypass).


## Try:

``` <!---sh-->
    ./try.alt.sh

    ./try.alt.sh 21701

    SLEEP=500 ./try.alt.sh

    SLEEP=900 ./try.alt.sh 789789789789789

    ./try.alt.sh 789789789

    SLEEP=400 ./try.alt.sh 42424242424242

    SLEEP=1000 ./try.alt.sh xyzzyzzyx

    SLEEP=1200 ./try.alt.sh xyzzyzzyx 5555
```


## Original code:

This version, the original, does not sleep in between writes, and is thus much
faster, at least with modern systems.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

Use `plummer` as you would `plummer.alt` above.


### Original try:

``` <!---sh-->
    ./try.sh

    ./try.sh 21701

    ./try.sh 789789789789789

    ./try.sh 789789789

    ./try.sh 42424242424242

    ./try.sh xyzzyzzyx

    ./try.sh xyzzyzzyx 5555
```


## Judges' remarks:

For extra credit: What happens when 'number' contains non-numeric
characters, and why?


## Author's remarks:

This program prints out all numbers up to a given number of digits
on a single line.  When the largest number is reached, the program
starts again with 0.  It takes two arguments: the first argument
specifies the number to start counting from and uses leading `0`s to
indicate the number of digits, the second argument can be anything
but must be present.

Variable names are single characters chosen for their similarity to other
characters (`O` for `0` (zero), `l` for `1` (one), `S` for `5` (five) in some
fonts, and `_` for ...  well nothing really, but it is easy to miss).  To
prevent the need for `strlen(3)`, the fact that argv is laid out sequentially is
exploited (i.e.  `argv[i + 1] == argv[i] + strlen(argv[i]) + 1`).  This is not
portable (by the books), but it seems to work everywhere I try (actually, for
VMS, that only holds for `i > 1`).  Also, I depend on the fact that a carriage
return causes the line just written to be overwritten. `lint` (and most
compilers) complain that there is no control path leading to a return from
`main()`.  At 125 characters, it still fits on a single line (for those of us
who don't mind ruining our eyes with 132 column screens).

### Deobfuscation:

The first statement points the base of `l` (the argument vector) to
be the first argument by incrementing it.  It then assigns `O` to
point to the character before the first character of the second
argument which also happens to be the `NUL` termination of the first
argument.  `*O` gets a `\r` assigned to it.  Finally `0` is assigned to
the first character of the second argument which has the effect of
`NUL` terminating the first argument after the carriage return had
removed its `NUL` termination.  I really tried to make the last part
of that statement part of the original expression, but the best I
could do was attach it with a comma (against the advice of K&R).
The for loop runs the next for loop continuously (actually until
the machine crashes or the user gets tired of seeing the
counting). The next for loop is the meat of the program.  In the
initialization statement, the string pointed to by `l` (the first
argument containing the digits used for counting followed by a `\r`)
is printed, and `_` is started at the least significant digit in the
string.  In the test portion, `_` is ensured not to be past the
beginning of the string (the most significant digit), and the digit
pointed to by `_` is incremented and checked to be sure that it _is_
greater than `9` (written here as `(S+*O+S)*S`).  If the test fails,
either the string has been incremented or each digit in the string
has been reset to `0`.  If the test succeeded, the iteration
statement assigns `0` (written here as `(S+*O)*S` (which has the
added bonus of having the code be a cry for help)) to `*_` and
decrements `_` to point to the next more significant digit to be
incremented; it is done only when a carry situation results (`*_` has
been incremented past `9`).

The inspiration for this program came from actual code which dealt
with scanning for a unique temporary filename by appending a
successively larger number to the end of a string.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
