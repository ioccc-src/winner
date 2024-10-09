## To build:

``` <!---sh-->
    make all
```

There is an [alternate version](#alternate-code) that does something different
that can be used if your compiler is incapable of compiling `X=g()...` in
`main()`. It can be used for another purpose too.


## To use:

``` <!---sh-->
    ./pjr
```


## Alternate code:

Note that some compilers will be unable to compile the expression `X=g()...` in
`main()` due to lack of temporary stack space.  One might want to try replacing
`main()` with:

``` <!---c-->
    main(){X=s().v().o().o().l().S().d().l().i().o().w().N();}
```

if this is a problem, which is what this alternate code is.

**NOTE**: it prints something else and it is what the author suggested one try as
well.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./pjr.alt
```


## Judges' remarks:

This program prints out a string.  Can you figure out how
it is done?

By use of pointers to functions returning a struct of pointers
to functions!


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### What this entry does:

This program prints out the string:

> the quick brown fox jumped over the lazy dog


## Author's remarks:

It is simple to make the program print other strings.  Each
alphabetical character from a to z is printed out as its
opposite:

```
    a->z b->y c->x etc
```

To encode a new string input the string as it is meant to come out:

``` <!---c-->
    X=s().v().o().o().l().S().d().l().i().o().w().N();
```

Note: `S()` represents a space and `N()` a newline.  This will now
produce...

```
    hello world
```

By the way, there is actually a piece of code which is not used
in the original program! I leave it as an intellectual exercise
to the reader to find out what it is.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
