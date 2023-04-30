# BUGS and (MIS)FEATURES

There are a number of known problems with IOCCC winners: many of
which have to do with differences between today's compiler environments
and those of today. In some cases the original code has a bug, some
of which were recently discovered and many of which were fixed. In some cases
attempt to port older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC winners.

Can you fix/improve entries not under the INABIAF (it's not a bug it's a
feature)? You are **VERY WELCOME** to try.

Please submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) (with ONE PULL
REQUEST *PER* FIX, please)!

We will be **happy to credit anyone who submits successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls)** in the entry's
_README.md_ file. If you're a previous winner we will add a link to your winning
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

If you're fixing an entry please make as few changes as possible! This is to
make it as close to the original but allowing it to work. This might be less of
a problem when providing alternate versions but it might still be nice to have
it as close as possible to the original. See also below two points.

### Request for one-liners:

For one-liners please keep the file one line if at all possible! If it needs an
include you can update the Makefile `CINCLUDE` variable. For instance if it
needs `stdio.h` you could do `-include stdio.h`. Please leave a space after the
`=` in the Makefile. You may also have extra long lines if this seems useful to
make it a one-liner even if it kind of makes it longer than what the judges
consider a one-liner. Thank you!


### On layout of program source:

If you make changes PLEASE TRY and keep the source code layout as close to the
original as possible. This might not always be possible and if you have an
editor that does formatting it can cause problems. Sometimes formatters can even
break code! [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has
experienced this many times with vim so he tends to disable all format options
when formatting code.


## STATUS: known bug - please help us fix

Entries with this status have one or more bugs that need to be fixed. Are you
able to fix it? We welcome your help!

An important point to note is that there is a very fine line when fixing bugs
where it might sometimes border on tampering with the program. And after all,
these are not meant to be maintainable or even good programming style! Use
careful judgement when fixing bugs please!

## STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

Entries with this status might or might not have a bug possibly depending on the
system.  In these entries we don't have the appropriate systems to test and fix
any problems.

## STATUS: probable bug (possibly depending on system) - please help test and if necessary fix

Entries with this status almost certainly have a bug or some other problem. The
issue or issues might depend on the system much like the above _STATUS: possible
bug (possibly depending on system)_.


## STATUS: doesn't work with some platforms - please help us fix

Entries with this status do not work under some OSes and/or architectures (and/or
something else?). Please help us to fix it!

## STATUS: doesn't work with some compilers - please provide alternative code

Some entries do not work with some compilers. A good example is
[1992/lush](1992/lush/lush.c) which uses error messages from the compiler to
generate its output.

Please help us by writing alternative code!

## STATUS: main() function args not allowed - please help us fix

Entries with this status have a problem in that the args to main() are not of a
specific type due to this being allowed in earlier C. Some compilers like clang
have a deficiency where they do not allow this so these entries do not work with
clang.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) looked at the source
code of clang and reported that there is no way to override this requirement so
these entries will fail to compile with clang. That's why in some entries he
fixed he did it by adding a function called `pain()`. :-)

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

While such entries can compile, the resulting executable sometimes or always
crashes.

NOTE: this does NOT apply to entries under the INABIAF status (though they're
not mutually exclusive in some cases).

## STATUS: uses gets() - change to fgets() if possible (in some cases getline() works)

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

[1984/mullender](1984/mullender/mullender.c) (see below and the [faq](/faq.md)
for a version that works in modern systems) is very system specific and was
before system specific winning entries were discouraged. This is an all time
personal favourite of Landon Curt Noll. Run the alternate code to understand why
this might be (along with how strange the source code is :-) ).

An example where a crash is not a bug: [2019/endoh](2019/endoh/endoh.c) is
supposed to crash. There are others that are also supposed to crash or that are
known to segfault but are considered features.

As of 10 April 2023 the definition changed for a second time (the first time was
07 April 2023). If something is noted by the author as a known bug or limitation
it need not be fixed **unless it impacts the usability** of the program or **it removes
instructional value**. An example where a crash undocumented needn't be fixed is
[1984/laman](1984/laman/laman.c).  On the other hand the fixes made by [Cody
Boone Ferguson](/winners.html#Cody_Boone_Ferguson) in
[1990/theorem](1990/theorem/theorem.c) were useful.

Nonetheless we challenge you to fix these entries for educational/instructional
value and/or enjoyment but we kindly request that you **DO NOT** submit a pull
request! If you can't figure it out you're invited to look at the git diffs,
where there are some (some were fixed earlier on but rolled back as both Cody
and Landon individually felt that the fix was tampering with the entry).

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
will be happy to credit you in the entry's _README.md_ file.

NOTE: as of commit fa8a9b8b28a6b69a6b4efd74a45402f745e280b3 we believe that all
the entries with this problem have been fixed due [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson)'s pursuit in fixing entries. Thanks
Cody!


# List of entries by year, sorted in alphabetical order per year

# 1984

## [1984/laman](1984/laman/laman.c) ([README.md](1984/laman/README.md)
## STATUS: INABIAF - please **DO NOT** fix

This entry will very likely crash or do something else if you run it without an
arg.

# 1985


# 1986


## [1986/august](1986/august/august.c) ([README.md](1986/august/README.md))
## STATUS: INABIAF - please **DO NOT** fix


This entry is known to segfault after printing its output. It was documented by
the judges and shouldn't be fixed.

## [1986/hague](1986/hague/hague.c) ([README.md](1986/hague/README.md))
## STATUS: uses gets() - change to fgets() if possible

This entry uses `gets()` which is unsafe. In particular the buffer size is a
mere 81 and it does not read a single string at command invocation but instead
until the program is terminated. This size can be increased to start out but it
would be better if it used `fgets()`. This will be addressed in time but is
noted here as a reminder.

The way this entry is formed has made it not as simple as some of the others
that have been addressed.


## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md))
## STATUS: INABIAF - please **DO NOT** fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems but he points out a warning that should NOT be fixed; he experimented
with trying to fix it but it did not work, either segfaulting or not displaying
the correct output. Thus:


```c
holloway.c:15:11: warning: incompatible pointer types initializing 'char *' with an expression of type 'char **'; dereference with * [-Wincompatible-pointer-types]
    char *t = s;
          ^   ~
              *
```

is NOT a problem and should NOT be changed. Neither are:

```c
holloway.c:14:1: warning: return type defaults to 'int' [-Wreturn-type]
   14 | main(m1,s) char **s; {
      | ^~~~
holloway.c: In function 'main':
holloway.c:14:1: warning: type of 'm1' defaults to 'int' [-Wmissing-parameter-type]
holloway.c:15:15: warning: initialization of 'char *' from incompatible pointer type 'char **' [-Wincompatible-pointer-types]
   15 |     char *t = s;
      |               ^
holloway.c:23:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
   23 |             for(a=f;a<j;++a)if(tab1[a]&&!(tab1[a]%((long)l(n))))return(a);
      |                      ^
holloway.c:24:9: note: here
   24 |         case g:
      |         ^~~~
holloway.c:34:1: warning: control reaches end of non-void function [-Wreturn-type]
   34 | }
      | ^

```

or any others.


# 1987

## [1987/lievaart](1987/lievaart/lievaart.c) ([README.md](1987/lievaart/README.md))
## STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

This might not work right. When [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) runs it he gets something like:

```sh
$ ./lievaart
Level:5
You:2
You:3
You:^C
```

However he also hasn't played Othello or if he has it was a very long time ago,
so maybe he's doing something wrong.


# 1988


# 1989

## [1989/robison](1989/robison/robison.c) ([README.md](1989/robison/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will crash with numbers with non-binary digits.


## [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md))
## STATUS: main() function args not allowed - please help us fix

Although [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for
some of the versions that are generated (see below tip) it will not work for
all. He noted that trying to fix it in some cases causes a segfault and in other
cases it fails to generate some of the files (others are okay) at all (empty
files).

He gives these tips on the problem: `main()`'s second, third and fourth args are
supposed to be a `char **`. This didn't use to be the case and some compilers
like gcc don't complain. `clang` however does. Cody was able to get `main()` to
be correct BUT a feature is that it uses ROT13 to decrypt the function `znva` to
be main in _generated files_ (see the [README.md](1989/westley/README.md) for
details). Since that function does not have the correct types when converted to
main() it fails to compile.  But as he said changing the type causes either a
segfault or files not generated at all. `ver1`, `ver2` and `ver3` are the
problematic ones.  The segfault happens when running the main program. Cody
fixed that but as noted as for the generated files only `ver0` will compile with
clang.

# 1990


## [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md))
## STATUS: INABIAF - please **DO NOT** fix

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
under linux you'll likely get success.


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


## [1990/theorem](1990/theorem/theorem.c) ([README.md](1990/theorem/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed many bugs that
prevented this from working properly (including segfaults) but one bug known to
exist remains: if `theorem_bkp` or `fibonacci` is passed two zeros the program
will enter an infinite loop, printing 0 over and over again (another condition
where this occurred was fixed).

Cody provides some hints here:

0. The function in `theorem.c` that matters is `w` (see below for definition).
1. However adding checks for the value being > 0 does not work due to the way the
code is generated. See below.

`w()` looks like this:

```c
w(g,R,u)float*g,u;char R;
/**/{int b,f;if(A>2){A=atoi(a[1]);b=atoi(a[2]);while((f=A+b)<15000){printf("%d\n",f);A=b;b=f;}}}
```

But as far as point 1 above changing it to be:

```c
/**/{int b,f;if(A>2){A=atoi(a[1]);b=atoi(a[2]);while(f!=0&&(f=A+b)<15000){printf("%d\n",f);A=b;b=f;}}}
```

and similar (like checking `>0`, doing a `do..while`, doing an `if` before the
while etc.) cause compilation errors.

Can you fix this? We welcome your help!

BTW: one of the important fixes for `fibonacci` to work is:

```diff
-/**/{int b,f;A=atoi(++a);b=atoi(++a);while((f=A+b)<15000){printf("%d\n",f);A=b;b=f;}}
+/**/{int b,f;if(A>2){A=atoi(a[1]);b=atoi(a[2]);while((f=A+b)<15000){printf("%d\n",f);A=b;b=f;}}}
```

Observe the check for the number of args and the calls to `atoi()` have been
changed a bit too.


## [1990/westley](1990/westley/westley.c) ([README.md](1990/westley/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This entry will crash without an arg. At this time this is not considered worth
fixing so it should not be fixed.

## STATUS: known bug - please help us fix

However any input not a number > 0 will make the program enter an infinite loop.
This will be fixed in time but it's noted here for now.

# 1991

## [1991/dds](1991/dds/dds.c) ([README.md)(1991/dds/README.md))
## [1991/dds.alt](1991/dds/dds.alt.c) ([README.md)(1991/dds/README.md))
## STATUS: INABIAF - please **DO NOT** fix

If the BASIC file cannot be opened for reading or the output file cannot be
opened for writing the program will crash. This is not a bug but a feature.
Please do not fix this except for the challenge.

Please also note that for `clang` you have to use [dds.alt](1991/dds/dds.alt.c) not
[dds.c](1991/dds/dds.c).

## STATUS: uses gets() - change to fgets() if possible

That being said the compiled code uses `gets()` not `fgets()`. Can you fix this?
You might find that the `s` array is relevant but if you do change it please
make sure to test all functionality!

## [1991/westley](1991/westley/westley.c) ([README.md](1991/westley/README.md))
## STATUS: INABIAF - please **DO NOT** fix

There is a very simple way to always win. The program doesn't catch you and as
someone called Cody's late grandmother said to him: 'it's not cheating unless
you're caught'. :-)

Please don't try and fix it as it's not a bug and was actually documented as a
possibility. Can you find out how?



# 1992

## [1992/buzzard.1](1992/buzzard.1/buzzard.1.c) ([README.md](1992/buzzard.1/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This entry will crash without enough args (2). At this time this is not
considered a bug to fix so it should not be fixed.

## [1992/kivinen](1992/kivinen/kivinen.c) ([README.md](1992/kivinen/README.md))
## STATUS: known bug - please help us fix

When you start the program everything starts to move over to the right side and then ends. 
[Yusuke Endoh](/winners.html#Yusuke_Endoh) pointed out that if you click the
mouse it takes it back towards the centre but this should probably be fixed.


## [1992/lush](1992/lush/lush.c) ([README.md](1992/lush/README.md))
## STATUS: doesn't work with some compilers - please provide alternative code

We used a patch from [Yusuke Endoh](/winners.html#Yusuke_Endoh) to get this to
work but it only works with gcc. Unfortunately due to the way the entry works
and the fact that other compilers like clang have different warnings and errors
this simply does not work with them. Can you help us?


# 1993

## [1993/plummber](1993/plummer/plummer.c) ([README.md](1993/plummer/README.md))
## STATUS: INABIAF - please **DO NOT** fix

If not enough args are specified this program will likely crash or do something
else. This should NOT be fixed.


# 1994

## [1994/horton[(1994/horton/horton.c) ([README.md](1994/horton/README.md))
## STATUS: INABIAF - please **DO NOT** fix

If not enough args are specified this program will likely crash or do something
else. This should NOT be fixed.

## [1994/ldb](1994/ldb/ldb.c) ([README.md](1994/ldb/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
with modern systems (see the README.md file for what had to change) but the
entry also used `gets()`. This could overflow long lines. Cody changed it to
`fgets()` but this introduces another problem namely that newlines can be
printed if the line length < 231.

This seems like a worthy compromise but it would be ideal for it to never print
a newline unless that's the line itself (a blank line).

Cody will be looking at this later on.


## [1994/schnitzi](1994/schnitzi/schnitzi.c) ([README.md])(1994/schnitzi/README.md))
## STATUS: uses gets() - change to fgets() if possible

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

## [1994/shapiro](1994/shapiro/shapiro.c) ([README.md](1994/shapiro/README.md))
## STATUS: missing file - please provide it

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) noted that the
README.md file refers to an alternative version of the code that is not
obfuscated but it is missing from the entry directory and the archive. Do you
have this file?

We would be grateful if you could provide it to us.  If you can provide this
file you might consider removing this entry from this file as well but if not
we'll take care of it.

### Important reminder to fix the `-1` value check for `getc()`:

Cody wants to remind you that he fixed the code to not use `-1` for the return
value of `getc()`; this is important because `EOF` is **NOT** guaranteed to be
`-1` but rather any negative value. On systems where `EOF != -1` the program
would enter an infinite loop until the program crashed, by chance reads a `-1`
or was killed. See the README.md for more details. If you don't feel comfortable
changing it to `EOF` Cody will happily do it for you but otherwise go right
ahead. We'll credit you in the README.md file regardless.

# 1995


## [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md))
## STATUS: known bug - please help us fix

This did not originally compile under macOS and after it did compile under
macOS, it crashed. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
fixed these problems.

However he observed that sometimes the program asks the user to hit return a
second time to resume solving the maze. It does not always happen. It doesn't
seem to be related to making it work under macOS as all that did was removing
some invalid prototypes and use `printf()` instead of the invalid pointer to it
(incompatible type). Besides that it happened under linux where there was no
compilation error or crash.


## [1995/vanschnitz](1995/vanschnitz/vanschnitz.c) ([README.md](1995/vanschnitz/README.md))
## STATUS: missing file - please provide it

The authors stated that they included a version that allows people with just K&R
compilers to use the program but this file is missing. Can you provide it?

We would appreciate anyone who has it or even just knows the name! Thank you.


# 1996

## [1996/august](1996/august/august.c) ([README.md](1996/august/README.md))
## STATUS: doesn't work with some compilers - please provide alternative code

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a segfault in
this program that prevented it from working but he observes that this hangs
in macOS with this invocation in particular:

```sh
cat august.c august.oc | ./august > august.oo
```

This happens to do with the fact that macOS is `clang` even the binary `gcc`.
Trying clang in linux and the same problem occurs. As well if specifying (even
with gcc) certain flags this also happens namely `-ggdb3`. The bug fix involved
increasing the value of `Z` as it was accessing way out of range of the array,
thus causing a segfault.

The compilation should look like:

```sh
cc -std=gnu90 -Wall -Wextra -pedantic -Wno-error -Wno-implicit-function-declaration -Wno-invalid-source-encoding -Wno-invalid-utf8  -DZ=240000 -D'T=m[s]' -D'P=m[s++]' -D'L=m[p++]' -D'g=getchar()' -DE=else -DW=while -D'B=m[p++]' -DI=if -DR='s=s+l/2;T=r;I(l%2)s++' -D'X=m[s-' -D'D=Q(13,-)Q(14,*)Q(15,/)Q(16,%)Q(6,==)Q(7,!=)Q(8,<)C(1,r=P;m[T]=r;T=r)C(9,r=P;m[T]=r;s++)'  -O3 august.c -o august 
```

but again this will not work with clang. As the judges noted that some compilers
compile it into an infinite loop I'm (Cody) inclined to believe that this is the
source of the problem.

Nevertheless if you have a fix for clang we welcome it!


## [1996/gandalf](1996/gandalf/gandalf.c) ([README.md](1996/gandalf/README.md))
## STATUS: missing or dead link - please provide them

The link was http://www.tc3.co.uk/~gandalf/G.HTML but this no longer exists as
it was instead requiring a login / password.

Do you have an updated link? We welcome your help!

## [1996/jonth](1996/jonth/jonth.c) ([README.md](1996/jonth/README.md))
## STATUS: doesn't work with some platforms - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) noted that this does
not work properly in macOS (at least Ventura). He did some debugging and has
determined where the crash occurs (depending on invocation of the program) and
came up with a workaround of sorts but if you have a fix we welcome your help.

With this you'll need XQuartz as described in the [faq](faq.md) and the
[1996/jonth/README.md](1996/jonth/README.md) file.

Notes from Cody:

Depending on invocation it appeared to have more than one crash location. It
appears that the correct invocation might be `./jonth :0 :0` but it still
crashes. Earlier invocations it would crash at

```c
s=XDefaultScreen(V=d[D]=XOpenDisplay(*(h+=!! *h)));
```

because `XOPenDisplay()` returned NULL. But using `:0 :0` _appears_ to resolve
that problem. However instead it crashes at this code:

```c
XMapRaised(V,R[D][x][y]=w(V,e,H*x,H*y,H,H,1,0,1,0,2048,&c));
```

This is formed through the macros `K` and what appears to be `S` (but maybe
others?):

```c
#define K Y(o,XMapRaised(V,e);)x=3;x--;)for(y=3;y--;r(G))XMapRaised(V,R[D]
#define S +k),z(k-P=w(V,e,H*x,H*y,H,H,1,0,1,0,2048,&c));}XEvent J;M(){XFlush(
```

and the code surrounding it will look something like:

```c
for (o[D]=XCreatePixmapFromBitmapData(V,e,b,H,H,BlackPixel(V,s),
    WhitePixel(V,s),DefaultDepth(V,s)),memset(b,x=0,H*H); x<H; x++)
                    XMapRaised(V,e);
for(x=3; x--;)
    for(y=3; y--; r(G))
        XMapRaised(V,R[D][x][y]=w(V,e,H*x,H*y,H,H,1,0,1,0,2048,&c));
```

In particular it is this part of the code that crashes: `w(...)`. But what is
that? According to `lldb`  it is:

```
(lldb) p w
(XID (*)(...)) $0 = 0x00000001003cd374 (libX11.6.dylib`XCreateWindow)
```

so `w == XCreateWindow()`. But it never actually finishes its call; modifying
the code a bit and we see that it crashes before it returns:


```
(lldb) up
frame #1: 0x0000000100003af4 jonth`T at jonth.c:40:16
   37  				    r(G)
   38  				    )
   39  			    {
-> 40  				Window ww = w(V,e,H*x,H*y,H,H,1,0,1,0,2048,&c);
   41  				XMapRaised(V,R[D][x][y]=ww);
   42  			    }

```

...so it never reaches the call that should be using its return value.
Unfortunately if XQuartz has debug symbols I don't have access to them so I'm at
a loss at this time.

A C pre-processed version of the code is below in case this helps you find the
problem:

```c
#include <math.h>
#include <X11/Xlib.h>
extern XIM Z;XID(*w)()=XCreateWindow,m,e,o[2],W[2],G[2],R[2][3][3];Display*V,*d[2];char**h,k=25,b[2500],H=50,D,s,x,y,i;T(){float l;XSetWindowAttributes c;s=XDefaultScreen(V=d[D]=XOpenDisplay(*(h+=!! *h)));XStoreName(V,e=w(V,RootWindow(V,s),0,0,152,152,2,0,1,0,0,0),"II"+D);for(G[D]=XCreatePixmapFromBitmapData(V,e,b,H,H,BlackPixel(V,s),WhitePixel(V,s),DefaultDepth(V,s)),memset(b,x=0,H*H);x<H;x++) for(i=c.event_mask=4;i--;x+i>H||z(x+i,(z(H-x-i,x),x)))x<i||z(x-i,x)|z(H-x+i,x);for(W[D]=XCreatePixmapFromBitmapData(V,e,b,H,H,BlackPixel(V,s),WhitePixel(V,s),DefaultDepth(V,s)),memset(b,x=0,H*H);x<H;x++) for(l=k;l>20&&l>x;l-=.5)z(x+k,y=sqrt(l*l-x*x) +k),z(k-x,y)-z(y,x+k)+z(y,k-x)*z(x+k,y=H-y),z(k-x,y),z(y,k-x),z(y,k+x);for(o[D]=XCreatePixmapFromBitmapData(V,e,b,H,H,BlackPixel(V,s),WhitePixel(V,s),DefaultDepth(V,s)),memset(b,x=0,H*H);x<H;x++)XMapRaised(V,e); for(x=3;x--;)for(y=3;y--;r(G))XMapRaised(V,R[D][x][y]=w(V,e,H*x,H*y,H,H,1,0,1,0,2048,&c));}XEvent J;M(){XFlush( d[!D]);x=3;for(XNextEvent(V,&J);x--;)for(y=3;y--;J.xany.window==R[D][ x][y]&&!b[x+k*y]++?t(D),t(!(D^=1)):D);M();}z(x,y){b[x/8+y*7]|=1<<x%8;}t(p){r(p?W:o);XClearWindow(V,m);}main(i,f)char**f;{M((T(h=f), T (++D)));}r(XID*z){XSetWindowBackgroundPixmap(V=d[D],m=R[D][x][y],z[ D]);}GC*g(
    XIC
);
```

### Workaround for macOS (if you have another X capable box like linux)

If you have X forward functionality enabled if you put in your `~/.ssh/config`
file (in the macOS) the line: `ForwardX11 yes` and have XQuartz open and ssh
into that other box by `ssh -X` it appears that you can run the program but it
does appear to not register the `O` move. Not sure if that's just doing
something wrong or not.

## STATUS: missing or dead link - please provide them

As well the link which was http://www.uio.no/~jonth is no longer valid and
there's no archive on the Internet Wayback Machine. Do you know of a proper URL?
We greatly appreciate your help here!


# 1997

There was no IOCCC in 1997.

# 1998

## [1998/dlowe](1998/dlowe/dlowe.c) ([README.md](1998/dlowe/README.md))
## STATUS: missing or dead link - please provide them

The domain http://pootpoot.com no longer exists as it once did. The judges have
given a script that can be used to make a similar page (**warning: not checked
for security in modern days!**). Do you have a server with enough bandwidth and
would like to set it up?  We'll gladly thank you in the README.md file and link
to the page as well!  You'll have IOCCC fame for reviving a pootifier! :-)

## [1998/dloweneil](1998/dloweneil/dloweneil.c) ([README.md](1998/dloweneil/README.md))
## STATUS: missing or dead link - please provide them

See above entry [1998/dlowe](1998/dlowe/dlowe.c).


## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md))
## STATUS: INABIAF - please **DO NOT** fix

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

[2000/primenum](2000/primenum/primenum.c) ([README.md](2000/primenum/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program does not do what you might think it does! Running it like:

```sh
./primenum 13
```

will seemingly wait for input exactly because it is waiting for input. See the
README.md file or look at the source.

It also has main() return void even though this is non-standard. Please do not
fix this (in fact it was originally done but rolled back).

As well there is a known crash that's also a feature.

## [2000/rince](2000/rince/rince.c) ([README.md](2000/rince/README.md))
## STATUS: INABIAF - please **DO NOT** fix

If `DISPLAY` is not set the program will very likely crash, do something strange
(or if you're very unlucky your computer might [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing))! :-) ).


# 2001

## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md))
## STATUS: doesn't work with some platforms - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed an initial
segfault and he also fixed the [supplementary program
bellard.otccex.c](2001/bellard/bellard.otccex.c) but this still crashes. Below
are some notes about getting this entry to work but the gist of it is that it
requires i386 linux. Can you fix it for 64-bit linux? We welcome your help! Here
are some notes of interest:

The author said that they compiled it with [gcc version
2.95.2](https://ftp.gnu.org/gnu/gcc/gcc-2.95.2/gcc-everything-2.95.2.tar.gz). We
don't know if a certain gcc version is necessary but it might be helpful to
download and compile that version to test it - or it might not.

I (Cody) have no i386 system to test this but perhaps this is why I can't get it
to work.  Yusuke was able to get this to work with `-m32` but it seems with an
emulator.

On the author's [web page for this program](https://bellard.org/otcc/) where it
is stated it requires i386 linux.

There I found what should be a more portable version which is included as
[otccelf.c](2001/bellard/otccelf.c) (after adding some `#include`s and the
modification by Yusuke noted in the README.md file) but it appears this also
requires i386 linux; indeed looking at the code it hard codes paths that are
i386 specific to linux.

Another point of interest is that the author provided de-obfuscated versions
which might be of value to look at. I might do that as well but this entry is
very likely never going to work for 64-bit linux.

Or maybe you have a fix for 64-bit CPUs? You might like to look at the otccelf
version but note that it at least in 64-bit linux (and macOS) have compilation
errors.

Either way we welcome your help! Thank you!


## [2001/cheong](2001/cheong/cheong.c) ([README.md](2001/cheong/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something different without an arg.

## [2001/dgbeards](2001/dgbeards/dgbeards.c) ([README.md](2001/dgbeards/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program deliberately crashes if it loses (which is what it aims to do).

## [2001/herrmann1](2001/herrmann1/herrmann1.c) ([README.md](2001/herrmann1/README.md)
## STATUS: missing files - please provide them

The author referred to the file `herrmann1.turing` but it does not exist not even
in the archive. Do you have a copy? Please provide it!

## STATUS: missing files - please provide them

The author also referred to the file `times2.turing` but this is also missing in
the archive. Do you have a copy? Please provide it!


## STATUS: known bug - please help us fix

There is also a bug in part. During compilation you're supposed to see some
animation but this does not seem to work with modern gcc versions. It appears
that version 2.95 works but maybe others do as well. Do you have a fix? We would
appreciate your help!

## [2001/herrmann2](2001/herrmann2/herrmann2.c) ([README.md](2001/herrmann2/README.md)
## STATUS: doesn't work with some platforms - please help us fix

The basic operation of this program does work but when using the more advanced
features it crashes but only if not compiled with `-m32`. This means that macOS
cannot easily compile it - if it can at all; Apple makes it very hard to do so.
To at least somewhat use it under macOS or a place where `-m32` is not possible
try using the [2001/herrmann2/herrmann2-64.c](2001/herrmann2/herrmann2-64.c)
program. The below describes the original including a fix for clang which does
not include a fix for 64-bit but still works with clang with one caveat which is
also described below.

With the default [herrmann2.c](2001/herrmann2/herrmann2.c) the below invocations
work fine - again as long as `-m32` works.


```sh
./herrmann2 \
'char*d,A[9876];e;b;*ad,a,c;  tw,ndr,T; wri; ;*h; _,ar  ;on;'\
' ;l ;i(V)man,n    {-!har  ;   =Aadre(0,&e,o||n -- +,o4,=9,l=b=8,'\
'!( te-*Aim)|(0~l),srand  (l),,!A,d=,b))&&+((A + te-A(&(*)=+ +95>'\
'e?(*& c_*r=5,r+e-r +_:2-19<-+?|(d==d),!n ?*d| *( (char**)+V+), ('\
'  +0,*d-7 ) -r+8)c:7:+++7+! r: and%9- 85! ()-(r+o):(+w,_+ A*(=er'\
'i+(o)+b)),!write,(=_((-b+*h)(1,A+b,!!((((-+, a >T^l,( o-95=+))w?'\
'++  &&r:b<<2+a +w) ((!main(n*n,V) , +-) ),l)),w= +T-->o +o+;{ &!'\
'a;}return _+= ' < herrmann2.ioccc
```

Note that with this it generates the original source code _prior to the clang
fix_! This is a nice way to get the original prefixed version!

This also works with 32-bit:

```sh
./herrmann2 "234 84 045 5 6765 7487 65190 84 656 254 12 43931 818 0 6542 \
341 45 567 76967 7244 606 976567 895 81898 095 68678 1843 4650547 \
565980691 389 04974" < herrmann2.ioccc
```

On the other hand these work with 64 bit (`Mach` or `x86_64`):

```sh
./herrmann2 < herrmann2.ioccc
./herrmann2 < herrmann2.cup
```

A few notes from Cody:

- The author stated that there are some layout restrictions and the changes made
to get it to compile with clang might have impacted this some. However given
that it appears to function correctly as long as it is compiled as a 32-bit
binary both before and after the fix this is probably not relevant.
- The author said that to add a function call one has to 'fill an entire line
with stuff doing mostly nothing' but it was not specified what an entire line is
nor what will happen otherwise. This is seen throughout the code and is likely
the source of dead code and variable declarations being repeated.
- At one point (not originally) my fix involved calling another function this
was done to try and find more about the crash. However this caused the program
to crash with the invocations that work as long as it's compiled with 32-bit so
this has been rolled back. This might be due to the restrictions noted in this
item and the above one but I'm not sure.
- The entry will give different output each invocation! But what you'll see is that
each line has a repeating pattern! This is expected.  See below for an example
few lines.
- There are some multiple and unsequenced modifications to some variables. See
below for these. This again does not seem to matter in 32-bit - at least
theoretically.
- See below for possible crash locations when compiled as 64-bit.


The remaining unsequenced modification warnings are:

```
herrmann2.c:6:12: warning: multiple unsequenced modifications to 'n' [-Wunsequenced]
(0,&e,o||n -- +(0,&e,o||n -- +(0,&o||n ,o-- +(0,&on ,o-4,- +(0,n ,o-=94,- +(0,n
           ^              ~~
herrmann2.c:6:42: warning: unsequenced modification and access to 'o' [-Wunsequenced]
(0,&e,o||n -- +(0,&e,o||n -- +(0,&o||n ,o-- +(0,&on ,o-4,- +(0,n ,o-=94,- +(0,n
                                         ^           ~
herrmann2.c:11:65: warning: unsequenced modification and access to 'r' [-Wunsequenced]
5,r+e-r +_:2-195,r+e-r +_:2-195+e-r +_:2-1<-95+e-r +_-1<-95+e-r ++?_-1<-95+e-r
                                                 ~              ^
herrmann2.c:18:68: warning: unsequenced modification and access to 'b' [-Wunsequenced]
-b+*h)(1,A+b,!!-b+*h),A+b,((!!-b+*h),A+b,!!-b+((*h),A+b,!!-b+*h),A-++b,!!-b+*h)
                                                                   ^
```

```
6ejZR}DU}*u?CI)6ejZR}DU}*u?CI)6ejZR}DU}*u?CI)6ejZR}DU}*u?CI)6ejZR}DU}*u?CI)6ejZ
```

If you break it up you get:

```
6ejZR}DU}*u?CI)
6ejZR}DU}*u?CI)
6ejZR}DU}*u?CI)
6ejZR}DU}*u?CI)
6ejZR}DU}*u?CI)
6ejZ
```

which you can see is quite similar.

As for crash locations:

```
Program terminated with signal SIGSEGV, Segmentation fault.
#0  main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:22
22	     )+0,
[...]
```

Note that that's not a `+` and the letter O; it's a zero!

Since I broke the line down here's what the line looks like correctly:

```c
+0,*d-7 ) -r+8)+0,*d-7 -r+8)+0,*d-c:7 -r+80,*d-c:7 -r+7:80,*d-7 -r+7:80,*d++-7
```

What happens if we remove the `+0`? We then get on line 13:

```
*( (char**)+(int)V+ *( (char)+(int)V+ *( (c),har)+V+  (c),har)+ (V+  (c),r)+ (V+  (  c),

```

Breaking this line down and we see it's still line 13:

```
13	 *
14	 ( (char**)+
15	   (int)V+
16	   *( (char)+
17	       (int)V+
```

So let's merge the lines a bit:

```
#0  main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:13
13	 *( (char**)+(int)V+
(gdb) bt
#0  main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:13
(gdb) p (char**)+(int)V
$1 = (char **) 0xffffffff831602d8
(gdb) p *(char**)+(int)V
Cannot access memory at address 0xffffffff831602d8
```

Still line 13. Let's do it again:

```
#0  0x0000000000401442 in main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:13
13	 *( (char**)+(int)V+ *( (char)+ (int)V+ *( (c), har)+ V+ (c), har)+ (V+ (c), r)+ (V+ (  c), + 0, *d - 7 ) -r +8),
(gdb) p *(( (char**)+(int)V+ *( (char)+ (int)V+ *( (c), har)+ V+ (c), har)+ (V+ (c), r)+ (V+ (  c), + 0, *d - 7 ) -r +8))
Cannot access memory at address 0xffffffffbfa05960
(gdb) p *( ( char**)+(int)V)
Cannot access memory at address 0xffffffffbfa05958
(gdb) p *( ( char**)+(int)V)+*((char)+(int)V)
Cannot access memory at address 0x58
(gdb) p *( (char)+ (int)V )
Cannot access memory at address 0x58
(gdb) p (int)V+*((c),har)
$1 = -1080010408
(gdb) ptype (int)V+*((c),har)
type = int
(gdb) p V
$2 = (char **) 0x7fffbfa05958
(gdb) p (int)V
$3 = -1080010408
(gdb) ptype V
type = char **
(gdb) p *V
$4 = 0x7fffbfa07323 "./herrmann2"
(gdb) ptype (int)V
type = int
(gdb) q

```

and so on. Note that with the fix for clang `V` is a `char **` not an int hence
the casts. But is this relevant? Let's find out:

```
#0  0x0000000000401440 in main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:14
14	+0,*d-7 ) -r+8)+0,*d-7 -r+8)+0,*d-c:7 -r+80,*d-c:7 -r+7:80,*d-7 -r+7:80,*d++-7
```

Now it's a different line! Can we fix this?

```
#0  main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:21
21	 +0,
```

Again `+0`! Let's remove it:

```
#0  main (n@entry=<optimized out>, V@entry=<optimized out>) at herrmann2.c:13
13	 *( (char**)+V+ *( (char)+V+ *( (c),har)+V+  (c),har)+ (V+  (c),r)+ (V+  (  c),
(gdb) p *( (char **)V)
Cannot access memory at address 0x544777d8
```

So now it's back to the same problem which means that it's most likely not
because of the fix for clang. Still if you have a 32-bit compiler/linker you can
run the program; else you can at least run the alt version that works in part.

Do you have a fix for 64-bit compilation? Please provide it!
## [2001/kev](2001/kev/kev.c) ([README.md](2001/kev/README.md)
## STATUS: INABIAF - please **DO NOT** fix

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

## [2001/ollinger](2001/ollinger/ollinger.c) ([README.md)(2001/ollinger/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something else without an arg.



## [2001/schweikh](2001/schweikh/schweikh.c) ([README.md](2001/schweikh/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something else if you do not give it
two args.

Note also that the glob pattern must match the whole string. See the author's
comments for details and a workaround.

There's also no way to escape meta characters.

# 2002

There was no IOCCC in 2002.

# 2003

There was no IOCCC in 2003.

# 2004


## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
with clang. He notes however that both prior to the fix (with gcc) and after the
fix (gcc, clang) it does not work: it allows input of the bet but after it
prints the hand it does not do anything with your next move. Cody provided the
following notes and tips (including possible reasons it doesn't work):

0. Originally the `jmp_buf` was just an `int p[4][1000]`.
1. The `setjmp.h` header file was not included so the calls to `longjmp()` had
not only the wrong number of arguments but also implicitly returned int when it
actually returns void. This means that the comma operator had to be used to get
the binary expressions to work. It might be this is part of the problem. It's
possible that actually changing this introduced it to not work as some old
entries actually use invalid prototypes and work but changing them to use the
proper prototype breaks them.
2. Another possible problem is the abuse of `setjmp()` and `longjmp()` which is
known to be a problem, at least as he interprets it in his tired head (and less
experience with `longjmp`). In particular:
> The longjmp() routines may not be called after the routine which called the
> setjmp() routines returns.
See also the NOTES section of the linux man pages for `setjmp(3)` and
`longjmp(3)`.
3. The main() originally returned a call to main() which appeared to be an
infinite recursion at least as it was; now it returns a call to poke() (since
it's a poker game) which has the same number and type of args (1, `char *`) that
main() originally had. This appears to not be an infinite recursion but I might
be reading it wrong. Changing it to not return itself and the same problem
occurs so perhaps this is not the problem. It's possible that the initial call
to the `poke()` function is incorrect.
4. It might be that the requirement of the comma operator in modern compilers is
a problem. Perhaps some instances of `,1` should be `,0`? That seems plausible
as they are often used with the `&&` operator.
5. As well main() had only one arg, a `char *`, and there was a (seemingly)
needless cast to `char *` from gets(). This cast remains in the code however.
6. The code no longer uses `gets()` but `fgets()`; this is not the problem
however.
7. Sometimes the lack of a _proper_ prototype lets code work if the function is
used incorrectly so one should be careful with adding the proper prototypes.
With this entry it didn't _appear_ to be relevant but maybe it is after another
change?

# 1997

There was no IOCCC in 1997.

# 1998

## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md))
## STATUS: INABIAF - please **DO NOT** fix

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

[2000/primenum](2000/primenum/primenum.c) ([README.md](2000/primenum/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program does not do what you might think it does! Running it like:

```sh
./primenum 13
```

will seemingly wait for input exactly because it is waiting for input. See the
README.md file or look at the source.

It also has main() return void even though this is non-standard. Please do not
fix this (in fact it was originally done but rolled back).


# 2001


## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md))
## STATUS: probable bug (possibly depending on system) - please help test and if necessary fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed an initial
segfault and he also fixed the [supplementary
program bellard.otccex.c](2001/bellard/bellard.otccex.c) to test the entry on to not segfault and
seemingly work but he has no 32-bit system to test any further fixes; we
would greatly appreciate anyone's help! It appears that this entry will require
major debugging and to make it work one might need to have a deep understanding
of the ELF format.

The author said that they compiled it with [gcc version
2.95.2](https://ftp.gnu.org/gnu/gcc/gcc-2.95.2/gcc-everything-2.95.2.tar.gz). We don't know if
a certain gcc version is necessary but it might be helpful to download and
compile that version to test it.

## [2001/westley](2001/westley/westley.c) ([README.md](2001/westley/README.md))
## STATUS: missing files - please provide them

The author referred to the file `card.gif` but this appears to be missing. Do
you have it? If you do please provide it and thank you!

## STATUS: uses gets() - change to fgets() if possible (in some cases getline() works)

The code also uses `gets()` which, without redirecting stderr to `/dev/null`,
can show an obnoxious warning every time it's run. In the script
[2001/westley/westley.sh](2001/westley/westley.sh) that [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) added stderr is in fact redirected
to `/dev/null` to prevent this warning but it would probably be better if it was
changed to use `fgets()` (which he might end up doing).


# 2002

There was no IOCCC in 2002.

# 2003

There was no IOCCC in 2003.

# 2004


## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
with clang. He notes however that both prior to the fix (with gcc) and after the
fix (gcc, clang) it does not work: it allows input of the bet but after it
prints the hand it does not do anything with your next move. Cody provided the
following notes and tips (including possible reasons it doesn't work):

0. Originally the `jmp_buf` was just an `int p[4][1000]`.
1. The `setjmp.h` header file was not included so the calls to `longjmp()` had
not only the wrong number of arguments but also implicitly returned int when it
actually returns void. This means that the comma operator had to be used to get
the binary expressions to work. It might be this is part of the problem. It's
possible that actually changing this introduced it to not work as some old
entries actually use invalid prototypes and work but changing them to use the
proper prototype breaks them.
2. Another possible problem is the abuse of `setjmp()` and `longjmp()` which is
known to be a problem, at least as he interprets it in his tired head (and less
experience with `longjmp`). In particular:
> The longjmp() routines may not be called after the routine which called the
> setjmp() routines returns.
See also the NOTES section of the linux man pages for `setjmp(3)` and
`longjmp(3)`.
3. The main() originally returned a call to main() which appeared to be an
infinite recursion at least as it was; now it returns a call to poke() (since
it's a poker game) which has the same number and type of args (1, `char *`) that
main() originally had. This appears to not be an infinite recursion but I might
be reading it wrong. Changing it to not return itself and the same problem
occurs so perhaps this is not the problem. It's possible that the initial call
to the `poke()` function is incorrect.
4. It might be that the requirement of the comma operator in modern compilers is
a problem. Perhaps some instances of `,1` should be `,0`? That seems plausible
as they are often used with the `&&` operator.
5. As well main() had only one arg, a `char *`, and there was a (seemingly)
needless cast to `char *` from gets(). This cast remains in the code however.
6. The code no longer uses `gets()` but `fgets()`; this is not the problem
however.
7. Sometimes the lack of a _proper_ prototype lets code work if the function is
used incorrectly so one should be careful with adding the proper prototypes.
With this entry it didn't _appear_ to be relevant but maybe it is after another
change?


## [2004/gavin](2004/gavin/gavin.c) ([README.md](2004/gavin//README.md))
## STATUS: compiled executable crashes - please help us fix
## STATUS: doesn't work with some platforms - please help us fix

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
        ${TAR} -cvf fs.tar sh vi gavin.c gavin.hint prim

gavin_clean:
        ${RM} -f sh vi kernel gavin.o

gavin_clobber: gavin_clean
        ${RM} -f gavin fs.tar

gavin_files: boot.b lilo.conf prim gavin_install.txt
```

The current ([Makefile](2004/gavin/Makefile) was modified to try and
fit into the current IOCCC build environment.

## [2004/sds](2004/sds/sds.c) ([README.md](2004/sds/README.md))
## STATUS: INABIAF - please **DO NOT** fix

The generated code will very likely segfault or do something not intended if not
given the right args. See the README.md file for the correct syntax.


# 2005

## [2005/anon](2005/anon/anon.c) ([README.md](2005/anon/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program sometimes will create unsolvable puzzles :-) just to hook you.
As a protection against this - and to prevent you from spending too much time on
such puzzles (or too big puzzles if you insist on doing this) - it deliberately
destroys its runtime stack. See the [README.md](2005/anon/README.md) for more
details on this.

If you specify more than three args the program might also crash or do something
strange. This might also happen if you specify excessively large board
dimensions. Try `100 100 100` for instance and see what happens!

## [2005/giljade](2005/giljade/giljade.c) ([README.md](2005/giljade/README.md))
## STATUS: known bug - please help us fix

Landon Curt Noll fixed this entry to work with clang by changing the first arg
to be an `int` and the second arg to be a `char **`. This is important because
of clang's deficiency requiring args to be one type only.

This did not completely fix the problem for the program however.
[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) observed that it has to
be compiled with `-m32` which is not possible in modern macOS. It also cannot
have the compiler optimiser enabled. Cody fixed it so that it works in 64-bit
but the clang fix does break something in the entry, specifically that the
self-test feature of the program no longer works.

One is supposed to be able to do:

```sh
./giljade > out
./giljade out
```

and see all layouts compile without error. If you wish to see this in action and
you have a compiler without the deficiency of clang you can do:

```sh
make alt
./giljade.alt > out
./giljade out

```

(You don't need to use `giljade.alt` to test compile - it's the output of the
program that's the actual problem.)

But the issue is can it be fixed for clang. If you have a fix we welcome your
help! Believe it or not this appears in part to be due to more than two spaces in
the program except in the places where the original code has them. This however
does not seem to be the full story. Cody probably will look at this again but
for now we note this problem here.

## STATUS: INABIAF - please **DO NOT** fix

It also will very likely segfault or do something strange if the source code
does not exist.


## [2005/mynx](2005/mynx/mynx.c) ([README.md](2005/mynx/README.md))
## STATUS: INABIAF - please **DO NOT** fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) notes that, though
probably obvious, this entry will not work with https. He added an alt version
that scans for https in case someone wants to set up a pipeline or other
workaround (perhaps with stunnel) but the problem otherwise is a secure
connection has to first be set up in order to give http commands. This is not a
bug but it's worth pointing out as it won't work on as many websites as it used
to including the [IOCCC website](https://www.ioccc.org) itself.


# 2006

## [2006/hamre](2006/hamre/hamre.c) ([README.md](2006/hamre/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something completely irrational :-) if
you don't supply it with an argument.

As well supplying more arguments will possibly limit the number of nested
operators supported.

Don't try dividing by 0 (zero).

## [2006/monge](2006/monge/monge.c) ([README.md](2006/monge/README.md))
## STATUS: INABIAF - please **DO NOT** fix

Incorrect formulas will ungracefully crash the program.

## [2006/stewart](2006/stewart/stewart.c) ([README.md](2006/stewart/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something funny if the file does not
exist or cannot be opened.


# 2007
# 2008
# 2009
# 2010

These years did not have an IOCCC.


# 2011

## [2011/dlowe](2011/dlowe/dlowe.c) ([README.md](2011/dlowe/README.md))
## STATUS: missing or dead link - please provide them

The author's website, http://www.pootpoot.net, no longer exists as it once did,
instead being something else entirely. The Internet Wayback Machine, although it
archived it, did not load scripts. Do you know if the domain was moved? Do you
have an archive or mirror? Please provide us it! Thank you.

# 2012


# 2013


# 2014


## [2014/vik](2014/vik/prog.c) ([README.md](2014/vik/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) discovered a bug that
shows itself in some cases (it works in others) when working on his winning
[2020 Enigma machine](2020/ferguson2/prog.c) ('Most enigmatic) entry. See his
[README.md](2020/ferguson2/README.md) for details (search for `vik` in the
file).

He provides a tip in testing the problem: it might help to use his Enigma
machine to find problems as it will allow you to verify what is correct and what
is not. Again see his README.md for details!


# 2015

## [2015/endoh3](2015/endoh3/prog.c) ([README.md](2015/endoh3/README.md))
## STATUS: missing files - please provide them

With Yusuke's analysis of his entry which can be found
[here](https://mame-github-io.translate.goog/ioccc-ja-spoilers/2015/endoh3.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp)
he shows a tarball with source files that work with his entry, a mock emulator
for [1984/mullender](1984/mullender/mullender.c). Unfortunately he does not have
the tarball available for download and only showed a few (which
[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) added to the repo).

Cody has his email and WILL be contacting him in time but we note it here anyway
for now.


# 2018

## [2018/algmyr](2018/algmyr/algmyr.c) ([README.md)(2018/algmyr/README.md]))
## STATUS: INABIAF - please **DO NOT** fix

This entry is known to crash if a file cannot be opened. This is noted by the
author and is easy enough to fix but need not be.


## [2018/hou](2018/hou/prog.c) ([README.md](2018/hou/README.md))
## STATUS: INABIAF - please **DO NOT** fix

When you run it you will see something like:

```sh
$ ./prog < ioccc.json > ioccc.html
Assertion failed: (rulez), function C, file prog.c, line 124.
Abort trap: 6
```

but this is expected and the file `ioccc.html` will be generated properly.


# 2019

## [2019/ciura](2019/ciura/prog.c) ([README.md](2019/ciura/README.md))
## STATUS: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the scripts so
that the locale is correct (or at least correct for the commands to be run
without error, notwithstanding English which isn't a problem) but he notes that
under both macOS and fedora linux the alternative language scripts don't report
anything. This happened before and after the fix to the scripts.

Maybe it's the locale or maybe it's the dictionary files but it appears that
they did work for some. If you can identify the problem we would appreciate the
help!


## [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md))
## STATUS: INABIAF - please **DO NOT** fix

As a backtrace quine this entry is **SUPPOSED to segfault** so this should not be
touched either.

# 2020

## [2020/burton](2020/burton/prog.c) ([README.md](2020/burton/README.md))
## STATUS: INABIAF - please **DO NOT** fix

This entry is known to crash if no arg is specified. Although easy to fix it is
documented and should not be fixed (of course you may fix it to see if you can
but it shouldn't be made into a pull request).

It will also show funny output with more than one arg. This should not be fixed
either. But can you figure out why this happens?

## [2020/ferguson1](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))
## STATUS: INABIAF - please **DO NOT** fix

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.


# 2021
# 2022

These years did not have an IOCCC entry.

# Final words

We hope this document was of use to you in determining which entries are known
to have a problem, what entries are known to have features that are not bugs and
so on. We also thank you for going through this document and, if you propose any
fixes via a pull request or otherwise, we thank you as well for the help!
