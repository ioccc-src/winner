# 1998

## [1998/dlowe](1998/dlowe/dlowe.c) ([README.md](1998/dlowe/README.md))
### STATUS: missing or dead link - please provide them

The domain http://pootpoot.com no longer exists as it once did. The judges have
given a script that can be used to make a similar page (**warning: not checked
for security in modern days!**). Do you have a server with enough bandwidth and
would like to set it up?  We'll gladly thank you in the README.md file and link
to the page as well!  You'll have IOCCC fame for reviving a pootifier! :-)

## [1998/dloweneil](1998/dloweneil/dloweneil.c) ([README.md](1998/dloweneil/README.md))
### STATUS: missing or dead link - please provide them

See above entry [1998/dlowe](1998/dlowe/dlowe.c).


## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md))
### STATUS: INABIAF - please **DO NOT** fix

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
### STATUS: INABIAF - please **DO NOT** fix

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
### STATUS: INABIAF - please **DO NOT** fix

If `DISPLAY` is not set the program will very likely crash, do something strange
(or if you're very unlucky your computer might [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing))! :-) ).


# 2001

## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md))
### STATUS: INABIAF - please **DO NOT** fix

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

### STATUS: INABIAF - please **DO NOT** fix

Note also that if you don't specify a file or you specify a non-32-bit ELF file
this program will very likely crash or do something strange like slaughter the
elves of Imladris :-(

## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md))
### STATUS: INABIAF - please **DO NOT** fix
### STATUS: doesn't work with some platforms - please help us fix

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


## [2001/cheong](2001/cheong/cheong.c) ([README.md](2001/cheong/README.md))
### STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something different without an arg.

## [2001/dgbeards](2001/dgbeards/dgbeards.c) ([README.md](2001/dgbeards/README.md))
### STATUS: INABIAF - please **DO NOT** fix

This program deliberately crashes if it loses (which is what it aims to do).

## [2001/herrmann1](2001/herrmann1/herrmann1.c) ([README.md](2001/herrmann1/README.md)
### STATUS: missing files - please provide them

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


## [2001/kev](2001/kev/kev.c) ([README.md](2001/kev/README.md)
### STATUS: INABIAF - please **DO NOT** fix

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
### STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something else without an arg.



## [2001/schweikh](2001/schweikh/schweikh.c) ([README.md](2001/schweikh/README.md))
### STATUS: INABIAF - please **DO NOT** fix

This program will very likely crash or do something else if you do not give it
two args.

Note also that the glob pattern must match the whole string. See the author's
comments for details and a workaround.

There's also no way to escape meta characters.

# 2002

There was no IOCCC in 2002.

# 2003

There was no IOCCC in 2003.
