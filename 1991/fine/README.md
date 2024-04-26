## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    echo text | ./fine
```


## Try:

``` <!---sh-->
    ./try.sh
```

Make sure that you read the last line backwards! Credit goes to [Merlyn LeRoy (Brian
Westley)](../../authors.html#Brian_Westley) for that. See his 22 August 1992
[rec.puzzles
post](https://groups.google.com/g/rec.puzzles/c/z_xVPMRVBtg/m/lyEYSAeBD4gJ).
Some others come from his 1989 entry as well. To
those who have a harder time reading backwards it says: `Gary lent the rug`,
rotated from `the rug gary lent`!


## Judges' remarks:

This filter, 80 chars plus a newline, fits into a single line on most
terminals, unless your terminal has a line wrap mis-feature :-).

Note in 2023: fixing this entry to work with modern systems increased the size,
originally to 106 characters but it was dropped back down to 80 with clever use
of the Makefile.

This entry is likely one of the smallest C implementations of this
filter, excluding programs that resort to command line or include
file tricks.

How does this program work?  Which 3 bytes of C code can be changed
into 2 bytes, allowing the program to still work, but also stripping
the high bit off some input?


## Author's remarks:

The author wishes to thank J Greely for the last 6 bytes.

Here's about how it does it:

NOTE:  Bits are referred to as 76543210, high to low.

1.  Get the character in variable `a`.  Note the fun way we check for `EOF`.
    (thanks J).

2.  Reverse bit 6, and strip bit 5.  Bit 6 determines (mostly) whether
    or not this character is a letter.  Bit 5 would determine case if
    we cared.  Assign this value to variable `b` (We need to save it,
    since we need to make 2 comparisons and maybe one operation with
    this value).  We can't abuse our first variable, since it saves the
    bits we're changing.

3.  Check this value to see if it is a letter.  It must be non-zero -
    if it is zero, then we have either the `@` (64) or the
    `` ` `` (96).  It also must be less than 27 - this checks the
    range for letters as well as implicitly checking the value of bit 6
    (if it was originally clear, it is set now, so `b` would be too big).

4.  If it is not a letter, the conditional expression inside of the
    `putchar()` returns the original character (`a`).  Otherwise, it
    returns a really messy expression that performs the actual rotation
    and fixes the fifth and sixth bits:
    * A.  Subtract 1, to get into the range 0-25 (for the modulo operation).
    * B.  Add 13 to the character.  Steps A and B are combined.
    * C.  Take this modulo 26 to make the addition wrap around.
    * D.  Fix bits 5 and 6, based on variable `a`.
    * E.  Add 1 back in (we took it out in step A.)  This is okay to do *after*
    step D, because we know the addition won't trickle up past the fourth bit
    (`b` would have to be 31 for this to happen).

Notice that this implementation operates only on characters with the
high bit clear.  The high bit can be ignored without changing the size
of the program.  Also, if you know you are only dealing with seven bit
data, the size can be reduced by one byte.  These are left as exercises
for the student.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
