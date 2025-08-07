## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/mills - Prize in ℤ₃](https://www.youtube.com/watch?v=sXdTonHUN8s)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog foo.z3 foo.sav
```

The `foo.z3` is an [Infocom][2] version 3 [Z-machine][3] file,
and `foo.sav` is file that is written when you enter the command `SAVE`
and read when you enter the command `RESTORE`.


## Try:

``` <!---sh-->
    ./try.sh

    For your first try, we suggest selecting games 0 or 1
```


## Alternate code:


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./try.alt.sh

    For your first try, we suggest selecting games 0 or 1
```


## Judges' remarks:

What is the "**Prize in ℤ₃**"?  The "_double-struck Z_" is **NOT**
a reference to a set of integers, nor is the "_double-struck Z subscript
3_" a reference to a ring of 3-adic integers.  Instead, it is a reference
to the 3rd version of a certain [virtual machine](https://en.wikipedia.org/wiki/Z-machine).

To fully appreciate the brilliance of this implementation, we suggest
illuminating the source code. But be careful not to get lost in the
labyrinthine twists and turns of this source code and get eaten by a Grue!


## Author's remarks:


### West of House

```
    You are standing in an open field west of a white house, with a boarded
    front door.

    There is a small mailbox here.
```

These are the opening lines from the legendary [Zork][1], one of the most
influential and successful games of the early computer era.  You can play a
demo version with the submitted program using the following command:

``` <!---sh-->
    ./prog minizork.z3 minizork.sav
``` <!---sh-->

_Minizork_ is a publicly-available demo version of the original _Zork_, but
the program can play any of the classic [Infocom][2] text adventure games that
run on the version 3 of the [Z-machine][3], a [virtual machine][4] which
Infocom used to run its mainframe-developed games on the 8-bit microcomputers
of the 1980's.

Although there were several iterations of the Z-machine, this program
implements version 3, which was used for dozens of Infocom's most famous and
influential [interactive fiction][5] games of the 1980's, including:

 - The _Zork_ Trilogy (_Zork I_, _Zork II_ and _Zork III_) and the related
   Enchanter Trilogy (_Enchanter_, _Sorcerer_ and _Spellbreaker_)
 - The _Planetfall_ series (_Planetfall_ and _Stationfall_)
 - _The Hitchhiker's Guide to the Galaxy_ (by Douglas Adams)
 - _The Lurking Horror_ (Lovecraftian horror)
 - _Plundered Hearts_ (romance)
 - _Leather Godesses of Phobos_ (best left unsaid)

If you are new to interactive fiction, you might want to try one of the two
Infocom "four-in-one" demo samplers.  These include a gentle introductory
tutorial to interactive fiction and some sample puzzles from _Zork I_,
_Planetfall_, _Infidel_, _The Witness_, _Trinity_ and _Leather Godesses of
Phobos_.  You can run them by typing:

``` <!---sh-->
    ./prog sampler1_R55.z3 sampler1.sav
```

or

``` <!---sh-->
    ./prog sampler2.z3 sampler2.sav
```

In addition to the Infocom games, there is an entire community of interactive
fiction authors who write modern games which can be downloaded from sites
like [The Interactive Fiction Database][6], [The Interactive Fiction Wiki][7],
and [The Interactive Fiction Archive][8].  I've included a few "story files"
compiled for the Z3 machine from these sites for your enjoyment, but I'll
point out in particular [Curses][9] by Graham Nelson, the author of
[Inform][10], a literate programming system for writing interactive fiction.
You can of course run it with

``` <!---sh-->
    ./prog curses-r10.z3 curses.sav
```

By now you've probably figured out that `prog` takes two command-line
arguments, the first being the "story file" which is the game itself, and
the second (optional) parameter being the "save file", which is the file
the game will write if you type `SAVE` and read if you type `RESTORE`.
The second parameter is optional, but if you don't use it, you won't be able
to `SAVE` your game (think of this as an "Ironman" mode).  Make sure that if
you switch story files, you also switch save files, because a `RESTORE` from
an unrelated story file will invoke what the C Standard Committee refers to
as ["Undefined Behavior"][22].

You can use this command-line template to run any other "version 3" games you
find, including the original Infocom ones.  If you are lucky, you can find
the original files in one of the (sadly out-of-print) collections like
[The Lost Treasures of Infocom][11], or you could download a copy of the
[Zork Trilogy][12] (which was given away free as part of an Activision
promotion long ago).  There are of course other places one might find Infocom
story files, but since they are not in the public domain I cannot give
pointers to them.  Maybe Microsoft will decide to release them from
abandonware status now that they have bought Activision...

Finally, I have also included a copy of [Colossal Cave Adventure][13], which
may be better known by it's PDP-10 file name _ADVENT_.  You can run it with

``` <!---sh-->
    ./prog advent.z3 advent.sav
```

_ADVENT_ is the original interactive fiction title by Crowther and Woods that
inspired _Zork_ and gave us hacker shibboleths like [Xyzzy][14] and "You are
in a maze of twisty little passages, all alike."


### It is pitch black. You are likely to be eaten by a grue.

So what makes the Z3 machine an interesting obfuscation target?  Good question!

The IOCCC has seen all manner of virtual machines over the years, from
Commodore PETs to IBM PC's that can run Windows&trade; and even a mainframe or
two, so what is so challenging about a VM that ran on the TRS-80 and the
Apple II?

Well, a lot really.  If you've got nothing better to do, take a look at the
[Z-Machine Standards Document][15] which is a detailed reverse-engineering
effort of Infocom's interpreter.  A Z-machine implementation has to handle
the byte-code for an exceptionally complicated byte-code interpreter, which
in turn has to do a lot of high-level operations such as:

- Text encryption, decryption and decompression using a packed 5-bit modal
  encoding and tables of "abbreviations"
- Lexical input parsing and mapping words through a compressed dictionary
  and a "word separator" table
- Screen output that includes automatic word-wrapping and a status line
  that shows the current room, number of moves and score (or current time,
  for timed games like _Deadline_).
- Maintaining an "Object tree" that holds the state of the objects in the
  game, their containment relationships, _attributes_ (openable, open, worn,
  concealed, locked, etc.) and _properties_ (name, description, capacity,
  exits, methods, etc.)
- Support for "virtual memory" -- the virtual machine's address space was
  larger than the 16-bit addressing of the computers of the era, and certainly
  larger than the 32 kilobytes of physical memory.  These restrictions require
  the interpreter to deal with multiple types of addresses to get at the
  different types of storage.
- File I/O for saving, restoring and restarting the game.
- Dynamic memory areas such as the "header" and various other tables that
  are used as sideband global communication between the interpreter and the
  story file.  Either or both can change the state, so it needs to be
  explicitly checked.
- An exceptionally [CISC][16]-like variable-length bytecode with variadic
  parameters and complicated encodings.

The interpreter is complicated because of the Herculean task the _Zork_
implementors set for themselves.  _Zork_ itself was originally written on a
PDP-10 mainframe at MIT running a version of Lisp called [MDL][17].  It was
designed to have a more natural parser than the two-word parser of _ADVENT_.
_Zork_ itself escaped into the wild because of MIT's connection to
[ARPANET][18].  Contributions and requests from the player-base caused the
program to grow in size until it filled the mainframe's megabyte of memory.
When the newly-founded Infocom decided to port their grad-school project to
the world of microcomputers, they needed to somehow move a megabyte of MDL
code onto 8-bit microcomputers with 32 kilobytes of memory.  They got there by
chopping the program into three separate parts, creating a stripped-down
subset of MDL called [ZIL][19] (for Zork Implementation Language) and
targeting the compiled ZIL bytecode to run on the Z-machine interpreter.  The
Z-machine data types were specifically designed to reduce the memory footprint
as much as possible (including packed properties and compressed string
encodings) but the ZIL code was still too large (at over 100 kilobytes), so
the interpreter was designed to page in parts of the story file from the
floppy disk, one of the first uses of [virtual memory][20] on personal
computers.

All of the above was described in a much clearer fashion by Infocom employees
in a paper called [How to Fit a Large Program into a Small Machine][21],
which I only discovered after writing the previous paragraph, alas.  I include
it here for the curious, because you can never have enough links in your
IOCCC write-up.


### A hollow voice says "Fool."

It took me many iterations to make the interpreter fit inside the IOCCC size
limits.

The original quite compact C program was maybe still 50% too large even after
doing as much minification as possible.  I won't go into the details of the
next iterations of reduction (that would spoil all the fun), but suffice to
say, the steps I took share some similarities to the steps the _Zork_
implementors took to do their heroic reduction.  It was only by completely
throwing out any attempt to make the source code look "pretty" was I able to
cross the `iocccsize` Rule 2b limitation of 2,053, and this included abusing
the whitespace rules.

Of course, by time the contest was announced, the size limit had increased
which means I had to go back and undo some of my heroics because now I had
enough wiggle room to make the source more picturesque.  I have however
included a version of the original source (`prog.alt.c`) for your perusal and
amusement.

 [1]: https://en.wikipedia.org/wiki/Zork                 "Zork"
 [2]: https://en.wikipedia.org/wiki/Infocom              "Infocom"
 [3]: https://en.wikipedia.org/wiki/Z-machine            "Z-machine"
 [4]: https://en.wikipedia.org/wiki/Virtual_machine      "Virtual machine"
 [5]: https://en.wikipedia.org/wiki/Interactive_fiction  "Interactive fiction"
 [6]: https://ifdb.org                                   "IFDB"
 [7]: https://www.ifwiki.org                             "IFWiki"
 [8]: https://www.ifarchive.org                          "IFArchive"
 [9]: https://ifdb.org/viewgame?id=plvzam05bmz3enh8      "Curses"
[10]: https://ganelson.github.io/inform-website          "Inform 7"
[11]: https://en.wikipedia.org/wiki/The_Lost_Treasures_of_Infocom
      "The Lost Treasures of Infocom"
[12]: http://www.infocom-if.org/downloads/downloads.html "Zork Trilogy"
[13]: https://en.wikipedia.org/wiki/Colossal_Cave_Adventure
      "Collosal Cave Adventure"
[14]: https://en.wikipedia.org/wiki/Xyzzy_(computing)    "Xyzzy"
[15]: https://www.inform-fiction.org/zmachine/standards  "Z-Machine Standards"
[16]: https://en.wikipedia.org/wiki/Complex_instruction_set_computer "CISC"
[17]: https://en.wikipedia.org/wiki/MDL_(programming_language) "MDL"
[18]: https://en.wikipedia.org/wiki/ARPANET              "ARPANET"
[19]: https://www.ifwiki.org/ZIL                         "ZIL"
[20]: https://en.wikipedia.org/wiki/Virtual_memory       "Virtual Memory"
[21]: https://mud.co.uk/richard/htflpism.htm             "ZIL paper"
[22]: https://en.wikipedia.org/wiki/Undefined_behavior   "Undefined Behavior"


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
