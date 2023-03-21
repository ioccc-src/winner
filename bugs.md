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


### [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md))

This did not compile under macOS and after it did it crashed.
[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this but he
observed that sometimes the program asks the user to hit return a second time to
resume solving the maze. It does not always happen. It doesn't seem to be
related to making it work under macOS as all that did was removing some invalid
prototypes and use `printf()` instead of the invalid pointer to it (incompatible
type).


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

### [1986/august](1986/august/august.c) ([README.md](1986/august/README.md))

This entry is known to segfault after printing its output. It was documented by
the judges and needn't be fixed.

### [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the scripts to
work in modern systems. He notes however that the command in the try section,
the one to test the official C entry, appear to not work with macOS, giving:


	$ echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
	oops: Undefined error: 0
	oops: Undefined error: 0


However this is because the entry uses `perror()` and it just so happens that
the default `errno` gives that result. For instance if you run the following C
program under macOS you will get undefined error but if you do it under linux
you'll likely get success.


```c
#include <stdio.h>
#include <errno.h>
#include <string.h>
int main()
{
    errno = 0;
    printf("%d, %s\n", errno, strerror(errno));
}
```

In fact the condition which is in the `a()` function on line 18 of the entry
namely:

	I k>16)

is true on both linux and macOS, with `k` being equal to 22.

Should the entry use `perror()`? Perhaps not but we're not sure of its purpose
so it can stay for now with this note.



### [1996/westley](1996/westley/westley.c) ([README.md](1996/westley/README.md))

This entry will possibly segfault even when showing the proper output in the
`clock1`, `clock2` and `clock3` scripts. Though this doesn't need to be fixed as
long as it works right it wouldn't hurt to fix it either.


### [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md))

As a backtrace quine this entry is SUPPOSED to segfault so this should not be
touched either.

### [2020/ferguson1](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.

### ... more to be added later ...

## Mis-features that should not be fixed

The following entries should not be touched either as although it might seem
wrong they are not.

### [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md))

When compiling this entry you might get an incompatible pointer type warning but
this should be ignored. When [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this he experimented with the
alternatives and it did not work. Thus if you see something like:

```c
[holloway.c:15:11: warning: incompatible pointer types initializing 'char *' with an expression of type 'char **'; dereference with * [-Wincompatible-pointer-types]
    char *t = s;
          ^   ~
              *

```

it is NOT a problem and should not be changed.

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
