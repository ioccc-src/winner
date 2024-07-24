## To build:

``` <!---sh-->
    make all
```

There is an alternate build (same code, alternate build) that uses more memory.
See [Alternate code](#alternate-code) below for more details.


## To use:

``` <!---sh-->
    ./weisberg
```


## Try:

``` <!---sh-->
    ./try.sh
```

If you have `primes(1)` installed you might also wish to try:

``` <!---sh-->
    ./primes.sh number
```

where `number` is a positive number, defaulting to 15. The
[try.sh](%%REPO_URL%%/1994/weisberg/try.sh) script will also `try` :-) and do
this.


## Alternate code:

If you liked what you saw from the above program, and happen to
have some 512 megabytes of virtual memory lying around with to do
something with you might try this build.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./weisberg.alt
```

Lesser systems will find this alternative version a good way to create
a core file.  :-)


## Judges' remarks:

This entry confuses some C-preprocessors and some C-beautifiers.
We found one cpp that processed this source differently when
it was read on `stdin` instead of via `cc -E`.


## Author's remarks:

### Description

The following short program implements the "Yet Another" algorithm for
generating prime numbers.  It will generate all primes up to 33554432,
displaying them to the standard output as it churns along.  As 33554432
is rather large on most machines, this code may take quite some time to
run to completion, so as an added feature, it will cease execution upon
reception of a signal (any will do equally well), as well as in the
event of a system shutdown or reboot.


### Bugs

The alternative build ([weisberg.c](%%REPO_URL%%/1994/weisberg/weisberg.c)
compiled to `weisberg.alt`) has never actually run
to completion. After running for close to a week it had reached somewhere around
250e6, when it became necessary to test the reboot feature (which worked
remarkably well). As there are quite a lot of primes to be found before reaching
`INT_MAX`, the output produced can be quite overwhelming so it's recommended to pipe
the output through your favorite pager (`more` or `less`), and not output to a
paper output device (unless you have *LOTS* of paper).


### Technical

The original "Yet Another Prime Program" algorithm used here was developed as a
Computer Architecture course micro-programming exercise, and was designed to
take full advantage of the UR300 micro-architecture to achieve blindingly fast
speed. It was ported to C specifically for the IOCCC. In the
conversion/obfuscation step some of (much of) the blazing speed was lost, but as
a bonus, the understandability of the code was reduced to zero.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
