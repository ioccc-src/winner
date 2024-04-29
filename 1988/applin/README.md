## To build:

``` <!---sh-->
    make all
```

A smaller version, originally called `zsmall.c` (and still exists as such, as
the source of the alt code), of [applin.c](%%REPO_URL%%/1988/applin/applin.c), can be found in
[applin.alt.c](%%REPO_URL%%/1988/applin/applin.alt.c).  Your machine may have an easier time with this
program.  See the [Alternate code](#alternate-code) section below for details.


## Try:

``` <!---sh-->
    ./applin
```


## Alternate code:

As noted above a smaller version can be used in case your `cpp` has a hard time
with this entry.


### Alternate build:

``` <!---sh-->
    make alt
```

Use `applin.alt` as you would `applin` above.

#### History about the smaller version:

Way back in 1988 ..

This entry took 75 minutes to compile on a Amdahl 5980-300E (a 55658
Dhyrstone/sec/cpu machine) using the System V `cpp`.  (The GNU `cpp` when defined as
`BIG_CPP` took only 45 seconds.)

Your `cpp` may not be able to compile it due to a common bug that results in
`cpp` running out of space.  The routine
[zsmall](%%REPO_URL%%/1988/applin/applin.alt.c) is a smaller version
of the [applin.c](%%REPO_URL%%/1988/applin/applin.c) entry.


## Judges' remarks:

This entry is by far the most unusual abuse of the C preprocessor that
we have received thus far.  Nearly all of the real work is done in the
C preprocessor!

When we compiled [applin.c](%%REPO_URL%%/1988/applin/applin.c) on an
[Amdahl](https://en.wikipedia.org/wiki/Amdahl_Corporation) 5890-300E, we found that it
spent over 75 minutes in the System V C preprocessor!  Besides showing that the
standard System V `cpp` is slow, it showed that it contained a memory usage
problem.  The [applin.c](%%REPO_URL%%/1988/applin/applin.c) only uses 29 different preprocessor symbols
(besides `stdio.h`) and yet the preprocessor ran out of space!

The GNU C preprocessor took under 45 seconds to perform the 2nd pass
on the Amdahl 5890-300E.  But due to the ANSI-likeness of GNU `cpp` (v. 1-21),
it was not able to cleanly substitute a symbol that began with a '#'.
Clearly the GNU C preprocessor is faster.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
