# BUGS and (MIS)FEATURES

There are a number of known problems with IOCCC winners: many of
which have to do with differences between today's compiler environments
and those of today. In some cases the original code has a bug, some
of which were recently discovered and many of which were fixed. In some cases
attempt to port older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC winners.

Can you fix/improve entries not under the INABIAF (it's not a bug it's a
feature)? You are **VERY WELCOME** to try.

Please submit your fixes fix in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) with one pull
request per fix, please!

We will be **happy to credit anyone who submits successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls)** in the entry's
_README.md_ file. If you're a previous winner we will add a link to your winning
entries in the file (if you're not a previous winner we can add a link to your
GitHub page or personal website if you have one, should you wish).

If you do fix an entry please feel free to delete the entry from this file!
Otherwise if you wish to not worry about it we can do that to make sure the
format is consistent and clean.

Thank you!

### ON **ALL** FIXES / IMPROVEMENTS / CHANGES

Make **ABSOLUTE CERTAIN** that you test the entry _BEFORE_ **AND** _AFTER_ your
changes! This includes output and the same input functionality! Sometimes it
might seem to be fine but is actually not! We will note some where this is known
to happen (if it's not yet fixed).

Make **ABSOLUTE CERTAIN** that you read the README.md file _BEFORE_ your changes
as it's important to see that the code is doing what it is supposed to. In the
case that it's not obvious (some README.md files do not even have commands to
try or even explain how to use it!) then you should either skip the entry OR ask
someone who will know e.g. us.

Make **ABSOLUTE CERTAIN** that you read the next section, the list of statuses
and the related information, BEFORE you submit a pull request!


# LIST OF STATUSES - PLEASE READ BEFORE FIXING (you may skip if you're only interested in knowing about entries with known issues)

Entries below have one of the following _**STATUS**_ values. Please see the text
below for more information. If an entry has more than one status it means that
either they all apply or they compliment each other. For instance
[2004/gavin](2004/gavin/gavin.c) crashes but it also doesn't even compile with
some platforms/architectures.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has been working on
resolving these issues and has fixed many but you're welcome to have a go at it
too (though he'll be very sad if he doesn't have a chance to at first fix it :-(
so you might want to hold off for now :-) .. or not :-) ). He hopes to have most
of the remaining entries resolved in the near future but nevertheless if you're
okay making people very sad you may have a go at the entries :-) He'll remove
this part later on.

## Compiler warnings are very rarely a problem

In general warnings should NOT be addressed. The only time they should be
CONSIDERED is when the entry does not work. However note that sometimes trying
to fix the warnings will actually introduce bugs! Below in some entries we do
list some warnings that definitely should be ignored (including some introduced
by fixes) but we do not list them all: trying to keep track of them all would be
impractical especially as different compilers give different warnings. Another
type of warning that would be hard to keep track of is different data sizes on
different platforms. These tend to be required at the risk that sometimes the
entry will not work for certain platforms, some of which might or might not be
fixable. But even if they are fixable (which will likely be hard to do) it's
almost certain that such code would be just as non-portable (importable ? :-) ).

## Request for one-liners:

For one-liners please keep the file one line if at all possible! If it needs an
include you can update the Makefile `CINCLUDE` variable. For instance if it
needs `stdio.h` you could do `-include stdio.h`. Please leave a space after the
`=` in the Makefile and thank you!


### On layout of program source

If you make changes PLEASE TRY and keep the source code layout as close to the
original as possible. This might not always be possible and if you have an
editor that does formatting it can cause problems. Sometimes formatters can even
break code! [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has
experienced this many times so he tends to disable all format options when
formatting code.



## STATUS: INABIAF - please **DO NOT** fix
### INABIAF: It's not a bug it's a feature :-)

Entries with this status should NOT be touched (unless they have another status
that suggests that issue can be changed): they are system specific by design
or are other things that are not actually bugs even if they appear to be but are
noteworthy nonetheless.

## STATUS: known bug - please help us fix

Entries with this status have one or more bugs that need to be fixed. Are you
able to fix it?

## STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

Entries with this status might or might not have a bug possibly depending on the
system.  In these entries we don't have the appropriate systems to test and fix
any problems.

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
specific type due this being allowed in earlier C. This shows itself in some
compilers like clang. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
looked at the source code of clang and reported that there is no way to override
this requirement so these entries will fail to compile with clang. That's why he
in some entries he fixed he did it by adding a function called `pain()`. :-)

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


## STATUS: requires a compiler supporting `-traditional-cpp` - alternate code requested

Entries with this status need a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not.

Please be advised that, as noted above, gcc under macOS is actually gcc even if it
looks like it's gcc (the programs are the same, they're not symlinks but both
are clang).

If you do wish to provide an alternate version of the program that does not need
compiler supporting you are welcome to summit such code via a
[GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we
will be happy to credit you in the entry's _README.md_ file.

## STATUS: uses gets() - change to fgets() if possible (in some cases getline() works)

Entries with this status use `gets()` which is unsafe because it has no limit on
the length of the string. [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) has fixed several of these and he's
working on others in between fixing other things. He provides some important
notes:

First: in some cases changing the entry to use `fgets()` will break the entry
and in some cases cause it to crash. Where this is known we will document it.
Some of these Cody is also working on.

Second: you MUST check the output before and after to make sure that it remains
the same. Sometimes the output might not be immediately obviously wrong but is.
We will document known examples.

Third: `gets()` does NOT STORE the `'\n'` but `fgets()` DOES! This is one of the
reasons some of the entries break when changed to `fgets()`. Cody has fixed some
of these but there are others he hasn't had time to address and/or even discover
yet.

Fourth: just because you don't see the string `gets` in the code does not mean
it's not used. It is after all the Obfuscated C Code Contest! :-) Sometimes it
will be in the Makefile and other times it will be obfuscated in other ways.
Compilers and linkers tend to warn about its use and this is a good way to find
entries that use it even if it's not visible in the code.

## STATUS: missing file(s) - please provide them

In these entries one file or multiple files are missing from the repo. In some
cases these files can be found on the [IOCCC website](https://www.ioccc.org) but
in other cases they are entirely absent. In this case you'll probably have to
contact the author (unless you are the author! :-) ).


# List of entries by year, sorted in alphabetical order

# 1984

## [1984/anonymous](1984/anonymous/anonymous.c) ([README.md](1984/anonymous/README.md))
## STATUS: doesn't work with some platforms - please help us fix


Although this works under linux it does not work under macOS: it prints nothing,
exiting 0.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) added some notes about
this in the [README.md](1984/anonymous/README.md) file. Can you fix this? We
welcome your help!


## [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md))
## STATUS: requires a compiler supporting `-traditional-cpp` - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need
compiler supporting `-traditional-cpp` you are welcome to submit such code via a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we will be happy to credit you in the entry's _README.md_ file.


# 1984


# 1985

## [1985/applin](1985/applin/applin.c) ([README.md](1985/applin/README.md)
## STATUS: doesn't work with some platforms - please help us fix

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided a fix for gcc but
[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) observed that this does
not work under macOS. It prints `H????????` with additional `?`s printed as it
continues to run.

We have not had a chance to try and fix this yet.


## [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md))
## STATUS: Requires a compiler supporting `-traditional-cpp` - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need
compiler supporting we welcome you to summit such code via a
[GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we
will be happy to credit you in the entry's _README.md_ file.


# 1986


## [1986/august](1986/august/august.c) ([README.md](1986/august/README.md))
## STATUS: INABIAF - please **DO NOT** fix


This entry is known to segfault after printing its output. It was documented by
the judges and shouldn't be fixed.

## [1986/hague](1986/hague/hague.c) ([README.md](1986/hague/README.md))
## STATUS: uses gets() - change to fgets() if possible

This entry uses `gets()` which is unsafe. In particular the buffer size is 81.
`gets()` does not store the `'\n'` but it does store the `'\0'`.

The latter fact

## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md))
## STATUS: INABIAF - please **DO NOT** fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems but he points out a warning that should NOT be fixed; he experimented
with trying to fix it but it did not work, either segfaulting or not displaying
the correct output. Thus:


```c
[holloway.c:15:11: warning: incompatible pointer types initializing 'char *' with an expression of type 'char **'; dereference with * [-Wincompatible-pointer-types]
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




## [1986/wall/wall.c](1986/wall/wall.c) ([README.md](1986/wall/README.md))
## STATUS: Requires a compiler supporting `-traditional-cpp` - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).


# 1987

## [1987/lievaart](1987/lievaart/lievaart.c) ([README.md](1987/lievaart/README.md))

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


## [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md))
## STATUS: Requires a compiler supporting `-traditional-cpp` - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).


# 1989

## [1989/robison](1989/robison/robison.c) ([README.md](1989/robison/README.md))
## STATUS: known bug - please help us fix

This might not be an issue that needs to be fixed but numbers with non-binary
digits will crash the program.


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


# 1991


# 1992

## [1992/lush](1992/lush/lush.c) ([README.md](1992/lush/README.md))
## STATUS: doesn't work with some compilers - please provide alternative code

We used a patch from [Yusuke Endoh](/winners.html#Yusuke_Endoh) to get this to
work but it only works with gcc. Unfortunately due to the way the entry works
and the fact that other compilers like clang have different warnings and errors
this simply does not work with them. Can you help us?


# 1993


# 1994

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

The original buffer size of this entry is 100 which is very easily overflowed
with `gets()` which it uses. [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) changed the buffer size to 10000
but he notes a problem in that this does not translate to the generated source
file (when feeding the source itself). With `fgets()` it generates compiler
errors. Without special care with changing the buffer size it would also
generate compiler errors. Cody explains the magic below which might be used to
change this entry to fgets() (and he'll be working on it in the coming days most
likely).

### The magic of [1994/schnitzi](1994/schnitzi/schnitzi.c) and how it flips text

Cody provided some tips in how the entry works so that it can hopefully be made
to use fgets() and also hopefully have the buffer size updated in the generated
code. He notes that this might be a real problem with formatting the code but
nevertheless he offers the below tips:

Take a look at the interesting comment as well as the `int r=0,x,y=0` at the top
of the file. If you look at each column go down that column you can see how it
spells out the code! For instance the first column looks like:


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


## STATUS: doesn't work with some platforms - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) pointed out a potential
bug in [1994/shapiro](1994/shapiro/shapiro.c) on systems where `EOF != -1` as
the code assumes that `EOF` will always be `-1`. As the standard says (see `7.21
Input/output<stdio.h>` subsection 1) it only has to be a negative int, not
necessarily `-1`. The problem is that the source file's last character is a
newline (10 in decimal) and so on systems where `EOF != -1` the `getc()`
functions would not terminate the loop (but see below). This would cause a
breakage in the entry.

However due to clever encoding of the code it is not a simple matter of applying
the following patch:

```diff
diff --git i/1994/shapiro/shapiro.c w/1994/shapiro/shapiro.c
index d2da120c7bc4e251b7624859e48f47f188d398e9..e054a1ceb067b82bf37c07e5ce75e82be7a03b85 100644
--- i/1994/shapiro/shapiro.c
+++ w/1994/shapiro/shapiro.c
@@ -9,11 +9,11 @@
             /*PPPPVPOQMQRPR*/=0;FILE/*TPSLUMWQT*/ *
            J/*MPRPKPLQ*/;     J=      fopen(__FILE__
           /*T*/,"r");for      (;(       L/*KPUOWOWMUQ
          LLOLMPULWLWL         WLW         LWLWLWLWLWLW
          LWLWLULVOXP          LLV          LLLOLMPULOL
-        MMNP*/=getc           (J)            )!= -1;L/*
+        MMNP*/=getc           (J)            )!=EOF;L/*
        OLWLRMMQUL             VOX             PLLVLLLMQO
        PMPYPXPNP              MQL              LVLLLWPSP
       XPOQNQOPMQ              LLV              LTj*/>='J'
      &&L/*LRPYP               OQL               QMQLLVLLL
      OLMQVOXPL                LVL                LLVOe*/<=

```

as doing so will cause `warning: illegal character encoding in string
literal` and the error `error: source file is not valid UTF-8`. Looking at the
file you'll see on line 4 of `shapiro_t2.c`:


```
char *a[]={"%c+------------+\n","%c+%3dPRÒ<82>3·Âå&Â"2W6öæF6'Â"Ò<96>æVGW6'Â¢ <82>öV'7'Â"R2Çå&Â"Â^E33sÃ^E33³UB¶cS³<83>T2Ç^E33<83>#Ò·£<90>æF^G"¶ÕÕ³^GÃ^BÃ^RsÃ^RCÃ^R^SÃ^BÓ·£Ð^V<96>æ<86>bÇ2<96><92>æF^Gb·3<86>^V&^G¢¢^B2¶£°7<86>^V&^GB¶E^CÓÅ¢RÆbÖc³£@<97>ÖVöE^Gr¶£`<94>ÄT^D¢<82>Æ¢<92>¶£p<87><96>ÆV^F<82>ÒÒb^Fbb^B^R^B<97>^FW<86>B<96>^Bbb^B^Rbö&·<86><92><92>²£<80>ÖcFö^FWæ<86>bÓbÆÃ^SÃ"^R&<92>²<93>ÖcFö^FWæ<86><82>bÓbÆÃ^S<93>²^RÃ""'<92>²£`ö&<87>²³<93>²<97>f<86>b<96>²gvVF7<87>BÆB^CÃ<92><96>²C¶5G'ÇVæ<86>B<96>Ò^RÓÕsÂ^Es²£<90>f<86>¢BÖÓs^Bs²b<96>²7^G'<97>æFg<86>¢2Æ"R2Çå&ÂB¶^R<93>²ó<86>2GGöVGÇbÃbÓbÆB¶^RÃ^B<93>Ò§<90>f<86>¢Bæs^Bs²b<96>ò<86><82>ÆRÃBÆ^BÃ^B<93>ÒWÆ6W¶G<97>ÖV<86>br<96>²SÖ^S67F<97>ÖV<86>Âö6^VÆF<97>ÖV<86>br<96><92>²£`ö&<87>b×^S³cÇc³c·²<92>ò<86><82>Æb^WÒ^Scbb^WÒcÓ^RÃb·r^BsÂ^RF÷<96><86>R¶"¶e×<95>Âb<97>2ÇVV^F<87>^R<93>²Ó××§ 
```

when it should be something entirely different. For what it should be try
running `make clobber all ; cat shapiro_t2.c` or else look at the second program
in the spoilers file [shapiro.md](1994/shapiro/shapiro.md]).

Cody is working will be working on this here and there but if you have a fix or
any suggestions you're welcome to provide it or them.

Cody points you to the README.md file for what should happen when the entry is
successfully compiled (including no compilation errors when running `make
clobber all`).

Another problem is that in the [shapiro.md](shapiro.md) file the first program
does not work.

### Tips on this entry:

Cody provides some tips on this entry:

First: the comments are the important part of this entry. Remove them and the
program breaks.

Second and perhaps part of the problem with changing the code to `EOF` instead
of `-1` is the `for` loop particularly to do with the bitwise operations,
perhaps also made worse by the seemingly gibberish comments.

Another important point is that the Makefile compiles the program as
`shapiro_t1` so that the source code that corresponds with it is actually
[shapiro.c](1994/shapiro/shapiro.c). But notice how running `shapiro_t1` results
in different functionality than `shapiro` itself? The source code that
`shapiro_t1` generates, `shapiro_t2.c`, is what is compiled into `shapiro`.

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


# 1996

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


# 2001


## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md))
## STATUS: known bug - please help us fix

This entry seems to no longer work and we would appreciate any help from anyone
who can fix this. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has
the following hints that might help but he has no system where he could test
it. [Yusuke Endoh](/winners.html#Yusuke_Endoh) [wrote a little bit about
it](https://mame-github-io.translate.goog/ioccc-ja-spoilers/2001/anonymous.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp) that
might or might not help but he too could not get it to work.

Tips from Cody:

- Try a beautifier on the original C code.
- Use cpp to make the functions easier to parse. For instance if you're in the
directory try `cpp -E anonymous.cp > anonymous.cpp` and look at that file to see
the functions. It might or might not be helpful to use cpp on the beautified
source.
- After beautifying it try changing references of the macros (where not too
complicated) to their definitions. For instance in vim you might do:
`:%s/\<l\>/int */g` and then delete the line that was changed to `#define int *
int*` (or else do a range substitute so it's not changed). You might not need
this if you use the cpp. This might be useful anyway to more easily test things.
- If your system has a `setarch` tool that might or might not be of help (I'm
not too familiar with its internals).
- The code appears to do everything from one call to `exit(3)` but it makes use
of the ternary operator and possibly the comma operator.
- Check the Makefile for the defines but also observe that those are in the
source file. It appears that the entry might try compiling as well but that's
from a quick glance.
- The original main() started like: `main (char *ck, char **k)` but we made it
compilable for clang by changing it to be: `main (int cka, char **k) { char *ck
= (char *)cka;` which might or might not be good.
- The author warns that only simple source (once compiled) would work so make
use of the provided source file
[2001/anonymous/anonymous.ten.c](2001/anonymous/anonymous.ten.c). To compile try
`make anonymous.ten` from the entry directory which you can then run the entry
on. Note that it needs to be compiled as a x86 program.
- The program will to an extent destroy files it is used on. See the author's
warning in their comments on that.


## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md))
## STATUS: possible bug (possibly depending on system) - please help test and if necessary fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed an initial
segfault and he also fixed the [supplementary
program](2001/bellard/bellard.otccex.c) to test the entry on to not segfault and
seemingly work but he has no 32-bit system to test any further fixes and we
would greatly appreciate anyone's help! It appears that this entry will require
major debugging and to make it work one might need to have a deep understanding
of the ELF format.

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


# 2005

## [2005/giljade](2005/giljade/giljade.c) ([README.md](2005/giljade/README.md))
## STATUS: doesn't work with some platforms - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) noted that this
requires both 32-bit CPUs (data size?) and also cannot have the optimiser
enabled.  It might be that it can be fixed, perhaps by changing the int sizes
and bitwise operations, but if not this will not work with some systems like
modern Macs as Apple has made it quite difficult to compile 32-bit applications
(thanks a lot Apple for ruining some IOCCC entries! :-) ).

It's quite probable that non x86 related CPUs will also not work: it's hard to
know because Cody's only non-x86 (x86_64 in particular) system is the MacBook
Pro Max with the M1 chip which is arm64 and specifying `-m32` is invalid on that
system (might be on Intel 64-bit Macs as well but he hasn't had one since before
November 2022).


## [2005/mynx](2005/mynx/mynx.c) ([README.md](2005/mynx/README.md))
## STATUS: INABIAF - please **DO NOT** fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) notes that, though
probably obvious, this entry will not work with https. He changed the code to
scan for https too (it exited before) in case someone comes up with a clever
command line to make it work but the problem is a secure connection has to first
be set up in order to give http commands. This is not a bug but it's worth
pointing out as it won't work on as many websites as it used to including the
[IOCCC website](https://www.ioccc.org) itself.


# 2006
# 2007
# 2008
# 2009
# 2010

These years did not have an IOCCC.


# 2011


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


## [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md))
## STATUS: INABIAF - please **DO NOT** fix

As a backtrace quine this entry is **SUPPOSED to segfault** so this should not be
touched either.

# 2020


## [2020/ferguson1](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))
## STATUS: INABIAF - please **DO NOT** fix

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.


# 2021
# 2022

These years did not have an IOCCC entry.
