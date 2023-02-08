# Best emulator

Stephen Sykes
Maxisat
Laivalahdenportti 2
00810, Helsinki
Finland
sds@maxisat.fi

## Judges' comments

For those who fondly remember their first PET, this entry will start you
down memory lane ... starting with $C000 of course!

We encourage you to try and grok the obfuscated expression on line 56,
after C pre-processor gets finished with it!

You will need to download the ROM contents to use the emulator in PET
mode.

        wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-c000.901465-01.bin
        wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-d000.901465-02.bin
        wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/edit-2-n.901447-24.bin
        wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/kernal-2.901465-03.bin

        dd bs=2k count=1 if=/dev/zero of=nullfill.bin

        cat basic-2-c000.901465-01.bin basic-2-d000.901465-02.bin edit-2-n.901447-24.bin nullfill.bin kernal-2.901465-03.bin >pet.rom

### To build

        cc -o sykes sykes.c -lcurses

### To run

        sykes binary_file

### Author's comments

This program is not only a complete 6502 processor emulator, but also an
emulation of the Commodore PET 2001.

This is the second version of the same entry, but this one takes care to
not include any possibly copyrighted items in the info files, to be sure
to not infringe the rules.

### Test

Compile the program, then test the 6502 emulation like this:

        ./prog 6502test

A basic test is done for each instruction and addressing mode, all tests
should pass. At the end of the tests, it loops forever - break out with
control-C.

### PET EMULATION

Cast your mind back to 1977... a little company called Commodore
introduced the "PET", the Personal Electronic Transactor.

The machine was a hit, and history was made.

Now you can re-live those wonderful times with this PET emulator!

To emulate the PET, you must download the pet rom. Use the script
provided (fetchrom), it will fetch the parts from right place, and will
compile it into the file pet.rom.

Or if you don't have wget, navigate to here:

   <http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/>
   
and fetch the files basic-2-c000.901465-01.bin,
basic-2-d000.901465-02.bin, edit-2-n.901447-24.bin,
kernal-2.901465-03.bin. Concatenate them in that order into one pet.rom
file, adding a 2048 byte filler in between the edit-2 and kernal-2
files. The resulting file should be 16384 bytes.

Make sure you have a terminal window of 40x25 chars or bigger, and then
run the emulator like this:

        ./prog pet.rom

You should see the startup message. Try typing in some BASIC - for
instance:

        PRINT "HELLO, WORLD"

There is an optional numeric parameter, which controls the speed. For a
slower cursor blink, try

        ./prog pet.rom 6

and for faster

        ./prog pet.rom 2

the default is 4.

The control keys are as follows:

        ^A HOME
        ^L CLR
        ^R RVS
        ^E OFF
        ^Y INST
        ^X STOP (break)
        ^F cursor forward
        ^B cursor back
        ^N cursor down

Supplied also is a short demo program written in BASIC. Try typing

        LOAD "DEMO"
        RUN

Many other old programs will run in this emulator too. Files with a .PRG
extension should work. (Look, for instance, here:
<http://www.zimmers.net/anonftp/pub/cbm/pet/ALLFILES.html>, 
or try this one: <http://www.zimmers.net/anonftp/pub/cbm/pet/games/english/dungeon.prg>) 
The filenames must be upper case in order to be loaded by the emulator.

You can save programs too - try

        10 PRINT "HELLO!"
        SAVE "HELLO"
        NEW

        LOAD "HELLO"
        RUN

You also might try typing this to see an ancient easter egg:

        WAIT 6502,12

### 6502 EMULATION

The program is basically a 6502 emulator, and it does NOT need the
commodore rom to work.

Supplied as a demonstration is a compiled-for-6502 version a chess
program (heh, I found a use for a previous losing entry :). Try:

        ./prog chess

It works as you would expect (it plays very badly). There's no castling
or en-passant, and to win you must actually take the opponent's king.

You can write your own programs too, any 6502 assembler should work.

The emulator loads the supplied file at $C000, and starts execution from
that address also (the reset vector is ignored).

The screen memory begins at $8000, and is 40 columns * 25 rows.
Keypresses appear when they occur in memory location $A2, and are OR'd
with $80 - this is a way of indicating a fresh character. The program
can frequently check this byte, and when it sees a new character, it can
AND it with $7F to indicate that it has been read.

The 6502 emulator receives an interrupt 60 times a second or so, you may
want to disable interrupts (with SEI) if you do not need this.

In 6502 emulation mode the special PET character codes are not used and
the screen understands normal ASCII.

Lastly, the before emulation starts, the low byte from a time() call is
placed at address 0 - this can be used as a random seed.

### Technical description

Most of the program comprises the 6502 emulator. Curses is used for the
screen and keyboard handling.

Much of the obfuscation comes from the need to squeeze in the 6502
emulation as well as faking enough of the PET hardware for it to work.

If the supplied file is exactly 16384 bytes, the emulator assumes it is
a PET rom, and goes into PET emulation mode. Otherwise some PET specific
features are skipped during normal 6502 emulation.

The main processing all happens in a heroic expression containing no
less than 64 ternery operators (after cpp) starting on line 56. This
decodes the 6502 instructions according to a table and executes them.

The addressing mode is decoded in a similar expression starting on line
53.

### Bugs

The machine emulated is an older 40 column PET, so 80 column programs
will not show correctly.

There is no emulation of PET graphics characters.

The parameter controls the speed of the 60Hz "jiffy clock", and not the
processor speed. This means many games may run too fast to be usable -
it really depends on the speed of your machine.

Although the PET emulator can do LOAD and SAVE, it cannot VERIFY or OPEN
and CLOSE files.

The PET hardware emulation is not at all complete - features such as the
hardware timers are completely missing. Some programs will not run
correctly.

The 6502 emulation does not include the seldom used decimal mode, or any
of the "undocumented" instructions.

### IMPORTANT NOTE

I think it is great fun to run the PET emulation and mess around with
Microsoft BASIC. However, this obviously needs the rom file to work. My
program is original and completely free of any copyright, but, of
course, the pet rom is not my work. So I ask the user to download it
from the internet.  This is to avoid directly infringing any copyright.

### Finally

What does this do?

        ./prog pet.rom -1
        
Have fun!
