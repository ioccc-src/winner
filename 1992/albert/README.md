## To build:

``` <!---sh-->
    make all
```


An [alternate version](#alternate-code) exists that fixes a bug.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: known bug - please help us fix
```

For more detailed information see [1992 albert bugs](../../bugs.html#1992_albert).


## To use:

``` <!---sh-->
    ./albert number
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

An alternate version of this entry, [albert.alt.c](%%REPO_URL%%/1992/albert/albert.alt.c), is provided.
Leo Broukhis, before he was an IOCCC judge, sent the IOCCC
judges this Email message:

```
    From: leo _at_ zycad -dot- com (Leo Broukhis)
    Date: Tue, 30 Jan 96 17:37:51 PST
    To: judges _at_ toad -dot- com
    Subject: IOCCC 1992 - a bug

    Dear Judges,

    albert.c (even in its fixed form) still has a bug. Although I don't
    remember the number that exposed the bug (afair, resulting in coredump)
    in albert.orig.c that has been fixed in albert.c,

    I've found a number exposing another bug: 10000000001 (that's 9 0's).
    Both albert and albert.orig loop without printing anything, although
    the first factor is 101 and is usually found in an instant.
```

The [albert.alt.c](%%REPO_URL%%/1992/albert/albert.alt.c) file is the fixed file, whereas the
[albert.c](%%REPO_URL%%/1992/albert/albert.c) is the file before applying Leo Broukhis' fix.


### Alternate build:

To compile this alternate version:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `albert.alt` as you would `albert` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

We were impressed with the speed at which it was able to factor
arbitrarily large numbers consisting of factors that fit into
a long.


## Author's remarks:

The Obfuscated version of the Horst algorithm.

This program will factor unlimited length numbers and print the
factors in ascending order. Numbers of one digit (e.g. 8)
are rejected without notice.

It quits as soon as there is at most one factor left, but that factor will not
be shown.  It accomplishes this efficiently, without resorting to division or
multiplication, until the candidate factor no longer fits in a signed long.

The nicest way is to rename the program into e.g. 4294967297
if you want to factor Fermat's 4th number. Then just run it.

Or you may type `./albert <some-number>`
A nice one is also (30 ones):

``` <!---sh-->
    ./albert 111111111111111111111111111111
```

Apart from the foregoing there are no special execution instructions.

To customize the program into a factorizer of a fixed number, use

``` <!---sh-->
    cc albert.c -o 4294967297
```

or some such.

There are no data files used, and it is not possible to feed input
via `stdin`.

I think this program is a nice example of algorithmic obfuscation.  Several
times two similar algorithms are merged into one. Then you need quite some
tricks to get it running, such as long jumps through recursive subroutines. I
felt like a sword smith, welding the sword very long, folding it again to the
proper length, keep on hammering till it is tight, then fold again.  Always
keeping it at the proper red hot temperature, but not too hot lest the hardness
fades.

The strict naming conventions for subroutines did not make things much clearer
after all, but it was not supposed to.

I would like to draw attention to the robustness of the program with respect to
error handling and the nice stopping criterion.  The aesthetic appeal of some
lines is at the expense of clearness, I apologize.

Running the program through the C-beautifier reveals nothing, it will only
destroy some of the lay out.  Running the program through lint shows the usual
remarks for a K&R program. Defeating this through casts does not make a program
cleaner in my opinion.

### Hints

Here are some hints, but they may not be too helpful:

1. The Horst algorithm is described in the Hobby Computer Club Newsletter, year
82, part 4, a real Dutch treat.  Assembly, C and Forth version have been around
for some years.
2. Does fractal programming exist after all?
3. You remember the Toom-Cook algorithm in Knuth?  It uses iteration instead of
recursion and is quite jumpy.  This program shares these disadvantages in a
modified form.
4. The Conversion is to be found in Knuth, not so the Observation.  The
Observation: "if it ends in a zero, it is divisible by ten".


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
