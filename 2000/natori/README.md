## To build:

``` <!---sh-->
    make
```

An alt version exists for those in the southern hemisphere (or those who want to
see what it would be in the southern hemisphere). See [Alternate
version](#alternate-code) below.


## To use:

``` <!---sh-->
    ./natori
```


## Try:

``` <!---sh-->
    ./try.sh
```

Try running this on different days, say a few days apart (even better if the
Moon phase changes), and each time run it several times in a row (or several
times in a day).

Also try modifying the code so that it will show another Moon phase based on
input or else just by the code itself. Bonus points if you can make it show all.

**NOTE**: if it's a Full Moon the script won't look as nice.


## Alternate code:

The author noted that those in the southern hemisphere might want to change
`acos(l/2)` into `acos(-l/2)` which we have done in the alternate version.


### Alternate build:

To build the alternate code that works for the southern hemisphere:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./natori.alt
```

Try running this on different days, say a few days apart, and each time run it
several times in a row (or several times in a day).

What happens if you run it in the northern hemisphere? Are there any
differences?

Can you identify any Moon phases that result in the same output of both
versions? Or are there any?


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```

Like with [try.sh](%%REPO_URL%%/2000/natori/try.sh), try using this multiple times in a row or throughout
the day on different days (if different phases of the Moon you'll see more of a
difference, of course).

**NOTE**: if it's a Full Moon the script won't look as nice.


## Judges' remarks:

Here is a nice compact program that changes with the phase of the Moon.
Can you figure out how it does it?

The ANSI-C committee, among their multiple misdeeds, broke perfectly fun C
programs by making it intractable for them to declare their own non-traditional
prototype for `main()`.  We have had to uglify this program in order to prevent
C compilers from failing to compile it due to (the now changed) unusual arg
types of the `main()` function.


## Author's remarks:

This program outputs a rough image of the moon in its current phase.
The main obfuscation of this entry is its complicated double recursion
(without any loop or conditional statement).

People living in the southern hemisphere may want to change `acos(l/2)`
into `acos(-l/2)`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
