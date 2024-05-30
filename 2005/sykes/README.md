## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2005/sykes in bugs.html](../../bugs.html#2005_sykes).


## To use:

``` <!---sh-->
    ./sykes binary_file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

For those who fondly remember their first
[PET](https://en.wikipedia.org/wiki/Commodore_PET), this entry will start you
down memory lane ... starting with `$C000` of course!

We encourage you to try and grok the obfuscated expression on [line
56](%%REPO_URL%%/2005/sykes/sykes.c#L56),
after the C pre-processor gets finished with it!

We downloaded the [ROM](https://en.wikipedia.org/wiki/ROM_image) contents to use
the [emulator](https://en.wikipedia.org/wiki/Emulator) in
[PET](https://en.wikipedia.org/wiki/Commodore_PET) mode as follows:

``` <!---sh-->
    wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-c000.901465-01.bin
    wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-d000.901465-02.bin
    wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/edit-2-n.901447-24.bin
    wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/kernal-2.901465-03.bin
```

We then created:

``` <!---sh-->
    dd bs=2k count=1 if=/dev/zero of=nullfill.bin
```

For your convenience, we have added the above mentioned files to this entry directory.
They were used to form the `pet.rom` file.


## Author's remarks:

This program is not only a complete [Motorola 6502
processor](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulator](https://en.wikipedia.org/wiki/Emulator), but also an emulation of the
[Commodore PET 2001](https://en.wikipedia.org/wiki/Commodore_PET).

This is the second version of the same entry, but this one takes care to
not include any possibly copyrighted items in the info files, to be sure
to not infringe the rules.


### Test

Compile the program, then test the
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulation](https://en.wikipedia.org/wiki/Emulator) like this:

``` <!---sh-->
    ./sykes 6502test
```

A basic test is done for each instruction and addressing mode, all tests
should pass. At the end of the tests, it loops forever - break out with
control-C.


### PET EMULATION

Cast your mind back to 1977... a little company called
[Commodore](https://en.wikipedia.org/wiki/Commodore_International) introduced
the [PET](https://en.wikipedia.org/wiki/Commodore_PET), the Personal Electronic
Transactor.

The [machine](https://en.wikipedia.org/wiki/Computer) was a hit, and
[history](https://en.wikipedia.org/wiki/History) was made.

Now you can relive those wonderful times with this
[PET](https://en.wikipedia.org/wiki/Commodore_PET) emulator!

Make sure you have a [terminal
window](https://en.wikipedia.org/wiki/Terminal_emulator) of 40x25 chars or
bigger, and then run the emulator like this:

``` <!---sh-->
    ./sykes pet.rom
```

You should see the startup message. Try typing in some
[BASIC](https://en.wikipedia.org/wiki/BASIC) - for instance:

```
    PRINT "HELLO, WORLD"
```

There is an optional numeric parameter, which controls the speed. For a
slower cursor blink, try

``` <!---sh-->
    ./sykes pet.rom 6
```

and for faster

``` <!---sh-->
    ./sykes pet.rom 2
```

The default is 4.

The control keys are as follows:

```
    ^A HOME
    ^L CLR
    ^R RVS
    ^E OFF
    ^Y INST
    ^X STOP (break)
    ^F cursor forward
    ^B cursor back
    ^N cursor down
```

Supplied also is a short demo program written in
[BASIC](https://en.wikipedia.org/wiki/BASIC). Try typing

```
    LOAD "DEMO"
    RUN
```

Many other old programs will run in this emulator too. Files with a `.PRG`
extension should work.  Look, for instance, here:

[http://www.zimmers.net/anonftp/pub/cbm/pet/ALLFILES.html](http://www.zimmers.net/anonftp/pub/cbm/pet/ALLFILES.html)

or try this one:

[http://www.zimmers.net/anonftp/pub/cbm/pet/games/english/dungeon.prg](http://www.zimmers.net/anonftp/pub/cbm/pet/games/english/dungeon.prg)

The filenames must be upper case in order to be loaded by the emulator.

You can save programs too - try

```
    10 PRINT "HELLO!"
    SAVE "HELLO"
    NEW

    LOAD "HELLO"
    RUN
```

You also might try typing this to see an ancient [Easter egg][]:


```
    WAIT 6502,12
```

[Easter egg]: https://en.wikipedia.org/wiki/Easter_egg_(media)#Software

### 6502 EMULATION

The program is basically a
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulator](https://en.wikipedia.org/wiki/Emulator), and it does NOT need the
[Commodore](https://en.wikipedia.org/wiki/Commodore_PET)
[ROM](https://en.wikipedia.org/wiki/ROM_image) to work.

Supplied as a demonstration is a
compiled-for-[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
version a chess program (heh, I found a use for a previous losing entry :) ). Try:

``` <!---sh-->
    ./sykes chess
```

It works as you would expect (it plays very badly). There's no castling
or en-passant, and to win you must actually take the opponent's king.

You can write your own programs too, any [6502
assembler](https://en.wikibooks.org/wiki/6502_Assembly) should work.

The [emulator](https://en.wikipedia.org/wiki/Emulator) loads the supplied file
at `$C000`, and starts execution from that address also (the reset vector is
ignored).

The screen memory begins at `$8000`, and is `40 columns * 25 rows`.
Key presses appear when they occur in memory location `$A2`, and are
[OR](https://en.wikipedia.org/wiki/Bitwise_operation#OR)ed
with `$80` - this is a way of indicating a fresh character. The program
can frequently check this byte, and when it sees a new character, it can
[AND](https://en.wikipedia.org/wiki/Bitwise_operation#AND) it with `$7F` to
indicate that it has been read.

The
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulator](https://en.wikipedia.org/wiki/Emulator) receives an interrupt 60
times a second or so, you may want to disable interrupts (with the `SEI`
instruction) if you do not need this.

In
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulation](https://en.wikipedia.org/wiki/Emulator) mode the special
[PET](https://en.wikipedia.org/wiki/Commodore_PET) character codes are not used and
the screen understands normal
[ASCII](https://en.wikipedia.org/wiki/ASCII#Character_set).

Lastly, before [emulation](https://en.wikipedia.org/wiki/Emulator) starts,
the low byte from a `time(3)` call is placed at address 0 - this can be used as a
random seed.


### Technical description

Most of the program comprises the
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulator](https://en.wikipedia.org/wiki/Emulator). `curses` is used for the
screen and keyboard handling.

Much of the obfuscation comes from the need to squeeze in the
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulation](https://en.wikipedia.org/wiki/Emulator) as well as faking enough of
the [PET](https://en.wikipedia.org/wiki/Commodore_PET) hardware for it to work.

If the supplied file is exactly 16384 bytes, the
[emulator](https://en.wikipedia.org/wiki/Emulator) assumes it is a
[PET](https://en.wikipedia.org/wiki/Commodore_PET)
[ROM](https://en.wikipedia.org/wiki/ROM_image), and goes into PET emulation
mode. Otherwise some PET specific features are skipped during normal
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
[emulation](https://en.wikipedia.org/wiki/Emulator).

The main processing all happens in a heroic expression containing no
less than 64 ternary operators (after `cpp`) starting on [line
56](%%REPO_URL%%/2005/sykes/sykes.c#L56).
This decodes the
[6502](https://en.wikipedia.org/wiki/MOS_Technology_6502#Technical_description)
instructions according to a table and executes them.

The addressing mode is decoded in a similar expression starting on [line
53](%%REPO_URL%%/2005/sykes/sykes.c#L53).


### Bugs

The machine emulated is an older 40 column
[PET](https://en.wikipedia.org/wiki/Commodore_PET), so 80 column programs
will not show correctly.

There is no [emulation](https://en.wikipedia.org/wiki/Emulator) of
[PET](https://en.wikipedia.org/wiki/Commodore_PET) graphics characters.

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


### IMPORTANT NOTE

I think it is great fun to run the
[PET](https://en.wikipedia.org/wiki/Commodore_PET)
[emulation](https://en.wikipedia.org/wiki/Emulator) and mess around with
[Microsoft](https://en.wikipedia.org/wiki/Microsoft)
[BASIC](https://en.wikipedia.org/wiki/BASIC). However, this obviously needs the
[ROM](https://en.wikipedia.org/wiki/ROM_image) file to work. My
program is original and completely free of any copyright, but, of
course, the `pet.rom` is not my work. So I ask the user to download it
from the Internet.  This is to avoid directly infringing any copyright.


### Finally

What does this do?

``` <!---sh-->
    ./sykes pet.rom -1
```

Have fun!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
