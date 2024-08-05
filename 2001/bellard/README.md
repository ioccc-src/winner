## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**<br>

For more detailed information see [2001/bellard in bugs.html](../../bugs.html#2001_bellard).


## To use:

``` <!---sh-->
    ./bellard file
```


## Try:

``` <!---sh-->
    ./bellard bellard.otccex.c
```


## Judges' remarks:

`<JUDGES_COMMENTS>` :-)


## Author's remarks:

`OTCC` is an Obfuscated Tiny C Compiler for i386-linux. It generates
FAST! i386 32 bit code (no bytecode) and it is powerful enough to
compile itself. `OTCC` supports a strict subset of C. This subset is
compilable by a standard ANSI C compiler. `OTCC` compiles,
assembles, links and runs C code without the need of any other
program.

You can use it by typing:

``` <!---sh-->
    ./bellard bellard.c [args]...
```

or by giving the C source to its standard input.

`args` are given to the `main()` function of `bellard.c`, `argv[0]` is
[bellard.c](%%REPO_URL%%/2001/bellard/bellard.c).


### Examples:

- Sample compilation and execution:

``` <!---sh-->
    ./bellard bellard.otccex.c 10
```

- Self compilation:

``` <!---sh-->
    ./bellard bellard.c bellard.otccex.c 10
```

- Self compilation iterated...

``` <!---sh-->
    ./bellard bellard.c bellard.c bellard.otccex.c 10
```

An alternate syntax is to use it as a script interpreter: you can
put `#!/usr/local/bin/otcc` at the beginning of your C source if
you installed `otcc` at this place.


### Supported C language subset


Read joint example [bellard.otccex.c](%%REPO_URL%%/2001/bellard/bellard.otccex.c) to have an introduction to `OTCC` dialect.


#### Expressions:

* binary operators, in decreasing precedence order: `*` `/` `%`,
  `+` `-`, `>>` `<<`, `<` `<=` `>` `>=`, `==` `!=`, `&`,
  `^`, `|`, `=`, `&&`, `||`.

* `&&` and `||` have the same semantics as in C: left to right
  evaluation and early exit (short-circuited).

* Parenthesis are supported.

* Unary operators: `&`, `*` (pointer indirection), `-`
  (negation), `+`, `!`, `~`, postfix `++` and `--`.

* Pointer indirection (`*`) only works with explicit cast to
  `char *`, `int *` or `int (*)()` (function pointer).

* `++`, `--`, and unary `&` can only be used with variable
  lvalue (left value).

* `=` can only be used with variable or `*` (pointer
  indirection) lvalue.

* Function calls are supported _with standard **i386** calling
  convention_. Function pointers are supported _with explicit
  cast_. Functions can be used before being declared.

- Types: only signed integer (`int`) variables and functions can
  be declared. Variables cannot be initialized in
  declarations. _Only old K&R function declarations are parsed
  (implicit integer return value and no types on arguments)_.

- Any function or variable from the libc can be used because `OTCC`
  uses the libc dynamic linker to resolve undefined symbols.

- Instructions: blocks (`{` `}`) are supported as in C. `if` and
  `else` can be used for tests. The `while` and `for` C loops are supported.
  `break` can be used to exit loops. `return` is used for the return value of a
  function.

- Identifiers are parsed the same way as C. Local variables are
  handled, but there is no local name space (not a problem if
  different names are used for local and global variables).

- Numbers can be entered in decimal, hexadecimal (`0x` or `0X`
  prefix), or octal (`0` prefix).

- `#define` is supported without function like arguments. _No macro
  recursion is tolerated_; _other preprocessor directives are
  ignored_.

- C Strings and C character constants are supported. Only `\n`,
  `\"`, `\'` and `\\` escapes are recognized.

- C Comments can be used (but no C++ comments).

- No error is displayed if an incorrect program is given.

- Memory: the code, data, and symbol sizes are limited to 100KB
  (it can be changed in the source code).


### Obfuscation:

No special effort was needed because obfuscation is almost
unavoidable for such a program :-) `#define`s must be used to
compress the code, and integrated i386 code generator leads to non
obvious code.


### Portability:

`OTCC` only works on i386 linux because it generates i386 code. `OTCC`
also relies on little endianness, unaligned memory accesses and
ASCII representation of characters. It also supposes that no valid
pointers are less than 512. If all those constraints are met, then
`OTCC` could be theoretically used to "cross compile", although no
such support is currently integrated.

It was successfully compiled with gcc version 2.95.2. You get some
warnings because old K&R prototypes are used, some casts are implicit
and some functions are used before being defined. `OTCC` uses the
dynamic linker to resolve symbols with `dlsym(3)`, so `-ldl` must
be used when you compile and link it.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
