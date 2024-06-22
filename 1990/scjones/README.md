## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./scjones
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

The addition of trigraphs has made it easier to make programs hard to read.  It
was a dark and stormy night for C when the ANSI C committee added trigraphs to
the standard.  Too bad that they didn't just simply require a more reasonable
ISO character set.

The Author sent us this note after he was informed that he won:

> Although I am quite grateful for the "`ANSI Committee's Worst Abuse of C`" title
(were you aware that I am a member of the committee or is the double meaning
unintentional?), I was really hoping for something more along the lines of
"`Closest Resemblance to Line Noise`."  :-)

... it was unintentional.


## Author's remarks:

Since this year's contest is dedicated to ANSI C, here is a strictly conforming
entry.  In accordance with the ANSI definition of a strictly conforming program
it does not produce output dependent on any unspecified, undefined, or
implementation defined behavior, and it does not exceed any of the minimum
implementation limits.  It adheres to all of the syntactic and semantic
constraints of the standard: it `#include`s the relevant headers for the
functions it uses, and it uses the `EXIT_SUCCESS` and `EXIT_FAILURE` macros to
return a correct success/fail status to the invoking program.  It also uses
trigraphs for characters which are not in the `Invariant Code Set` of `ISO
646:1983`, so it will be portable to machines with deficient (from C's
standpoint) character sets.  In short, it should be very widely portable.  As an
extra added attraction, all of the lines are under 72 characters long, which
would allow for sequence numbers to be punched in columns 73-80 :-).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
