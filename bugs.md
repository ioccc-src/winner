# BUGS and (mis)FEATURES

There are a number of known problems with IOCCC winners: many of
which have to do with differences between today's compiler environments
and those of today.  In some cases the original code has a bug, some
of which were recently discovered.  In some cases attempt to port
older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC winners.

Can you fix/improve them?  You are **VERY WELCOME** to try.
Please submit your fixes fix a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls).

We will be happy to credit those who submit successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls) in the entry's
_README.md_ file. If you're a previous winner we will add a link to your winning
entries in the file (if you're not we can add a link to your personal website if
you have one if you like).


## Known bugs that are OK to fix

### [2014/vik](2014/vik/prog.c) ([README.md](2014/vik/README.md))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) discovered a bug that
shows itself in some cases (it works in others) when working on his [2020 Enigma
machine](2020/ferguson2/prog.c) entry. See his
[README.md](2020/ferguson2/README.md) for details (search for `vik` in the
file).

He provides a tip in testing the problem: it might help to use the Enigma
machine to find problems as it will allow you to verify what is correct and what
is not. Again see his README.md for details.

## Compiler specific requirements on type of args to main

The following entries have a problem in that the args to main() are not of a
specific type due this being allowed in earlier C. This shows itself in some
compilers like clang. Looking at the source code of `clang` there is no way to
override this requirement so these entries will fail to compile with clang.

Please be aware that gcc under macOS is clang despite the fact it might appear
to be gcc: no symlink and both gcc and clang exist.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has fixed several but
there are some he has not yet fixed and we welcome your help!

A tip: in the older days args to main() not given a type were used as ints but
when they're required to be `char **` this can cause a problem. In some cases
Cody was able to use a `char *` inside main() (see
[1989/tromp/tromp.c](1989/tromp/tromp.c) for an example). In other cases he was
able to dereference the pointers to be used like an int. Some might require
additional functions are added.

For one-liners please keep the file one line!

You may provide an alt version for the fix as well.


### [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md))

Although [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for
some of the versions that are generated (see below tip) it will not work for
all. He noted that trying to fix it in some cases causes a segfault and in other
cases it fails to generate some of the files (others are okay) at all (empty
files).

He gives a tip on the problem: main() requires the second, third and fourth arg
to be a `char **`. This didn't use to be the case and some compilers like gcc
don't complain. He was able to get `main()` to be correct BUT a feature is that
it uses ROT13 to decrypt the function `znva` to be main in generated files.
Since that function does not have the correct types when converted to main() it
fails to compile. But as he said changing the type causes either a segfault or
files not generated at all. `ver1`, `ver2` and `ver3` are the problematic ones.
The segfault happens when running the main program.

This will not be a problem with gcc.

## INABIAF (it's not a bug it's a feature)

The following entries should NOT be touched: they are system specific by design
but are noteworthy nonetheless.


### [1984/mullender](1984/mullender/mullender.c) ([README.md](1984/mullender/README.md))

This entry is likely to fail and/or dump core on any computer other than a
Vax-11 or pdp-11. In 1984 machine dependent code was allowed.

### [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md))

As a backtrace quine this entry is SUPPOSED to segfault so this should not be
touched either.

### [2020/ferguson1](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.

### ... more to be added later ...

## Entries that require a compiler that support `-traditional-cpp`

The following entries need a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

- [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md))
- [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md))
- [1986/wall/wall.c](1986/wall/wall.c) ([README.md](1986/wall/README.md))
- [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md))

.. more to be added as they are discovered ..


## Entries that can no longer compile

.. entries to be added later ..

## Entries that can compile but crash (sometimes or always)

.. entries to be added later ..
