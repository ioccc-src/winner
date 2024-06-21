## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1989/fubar in bugs.html](../../bugs.html#1989_fubar).


## To use:

``` <!---sh-->
    ./fubar <number>
```


## Try:

``` <!---sh-->
    ./try.sh # run on 1 - 7

    ./fubar.sh 2 # run via script
    ./fubar 2 # run directly
```


## Judges' remarks:

Run this with a single digit argument (or wait a long time and risk an infinite
loop and compilation error as described in the [1989/fubar in
bugs.html](../../bugs.html#1989_fubar) file). This is, however, a feature, not a bug.

The blank line at the beginning of the source is mandatory.
Do you know why?

NOTE: the file `ouroboros.c` is created by the program itself so this is why it
is not in the repository.


## Author's remarks:

In a nutshell, this is probably the slowest and most
obnoxious factorial program ever written.  Unfortunately,
the name of the C source must be `ouroboros.c`; the name is
hard-coded into the program.

The source is a legal shell script and a legal C program.
The shell script compiles itself, and then executes the
resulting binary, giving the source as input.  The program
works by successively modifying #define lines each pass through.

Both `indent` and `cb` will damage the program, `indent`
much more so.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
