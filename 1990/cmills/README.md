## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./cmills [starting_cash]
```


## Try:

``` <!---sh-->
    ./cmills 5000
```


## Judges' remarks:

The Makefile uses several `-D` defines. The following is is a list of the macros
that may be changed:

- `-DM=<max bet allowed>`
- `-DN=<52 * number of decks used>`
- `-DX=<how to seed the rand() generator>`

The macro `V` should remain `void`.

The author noted that a compiler being used assumed that `x=*p++` means `x*=p++`
but do you know why? This is not so strange as it might seem if you look at [C's
history](https://www.bell-labs.com/usr/dmr/www/chist.html). Example code where
this occurs is in John Lions' Commentary on the Sixth Edition UNIX Operating System.


## Author's remarks:

This is a blackjack program.  It does splits, doubling down, insurance, etc.

As best I can figure, it should be ANSI-compliant, as well as portable to BSD &
SysV (as well as the irritating compiler I was using which assumes `x=*p++`
means `x*=p++`!).  It is reasonably robust in its error handling---it won't let
you split, double, etc. unless you actually have the cash, etc.  To terminate
the program, hit `EOF` or type `0` or a negative number for you wager.

The way it deals with splits is particularly cool (IMHO).  You can split many
times, and it will show all hands as they are played.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
