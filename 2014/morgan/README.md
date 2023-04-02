# Most likely to succeed

    Yves-Marie Morgan  
    <yves-marie.morgan@parrot.com>  

## To build:

```sh
make
```

## To run:

```sh
./prog [arg ..]
```

## Try:

```sh
make
cp -f prog morgan
./morgan clobber
ls

./morgan all install
ls

./prog love haste waste supernova
ls

make
./prog magic
ls
```

## Judges' comments:

Think of this as a Maker Faire's make.  :-)

It works reasomably well.  While not super ultra-featured, it does fair well with the Makefile we supplied.
Not only that, it helped uncover a bug we had in our special Makefile rules.

## Author's comments:

### Remarks

This program is a tiny `make` clone.

It is able to parse a subset of the `make` syntax and will execute rules for
goals given in arguments if they need to (based on timestamp of dependencies
of rule targets).

## Supported features

* Variable assignments (only recursive ones). Variable references with recursion.
* Environment variables are available.
* It is possible to specify variables in command line: `name=value`.
* Variables given in command line will have precedence over variables defined
  in makefile, which will have precedence over environment variables.
* If no goal given in command line, the first target defined will be used.
* Comments, escaped comments, escaped new lines.

It should be able to build programs of previous years with the provided `Makefile`
found in previous contest archives. Simply use this program instead of `make`.
It will recursively use itself for submake (the `MAKE=` assignment inside
`Makefile` will be ignored to continue using itself).

## Limitations / Known issues

* There is a lot of memory leak (not a single free).
* The opened file is not closed.
* The input file shall be named `Makefile`.
* No diagnostic message, but the exit status is non zero to indicates failure
  (failed command in a rule or missing target).
* Only `$<` and `$@` are supported for automatic variables in commands.
* No parallel execution (`-j` option).
* No `:=` `+=` `?=` syntax for variable assignment.
* No built-in function available.
* No pattern targets.
* No pattern substitution variables.
* No built-in rules.
* No built-in variables (except the one from environment).
* No conditional directives.

### Compilation warnings

with gcc 4.8.2 on Linux Ubuntu 14.04 64-bit :
* prog.c:22:15: warning: return makes integer from pointer without a cast [enabled by default]
* prog.c:23:72: warning: signed and unsigned type in conditional expression [-Wsign-compare]
* prog.c:12:11: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
