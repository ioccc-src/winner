## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2011/konno in bugs.html](../../bugs.html#2011_konno).



## To use:

``` <!---sh-->
    ./konno lower_case_word
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This tiny program outputs what looks like a tiny keyboard.
OK, so the letters are missing. But that is no problem because
this program identifies the lower case letters that were pressed!

It is one of those minimal keyboards without all of those
confusing symbols keys.  No shift for SHOUTING CAPS
but at least it does not have that useless CAPS LOCK key!

We recommend that you completely deconstruct / figure out
how this program works and does what it does.  Can you
extend this program to deal with a full QWERTY keyboard?
Can you then minimize the size of that code?


## Author's remarks:

### Limitation

This program ignores non-lower case letters.

### Obfuscation

* `for` is not used.
* A part of the program is encrypted.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
