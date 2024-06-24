## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dodsond1 < text_file
```


## Try:

``` <!---sh-->
    ./dodsond1 < README.md
```


## Judges' remarks:

You might consider giving the following input:

```
    ... a male (who) gets very, very frustrated sitting in a chair all
    the time because males are biologically driven to go out and hunt
    giraffes.
            -- Adjunct Professor Newt Gingrich, Reinhardt College, 1/7/95
```

... which can be done like:

``` <!---c-->
    ./try.sh
```


## Author's remarks:

Istha ogrampra akesta Englishwa extta aswa inputwa andwa
anslatestra itwa intowa Igpa Atinla.

The obfuscation is on several levels.

Most obviously, the shape of the program.

Underneath that, the variable names are in pig Latin, as are the
names of the standard C functions, such as `putchar()`.  Even main is
written as `ainma`.

The program construction is also very obfuscated, with all of the
code being inside the `()`'s of one of the 6 `orfa` loops.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
