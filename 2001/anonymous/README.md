# Dishonorable mention

The author wishes to remain anonymous  
Great Britain  

## To build:

```sh
make
```

## To run:

```sh
./anonymous x86_program
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed both the
supplementary program and the program itself (both of which segfaulted and once
that was fixed only the binary was modified; it was not run but according to the
author's remarks it should be executed). He managed to do this with linux
but it will not work with macOS (see [bugs.md](/bugs.md) for why this is); this
is not a bug but a feature inherent in what it does.

Although it took a fair bit of debugging it turns out all that had to change
was:

- `#include <sys/mman.h>` for `mmap()` and `munmap()`.
- have `main()` call another function which is no longer a recursive function;
this prevented `main()` from entering an infinite recursive loop.

Without either of these it would crash and prevent modification of the 32-bit
[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) (not elf :-)
) binary. But again see [bugs.md](/bugs.md) here. The following change was also
made to be more portable, in case the constants `PROT_READ` and/or `PROT_WRITE`
are not standardised:

Change `3` in the call to `mmap()` to be `PROT_READ|PROT_WRITE`: just in case
`PROT_READ|PROT_WRITE` does not equal 3 (though it seems to be equal in both
macOS and linux).

There was one other thing that had to be done though. Since the program used to
recursively call (infinite recursion, seemingly) `main()` and since that cannot
be done what had to be done instead is after the new function (`pain()` since it
was a pain to fix :-) ) returns to first call `munmap()` and `close()` (else
one would get text file busy error) and then the program can call `execv()` again like the
function `pain()` (was in `main()`) did but with a slight change. See commit
`2159caec4677e0f25ad704a74e04c8196fd6c343` for details. Notice that
the location of the calls to `munmap()` and `close() followed by `execv()` do
matter!

NOTE: there might be educational value to see the progress of this fix; if you
wish to see, try:

```sh
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..93aa8d79f208dcccc3c5a2370a727b5cf64e9c53 anonymous.c
git diff 93aa8d79f208dcccc3c5a2370a727b5cf64e9c53..c48629017117379a52b1a512ef8f2593ca9569c8 anonymous.c
git diff c48629017117379a52b1a512ef8f2593ca9569c8..efdee208a2bc650256637b9357ddfd0de82d2f41 anonymous.c
git diff efdee208a2bc650256637b9357ddfd0de82d2f41..e9a3f77ea3b209e63ac3f9c06bb84ad86e5ea706 anonymous.c
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..2159caec4677e0f25ad704a74e04c8196fd6c343 anonymous.c
```

Thank you Cody for your assistance!

### INABIAF - it's not a bug it's a feature! :-)

If you do not specify a 32-bit ELF binary as the arg of this program it will
very likely crash or do something terribly wrong like slaughtering all the
[elves](https://www.glyphweb.com/arda/e/elves.html) of
[Imladris](https://www.glyphweb.com/arda/i/imladris.php)! :-) so please don't do
that :-(

If the program cannot be run (for instance under macOS as an ELF file) then
the program will fail to execute it and might not even touch it.

### WARNING on note from the author

The author suggested that this will somewhat destroy the binaries this touches
but Cody did not observe this. It does indeed modify the files as the script
below will show you (though not all files are modified: can you figure out why
that is?) but Cody did not notice any problems in using them. Perhaps it's
something he's not aware of possibly including the fact that the modification
might or might not be complete. If you follow the try commands below you will
notice that although the binaries do differ it's not many differences and the
output of the supplementary program both before and after is the same. See the
author's warning about this in their remarks.

## Try:

```sh
./try.me.sh
```

What happens if the x86 program has already been modified by this program? The
judges' remarks below might give you a hint!

What happens if you try it on another file like [anonymous.c](anonymous.c)? Can
you recompile it okay? What if you run it on `anonymous` itself? Can you run the
program successfully after it without recompiling?


## Judges' remarks:

Is emulation the sincerest form of flattery?  This small program does
quite a lot of bit twiddling.

## Author's remarks:

This program is an optimizing dynamic binary translator, allowing you to
run x86 programs on any machine (x86 or otherwise).

I have included a simple [10 Green
Bottles](https://www.bbc.co.uk/teach/school-radio/nursery-rhymes-ten-green-bottles/zncyt39)
[program](anonymous.ten.c) (try `make anonymous.ten`), meant to be compiled in 32-bit.
The program `anonymous.ten`, and its source (dull) are included as data
files.

### Warning

Note that the translator screws around with the binary you run on it and *might*
corrupt the binary to some extent and in so doing might leave any program you
run on it unusable.

The build script should give an example command to compile the program.

### Features

[Basic Block](https://en.wikipedia.org/wiki/Basic_block)
[Cache](https://en.wikipedia.org/wiki/Cache_(computing)): Rather than
translating each instruction individually the dynamic binary translator
generates a translation for an entire basic block of subject code.  Having
translated a block once, the target code generated will be stored for the
duration that the program is running, so as a program runs its performance will
improve, as it hits cached blocks.  This can be clearly observed in the example
program, [anonymous.ten](anonymous.ten.c) which must be compiled as a 32-bit
binary.

### Target Library Linking:

The program runs [dynamically
linked](https://en.wikipedia.org/wiki/Dynamic_linker) [ELF
binaries](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format), and
when the subject program attempts to make a call to a standard
[library](https://en.wikipedia.org/wiki/Library_(computing)), the translator
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
call to `exit()`, there are some nice subtle little obfuscations.  For
example, you may notice that there are a couple of macros that use the
`##` preprocessor operator to build pairs of functions.  One of these
macros is used to build pairs of functions of which only one has
local variables which shadow global variables: so one modifies the
global state, and the other doesn't.

There is also quite a nice trick where I wave a magic wand, and a chunk of code
which should only be run when the program is run for the first time (setting the
[PC / IP](https://en.wikipedia.org/wiki/Program_counter) to point at `main()`,
etc) gets turned into a `frog^M^M^M^Mstring`.  The C compiler sees a string by
itself in the code, thinks "yup, that's a valid C expression", and quietly moves
on to the next line of code.

### Limitations

Due to space limitations only a handful of instructions are supported; these
instructions which are supported are supported in somewhat non-conventional
ways: chunks of the architecture (e.g. flags) are just ignored, the ELF
[loader](https://en.wikipedia.org/wiki/Loader_(computing)) does not really load
the [ELF binary](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format),
the target [library linking](https://en.wikipedia.org/wiki/Linker_(computing))
can only pass up to 3 parameters to the target library function, etc.

In short, please consider this a full disclaimer for any bug that may
turn up - yes the program is unsafe, but it's pretty cool anyway.

Despite all this, the translator is not exclusively limited to running the
[anonymous.ten](anonymous.ten.c) program.  Other trivial **_x86_** programs may
run on the translator \- and I have successfully run a wide range of "Hello
World" programs, including one of last years IOCCC winners,
[tomx](/2000/tomx/tomx.c).

### Complete Program

The fact that the program makes calls to `system()` and `execv()` may imply that
it is not a complete program in its own right, as it relies on other programs.
The call to `system()` is a call to ask gcc to recompile the translator with a
new set of switches, and the call to `execv()` asks for the newly compiled
program to be executed.  I would point out that almost every other entry to this
competition also require a C compiler (well, the published winners at any rate,
and I recognize that a few don't).  There is little real difference between this
program and one like last years entry [dhyang](/2000/dhyang/dhyang.c); both are
just C programs that generate C code as their output.

Enjoy and thanks!

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
