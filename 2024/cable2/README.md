## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/cable2 - Prize in murky waters](https://www.youtube.com/watch?v=RMI5oT9U4vc)


## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

Some terminal applications do not handle all Unicode characters adequately.

On Linux, it is better to enjoy this entry on `gnome-terminal` or an equivalent modern terminal emulator.

## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

We had a few minutes of amazement and fun while figuring that the is
something fishy 🐠 wit the [prog.c source code](%%REPO_URL%%/2024/cable2/prog.c).

Those who follow the philosophy of "_seeing is believing_" are
likely to be "_deceived_" when they try to view the
[prog.c source code](%%REPO_URL%%/2024/cable2/prog.c) in a terminal window:

``` <!---sh-->
    cat 2024/cable2/prog.c
```

**HINT**: There is a command line flag to the `cat(1)` tool may provide a clue.

**HINT**: For those who might not be familiar with the
[U"string" literal prefix](https://en.cppreference.com/w/cpp/language/string_literal.html):
When using the U literal prefix, anything inside the quotes is encoded as **UTF-32**.

**HINT TO FUTURE SUBMITTERS**: Now that we have awarded
this **clever entry**, please understand that this
[salmon is now old hat](https://en.wikipedia.org/wiki/Salmon_hat).
What was **murky waters** for **IOCCC28** in 2024 will, in the future,
be immediately seen through when analyzing future submissions to the IOCCC.
In other words, to win a future IOCCC, you will need to do **MORE**
than simply employing this fun obfuscation trick!  :-)


## Author's remarks:


Salmon: a most fishy submission


#### About

This program obviously prints the squares of the numbers from 1 to 10. Or does it? The author got a little hungry for char-grilled salmon, and there's clearly something fishy going on with those unused #defines. Or is there? What the actual f*sh is going on here? Follow the three steps below for maximum enjoyment.

**Step 1:**

``` <!---sh-->
    cat prog.c
```

**Step 2:**

``` <!---sh-->
    make clobber all
```

**Step 3:**

``` <!---sh-->
    ./prog
```

Scratch head. Then, [slap head with fish](https://www.youtube.com/watch?v=T8XeDvKqI4E).

You may suspect there's something fishy with the `Makefile`, but you would be wrong. It just invokes `cc -o prog prog.c`

You may suspect `cat` might be eating the salmon in step 1 (see `2015/endoh2`), but you would be even wronger. Confirm by looking at the program source using GitHub or `emacs` or `nano`.

You are probably now even more confused, in which case, return to step 1.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
