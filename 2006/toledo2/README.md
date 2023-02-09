# Best of Show

Oscar Toledo
Av. Santa Cruz del Monte 9-304
Ciudad Satelite. Edo. de Mexico
CP. 53110
Mexico

## Judges' comments:

### To build:

        make toledo2

### Try:

        cp C.BASIC C
        ./toledo2

We're impressed! Last year, it was a 6502 emulator; this year,
it's 8080!  It requires an input file ("C") to be present, but
it does not have to be one of C.BASIC or C.BIOS - you're welcome
to write a standalone 8080 program yourself! How about C.FORTH
or C.LISP?

In addition to the functionality you could expect from a program
of this size, it allows importing files from the host file
system (one by one, so you'll have to be patient).

Remember the good old days and play (or let your kids play)
Adventure (in the directory ADVENTUR within the KAYPROII.ZIP
file referred in the author's comments); walking in a maze of
twisty little passages all alike is easier than understanding
the code!

## Author's comments:

This program emulates a complete Intel(r) 8080
processor, along with a teletype and a disk
controller, just like at the start of the personal
computers revolution (circa 1975).

It needs an initial memory image to do something
usable, so along it you will find two files
(C.BASIC and C.BIOS). Rename C.BASIC to C and run
the emulator, and et voila! you have the public
domain Palo Alto Tiny BASIC (by Li-Chen Wang),
published on the very first volume of Dr. Dobb's
Journal.

Type using uppercase letters, here are three example
programs, press Enter after each line:

        10 PRINT "Hello, world!"
        LIST
        RUN

        10 FOR A=1 TO 10       10 INPUT A
        20 PRINT A             20 INPUT B
        30 NEXT A              30 PRINT A+B
        LIST                   LIST
        RUN                    RUN

Press Ctrl+Z to quit, by the way, the segmentation fault is
normal at this point.

All good programmers started learning BASIC, now, what about a
CP/M emulator?

Download the following file (not included because of possible
copyright and blah, blah):

> <http://www.retroarchive.org/cpm/os/KAYPROII.ZIP>

Extract CPM64.COM from the SOURCE directory, and copy it to
files named A and B (these will be the disk drives). Now rename
the provided C.BIOS to C and run the emulator.

Now you have a running CP/M system!, with two files on A: drive,
HALT.COM to stop the emulator (so it closes drives) and IMPORT.COM
to introduce new files.

To get a complete CP/M system, you will need the following files
from the KAYPROII.ZIP, SOURCE directory:

        ASM.COM  DDT.COM   DUMP.COM   ED.COM   LOAD.COM
        PIP.COM  STAT.COM  SUBMIT.COM XSUB.COM

To import them, you must run the emulator with an argument, by
example:

        prog DDT.COM

When the A> prompt appears, do:

        IMPORT DDT.COM

When it ends, do HALT, so the file is saved, and you can start
the same process with another file.

At this time I have tested successfully the following software
from retroarchive.org:

> <http://www.retroarchive.org/cpm/lang/c80v30.zip>
> <http://www.retroarchive.org/cpm/lang/Mbasic.com>
> <http://www.retroarchive.org/cpm/business/MULTPLAN.ZIP>

Some programs requiere installation to configure the terminal,
locate ANSI or VT-100.

### What is an 8080?

It is simply the little brother of the Z80, it has no extended
registers (AF', BC', DE', HL', IX or IY), no relative jumps,
and every instruction beginning with CB, DD, ED or FD doesn't
exist.

The flags are only S (Sign, bit 7), Z (Zero, bit 6), P (Parity,
bit 2) and C (Carry, bit 0).

### Porting it

It is easy if your platform has getch/kbhit and
ANSI terminal

        read    -->  Z=kbhit()?getch():0
        write   -->  putchar(7[o])
        system  -->  nothing

Also add the following to trap Ctrl-C:

        #include <signal.h>
        signal(SIGINT, SIG_IGN);

On PC/DOS you need to add ANSI.SYS to CONFIG.SYS

In *NIX the min 0 on stty is required, circa 2001
it was not required.

.
.
.

### How it works (SPOILER)

.
.
.

The l array contains the 64K memory, it is initialized with a
boot image loaded from the 'C' file, the program counter is the
c pointer, and regitser are on o[]. The main loops reads every
op-code and separates it in one of three common forms, a lot
of trinary operators selects the instruction.

        o[0] = B register   o[1] = C register
        o[2] = D register   o[3] = E register
        o[4] = H register   o[5] = L register
        o[6] = Flags        o[7] = A or accumulator

The following instructions do peripheral operation:

        76           Quits emulator
        DB 00        Reads key pressed status
        DB 01        Reads key
        DB 02        Reads byte from file (Carry=EOF)
        D3 xx        Writes byte from acc. to console
        ED ED 02     Reads sector
        ED ED 03     Writes sector

Memory addresses:

        FBFA = Low source/target direction
        FBFB - High source/target direction
        FBFC - Sector
        FBFD - Low cylinder
        FBFE - High cylinder
        FBFF - Drive.

The BIOS is tailor made for this emulator, and helps to simplify it.

Other notes:

- The 8080 runs at your computer speed divided
  between a number that I have not calculated.
- This obfuscated processor is created using
  obfuscated code produced by an obfuscated mind,
  no brains were harmed during its production,
  except those that tried to read the code.
- The original version of this code was eated
  by my C++ dog.
- I intended to make it simple to understand,
  it uses only four C keywords.
- Also I discovered that braces are very useful
  for commenting.
- Why to bother with prototypes?, every good C
  programmer can develop its C programs using
  only one function.

