## To build:

``` <!---sh-->
    make all
```

There is an alternate version for those with an old enough compiler or for those
who wish to see how C changed over the years. See [Alternate
code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [1990/westley in bugs.html](../../bugs.html#1990_westley).



## To use:

``` <!---sh-->
    ./westley <number>
```

The number should be greater than 0.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The alternate code is provided to show how C changed.


### Alternate build:

If you have an old enough compiler or if you want to see how C changed over the
years:

``` <!---sh-->
    make alt
```


### Alternate use:

Assuming that `westley.alt` compiles:

``` <!---sh-->
    ./westley.alt <number>
```


## Judges' remarks:

If you would rather "Daisy" someone other than Westley, rename
the program as needed.  :-)

Read each block of code as if it were a piece of correspondence.
For example, the first block of code would read:

```
    charlie,
	    doubletime me, OXFACE!
	    not interested, get out
	    mainly die, charly, *die*
		    signed charlotte
```

The original source had control-L's after each code block.  To
make it easier on news readers, we converted each control-L to
a blank line.


## Author's remarks:

This is a "Picking the Daisy" simulation.  Now, instead of mangling a
daisy, simply run this program with the number of petals desired as
the argument.

This is a good counter-example to peoples' complaints that C doesn't
have an "English-like" syntax.

Lint complains about everything - null effect, xxx may be used before
set, statement not reached, return(e) and return.  Lint dumps core
on some systems.  My personal favorite lint complaint is

> warning: eroticism unused in function `main`.

Also obviously, `(char)lotte` and `(char*)lie` are incompatible types...


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
