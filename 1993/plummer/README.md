# Best One Liner

Mark Plummer\
2901 Reckord Road\
Fallston, MD, 21047\
US


## To build:

```sh
make all
```


## To use:

```sh
./plummer number arg
```

where:

- number is a number    (try 21701)
- arg is any argument

NOTE: an alternate version exists. See Alternate code section below.


## Try:

```sh
./plummer 01234567890876543210 xxx

```

### Alternate code:

To use:


```sh
make alt
```

Use `plummer.alt` as you would `plummer`.

If you wish to change the time to sleep (default `200`) you can do so like:

```sh
make clobber CDEFINE="-DZ=50" alt
```


#### Try:

```sh
./plummer.alt xyzzyzzyx 5555
```

### INABIAF - it's not a bug it's a feature :-)

This entry will very likely crash or do something else if you run it without
enough args.


## Judges' remarks:

For extra credit: What happens when 'number' contains non-numeric
characters, and why?

## Author's remarks:

This program prints out all numbers up to a given number of digits
on a single line.  When the largest number is reached, the program
starts again with 0.  It takes two arguments: the first argument
specifies the number to start counting from and uses leading `0`s to
indicate the number of digits, the second argument can be anything
but must be present.

Variable names are single characters chosen for their similarity to other
characters (`O` for `0` (zero), `l` for `1` (one), `S` for `5` (five) in some
fonts, and `_` for ...  well nothing really, but it is easy to miss).  To
prevent the need for `strlen()`, the fact that argv is laid out sequentially is
exploited (i.e.  `argv[i + 1] == argv[i] + strlen(argv[i]) + 1`).  This is not
portable (by the books), but it seems to work everywhere I try (actually, for
VMS, that only holds for `i > 1`).  Also, I depend on the fact that a carriage
return causes the line just written to be overwritten. `lint` (and most
compilers) complain that there is no control path leading to a return from
`main()`.  At 125 characters, it still fits on a single line (for those of us
who don't mind ruining our eyes with 132 column screens).

The first statement points the base of `l` (the argument vector) to
be the first argument by incrementing it.  It then assigns `O` to
point to the character before the first character of the second
argument which also happens to be the NUL termination of the first
argument.  `*O` gets a `\r` assigned to it.  Finally `0` is assigned to
the first character of the second argument which has the effect of
NUL terminating the first argument after the carriage return had
removed its NUL termination.  I really tried to make the last part
of that statement part of the original expression, but the best I
could do was attach it with a comma (against the advice of K&R).
The for loop runs the next for loop continuously (actually until
the machine crashes or the user gets tired of seeing the
counting). The next for loop is the meat of the program.  In the
initialization statement, the string pointed to by `l` (the first
argument containing the digits used for counting followed by a `\r`)
is printed, and `_` is started at the least significant digit in the
string.  In the test portion, `_` is ensured not to be past the
beginning of the string (the most significant digit), and the digit
pointed to by `_` is incremented and checked to be sure that it _is_
greater than `9` (written here as `(S+*O+S)*S`).  If the test fails,
either the string has been incremented or each digit in the string
has been reset to `0`.  If the test succeeded, the iteration
statement assigns `0` (written here as `(S+*O)*S` (which has the
added bonus of having the code be a cry for help)) to `*_` and
decrements `_` to point to the next more significant digit to be
incremented; it is done only when a carry situation results (`*_` has
been incremented past `9`).

The inspiration for this program came from actual code which dealt
with scanning for a unique temporary filename by appending a
successively larger number to the end of a string.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
