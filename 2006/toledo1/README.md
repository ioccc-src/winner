## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./toledo1 [0-9][0-9]
```

where `[0-9][0-9]` is a two digit number.


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

For most of the arguments (e.g. those above) the resulting path
is not circular, but at least one starting point yields a circular path.

Why do some of the "illegal" starting points work more or less as could
be expected, and some dump core?


## Author's remarks:

Can you place a knight on a chess board and make it
visit the 64 squares without repeating them?

If not, this program does it, just run it with an argument
giving initial position.

``` <!---sh-->
    ./toledo1 11       # start is A8
    ./toledo1 18       # start is H8
    ./toledo1 81       # start is A1
    ./toledo1 88       # start is H1
    ./toledo1 44       # start is D5
```

It will print move order. The algorithm is so simple that you can read
it in the source code.  At the first glance it can appear checkered.
Nevertheless, don't be dismayed, jar, jar.  :-)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
