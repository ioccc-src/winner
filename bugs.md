# Bugs and (Mis)features

There are a number of known problems with IOCCC winners: many of
which have to do with differences between today's compiler environments
and those of today. In some cases the original code has a bug, some
of which were recently discovered and many of which were fixed. In some cases
attempt to port older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC winners.

Can you fix/improve entries not under the INABIAF (it's not a bug it's a
feature)? You are **VERY WELCOME** to try.

NOTE: currently this file is mostly for us. We are not yet ready for help except
for dead links and missing files. We will remove this notice when this changes.
We will note this below for each status we're not yet ready for help with.

As far as how to help: please submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) (with ONE PULL
REQUEST *PER* FIX, please)!

We will be **happy to credit anyone who submits successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls)** in the [thanks
file](thanks-for-fixes.md). If you're a previous winner we will add a link to your winning
entries in the file (if you're not a previous winner we can add a link to your
GitHub page or personal website if you have one, should you wish).

If you do fix an entry please feel free to delete the entry from this file!
Otherwise if you wish to not worry about it we can do that to make sure the
format is consistent and clean.

THANK YOU!


## To the winning authors:

If you're the author of an entry that has been fixed and you find it against
your liking **PLEASE** let us know and we'll be happy to undo any fixes even if
it takes away some instructional value or even usability. _In this case we're
**VERY SORRY_** about it: it's a fine line, we know, and we tried to use careful
judgement but invariably some might have been the wrong decision. Thank you for
understanding!

I ([Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson))
accept the blame in some cases; when working on getting entries to compile
sometimes I got carried away with it and there might be that I fixed some things
that should not have been fixed. I am correcting these mistakes as I come across
them but if I miss any please let the judges or me know.


### ON **ALL** FIXES / IMPROVEMENTS / CHANGES

Make **ABSOLUTE CERTAIN** that you test the entry _BEFORE_ **AND** _AFTER_ your
changes! This includes output and the same input functionality! Sometimes it
might seem to be fine but is actually not! We will note some where this is known
to happen (if it's not yet fixed). This has actually already happened to us.
Sometimes it is okay: some entries are known to not work but they can still have
improvements (rarer situation but it's happened). Some might have slightly
different output but which is not a problem for instance a newline after output
in [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)'s changing it to
[1994/ldb](1994/ldb/ldb.c) use `fgets()` from `gets()`.

Make **ABSOLUTE CERTAIN** that you read the README.md file _BEFORE_ your changes
as it's important to see that the code is doing what it is supposed to. In the
case that it's not obvious (some README.md files do not even have commands to
try or even explain how to use it!) then you should either skip the entry OR ask
someone who will know e.g. us.

Make **ABSOLUTE CERTAIN** that you read the next section, the list of statuses
and the related information, BEFORE you submit a pull request!

**BE VERY AWARE** that sometimes fixing an entry for one platform will break it
under another so if you have more than one platform (e.g. macOS and linux) it
would be wise to test it under all that you have access to. Otherwise we can do
that. Of course if the entry does not work under any platform and you fix it for
one that's more than fine (and it has been done numerous times).

Again, THANK YOU!


# LIST OF STATUSES - PLEASE READ BEFORE FIXING (you may skip if you're only interested in knowing about entries with known issues)

NOTE: when going through the entries you can skip to the next entry (some are
detailed explanations) by searching for `^## STATUS:` in your editor (or
searching for it - probably without the `^` in your browser). For a specific
year try `^# YYYY` where `YYYY` is the year as a number.

Entries below have one or more of the following _**STATUS**_ values. Please see
the text below for more information. If an entry has more than one status it
means that either they all apply or they compliment each other. For instance
[2004/gavin](2004/gavin/gavin.c) crashes but it also doesn't even compile with
some platforms/architectures.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has been working on
resolving these issues and has fixed many but you're welcome to have a go at it
too (though he'll be very sad if he doesn't have a chance to at first fix it :-(
so you might want to hold off for now :-) .. or not :-) ). He hopes to have most
of the remaining entries resolved in the near future but nevertheless if you're
okay making people very sad you may have a go at the entries :-) [Yusuke
Endoh](/winners.html#Yusuke_Endoh) has also fixed a number of entries though at
this point he does not know it. :-) Cody will remove this part later on.


## General notes about the statuses and making fixes


### Compiler warnings are very rarely a problem

In general warnings should NOT be addressed. The only time they should be
CONSIDERED is when the entry does not work. However note that sometimes trying
to fix the warnings will actually introduce bugs! Other times 'fixing' them will
break the entry (see below).

Below in some entries we do list some warnings that definitely should be ignored
(including some introduced by fixes) but we do not list them all: trying to keep
track of them all would be impractical especially as different compilers give
different warnings.

Another type of warning that would be hard to keep track of is different data
sizes on different platforms.  These tend to be required at the risk that
sometimes the entry will not work for certain platforms, some of which might or
might not be fixable; a good example where it was required to change and is okay
is when [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the
segfault in macOS of [1989/paul](1994/paul/paul.c): changing the `int *` to a
`long *` was required and it works just as well with linux.

But even if they are fixable (which will likely be hard to do) it's almost
certain that such code would be just as non-portable (importable ? :-) ).

In rare cases they are valid. For instance Cody noticed in linux the following
warning in [1985/applin](1985/applin/applin.c) with gcc:

```
applin.c:1:78: warning: incompatible implicit declaration of built-in function 'execlp' [-Wbuiltin-declaration-mismatch]
    1 | main(v,c)char**c;{for(v[c++]=strdup("Hello, world!\n");(!!c)[*c]&&(v--||--c&&execlp(*c,*c,c[!!c]+!!c,!c));**c=!c)write(!!*c,*c,!!**c);}
      |                                                                              ^~~~~~
```

and this reminded him of his fix to
[1984/anonymous](1984/anonymous/anonymous.c). In the case of `1984/anonymous` it
was a bit more involved but with `1985/applin` one need only add to the Makefile
`-include unistd.h`. So there are some cases where fixing warnings can fix a
problem but in general they should be ignored even if they're annoying.

Hopefully with the example entries listed above you get the idea.


### General request on original code:

If you're fixing an entry please make as _FEW CHANGES AS POSSIBLE_! This is to
make it as close to the original but allowing it to work. This might be less of
a problem when providing alternate versions but it might still be nice to have
it as close as possible to the original. See also below two points.


### Request for one-liners:

For one-liners _PLEASE KEEP THE FILE ONE LINE IF AT ALL POSSIBLE_! If it needs an
include you can update the Makefile `CINCLUDE` variable. For instance if it
needs `stdio.h` you could do `-include stdio.h`. Please leave a space after the
`=` in the Makefile. You may also have extra long lines if this seems useful to
make it a one-liner even if it kind of makes it longer than what the judges
consider a one-liner. Thank you!


### On layout of program source:

If you make changes _PLEASE TRY AND KEEP THE SOURCE CODE LAYOUT AS CLOSE TO THE
ORIGINAL AS POSSIBLE_. This might not always be possible and if you have an
editor that does formatting it can cause problems. Sometimes formatters can even
break code! [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has
experienced this many times with vim so he tends to disable all format options
when formatting code. In vim you should be able to do that with:

```
:set formatoptions=
```


## STATUS: known bug - please help us fix

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Entries with this status have one or more bugs that need to be fixed. Are you
able to fix it? We welcome your help!

An important point to note is that there is a very fine line when fixing bugs
where it might sometimes border on tampering with the program. And after all,
these are not meant to be maintainable or even good programming style! Use
careful judgement when fixing bugs please!


## STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Entries with this status might or might not have a bug possibly depending on the
system.  In these entries it's unknown if there is a bug and sometimes it's
because we do not remember and sometimes we don't have the appropriate system or
environment to test and fix any possible problems.


## STATUS: might not be completely functional - can you confirm?

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Although these entries _appear_ to work for one or more reasons we're unsure if
they are completely functional. Can you confirm this? Please let us know so we
can fix it!


## STATUS: probable bug (possibly depending on system) - please help test and if necessary fix

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Entries with this status almost certainly have a bug or some other problem. The
issue or issues might depend on the system much like the above _STATUS: possible
bug (possibly depending on system)_.


## STATUS: doesn't work with some platforms - please help us fix

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Entries with this status do not work under some OSes and/or architectures (and/or
something else?). Please help us to fix it!


## STATUS: doesn't work with some compilers - please provide alternative code

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Some entries do not work with some compilers. A good example is
[1992/lush](1992/lush/lush.c) which uses error messages from the compiler to
generate its output.

Please help us by writing alternative code!


## STATUS: main() function args not allowed - please help us fix

NOTE: it appears that all of these have been fixed except perhaps for
[1989/westley](1989/westley/westley.c) which has only been partly fixed. However
some still have problems of some kind or another. This is what the status means,
however.

Entries with this status have a problem in that the args to main() are not of a
specific type due to this being allowed in earlier C. Some compilers like clang
have a defect where they do not allow this so these entries do not work with
clang. Some versions of clang also do not allow four args to main() which
`1989/westley` has.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) looked at the source
code of clang and reported that there is no way to override the requirement of
arg types so these entries will fail to compile with clang. That's why in some
entries he fixed he did it by adding a function called `pain()`. :-) He did not
check for the number of args as that was discovered later but he suspects it's
the same issue.

**NOTE for macOS users**: please be aware that _gcc_ under macOS **is actually
clang** despite the fact it might appear to be gcc: no symlink and both gcc and
clang exist but the gcc is clang which you'll see if you run `gcc --version`.

A tip and some fix methods from Cody: in the older days args to main() not given
a type were implicit ints but when they're required to be char ** this can cause
a problem. In some cases Cody was able to use a char * inside main() (see
[1989/tromp/tromp.c](1989/tromp/tromp.c) and
[1986/holloway/holloway.c](1986/holloway) for two examples though done slightly
differently). In other cases he was able to dereference the pointers to be used
like an int. He used other various techniques to get them to compile. In some
cases this introduced a problem but typically if not always that problem exists
with compilers that are less strict.


## STATUS: compiled executable crashes - please help us fix

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

While such entries can compile, the resulting executable sometimes or always
crashes.

NOTE: this does NOT apply to entries under the INABIAF status (though they're
not mutually exclusive in some cases).


## STATUS: uses gets() - change to fgets() if possible (in some cases getline() works)

NOTE: we're still locating entries and working on fixes with this status so we're not yet
ready for help. We will remove this when we are.

Entries with this status use `gets()` which is unsafe because it has no limit on
the length of the string. [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) has fixed several of these and he's
working on others in between fixing other things.

There's a very good reason for this even though it is bordering on tampering
entries: in modern systems one will get possibly alarming and certainly annoying
warnings during at least one of compiling, linking and execution. In macOS it's
most annoying as it happens during execution (also compilation) with the warning
being interspersed with the output of the program, often causing confusing
output with the entry. A good example that was fixed is
[1990/tbr](1990/tbr/tbr.c).

Cody provided some important notes on this status with respect to fixing /
changing entries:

0. In some cases changing the entry to use `fgets()` will break the entry and in
some cases cause it to crash. Where this is known we will document it.  Some of
these Cody is also off and on working on.

1. You **MUST** check the output before and after to make sure that it remains
the same. Sometimes the output might not be immediately obviously wrong but is.
We will document known examples as we come across them.

2. `gets()` does NOT STORE the `'\n'` but `fgets()` DOES! This is one of the
reasons some of the entries break when changed to `fgets()`. Cody has fixed some
of these but there are others he hasn't had time to address or even discover
yet.

3. Just because you don't see the string `gets` in the code does not mean it's
not used. It is after all the International _Obfuscated C Code_ Contest!  :-)
Sometimes it will be in the Makefile and other times it will be obfuscated in
other ways.  Compilers and linkers tend to warn about its use (and as noted in
macOS it also happens at execution) and this is a good way to find entries that
use it even if it's not visible in the code.

_NOTE_: this status is _NOT necessarily mutually exclusive_ with the _INABIAF_ (it's a
bug not a feature) status. The reason for this is due to warnings during
compiling, linking and/or runtime, sometimes causing confusing output (as noted
above).


## STATUS: missing file(s) - please provide them

In these entries one file or multiple files are missing from the repo. In some
cases these files can be found on the [IOCCC website](https://www.ioccc.org) but
in other cases they are entirely absent. In this case you'll probably have to
contact the author (unless you are the author! :-) ).


## STATUS: missing make rules - please provide them

In these entries one or more make rules noted by the author and/or judges is/are
missing. You might consider looking at the [archive](/archive) as a good place
to find them.


## STATUS: missing or dead link - please provide them

This is as they sound: a link is either missing or it's no longer valid. In many
cases the [Internet Wayback Machine](https://web.archive.org) will be very
useful but there happens to be numerous links that this is not helpful. In other
cases the URL has changed. Some of these have been discovered by the Internet
Wayback Machine with the orange status.


### Statuses of Internet Wayback Machine archive:

- Green (3xx): redirect (this has been used to find changes in URL).
- Orange (4xx): not found etc.
- Blue: this is a good link (but note that this doesn't mean that it's correct!).

The archive website will tell you if the link was never captured.


## STATUS: INABIAF - please **DO NOT** fix
### INABIAF: It's not a bug it's a feature :-)

Entries with this status should NOT be touched (unless they have another status
that suggests that _that_ issue can be changed): they are system specific by
design or are other things that are not actually bugs or bugs even if they
appear to be. Or they might be documented bugs or things that simply are part of
the entry. Nonetheless they are noteworthy.

NOTE: the definition of this status changed over time. At one point it was when
something was noted by the author, the judges, a consequence of earlier
requirements for winning entries or the purpose was to do something that might
appear to be buggy. An example of system specific entries:

[1984/mullender](1984/mullender/mullender.c) (see below and the [FAQ](/faq.md)
for a version that works in modern systems) is very system specific and was
before system specific winning entries were discouraged. This is an all time
personal favourite of Landon Curt Noll. Run the alternate code to understand why
this might be (along with how strange the source code is :-) ).

An example where a crash is not a bug: [2019/endoh](2019/endoh/endoh.c) is
supposed to crash. There are others that are also supposed to crash or that are
known to segfault but are considered features.

An important note is that if the README.md of the entry has a bug status that
says it can be fixed it can be. Otherwise it should not be.

Nonetheless we challenge you to fix these entries for educational/instructional
value and/or enjoyment but we kindly request that you **DO NOT** submit a pull
request unless it's a bug or (mis)feature we would like you to fix! If you can't
figure it out you're invited to look at the git diffs, where there are some
(some were fixed earlier on but rolled back as both Cody and Landon individually
felt that the fix was tampering with the entry).

NOTE: in the case of `gets()` we've fixed some to avoid the warning of the
compiler, linker or even during runtime, depending on the system. In [some cases
like 1990/tbr](1990/tbr/tbr.c) the fix actually prevents confusing output (though that
was not the only fix made in that entry).


### Exception: your own entries

Of course if you're the author you're welcome to fix your own entry, prefer your
own fix or suggest that they're fixed!


## STATUS: requires a compiler supporting `-traditional-cpp` - alternate code requested

### NOTE: all of these appear to be fixed

Entries with this status need a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not.

Please be advised that, as noted above, gcc under macOS is actually gcc even if it
looks like it's gcc (the programs are the same, they're not symlinks but both
are clang).

If you do wish to provide an alternate version of the program that does not need
compiler supporting you are welcome to summit such code via a
[GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we
will be happy to credit you in the [thanks file](thanks-for-fixes.md).

NOTE: as of commit fa8a9b8b28a6b69a6b4efd74a45402f745e280b3 we believe that all
the entries with this problem have been fixed due [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson)'s pursuit in fixing entries. Thanks
Cody!


# List of entries by year, sorted in alphabetical order per year


# 1984


## 1984 decot

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1984/decot/dedot.c](1984/decot/decot.c)
### Information: [1984/decot/README.md](1984/decot/README.md)

The purpose of this program is to print out a string of rubbish. In particular
you should see something like:

```sh
$ ./decot
'",x);	/*
\
```

without a newline after the `\`. This is not a bug.


## 1984 mullender

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1984/mullender/mullender.c](1984/mullender/mullender.c)
### Information: [1984/mullender/README.md](1984/mullender/README.md)

Although there is an alt version and supplementary program added by Cody that
will work in modern systems, if you do not have a
[VAX-11](https://en.wikipedia.org/wiki/VAX-11) or
[PDP-11](https://en.wikipedia.org/wiki/PDP-11) to run the original entry on it
will not work. See the README.md for details on the alternate versions.

Cody added and fixed the [gentab.c](1984/mullender/gentab.c) which is from the
author's (or one of them, Mullender) remarks found by Cody. Cody fixed this to
compile and work (as best as he can determine: he has no VAX-11 or PDP-11 or
emulator to test it) but running the code on the binary itself produces a
`short[]` that can compile in modern systems.


# 1985

There was no known bugs and (Mis)features for 1985.


# 1986


## 1986 august

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1986/august/august.c](1986/august/august.c)
### Information: [1986/august/README.md](1986/august/README.md)


This entry is known to segfault after printing its output. It was documented by
the judges and shouldn't be fixed.


# 1987

There was no known bugs and (Mis)features for 1987.


# 1988


## 1988 dale

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1988/dale/dale.c](1988/dale/dale.c)
### Information: [1988/dale/README.md](1988/dale/README.md)

In linux it might happen that despite no error message or message about doing
so, the program drops a core file into the directory even though the entry works
and does not crash.


# 1989


## 1989 fubar

### STATUS: known bug - please help us fix
### Source code: [1989/fubar/fubar.c](1989/fubar/fubar.c)
### Information: [1989/fubar/README.md](1989/fubar/README.md)

If you use either `fubar` or `ouroboros.c` (it's executable, see README.md for
details) with a number < 0 or larger than, say 20, it's very likely that the
program will turn into an infinite loop trying to compile code with syntax
errors.

If you want to try and fix this (mis)feature, you are welcome to try.


## 1989 robison

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1989/robison/robison.c](1989/robison/robison.c)
### Information: [1989/robison/README.md](1989/robison/README.md)

This program will very likely crash or break into tiny bits :-) if you feed it
numbers with non-binary digits.


## 1989 westley

### STATUS: known bug - please help us fix
### Source code: [1989/westley/westley.c](1989/westley/westley.c)
### Information: [1989/westley/README.md](1989/westley/README.md)

With version 2 it sometimes segfaults even with the same input where other times
it does not. We don't believe this is because of the fix that lets some versions
be compiled with clang. An example invocation is:

```sh
./ver2 < westley.c
```

### A useful note on changing/fixing this program

It should be noted that in additional to rot13 names there is code that is the
reverse of other code (also wrt names). See the source file and the README.md
(in the author's remarks) for more details.

Fixing the (Mis)feature is likely to be a difficult challenge.
You are welcome to try and fix it if you can!


# 1990


## 1990 jaw

### STATUS: known bug - please help us fix
### Source code: [1990/jaw/jaw.c](1990/jaw/jaw.c)
### Information: [1990/jaw/README.md](1990/jaw/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the scripts to
work in modern systems. He notes however that the command in the try section,
the one to test the official C entry, **appears** (the keyword!) to not work
with macOS, giving:


```sh
$ echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
oops: Undefined error: 0
oops: Undefined error: 0
```

However this is because the entry uses `perror()` and it just so happens that
the default `errno` of 0 gives that result. For instance if you run the
following C program under macOS you will get undefined error but if you do it
under Linux you'll likely get success.


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

is true on both linux and macOS, with `k` being equal to 22!

Should the entry use `perror()`? Perhaps not but we're not sure of its purpose
so it should stay with this note.

If you want to try and fix this (mis)feature, you are welcome to try.


## 1990 theorem

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1990/theorem/theorem.c](1990/theorem/theorem.c)
### Information: [1990/theorem/README.md](1990/theorem/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed many bugs that
prevented this from working properly (including segfaults) but one thing to note
is that if you pass two zeroes to `theorem_bkp` or `fibonacci` the program
will enter an infinite loop, printing 0 over and over again; another condition
where this occurred was fixed but this one should not be fixed. Thank you.


## 1990 westley

### STATUS: known bug - please help us fix
### Source code: [1990/westley/westley.c](1990/westley/westley.c)
### Information: [1990/westley/README.md](1990/westley/README.md)

This entry will very likely crash or do something strange without an arg.

This entry will also enter an infinite loop if input is not a number > 0.

If you want to try and fix this (mis)feature, you are welcome to try.


# 1991


## 1991 dds

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1991/dds/dds.c](1991/dds/dds.c)
### Information: [1991/dds/README.md](1991/dds/README.md)

If the BASIC file cannot be opened for reading or the output file cannot be
opened for writing the program will very likely crash or do something funny.
This is not a bug but a feature.  Please do not fix this except for the
challenge to yourself.

### STATUS: uses gets() - change to fgets() if possible

That being said the compiled code uses `gets()` not `fgets()`. Can you fix this?
It's quite complicated to do: the `s` array is certainly relevant and you can
see a bit of the magic in the [thanks](/thanks-for-fixes.md) and the README.md
file for how it works. It's easy enough to get the code to refer to `fgets()`
and call it correctly but it might take more work to get the generated code
sorted. This will be looked at later.


## 1991 westley

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1991/westley/westley.c](1991/westley/westley.c)
### Information: [1991/westley/README.md](1991/westley/README.md)

There is a very simple way to always win. The program doesn't catch you and as
someone called Cody's late grandmother said to him: 'it's not cheating unless
you're caught'. :-)

Please don't try and fix it as it's not a bug and was actually documented as a
possibility. Can you find out how?



# 1992

## 1992 buzzard.1

### STATUS: known bug - please help us fix
### Source code: [1992/buzzard.1/buzzard.1.c](1992/buzzard.1/buzzard.1.c)
### Information: [1992/buzzard.1/README.md](1992/buzzard.1/README.md)

This entry will crash without enough args (2).

If you want to try and fix this (mis)feature, you are welcome to try.


## 1992 kivinen

### STATUS: known bug - please help us fix
### Source code: [1992/kivinen/kivinen.c](1992/kivinen/kivinen.c)
### Information: [1992/kivinen/README.md])1992/kivinen/README.md_

When you start the program everything starts to move over to the right side and
then ends.  [Yusuke Endoh](/winners.html#Yusuke_Endoh) pointed out that if you
click the mouse it takes it back towards the centre.

If you want to try and fix this (mis)feature, you are welcome to try.


## 1992 lush

### STATUS: doesn't work with some compilers - please provide alternative code
### Source code: [1992/lush/lush.c](1992/lush/lush.c)
### Information: [1992/lush/README.md](1992/lush/README.md)

We used a patch from [Yusuke Endoh](/winners.html#Yusuke_Endoh) to get this to
work but it only works with gcc. Cody removed the warnings of `gets()`.

Unfortunately due to the way the entry works and the fact that other compilers
like clang have different warnings and errors this simply does not work with
them.

Some tips from Cody:

This entry relies on specific compiler warnings. With gcc it will look something
like:

```
[...]
lush.c: In function 'main':
lush.c:40: warning: "f" redefined
   40 |           main
      |
lush.c:1: note: this is the location of the previous definition
    1 | #define gets(_) fgets((_),999,stdin)
      |
lush.c:42: warning: "f" redefined
   42 | #define f 001:
      |
lush.c:40: note: this is the location of the previous definition
   40 |           main
      |
lush.c:44: warning: "f" redefined
   44 | #define f 100:
      |
lush.c:42: note: this is the location of the previous definition
   42 | #define f 001:
      |
lush.c:45: warning: "f" redefined
   45 |          _[i--
      |
lush.c:44: note: this is the location of the previous definition
   44 | #define f 100:
      |
lush.c:46: warning: "f" redefined
   46 | #define f 126:
      |
lush.c:45: note: this is the location of the previous definition
   45 |          _[i--
      |
```

Now one can use `sed` to get the `warning:` line correct but there is more to it
than that. For instance this is what it looks like with clang:

```
lush.c:40:9: warning: 'f' macro redefined [-Wmacro-redefined]
#define f 001:
        ^
lush.c:1:9: note: previous definition is here
#define f 000:
        ^
lush.c:42:9: warning: 'f' macro redefined [-Wmacro-redefined]
#define f 100:
        ^
lush.c:40:9: note: previous definition is here
#define f 001:
        ^
```

As you might see the part under the `warning:` line is different.

The entry is supposed to show warnings and then print:

```
Hello World.
```

Can you help us?



# 1993


## 1993 lmfjyh

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/lmfjyh/lmfjyh.c](1993/lmfjyh/lmfjyh.c)
### Information: [1993/lmfjyh/README.md](1993/lmfjyh/README.md)

This entry relied on a bug in gcc that was fixed with gcc version 2.3.3. This
cannot be fixed for modern systems as the bug is long gone.

An alternate version, however, does exist. See the README.md file for details.


# 1994


## 1994 ldb

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1994/ldb/ldb.c](1994/ldb/ldb.c)
### Information: [1994/ldb/README.md](1994/ldb/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
with modern systems (see the [thanks-for-fixes.md](thanks-for-fixes.md) file for
what had to change) but the entry also used `gets()` which in some systems would
print out a warning along with the output of the program. Naturally it could
also overflow long lines.  Cody changed it to `fgets()` to prevent the display
problem but this introduces another problem namely that newlines can be printed
if the line length < 231.

This seems like a worthy compromise to not have messed up output and although it
would be ideal for it to never print a newline unless that's the line itself it
might be tampering too much with the entry as it's not a real problem and as a
one liner it's already quite long.


## 1994 schnitzi

### STATUS: uses gets() - change to fgets() if possible
### Source code: [1994/schnitzi/schnitzi.c](1994/schnitzi/schnitzi.c)
### Information: [1994/schnitzi/README.md](1994/schnitzi/README.md)

The buffer size of this entry is 100 which is very easily overflowed
with `gets()` which it uses. Changing it to use `fgets()` is difficult. Even
changing the buffer size can cause compilation errors and even when that is
fixed it will not translate to the generated file. The buffer size was changed
but to make it the same functionality it was changed back.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) explains the magic of
how this entry works which will be necessary if this entry is to be fixed, below.

### The magic of [1994/schnitzi](1994/schnitzi/schnitzi.c) and how it flips text

The problem is getting the generated code to use `fgets()` (once it even
compiles which is easy to do) and also have the updated buffer size be the same.
The generated output, when changed to `fgets()` failed to compile. The buffer
size, when using `gets()` is still the same.

The real problem is with formatting the code. Take a look at the interesting
comment as well as the `int r=0,x,y=0` at the top of the file. If you look at
each column go down that column you can see how it spells out the code! For
instance the first column looks like:


```
i
n
c
l
u
d
e

<
s
t
d
i
o
.
h
>
```

If you join the lines you end up with:


```c
#include <stdio.h>
```

If you look at column 25 which is the end of the word 'mh111' and you go down to
the next row you'll see a 0 and if you go one row down another 0. This is the
buffer size, 100, for `u`! The column to the left is the same for the `t`
variable.

Thus it seems that in order to get the generated output correct one needs to
provide the correct input in comments or possibly by rearranging some of the
code (this was actually required to make the generated code compile at all when
changing the buffer size, see below).

### Important points:

Getting this entry to use `fgets()` is easy but the problem is you're supposed
to be able to feed the source to the program and the output of that will be
compilable. It however will create compiler errors. So it's not just changing
the code to get it to use fgets()! I (Cody) already did this before I noticed
the other part which is why I rolled that part back. I did increase the buffer
size but that only works on the original source.

To say just how sensitive this entry is: even a space, lack of space or a
character, wrong character, lack of character or character in the wrong place
can cause a compilation error! Make sure that the output of:

```sh
./schnitzi < schnitzi.c
```

can be compiled and the output of that new program when fed itself can also be
compiled!


## 1994 shapiro

### STATUS: missing file - please provide it
### Source code: [1994/shapiro/shapiro.c](1994/shapiro/shapiro.c)
### Information: [1994/shapiro/README.md](1994/shapiro/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) noted that the
README.md file refers to an alternative version of the code that is not
obfuscated but it is missing from the entry directory and the archive. Do you
have this file?

We would be grateful if you could provide it to us.  If you can provide this
file you might consider removing this entry from this file as well but if not
we'll take care of it.

### Important reminder and a note about the `-1` value check for `getc()`:

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the code to not
use `-1` for the return value of `getc()`; this is important because `EOF` is
**NOT** guaranteed to be `-1` but rather any negative value. On systems where
`EOF != -1` the program would enter an infinite loop until the program crashed,
by chance reads a `-1` or was killed (it is for this same reason that one should
not use `EOF` for the `getopt()` functions as they return `-1` when all options
are parsed (for details on the definition of `EOF` see `7.21
Input/output<stdio.h>` subsection 1 of the standard)).


An interesting problem occurred where changing the `-1` to `EOF` caused both
`warning: illegal character encoding in string literal` and `error: source file
is not valid UTF-8`. But since `EOF` is simply an int < 0 and making the loop
condition check that the return value is >= 0 does not cause a compilation error
and it functions correctly it will address the systems where `EOF != -1` just as
if it checked for `!= EOF`.

Since it works there is no need to fix this except for a challenge to yourself.


# 1995


## 1995 cdua

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1995/cdua/cdua.c](1995/cdua/cdua.c)
### Information: [1995/cdua/README.md](1995/cdua/README.md)

This did not originally compile under macOS and after it did compile under
macOS, it crashed. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
fixed these problems.

It should be noted however that there is a condition where the program will
prompt you to press return again. This was thought to be a bug but looking at
the code it can clearly be seen that if `g - a` is 0 then the message is
supposed to be printed again and one is supposed to press a key as at that point
it calls `getchar()` via the pointer `m`. So this is a feature not a bug.


## 1995 vanschnitz

### STATUS: missing file - please provide it
### Source code: [1995/vanschnitz/vanschnitz.c](1995/vanschnitz/vanschnitz.c)
### Information: [1995/vanschnitz/README.md](1995/vanschnitz/README.md)

The authors stated that they included a version that allows people with just K&R
compilers to use the program but this file is missing. Can you provide it?

We would appreciate anyone who has it or even just knows the name! Thank you.


# 1996


## 1996 august

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1996/august/august.c](1996/august/august.c)
### Information: [1996/august/README.md](1996/august/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a segfault in
this program that prevented it from working in gcc. It is known, however, that
some compilers (like clang) will compile the code so that it enters an infinite
loop. See the README.md file for an example command that this can happen with.


## 1996 gandalf

### STATUS: missing or dead link - please provide them
### Source code: [1996/gandalf/gandalf.c](1996/gandalf/gandalf.c)
### Information: [1996/gandalf/README.md](1996/gandalf/README.md)

The link was http://www.tc3.co.uk/~gandalf/G.HTML but this no longer exists as
it was instead requiring a login / password.

Do you have an updated link? We welcome your help!


## 1996 jonth

### STATUS: missing or dead link - please provide them
### Source code: [1996/jonth/jonth.c](1996/jonth/jonth.c)
### Information: [1996/jonth/README.md](1996/jonth/README.md)

As well the link which was http://www.uio.no/~jonth is no longer valid and
there's no archive on the Internet Wayback Machine. Do you know of a proper URL?
We greatly appreciate your help here!


# 1997

There was no IOCCC in 1997.


# 1998


## 1998 dlowe

### STATUS: missing or dead link - please provide them
### Source code: [1998/dlowe/dlowe.c](1998/dlowe/dlowe.c)
### Information: [1998/dlowe/README.md](1998/dlowe/README.md)

The domain http://pootpoot.com no longer exists as it once did. The judges have
given a script that can be used to make a similar page (**warning: not checked
for security in modern days!**). Do you have a server with enough bandwidth and
would like to set it up?  We'll gladly thank you in the README.md file and link
to the page as well!  You'll have IOCCC fame for reviving a pootifier! :-)


## 1998 dloweneil

### STATUS: missing or dead link - please provide them
### Source code: [1998/dloweneil/dloweneil.c](1998/dloweneil/dloweneil.c)
### Information: [1998/dloweneil/README.md](1998/dloweneil/README.md)

See above entry [1998/dlowe](1998/dlowe/dlowe.c).


## 1998 schnitzi

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1998/schnitzi/schnitzi.c](1998/schnitzi/schnitzi.c)
### Information: [1998/schnitzi/README.md](1998/schnitzi/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to work for
modern systems but he notes a couple compile warnings to ignore.

First if you get the warning:

	warning: incompatible implicit declaration of built-in function 'printf' [-Wbuiltin-declaration-mismatch]
	   11 | void  g(){ O=j; printf(_); }
	      |                 ^~~~~~


please do NOT change it! Doing so will break the generated output.

Another warning that was introduced but should be ignored (it's required) is:


	warning: assignment to 'char *' from incompatible pointer type 'char **' [-Wincompatible-pointer-types]
	   55 | main(int v,char **c){ O=r_; _d=c;
	      |                               ^

Please DO NOT change this either.

If there are any other warnings triggered by your compiler please DO NOT fix
those either!

Another important note is that as the number passed into the program gets bigger
the number of lines of output gets substantially larger. For instance:

```sh
$ ./schnitzi 9|wc -l
  771999
```


# 1999

There was no IOCCC in 1999.


# 2000


## 2000 primenum

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2000/primenum/primenum.c](2000/primenum/primenum.c)
### Information: [2000/primenum/README.md](2000/primenum/README.md)

This program does not do what you might think it does! Running it like:

```sh
./primenum 13
```

will seemingly wait for input exactly because it is waiting for input. See the
README.md file or look at the source.

It also has main() return void even though this is non-standard. Please do not
fix this (in fact it was originally done but rolled back).

As well there is a known crash that's also a feature.


## 2000 rince

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2000/rince/rince.c](2000/rince/rince.c)
### Information: [2000/rince/README.md](2000/rince/README.md)

If `DISPLAY` is not set the program will very likely crash, do something strange
(or if you're very unlucky your computer might [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing))! :-) ).


# 2001


## 2001 anonymous

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/anonymous/anonymous.c](2001/anonymous/anonymous.c)
### Information: [2001/anonymous/README.md](2001/anonymous/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so that it
doesn't segfault and then also fixed the functionality of it (but see below).

Cody also fixed the [anonymous.ten.c](2001/anonymous/anonymous.ten.c) program
(it also segfaulted) but notes that it **MUST** be compiled as a **32-bit ELF
binary** so it will NOT work in macOS (for example); if you cannot use `-m32` or
even if you can but it cannot compile as an ELF binary (not elf binary :-) )
(but see below) then the `anonymous` program itself will very likely crash if
you run it on the compiled [anonymous.ten.c](2001/anonymous/anonymous.ten.c) but
if nothing else it will not modify the target executable (this part of the fix
at least should be correct).

The file `2001/anonymous/anonymous.ten.32` is a pre-compiled
[2001/anonymous.ten.c](2001/anonymous.ten.c) as a 32-bit ELF binary in case you
can run ELF binaries but cannot compile 32-bit binaries.

Other BSD Unices were not tested.

Note also that if you don't specify a file or you specify a non-32-bit ELF file
this program will very likely crash or do something strange like slaughter the
elves of Imladris :-(


## 2001 bellard

### STATUS: INABIAF - please **DO NOT** fix
### STATUS: doesn't work with some platforms - please help us fix
### Source code: [2001/bellard/bellard.c](2001/bellard/bellard.c)
### Information: [2001/bellard/README.md](2001/bellard/README.md)

The two statuses might seem contradictory but that is a complicated question.
The author stated that it only works with i386 linux so on the one hand the fact
it doesn't work in modern systems is considered a feature and not a bug. But on
the other hand it would be nice if there was an alternate version which worked
for modern systems. This does seem quite unlikely but some fixes, described
next, were made.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed an initial
segfault (trying to open the file) and he also fixed the [supplementary program
bellard.otccex.c](2001/bellard/bellard.otccex.c) but this still crashes in
systems not i386 linux which is what the author stated.

On the other hand if you do have a fix for 64-bit systems you're welcome to
provide it as an alternate version. If by chance you have a fix so that it works
for both 32-bit and 64-bit systems that is also okay.

The author said that they compiled it with [gcc version
2.95.2](https://ftp.gnu.org/gnu/gcc/gcc-2.95.2/gcc-everything-2.95.2.tar.gz). We
don't know if a certain gcc version is necessary but it might be helpful to
download and compile that version to test it - or it might not.

I (Cody) have no i386 system to test this but perhaps this is why I can't get it
to work.  Yusuke was able to get this to work with `-m32` but only in an
emulator.

On the author's [web page for this program](https://bellard.org/otcc/) it is
explicitly stated that it requires i386 linux.

There I found what should be a more portable version which is included as
[otccelf.c](2001/bellard/otccelf.c) (after adding some `#include`s and the
modification by Yusuke noted in the README.md file) but it appears this *also*
requires i386 linux; indeed looking at the code it hard codes paths that are
i386 specific to linux.

Another point of interest is that the author provided de-obfuscated versions
which might be of value to look at. I might do that as well but this entry is
very likely never going to work for 64-bit linux so that's not that likely since
there are other things that are more important.

If you have a fix for 64-bit systems this is welcome as an alternate version, as
stated above. You might like to look at the otccelf version but note that it (at
least in 64-bit linux and macOS) has compilation errors.

### Aside: why were there changes if INABIAF ?

This is a good question. The reason is we believe it better to fix some obvious
problems: there were some bugs that would very possibly prevent it from working
even if it was in i386 linux though Yusuke seemed to get it to work in an
emulator so perhaps not. Still it's better to have the type of the file pointer
correct and so that the file can at least be opened in modern systems even if
the compiler won't work there.

Also the supplementary program, which did not work at all, was fixed (by Cody)
and it can be run by itself for fun in modern systems, which was not possible
before the fixes there.


## 2001 dgbeards

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/dgbeards/dgbeards.c](2001/dgbeards/dgbeards.c)
### Information: [2001/dgbeards/README.md](2001/dgbeards/README.md)

This program deliberately crashes if it loses (which is what it aims to do).


## 2001 herrmann1

### STATUS: missing files - please provide them
### Source code: [2001/herrmann1/herrmann1.c](2001/herrmann1/herrmann1.c)
### Information: [2001/herrmann1/README.md](2001/herrmann1/README.md)

The author referred to the file `herrmann1.turing` but it does not exist not even
in the archive. Do you have a copy? Please provide it!

### STATUS: missing files - please provide them

The author also referred to the file `times2.turing` but this is also missing in
the archive. Do you have a copy? Please provide it!

### STATUS: known bug - please help us fix

There is also a bug in part. During compilation you're supposed to see some
animation but this does not seem to work with modern gcc versions. It appears
that version 2.95 works but maybe others do as well. Do you have a fix? We would
appreciate your help!

If you want to try and fix this (mis)feature, you are welcome to try.


## 2001 kev

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/kev/kev.c](2001/kev/kev.c)
### Information: [2001/kev/README.md](2001/kev/README.md)

Sometimes when one player presses `q` it will result in broken pipe on the other
end.

The author also noted that some versions of `curses` have problems with
`getch()` having a delay.

The program is very likely to segfault if the specified port can't be bound or
connected to.

If the terminal is too wide (the author suggests over 500 characters) the
program can segfault.

It's also possible to crash the program if a player scores over a billion
points.

Although it is independent of endianness both systems need the same character
set. In other words both have to be ASCII or EBCDIC - not one of each.


## 2001 ollinger


### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/schweikh/schweikh.c](2001/schweikh/schweikh.c)
### Information: [2001/schweikh/README.md](2001/schweikh/README.md)

The glob pattern must match the whole string. See the author's comments for
details and a workaround.

There's also no way to escape meta characters.


# 2002

There was no IOCCC in 2002.


# 2003

There was no IOCCC in 2003.


# 2004


## 2004 gavin

### STATUS: compiled executable crashes - please help us fix
### STATUS: doesn't work with some platforms - please help us fix
### Source code: [2004/gavin/gavin.c](2004/gavin/gavin.c)
### Information: [2004/gavin//README.md](2004/gavin//README.md)

Segmentation fault will occur in some systems. For instance on macOS with the
arm64 chip:

```sh
./gavin > kernel
```

When trying to link `gavin.o` to produce `sh`, the linker generates:

```
Undefined symbols for architecture arm64:
  "start", referenced from:
     -u command line option
     (maybe you meant: __start)
ld: symbol(s) not found for architecture arm64
```

We believe that this simply won't work with non x86 specific systems but perhaps
you have a fix? We welcome your help!

### Recent 2004/gavin mods:

Although not related some recent changes were made to 2004/gavin to let it
compile under clang. The following patch was applied:

```patch
diff --git a/2004/gavin/gavin.c b/2004/gavin/gavin.c
index c967b7e..2082b49 100644
--- a/2004/gavin/gavin.c
+++ b/2004/gavin/gavin.c
@@ -1,8 +1,9 @@
+int main(int t, char **q, char **d) { return cain(t, (int)q, (int)d); }
 #define G(n) int n(int t, int q, int d)
 #define X(p,t,s) (p>=t&&p<(t+s)&&(p-(t)&1023)<(s&1023))
 #define U(m) *((signed char *)(m))
 #define F if(!--q){
-#define I(s) (int)main-(int)s
+#define I(s) (int)cain-(int)s
 #define P(s,c,k) for(h=0; h>>14==0; h+=129)Y(16*c+h/1024+Y(V+36))&128>>(h&7)?U(s+(h&15367))=k:k

 G (B)
@@ -52,7 +53,7 @@ else

 G (_);
 G (o);
-G (main)
+G (cain)
 {
   Z, k = K;
   if (!t)
```

The original Makefile from 2004 had the following to say about this entry:

```make
# Special flags for the gavin entry
#
# FYI: Older versions of GCC have a bug in -O2 optimization, hence -O1
#
GAVIN_OPT= -O1
GAVIN_FLAGS=\
        '-DY(m)=*((int*)(m))'\
        '-DE(f,a,b,c)=((G((*)))(f))(a,b,c)'\
        '-DM=for(D=0;D<786432;D++)'\
        '-DZ=int i=0,j=0,h,n,p=393728,s=26739,C,D'\
        '-DV=0x90200'\
        '-DK=0'\
        '-DR=while((C=E(V-8,100,0,0))&3&&(D=E(V-8,96,0,0))|3){'\
        '-DL(c,d)=E(V+8,100,c,0);R}E(V+8,96,d,0);R}'

# ...

# Best of Show
#
gavin: gavin.c
        ${CC} ${GAVIN_OPT} -o gavin ${GAVIN_FLAGS} gavin.c
        ${RM} -f kernel
        ./gavin > kernel
        ${CC} ${GAVIN_OPT} -c ${GAVIN_FLAGS} -DB=_start '-Dputchar(a)=' gavin.c
        ${RM} -f sh
        ${LD} -s -o sh gavin.o
        ${RM} -f vi
        ${CP} sh vi
        ${RM} -f fs.tar
        ${TAR} -cvf fs.tar sh vi gavin.c README.md prim

gavin_clean:
        ${RM} -f sh vi kernel gavin.o

gavin_clobber: gavin_clean
        ${RM} -f gavin fs.tar

gavin_files: boot.b lilo.conf prim gavin_install.txt
```

The current ([Makefile](2004/gavin/Makefile) was modified to try and
fit into the current IOCCC build environment.


## 2004 sds

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2004/sds/sds.c](2004/sds/sds.c)
### Information: [2004/sds/README.md](2004/sds/README.md)

The generated code will very likely segfault or do something not intended if not
given the right args. See the README.md file for the correct syntax.


# 2005


## 2005 anon

### STATUS: known bug - please help us fix
### Source code: [2005/anon/anon.c](2005/anon/anon.c)
### Information: [2005/anon/README.md](2005/anon/README.md)

This program sometimes will create unsolvable puzzles :-) just to hook you.
As a protection against this - and to prevent you from spending too much time on
such puzzles (or too big puzzles if you insist on doing this) - it deliberately
destroys its runtime stack. See the [README.md](2005/anon/README.md) for more
details on this.

If you specify more than three args the program might also crash or do something
strange. This might also happen if you specify excessively large board
dimensions. Try `100 100 100` for instance and see what happens!

If you want to try and fix this (mis)feature, you are welcome to try.


## 2005 giljade

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/giljade/giljade.c](2005/giljade/giljade.c)
### Information: [2005/giljade/README.md](2005/giljade/README.md)

This entry will very likely segfault or do something strange if the source code
does not exist.

This entry requires that `sed` and `make` are in the path.


## 2005 mynx

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/mynx/mynx.c](2005/mynx/mynx.c)
### Information: [2005/mynx/README.md](2005/mynx/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) notes that, though
probably obvious, this entry will not work with https. He added an alt version
that scans for https in case someone wants to set up a pipeline or other
workaround (perhaps with stunnel) but the problem otherwise is a secure
connection has to first be set up in order to give http commands. This is not a
bug but it's worth pointing out as it won't work on as many websites as it used
to including the [IOCCC website](https://www.ioccc.org) itself.


# 2006


## 2006 hamre

### STATUS: known bug - please help us fix
### Source code: [2006/hamre/hamre.c](2006/hamre/hamre.c)
### Information: [2006/hamre/README.md](2006/hamre/README.md)

This program will very likely crash or do something completely irrational :-) if
you don't supply it with an argument.

As well supplying more arguments will possibly limit the number of nested
operators supported.

Don't try dividing by 0 (zero).

If you want to try and fix this (mis)feature, you are welcome to try.


## 2006 monge

### STATUS: known bug - please help us fix
### Source code: [2006/monge/monge.c](2006/monge/monge.c)
### Information: [2006/monge/README.md](2006/monge/README.md)

Incorrect formulas will ungracefully crash the program.

Fixing the (Mis)feature is likely to be a difficult challenge.
You are welcome to try and fix it if you can!


## 2006 toledo2

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/toledo2/toledo2.c](2006/toledo2/toledo2.c)
### Information: [2006/toledo2/README.md](2006/toledo2/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this program to
not crash in macOS (it appeared to work fine in fedora linux on an `x86_64`
architecture but he does not know if it crashed in macOS Ventura due to the fact
it is an `arm64` CPU - the Apple silicon chip). This fix, BTW, is a mix of a fix
by [Yusuke Endoh](/winners.html#Yusuke_Endoh) and Cody's. Nevertheless there are
two features that are not bugs and one bug (see below).

By design this program is supposed to crash on termination.

You must type in caps (except in strings) and this program is indeed
case-sensitive.

### STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

The author showed something like this in their remarks:

```sh
./toledo2 DDT.COM
A> IMPORT DDT.COM
```

but the `A>` prompt never appears; instead it's just the same as if you
specified no arg which is `>`. It seems like the `A>` might be a typo. That
being said from the description by the author, if the required files exist in
the directory, it seems you can do `HALT` 'so the file is saved, and you can
start the same process with another file'. This does not seem to work but it
might be not enough information or a misunderstanding.


# 2007

There was no IOCCC in 2007.


# 2008

There was no IOCCC in 2008.


# 2009

There was no IOCCC in 2009.


# 2010

There was no IOCCC in 2010.


# 2011


## 2011 dlowe

### STATUS: missing or dead link - please provide them
### Source code: [2011/dlowe/dlowe.c](2011/dlowe/dlowe.c)
### Information: [2011/dlowe/README.md](2011/dlowe/README.md)

The author's website, http://www.pootpoot.net, no longer exists as it once did,
instead being something else entirely. The Internet Wayback Machine, although it
archived it, did not load scripts. Do you know if the domain was moved? Do you
have an archive or mirror? Please provide us it! Thank you.

### STATUS: known bug - please help us fix

The author states the following:

* Bad input (e.g. nonexistent files, non-numeric number of iterations, etc.)
tends to result in empty output.

* Given exactly one corpus, the program will crash or produce garbage.

* Leaks memory and file descriptors while processing files.

* Will crash and die horribly if it runs out of memory.

If you want to try and fix this (mis)feature, you are welcome to try.


## 2011 richards

### STATUS: doesn't work with some platforms - please help us fix
### Source code: [2011/richards/richards.c](2011/richards/richards.c)
### Information: [2011/richards/README.md](2011/richards/README.md)

This does not appear to work with macOS, resulting in a segfault (and sometimes
a bus error).

We're not sure if this is to do with the Apple silicon chip or not but it seems
like it _might_ (see Apple resources below) be but it could also be a wider
problem with macOS. It appears that Apple does not allow certain combinations of
memory protections with the arm64 processor.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) tried some of the
workarounds but at this time he could not get it to work. He offers some earlier
debugging sessions below as well as a resource from the author as well as some
resources on Apple's website should anyone wish to take a crack at it. He might
address it later.

### Debugging

At first glance it appeared to be that it might be the function pointers or the
fact it is trying to execute code in memory (as noted above). The function
pointers were changed a bit but this has not helped solve the problem with
macOS. A few things that were noticed depending on `asan` sanitisers specified.
With `address` in linux:

```
richards.c:101:9: runtime error: null pointer passed as argument 2, which is declared to never be null
```

but it actually works. This code is:

```c
    } else
                p++;
        W(c)} /* LINE 101 */
    }
```

Okay but what about argument 2? Well `W` is defined as:

```c
#define W(c) e=memmove(e,x[(u)c], y[(u)c])+y[(u)c];
```

so it would appear that

```c
x[(u)c]
```

(at least in my tired head?) is NULL. But why does it work then?

NOTE: `u` is `int`.

Under macOS (with the arm64 chip) we get:

```
UndefinedBehaviorSanitizer:DEADLYSIGNAL
==10834==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address 0xffffffffffffffff (pc 0x00019f446748 bp 0x00016f353100 sp 0x00016f352b90 T139066)
==10834==The signal is caused by a WRITE memory access.
    #0 0x19f446748 in _platform_memmove+0xa8 (libsystem_platform.dylib:arm64e+0x3748) (BuildId: 756cd10d62a032839e57cbaa810c95ac32000000200000000100000000030d00)
    #1 0x100c33c2c in main richards.c:202
    #2 0x19f0bff24  (<unknown module>)

==10834==Register values:
 x[0] = 0xffffffffffffffff   x[1] = 0x0000000100ab18c1   x[2] = 0x00000000000000cf   x[3] = 0x0000000000000000
 x[4] = 0x0000000100ab18a1   x[5] = 0x0000000000000001   x[6] = 0x000000000000000a   x[7] = 0x0000000000000000
 x[8] = 0x00000001015972b8   x[9] = 0xffffffffffffffff  x[10] = 0x0000000000000001  x[11] = 0x00000000000001f0
x[12] = 0x0000000000000001  x[13] = 0x00000000000003e0  x[14] = 0x0000000000000001  x[15] = 0x0000000000000084
x[16] = 0x000000019f4466a0  x[17] = 0x00000001ff3ad908  x[18] = 0x0000000000000000  x[19] = 0x0000000100c32a80
x[20] = 0x00000001017e0000  x[21] = 0x00000001017e1910  x[22] = 0x000000016f353530  x[23] = 0x000000019f13a366
x[24] = 0x000000016f3534b0  x[25] = 0x0000000000000001  x[26] = 0x0000000000000000  x[27] = 0x0000000000000000
x[28] = 0x0000000000000000     fp = 0x000000016f353100     lr = 0x0000000100aaf880     sp = 0x000000016f352b90
UndefinedBehaviorSanitizer can not provide additional info.
SUMMARY: UndefinedBehaviorSanitizer: SEGV (libsystem_platform.dylib:arm64e+0x3748) (BuildId: 756cd10d62a032839e57cbaa810c95ac32000000200000000100000000030d00) in _platform_memmove+0xa8
==10834==ABORTING
```

and naturally it does not work.

Adding the proper `PROT_WRITE` constant to the `mmap()` call does not seem to
help. Of course with the address this is not surprising so why is a different
address allocated in macOS? Or is it?

Now with `address` sanitiser both linux and macOS crash at:

```
=================================================================
==10983==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x00016f8d5e78 at pc 0x0001005dd910 bp 0x00016f8d5cd0 sp 0x00016f8d5cc8
READ of size 8 at 0x00016f8d5e78 thread T0
    #0 0x1005dd90c in rd richards.c:132
    #1 0x1005ddf8c in re richards.c:149
    #2 0x1005110a0 in t richards.c:108
    #3 0x1005df72c in main richards.c:189
    #4 0x19f0bff24  (<unknown module>)

Address 0x00016f8d5e78 is located in stack of thread T0 at offset 56 in frame
    #0 0x1005dd678 in rd richards.c:129

  This frame has 2 object(s):
    [32, 36) 'v.addr'
    [48, 56) 'a' (line 130) <== Memory access at offset 56 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow richards.c:132 in rd
Shadow bytes around the buggy address:
  0x00702df3ab70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3ab80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3ab90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3aba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3abb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x00702df3abc0: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 04 f2 00[f3]
  0x00702df3abd0: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3abe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3abf0: 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3 00 00 00 00
  0x00702df3ac00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x00702df3ac10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==10983==ABORTING
/bin/bash: line 1: 10983 Abort trap: 6           ./richards
```

which corresponds to the code:

```c
o rd(u v)
{
    o *a = 0, **b = &a, **c = b + 32;
    x[v] = w;
    for (; b < c && (*b < (o *)w || *b > (o *) T || *b == &v); b++); /* LINE 132 */

```

but this seems to not necessarily be relevant since without it it works in
linux.

A warning of interest when compiling is:

```

richards.c:169:15: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'o ()' (aka 'void ()') [-Wincompatible-pointer-types]
f *lib1[] = { T, T, T, T, T } ;

...

richards.c:170:15: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'o ()' (aka 'void ()') [-Wincompatible-pointer-types]
f *lib2[] = { T, ld, lp, lx, l1 } ;
              ^
richards.c:170:18: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'void (volatile dt)' (aka 'void (struct (unnamed at richards.c:36:3) *volatile)') [-Wincompatible-pointer-types]
f *lib2[] = { T, ld, lp, lx, l1 } ;
                 ^~
richards.c:170:22: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'void (volatile dt)' (aka 'void (struct (unnamed at richards.c:36:3) *volatile)') [-Wincompatible-pointer-types]
f *lib2[] = { T, ld, lp, lx, l1 } ;
                     ^~
richards.c:170:26: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'void (volatile dt)' (aka 'void (struct (unnamed at richards.c:36:3) *volatile)') [-Wincompatible-pointer-types]
f *lib2[] = { T, ld, lp, lx, l1 } ;
                         ^~
richards.c:170:30: warning: incompatible pointer types initializing 'f *' (aka 'void (**)(volatile void *)') with an expression of type 'void (volatile dt)' (aka 'void (struct (unnamed at richards.c:36:3) *volatile)') [-Wincompatible-pointer-types]
f *lib2[] = { T, ld, lp, lx, l1 } ;
                             ^~
```

This can be fixed easily enough however but it doesn't appear to matter in this
case.

### Resources

#### More from the author

The author has more about the entry at
<https://github.com/GregorR/ioccc2011>.

#### Apple resources

[Porting Just-In-Time Compilers to Apple
Silicon](https://developer.apple.com/documentation/apple-silicon/porting-just-in-time-compilers-to-apple-silicon?language=objc)

[Allow Execution of JIT-compiled Code
Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_cs_allow-jit?language=objc)

Looking at
<https://github.com/apple/darwin-xnu/blob/5394bb038891708cd4ba748da79b90a33b19f82e/bsd/kern/kern_mman.c>
Cody noticed a curious thing in the `mprotect()` function: `#if
CONFIG_DYNAMIC_CODE_SIGNING` and the protection variable has the
`VM_PROT_TRUSTED` set it might allow overriding the problem but this is
unconfirmed and it's not known when `CONFIG_DYNAMIC_CODE_SIGNING` would be
defined.

Do you have a fix? We welcome it!


## 2011 vik

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2011/vik/vik.c](2011/vik/vik.c)
### Information: [2011/vik/README.md](2011/vik/README.md)

The author stated that the program will crash if no argument is passed to the
program though we note that your computer might also [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing)) :-)


# 2012


## 2012 vik

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/vik/vik.c](2012/vik/vik.c)
### Information: [2012/vik/README.md](2012/vik/README.md)

The author stated that the program will crash if no argument is passed to the
program or if invalid arguments or images of mismatching sizes or unsupported
pixel formats though we note that your computer might also [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing)) :-)



# 2013


## 2013 cable3

### STATUS: missing files - please provide them
### Source code: [2013/cable3/cable3.c](2013/cable3/cable3.c)
### Information: [2013/cable3/README.md](2013/cable3/README.md)

Many fixes and improvements were made by Cody but he observed that the author
referred to a file that is nowhere to be found: not in the directory or the
archive.

The file is `hd.img`.

Do you have it? Please provide it!


## 2013 dlowe

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/dlowe/dlowe.c](2013/dlowe/dlowe.c)
### Information: [2013/dlowe/README.md](2013/dlowe/README.md)

This program will possibly crash or draw something strange with 0 args. Then
again it might not. :-) This is easy to fix but would add bytes and since the
author noted it is a feature and not a bug. You of course can try and fix it
yourself but please do NOT open a pull request for this: just do it as an
exercise to see if you understand the code.

You can try and answer the questions, too: when will it crash? When will it draw
something funny (or will it? :-) ) and when will it just do nothing?


## 2013 hou

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/hou/hou.c](2013/hou/hou.c)
### Information: [2013/hou/README.md](2013/hou/README.md)

This program will not terminate on its own; you must kill `hou` (but not Qiming
Hou :-) ) yourself. This should not be fixed.


# 2014


## 2014 vik

### STATUS: known bug - please help us fix
### Source code: [2014/vik/prog.c](2014/vik/prog.c)
### Information: [2014/vik/README.md](2014/vik/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) discovered a bug that
shows itself in some cases (it works in others) when working on his winning
[2020 Enigma machine](2020/ferguson2/prog.c) ('Most enigmatic') entry. See his
[README.md](2020/ferguson2/README.md) for details (search for `vik` in the
file).

He provides a tip in testing the problem: it might help to use his Enigma
machine to find problems as it will allow you to verify what is correct and what
is not. Again see his README.md for details!

If you want to try and fix this (mis)feature, you are welcome to try.


# 2015

There was no known bugs and (Mis)features for 2015.


# 2016

There was no IOCCC in 2016.


# 2017

There was no IOCCC in 2017.


# 2018


## 2018 algmyr

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2018/algmyr/algmyr.c](2018/algmyr/algmyr.c)
### Information: [2018/algmyr/README.md](2018/algmyr/README.md)

This entry is known to crash if a file cannot be opened. This is noted by the
author and is easy enough to fix but need not be.


## 2018 hou

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2018/hou/prog.c](2018/hou/prog.c)
### Information: [2018/hou/README.md](2018/hou/README.md)

When you run it you will see something like:

```sh
$ ./prog < ioccc.json > ioccc.html
Assertion failed: (rulez), function C, file prog.c, line 124.
Abort trap: 6
```

but this is expected and the file `ioccc.html` will be generated properly.


# 2019


## 2019 duble

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/duble/prog.c](2019/duble/prog.c)
### Information: [2019/duble/README.md](2019/duble/README.md)

This program will very likely leave sockets lying about in the current working
directory. For instance [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
showed us this:

```sh
$ ls -al |grep '^s'
srwxr-xr-x   1 cody  staff     0 Apr  6 08:19 .BDHFHALG=
srwxr-xr-x   1 cody  staff     0 Apr  6 08:15 .CGGHAMGC=
srwxr-xr-x   1 cody  staff     0 Apr  6 08:16 .CMDGAELH=
srwxr-xr-x   1 cody  staff     0 Apr  3 08:47 .CMLBCCDA=
[...]
```

This is NOT a bug and you'll have to (at least at this time?) delete the files
manually. You shouldn't have to worry about these being added to git: it seems
to ignore sockets (it did at least in macOS).

NOTE: to get a list of files with this glob try:

```sh
ls -al |awk '{print $NF}' | grep -E '^\.[A-Z]+'
```

To delete them you can do:

```sh
find . -name '.[A-Z]*' -delete
```

though one might want to check that the program is not currently running. :-)


## 2019 ciura

### STATUS: known bug - please help us fix
### Source code: [2019/ciura/prog.c](2019/ciura/prog.c)
### Information: [2019/ciura/README.md](2019/ciura/README.md)

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the scripts so
that the locale is correct (or at least correct for the commands to be run
without error, notwithstanding English which isn't a problem) but he notes that
under both macOS and fedora linux the alternative language scripts don't report
anything. This happened before and after the fix to the scripts.

Maybe it's the locale or maybe it's the dictionary files but it appears that
they did work for some. If you can identify the problem we would appreciate the
help!


## 2019 endoh

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/endoh/prog.c](2019/endoh/prog.c)
### Information: [2019/endoh/README.md](2019/endoh/README.md)

As a backtrace quine this entry is **SUPPOSED to segfault** so this should not be
touched either.


## 2019 poikola

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/poikola/prog.c](2019/poikola/prog.c)
### Information: [2019/poikola/README.md](2019/poikola/README.md)

This program will not validate input so it might fail or get stuck if invoked
erroneously.


# 2020


## 2020 burton

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/burton/prog.c](2020/burton/prog.c)
### Information: [2020/burton/README.md](2020/burton/README.md)

This entry is known to crash if no arg is specified. Although easy to fix it is
documented and should not be fixed (of course you may fix it to see if you can
but it shouldn't be made into a pull request).

It will also show funny output with more than one arg. This should not be fixed
either. But can you figure out why this happens?


## 2020 ferguson1

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/ferguson1/prog.c](2020/ferguson1/prog.c)
### Information: [2020/ferguson1/README.md](2020/ferguson1/README.md)

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.


# 2021

There was no IOCCC in 2021.


# 2022

There was no IOCCC in 2022.


# 2023

There was no IOCCC in 2023.


# Final words

We hope this document was of use to you in determining which entries are known
to have a problem, what entries are known to have features that are not bugs and
so on. We also thank you for going through this document and, if you propose any
[fixes](/thanks-for-fixes.md) via a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) or otherwise, we
thank you as well for the help! We will happily add you to the

There was no IOCCC in these years.

# 2023

Probably there will be no IOCCC in 2023 but we do hope to at least run the
IOCCCMOCK contest this year. This depends entirely on the work in this repo
and the [mkiocccentry](https://github.com/ioccc-src/mkiocccentry) being
completed.

# Final words

We hope this document was of use to you in determining which entries are known
to have a problem, what entries are known to have features that are not bugs and
so on. We also thank you for going through this document and, if you propose any
[fixes](/thanks-for-fixes.md) via a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) or otherwise, we
thank you as well for the help! We will happily add you to the
[thanks-for-fixes.md](/thanks-for-fixes.md) file as well.
