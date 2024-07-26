# Bugs and (mis)features

## Table of Contents

If you are going to try and fix any bugs **PLEASE READ THE NEXT SECTIONS _FIRST_**.
If however you want to jump to a specific year or you have already read the
below and you wish to help with a year, you can use these links:

- [1984 entries](#1984) |       [1985 entries](#1985)   |       [1986 entries](#1986)   |       [1987 entries](#1987)
- [1988 entries](#1988) |       [1989 entries](#1989)   |       [1990 entries](#1990)   |       [1991 entries](#1991)
- [1992 entries](#1992) |       [1993 entries](#1993)   |       [1994 entries](#1994)   |       [1995 entries](#1995)
- [1996 entries](#1996) |       [1998 entries](#1998)   |       [2000 entries](#2000)   |       [2001 entries](#2001)
- [2004 entries](#2004) |       [2005 entries](#2005)   |       [2006 entries](#2006)   |       [2011 entries](#2011)
- [2012 entries](#2012) |       [2013 entries](#2013)   |       [2014 entries](#2014)   |       [2015 entries](#2015)
- [2018 entries](#2018) |       [2019 entries](#2019)   |       [2020 entries](#2020)

## PLEASE read the next sections if you wish to help

There are a number of known problems with IOCCC entries: many of
which have to do with differences between today's compiler environments
and those of today. In some cases the original code has a bug, some
of which were recently discovered and many of which were fixed. In some cases
attempt to port older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC entries.

Can you fix/improve entries not under the INABIAF (it's not a bug it's a
feature)? You are **VERY WELCOME** to try.

As far as how to help: please submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls) (with ONE PULL
REQUEST *PER* FIX, please)!

We will be **happy to credit anyone who submits successful [GitHub pull
requests](https://github.com/ioccc-src/winner/pulls)** in the
[thanks](thanks-for-help.html) file. If you're the author of an entry
that win the IOCCC, we will add a link to your winning entries in the file
(if you're not an author, we can add a link to your GitHub page or personal
website if you have one, should you wish).

If you do fix an entry please feel free to delete the entry from this file!
Otherwise if you wish to not worry about it we can do that to make sure the
format is consistent and clean.

THANK YOU!


## To the winning authors:

If you're the author of an entry that has been fixed and you find it against
your liking **PLEASE** let us know and we'll be happy to undo any fixes even if
it takes away some instructional value or even usability. _In this case we're
**VERY SORRY** about it: it's a fine line, we know, and we tried to use careful
judgement but invariably some might have been the wrong decision. Thank you for
understanding!

I ( [Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) )
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
in [Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson)'s changing it to
[1994/ldb](%%REPO_URL%%/1994/ldb/ldb.c) use `fgets()` from `gets()`.

Make **ABSOLUTE CERTAIN** that you read the index.html file _BEFORE_ your changes
as it's important to see that the code is doing what it is supposed to. In the
case that it's not obvious (some index.html files do not even have commands to
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


<hr>


# LIST OF STATUSES

## PLEASE READ BEFORE FIXING

**BTW**: You may skip if you're only interested in knowing about entries with known issues.

Entries below have one or more of the following _**STATUS**_ values. Please see
the text below for more information. If an entry has more than one status it
means that either they all apply or they compliment each other. For instance
[2004/gavin](%%REPO_URL%%/2004/gavin/gavin.c) crashes but it also doesn't even compile with
some platforms/architectures.


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
is when [Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed the
segfault in macOS of [1989/paul](%%REPO_URL%%/1989/paul/paul.c): changing the `int *` to a
`long *` was required and it works just as well with linux.

But even if they are fixable (which will likely be hard to do) it's almost
certain that such code would be just as non-portable (importable ? :-) ).

In rare cases they are valid. For instance Cody noticed in linux the following
warning in [1985/applin](%%REPO_URL%%/1985/applin/applin.c) with gcc:

```
    applin.c:1:78: warning: incompatible implicit declaration of built-in function 'execlp' [-Wbuiltin-declaration-mismatch]
        1 | main(v,c)char**c;{for(v[c++]=strdup("Hello, world!\n");(!!c)[*c]&&(v--||--c&&execlp(*c,*c,c[!!c]+!!c,!c));**c=!c)write(!!*c,*c,!!**c);}
          |                                                                              ^~~~~~
```

and this reminded him of his fix to
[1984/anonymous](%%REPO_URL%%/1984/anonymous/anonymous.c). In the case of `1984/anonymous` it
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
break code! [Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) has
experienced this many times with vim so he tends to disable all format options
when formatting code. In vim you should be able to do that with:

```
    :set formatoptions=
```


## STATUS: known bug

**Please help us fix**!

Entries with this status have one or more bugs that need to be fixed. Are you
able to fix it? We welcome your help!

An important point to note is that there is a very fine line when fixing bugs
where it might sometimes border on tampering with the program. And after all,
these are not meant to be maintainable or even good programming style! Use
careful judgement when fixing bugs please!


## STATUS: possible bug

### System dependent bug possibly

**Please help test, and if necessary fix this bug**!

Entries with this status might or might not have a bug possibly depending on the
system.  In these entries it's unknown if there is a bug and sometimes it's
because we do not remember and sometimes we don't have the appropriate system or
environment to test and fix any possible problems.


## STATUS: might not be completely functional

**Can you confirm there is a bug?**

Although these entries _appear_ to work for one or more reasons we're unsure if
they are completely functional. Can you confirm this? Please let us know so we
can fix it!


## STATUS: probable bug

### Possible system dependent bug

**Please help test and if necessary fix this bug**!

Entries with this status almost certainly have a bug or some other problem. The
issue or issues might depend on the system much like the above _STATUS: possible
bug (possibly depending on system)_.


## STATUS: doesn't work with some platforms

**Please help us fix this bug**!

Entries with this status do not work under some OSes and/or architectures (and/or
something else?). Please help us to fix it!


## STATUS: doesn't work with some compilers

**Please provide alternative code or fix for more compilers**!

Some entries do not work with some compilers. A good example is
[1992/lush](%%REPO_URL%%/1992/lush/lush.c) which uses error messages from the compiler to
generate its output.

If you can provide code that works for multiple compilers without too much
tampering this is okay though it's probably not possible with the above
mentioned entry; otherwise it would be better to provide alternate code. In some
cases it might be better to provide alternate code anyway. Use a judgement call
here as best you can manage.



## STATUS: main() function args not allowed

**Please help us fix the main() function**!

NOTE: it appears that most if not all of these have been fixed except perhaps
for [1989/westley](%%REPO_URL%%/1989/westley/westley.c) but this has probably been fixed as
much as possible given the nature of how it generates code: the entry itself
compiles but two versions of code it generates does not work with clang.

However some still might have problems of some kind or another and some might
not yet be located as an additional defect of clang was noticed where `main()`
is not allowed four args or one arg.

This is what the status means, however.

Entries with this status have a problem in that the args to main() are not of a
specific type or there are too many due to this being allowed in earlier C. Some
compilers like clang have a defect where they do not allow this and some
versions have an additional defect where they only allow 0, 2 or 3 args, the
latter of which affected `1989/westley`, so these entries do not work with
clang.

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) looked at the source
code of clang and reported that there is no way to override the requirement of
arg types so these entries will fail to compile with clang. That's why in some
entries he fixed he did it by adding a function called `pain()`. :-) He did not
check for the number of args as that was discovered later but he suspects it's
the same issue.

**NOTE for macOS users**: please be aware that _gcc_ under macOS **is actually
clang** despite the fact it might appear to be gcc: no symlink and both gcc and
clang exist but the gcc is clang which you'll see if you run `gcc --version`.

A tip and some fix methods from Cody: in the older days args to main() not given
a type were implicit ints but when they're required to be `char **` this can
cause a problem. In some cases Cody was able to use a `char *` inside `main()`
(see [1989/tromp/tromp.c](%%REPO_URL%%/1989/tromp/tromp.c) and
[1986/holloway/holloway.c](1986/holloway/index.html) for two examples though done slightly
differently). In other cases he was able to dereference the pointers to be used
like an int and other times a cast was necessary. He used other various
techniques to get them to compile. In some cases this introduced a problem but
typically if not always that problem exists with compilers that are less strict.


## STATUS: main() has only one arg

**Please help modify so that main() as 2 or 3 args**!

Because some versions of clang complain about the number of args of `main()` and
in particular say (when it has four, for instance) that it's only allowed to
have 0, 2 or 3 args, numerous entries had a second arg added to `main()` (if
they only had one). This is in case clang adds further restrictions which is not
impossible especially as it already claims having only one arg is not allowed.
At this time (04 Feb 2024) there is one entry known (it is possible that not all
were checked) that has this problem but it's not as simple as the others to fix
without breaking it.


## STATUS: compiled executable crashes

**Please help us fix this bug**!

While such entries can compile, the resulting executable sometimes or always
crashes.

NOTE: this does NOT apply to entries under the INABIAF status (though they're
not mutually exclusive in some cases).

REMINDER: if you're debugging a crash it will be very helpful to have `-O0 -g`
or if you can `-ggdb3` when compiling as that will help with debugging symbols.


## STATUS: uses gets()

**Please help us change use of gets() to fgets()**, if possible.

Entries with this status use `gets()` which is unsafe because it has no limit on
the length of the string. [Cody Boone
Ferguson](authors.html#Cody_Boone_Ferguson) has fixed several of these and he's
working on others in between fixing other things.

There's a very good reason for this even though it is bordering on tampering
entries: in modern systems one will get possibly alarming and certainly annoying
warnings during at least one of compiling, linking and execution. In macOS it's
most annoying as it happens during execution (also compilation) with the warning
being interspersed with the output of the program, often causing confusing
output with the entry. A good example that was fixed is
[1990/tbr](%%REPO_URL%%/1990/tbr/tbr.c).

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

_NOTE_: this status is _NOT necessarily mutually exclusive_ with the _INABIAF_
(it's not a bug it's a feature) status. The reason for this is due to warnings
during compiling, linking and/or runtime, sometimes causing confusing output (as
noted above).

Sometimes `getline(3)` will work but note that this function also stores the
newline just like `fgets(3)`.


## STATUS: missing file(s)

**Please help is by finding missing file(s)**!

In these entries one file or multiple files are missing from the repo. In some
cases these files can be found on the [IOCCC website](https://www.ioccc.org) but
in other cases they are entirely absent. In this case you'll probably have to
contact the author (unless you are the author! :-) ).


## STATUS: missing or dead link

**Please help is fix missing or dead link(s)**!

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

[1984/mullender](%%REPO_URL%%/1984/mullender/mullender.c) (see below for a
version that works in modern systems) is very system specific and was before
system specific winning entries were discouraged. This is an all time personal
favourite of Landon Curt Noll. Run the alternate code to understand why this
might be (along with how strange the source code is :-) ).

An example where a crash is not a bug: [2019/endoh](%%REPO_URL%%/2019/endoh/prog.c) is
supposed to crash. There are others that are also supposed to crash or that are
known to segfault but are considered features.

An important note is that if the index.html of the entry has a bug status that
says it can be fixed it can be. Otherwise it should not be.

Nonetheless we challenge you to fix these entries for educational/instructional
value and/or enjoyment but we kindly request that you **DO NOT** submit a pull
request unless it's a bug or (mis)feature we would like you to fix! If you can't
figure it out you're invited to look at the git diffs, where there are some
(some were fixed earlier on but rolled back as both Cody and Landon individually
felt that the fix was tampering with the entry).

NOTE: in the case of `gets()` we've fixed some to avoid the warning of the
compiler, linker or even during runtime, depending on the system. In [some cases
like 1990/tbr](%%REPO_URL%%/1990/tbr/tbr.c) the fix actually prevents confusing output (though that
was not the only fix made in that entry).


### Exception: your own entries

Of course if you're the author you're welcome to fix your own entry, prefer your
own fix or suggest that they're fixed!


<hr>


# List of entries by year, sorted in alphabetical order per year


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1984">
# 1984
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1984_decot">
## 1984/decot
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1984/decot/decot.c](%%REPO_URL%%/1984/decot/decot.c)
### Information: [1984/decot/index.html](1984/decot/index.html)

The purpose of this program is to print out what looks like a fragment of C
code. In particular you should see something like:

``` <!---sh-->
    $ ./decot
    '",x);      /*
    \
```

without a newline after the `\`. This is not a bug.


<div id="1984_laman">
## 1984/laman
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1984/laman/laman.c](%%REPO_URL%%/1984/laman/laman.c)
### Information: [1984/laman/index.html](1984/laman/index.html)

This program will very likely crash or do something funny without an arg.


<div id="1984_mullender">
## 1984/mullender
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1984/mullender/mullender.c](%%REPO_URL%%/1984/mullender/mullender.c)
### Information: [1984/mullender/index.html](1984/mullender/index.html)

Although there is an alt version and supplementary program added by Cody that
will work in modern systems, if you do not have a
[VAX-11](https://en.wikipedia.org/wiki/VAX-11) or
[PDP-11](https://en.wikipedia.org/wiki/PDP-11) to run the original entry on it
will not work. See the index.html for details on the alternate versions.

Cody added and fixed the [gentab.c](%%REPO_URL%%/1984/mullender/gentab.c) which is from the
author's (or one of them, Mullender) remarks found by Cody. Cody fixed this to
compile and work (as best as he can determine: he has no VAX-11 or PDP-11 or
emulator to test it) but running the code on the binary itself produces a
`short[]` that can compile in modern systems though it'll not work.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1985">
# 1985
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There are no known bugs or (mis)features for entries in 1985.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1986">
# 1986
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1986_august">
## 1986/august
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1986/august/august.c](%%REPO_URL%%/1986/august/august.c)
### Information: [1986/august/index.html](1986/august/index.html)


This entry is known to segfault after printing its output. It was documented by
the judges and shouldn't be fixed.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1987">
# 1987
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There are no known bugs or (mis)features for entries in 1987.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1988">
# 1988
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1988_dale">
## 1988/dale
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1988/dale/dale.c](%%REPO_URL%%/1988/dale/dale.c)
### Information: [1988/dale/index.html](1988/dale/index.html)

In linux it might happen that despite no error message or message about doing
so, the program drops a core file into the directory even though the entry works
and does not crash.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1989">
# 1989
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1989_fubar">
## 1989/fubar
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1989/fubar/fubar.c](%%REPO_URL%%/1989/fubar/fubar.c)
### Information: [1989/fubar/index.html](1989/fubar/index.html)

If you use either `fubar` or `ouroboros.c` (it's executable, see index.html for
details) with a number < 0 or larger than, say 20, it's very likely that the
program will turn into an infinite loop trying to compile code and end up with
with syntax errors. As this was documented it is not a bug to be fixed.


<div id="1989_robison">
## 1989/robison
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1989/robison/robison.c](%%REPO_URL%%/1989/robison/robison.c)
### Information: [1989/robison/index.html](1989/robison/index.html)

This program will very likely crash or break into tiny bits :-) if you feed it
numbers with non-binary digits.

There are also other cases where this can happen for instance using unsupported
operators like `/`. To see what operators are supported check the source code.


<div id="1989_westley">
## 1989/westley
</div>

### STATUS: known bug - please help us fix
### Source code: [1989/westley/westley.c](%%REPO_URL%%/1989/westley/westley.c)
### Information: [1989/westley/index.html](1989/westley/index.html)

With version 2 it sometimes segfaults even with the same input where other times
it does not. We don't believe this is because of the fix that lets some versions
be compiled with clang. An example invocation is:

``` <!---sh-->
    ./ver2 < westley.c
```

### A useful note on changing/fixing this program

It should be noted that in additional to rot13 names there is code that is the
reverse of other code (also wrt names). See the source file and the index.html
(in the author's remarks) for more details.

Fixing the (mis)feature is likely to be a very difficult challenge especially
without breaking something else which is far more likely (see below in tips from
Cody). You are welcome to try and fix it if you can!

### Tips from Cody:

The reason this is crashing is that the array `irk` is being accessed way out of
bounds by the int `gnat`. For instance:

```
    Program terminated with signal SIGSEGV, Segmentation fault.
    #0  0x0000000000401335 in main (ABBA@entry=<optimized out>, tang@entry=<optimized out>, gnat@entry=<optimized out>, Near@entry=<optimized out>)
        at ver2.c:23
    23  &&gnat!({)Near,noon,/*krelc*/)<0&&(Near= -      irk[-gnat--]-2)))&&main(ABBA,
    (gdb) p gnat
    $1 = -518733305
```

### Magic of the entry:

The real trouble is that the code is generated and in a complex way or rather
ways.

I will explain this a little bit (though it might be more than a bit according
to many :-) ) but that is all I can do for now. The program, when used without
any args, will print out what it reads. If one arg is specified it will do a
ROT13 of it. If two args are specified it will print out the text backwards
(_WITHOUT ROT13!_). If three args are specified it will do both **_reversal AND
ROT13_**.

So `ver0` is the same as the main program; `ver1` is the ROT13 of the code (but
see below); `ver2` will reverse the code and `ver3` will both reverse and ROT13
the code. But it's trickier than that as one might expect.

The comments are processed too. Furthermore it happens that the last line
becomes the first and the first line becomes the last! Now if you look at the
code you'll see on the first line:

``` <!---c-->
    /**//*/};)/**/pain(*//**/tang         ,gnat/**//*/,ABBA~,0-0(avnz;)0-0,tang,raeN
```

In `ver0` it'll be the same but the others are more interesting.

In `ver1` you'll see on the last line:

``` <!---c-->
    cnva((vag)NOON&2/*//*\\**/,gnat,tang        ,NOON/**//*/(niam/**/);}/*//**/
```

and on the first line:

``` <!---c-->
    /**//*/};)/**/cnva(*//**/gnat         ,tang/**//*/,NOON~,0-0(niam;)0-0,gnat,enrA
```

Observe that the ROT13 of `pain` is `cnva` and the ROT13 of `main` is `znva`.
The ROT13 of `NOON` is `ABBA`. `vag` is ROT13 of `int`, `gnat` and `tang` are
ROT13 of each other as well which is the reverse of the original (this is not
because it goes backwards (it doesn't in this version) but because they are
ROT13 pairs!). `main` spelt backwards is `niam` and `pain` spelt backwards is
`niap`. Furthermore see the Makefile for other defines that had to be specified
and for `ver2` and `ver3` (that both work with gcc) one had to be undefined (search
for `CDEFINE` and `-U`). These details will be important momentarily.

As far as `NOON` and `ABBA` being ROT13 pairs, notice how `NOON` is not in the
original code but `ABBA` is; but in other versions it becomes `NOON` and they
also have `abba` which the original code does not!

Now notice how the `avnz` in the first line got changed to `niam`, its ROT13
value.  Notice also how some of these are in comments!

`main()` is in there somewhere and that had to be changed to call
`pain()` (see the [thanks](thanks-for-help.html#1989_westley)
file (see the _1989/westley_ section for details on how as this was
not as straight forward as it is for other entries) as well. Now
if you notice on that line you have in a comment `niam`. If you
were to change that to `niap` (pain backwards) that function would
end up as `pain()` in generated code! That's assuming that it's
just the reversal version, of course but ver1 is the ROT13 version.

These facts are bad enough but then you throw in the reverse of it without ROT13
and then another version that has the reversal _and_ ROT13 then you can see it's
nigh impossible to fix if not impossible.

The fix to get it to even compile with clang and then get the first two
(counting the original, `ver0`) to work was the hardest fix I made due to how
the comments in reverse and ROT13 of it all works together, especially allowing
all versions to compile with gcc. The only reason that it doesn't work
completely with clang is the arg types of main() (see if you can figure out how
the change of `main()` in `westley.c` is not carried over to versions 2 and 3!);
originally none of them compiled with clang.

But it was possible to get the ROT13 code to compile with clang but the other
versions, reversed as well as ROT13 and reversed code, proved much more
problematic. I got it to compile (or maybe mostly compile) all versions with
clang but I then carried it over to gcc in another system and it had syntax
errors.

That's about all I can say for how it works as other things have to be done too.
Enjoy! :-)


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1990">
# 1990
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1990_baruch">
## 1990/baruch
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1990/baruch/baruch.c](%%REPO_URL%%/1990/baruch/baruch.c)
### Information: [1990/baruch/index.html](1990/baruch/index.html)

A point worth considering is that as the number passed into the program gets
bigger the number of lines of output gets substantially larger and it takes much
more time and resources to run as well. For instance:

``` <!---sh-->
    $ for n in $(seq 1 18); do echo "$n"; echo "$n" | time "./baruch" | wc -l | sed -E -e 's/[[:space:]]//g'; done
    1
    3
    ./baruch  0.00s user 0.00s system 5% cpu 0.115 total
    2
    1
    ./baruch  0.00s user 0.00s system 64% cpu 0.004 total
    3
    1
    ./baruch  0.00s user 0.00s system 60% cpu 0.003 total
    4
    11
    ./baruch  0.00s user 0.00s system 64% cpu 0.003 total
    5
    61
    ./baruch  0.00s user 0.00s system 66% cpu 0.003 total
    6
    29
    ./baruch  0.00s user 0.00s system 61% cpu 0.003 total
    7
    321
    ./baruch  0.00s user 0.00s system 69% cpu 0.002 total
    8
    829
    ./baruch  0.00s user 0.00s system 76% cpu 0.003 total
    9
    3521
    ./baruch  0.00s user 0.00s system 87% cpu 0.005 total
    10
    7965
    ./baruch  0.01s user 0.00s system 95% cpu 0.014 total
    11
    32161
    ./baruch  0.05s user 0.00s system 98% cpu 0.053 total
    12
    184601
    ./baruch  0.29s user 0.00s system 99% cpu 0.294 total
    13
    1031969
    ./baruch  1.78s user 0.00s system 99% cpu 1.794 total
    14
    5483941
    ./baruch  11.26s user 0.02s system 99% cpu 11.311 total
    15
    36466945
    ./baruch  79.20s user 0.15s system 99% cpu 1:19.72 total
    16
    251132705
    ./baruch  592.89s user 0.77s system 99% cpu 9:55.34 total
    17
    1724671873
    ./baruch  4535.71s user 5.25s system 99% cpu 1:15:49.76 total
    18
    12655721857
    ./baruch  37496.97s user 58.50s system 99% cpu 10:27:48.29 total
```

This is not considered a bug, however.


<div id="1990_jaw">
## 1990/jaw
</div>

### STATUS: known bug - please help us fix
### Source code: [1990/jaw/jaw.c](%%REPO_URL%%/1990/jaw/jaw.c)
### Information: [1990/jaw/index.html](1990/jaw/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson)
fixed some issues in this program and [Yusuke
Endoh](authors.html#Yusuke_Endoh) provided the `btoa`
script but it appears there is a bug in this entry. The judges wrote that to
test the entry one can do:

``` <!---sh-->
    echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
```

which should apply the identity transformation to a minimal holoalphabetic
sentence.

But doing this shows instead:

``` <!---sh-->
    echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
    a얖?)V...?????777??hC??h??-?    )SSSSXXX????r?L=???*?-???ppp,,,?R
    ?j
    111-)))? '..F@E
           ???b111?
    ..F..F.?n,,,,,L@E$
```

Notice how there's no newline at the end: that final `$` is the prompt.

If one does, however:

``` <!---sh-->
    echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw | ./jaw
```

they will get just

```
    oops
```

which seems to be an error message (one of the fixes was to make it not use
`perror(3)` - this fixed something else though it's no longer known what except
that in macOS if `errno` is 0 it reports what looks like an error, rather than
success in, say, linux).

The script [shark.sh](%%REPO_URL%%/1990/jaw/shark.sh) has some issues too in that due to
path not having `.` (this and maybe some other things were fixed) and `tar` not
wanting to accept reading from `stdin` (this in particular) even with the right
options used, seemingly, it has to write to disk the tarball which seems to
defeat the purpose. This would ideally be fixed.


<div id="1990_tbr">
## 1990/tbr
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1990/tbr/tbr.c](%%REPO_URL%%/1990/tbr/tbr.c)
### Information: [1990/tbr/index.html](1990/tbr/index.html)

The authors provided a list of features in the
[BUGS](1990/tbr/index.html#bugs) section in their remarks.


<div id="1990_theorem">
## 1990/theorem
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1990/theorem/theorem.c](%%REPO_URL%%/1990/theorem/theorem.c)
### Information: [1990/theorem/index.html](1990/theorem/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed many bugs that
prevented this from working properly (including segfaults) but one thing to note
is that if you pass two zeroes to `theorem_bkp` or `fibonacci` the program
will enter an infinite loop, printing 0 over and over again; another condition
where this occurred was fixed but this one should not be fixed. Thank you.


<div id="1990_westley">
## 1990/westley
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1990/westley/westley.c](%%REPO_URL%%/1990/westley/westley.c)
### Information: [1990/westley/index.html](1990/westley/index.html)

Although Cody fixed this to not enter an infinite loop if the arg (converted to
a number) is < 0 the lack of an arg check at all was kept in to make it like the
original. The reason for the < 0 check is it floods the screen (yes this is
indeed inconsistent with some other entries but it is not worth the time spent,
maybe, to change it back, especially as it is annoying to have the screen
flooded).



<hr style="width:10%;text-align:left;margin-left:0">
<div id="1991">
# 1991
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1991_buzzard">
## 1991/buzzard
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1991/buzzard/buzzard.c](%%REPO_URL%%/1991/buzzard/buzzard.c)
### Information: [1991/buzzard/index.html](1991/buzzard/index.html)

If the maze file cannot be opened, either because the path specified does not
exist or because the default (whatever the source file was at compilation time)
file does not exist in the directory, this program will very likely crash.

This is a feature, not a bug.


<div id="1991_westley">
## 1991/westley
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1991/westley/westley.c](%%REPO_URL%%/1991/westley/westley.c)
### Information: [1991/westley/index.html](1991/westley/index.html)

There is a very simple way to always win. The program doesn't catch you and as
someone called Cody's late grandmother said to him: '_it's not cheating unless
you're caught_'. :-)

Please don't try and fix it as it's not a bug and was actually documented as a
possibility. Can you find out how? There's also a way to make it so that even
when you're cheating it ends up winning! Can you figure that out as well?


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1992">
# 1992
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1992_adrian">
## 1992/adrian
</div>


### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1992/adrian/adrian.c](%%REPO_URL%%/1992/adrian/adrian.c)
### Information: [1992/adrian/index.html](1992/adrian/index.html)

The author stated that if the file cannot be opened then it will print a system
error but this is not the case unless it's showing a fault. However this was
instead fixed by Cody as part of another problem that was detected so that the
program just exits 1 if the file cannot be opened.

Also, if _some_ of the programs are not given an arg they will very likely crash
or do something funny. For instance `adsleep` and `adbasename`. This is very
simple to fix but the author explicitly noted that this will segfault and it is
that that is the error message.

Another thing is that the code:

``` <!---c-->
    printf((W,Y));
```

appears to be wrong because `W` is a `FILE *` and `Y` is a `char[]` but if one
changes it to use `fprintf()` on the file (which, incidentally, is opened in
read only mode which is another reason) with the `%s` specifier it will make
`adhead` not work: it'll print nothing at all! So this code should not be
changed either even if it appears to be wrong. Notice too a curious thing: if
you did change it to `fprintf()`, even if you have the right number of args, you'd
have to remove the outer `()` pair.


<div id="1992_albert">
## 1992/albert
</div>


### STATUS: known bug - please help us fix
### Source code: [1992/albert/albert.c](%%REPO_URL%%/1992/albert/albert.c)
### Information: [1992/albert/index.html](1992/albert/index.html)

Leo Broukhis, before he was an IOCCC judge, sent the IOCCC judges an email:


> From: leo _at_ zycad -dot- com (Leo Broukhis)<br>
> Date: Tue, 30 Jan 96 17:37:51 PST<br>
> To: judges _at_ toad -dot- com<br>
> Subject: IOCCC 1992 - a bug<br>
>
> Dear Judges,
>
> `albert.c` (even in its fixed form) still has a bug. Although I don't
> remember the number that exposed the bug (afair, resulting in coredump)
> in `albert.orig.c` that has been fixed in `albert.c`,
>
> I've found a number exposing another bug: 10000000001 (that's 9 0's).
> Both albert and albert.orig loop without printing anything, although
> the first factor is 101 and is usually found in an instant.



A quick debugging session from Cody suggests that the problem with this value
is that:

``` <!---c-->
    if ( ppp->qq!=48 ) return;
```

is never reached because the value is never 48 (it is in other cases but not for
the example input). It varies in value at this point. Observe that the next
lines of code are:

``` <!---c-->
    while ( ppp->qq==48 )
    {
        printf("%ld\n",qqq-45);
        *pp = ppp;
        ppp = ppp->p;
    }
```

so it is expected that that value is 48, before printing the numbers, but if
it's not it should not proceed at all, not even to go past that loop. In other
words that loop should always be entered for at least one iteration. The check
for the `!= 48` is also required.

Perhaps more useful to know is that at this point in the code the code:

``` <!---c-->
    if ((((( !(aa=setjmp(ppp->ppp))||aa==aaaaaa )))))
```

appears to be entered because of the return value of `setjmp()`, not the other
condition.

The alt version does fix the problem but it is not obfuscated and not like the
entry itself. Can you fix the actual entry? You are welcome to try and do so.


<div id="1992_gson">
## 1992/gson
</div>

### STATUS: uses gets() - change to fgets() if possible
### Source code: [1992/gson/gson.c](%%REPO_URL%%/1992/gson/gson.c)
### Information: [1992/gson/index.html](1992/gson/index.html)

This code uses `gets(3)` on a buffer size of 256 to read from the dictionary. It
is highly unlikely that a line in a dictionary file will be this long but it
could happen and it would be ideal if the code used `fgets(3)` instead.
Unfortunately with this entry it's not as simple due to how `gets(3)` is used,
which can be described simply as: first `m` is set to `*++p` in a for loop where
`p` is argv. Later `m` is set to point to `h` which was of size 256\. `gets(3)`
is called as `m = gets(m)`) but trying to change it to use `fgets(3)` breaks the
program.


### STATUS: INABIAF - please **DO NOT** fix

On the other hand, the author noted the following bugs and limitations:

- There is no error checking.
- Standard input must be seekable, so you can't pipe the dictionary into `AG`.
- The input sentence and each line in the dictionary may contain at most 32
distinct letters, and each letter may occur at most 15 times.
- Words in the dictionary may be at most 255 bytes long.
- `AG` cannot handle characters that sign-extend to negative values.
- Although `AG` works on both 16-bit and 32-bit machines, the size of the problems
it can solve is severely limited on machines that limit the stack size to 64k or
less.

... so whether or not the `gets(3)` should be changed to `fgets(3)` is up to
debate.


<div id="1992_kivinen">
## 1992/kivinen
</div>

### STATUS: known bug - please help us fix
### Source code: [1992/kivinen/kivinen.c](%%REPO_URL%%/1992/kivinen/kivinen.c)
### Information: [1992/kivinen/index.html](1992/kivinen/index.html)

When you start the program everything starts to move over to the right side and
then ends.  [Yusuke Endoh](authors.html#Yusuke_Endoh) pointed out that if you
click the mouse it takes it back towards the centre.

If you want to try and fix this, you are welcome to try.


<div id="1992_lush">
## 1992/lush
</div>

### STATUS: doesn't work with some compilers - please provide alternative code or fix for more compilers
### Source code: [1992/lush/lush.c](%%REPO_URL%%/1992/lush/lush.c)
### Information: [1992/lush/index.html](1992/lush/index.html)

We used a patch from [Yusuke Endoh](authors.html#Yusuke_Endoh) to get this to
work but it only works with gcc. Cody removed the warnings of `gets()` and
provided a script to run the entry properly.

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


<div id="1992_vern">
## 1992/vern
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1992/vern/vern.c](%%REPO_URL%%/1992/vern/vern.c)
### Information: [1992/vern/index.html](1992/vern/index.html)

When your own checkmate is imminent it prints `"Har har"` but does not exit so
it can '_rub your nose in defeat_', as the author puts it. You will have to exit
it yourself through ctrl-c or killing it in some other fashion.


<div id="1992_westley">
## 1992/westley
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1992/westley/westley.c](%%REPO_URL%%/1992/westley/westley.c)
### Information: [1992/westley/index.html](1992/westley/index.html)

Cody improved the usability of this program by making it so that as long as the
terminal columns is >= 80 it will display properly, rather than having to wrap
at 80 columns. However due to the nature of the program if the terminal is < 80
in column width it will not display right.  To see the number of columns in your
terminal try:

``` <!---sh-->
    echo $COLUMNS
```


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1993">
# 1993
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1993_ant">
## 1993/ant
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/ant/ant.c](%%REPO_URL%%/1993/ant/ant.c)
### Information: [1993/ant/index.html](1993/ant/index.html)

The author stated that:

> The expression `(a*)*` compiles but loops forever.
>
> There is no check for trailing backslash (`\`) in the pattern.
>
> There is no check for unbalanced brackets.  Omitting a closing bracket will
generate a "Pattern too long" error, which is not the real error.


<div id="1993_cmills">
## 1993/cmills
</div>

### STATUS: known bug - please help us fix
### Source code: [1993/cmills/cmills.c](%%REPO_URL%%/1993/cmills/cmills.c)
### Information: [1993/cmills/index.html](1993/cmills/index.html)

In multiple platforms, both macOS and also linux (in particular a RHEL 9.3
system), this entry just shows a blank screen.

Can you fix it? We welcome your help.


<div id="1993_lmfjyh">
## 1993/lmfjyh
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/lmfjyh/lmfjyh.c](%%REPO_URL%%/1993/lmfjyh/lmfjyh.c)
### Information: [1993/lmfjyh/index.html](1993/lmfjyh/index.html)

This entry relied on a bug in gcc that was fixed with gcc version 2.3.3. This
cannot be fixed for modern systems as the bug is long gone.

An alternate version that will work for modern systems, however, does exist. See
the index.html file for details.


<div id="1993_rince">
## 1993/rince
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/rince/rince.c](%%REPO_URL%%/1993/rince/rince.c)
### Information: [1993/rince/index.html](1993/rince/index.html)

Although the code checks if the file can be opened or not, badly formatted files
will cause problems. No other checks are performed either.

There is no end of game checking function so you will have to quit the game
through ctrl-c or such.


<div id="1993_schnitzi">
## 1993/schnitzi
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/schnitzi/schnitzi.c](%%REPO_URL%%/1993/schnitzi/schnitzi.c)
### Information: [1993/schnitzi/index.html](1993/schnitzi/index.html)

If the file cannot be opened it will very likely segfault. This should not be
fixed except for an exercise to yourself, should you wish to try.

This program uses `system(3)` so if you provide invalid characters in the
question you might cause an error. For instance don't do this:

``` <!---sh-->
    $ ./schnitzi schnitzi.info
    This program answers questions about paragraphs
    of text posed to it in English.  It is written
    in C.  Mark Schnitzius is the author of this
    program.

    The Loch Ness monster has been captured.  Elvis
    is alive.  Hostler was a woman.  The NASA moon
    landings were clearly faked.


    ? What is foo'?
```

because doing so will result in something like:

```
    sh: -c: line 0: unexpected EOF while looking for matching `''
    sh: -c: line 1: syntax error: unexpected end of file
```

with the program terminating. Other characters will also cause this problem.

Of course if you do something like:

```
    What is 'foo'?
```

it will work fine.


<div id="1993_vanb">
## 1993/vanb
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1993/vanb/vanb.c](%%REPO_URL%%/1993/vanb/vanb.c)
### Information: [1993/vanb/index.html](1993/vanb/index.html)

No spaces are allowed in the expression.

The program does no error checking so erroneous expressions will produce
spurious results.

The unary `-` is an operator so decimal `-46` should be entered as `-d46` and
not `d-46`.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1994">
# 1994
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1994_dodsond2">
## 1994/dodsond2
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1994/dodsond2/dodsond2.c](%%REPO_URL%%/1994/dodsond2/dodsond2.c)
### Information: [1994/dodsond2/index.html](1994/dodsond2/index.html)

When you initiate shooting via the `s` command you immediately lose an arrow
**before you choose _where to_ shoot**.

Also, when you shoot it will move you to that room so if you end up shooting
into a pit room you will end up dying even though you didn't explicitly move
there.


<div id="1994_ldb">
## 1994/ldb
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1994/ldb/ldb.c](%%REPO_URL%%/1994/ldb/ldb.c)
### Information: [1994/ldb/index.html](1994/ldb/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed this to compile
with modern systems but the entry also used `gets(3)` which in some systems would
print out a warning along with the output of the program. Naturally it could
also overflow long lines, of which there are many, though that is more
considered a feature, not a bug, as it was documented by the author.

Cody changed it to `fgets(3)` to prevent the display problem but this introduces
another problem namely that newlines can be printed if the line length < 231.

This seems like a worthy compromise to not have messed up output and although it
would be ideal for it to never print a newline (unless that's the line itself)
it might be tampering too much with the entry to fix this problem, as it's not a
real problem and as a one liner it's already quite long.

See the
FAQ on "[gets and fgets](faq.html#gets)"
for more information on the change to `fgets(3)`.


<div id="1994_schnitzi">
## 1994/schnitzi
</div>

### STATUS: uses gets() - change to fgets() if possible
### Source code: [1994/schnitzi/schnitzi.c](%%REPO_URL%%/1994/schnitzi/schnitzi.c)
### Information: [1994/schnitzi/index.html](1994/schnitzi/index.html)

NOTE: the generated code of all versions, when fed its own source, will differ
even when it works. See the author's remarks in the index.html for details.
Increasing the buffer size and having it, when fed its own source code,
generate code that will compile with the same buffer size is difficult: it just
uses the original size. Cody explains this further down.

Getting it to use `fgets()` is even harder as when fed its own code it will
generate code that cannot even compile let alone use `fgets(3)`.

In both cases, changing the buffer size and changing it to use `fgets(3)`, will
cause compilation errors without other adjustments.

See the below magic for details. Along with the author's remarks in the
index.html file it might prove possible to get it to use `fgets(3)`. Cody,
writing this on 02 November 2023, only just noticed the author's remarks and
will later on look at this if nobody takes up the challenge. More important work
like getting to a place that the next contest can run must be done first.

Cody explains the magic of how this entry works, which will be necessary if this
entry is to be fixed, below.

You might wish to run the command:

``` <!---sh-->
    make diff_orig_prog
```

to see what had to change for the buffer size, when looking at the below.
Furthermore you will want to look at:


``` <!---sh-->
    diff schnitzi.alt.c schnitzi.alt2.c
```

as the `fgets(3)` version can compile it just can't generate compilable code (let
alone using `fgets(3)`) when fed itself (to reiterate, just changing the call to
`fgets(3)` does not mean it can compile and there's a further problem in that
`fgets(3)` retains the newline whereas `gets(3)` does not). Nevertheless looking
at these commands will be of help to understand how it works.

For the alternate versions the other functionality is unaffected.

### The magic of [1994/schnitzi](%%REPO_URL%%/1994/schnitzi/schnitzi.c) and how it flips text

The problem is getting the generated code to use `fgets()` (once it even
compiles which was easy to do) and also have the updated buffer size be the
same (which was easy to do too at least in the original version). The generated
output, when changed to `fgets()` failed to compile and it also used `gets(3)`
and these are the bugs here.

The buffer size, when using `gets()` is still the same but as noted above the
original code has had a buffer size increase.

The real problem is with formatting the code. Take a look at the `#include
<stdio.h>`, `int r=0,x,y=0` and the interesting comment below it, at the top of
the file.

If you look at each column and go down that column you can see how it spells out
the code! For instance the first column looks like:


```
    #
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


``` <!---c-->
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

Getting this entry to use `fgets(3)` is easy but the problem is you're supposed
to be able to feed the source to the program and the output of that will be
compilable. It however will create compiler errors. So it's not just changing
the code to get it to use `fgets(3)`! I (Cody) already did this before I noticed
the other part which is why I rolled that part back. I did increase the buffer
size but that only works on the original source.

To say just how sensitive this entry is: even a space, lack of space or a
character, wrong character, lack of character or character in the wrong place
can cause a compilation error! Make sure that the output of:

``` <!---sh-->
    ./schnitzi < schnitzi.c
```

can be compiled and the output of that new program when fed itself can also be
compiled!


<div id="1994_shapiro">
## 1994/shapiro
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1994/shapiro/shapiro.c](%%REPO_URL%%/1994/shapiro/shapiro.c)
### Information: [1994/shapiro/index.html](1994/shapiro/index.html)

This program will likely crash if the source code file (by the name of the file
that's compiled) cannot be opened in the directory it is run from.

### Important reminder and a note about the `-1` value check for `getc()`:

Cody fixed the code to not use `-1` for the return value of `getc()`; this is
important because `EOF` is **NOT** guaranteed to be `-1` but rather any negative
value. On systems where `EOF != -1` the program would enter an infinite loop
until the program crashed, by chance reads a `-1` or was killed (it is for this
same reason that one should not use `EOF` for the `getopt()` functions as they
return `-1` when all options are parsed (for details on the definition of `EOF`
see `7.21 Input/output<stdio.h>` subsection 1 of the standard)).

An interesting problem occurred where changing the `-1` to `EOF` caused both
`warning: illegal character encoding in string literal` and `error: source file
is not valid UTF-8`. But since `EOF` is simply an int < 0 and making the loop
condition check that the return value is >= 0 does not cause a compilation error
and it functions correctly it will address the systems where `EOF != -1` just as
if it checked for `!= EOF`.

Since it works there is no need to fix this except for a challenge to yourself.


### STATUS: missing file - please provide it

The index.html file refers to an alternate version of the code that is not
obfuscated but it is missing from the entry directory and the archive. Do you
have this file?

We would be grateful if you could provide it to us.  If you can provide this
file you might consider removing this status from this file as well but if not
we'll take care of it.


<div id="1994_tvr">
## 1994/tvr
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1994/tvr/tvr.c](%%REPO_URL%%/1994/tvr/tvr.c)
### Information: [1994/tvr/index.html](1994/tvr/index.html)



The judges said the following in their remarks:

> The fractally minded may be able to detect that mode 0 does not calculate
Mandelbrot/Julian sets correctly.  Can you find the bug?  Better still, can you
fix it without breaking something else?

However, the author stated that this is a feature so this should not be fixed.
See also the other [bugs](1994/tvr/index.html#bugs) the author mentioned that,
as documented, are considered features.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1995">
# 1995
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1995_cdua">
## 1995/cdua
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1995/cdua/cdua.c](%%REPO_URL%%/1995/cdua/cdua.c)
### Information: [1995/cdua/index.html](1995/cdua/index.html)

This did not originally compile under macOS and after it did compile under
macOS, it crashed. [Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson)
fixed these problems.

It should be noted however that there is a condition where the program will
prompt you to press return again. This was thought to be a bug but looking at
the code it can clearly be seen that if `g - a` is 0 then the message is
supposed to be printed again and one is supposed to press a key as at that point
it calls `getchar()` via the pointer `m`. So this is a feature not a bug.


<div id="1995_leo">
## 1995/leo
</div>

### STATUS: known bug - please help us fix
### Source code: [1995/leo/leo.c](%%REPO_URL%%/1995/leo/leo.c)
### Information: [1995/leo/index.html](1995/leo/index.html)

The judges suggested that the following commands should result in output:


``` <!---sh-->
    ./leo 1 | cat - /dev/tty | gs -

    ./leo 37 80 | cat - /dev/tty | gs -
```

The first one can work if one does instead:

``` <!---sh-->
    echo "" | ./leo 1 > foo.ps
    gs foo.ps
```

but it is supposed to work in the pipeline as is. The second one does not appear
to work at all even if one redirects to a file (like the workaround for the
first) as it appears to just block.

It is not known if this is platform specific but this was observed in macOS and
it would be good if it was fixed.


<div id="1995_savastio">
## 1995/savastio
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1995/savastio/savastio.c](%%REPO_URL%%/1995/savastio/savastio.c)
### Information: [1995/savastio/index.html](1995/savastio/index.html)

This program expects a POSITIVE number. If you specify a negative number it will
not show any output, stuck in a loop.


<div id="1995_vanschnitz">
## 1995/vanschnitz
</div>

### STATUS: missing file - please provide it
### Source code: [1995/vanschnitz/vanschnitz.c](%%REPO_URL%%/1995/vanschnitz/vanschnitz.c)
### Information: [1995/vanschnitz/index.html](1995/vanschnitz/index.html)

The authors stated that they included a version that allows people with just K&R
compilers to use the program but this file is missing. Can you provide it?

We would appreciate anyone who has it or even just knows the name! Thank you.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1996">
# 1996
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1996_gandalf">
## 1996/gandalf
</div>

### STATUS: missing or dead link or links - please provide it or them
### Source code: [1996/gandalf/gandalf.c](%%REPO_URL%%/1996/gandalf/gandalf.c)
### Information: [1996/gandalf/index.html](1996/gandalf/index.html)

The link was `http://www.tc3.co.uk/~gandalf/G.HTML` but this no longer exists as
it was instead requiring a login / password.

Do you have an updated link? We welcome your help!


<div id="1996_huffman">
## 1996/huffman
</div>

### STATUS: uses gets() - change to fgets() if possible
### Source code: [1996/huffman/huffman.c](%%REPO_URL%%/1996/huffman/huffman.c)
### Information: [1996/huffman/index.html](1996/huffman/index.html)

The changing to using `fgets(3)` in this entry is a bit more complicated. It can
almost be done except that some of the output of the
[try.sh](%%REPO_URL%%/1996/huffman/try.sh) is wrong, especially the last one.

This diff almost does it but not quite:

``` <!---diff-->
    diff --git i/1996/huffman/huffman.c w/1996/huffman/huffman.c
    index a5745bc7f4fa28b834c004f4cf19633e40ad9165..5e5e5334f33f9dbd95c70eddece3189d9bcff5e9 100644
    --- i/1996/huffman/huffman.c
    +++ w/1996/huffman/huffman.c
    @@ -1,15 +1,16 @@
     #define x char
     #define z else
     #define w gets
    +#define gets(b) ((b)[0]='\0',(fgets((b), 100, stdin)))
     #define r if
     #define u int
     #define s main
     #define v putchar
     #define y while
     #define t " A?B?K?L?CIF?MSP?E?H?O?R?DJG?NTQ?????U?V?????X???????Z????W??Y??"
    - s (   )  {   x* c  ,  b[ 5  * 72   ]; u  a, e  ,  d   [  9
    + s (   )  {   x* c  ,  b[ 5  * 72  ]; u  a, e  ,  d   [  9
     *9 *9 ]  ;    y  (w  ( b) ){            r  ( 0   [ b] -7 *
     5        )    {  c  =     b    ;       y  (  (*    c  -  6
     * 7 )* *  c )c =  c+ 1  ;   r ((   -0 )  [ c  ] &&  w (  b   +
       8 *  5*    3        ) && w          (b   +8      *5  * 6) )
       { a       =  0; y     (                  a       [     b  ]
```

But since it does not for the time being it is advisable to just redirect
`stderr` to `/dev/null` (`2>/dev/null`).


<div id="1996_jonth">
## 1996/jonth
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1996/jonth/jonth.c](%%REPO_URL%%/1996/jonth/jonth.c)
### Information: [1996/jonth/index.html](1996/jonth/index.html)

If X is not running this program will very likely crash or do something funny.
This should NOT be fixed.

**NOTE**: the two boards will be on top of each other so you will have to drag one
off the other so that you can properly play.


### STATUS: missing or dead link or links - please provide it or them

As well: the link which was http://www.uio.no/~jonth is no longer valid and
there's no archive on the Internet Wayback Machine. Do you know of a proper URL?
We greatly appreciate your help here!


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1997">
# 1997
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 1997.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1998">
# 1998
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="1998_dlowe">
## 1998/dlowe
</div>

### STATUS: missing or dead link or links - please provide it or them
### Source code: [1998/dlowe/dlowe.c](%%REPO_URL%%/1998/dlowe/dlowe.c)
### Information: [1998/dlowe/index.html](1998/dlowe/index.html)

The domain http://pootpoot.com no longer exists as it once did. The judges have
given a script that can be used to make a similar page (**warning: not checked
for security in modern days!**). Do you have a server with enough bandwidth and
would like to set it up?  We'll gladly thank you in the index.html file and link
to the page as well!  You'll have IOCCC fame for reviving a pootifier! :-)


<div id="1998_dloweneil">
## 1998/dloweneil
</div>

### STATUS: missing or dead link or links - please provide it or them
### Source code: [1998/dloweneil/dloweneil.c](%%REPO_URL%%/1998/dloweneil/dloweneil.c)
### Information: [1998/dloweneil/index.html](1998/dloweneil/index.html)

See above entry [1998/dlowe](%%REPO_URL%%/1998/dlowe/dlowe.c).


<div id="1998_schnitzi">
## 1998/schnitzi
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [1998/schnitzi/schnitzi.c](%%REPO_URL%%/1998/schnitzi/schnitzi.c)
### Information: [1998/schnitzi/index.html](1998/schnitzi/index.html)

A point worth considering is that as the number passed into the program gets
bigger the number of lines of output gets substantially larger. For instance:

``` <!---sh-->
    $ ./schnitzi 9|wc -l
      771999
```

The larger the number the bigger the file can become too, even becoming
gigabytes in size. The range is checked for `>0 && <27` as not having this can
be a problem including a segfault.

If you use the generated program and do not give enough numbers in input
something funny will happen, very possibly with different results per run. This
is in the index.html file as something to try and ponder.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="1999">
# 1999
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 1999.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2000">
# 2000
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2000_dlowe">
## 2000/dlowe
</div>


### STATUS: known bug - please help us fix
### Source code: [2000/dlowe/dlowe.c](%%REPO_URL%%/2000/dlowe/dlowe.c)
### Information: [2000/dlowe/index.html](2000/dlowe/index.html)

The author gives an example command:

``` <!---sh-->
    echo "7 P 6 d P P 8 p" | ./dlowe | tr 876 tpo
```

which should print out `poot` but it doesn't, not in linux and not in macOS.

In linux it doesn't crash but it doesn't print anything out either.

In macOS it crashes; it might appear to not crash in macOS but this is because
of the pipeline. If you remove the `| tr 876 tpo` part of the command you will
see that it does indeed crash!

The reason for this not working is really strange.

``` <!---sh-->
    $ echo "7 P 6 d P P 8 p" | ./dlowe
    7668
    $ echo "7 P 6 d P P 8 p" | ./dlowe | grep 7
    $
```

Why? Is it writing to stdout? Let's try some other things:

``` <!---sh-->
    $ echo 7668 | tr 876 tpo
    poot
```

Okay so we know that it SHOULD work. But we also know something funny is going on with stdout and the entry. Another experiment:

``` <!---sh-->
    $ echo "7 P 6 d P P 8 p" | ./dlowe 1>&2 | grep 7
    7668
```

Okay so now it sees it, `grep`. But watch!

``` <!---sh-->
    $ echo "7 P 6 d P P 8 p" | ./dlowe 2>foo 1>&1
    7668
    $ cat foo
```

.. so at this hour it does appear to be writing to stdout but yet somehow it doesn't? But watch:

``` <!---sh-->
    $ echo "7 P 6 d P P 8 p" | ./dlowe 1>foo 1>&1
    $ cat foo
    $
```

Well this explains why the `tr` does not transliterate it to `poot` but why is
this happening? Why can't it be redirected to another file even?

If it could be figured out why it's not writing to stdout and yet at the same
time is writing to stdout one bug could be fixed. Maybe it's the perl messing
with things but we don't know.


Other commands do work, however, and give the appropriate output, such as:

``` <!---sh-->
    $ echo 1 2 + p | ./dlowe
    3
```

so something is wrong with some commands/operators.

Another feature that does work in linux is:

``` <!---sh-->
    $ echo poot | ./dlowe
    poot was here!
```

Can you help fix these problems?

Cody provided the C code that creates an unformatted perl script that will just
print 'unimplemented' for operators but it seems to work in some other ways (see
below for how to go further than unimplemented) which is the exact perl from the
C program except that it has the `#!/usr/bin/env perl` and `use warnings;` as
well. A note below might suggest that doing this creates incomplete perl.
Anyway:

``` <!---c-->
    #include <stdio.h>
    int main(void)
    {
        printf("#!/usr/bin/env perl\nuse warnings;_:$_=               <> ; defined               or exit; @ARGV"
            "=split; __:$_=             shift;defined or             goto _; chomp "
            ";(m*^\\x70oO"              "\\x74$*i)?(pri"              "nt \"$_ w\\x"
            "61s h\\145r\\x"            "65!\\n\"):((m*"            "^\\s\\*(-?\\d+"
            "(\\.\\d+)?)\\s"            "\\*$*)?(push@SS            ,$1):(&{chr(((o"
            "rd)%%39)+3**4)x2             } )); goto __;             sub ff { @SS= ("
            ")} sub __{print            \"stack empty\\"            "n\"} sub ss{$#"
            "SS<0 and goto &            __; print $SS[$"            "#SS].\"\\n\"} "
            "sub SS{ $#SS<0              and goto &__ ;              print pop @SS}"
            "sub _ { print              \"divide by zer"            "o\\n\"}sub ii{"
            "map{ print\"$_"            "\\n\" } reverse            @SS} sub AUTOLO"
            "AD { print\"un"            "implemented\\n"            "\"} sub gg{ $#"
            "SS<0 and goto              &__;push@SS,$SS[            $#SS]} sub uu{ "
            "$#SS<1 and goto            &__;$SS[ $#SS]+=            $SS[$#SS-1];$SS"
            "[$#SS-1]=$SS[$"            "#SS]-$SS[$#SS-"            "1]; $SS[$#SS]-"
            "=$SS[$#SS-1]}");
    }
```

Compiling this you can generate:


``` <!---perl-->
    #!/usr/bin/env perl
    use warnings;_:$_=               <> ; defined               or exit; @ARGV=split; __:$_=             shift;defined or             goto _; chomp ;(m*^\x70oO\x74$*i)?(print "$_ w\x61s h\145r\x65!\n"):((m*^\s\*(-?\d+(\.\d+)?)\s\*$*)?(push@SS            ,$1):(&{chr(((ord)%39)+3**4)x2             } )); goto __;             sub ff { @SS= ()} sub __{print            "stack empty\n"} sub ss{$#SS<0 and goto &            __; print $SS[$#SS]."\n"} sub SS{ $#SS<0              and goto &__ ;              print pop @SS}sub _ { print              "divide by zero\n"}sub ii{map{ print"$_\n" } reverse            @SS} sub AUTOLOAD { print"unimplemented\n"} sub gg{ $#SS<0 and goto              &__;push@SS,$SS[            $#SS]} sub uu{ $#SS<1 and goto            &__;$SS[ $#SS]+=            $SS[$#SS-1];$SS[$#SS-1]=$SS[$#SS]-$SS[$#SS-1]; $SS[$#SS]-=$SS[$#SS-1]}
```

Here is example input/output:

```
    p
    stack empty
    5 p
    5
    5 + 5 p
    unimplemented
    5
    P
    5
    p
    5
```

So you can see that if one uses operators it just shows 'unimplemented' (observe
how this does not happen in the C program in linux!) but if one uses 'p' by
itself it will print what's on the stack (for example).

To not get 'unimplemented' you can remove from the perl:


``` <!---perl-->
    sub AUTOLOAD { print"unimplemented\n"}
```

(Note that the author stated this was used for exception handling so another
possibility is that the C code doesn't generate the correct perl and indeed even
spaces is known to break the perl in at least one way, syntax errors, but maybe
others too.)

Here is an example run of several operations in the perl script after removing
that subroutine:

``` <!---sh-->
    $ echo 5 5 p | ./dlowe.pl
    5
    $ echo 5 5 + p | ./dlowe.pl
    5
    Undefined subroutine &main::UU called at ./pl.pl line 2, <> line 1.
    $ echo 5 5 * p | ./dlowe.pl
    5
    Undefined subroutine &main::ww called at ./pl.pl line 2, <> line 1.
    $ echo 5 5 - p | ./dlowe.pl
    5
    Undefined subroutine &main::WW called at ./pl.pl line 2, <> line 1.
    $ echo 5 5 / p | ./dlowe.pl
    5
    Undefined subroutine &main::YY called at ./pl.pl line 2, <> line 1.
    $ echo 5 P | ./dlowe.pl
    5$ echo p | ./dlowe.pl
    stack empty
    $ echo P | ./dlowe.pl
    stack empty
```

Note the undefined subroutine error: that happens with commands that are not
even in the program. Again the author used `AUTOLOAD` for exception handling so
it seems likely that there is something missing (which the below shows as well).
For instance inputting `D` followed by `XX`:

```
    Undefined subroutine &main::nn called at ./pl.pl line 2, <> line 6.
    Undefined subroutine &main::[[ called at ./pl.pl line 2, <> line 1.
```

That means then that in linux despite the subroutines seemingly not existing it
works in the code, at least in some cases.

As far as the unimplemented error goes: the author stated that it means there is
invalid input. But as can be seen by the input I (Cody) gave the input is not
actually incorrect. It is also curious to note that it ends up printing what's
on the stack at that point:

``` <!---sh-->
    $ echo 5 5 + p | ./dlowe.pl
    unimplemented
    5
```

which might (?) suggest that the `+` operator is unimplemented. Unfortunately it
has been many years since I have used perl and I was never a guru either.


### STATUS: INABIAF - please **DO NOT** fix

The author states that in perl < 5.6.0 there is a bug with a core dump in what
they said is in `Perl_sv_upgrade`. As this is documented it is not considered a
bug to be fixed. For the curious this will crash in macOS. Cody notes that the
code that crashes is:

``` <!---c-->
    perl_eval_sv
    (newSVpv("_:$_=               <> ; defined               or exit; @ARGV"
    "=split; __:$_=             shift;defined or             goto _; chomp "
    ";(m*^\\x70oO"              "\\x74$*i)?(pri"              "nt \"$_ w\\x"
    "61s h\\145r\\x"            "65!\\n\"):((m*"            "^\\s\\*(-?\\d+"
    "(\\.\\d+)?)\\s"            "\\*$*)?(push@SS            ,$1):(&{chr(((o"
    "rd)%39)+3**4)x2             } )); goto __;             sub ff { @SS= ("
    ")} sub __{print            \"stack empty\\"            "n\"} sub ss{$#"
    "SS<0 and goto &            __; print $SS[$"            "#SS].\"\\n\"} "
    "sub SS{ $#SS<0              and goto &__ ;              print pop @SS}"
    "sub _ { print              \"divide by zer"            "o\\n\"}sub ii{"
    "map{ print\"$_"            "\\n\" } reverse            @SS} sub AUTOLO"
    "AD { print\"un"            "implemented\\n"            "\"} sub gg{ $#"
    "SS<0 and goto              &__;push@SS,$SS[            $#SS]} sub uu{ "
    "$#SS<1 and goto            &__;$SS[ $#SS]+=            $SS[$#SS-1];$SS"
    "[$#SS-1]=$SS[$"            "#SS]-$SS[$#SS-"            "1]; $SS[$#SS]-"
    "=$SS[$#SS-1]}                   ",0),0                   );
```

and in particular it appears that it is the perl itself. In other words if one
changes it to be:

``` <!---c-->
    perl_eval_sv(newSVpv("",0),0);
```

it will not crash. But of course it won't do anything either. So it's more
specifically that the call to `newSVpv()` crashes the code but _INSIDE_
(key point!) the call to `perl_eval_sv()` that does it. Given what the author
stated and that the version of perl is < than 5.6.0 which the author states can
crash this makes sense.

The example command above _should_ print:

``` <!---sh-->
    $ echo "13 14 15 16 17 + - * / p" | ./dlowe
    -0.0515873015873016
```

and that's what it shows in linux.

Note that with different perl libraries in macOS (for instance from
[Homebrew](https://brew.sh) and [MacPorts](https://www.macports.org) package managers) it will
likely print different warnings when compiling. It was observed that with
Homebrew it does not report any warnings but with MacPorts it results in a total
of 92 warnings! Nonetheless neither works okay and both crash.



<div id="2000_primenum">
## 2000/primenum
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2000/primenum/primenum.c](%%REPO_URL%%/2000/primenum/primenum.c)
### Information: [2000/primenum/index.html](2000/primenum/index.html)

This program does not do what you might think it does! Running it like:

``` <!---sh-->
    ./primenum 13
```

will seemingly wait for input exactly because it is waiting for input. See the
index.html file or look at the source.

Although the name of the program suggests it prints prime numbers this is not
the case. This is by design. See the author's comments for more details or
better yet look at the code and if necessary try it out.  Please do not try and
fix this.

A crash in the program is known as well. This is also a feature.  Please do not
try to fix the crashing of this code except to challenge yourself (if you think
that it'll be worth your two second fix :-) ).  If you do fix it please do not
make a pull request.


<div id="2000_rince">
## 2000/rince
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2000/rince/rince.c](%%REPO_URL%%/2000/rince/rince.c)
### Information: [2000/rince/index.html](2000/rince/index.html)

If `DISPLAY` is not set the program will very likely crash, do something strange
(or if you're very unlucky your computer might [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_&#x28;computing&#x29;)! :-) ).


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2001">
# 2001
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2001_anonymous">
## 2001/anonymous
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/anonymous/anonymous.c](%%REPO_URL%%/2001/anonymous/anonymous.c)
### Information: [2001/anonymous/index.html](2001/anonymous/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed this so that it
doesn't segfault and then also fixed the functionality of it (but see below).

Cody also fixed the [anonymous.ten.c](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) program
(it also segfaulted) but notes that it **MUST** be compiled as a **32-bit ELF
binary** so it will NOT work in macOS (for example); if you cannot use `-m32` or
even if you can but it cannot compile as an ELF binary (not elf binary :-) )
(but see below) then the `anonymous` program itself will very likely crash if
you run it on the compiled [anonymous.ten.c](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) but
if nothing else it will not modify the target executable (this part of the fix
at least should be correct).

Note also that if you don't specify a file or you specify a non-32-bit ELF file
this program will very likely crash or do something strange like slaughter the
elves of Imladris :-(


<div id="2001_bellard">
## 2001/bellard
</div>

### STATUS: INABIAF - please **DO NOT** fix
### STATUS: doesn't work with some platforms - please help us fix it
### Source code: [2001/bellard/bellard.c](%%REPO_URL%%/2001/bellard/bellard.c)
### Information: [2001/bellard/index.html](2001/bellard/index.html)

The two statuses might seem contradictory but that is a complicated question.
The author stated that it only works with i386 linux so on the one hand the fact
it doesn't work in modern systems is considered a feature and not a bug. But on
the other hand it would be nice if there was an alternate version which worked
for modern systems. This does seem quite unlikely but some fixes, described
next, were made.

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed an initial
segfault (trying to open the file) and he also fixed the [supplementary program
bellard.otccex.c](%%REPO_URL%%/2001/bellard/bellard.otccex.c) but this still crashes in
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
[otccelf.c](%%REPO_URL%%/2001/bellard/otccelf.c) (after adding some `#include`s and the
modification by Yusuke noted in the [thanks](thanks-for-help.html)
file) but it appears this *also* requires i386 linux; indeed looking at the code
it hard codes paths that are i386 specific to linux.

Another point of interest is that the author provided de-obfuscated versions
which might be of value to look at.

If you have a fix for 64-bit systems this is welcome as an alternate version, as
stated above. You might like to look at the otccelf version but note that it (at
least in 64-bit linux and macOS) has compilation errors.


### Aside: why were there changes made if INABIAF ?

This is a good question. The reason is we believe it better to fix some obvious
problems: there were some bugs that would very possibly prevent it from working
even if it was in i386 linux though Yusuke seemed to get it to work in an
emulator so perhaps not. Still it's better to have the type of the file pointer
correct and so that the file can at least be opened in modern systems even if
the compiler won't work there.

Also the supplementary program, which did not work at all, was fixed (by Cody)
and it can be run by itself for fun in modern systems, which was not possible
before the fixes there.

<div id="2001_cheong">
## 2001/cheong
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/cheong/cheong.c](%%REPO_URL%%/2001/cheong/cheong.c)
### Information: [2001/cheong/index.html](2001/cheong/index.html)

This program will crash without an arg.


<div id="2001_dgbeards">
## 2001/dgbeards
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/dgbeards/dgbeards.c](%%REPO_URL%%/2001/dgbeards/dgbeards.c)
### Information: [2001/dgbeards/index.html](2001/dgbeards/index.html)

This program deliberately crashes if it loses (which is what it aims to do).


<div id="2001_herrmann1">
## 2001/herrmann1
</div>

### STATUS: missing files - please provide them
### Source code: [2001/herrmann1/herrmann1.c](%%REPO_URL%%/2001/herrmann1/herrmann1.c)
### Information: [2001/herrmann1/index.html](2001/herrmann1/index.html)

The author referred to the file `herrmann1.turing` but it does not exist not even
in the archive. Do you have a copy? Please provide it!


### STATUS: known bug - please help us fix

There is also a bug in part. During compilation you're supposed to see some
animation but this does not seem to work with modern gcc versions. It appears
that version 2.95 works but maybe others do as well. Do you have a fix? We would
appreciate your help!

If you want to try and fix this, you are welcome to try.


<div id="2001_kev">
## 2001/kev
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/kev/kev.c](%%REPO_URL%%/2001/kev/kev.c)
### Information: [2001/kev/index.html](2001/kev/index.html)

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


<div id="2001_ollinger">
## 2001/ollinger
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/ollinger/ollinger.c](%%REPO_URL%%/2001/ollinger/ollinger.c)
### Information: [2001/ollinger/index.html](2001/ollinger/index.html)

This program will very likely crash or do something unexpected if you do not
provide enough args.


<div id="2001_rosten">
## 2001/rosten
</div>


### STATUS: missing files - please provide them
### Source code: [2001/rosten/rosten.c](%%REPO_URL%%/2001/rosten/rosten.c)
### Information: [2001/rosten/index.html](2001/rosten/index.html)

The author stated that there is a cat man page for this program in case one
wanted to install it as a tool but this is missing.


<div id="2001_schweikh">
## 2001/schweikh
</div>


### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2001/schweikh/schweikh.c](%%REPO_URL%%/2001/schweikh/schweikh.c)
### Information: [2001/schweikh/index.html](2001/schweikh/index.html)

The glob pattern must match the whole string. See the author's comments for
details and a workaround.

There's also no way to escape meta characters.


<div id="2001_westley">
## 2001/westley
</div>


### STATUS: uses gets() - change to fgets() if possible
### Source code: [2001/westley/westley.c](%%REPO_URL%%/2001/westley/westley.c)
### Information: [2001/westley/index.html](2001/westley/index.html)

This function uses `gets(3)` but it would be ideal if it used `fgets(3)`. This
one is rather complicated and will be looked at later (some progress was made by
Cody but it is less important than other work) but you are welcome to try
and fix this if you wish.


### STATUS: main() has only one arg - try and make it have 2 or 3

This program only has one arg to `main()`. However changing it to have 2 is not
as simple as it might seem. Doing this breaks things. If memory serves changing
it to two will, for instance, break the punch card code output. It might be that
that is for `fgets(3)`, however, but the point remains: in order to test any
fixes you must determine if the extra files generated (some from `sort(1)`) -
see the index.html file - generate correct output as well as that the main entry
does too. You might try running the `try.sh` script and redirect it to a file
first so that you can compare the output. Make sure to recreate the extra files
as described by the author if you do fix this. This might be looked at later if
nobody else takes up the challenge.


### STATUS: missing files - please provide them

The author referred to a file `card.gif` but this file is missing. Do you have
it? Please provide it!


<div id="2001_williams">
## 2001/williams
</div>


### STATUS: known bug - please help us fix
### Source code: [2001/williams/williams.c](%%REPO_URL%%/2001/williams/williams.c)
### Information: [2001/williams/index.html](2001/williams/index.html)

There seem to be a couple bugs at least in this entry. The first one is that
when it does reach a certain point it crashes. This is in the function `J()` (or
one it calls?). But sometimes it seems to not get that far, just showing lines
moving back and forth. This is also in `J()`. It is not confirmed but it might
be that the lines are drawn by `XDrawString()`, the last part in `J()`.

`J()` has a `for` loop identified by `for` and also a couple `while` loops,
identified by `R`.

Since the game never ends properly the score is not printed either.

It appears that the crash happens in more than one place. For instance it has
happened at

``` <!---c-->
    XCheckMaskEvent(d, 4,&e)
```

but it's also happened at

``` <!---c-->
    else XDrawPoint(d    ,w,g,(l.s+=l.a)>>9,    h=(l.c+=l.b)>>9)
```

In both cases the pointer `d` was corrupted:

```
    (lldb) p d
    (Display *) 0x0000000000000001
```

It is believed that it also happened at

``` <!---c-->
    XDrawString(d,w,g,W/3,H/2,m,B);
```

in `J()` and for the same reason.

The loop seems to be stuck in the call to `usleep(3)` like:

``` <!---c-->
    usleep(p*200);
```

which happens to be in a `while()` loop.

There is a way to get the code to crash. If you don't do anything until
everything is destroyed (where you'd lose the game if it ended) and then you
start to shoot your missiles repeatedly it will eventually crash. It appears not
to be the case (though this was not tried as many times) if you start shooting
when the missiles come down. The fact you can shoot after it starts that
sleeping in a loop does suggest that it's not stuck only showing those lines and
sleeping.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2002">
# 2002
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2002.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2003">
# 2003
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2003.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2004">
# 2004
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2004_gavin">
## 2004/gavin
</div>

### STATUS: compiled executable crashes - please help us fix
### STATUS: doesn't work with some platforms - please help us fix it
### Source code: [2004/gavin/gavin.c](%%REPO_URL%%/2004/gavin/gavin.c)
### Information: [2004/gavin//index.html](2004/gavin//index.html)

Segmentation fault will occur in some systems. For instance on macOS with the
arm64 chip:

``` <!---sh-->
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

``` <!---patch-->
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

``` <!---make-->
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
            ${TAR} -cvf fs.tar sh vi gavin.c index.html prim

    gavin_clean:
            ${RM} -f sh vi kernel gavin.o

    gavin_clobber: gavin_clean
            ${RM} -f gavin fs.tar

    gavin_files: boot.b lilo.conf prim gavin_install.txt
```

The current ([Makefile](%%REPO_URL%%/2004/gavin/Makefile) was modified to try and
fit into the current IOCCC build environment.


### STATUS: INABIAF - please **DO NOT** fix

See [known features in the index.html](2004/gavin/index.html#known-features) for
things that are not bugs but documented (mis)features.


<div id="2004_jdalbec">
## 2004/jdalbec
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2004/jdalbec/jdalbec.c](%%REPO_URL%%/2004/jdalbec/jdalbec.c)
### Information: [2004/jdalbec/index.html](2004/jdalbec/index.html)

The author stated that:

```
    Arguments matching `/[^2]22$/` cause the program to segfault
    after rapidly exhausting the available stack space.  I could
    probably fix this by adding some special cases to the code,
    but [Blaine the Mono] it's quite a bit more exciting this way,
    don't you think?[/Blaine]  Since the trailing `22` will be
    its own atom anyway, you can just insert a space in front of
    it if you run into this feature (e.g. `1 22` instead of `122`).

    Arguments matching `/(?:.){10,}/` will produce visually incorrect
    results (e.g., generation 1 starting from 1111111111 will
    print as `: 1`), but there's nothing interesting about these
    arguments that can't be modeled using shorter runs of the same
    symbol.

    Arguments matching `/(?:.){257,}/` may produce mathematically
    incorrect results (e.g., generation 1 starting from a string
    of 257 `1`s will be calculated as `11`); the remark from the
    previous paragraph applies here also.
```


<div id="2004_sds">
## 2004/sds
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2004/sds/sds.c](%%REPO_URL%%/2004/sds/sds.c)
### Information: [2004/sds/index.html](2004/sds/index.html)

The generated code will very likely segfault or do something not intended if not
given the right args. See the index.html file for the correct syntax.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2005">
# 2005
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2005_anon">
## 2005/anon
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/anon/anon.c](%%REPO_URL%%/2005/anon/anon.c)
### Information: [2005/anon/index.html](2005/anon/index.html)

This program sometimes will create unsolvable puzzles :-) just to hook you.
As a protection against this - and to prevent you from spending too much time on
such puzzles (or too big puzzles if you insist on doing this) - it deliberately
destroys its runtime stack. See the [index.html](2005/anon/index.html) for more
details on this.

If you specify more than three args the program might also crash or do something
strange. This might also happen if you specify excessively large board
dimensions. Try `100 100 100` for instance and see what happens!


<div id="2005_giljade">
## 2005/giljade
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/giljade/giljade.c](%%REPO_URL%%/2005/giljade/giljade.c)
### Information: [2005/giljade/index.html](2005/giljade/index.html)

This entry will very likely segfault or do something strange if the source code
does not exist.

This entry requires that `sed` and `make` are in the path.


<div id="2005_mikeash">
## 2005/mikeash
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/mikeash/mikeash.c](%%REPO_URL%%/2005/mikeash/mikeash.c)
### Information: [2005/mikeash/index.html](2005/mikeash/index.html)

The author states:

* The only built-in functions are `defvar`, `format`, `substitute`,
`char-upcase`, `+`, `-`, `*`, and `/`.

* Only one variable is available. This variable is called `q`, although any
symbol name starting with the letter `q` will be mapped to this variable.

* Only the first letter of a function name is significant. For example,
`format`, `f`, `farm`, and various other words starting with `f` will all map to
the `format` function.

* The `defvar` function completely ignores its first parameter. It will always
store the result of evaluating its second parameter in `q`. Unlike in [Common
Lisp](https://en.wikipedia.org/wiki/Common_Lisp), multiple invocations of
`defvar` on the same variable will overwrite old values.

* Character constants are limited to `#\Newline` and single-character
constants such as `#\x`.

* The `char-upcase` function will give strange results if passed something
other than a lowercase character.

* The `format` function takes exactly three parameters. The first parameter is
ignored; output always goes to `stdout`. The second parameter must have exactly
one `~s` format specifier in it, and no other format specifiers are permitted.

* The arithmetic functions take exactly two parameters.

* All tokens must be separated from a following `)` by whitespace.

* A lot of other things. Notably, the language which this program interprets is
nowhere near
[Turing-complete](https://en.wikipedia.org/wiki/Turing_completeness).

Basically, the [LISP][] interpreter is good for some basic math operations, and
for running itself.


<div id="2005_mynx">
## 2005/mynx
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/mynx/mynx.c](%%REPO_URL%%/2005/mynx/mynx.c)
### Information: [2005/mynx/index.html](2005/mynx/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) notes that, though
probably obvious, this entry will not work with https. He added an alt version
that scans for https in case someone wants to set up a pipeline or other
workaround (perhaps with stunnel) or even add additional code to it to make it
work with https but the problem otherwise is a secure connection has to first be
set up in order to give http commands. This is not a bug but it's worth pointing
out as it won't work on as many websites as it used to including the [IOCCC
website](https://www.ioccc.org) itself.


<div id="2005_sykes">
## 2005/sykes
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2005/sykes/sykes.c](%%REPO_URL%%/2005/sykes/sykes.c)
### Information: [2005/sykes/index.html](2005/sykes/index.html)

The author stated the below points of interest.

The machine emulated is an older 40 column one so 80 column programs will not
show up correctly.

There is no emulation of [PET](https://en.wikipedia.org/wiki/Commodore_PET)
graphics characters.

The parameter controls the speed of the 60Hz "jiffy clock", and not the
processor speed. This means many games may run too fast to be usable -
it really depends on the speed of your machine.

Although the PET [emulator](https://en.wikipedia.org/wiki/Emulator) can do `LOAD`
and `SAVE`, it cannot `VERIFY` or `OPEN` and `CLOSE` files.

The [PET](https://en.wikipedia.org/wiki/Commodore_PET) hardware
[emulation](https://en.wikipedia.org/wiki/Emulator) is not at all complete -
features such as the hardware timers are completely missing. Some programs will
not run correctly.

The
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulation](https://en.wikipedia.org/wiki/Emulator) does not include the seldom
used decimal mode, or any of the "undocumented" instructions.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2006">
# 2006
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2006_birken">
## 2006/birken
</div>

### STATUS: uses gets() - change to fgets() if possible
### Source code: [2006/birken/birken.c](%%REPO_URL%%/2006/birken/birken.c)
### Information: [2006/birken/index.html](2006/birken/index.html)

This entry uses `gets(3)` which is unsafe and provides annoying warnings, most
obnoxious in macOS as it shows it at runtime (redirecting `stderr` to
`/dev/null` will silence it). The following diff will almost work but it crashes
with at least `computer.tofu` input file:

``` <!---diff-->
    12a13
    #define gets(c) fgets((c),PI,stdin)&&(((c)[strlen((c))-1]='\0'),c!=NULL)
```


<div id="2006_borsanyi">
## 2006/borsanyi
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/borsanyi/borsanyi.c](%%REPO_URL%%/2006/borsanyi/borsanyi.c)
### Information: [2006/borsanyi/index.html](2006/borsanyi/index.html)

The string specified must be <= 42 characters and may only consist of the
characters in the regex `a-z_A-Z0-9@.-`. Breaking these constraints will end up
with possibly corrupt GIF files.


<div id="2006_hamre">
## 2006/hamre
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/hamre/hamre.c](%%REPO_URL%%/2006/hamre/hamre.c)
### Information: [2006/hamre/index.html](2006/hamre/index.html)

This program will likely crash or do something funny without an arg.


<div id="2006_monge">
## 2006/monge
</div>

### STATUS: doesn't work with some platforms - please help us fix it
### Source code: [2006/monge/monge.c](%%REPO_URL%%/2006/monge/monge.c)
### Information: [2006/monge/index.html](2006/monge/index.html)

This program requires x86 (with an x87 FPU) or x86_64 machine and it requires
the SDL1 library.

This program also requires being able to read, write and execute memory. With the
Apple silicon chips this is not allowed. Fixing this might be quite challenging
but you are welcome to try and fix it.

If you do fix this it might be good to fix the alternate code as well or else
provide it as an additional alt version. Fixing this is very likely to be very
challenging and in some systems it will not be possible to fix but you are
welcome to try and fix it if you wish to!




### STATUS: INABIAF - please **DO NOT** fix

Incorrect formulas will ungracefully crash the program.


<div id="2006_stewart">
## 2006/stewart
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/stewart/stewart.c](%%REPO_URL%%/2006/stewart/stewart.c)
### Information: [2006/stewart/index.html](2006/stewart/index.html)

This program will likely crash or do something funny if the file cannot be
opened. The number of args is however checked.


<div id="2006_sykes1">
## 2006/sykes1
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/sykes1/sykes1.c](%%REPO_URL%%/2006/sykes1/sykes1.c)
### Information: [2006/sykes1/index.html](2006/sykes1/index.html)

The author stated:

```
    If you pick a number higher than 19186, the program will return a
    solution but it will be a rotation of one of the first 19186.  This is
    because the cross shaped piece fits 48 ways in the 4x4 cube, but only
    2 of those ways are unique - you can rotate one of those to make any
    of the other 46.  The algorithm used always places the cross piece
    first, so the first two placings of that piece result in the 19186
    unique solutions.

    If you pick a number higher than 460464 (24x19186) the program will
    return without outputting a solution.  If you can wait that long.
```


<div id="2006_toledo2">
## 2006/toledo2
</div>


### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2006/toledo2/toledo2.c](%%REPO_URL%%/2006/toledo2/toledo2.c)
### Information: [2006/toledo2/index.html](2006/toledo2/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed this program to
not crash in macOS (it appeared to work fine in fedora linux on an `x86_64`
architecture but he does not know if it crashed in macOS Ventura due to the fact
it is an `arm64` CPU - the Apple silicon chip). This fix, BTW, is a mix of a fix
by [Yusuke Endoh](authors.html#Yusuke_Endoh) and Cody's. Nevertheless there are
two features that are not bugs. Later the author made some slight changes to
make it not crash in x86_64 macOS.

By design this program is supposed to crash on termination. This actually no
longer seems to happen but we don't need this to be added even if it might
be called a bug :-)

You must type in caps (except in strings) and this program is indeed
case-sensitive.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2007">
# 2007
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2007.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2008">
# 2008
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2008.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2009">
# 2009
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2009.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2010">
# 2010
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2010.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2011">
# 2011
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2011_borsanyi">
## 2011/borsanyi
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2011/borsanyi/borsanyi.c](%%REPO_URL%%/2011/borsanyi/borsanyi.c)
### Information: [2011/borsanyi/index.html](2011/borsanyi/index.html)

For a great amount of data points the program will crash, depending on your
available stack space.

Giving too few (distinct) points can also cause a crash or division by zero.

The program expects plain numbers separated by whitespace.

This program assumes ASCII.

If you give the program any arg it might flood the screen.

It requires both syscalls `fork(2)` and `wait(2)`.

Giving any arg to the program is likely to flood your screen.

Rounding errors might cause an omission in the highest bin. There might be empty
bins at the edges.


<div id="2011_dlowe">
## 2011/dlowe
</div>

### STATUS: missing or dead link or links - please provide it or them
### Source code: [2011/dlowe/dlowe.c](%%REPO_URL%%/2011/dlowe/dlowe.c)
### Information: [2011/dlowe/index.html](2011/dlowe/index.html)

The author's website, http://www.pootpoot.net, no longer exists as it once did,
instead being something else entirely. The Internet Wayback Machine, although it
archived it, did not load scripts. Do you know if the domain was moved? Do you
have an archive or mirror? Please provide us it! Thank you.


### STATUS: INABIAF - please **DO NOT** fix

The author states the following:

* Bad input (e.g. nonexistent files, non-numeric number of iterations, etc.)
tends to result in empty output.

* Given exactly one corpus, the program will crash or produce garbage.

* Leaks memory and file descriptors while processing files.

* Will crash and die horribly if it runs out of memory.



<div id="2011_fredriksson">
## 2011/fredriksson
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2011/fredriksson/fredriksson.c](%%REPO_URL%%/2011/fredriksson/fredriksson.c)
### Information: [2011/fredriksson/index.html](2011/fredriksson/index.html)

The author stated that there are a number of features and limitations. As the
list is rather long see [other
features](2011/fredriksson/index.html#other-features) and [limitations and
remarks](2011/fredriksson/index.html#limitations-and-remarks) instead.


<div id="2011_konno">
## 2011/konno
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2011/konno/konno.c](%%REPO_URL%%/2011/konno/konno.c)
### Information: [2011/konno/index.html](2011/konno/index.html)

This program will very likely crash or do something funny without an arg.



<div id="2011_richards">
## 2011/richards
</div>

### STATUS: doesn't work with some platforms - please help us fix it
### Source code: [2011/richards/richards.c](%%REPO_URL%%/2011/richards/richards.c)
### Information: [2011/richards/index.html](2011/richards/index.html)

This does not appear to work with macOS, resulting in a segfault (and sometimes
a bus error).

We're not sure if this is to do with the Apple silicon chip or not but it seems
like it _might_ (see Apple resources below) be but it could also be a wider
problem with macOS. It appears that Apple does not allow certain combinations of
memory protections with the arm64 processor.

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) tried some of the
workarounds but at this time he could not get it to work. He offers some earlier
debugging sessions below as well as a resource from the author as well as some
resources on Apple's website should anyone wish to take a crack at it. He might
address it later but a starting point might be in
[richards.alt.c](%%REPO_URL%%/2011/richards/richards.alt.c).


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

``` <!---c-->
    } else
                p++;
        W(c)} /* LINE 101 */
    }
```

Okay but what about argument 2? Well `W` is defined as:

``` <!---c-->
    #define W(c) e=memmove(e,x[(u)c], y[(u)c])+y[(u)c];
```

so it would appear that

``` <!---c-->
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

``` <!---c-->
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


### Testing fixes

It might be helpful to use the [try.alt.sh](%%REPO_URL%%/2011/richards/try.alt.sh) script to
test that it does not crash and functions properly.


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


<div id="2011_vik">
## 2011/vik
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2011/vik/vik.c](%%REPO_URL%%/2011/vik/vik.c)
### Information: [2011/vik/index.html](2011/vik/index.html)

The author stated that the program will crash if no argument is passed to the
program though we note that your computer might also [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_&#x28;computing&#x29;) :-)


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2012">
# 2012
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2012_blakely">
## 2012/blakely
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/blakely/blakely.c](%%REPO_URL%%/2012/blakely/blakely.c)
### Information: [2012/blakely/index.html](2012/blakely/index.html)

The author stated:

```
    If there is a division by zero, square-root of a negative number, or similar
    operation, then the results are undefined.
```


<div id="2012_deckmyn">
## 2012/deckmyn
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/deckmyn/deckmyn.c](%%REPO_URL%%/2012/deckmyn/deckmyn.c)
### Information: [2012/deckmyn/index.html](2012/deckmyn/index.html)

The author stated:

```
    The memory locations of `argv` are used for various purposes. Therefore, the
    program name (default `deckmyn`) must be *at least 4 characters long*, including
    possibly the path. This, along with the ending `'\0'`, gives a minimum 5 bytes of
    useful memory space. Otherwise, the program may attempt to write outside the
    string.

    The code is quite sensitive. Errors in the input can lead to strange results.
    The code does not read beyond the end of the music input, but that is about the
    only error checking available. Any input that is not according to the rules in
    the deckmyn.html, may cause errors.

    The program has no special hardware limitations or requirements, other than 8bit
    `char` (`signed` or `unsigned`) and two's complement negatives.

    The limitations of using `char` as counters for e.g. the number of music staves
    are minor. 127 staves to a page is rather a lot.

    The file layout must be exactly the same as deckmyn.c though, only the locations
    of space (`" "`) may differ.

    Every element in the music is given by a string of *exactly* 3 characters. Any
    violation of this will result in the rest of the music being interpreted in some
    randomly wrong way. Notice that in a file, the newline is also a character!
    Therefore, when preparing music in a file, care should be taken that the last
    musical element of a line is only 2 characters!
```



The manual referred to is [here](2012/deckmyn/deckmyn.html).


<div id="2012_dlowe">
## 2012/dlowe
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/dlowe/dlowe.c](%%REPO_URL%%/2012/dlowe/dlowe.c)
### Information: [2012/dlowe/index.html](2012/dlowe/index.html)

The author stated:

* Flicker, especially at high speeds, and in spite of "double-buffering" (X11
  doesn't make it possible to lock drawing to the display refresh rate.)
* Cannot be run outside of the directory containing the data files (`splash.d`,
  `dead.d` and `sprites.d`).
* Cannot build or run without X11 (or an X11 compatibility layer).


<div id="2012_tromp">
## 2012/tromp
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/tromp/tromp.c](%%REPO_URL%%/2012/tromp/tromp.c)
### Information: [2012/tromp/index.html](2012/tromp/index.html)

The author stated:

```
    If the input doesn't start with a valid program, that is,
    if the interpreter reaches end-of-file during program parsing,
    it will crash in some way. E.g. the following might dump core:

        echo -n "U" | ./tromp

    Furthermore, the interpreter requires the initial encoded lambda term to be closed,
    that is, variable n can only appear within at least 'n' enclosing lambdas.
    For instance, here the term '\ 5' is not closed, causing the interpreter to crash when
    looking into a null-pointer environment:

        echo ">Hello, world" | ./tromp

    will likely dump core.
```


<div id="2012_vik">
## 2012/vik
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2012/vik/vik.c](%%REPO_URL%%/2012/vik/vik.c)
### Information: [2012/vik/index.html](2012/vik/index.html)

The author stated that the program will crash if no argument is passed to the
program or if invalid arguments (e.g. file does not exist) or images of
mismatching sizes or unsupported pixel formats though we note that your computer
might also [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_&#x28;computing&#x29;) :-)


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2013">
# 2013
</div>
<hr style="width:10%;text-align:left;margin-left:0">

<div id="2013_cable2">
## 2013/cable2
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/cable2/cable2.c](%%REPO_URL%%/2013/cable2/cable2.c)
### Information: [2013/cable2/index.html](2013/cable2/index.html)

The author stated:

- The width of input images must be a multiple of 4.
- Input images can be 8-bit greyscale, 24-bit color or 32-bit color only. 8-bit
color and 16-bit color are not supported. If you use the "color" command-line
feature, do not use a greyscale input file!
- Normal Windows BMP files are stored "upside-down", i.e. the bottom line in the
image is written first. Some (old) graphics programs actually write BMP files
"top-to-bottom" and the program does not support such files.
- Using anti-aliased brush strokes to draw your letters is fine; however,
antialiasing interferes with color detection in "color" mode.
- Only runs on little endian machines (since the BMP format is little endian,
and endianness conversion would make the source too large for IOCCC rule 2).


<div id="2013_dlowe">
## 2013/dlowe
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/dlowe/dlowe.c](%%REPO_URL%%/2013/dlowe/dlowe.c)
### Information: [2013/dlowe/index.html](2013/dlowe/index.html)

This program will possibly crash or draw something strange with 0 args. Then
again it might not. :-) This is easy to fix but would add bytes and since the
author noted it is a feature and not a bug. You of course can try and fix it
yourself but please do NOT open a pull request for this: just do it as an
exercise to see if you understand the code.

You can try and answer the questions, too: when will it crash? When will it draw
something funny (or will it? :-) ) and when will it just do nothing?

The author also stated:

* Produces bogus graphs when given > about 5000 arguments.
* Only works if your terminal is UTF-8 and your font supports the 8 glyphs
  used.


<div id="2013_endoh1">
## 2013/endoh1
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/endoh1/endoh1.c](%%REPO_URL%%/2013/endoh1/endoh1.c)
### Information: [2013/endoh1/index.html](2013/endoh1/index.html)

From the author:

--

This program supports only "Combinator-calculus style notation" of Lazy K.
"Unlambda style" and "Iota and Jot" style are not supported.

Also, it requires a space between identifiers.  In short, use `(S K)` instead of
`(SK)`, "\`sk", **i*i*i*ii*i*i*ii`, or `11111100011100`.

Huge memory may be required to compile the program (about 300 MB on my machine).

In addition, there are some limitations (and workarounds) mentioned in the
[obfuscation section](2013/endoh1/index.html#obfuscation).

--


<div id="2013_endoh3">
## 2013/endoh3
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/endoh3/endoh3.c](%%REPO_URL%%/2013/endoh3/endoh3.c)
### Information: [2013/endoh3/index.html](2013/endoh3/index.html)

From the author:

--

You can *NOT* write a note length immediately followed by a note `E`,
such as `C2E2`.

Can you figure out why?

A workaround is inserting a whitespace: `C2 E2`.

--


<div id="2013_endoh4">
## 2013/endoh4
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/endoh4/endoh4.c](%%REPO_URL%%/2013/endoh4/endoh4.c)
### Information: [2013/endoh4/index.html](2013/endoh4/index.html)

Invalid input files will very likely crash the program.



<div id="2013_hou">
## 2013/hou
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/hou/hou.c](%%REPO_URL%%/2013/hou/hou.c)
### Information: [2013/hou/index.html](2013/hou/index.html)

This program will not terminate on its own; you must kill `hou` (but not Qiming
Hou :-) ) yourself. This should not be fixed.


<div id="2013_mills">
## 2013/mills
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2013/mills/mills.c](%%REPO_URL%%/2013/mills/mills.c)
### Information: [2013/mills/index.html](2013/mills/index.html)

The author reminds us that if you kill the program you will have to wait a short
bit of time before you can start it again if you want it to be able to bind to
the socket (which obviously you do). The source is out the scope of this
document but the author does mention the well known (at least to those of us who
have experience with socket programming :-) ) fix. However as the author pointed
it out as a known limitation it is not a bug but a feature.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2014">
# 2014
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2014_maffiodo1">
## 2014/maffiodo1
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2014/maffiodo1/prog.c](%%REPO_URL%%/2014/maffiodo1/prog.c)
### Information: [2014/maffiodo1/index.html](2014/maffiodo1/index.html)

The author noted that in macOS the colours might be wrong. They gave a solution.
However Cody didn't see any problem with it and he beat the series many times.
Of course the game here is small and he's practically blind and it's been a
while since he last played so it might be wrong. Nevertheless the author does
give a way to reconfigure the colours.

The author noted that the character cannot go through walls and the impression
is that this is how it was believed but Cody ironically pointed out that there
are known glitches where in some places you actually could go through walls.
This might even have applied to the arcade version, Mario Bros, though that can
no longer be confirmed by Cody. The point here is that in this game you cannot
go through walls but it's not a bug.

On the other hand, the author also stated:

--

When the `Super character` becomes bigger (`ZOOM` flag), the character can
collide with blocks and get stuck inside them. This is a KNOWN BUG. When your
player become bigger, stay away from blocks!


--

but since it's documented it's considered a feature, not a bug to fix.


<div id="2014_maffiodo2">
## 2014/maffiodo2
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2014/maffiodo2/prog.c](%%REPO_URL%%/2014/maffiodo2/prog.c)
### Information: [2014/maffiodo2/index.html](2014/maffiodo2/index.html)

This program will very likely crash if no arg is given.


<div id="2014_vik">
## 2014/vik
</div>

### STATUS: known bug - please help us fix
### Source code: [2014/vik/prog.c](%%REPO_URL%%/2014/vik/prog.c)
### Information: [2014/vik/index.html](2014/vik/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) discovered a bug to do
with translating sound to text that shows itself in some cases (it works in
others) when working on his winning [2020 Enigma machine](%%REPO_URL%%/2020/ferguson2/prog.c)
('Most enigmatic') entry. See his [index.html](2020/ferguson2/index.html) for
details (search for `vik` in the file). This one might be more of a limitation
but this is not known.

He provides a tip in testing the problem: it might help to use his Enigma
machine to find problems as it will allow you to verify what is correct and what
is not. Again see his index.html for details. However it is also possible to not
rely on the entry as the below shows. One should be able to do:


``` <!---sh-->
    echo 'No. I want chocolate!' | ./prog > chocolate.raw

./prog e < chocolate.raw
```

and get:

```
    No. I want some chocolate!
```

but instead we get:

```
    IT FHOCOLITE!
```

which is very wrong. If however one does:

```
    echo IOCCC | ./prog > ioccc.raw

    ./prog e < ioccc.raw
```

they will properly get:

```
    IOCCC
```


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2015">
# 2015
</div>
<hr style="width:10%;text-align:left;margin-left:0">



<div id="2015_hou">
## 2015/hou
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2015/hou/prog.c](%%REPO_URL%%/2015/hou/prog.c)
### Information: [2015/hou/index.html](2015/hou/index.html)

The author stated:

--

Hard requirements:

* The platform must implement the `double` type as IEEE754-compliant 64-bit
floating point numbers.  The 80-bit intermediate format used by x87 is
considered as an violation of this. The code should print an error message on
such platforms.

* The program must start with the CPU / FPU in round-to-nearest mode.

Soft requirements:

* The compiler must respect `volatile`. The code is formatted to warn about
that, though.

* The printed result is only correct on little-endian machines. The program
takes care to warn about this issue after printing an incorrect big-endian
result. Error messages become garbled, though.

--

<div id="2015_howe">
## 2015/howe
</div>

### STATUS: known bug - please help us fix

The test scripts do not seem to work properly with bash but this would be ideal
as not all systems have a compatible shell (they assume a POSIX compliant
shell). One, with bash, might see:

``` <!---sh-->
    ./prog-test.sh
    <<< A='1' B='1'
    prog: : No such file or directory
    >>> got=0 expect=0 -OK-
    <<< A='1' B='A'
    prog: : No such file or directory
    >>> got=0 expect=2 FAIL
```

It would appear that the variable passed to the command in the function,
`distance`, is empty.

The same problem exists in the
[prog.alt-test.sh](%%REPO_URL%%/2015/howe/prog.alt-test.sh), particularly
because it is the same thing as the other, just updated to use `prog.alt`.


<div id="2015_mills2">
## 2015/mills2
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2015/mills2/prog.c](%%REPO_URL%%/2015/mills2/prog.c)
### Information: [2015/mills2/index.html](2015/mills2/index.html)

The program doesn't look at the header of files so if it's passed something hat
is not compressed data it's likely to crash.

The program depends on little endian systems.


<div id="2015_schweikhardt">
## 2015/schweikhardt
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2015/schweikhardt/prog.c](%%REPO_URL%%/2015/schweikhardt/prog.c)
### Information: [2015/schweikhardt/index.html](2015/schweikhardt/index.html)

The program assumes that `EOF` is `-1`. This can be fixed but at this time it is
uncertain if it should be.

The author also stated:

--

While the program works best when bytes/characters are octets and the
number of bits in a type is `sizeof(typ) << 3`, it will work correctly
on 24-bit or 36-bit systems with 9 bits/byte, or systems where
`sizeof(typ)` is 1 even for `int` and so on. On such systems, it will only
use `8 * sizeof(typ)` bits per place. It does not work when `CHAR_BIT <= 7`.

--


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2016">
# 2016
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2016.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2017">
# 2017
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2017.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2018">
# 2018
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2018_algmyr">
## 2018/algmyr
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2018/algmyr/prog.c](%%REPO_URL%%/2018/algmyr/prog.c)
### Information: [2018/algmyr/index.html](2018/algmyr/index.html)

The author wrote:

* There is no error checking done when opening files, so expect segfaults if you
provide the wrong path to a file.
* This program is bound to misbehave if `int` is less than 32 bits.
* Flags will only be interpreted correctly if they are the first argument. Reading
a file named `-d` or `-h` is fully possible if it is not the first file
provided, even though I am not sure why you would want to do that.
* Providing invalid/unexpected arguments to the decode flag will result in odd
behavior. Some erroneous arguments cause segfaults (negative number of channels,
channel id outside valid range). One argument in particular causes an infinite
loop printing whitespace.



<div id="2018_hou">
## 2018/hou
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2018/hou/prog.c](%%REPO_URL%%/2018/hou/prog.c)
### Information: [2018/hou/index.html](2018/hou/index.html)

When you run it on a JSON file you will see something like:

``` <!---sh-->
    $ ./prog < ioccc.json > ioccc.html
    Assertion failed: (rulez), function C, file prog.c, line 124.
    Abort trap: 6
```

(from say running `./try.sh) but this is expected and the file `ioccc.html` will
be generated properly.

Some JSON files might cause the program to continue to run and seemingly
infinitely increase the size of the output file. This can happen if you try
fixing the syntax error in the generated `ioccc.json` file.


<div id="2018_mills">
## 2018/mills
</div>

### STATUS: known bug - please help us fix
### Source code: [2018/mills/prog.c](%%REPO_URL%%/2018/mills/prog.c)
### Information: [2018/mills/index.html](2018/mills/index.html)

After exiting the program (with ctrl-e) if you try running it again you will
likely see:

```
    >bootT5pw
             ]h_        8D3[]
```

where `[]` is the cursor. When this happens if you hit enter (this is necessary
or else it'll happen again) and then exit again (ctrl-e) and run `prog` again
it'll be okay.


### STATUS: INABIAF - please **DO NOT** fix

The author stated that if you make a typo it can happen that the boot loader can
crash and halt. If this is the case type ctrl-e to quit the emulator and try
again.

The author also stated that it is possible to corrupt the virtual disk. If you
do this you should type `make clobber all` and try again.

Cody caused a funny problem where it showed `ERROR` after each command. The
solution was to hit ctrl-e and start again. He does not know if this is what was
referred to by the author but there was likely no typo involved.

Cody notes that if you are using the saved mode you must type `sync` prior to
exiting the program or else the next time you run it the file will not exist (or
in the case of compiled code it won't be executable).


<div id="2018_vokes">
## 2018/vokes
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2018/vokes/prog.c](%%REPO_URL%%/2018/vokes/prog.c)
### Information: [2018/vokes/index.html](2018/vokes/index.html)

The author wrote the following:

- Despite appearances, it does not handle numbers in hex, or provide
  a `curses(3)`-based interface.

- The expected input format is zero or more lines of space-separated
  integers. If other characters appear in the input, it will either
  reject the input entirely and exit with a non-zero status, or skip
  number(s) adjacent to the non-digit characters, depending on where the
  characters appear. Tabs and multiple consecutive spaces are handled
  correctly, however.

- Individual lines of input longer than `0x3543 - 1` bytes will be
  split and processed as if they were multiple lines of input, which can
  produce incorrect results. This magic number's significance is
  described earlier.

- The algorithm expects its input to represent a fully connected graph.
  While the output is otherwise topologically sorted, if there are nodes
  completely unconnected to the rest of the graph (with or without
  self-cycles), they will be output as soon as they are processed --
  this means that, when there are disconnected nodes, reordering the
  input lines can produce different output. Addressing this by adding
  another pass is would put the program over the size limit.

- While the node IDs don't need to be consecutive or start at 0, the
  implementation doesn't have special handling for sparse graphs. If you
  give it a graph with nodes numbered 0 and 2147483647, it will attempt
  to allocate sufficient memory (potentially around 32 GB) for the
  entire range of graph nodes, even if those are the only ones. If
  memory allocation returns NULL, it will gracefully exit, otherwise it
  will succeed, eventually, perhaps after a great deal of swapping.

- Node IDs >= 2147483648 will cause the program to print an error
  message and exit with a non-zero status. This shrinks the code that
  detects overflowing the array size by a bit.

- A very large group of nodes in a cycle can cause a stack overflow.
  This typically takes over 100,000 nodes, and depends on the order the
  nodes are visited. Addressing this would put the program over the size
  limit.

- The implementation depends on the characters `'0'`, `'1'`, ... `'9'` having
  the values `48` through `57`, rather than using `isdigit(3)`. As noted above,
  this program has nothing to do with a hand.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2019">
# 2019
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2019_adamovsky">
## 2019/adamovsky
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/adamovsky/prog.c](%%REPO_URL%%/2019/adamovsky/prog.c)
### Information: [2019/adamovsky/index.html](2019/adamovsky/index.html)

Certain input can crash this program. The file
[crash.unl](%%REPO_URL%%/2019/adamovsky/crash.unl) is an example file.


<div id="2019_burton">
## 2019/burton
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/burton/prog.c](%%REPO_URL%%/2019/burton/prog.c)
### Information: [2019/burton/index.html](2019/burton/index.html)

The author pointed out that some implementations of `wc(1)` show different
values but his implementation matches that of macOS and FreeBSD.


<div id="2019_ciura">
## 2019/ciura
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/ciura/prog.c](%%REPO_URL%%/2019/ciura/prog.c)
### Information: [2019/ciura/index.html](2019/ciura/index.html)

[Cody Boone Ferguson](authors.html#Cody_Boone_Ferguson) fixed the scripts so
that they can work but it might end up that the scripts don't show any output
anyway as they use the full alphabet. To test that it works one can have a
script like:

``` <!---sh-->
    LC_ALL=C  aäbcdefghijklmnoöpqrsßtuüvwxyz | LC_ALL=C grep .. | LC_ALL=de_DE.UTF-8 ./prog aäbcdefghijklmnoöpqrsßtuüvwxyz
```

If you run this you should see:

```
    aäbcdefghijklmnoöpqrsßtuüvwxyz
```

which shows it works. However as the de.sh script refers to all letters it can't
find a perfect pangram. BTW, as far as the question of whether the umlaut
letters or the Eszett are considered letters in the German alphabet, Cody noted
in the de.sh/de.alt.sh scripts:

```
    # Are the umlauts ä, ö, ü and Eszett (ß) letters in the German alphabet? There
    # is more than one opinion on the subject but a lot of words do have an umlaut
    # (or Umlaut in German). In some (probably all) systems this script outputs
    # nothing probably because it's very hard to form a perfect pangram in German,
    # if it's not impossible. Nevertheless, we do include the other characters
    # whether or not they are in your view considered part of the alphabet for the
    # reason that so many words have them.
```

<div id="2019_dogon">
## 2019/dogon
</div>

### STATUS: uses gets() - change to fgets() if possible
### Source code: [2019/dogon/prog.c](%%REPO_URL%%/2019/dogon/prog.c)
### Information: [2019/dogon/index.html](2019/dogon/index.html)

The author does not it uses `gets()` and one will get warnings but it would be
ideal if this was not the case.


<div id="2019_duble">
## 2019/duble
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/duble/prog.c](%%REPO_URL%%/2019/duble/prog.c)
### Information: [2019/duble/index.html](2019/duble/index.html)

There are two things to be aware of with this entry.

If the file being used (to draw) is deleted it might lock any session still in
use. These will have to be killed from another shell session or by closing the
terminal tab. This will also happen if the file cannot be opened in the
beginning.

This program will also very likely leave sockets lying about in the current
working directory. For instance [Cody Boone
Ferguson](authors.html#Cody_Boone_Ferguson) showed us this:

``` <!---sh-->
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

He provides the following tips on this situation. A simpler way to find sockets
in the directory:

``` <!---sh-->
    file .*|grep socket|cut -f1 -d:
```

To delete them you can do:

``` <!---sh-->
    find . -exec file '{}' \;|grep socket|cut -f 1 -d: | xargs rm -f
```

though one might want to check that the program is not currently running. :-)


<div id="2019_endoh">
## 2019/endoh
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/endoh/prog.c](%%REPO_URL%%/2019/endoh/prog.c)
### Information: [2019/endoh/index.html](2019/endoh/index.html)

As a backtrace quine this entry is **SUPPOSED to segfault** so this should not be
touched either.


<div id="2019_karns">
## 2019/karns
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/karns/prog.c](%%REPO_URL%%/2019/karns/prog.c)
### Information: [2019/karns/index.html](2019/karns/index.html)

The author stated the following:

```
    - The program must be ran in a terminal that supports ANSI
      escape codes for moving the cursor and changing colors.

    - Segfaults happen sometimes.

    - I don't know what memory management there is, if any.

    - The program will not compile by an ANSI C compiler: it uses
      for loops, and it uses C++ style comments. It should compile
      cleanly using a C99 standard.

    - Breadth first search is slow (and very slow on certain maps),
      but my A star version of this program is too big.

    - Lots of extra whitespace may be needed if you want to feed in
      an arbitrary file.

    - It fails to compile on GCC sometimes (according to a friend
      of mine, I've not encountered this myself).

    - The program could be obfuscated much further.

    - The program contains some unused code and data.
```


<div id="2019_lynn">
## 2019/lynn
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/lynn/prog.c](%%REPO_URL%%/2019/lynn/prog.c)
### Information: [2019/lynn/index.html](2019/lynn/index.html)

The author wrote that there are a number of differences from what one might
expect. Rather than duplicate the information we refer you to the author's
remarks in the sections [Syntax](2019/lynn/index.html#syntax) and
[Caveats](2019/lynn/index.html#caveats).


<div id="2019_mills">
## 2019/mills
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/mills/prog.c](%%REPO_URL%%/2019/mills/prog.c)
### Information: [2019/mills/index.html](2019/mills/index.html)

The author wrote that if you decide to change networks or use a different input
file you should delete all the checkpoint files because the format depends on
both the network and the input -- using the wrong checkpoint is likely to cause
a crash.

The author also wrote:

```
    IMPORTANT NOTE: Since OMLET uses the system stack for network storage,
    larger networks may cause OMLET to crash (typically with a message like
    Segmentation fault) unless the system stack size is first increased.
    The exact command for doing so depends on your shell and your system's
    hard limits.  On sh/ksh/bash shells, you can view the hard limit
    with ulimit -Hs and set it with ulimit -s 65532 (replacing 65532
    with the actual hard limit).  On csh/tcsh shells, you can view
    the hard limit with limit -h stacksize and set it with
    limit stacksize 65532 (replacing 65532 with the actual hard limit).
```

<div id="2019_poikola">
## 2019/poikola
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/poikola/prog.c](%%REPO_URL%%/2019/poikola/prog.c)
### Information: [2019/poikola/index.html](2019/poikola/index.html)

This program will not validate input so it might fail or get stuck if invoked
erroneously.

Also, the maximum file size is 1GB.

<div id="2019_yang">
## 2019/yang
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2019/yang/prog.c](%%REPO_URL%%/2019/yang/prog.c)
### Information: [2019/yang/index.html](2019/yang/index.html)

The author noted that if the program runs out of memory it is likely to crash.

The author also stated that 'if input contains CR-LF end of line sequences,
those `CR`s are silently dropped.  In fact, most control codes are silently
ignored except line feeds (preserved) and tabs (expanded to 8 spaces).'




<hr style="width:10%;text-align:left;margin-left:0">
<div id="2020">
# 2020
</div>
<hr style="width:10%;text-align:left;margin-left:0">


<div id="2020_burton">
## 2020/burton
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/burton/prog.c](%%REPO_URL%%/2020/burton/prog.c)
### Information: [2020/burton/index.html](2020/burton/index.html)

This entry is known to crash if no arg is specified. Although easy to fix it is
documented and should not be fixed (of course you may fix it to see if you can
but it shouldn't be made into a pull request).

It will also show funny output with more than one arg. This should not be fixed
either. But can you figure out why this happens?


<div id="2020_carlini">
## 2020/carlini
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/carlini/prog.c](%%REPO_URL%%/2020/carlini/prog.c)
### Information: [2020/carlini/index.html](2020/carlini/index.html)

The author stated that bad things happen if the entered move is outside of the
range [1..9]. We observed a crash but we also observed a tie and other things
besides (say with the input `-1`, `-`, `-10` and others).

If a player makes a move over their opponent's place they will automatically
lose.

If a player tries to play a move they already played they will forfeit their
move.

If you have audible bells enabled the program will beep at every turn.


<div id="2020_ferguson1">
## 2020/ferguson1
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/ferguson1/prog.c](%%REPO_URL%%/2020/ferguson1/prog.c)
### Information: [2020/ferguson1/index.html](2020/ferguson1/index.html)

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See the
[bugs.html](2020/ferguson1/bugs.html) and
[troubleshooting.html](2020/ferguson1/troubleshooting.html) files for details.


<div id="2020_giles">
## 2020/giles
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/giles/prog.c](%%REPO_URL%%/2020/giles/prog.c)
### Information: [2020/giles/index.html](2020/giles/index.html)

The author noted that the program only supports WAV files that have
exactly 16 bits per sample, but it allows any sample rate and any number of
audio channels.


<div id="2020_otterness">
## 2020/otterness
</div>

### STATUS: INABIAF - please **DO NOT** fix
### Source code: [2020/otterness/prog.c](%%REPO_URL%%/2020/otterness/prog.c)
### Information: [2020/otterness/index.html](2020/otterness/index.html)

The author listed the following limitations:

1. The program does not support MIDI files over 4 MB (specifically, it will
not take input files larger than `2^22 - 1` bytes).  This is unlikely to be a
big limitation in practice, since even lengthy MIDIs are rarely over a
couple hundred KB.

2. Not all MIDIs set (or *correctly* set) their timing information, which will
lead to the tempo of the drum beat not matching the track.  This will be
especially true for "live performance" .mid files.

3. There may be some types of MIDI messages that the program is unable to
correctly parse, but I have rarely seen this in practice.  The largest
cause of program failures, in my experience, has been Limitation 2.

See also the [Program error
codes](2020/otterness/index.html#program-error-codes) written by the author
which lists some other conditions which should be considered features, not bugs.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2021">
# 2021
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2021.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2022">
# 2022
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2022.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2023">
# 2023
</div>
<hr style="width:10%;text-align:left;margin-left:0">

There was no IOCCC in 2023.


<hr style="width:10%;text-align:left;margin-left:0">
<div id="2024">
# 2024
</div>
<hr style="width:10%;text-align:left;margin-left:0">

We hope to run the IOCCCMOCK this year, 2024, and hopefully the next IOCCC, but
for now we wish everyone a happy new year!


# Final words

We hope this document was of use to you in determining which entries are known
to have a problem, what entries are known to have features that are not bugs and
so on. We also thank you for going through this  document and, if you propose any
fixes] via a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls) or otherwise, we
thank you as well for the help! We will happily add you to the
[thanks](thanks-for-help.html) file as well.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
