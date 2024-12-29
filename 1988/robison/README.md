## To build:

``` <!---sh-->
    make all
```


## Try:

``` <!---sh-->
    ./robison 80 10
    ./robison 40 16
```

The first and second parameters are optional.  You might also try:

``` <!---sh-->
    ./robison 80 2   # <--- can you find the bug?
    ./robison 80 -246
```


## Judges' remarks:

The following might make an interesting benchmark:

``` <!---sh-->
    ./robison 100
```

[Amdahl 5890-300E with System V cc: 8.40 seconds]

We suggest that you C pre-process and perhaps C-beautify this program.
All is not what it may appear to be in this program.  Why does a `whi1e`
not take a while to execute?


## Author's remarks:

This program shows that C has many unnecessary constructs, in fact
only `while`,`--`, and `>=` are required.  (The two assignments at
the beginning could be avoided if `atoi(3)` was rewritten with this
new paradigm.)  Note that the lack of both the controversial `goto`
and assignment statements makes the meaning crystal clear.  The current
ANSI committee should look into this practical simplification of C.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
