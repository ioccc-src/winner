Award: Consistently constant award

## To build:

``` <!---sh-->
    make all
```


## Try:

``` <!---sh-->
    ./prog | cat

    ./prog > out
    cat -v out
```


## Judges' remarks:

A little poem, no AI - just free,<br>
something from us, for all to see:

```
    Beneath the hush of calculus’ breath,
    Where limits dance with range and depth;
    There stirs a number, whose exponent is there,
    With complex cycles, and digits to spare.

    With compound interest, from balance may rise,
    That swells beneath the banker’s eyes;
    A meager value that starts out small,
    With time expands and value grows tall.

    So set the terms: at a rate of one per span,
    Compounded n times, then let n ascend;
    Whose decimal digits, one may behold,
    That goes on without end, no matter how old.

    View the source, a variable you see,
    Single and clean, not needing three;
    Base 10 digits grow vast, a boundless sea,
    Follow that number, what will it be?
```


### A fun challenge


#### Fun challenge 0

Are you able to explain why [prog.c](%%REPO_URL%%/2025/dogon/prog.c) prints
only a limited number of digits of the **constant*?

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


#### Fun challenge 1

Given the "*constant*" that is printed, explain the last line of output:

``` <!---sh-->
    ./prog | tail -1
```

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


#### Fun challenge 2

Generate an alternative version of [prog.c](%%REPO_URL%%/2025/dogon/prog.c), named `prog.alt.c`,
that prints **IOCCC 2025** at the very end, in honor of the contest year in which it won, instead of **IOCCC 2026**.
Of course, the digits printed beforehand should remain the same.

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


#### Fun challenge 3

Additionally, observe the [try.sh](%%REPO_URL%%/2025/dogon/try.sh) script uses the
following display the program's output:

``` <!---sh-->
    ./prog | cat
```

However, the following may, for some environments, will print what seems like garbage:

``` <!---sh-->
    ./prog
```

Explain why this command:

``` <!---sh-->
    ./prog | cat > foo
```

may produce, for some environments, different output than the following command:

``` <!---sh-->
    ./prog > bar
```

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


## Author's remarks:


### A little song (and no dance)

>  What this program does is plain to see,
>  as the only one variable it uses is e.
>  No other identifiers there you'll discern,
>  except the required printf, calloc, and main.
>
>  The constant is printed, to quite a few digits,
>  yet there's none in the source, you'd better believe it.
>  Yes, "Where are the constants inside?" you may wonder,
>  No Zero, nor One, and none any other.
>
>  "What of string constants?" You might indeed ask.
>  So many printfs, they must have formats,
>  but none will you find, no there is no trick,
>  All prints are achieved by some arithmetic.
>
>  The program's a bit longer than it should be,
>  as it tries to support also big endianity.
>  Though try it does, there is a small snag,
>  there's no CCOI contest, I guess it's a bug!


### And some history

An earlier version of the entry was written more than a decade ago, and
failed to make it. The only simple simple change in the output updating
2015 to 2026 was quite a bit of a challenge, which means indeed the
level of obfuscation is considerable.

The remarks song was written a decade ago too, so, no AI chatbot was
abused, and its an entirely original work.

Indeed, the program is treading some familiar themes and there's
been the 1989/roemer entry, but it had lots more variables and
constants. I'd say this entry is the C programming constrained writing
[OuLiPo](https://en.wikipedia.org/wiki/Oulipo) inverse of Perecs [A
void](https://en.wikipedia.org/wiki/A_Void).


### A note about the layout

This was the other main change of the original. Indeed the layout is
quite extremely sparse and has to be viewed with tabstop 8, and a rather
big terminal. And then take limit at infinity :)


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
