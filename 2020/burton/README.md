# Best one-liner

```
Dave Burton
<http://snox.net/ioccc>
Twitter: @lv2jmp
```

## To build

```sh
make
```

### To run

```sh
./prog arg ...
```

NOTE: this entry will dump core if you do not specify an argument.

### Try

```sh
./prog 128

./prog_le 128
./prog_be 128

./prog 170

./prog 85

./prog 128 128
./prog 128 128 128
./prog 128 128 128 128
```

### Alternate code

By default, this code compiles for Little Endian machines.
To compile for a Big Engian machine use:

```sh
make alt
```

Use `prog_be` as you would `prog` above.

## Judges' comments

Can you determine why this shows strange output for `./prog 128 128`
and `./prog 128 128 128 128` but not `./prog 128 128 128`?

Can you find a pattern here?

What happens if you specify different numbers?

This tiny one-liner is a bit-twiddlers delight! It does all of the work
without looping.

To understand how it works, a good place to start is to look at the hex
value that results when the two magic constants are XORed.

Once you've figured out what happens with one set of constants, how can
choosing new constants, but using the same computation generate a reversed
result?

This code may be tested by:

```sh
make test
```

## Author's comments

Invoke this with a single non-negative integer less than 256, and a useful transformation occurs.

### Rule 2-ish

Exporting the constants B,I,T,S to the makefile allows the code
to be compiled for either LE (little-endian) or BE (big-endian) machines(!!),
so they are truly configuration parameters, not logic.

### Notes

One <strike>ping</strike> argument only.  It will segfault on zero arguments, and
display strange results if more than one argument.

Small, non-negative integers only.  Useful range is 0 .. 511, sorta, for LE; 0 .. 255 for BE.
Bonus points if you can explain why the limits work this way.

ASCII character set, 64-bit long longs are required.

v,a,r,i,a,b,l,e,s_NAME the operation.

No loops, no branches?!?

### Compilation

Compiles cleanly under `clang -Wall -Weverything -pedantic`,
but you need to add `--include stdio.h --include stdlib.h` for the `printf`(3) and `atoi`(3).

On a little-endian machine:

```sh
clang -include stdio.h -include stdlib.h -Wall -Weverything -pedantic -DB=6945503773712347754LL -DI=5859838231191962459LL -DT=0 -DS=7 -o prog prog.c
```

On a big-endian machine:

```sh
clang -include stdio.h -include stdlib.h -Wall -Weverything -pedantic -DB=7091606191627001958LL -DI=6006468689561538903LL -DT=1 -DS=0 -o prog_be prog.c
```

You might be interested to compile it both ways on the same host, and try:

```sh
./prog 1; ./prog_be 1
```

## Copyright

(c) Copyright 1984-2020, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
