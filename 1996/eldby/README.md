## To build:

``` <!---sh-->
    make alt
```

We recommend that you use the alt version to see what the entry looked like back
in 1996. For the original version see the [original code](#original-code)
section.


## To use:

``` <!---sh-->
    ./eldby.alt
```

To quit send intr (typically ctrl-c).

**NOTE**: to reset the sanity of your terminal after this program ends try `reset`.


## Try:

This alternate version, which we recommend that you use in order to see what is
happening with modern systems, and to not flash too quickly, which can be
problematic for some people, can be configured to different speeds by way of the
value used in `usleep()`. The default is `35000` but you can easily change
it. To do so try:

``` <!---sh-->
    make SLEEP=20000 clobber alt
    ./eldby.alt
```


## Original code:

This version is the original which has no sleep time in between updates.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

Use `./eldby` as you would `./eldby.alt` above.


## Judges' remarks:

We were impressed by the author's ability to render spheres in 3D
in a very small chunk of code.


## Author's remarks:

This program shows flying spheres. The program eats CPU on lesser
equipped systems. The program will run until termination. Terminals
must be VT100 or better with 80 columns and 24 rows or more.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
