## To build:

```sh
make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: missing file - please provide it
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1994 shapiro in bugs.md](/bugs.md#1994-shapiro).


## To use:

```sh
./shapiro &
```


## Try:

```sh
./shapiro
^Z
bg
ps x
fg
^C

./shapiro_t1
```

Notice what you see in the output of `ps`! Observe too that after you bring it
back to the foreground what happens.


## Judges' remarks:

This entry has many different levels of obfuscation, and yet the
source file is self documenting.  :-)

From time to time, run `ps(1)` and look at the new processes.

See [shapiro.md](shapiro.md) for more information in the internals of this program.
The file [shapiro.alt.c](shapiro.alt.c) contains a non-obfuscated version of
this program. Note that this alt file is currently missing. See
[bugs.md](/bugs.md) for details.


## Author's remarks:

The basic theme (pun) of this program is:


> "This time (everything) is not where it should be."
>       ~~~~


My entry ([shapiro.c](shapiro.c)) is mostly comments, formatted in the shape of a
clock. If you strip out the comments and look at the code you will
quickly realize that the comments were the important part and that
the code does very little (see pun above). It writes (to `stdout`)
another C program ([shapiro_t2.c](shapiro_t2.c)). This is the first level of
obfuscation.

The second program ([shapiro_t2.c](shapiro_t2.c) (use `make everything` first)
prints a clock in the upper right hand corner of your VTxxx/ANSI display.

Most of the surface obfuscation in the second program
([shapiro_t2.c](shapiro_t2.c)) was an attempt to make it as small as possible.
You should be able to see around this with `cb(1)` and some more intelligent
variable names.  Once you get past this you will realize that the third level of
obfuscation is a six member client/server hierarchy.  (See the
[shapiro.md](shapiro.md) file for a detailed description of the algorithm.)

`lint` complains about: precedence confusion, `K` may be used before set,
`main()` returns random value to invocation environment, value type used
inconsistently, value type declared inconsistently, function argument
(number) used inconsistently, function returns value which is always
ignored, function returns value which is sometimes ignored.
All of which are harmless (famous last words).

This may or may not work on non ASCII systems (I could not find one to
test it on.)


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
