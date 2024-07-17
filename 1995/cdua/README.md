## To build:

We recommend that you try the alternate version first so you can see what this
entry looked like back in 1995 (with a configurable speed).  See the [original
code](#original-code) section below for the original entry.

``` <!---sh-->
    make alt
```

The alternate version uses `usleep(3)` with `SLEEP` (defined in the Makefile,
default `3000`) microseconds to make it easier to see the maze being solved in
real time. You can redefine `SLEEP` at compile time to reconfigure it in case
it's going too slow, too fast :-) or you're doing some strange experiment like
making it 100000 (which is actually fun :-) ).


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [1995/cdua in bugs.html](../../bugs.html#1995_cdua).


## To use:

``` <!---sh-->
    ./cdua.alt
```


## Try:

``` <!---sh-->
    make SLEEP=1500 clobber alt

    ./cdua.alt # press enter and watch it go much faster!
```

You might also like to try:

``` <!---sh-->
    make SLEEP=65000 clobber alt

    ./cdua.alt # press enter and watch it go much slower!
```

Do you see anything strange in this version when `SLEEP` is a high value like
`65000`? What happens if you use `100000`? Is this strange output still there?
Why?


## Original code:

With modern systems this was hard to see it solve it in real time because it
goes so quickly which is why we recommend the alternate version first: you can
actually see it being solved in real time rather than have it go by in a flash.

If you wish to use the original version, for instance if you wish to see how
fast your computer is :-) or use both to see the difference, you can do so.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

``` <!---sh-->
    ./cdua
```


## Judges' remarks:

This could be used as the basis of an a-maze-ing screen exerciser.


## Author's remarks:

A program that generates a maze, and then solves it, all this being seen by the
user.  Some highlights of obfuscation are: 3 step function in one - `main()`,
several recursive calls with conditional actions, and just one (big and ugly)
statement to solve the maze.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
