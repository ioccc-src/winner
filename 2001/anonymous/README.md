## To build:

``` <!---sh-->
    make
```

The programs that this program is supposed to act on,
[anonymous.ten.c](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) and [anonymous.bed.c](%%REPO_URL%%/2001/anonymous/anonymous.bed.c),
compiled with `make`, MUST be compiled as 32-bit ELF binaries. In the case that
this fails these programs will be compiled as 64-bit binaries as alternate code,
`anonymous.ten.alt` and `anonymous.bed.alt`, ELF or otherwise. However trying to
use the entry on these files will fail. See [Alternate code](#alternate-code)
below for information on how to compile these programs as 64-bit binaries (or
whatever your system will compile them as).


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2001/anonymous in bugs.html](../../bugs.html#2001_anonymous).


## To use:

``` <!---sh-->
    ./anonymous x86_program
```


## Try:

``` <!---sh-->
    ./try.sh

    ./anonymous anonymous.bed # if able to compile as a 32-bit (-m32) ELF binary
```

NOTE: if the 32-bit version cannot be compiled the script will at least compile
[anonymous.ten](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) as a 64-bit program (or whatever your system is
set to) and run it directly.

What happens if the x86 program has already been modified by this program? The
judges' remarks below might give you a hint!

What happens if you try it on another file like [anonymous.c](%%REPO_URL%%/2001/anonymous/anonymous.c)? Can
you recompile it okay? What if you run it on `anonymous` itself? Can you run the
program successfully after it without recompiling?


## Alternate code:

In the case you you wish to manually compile the extra programs as 64-bit code
you may do so. Using the entry on these binaries will very likely crash the
program or do something terribly wrong like slaughtering all the
[elves](https://www.glyphweb.com/arda/e/elves.html) of
[Imladris](https://www.glyphweb.com/arda/i/imladris.php)! :-) so please don't do
that :-(


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./anonymous.ten.alt

    ./anonymous.bed.alt
```


### A 2023 note about the warning from the author:

The author suggested that this *might* somewhat destroy the binaries this
touches but after the fix of 2023 this was not observed (yet?). It does indeed
modify the files (though not all files are modified: can you figure out why that
is?) but using them after did not result in any problems. It could be that it's
no longer known exactly what is supposed to happen and possibly that the
modification might not be entirely correct for that reason though it does appear
to be correct.

It appears that the corruption happens only if the modification fails in the
middle of doing so so that might be why it hasn't been observed.


## Judges' remarks:

Is emulation the sincerest form of flattery?  This small program does
quite a lot of bit twiddling.


## Author's remarks:

This program is an optimizing dynamic binary translator, allowing you to
run x86 programs on any machine (x86 or otherwise).

I have included a simple [10 Green
Bottles](https://www.bbc.co.uk/teach/school-radio/nursery-rhymes-ten-green-bottles/zncyt39)
[program](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) (try `make anonymous.ten`), meant to be compiled as a
32-bit ELF binary.

The program `anonymous.ten`, and its source (dull) are included as data
files.


### Warning

Note that the translator screws around with the binary you run on it and *might*
corrupt the binary to some extent and in so doing might leave any program you
run on it unusable.

The build script should give an example command to compile the program.

### Features

[Basic Block](https://en.wikipedia.org/wiki/Basic_block)
[Cache](https://en.wikipedia.org/wiki/Cache_&#x28;computing&#x29;): Rather than
translating each instruction individually the dynamic binary translator
generates a translation for an entire basic block of subject code.  Having
translated a block once, the target code generated will be stored for the
duration that the program is running, so as a program runs its performance will
improve, as it hits cached blocks.  This can be clearly observed in the example
program, [anonymous.ten](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) which must be compiled as a 32-bit ELF
binary.

### Target Library Linking:

The program runs [dynamically
linked](https://en.wikipedia.org/wiki/Dynamic_linker) [ELF
binaries](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format), and
when the subject program attempts to make a call to a standard
[library](https://en.wikipedia.org/wiki/Library_&#x28;computing&#x29;), the translator
attempts to make an appropriate call to the native system libraries on the
target machine.  This involves mangling between different calling conventions,
etc.

### Automatic Endian Detection/Reversal:

There are various problems raised when attempting to run little
[endian](https://en.wikipedia.org/wiki/Endianness)
[x86](https://en.wikipedia.org/wiki/X86) code on a big endian chip, such as a
[PPC](https://en.wikipedia.org/wiki/PowerPC).  These problems are dealt
with in a manner that is entirely transparent to the user.


### Configuration:


#### Warnings:

By default the build script should compile the program with a set of
switches such that while compiling the program it generates one error
(which I feel is useful advice).  The program should generate no further
compiler errors while it is running (yes, the program can generate
compiler errors while it is running).  If you do not wish to see this
error, or if the program generates any further error when compiled using
your C compiler please remove the `-Dwarning='-Dprocessor'` line and the
`$$warning` from the compiler invocation.


### Optimization

The build script contains a `-O1` switch for the compiler.  Increasing
the optimization level will make the program run *slower*, while
compiling the program without any optimization will allow it to run
*faster*.


### Obfuscation

The most obvious part of the obfuscation is probably the mess of `#define`s at the
top.  This may seem a somewhat tired old obfuscation - however since many of
these macros are (sometimes only) used by the program once it has dynamically
recompiled itself, they are only referenced within the source code from within
strings - and therefore the macros cannot be expanded.  Furthermore, some of
these strings of code are not given as strings, but instead are wrapped up in
macros that use the `#` preprocessor operator to turn them into strings. In the
hope of throwing off a few C beautifiers the macro to generate the strings is
not contained within the source code but instead is passed in on the command
line.

Buried under all this, and the fact that the entire program is just a
call to `exit(3)`, there are some nice subtle little obfuscations.  For
example, you may notice that there are a couple of macros that use the
`##` preprocessor operator to build pairs of functions.  One of these
macros is used to build pairs of functions of which only one has
local variables which shadow global variables: so one modifies the
global state, and the other doesn't.

There is also quite a nice trick where I wave a magic wand, and a chunk of code
which should only be run when the program is run for the first time (setting the
[PC / IP](https://en.wikipedia.org/wiki/Program_counter) to point at `main()`
etc.) gets turned into a <del>frog</del>string.  The C compiler sees a string by
itself in the code, thinks "yup, that's a valid C expression", and quietly moves
on to the next line of code.


### Limitations

Due to space limitations only a handful of instructions are supported; these
instructions which are supported are supported in somewhat non-conventional
ways: chunks of the architecture (e.g. flags) are just ignored, the ELF
[loader](https://en.wikipedia.org/wiki/Loader_&#x28;computing&#x29;) does not really load
the [ELF binary](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format),
the target [library linking](https://en.wikipedia.org/wiki/Linker_&#x28;computing&#x29;)
can only pass up to 3 parameters to the target library function, etc.

In short, please consider this a full disclaimer for any bug that may
turn up - yes the program is unsafe, but it's pretty cool anyway.

Despite all this, the translator is not exclusively limited to running the
[anonymous.ten](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) program.  Other trivial **_x86_** programs may
run on the translator \- and I have successfully run a wide range of "Hello
World" programs, including one of last year's IOCCC entries,
[2000/tomx](../../2000/tomx/index.html).


### Complete Program

The fact that the program makes calls to `system(3)` and `execv(3)` may imply that
it is not a complete program in its own right, as it relies on other programs.
The call to `system(3)` is a call to ask gcc to recompile the translator with a
new set of switches, and the call to `execv(3)` asks for the newly compiled
program to be executed.  I would point out that almost every other entry to this
competition also require a C compiler (well, the published winning entries at any rate,
and I recognize that a few don't).  There is little real difference between this
program and one like last year's entry [dhyang](%%REPO_URL%%/2000/dhyang/dhyang.c); both are
just C programs that generate C code as their output.

Enjoy and thanks!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
