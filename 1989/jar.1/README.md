## To build:

NOTE: this will run the program itself.

``` <!---sh-->
    make clobber all
```

There is an alternate version with a slight difference that you may wish to try.
See the [Alternate code](#alternate-code) section below for more details.


## To use:

``` <!---sh-->
    ./jar.1
```


## Alternate code:

This alternate code, which prints something slightly different, is provided as well.


### Alternate build:

NOTE: this will run the program itself.

``` <!---sh-->
    make clobber alt
```


### Alternate use:

``` <!---sh-->
    ./jar.1.alt
```


## Judges' remarks:

On many systems the compiler will not allow you to send the object file to
`/dev/tty`.  The author suggested:

``` <!---sh-->
    cc -c -o /dev/tty jar.1.c
```

As a last resort the `jar.1.sh` script provided simulates
writing the raw binary of the `.o` object file to the terminal.

Abuse of the rules winning entry usually result in a change of the rules.
Starting in 1990, compiling entries must result an regular file
which can be executed.

Under certain conditions that are dependent on such diverse things such as:

- compiler type
- compiler version
- libc
- crt0.o
- operating system
- terminal application
- terminal driver
- various bugs and misfeatures :-)

the output of raw binary to a terminal can produce various effects
from the mildly annoying beeps to missing seeing the important
output, to various "ill effects" such as the crashing of the terminal
application.  Instead we have opted to pipe raw binary thru the
strings utility before writing to standard output instead of
`/dev/tty`.

As a historical note, the Makefile does echo the original command
to standard output, the original shell command that once wrote raw
binary to the `/dev/tty` special file.

The use of piping raw binary thru stings makes the original 1989 output
more apparent, as was the case when using dumb CRT terminals (some
so dumb that they couldn't even process simple ANSI escape sequences)
was more common.


## Author's remarks:

This program is (supposedly) the smallest C program able to print "Hello
world.". The compilation itself produces the desired printout and the program
need not be actually run.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
