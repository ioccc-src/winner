## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./august
```


## Try:

``` <!---sh-->
    ./try.sh
```

If you have the `primes(6)` tool (sometimes part of
[BSD Games](https://github.com/vattam/BSDGames)) you can see
what of the output in the first `N` (say `15` or `25`) lines are primes:

``` <!---sh-->
    ./primes.sh # 15
    ./primes.sh 25
```

Note that `try.sh` will run this script anyway, telling you where to get
`primes(6)` if you don't have it installed, but it will only run with the
default value of 15, rather than trying several different values.


## Judges' remarks:

An interesting use of a recursive call to `main()`.  Compile and execute
without args.  What is the initial value of `b`? Does it alter the
action of the program?

If you let it, the program will continue to print a numerical sequence (can you
guess in what base it is printed by looking at the code?) until you run out of
memory or until they sell your computer, whichever comes first.

If you use the [primes.sh](%%REPO_URL%%/1985/august/primes.sh) script can you figure out if there's
anything funny going on with the output?


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
