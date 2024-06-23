## To build:

``` <!---sh-->
    make
```

There is an alternate version with vi(m) key movements. See [alternate
code](#alternate code) below.


## To use:

``` <!---sh-->
    ./ctk
```


## Alternate code:

This alternate version adds to the movement keys `l` for right, `h` for left and
`k` for straight.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./ctk.alt
```


## Judges' remarks:

No matter how careful you are, this guy eventually crashes.  Most people
can make at least one successful road trip without crashing.

This is, of course, another of the retro games.


## Author's remarks:

This is a game based on an [Apple
II](https://en.wikipedia.org/wiki/Apple_II_series) [Print Shop
Companion](https://en.wikipedia.org/wiki/The_Print_Shop) [Easter egg][1] named
'DRIVER', in which the goal is to drive as fast as you can down a long twisty
highway without running off the road.  Use `,./`, `[ ]`, or `bnm` to go left,
straight, and right respectively. Use `1234` to switch gears. `q` quits. The
faster you go and the thinner the road is, the more points you get. Most of the
obfuscation is in the nonsensical if statements among other things. It works
best on the Linux console: you get engine sound (!) and the * Lock keyboard
lights tell you what gear you're in (none lit=4th).  The `q` argument (no
leading `-`) will silence the sound. It won't work on a terminal smaller than
80x24, but it works fine with more (try it in an XTerm with the "Unreadable"
font and the window maximized vertically!).

[1]: https://en.wikipedia.org/wiki/Easter_egg_(media)#In_computing


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
