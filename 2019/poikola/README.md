## To build:

``` <!---sh-->
    make
```

There is an alternate version of this program which changes the way the output
is displayed. See [Alternate code](#alternate-code) below.

NOTE: we disable the optimiser because the author stated that for GCC optimiser
level 0 gave correct output. With clang `[0123s]` works which suggests that [123s]
might or might not work with GCC. Likewise, we do similar for the standard,
forcing `-std=gnu11`.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2019/poikola in bugs.html](../../bugs.html#2019_poikola).


## To use:

``` <!---sh-->
    ./prog 512 ./prog

    sleep 86400; make clobber prog
    ./prog 512 ./prog

    sleep 86400; make clobber prog
    ./prog 512 ./prog
```

If you wish for some documentation:

``` <!---sh-->
    make docs
```

This will create the file `poikola.pdf` for your enjoyment.


## Try:

If you don't have a few days, try:

``` <!---sh-->
    ./try.sh
```

As the [2019/poikola in bugs.html](../../bugs.html#2019_poikola) says, this program will not validate
input so it might get stuck or fail if invoked erroneously.


## Alternate code:

This version prints a newline after each number for parsing in other ways than
what can be done with the original entry.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Do you have the time to see what this program does?  Think again, come back and
try again.

Note that [2](https://t5k.org/curios/page.php/2.html) can be said to be the
least [odd](https://en.wikipedia.org/wiki/Parity_&#x28;mathematics&#x29;)
[prime](https://en.wikipedia.org/wiki/Prime_number) because it is the greatest
[even](https://en.wikipedia.org/wiki/Parity_&#x28;mathematics&#x29;) prime.  Moreover `2`
can be also said to be the greatest odd prime because it is the least even
prime.

The source code layout and some of the variable names honors the ski jumping
accomplishments of [Matti
Nyk&auml;nen](https://en.wikipedia.org/wiki/Matti_Nyk%C3%A4nen).


## Author's remarks:

### How to build:

``` <!---sh-->
    gcc -O0 -o prog prog.c
```

or

``` <!---sh-->
    clang -O[0123s] -o prog prog.c
```

e.g.:

``` <!---sh-->
    clang -O1 -o prog prog.c
```


### Poster:

You can generate an A3 sized poster by `make docs`. This command creates a pdf
file `poikola.pdf`. This requires the
[pdfTeX](https://en.wikipedia.org/wiki/PdfTeX) tool.


### What this entry does:

An old wise man mumbled to me:

```
    Implement a program, which can calculate SHA-3 checksum for a file --
```

I thought it was easy, but the wizard didn't stop yet:

```
    and primes and Fibonacci numbers.
```

Still easy. But the [Gandalf the
Grey](https://www.glyphweb.com/arda/g/gandalf.html) impersonator was not ready:

```
    But use only `main()`, and do not use `math.h` nor predefined stuff at all.
```

But wait, there are more rules: This work should reflect the extraordinary mind
of Matti Nyk&auml;nen, the all-time best [ski
jumper](https://en.wikipedia.org/wiki/Matti_Nyk%C3%A4nen) and [amateur
philosopher](http://telefinn.blogspot.com/2011/11/matti-nykanen-quotes.html),
who passed away on fourth of February 2019.


### Oh boys:

So, I followed the rules given by [Gandalf the
White](https://www.glyphweb.com/arda/g/gandalf.html) and the [Judges of
the IOCCC](../../judges.html).

Output of `iocccsize`, using the [2019 version of
iocccsize](%%REPO_URL%%/2019/iocccsize.c), is carefully selected.  For
the sake of clarity, I used single letter variables in the code. I also avoided
unnecessary use of functions.  Like a
[tripundra](https://en.wikipedia.org/wiki/Tripundra), this program has three
levels.  In order to reveal all of them, you have to compile this program on
three consecutive days.

As this is a contest for obfuscated code, the program does not perform
unnecessary checks, but either fails or gets stuck if invoked erroneously. The
program is invoked in this way:


``` <!---sh-->
    ./prog <integer> <file>
```

where `<integer>` is 224, 256, 384, 512 or even 1024. Yes, I know 1024 is not a
supported length of output, but as I said, the program does not validate its
input in any way.  These same parameters should be given in calculating a
[Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence) or [prime
numbers](https://en.wikipedia.org/wiki/Prime_number). *Please note that maximum
file size is one gigabyte*!


### Obfuscation:

*Matti Nyk&auml;nen*: Every time I jump, and I get that feeling of _bon voyage_,
the feeling that I've been here before.

*Matti Nyk&auml;nen*: When you are about to jump, you are all alone and have to
make your own decisions. Up there, it's all _up yours_.

This code has some jumping too. I used some `goto`s instead of `longjmp(3)`. Some
Finnish [ski jumping](https://en.wikipedia.org/wiki/Ski_jumping) sites are used
as labels, however, there is `lahti` instead of
<span style="font-family: monospace;">salpausselk&auml;</span>.


### SHA-3-512 Compatibility chart ###

Tested against [test vectors](https://www.di-mgt.com.au/sha_testvectors.html).

`Clang` (version 4.0): For optimization levels `[0123s]`, the program compiles and produces
correct output for every tested vector using the C standards c11, c89, c90, c99,
gnu11, gnu1x, gnu89, gnu90, gnu99, iso9899:1990, iso9899:199409, iso9899:1999
and iso9899:2011 (argument of `-std=`).

`GCC` (version 6): For optimization level 0, correct output using the C
standards c11, c99, gnu11, gnu1x, gnu89, gnu90, gnu99, iso9899:1999 and
iso9899:2011.


### Missing a prime

For obvious reason, the [oddest
prime](https://mathworld.wolfram.com/OddPrime.html) is missing from output.


### Observations

`gcc` and `clang` are very fragile compilers. I spent numerous hours trying to
achieve exactly the same output from different optimization levels and
compilers. Small change in code can produce really unexpected results, i.e. the
compiler can skip a few expressions or statements without obvious reason.


### Major spoilers

It is commonly believed that [Mike Keith's
algorithm](http://www.cadaeic.net/calendar.htm) published in _Journal of
Recreational Mathematics_, Vol. 22, No. 4, 1990, p. 280, is the shortest way to
calculate the day of the week for a given date.

#### Keith's versus my algorithm

Kieth's algorithm is `(d+=m<3?y--:y-2,23*m/9+d+4+y/4-y/100+y/400)%7`. I noticed
that `(23*m/9+(m<3?y--:y-2)+d+4+y/4-y/100+y/400)%7` is one character shorter. In
my solution, `m<3?y--:y-2` is used directly, instead of assigning a value to
`d`.

`Q` is pronounced in Finnish exactly like `kuu`, a word for
[month](https://en.wikipedia.org/wiki/Month) or the
[Moon](https://en.wikipedia.org/wiki/Moon). So, `Q = k` is intended.

Last term of outputted [Fibonacci
sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence) is the last one
smaller than 2<sup>64</sup>. It is a plain but funny coincidence
that the value of `^` is 94 in [ASCII](https://en.wikipedia.org/wiki/ASCII).

For [prime calculations](https://en.wikipedia.org/wiki/Prime_number): I recycled
code from my high school C-programming course. Originally, I wrote it over 20
years ago. My teacher said that it is (too) complicated to use bits stored in
arrays, so I did it.


### Other stuff

[Cody Boone Ferguson](../../authors.html#Cody_Boone_Ferguson): I really like that you enjoyed my
previous entry. I hope that you will like this entry too.  Because I did not
want to give too many clues to [the Judges](../../judges.html), I tried to write this
entry in a different way than [Most Stellar](../../2018/poikola/index.html), but in this
code there is at least one recycled thing from it. By the way, the answers to
the questions I posed: (1) 255. (2) Try to compare binary representations of
those `float`s and binary representation of the string "`25th IOCCC!`". (3) I
don't know. I used standard [trigonometric
functions](https://en.wikipedia.org/wiki/Trigonometric_functions) from
[math.h](https://en.wikipedia.org/wiki/C_mathematical_functions#Overview_of_functions)
for rotating the [Big Dipper](https://en.wikipedia.org/wiki/Big_Dipper) and
later replaced those functions with my own implementations.  But there was a bug
in my code and the effect was more beautiful than intended.  I did not even
debug this bug and now it works as a feature. (4) It is not possible. If you
change a single bit, the [Fletcher's 16
checksum](https://en.wikipedia.org/wiki/Fletcher%27s_checksum#Fletcher-16) does
not match anymore and `goto` jumps to the end of the code.

I see that one of the [Volker
Diels-Grabsch](../../authors.html#Volker_Diels-Grabsch)'s winning entries is
awarded the category [Most self-aware](%%REPO_URL%%/2019/diels-grabsch2/prog.c). In last
year, my entry incorporates the [Fletcher's 16
algorithm](https://en.wikipedia.org/wiki/Fletcher%27s_checksum#Fletcher-16) to
ensure integrity of code. One of my first ideas for this year was to do the same
thing, but with [SHA-3](https://en.wikipedia.org/wiki/SHA-3). Using Fletcher 16,
calculating a [checksum](https://en.wikipedia.org/wiki/Checksum) which matches
with `sleeping time factor` took about one minute.  I realized that SHA-3 even
with 224-[bit](https://en.wikipedia.org/wiki/Bit) output could take too much
[CPU](https://en.wikipedia.org/wiki/Central_processing_unit) time.

I would like to say _thanks_ to PSP, because there were not too many
interruptions during the coding phase.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
