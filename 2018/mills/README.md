# Best of show

Christopher Mills <mrxo@sonic.net>  
Twitter: @MisterXopher  


## Judges' comments:
### To use:

    make
    ./prog

### Try:

    make
    ./prog
    (At the ">boot" prompt, type return)
    (At the ":" prompt, type "rk(0,0)rkunix")
    NOTE: To quit, press Control-E

### Selected Judges Remarks:

Do small machines only need small programs?  This program weighs in at just
3636 bytes, which is considerably lighter than the original machine it can replace.

This program can take you back to the start of everything, it is possible to
run v0. Just type:

    make
    ./v0

    NOTE: To quit v0, press Control-E

You will be greeted with a familiar prompt of "login". The username and
password are "dmr" and "dmr". To make things more familiar you'll need to
create '.' as it hasn't been invented yet on this image!

    @ ln dd dmr .

An "ls" will reveal that C hasn't been invented yet! IOBCC anyone? The
compiler is "bc". It producess assembly, which will then need to be assembled
together in this order "ops.s bl.s hello.s bi.s" to produce a.out!

But wait, we said this was the start of it all! This program can also run a
program that replaces an even larger machine that can run BSD 2.9. To start this,

    make
    ./prog

    (At the ">boot" prompt, type return)
    (At the ":" prompt, type "rk(0,0)rkunix")
    NOTE: To quit prog, press Control-E

This should now be very familiar and it is possible to compile and run one of
the very first IOCCC entires "mullender.c"

But wait, there is even more!  Try:

    make
    ./v6

    (At the "@" prompt, type "rkunix")
    NOTE: To quit v6, press Control-E

## Author's comments:

>   *This IOCCC entry is dedicated to the late Dennis M. Ritchie*


The Program
===========

Since this is the 25th "annual" IOCCC, I thought I should mark the occasion
with a look back to its earliest roots.  At the same time the contest enters
its 34th year of providing a safe forum for poor C code, the C language
itself is fast approching its 50th anniversary, along with the UNIX operating
system whose history is so entwined with.

The program delivered here is both a full machine emulation of the original
PDP-7 that Ken Thompson used to write the first version of UNIX and a full
machine emulation of the PDP-11/40 used by subsequent UNIXes.  The `Makefile`
can build versions that can run each of the following:

  1. UNIX v0 for the PDP-7 (circa 1969)
  2. Research UNIX Version 6 (circa 1975)
  3. BSD 2.9 (circa 1983)

For reasons to be described in a bit, the last (BSD 2.9) is the default.

Building and Running BSD 2.9
----------------------------

To run BSD 2.9, do `make` to build `prog` and then `./prog` to run it.

You should see a prompt from the first-stage bootloader that looks like

        >boot

Type `RETURN` at this point and you will get to the second-stage boot loader
that looks like

        40Boot
        :

The 40 in the prompt indicates that the bootloder has correctly determined
that we are running on a PDP-11/40.

At this point, type the rather cryptic command `rk(0,0)rkunix` -- this tells
the system to look at the first partition on the first RK05 fixed disk, find
the `rkunix` file and load it.  You should eventually see the following:

        >boot
        
        40Boot
        : rk(0,0)rkunix
        
        Berkeley UNIX (Rev. 2.9.1) Sun Nov 20 14:55:50 PST 1983
        mem = 135872
    
        CONFIGURE SYSTEM:
        xp ? csr 176700 vector 254 skipped:  No CSR
        rk 0 csr 177400 vector 220 attached
        hk ? csr 177440 vector 210 skipped:  No CSR
        rl ? csr 174400 vector 160 skipped:  No CSR
        rp ? csr 176700 vector 254 skipped:  No CSR
        ht 0 csr 172440 vector 224 skipped:  No CSR
        tm 0 csr 172520 vector 224 skipped:  No CSR
        ts 0 csr 172520 vector 224 skipped:  No CSR
        dh ? csr 160020 vector 370 skipped:  No CSR
        dm ? csr 170500 vector 360 skipped:  No autoconfig routines
        dz ? csr 160110 vector 320 skipped:  No CSR
        dz ? csr 160110 vector 320 skipped:  No CSR
        dn 0 csr 175200 vector 300 skipped:  No autoconfig routines
        vp ? csr 177500 vector 174 skipped:  No autoconfig routines
        lp ? csr 177514 vector 200 skipped:  No CSR
        Erase=^?, kill=^U, intr=^C
        # 
    
Congratulations, you are running BSD UNIX 2.9 in single-user mode as root.

On the other hand, if you did a typo somewhere, the boot loader has probably
crashed and halted -- if so, type Control-E to quit the simulation and try
again.  If you did really badly, you might have corrupted the virtual disk.
If so, consider a `make clean` to start from scratch.

Assuming you managed to type 15 characters correctly, You should be at the
root prompt.  Most of the commands you are familiar with work here (this was
only a quarter of a century ago -- how much could things have changed?).
Let's try some:

        # ls
        .cshrc       .profile     boot         hkunix       mnt          tmp
        .login       2.9stamp     dev          lib          mullender.c  unix
        .msgsrc      bin          etc          lost+found   rkunix       usr
        # df
        Filesystem  Mounted on  kbytes    used    free  % used
        /dev/rk0    /             1958    1688     270     86%
        # cc mullender.c
        # ./a.out

The program you've just run was the [winner of the first IOCCC contest from
1984] [1]  (or was it 1894?), a personal favorite of mine.  It is rather
tightly bound to running on either a PDP-11 or a VAX.  Now you have one.

Hitting Control-C will return you to the BSD UNIX prompt.  Hitting Control-D
will log you out of the single-user session and get you back to the `:login:`
prompt.  Here you can log in as `root` and get a full timesharing session.
Feel free to try things like `vi`.  I've taken the liberty of editing the
`.login` and `.profile` files to set the console to a less traditional setup
so that you don't have to wait for the Model 33 KSR teletype to move its
carriage.  I've also predefined `TERM` to `vt100`, which will probably work
well enough with whatever sort of ANSI terminal emulation you are using.

Note that I have not mounted the `/usr` disk here, so some commands from
`/usr/bin` will be missing, along with all of the `man` pages.  They are
[available online] [2] if you need them.  Adding a second RK05 disk was
possible, but I didn't get around to it...  As the Judges can no doubt attest,
"Mid 2017" creeps up on you quicker than you expect. :)

Once you've had enough fun in BSD 2.9, type Control-E to exit the emulation.

Building and Running Research UNIX v6
-------------------------------------

Research UNIX v6 and BSD 2.9 use the same executable, but require a different
disk image.  Type `make v6` to build it, then type `./prog` to run it.

You should see the boot loader prompt which is a single `@`:

        @

At this point, you again must type a special incantation: `rkunix`.  After that
you should see:

        @rkunix
        mem = 1035
        RESTRICTED RIGHTS
        
        Use, duplication or disclosure is subject to
        restrictions stated in Contract with Western
        Electric Company, Inc.
        # 

You are now running a single-user session of v6 UNIX.  You might want to start
with `stty -lcase` because otherwise everything will be IN ALL CAPS.

Again, if you failed typing seven characters without making a mistake, you
may need to use Control-E to quit the simulation.

Assuming you're more careful than that, we can try a few commands:

        @rkunix
        mem = 1035
        RESTRICTED RIGHTS
        
        Use, duplication or disclosure is subject to
        restrictions stated in Contract with Western
        Electric Company, Inc.
        # STTY -LCASE
        # ls
        bin
        dev
        etc
        hpunix
        lib
        mnt
        rkunix
        rpunix
        tmp
        unix
        usr
        # cat > foo.c
        main()
        {
            printf("Hello, World!\n");
        }
        # cc foo.c
        # ./a.out
        Hello, World!

Why is Version 6 interesting?  Well, it was the oldest version that I could
find a boot image of that had a C compiler...  This C compiler is recognizably
C, but not quite the same syntax as we have today.  It's much closer to the
[B language] [3] from which it is derrived.  In particular, this C compiler
would not be able to compile `mullender.c` (as simple as it is), because the
following syntax features don't exist yet:

  * The `short` data type doesn't exist yet.  Only `int` (`short` will show
    up when `long` comes, and the port to the Interdata 7/32 starts to make
    the idea of portability become important).
  * Hexidecimal constants don't exist yet.  Digital's computers all used
    octal.
  * The array initializer syntax hasn't yet moved to using `=`.  It still uses
    the older form taken from B, which looks like `array[] { 1, 2, 3 };`

It can still compile "Hello World!" (note that you must type a Control-D after
you finish entering the code, to let `cat` see an end-of-file).

This version of UNIX doesn't go into multi-user mode if you do a Control-D.
Single-user mode was entered because the front-panel console switches were
set to the magic number 0173030 (this can be changed with a re-compile).

Once you are done with Version 6, Type Control-E to exit the simulation.

Note that since both BSD 2.9 and UNIX v6 use the same PDP-11/40 emulation
code, and they use the same name for the disk (`rk05.fs`), if you want to go
back to the BSD simulation, you should either delete `rk05.fs` or do a
`make clean` before you do a `make`.

Building and Running UNIX v0
----------------------------

We now set the Wayback Machine to the very start of it all, 1969.

[The story] [4] here is interesting and well worth a read.  Bell Labs was
pulling out of the Multics project and Ken Thompson and his collegues had
become accustomed to the relatively nice programming environment.  They also
enjoyed the early computer game [*Space Travel*] [5] and wanted another system
to run it on.  They found a PDP-7 which was already obsolete at the time to
port *Space Travel* to.  The primitive programming environment influenced
Thompson to recreate parts of the Multics experience in the much more
hardware-constrained PDP-7 environemnt.  In the summer of 1969, with his wife
out on a month-long vacation, Thompson re-wrote a filesystem emulation he had
been experementing with to include an assembler, a shell, an editor and an
operating system kernel and hence created the first version of UNIX (although
it hadn't been named that yet).

You can try out this version by typing `make v0`.  Since this version is a
native PDP-7 emulation, it gets its own binary.  Type `./v0` to run it.  You
should see the login prompt.

        login:

There are two user accounts `ken` and `dmr`, with the passwords `ken` and `dmr`
respectively.  Let's try the Dennis Richie's `dmr` account:

        login: dmr
        password: dmr
        @ ls
        .       ?

Even though this is not Ken's doing, I feel this gives me licence to
include this quote from the BSD `fortune` program:

> Ken Thompson has an automobile which he helped design. Unlike
> most automobiles, it has neither speedometer, nor gas gauge,
> nor any of the numerous idiot lights which plague the modern
> driver. Rather, if the driver makes any mistake, a giant "?"
> lights up in the center of the dashboard. "The experienced
> driver", he says, "will usually know what's wrong."

What's the deal here?  Well, that's a slightly long story.  The short version
is we have gone so far back in the history of UNIX that *we don't have
filesystem paths yet*.  In other words, we can't say something like
`/bin/ls` yet, and the shell can't store that path in `$PATH` to search for it.
We also haven't invented `.` or `..` yet.  In fact, the filesystem isn't even
the traditional UNIX tree structure, it's a directed graph of hard links...

`ls` needs to be able to read '`.`', the current directory.  `dmr`'s home
directory doesn't have that yet, but we can make it, because the home
directory has a hard link to `dd`, which is the directory that holds all
of the user home directories (this will eventually become ``/``, the root
path).  We can do

        @ ln dd dmr .

To make the new link (note that `ln` doesn't support paths either, so you have
to give it three arguments -- a directory in the current dir, a file in that
directory, and the new name).

Now `ls` will work, and we can try some other things while we are here:

        login: dmr
        password: dmr
        @ ln dd dmr .
        @ ls
        dd      
        system  
        as.s    
        b_readme
        bi.s    
        bl.s    
        db.s    
        hello.b 
        ops.s   
        .       
        @ cat b_readme
        Here is how to compile and run hello.b:
        
          @ bc hello.b hello.s
          @ as ops.s bl.s hello.s bi.s
          I
          II
          ops.s   
          bl.s    
          hello.s 
          bi.s    
          @ a.out
          Hello, World!
        
        
        @ bc hello.b hello.s
        @ as ops.s bl.s hello.s bi.s
        I
        II
        ops.s   
        bl.s    
        hello.s 
        bi.s    
        @ a.out
        Hello, World!
        @ 

The last command is invoking the compiler for an exteremely early version of
the [B programming language] [3], the predecessor to C.  Thompson missed the
convinience of writing code in a high-level language -- Multics was written
a version of PL/1 -- and wanted the same convinience on UNIX.  He preferred
BCPL (a typeless language) to PL/1.  As Dennis Ritchie [wrote] [6]:

> B can be thought of as C without types; more accurately,
> it is BCPL squeezed into 8K bytes of memory and filtered
> through Thompson's brain.

A look at the B reference manual will show the strong correlation with C, and
shows the source of a lot of C's mysteriousness -- some of which is preserved
simply so that C could compile the *dozens* of lines of existing B code...

Thompson's assembler was also extremely simple.  It didn't even know about
opcodes -- these need to be defined in the first assembly file, with the
assembler OR-ing the opcode fields together (space was the "operator" for
logical OR).  There is no link step -- all files are provided to the assembler
on the command line, concatenated together and assembled, producing a single
`a.out` (assembler output) file.  Even after UNIX got a linker, `a.out`
remained the default name of the binary generated by the linker (and hence
also by `cc`).

This system is still has the familiarity of UNIX, with all the two- and
three-letter commands, device files, shell redirection, the same core system
calls (`read`, `write`, `open`, `close`, `creat`, `fork`, etc.).  There are a
number of differences still:

  * As noted, there are no file paths
  * `read` and `write` do I/O on (18-bit) words.  Character I/O to files needs
    to unpack those to bytes, and of course deal with `NUL` characters.
  * `exec` was performed by the shell directly.  Arguments are passed as
    four words (eight bytes), and space padded.  This matches the format for
    file names for `open` and `creat`.
  * `wait` does not yet exist.  A more complicated mechanism for sending and
    recieving messages (`smes` and `rmes`) are used instead.
  * File permission bits are all different, since groups don't exist yet.
  * User programs are not allowed to run during disk I/O.  This is because the
    disk controller's "data break" (DMA) accesses were so fast relative to the
    CPU that transfers would be dropped if an instruction that used
    "deferred" mode (indirection) was executed.  This also meant that the
    "program break" (interrupt) routine in the kernel had to specifically
    avoid deferred accesses by using self-modifying code to do indirection
    through pointers.
  * Although the PDP-7 suppoted a "trap mode" (a primitive supervisor mode),
    the UNIX kernel doesn't use it.  This means that user programs could alter
    or crash the kernel at will (in fact, there is a system call that returns
    addresses of useful kernel routines so that user code can call them
    directly).

As usual, when you are done exploring UNIX v0, type Control-E to exit the
simulator.

About the Program
=================

The program came about when I was looking for something to honor the pending
50th anniversary of the C language (because of the mercurial nature of IOCCC
contest scheduling, I chose not to wait for the actual 50th anniversary).
I had though of writing self-hosting compilers for a stripped-down version of
C, or maybe even a version of the B language...  At the same time, I was
obsessed with the idea of allowing `mullender.c` from 1984 to run.  Although
that was still a possibility on an interpreted version of B or a stripped-down
version of C, it felt cheap, as it would be `mullender.c` only in spirit.

It was during this time that I discovered that in 2016, members of the Unix
Heritage Society got access to [printouts of assembly-language source for the
original version of UNIX] [7].  With what was a [huge amount of work] [8],
they scanned in the printouts, fixed up the OCR translations, built assembler
and file system tools from scratch and made an accurate simulation of
Thompson's PDP-7 that allowed them to get the system up and running.  Although
source for the entire kernel and about half of the user-space commands were
present (including the runtime and libraries for the B compiler), the
remainder needed to be written from scratch, including the shell.  The final
results of the project are [available on github] [9].

None of this was remotely easy (as I was to discover myself).  The PDP-7 is
long gone, and the documentation for it is less complete than one would like.
In addition, the devices attached for it were a bit of a mystery.  The disk
system is referenced only in an old price list.  It was a RB09 fixed disk,
probably made by Burroughs.  It is close to what was called the RC10 for the
PDP-10, but with a different interface.  And the system also included a custom
display device called Graphics-2, which had been built in-house by AT&T.
It can't be completely ignored, because the kernel itself pokes at it (the
UNIX crew used it as a second terminal -- a "glass TTY").

I decided that implementing this PDP-7 would be possible as an IOCCC entry.

The emulator emulates the full machine:

  * PDP-7 Central Processor
  * Core Memeory Module Type 147 -- extends the core to 8,192 18-bit words
  * Extended Arithmetic Element Type 177 -- adds one's-complement
    multiplication, division and shifting
  * Real Time Clock
  * Teletype Model 33 KSR
  * Perforated Tape Reader Type 444
  * RB09 Fixed Disk Controller

The [PDP-7] [10] is an odd duck by modern computer standards:

  * 18 bit words, with no byte addressing.
  * Both one's and two's complement math (there is `ADD` for one's complement
     and `TAD` for two's complement).  The EAE is entirely one's-complement.
  * "Microcoded" instructions.
  * Auto-increment memory locations.
  * Non-reentrant function calls (the return address is stored at the indicated
    address and the PC jumps to the location after it).
  * The `XCT` instruction, that executes the word loaded from memory as an
    instruction.
  * An instruction `LAW` that loads the instruction opcode into the
    accumulator.
  * Heavy use of "inline" operands.  For instance the `MUL` instruction expects
    the second operand to be stored in memory after the instruction.  This
    pretty much requires the use of self-modifying code.
  * No immediates.  Almost all constants have to live in memory locations and
    be referenced by address.
  * Common operations, like "subtract" and "inclusive OR" are not directly
    supported on the machine and require multiple instructions and some spare
    memory locations to support.  Being clever also helps.
  * Single accumulator architecture.  No direct support for things like stacks.
  * I/O is done with dedicated I/O instructions (which are also microcoded).
  * The RB09 disk controller gets a special mention here because of its
    particularly annoying encoding of track and sector offsets in
    [packed BCD] [11].  A non-trivial amount of code space in the simulator
    is needed to convert into and out of BCD, along with an equivalent amount
    of code in the UNIX kernel itself.

The simulation handles everything I was able to discover about the PDP-7, even
things that the UNIX code itself doesn't use.  For instance, it correctly
implements the "trap mode" feature (a primitive form of supervisor mode) even
though the kernel does not enable it.  It also implements the microcoding of
the EAE instructions even though the UNIX environment uses only the standard
encodings.  If you wanted to do a 11-bit multiply instead of an 18-bit one,
it will probably work.

The simulation starts by loading a boot program off of the virtualized paper
tape, which is in a modified version of the RIM boot loader format.  The
RIM format encodes each 18-bit word as three six-bit characters, using one bit
to denote the final word (which is executed directly and is usually a `JMP` or
`HLT` instruction).  The load address comes from the console address switches.
Both of these are controlled by compile-time flags.

The emulator continues emulating instructions until it sees a `HLT` instruction
which will cause it to exit.  Console I/O is emulated by setting the terminal
into raw mode and polling via `read`.  Line-clock ticks (at 60 Hz) are done
by polling `gettimeofday`.  Dynamic frequency code arranges to reduce the
polling interval to a few polls per tick, so that simulation remains
responsive.  Since we use the real wall-clock time, this means that the
emulated system will see time advance at the correct rate.

Licencing Fun
-------------

So now I have a system that can run UNIX v0.  One problem remains...  I don't
have permission to submit UNIX v0 to the IOCCC.  It is not my code and the
copyright for it remains the property of whoever owns that part of what was
once Bell Labs -- I believe it is Nokia at this point.  I have worked around
this problem in two ways:

First, I didn't submit the source code or binary image for v0 UNIX as part of
my IOCCC entry.  I merely submitted a `Makefile` that can issue a `curl`
command to fetch a prebuilt v0 disk image from the github repository.  I am
hoping this is considered part of "Legal abose of the rules" which is supposed
to be "somewhat encouraged".  As per RULE 12, I am justifying said abuse here,
in the remarks file.

Secondly, the choice to run the UNIX v0 code is optional.  If you are worried
about Nokia's lawyers running you to ground for running a 50-year old copy
of a binary image for a machine that is almost completely nonexistant, you
can just not do so.  Delete the lines from the `Makefile` and sleep well.
You still have two other UNIXes to play with.

What about the other two UNIX variants?  These are both covered by licences
that allow me to use them.  Back in 2002, Caldera International released
Research Unix versions 1-7 and 32V under a [permissive BSD-like license] [12].
BSD UNIX is based off of v7 UNIX, and of course has its own permissive
BSD licence.  And in 2017, Nokia also released versions 8-10 under the
condition that it will not assert copyright rights for non-commercial use.

So the newer UNIXes are in the clear.  I doubt anyone actually cares about
version 0 either, but technically it's still under copyright.

PDP-11/40
---------

So if I have a PDP-7 emulator, how do I run operating systems that expect a
PDP-11?  Simple...  *I emulate a PDP-11/40 on the PDP-7*.  I have written
PDP-7 assembler code to emulate a PDP-11/40 with the following equipment:

  * PDP-11/40 (KD11-A)
  * EIS instruction set (KE11-E)
  * Memory management unit (KJ11-A)
  * Line time clock (KT11-D)
  * 124 Kwords of memory (244 Kbytes)
  * RK05 fixed disk drive (RK11)
  * Console TTY (DL11)

This required a few tweaks to the emulator.  The first problem is that the
RK05 disk is about 2.5 MB, but the RB09 is only about 2 MB.  That's easily
solveable -- just add more tracks to the RB09.  UNIX v0 is unlikely to notice
(although the number of tracks is a compile time parameter, and the `v0`
build commands set it to the correct value).

The second problem is that we are simulating a system that can have up to
124 Kwords of memory on a system with only 8 Kwords total.  That meant I needed
to virtualize the PDP-11/40's physical memory (and add a few more tracks to
the disk to hold the virtualization).

A large amount of time was spent tuning this code to be efficient.  The
memory virtualization uses part of the 8 Kword memory as an LRU cache, and
uses a number of first-level microcaches to avoid having to do the LRU updates.
This also serves to offload the complexity of the PDP-11's segmentation logic
from a large number of memory accesses (the PDP-11 does as many as eight
accesses per instruction).  Despite the super fast emulated disk, the PDP-7
code in the emulator is slow, mostly because it has to do a bunch of divides
to convert the linear disk offset into a BCD-coded track and sector for the
emulated RB09.  I/O polling is again used, except this time it uses the
PDP-7's  "skip on flag set" I/O instructions.  As with the PDP-7 emulator
itself, the PDP-11 emulator dynamically measures the instruction throughput
relative to the line-clock tick, so that it only polls for I/O a few times
per tick.

The one remaining problem is building the disk images themselves.  Since the
PDP-11's disk is 16-bit, but the PDP-7's is 18-bit (which the emulator stores
in 32-bit `int`s), a conversion program is needed to unpack the binary disk
images from 16 bits per word to 32.  This in turn needs to be done in the
`Makefile` using standard POSIX tools, which aren't exactly good with binary.
I had a wierdly clever way to do this with `od`, `awk` and `uudecode` that
I will leave as an exercise for the curious, but I decided it would be easier
to do it with the PDP-7 emulator itself, feeding a simple program in on its
boot tape.  This required an additional tweak to the emulator, since by default
its console TTY is not eight-bit clean (in fact, UNIX v0 expects to see the
MSB set on the terminal reads, and sets it on writes, what is called "mark"
parity).  This is also enabled by a compile-time setting (used only for the
`builddisk` program).

Despite the complexity of the PDP-11 instruction set and its emulated I/O
devices and the corresponding primitiveness of the PDP-7's instruction set,
the emulation itself is a suprisingly small amount of code, not really taxing
the 8 Kword memory, with about 2.25 Kwords of actual code and a similar
amount of space for the memory virtualization cache and disk block buffer,
leaving nearly half (3.5 Kwords) of the memory unused.  The simulator executes
somewhere around 250 PDP-7 instructions per PDP-11 instruction.  On my laptop,
the PDP-7 is running somewhere in the neighborhood of 70 MIPS, which means the
PDP-11 is running at about 0.3 MIPS, which is probably not too far off of its
actual speed (the cycle time of an 11/40 was around a microsecond for simple
instructions, but could be proportionally larger for instructions that did
multiple memory accesses, which many did).

As an aside, although the idea of emulating the PDP-11 on an emulated PDP-7
came about from the realization that I needed a response to the late-discovered
licence issue, I'm quite pleased with the result -- it enables an interesting
window on the dawn of the UNIX era.  I feel that someone should complete the
circle here by emulating a VAX 780 on the PDP-11 and run 4.2BSD on it, so that
we can get the [original runtime environment used for the first IOCCC] [13].

Compile-time Options
--------------------

The following command flags control the compilation:

  * `-DI="image.fs"`: Name of the disk image file.  This must be created
     offline, and be of the correct size to avoid segmentation violations.
  * `-DA=4096`: Setting of the console address switches.  This tells the RIM
    bootloader where to load the boot image.
  * `-DS=0`: Setting of the console data switches.  The PDP-7 emulation can
    read these with the microcoded `OAS` (OR switches into AC) instruction.
    By proxy, the PDP-11 emulation can read them via the `CSW` device.
  * `-DW=MAP_PRIVATE`: This sets the memory mapping for `mmap`.  Setting to
    `MAP_PRIVATE` makes the disk image be copy-on-write.  Setting it to
    `MAP_SHARED` makes the disk image be sharable.  Do the latter if you want
    to preserve the disk contents between sessions.
  * `-DT=`: List of initializers for the `termios` structure.  The v0 UNIX
    expects the terminal to be in half-duplex mode, echoing its input, with
    swapped CR and NL.  The PDP-11 UNIXes don't.
  * `-DX=5`: The ASCII code of the control character that causes the simulation
    to abort.  If set to 0, there is no abort code.
  * `-DY=128`: Controls console I/O parity.  If set to zero, the console is
    eight-bit clean.  If set to 128, the high bit is set on keyboard reads and
    masked off on printer output ("mark" parity).  UNIX v0 expects the latter.
  * `-DV=270`: The size of the disk, in tracks.  The UNIX v0 disk has 200
    tracks (each has 80 sectors of 64 18-bit words).  The PDP-11 UNIXes
    increase this to 270, to allow for the larger RK05 disk emulation
    (406 tracks of twelve 256-word sectors), plus the space for the 124 Kwords
    of virtualized memory and the 8 Kwords of emulator code.
  * `-DP="xxx"`: RIM bootstrap program paper tape image.  Be careful with the
    quoting here -- there is at least three levels going on.  In particular,
    you will need to escape `$` as `$$` to protect it from `make`.

What is the ASCII art supposed to be?
-------------------------------------

The ASCII art represents a torn piece of [paper tape] [14].

Acknowledgements
----------------

None of this could have been possible without the hard work of

  * Warren Toomey and the other members of the
    [The Unix Heratage Society] [15]
  * Robert M. Supnik and the other contributors to [SimH] [16], the simulator
    for historic computer architectures.  The number of times I needed to
    "Use the Source, Luke" on SimH to unravel some dark corner of these
    machines was uncountable.
  * [Bitsavers] [17], which acquired, scanned and preserved all the manuals
    I spent many hours squinting at.
  * Ken Thompson, Dennis Ritchie, Brian Kernigan, M\. D\. McIlroy, J\. F\.
    Osssanna, Rudd Canaday and the other members of the Bell Labs
    Computing Science Research Center who were responsible for the invention
    of UNIX, the C programming language, and the innumerable other innovations
    that we now take for granted as part of the modern software landscape.
    In particular, the [home page of the late Dennis Ritchie] [18] contained
    a trove of useful information on the evolution of UNIX and C and is
    recommended for perusal by others who share my peculiar retrocomputing
    affectations.

Finally, thanks to my spouse for putting up with the many hours I spent on this
nonsense, and treating "I'm working on my IOCCC entry" as an acceptable answer
to queries about how I was spending my free time.  Similarly, I apologise to
those friends and coworkers who had to listen to me complain about obscure
corner-case bugs in my code.  The obsession is over, at least until next
time...

-------------------------------------------------------------------------------

[1]:  http://ioccc.org/1984/mullender/mullender.c            "mullender.c"
[2]:  http://minnie.tuhs.org/cgi-bin/utree.pl?file=2.9BSD    "2.9 BSD"
[3]:  https://www.bell-labs.com/usr/dmr/www/kbman.html       "B Language"
[4]:  https://www.bell-labs.com/usr/dmr/www/hist.html        "UNIX history"
[5]:  https://www.bell-labs.com/usr/dmr/www/spacetravel.html "Space Travel"
[6]:  https://www.bell-labs.com/usr/dmr/www/chist.html       "C History"
[7]:  http://www.tuhs.org/Archive/Distributions/Research/McIlroy_v0/ "V0 Scans"
[8]:  http://minnie.tuhs.org/Y5/wkt_hapop_paper.pdf          "UNIX v0"
[9]:  https://github.com/DoctorWkt/pdp7-unix                 "PDP-7 UNIX"
[10]: http://bitsavers.trailing-edge.com/pdf/dec/pdp7/F-75P_PDP7prelimUM_Dec64.pdf "PDP-7 Manual"
[11]: https://en.wikipedia.org/wiki/Binary-coded_decimal     "BCD"
[12]: http://www.tuhs.org/Archive/Caldera-license.pdf       "Caldera Licence"
[13]: https://groups.google.com/forum/?hl=en#!msg/net.lang.c/lx-TAuEyeRI/HdOOnNx6LC0J "First annual IOCCC announcement"
[14]: https://en.wikipedia.org/wiki/Punched_tape             "Paper Tape"
[15]: http://www.tuhs.org                      "The Unix Heritage Society"
[16]: http://simh.trailing-edge.com            "SimH"
[17]: http://bitsavers.trailing-edge.com       "Bitsavers.org"
[18]: https://www.bell-labs.com/usr/dmr/www/   "DMR Homepage"


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
