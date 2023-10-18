# Best of Show

Gavin Barraclough\
UK


## To build:

```sh
make
```


## To run:

```sh
./gavin
```


## Try:

To enjoy the results (on a Linux/x86 machine):

```sh
su
```

Make a floppy with an ext2 filesystem (`mke2fs /dev/fd0` replacing `fd0` with
whatever the floppy device is!),  mount it under `/mnt/floppy` and then:


```sh
cp kernel fs.tar lilo.conf boot.b /mnt/floppy
```

NOTE: If the version of your lilo is not 21.4, use the appropriate boot.b file.

NOTE: If your floppy drive is not `/dev/fd0`, edit lilo.conf appropriately.

```sh
lilo -C /mnt/floppy/lilo.conf
```

Boot from the floppy on an x86 machine with a PS/2 keyboard and mouse.
Move the window away from the corner.

```sh
vi gavin.c
```

Scroll up and down the file with up-arrow and down-arrow.

```sh
sh
```

You can have several shell windows:

```sh
vi README.md
./prim
```

Press and hold any key.


## Judges' remarks:

Over the years, we've seen a program that dumps core if executed on a "wrong"
architecture immediately ([1984/mullender](/1984/mullender/mullender.c)), or
after a while ([2001/bellard](/2001/bellard/bellard.c)). This entry will happily
compile and execute on most any architecture - the trick is that the result, to
be useful, must be produced (and can only be enjoyed) on a particular
architecture.  We have not decided yet whether to disallow this for future
contests.

If you do not want to mess with a floppy and you use GRUB, see below
in the author's notes.

You can put additional text files in `fs.tar` for browsing with vi.  If you do
not want to bother rebooting your computer at all, see <http://bellard.org> for
QEMU ([Fabrice Bellard](/winners.html#Fabrice_Bellard) is an IOCCC 2001 winner),
but your experience will be limited (replace `-DK=0` with `-DK=1` in the
[Makefile](Makefile), and you will have to move the mouse to trigger the initial
screen update).

The judges were able to write a few more programs to run in this OS.
What are the limitations for such programs?

What you can do and what you cannot do in such programs?

The program called `prim`, written by the judges, computes and prints prime
numbers.


## Author's remarks:

This is a 32-bit multitasking operating system for x86 computers,
with GUI and filesystem, support for loading and executing user
applications in elf binary format, with PS/2 mouse and keyboard drivers,
and vesa graphics.  And a command shell.  And an application -
a simple text-file viewer.

The OS has ended up as a traditional monolith with one entry point
for syscalls, with apps treated as cooperative-multitasking tasks
that can be sent different messages (e.g. 'initialize', 'key hit',
'render to buffer') through their main entry point, and which will
return control to the OS having performed the necessary work.
Applications are are passed a pointer to their task structure,
which is partially defined by the OS, and partially for
the application's own use.

The program compiles into a tool to build a kernel image,
so having built the program, the [Makefile](Makefile) will run it,
piping the output into a file called `kernel`.
The Makefile will then proceed to build a root filesystem image.
This involves rebuilding the program with different compiler flags,
then building a tar file containing the resulting programs
(the filesystem format supported by the OS is the tar-file format).

For further usage information see [gavin.md](gavin.md).

The filenames `vi` and `sh` are significant, and should not be changed.

### Known 'features'

Known issues are really too plentiful to list.

If the mouse pointer goes off the left hand side of the screen
it will reappear on the right, and vice-versa.
If it goes off the top or bottom, it will go and corrupt some memory.

The file system is kinda optimistic about matching names, so,
for example if you type the command `shell` into a command-line
it will execute the program `sh` - close enough a match for it.

The ELF binaries are not loaded at the correct address, and their entry point
must be the start address of the text segment.

The keyboard driver can cope with the basic alpha-numeric keys,
but gets confused by fancy things like `shift` or `backspace`.

In the text-file viewer, `vi`, the up/down and PgUp/PgDn keys
scroll up or down by one line.  There is nothing to stop you
from scrolling above the top of the file, and pressing any
other keys might have an undefined effect.

The x86 is bootstrapped into 32bit mode in 6 instructions, with 4 more to set up
data/stack segments and a stack-pointer to allow C code to be run.  On top of
this there are also about a dozen instructions to switch the video card into
graphics mode.  All in all, a relatively tiny number of instructions next to the
size of the C program.  Also, the string is mostly composed of data - a
Linux-esque kernel header for the bootloader, protected mode descriptor tables,
keyboard maps, etc.  (I should also mention that it contains mini functions to
perform an x86 `in` and `out` instruction - to allow the keyboard & mouse to be
driven from C code).

Porting to another architecture should be relatively easy\* -
the string simply needs be replaced with one containing
data & code suitable for the new target platform.
Accesses to data in the string are made relative to the define `V`,
so these may need updating as appropriate (`0x90200` is the address
at which a Linux bootloader loads an x86 kernel image).

\* ;-)


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
