## To build:

``` <!---sh-->
    make
```

There is [alternate code](#alternate-code) that is based on the author's notes
for DOS/Windows. This cannot be tested by us, not even to compile, but it appears
that it should be fine, after the proper header files were added.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2006/toledo2 in bugs.html](../../bugs.html#2006_toledo2).


## To use:

``` <!---sh-->
    ./toledo2
```

To end execution press `ctrl-z`. As mentioned in the author's remarks and in the
below section, it is supposed to crash on termination though some noted this
does not seem to happen in macOS or linux in 2023.


## Try:

``` <!---sh-->
    ./toledo2
```

and then type in the following:

```
    10 PRINT "HELLO WORLD!"
    LIST
    RUN
```

To end the program hit ctrl-z.


## Alternate code:

This version, as noted, should work for DOS/Windows. It uses non-standard
functions in place of `read(2)` and `write(2)`.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

The author noted that for PC/DOS you will have to add `ANSI.SYS` to your
`CONFIG.SYS` but this is also something we can't test.

Use `toledeo2.alt` as you would `toledo2` above.


## Judges' remarks:

We're impressed! Last year, it was a
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502) emulator; this year,
it's [8080](https://en.wikipedia.org/wiki/Intel_8080)! It requires an input file
(`C`) to be present, but it does not have to be one of `C.BASIC` or `C.BIOS` -
you're welcome to write a standalone 8080 program yourself! How about `C.FORTH`
or `C.LISP`?

In addition to the functionality you could expect from a program
of this size, it allows importing files from the host file
system (one by one, so you'll have to be patient).

Remember the good old days and play (or let your kids play)
[Adventure](https://rickadams.org/adventure/) (in the directory `ADVENTUR`);
walking in a maze of twisty little passages all alike is easier than
understanding the code!

**NOTE**: The `KAYPROII.ZIP` file originally came from
[http://www.retroarchive.org/cpm/os/KAYPROII.ZIP](http://www.retroarchive.org/cpm/os/KAYPROII.ZIP).
For your convenience, we have included `KAYPROII.ZIP` in this entry.
Both the `make all` and the `make alt` unzip that file, and the `make clobber`
removes those files extracted from the `KAYPROII.ZIP`.


## Author's remarks:

This program emulates a complete [Intel(r)
8080](https://en.wikipedia.org/wiki/Intel_8080) processor, along with a teletype
and a disk controller, just like at the start of the personal computers
revolution (circa 1975).

It needs an initial memory image to do something usable, so along with it you
will find two files: [C.BASIC](C.BASIC) and [C.BIOS](C.BIOS). Rename
[C.BASIC](%%REPO_URL%%/2006/toledo2/C.BASIC) to `C` (NOTE from the judges: running `make` will do this for
you), run the emulator, and et voila! you have the public domain Palo Alto [Tiny
BASIC](https://en.wikipedia.org/wiki/Tiny_BASIC) (by Li-Chen Wang), published in
the very first volume of [Dr. Dobb's
Journal](https://en.wikipedia.org/wiki/Dr._Dobb%27s_Journal).

Type using uppercase letters. Here are three example programs. Press Enter after
each line:

``` <!---basic-->
    10 PRINT "Hello, world!"
    LIST
    RUN

    10 FOR A=1 TO 10
    20 PRINT A
    30 NEXT A
    LIST
    RUN

    10 INPUT A
    20 INPUT B
    30 PRINT A+B
    LIST
    RUN
```

Press Ctrl+Z to quit. By the way, the segmentation fault is
normal at this point.

All good programmers started learning
[BASIC](https://en.wikipedia.org/wiki/BASIC), now, what about a
[CP/M](https://en.wikipedia.org/wiki/CP/M) emulator?

Copy `CPM64.COM` to files named `A` and `B` (these
will be the disk drives). Now rename the provided `C.BIOS` to `C` and
run the emulator.

Now you have a running [CP/M](https://en.wikipedia.org/wiki/CP/M) system!, with
two files on A: drive, `HALT.COM` to stop the emulator (so it closes drives) and
`IMPORT.COM` to introduce new files. The two files are created automatically
by the provided C.BIOS.

To get a complete [CP/M](https://en.wikipedia.org/wiki/CP/M) system, you will need the following files
from the `SOURCE` directory:

```
    ASM.COM  DDT.COM   DUMP.COM   ED.COM   LOAD.COM
    PIP.COM  STAT.COM  SUBMIT.COM XSUB.COM
```

To import them, you must run the emulator with an argument, by
example:

``` <!---sh-->
    ./toledo2 DDT.COM
```

When the `>` prompt appears, do:

```
    IMPORT DDT.COM
```

When it ends, do `HALT`, so the file is closed, and you can start
the same process with another file.

At this time I have tested successfully the following software
from <http://www.retroarchive.org>:

- <http://www.retroarchive.org/cpm/lang/c80v30.zip>
- <http://www.retroarchive.org/cpm/lang/Mbasic.com>
- <http://www.retroarchive.org/cpm/business/MULTPLAN.ZIP>

Some programs require installation to configure the terminal,
locate ANSI or VT-100.


### What is an 8080?

It is simply the little brother of the
[Z80](https://en.wikipedia.org/wiki/Zilog_Z80); it has no extended
registers (`AF'`, `BC'`, `DE'`, `HL'`, `IX` or `IY`), no relative jumps,
and no instruction beginning with `CB`, `DD`, `ED` or `FD` exists.

The flags are only `S` (Sign, bit 7), `Z` (Zero, bit 6), `P` (Parity,
bit 2) and `C` (Carry, bit 0).


### Porting it

It is easy if your platform has `getch()`/`kbhit()` and
ANSI terminal:

```
    read    -->  Z=kbhit()?getch():0
    write   -->  putchar(7[o])
    system  -->  nothing
```


Notice that you'll have to do `#include <conio.h>` as well.

Also add the following to trap Ctrl-C:

        #include <signal.h>
        signal(SIGINT, SIG_IGN);

NOTE: this is what the [alternate code](#alternate-code) is for!

NOTE from the judges: in Unix like systems `getch()` is part of curses but this
is not what is needed.

On PC/DOS you need to add `ANSI.SYS` to `CONFIG.SYS`.

In Unix the min 0 on `stty` is required but circa 2001
it was not required.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### How this entry works:

The `l` array contains the 64K memory; it is initialized with a boot image
loaded from the `C` file. The [program
counter](https://en.wikipedia.org/wiki/Program_counter) is the `c` pointer and
[registers](https://en.wikipedia.org/wiki/Processor_register) are in `o[]`. The
main loop reads every [opcode](https://en.wikipedia.org/wiki/Opcode) and
separates them in one of three common forms. A lot of ternary operators selects
the instruction.

```
    o[0] = B register   o[1] = C register
    o[2] = D register   o[3] = E register
    o[4] = H register   o[5] = L register
    o[6] = Flags        o[7] = A or accumulator
```

The following instructions do peripheral operation:

```
    76           Quits emulator
    DB 00        Reads key pressed status
    DB 01        Reads key
    DB 02        Reads byte from file (Carry=EOF)
    D3 xx        Writes byte from acc. to console
    ED ED 02     Reads sector
    ED ED 03     Writes sector
```

Memory addresses:

```
    FBFA = Low source/target direction
    FBFB - High source/target direction
    FBFC - Sector
    FBFD - Low cylinder
    FBFE - High cylinder
    FBFF - Drive.
```

The BIOS is tailor made for this emulator, and helps to simplify it.


### Other notes

- The 8080 runs at your computer speed divided
  between a number that I have not calculated.
- This obfuscated processor is created using
  obfuscated code produced by an obfuscated mind;
  no brains were harmed during its production,
  except those that tried to read the code.
- The original version of this code was eaten
  by my C++ dog.
- I intended to make it simple to understand;
  it uses only four C keywords.
- Also I discovered that braces are very useful
  for commenting.
- Why bother with prototypes? Every good C
  programmer can develop their C programs using
  only one function.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
