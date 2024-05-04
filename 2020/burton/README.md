## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2020/burton in bugs.html](../../bugs.html#2020_burton).


## To use:

``` <!---sh-->
    ./prog arg ...
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

By default, the program works for Little Endian machines. This alternate build
is for Big Endian machines (that works whether you have LE or BE).


### Alternate build:

Running `make` builds the alternate code by default.


### Alternate use:

Use `prog_be` as you would `prog` above.


## Judges' remarks:

Can you determine why this shows strange output for `./prog 128 128`
and `./prog 128 128 128 128` but not `./prog 128 128 128`?

Can you find a pattern here?

What happens if you specify different numbers?

This tiny one-liner is a bit-twiddler's delight! It does all of the work
without looping.

To understand how it works, a good place to start is to look at the hex
value that results when the two magic constants are `XOR`ed.

Once you've figured out what happens with one set of constants, how can
choosing new constants, but using the same computation generate a reversed
result?

This code may be tested by:

``` <!---sh-->
    make test
```


## Author's remarks:

Invoke this with a single non-negative integer less than 256, and a useful
transformation occurs.


### Rule 2-ish:

Exporting the constants `B`,`I`,`T`,`S` to the [Makefile](%%REPO_URL%%/2020/burton/Makefile) allows the
code to be compiled for either LE (little-endian) or BE (big-endian)
machines(!!), so they are truly configuration parameters, not logic.


### Notes:

One <del>ping</del> argument only.  It will segfault on zero arguments, and
display strange results with more than one argument.

Small, non-negative integers only.  Useful range is `0 .. 511`, sorta, for LE; `0
.. 255` for BE.  Bonus points if you can explain why the limits work this way.

ASCII character set, 64-bit `long long`s are required.

v,a,r,i,a,b,l,e,s\_NAME the operation.

No loops, no branches?!?


#### Compilation:

Compiles cleanly under `clang -Wall -Weverything -pedantic`, but you need to add
`--include stdio.h --include stdlib.h` for the `printf(3)` and `atoi(3)`.

On a little-endian machine:

``` <!---sh-->
    clang -include stdio.h -include stdlib.h -Wall -Weverything -pedantic -DB=6945503773712347754LL -DI=5859838231191962459LL -DT=0 -DS=7 -o prog prog.c
```

On a big-endian machine:

``` <!---sh-->
    clang -include stdio.h -include stdlib.h -Wall -Weverything -pedantic -DB=7091606191627001958LL -DI=6006468689561538903LL -DT=1 -DS=0 -o prog_be prog.c
```

You might be interested to compile it both ways on the same host, and try:

``` <!---sh-->
    ./prog 1; ./prog_be 1
```

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
