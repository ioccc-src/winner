# Most sound

Daniel Vik  
<daniel@vik.cc>  
<http://www.danielvik.com>  


## To build:

```sh
make
```


## To run:

```sh
./vik file.mod > audio_file.raw
```

An alternate version for Windows is available. See the Alternate code section
below.

### INABIAF - it's not a bug it's a feature! :-)

The author stated that the program will crash if no argument is passed tot he
program though we note that your computer might also [halt and catch
fire](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire_(computing)) :-)


## Try:

```sh
./vik randowan.mod | mplayer -demuxer rawaudio -
./vik mad_world.mod | mplayer -demuxer rawaudio -
```

Alternatively, you can use:

```sh
./vik file.mod > file.raw; ./raw2wav file.raw > file.wav 
```

It is possible to download a number of Mod files from [The Mod
Archive](http://modarchive.org).


### Alternate code:

Assuming that `make` is similar enough try:

```sh
make alt

```

Use `vik.alt` as you would `vik` above.


## Judges' remarks:

This entry converts .MOD audio files to a playable stream
in a most pleasing manner if you don't like tremolo or vibrato.

Also it abuses the C compiler and/or assembler with a partially
initialized 32MB array. Can you tell what that partial
initialization for?

Does it take your system a long time to compile?  You may want to do try:

```sh
cc -S vik.c
```

and to examine the resulting assembly file vik.s.  On some platforms
the assembly file is about 128MB in size!

NOTE: The [randowan.mod](randowan.mod) and [mad_world.mod](mad_world.mod) files were
created by [Henrik Bertilsson](http://www.translucentboy.com) and are included
with his permission.


## Author's remarks:

### Introduction

In 1987, [Karsten
Obarski](http://www.vgmpf.com/Wiki/index.php?title=Karsten_Obarski) [changed the
way](https://en.wikipedia.org/wiki/Ultimate_Soundtracker) music was handled in games and
demos with the introduction of the MOD file format on [Commodore
Amiga](https://en.wikipedia.org/wiki/Amiga)

A MOD file contains a set of samples, a number of patterns indicating how and
when the samples are to be played, a list of what patterns to play in what
order, and a number of effects.

### Features

This program converts MOD files created  with the standard trackers for
Amiga, e.g. Pro Tracker, Noise Tracker and Sound Tracker to raw 16 bit
44.1kHz stereo audio. The program supports MOD music with 4, 6, and 8
channels MOD files with up to 31 samples.

The MOD format includes many effects for each audio channel and this
program supports most of them, including:

* Arpeggio
* Slide and fine slide up/down/to note
* Set sample offset
* Volume slide
* Pattern break
* Filter on/off
* Set volume
* Cut sample
* Delay sample
* Delay pattern
* Set speed

Due to size constraints tremolo and vibrato is not supported. Also, to
avoid infinite long songs, the position jump feature is ignored.

### Songs

With his permission, the package includes two songs composed by Henrik
Bertilsson, also known as Deelite:

1. Mad World
2. Randowan


### Build

Compiling for Unix systems (including cygwin) is straight forward:

```sh
gcc -o vik vik.c
```

### Usage

### Convert MOD file to raw 44.1kHz stereo audio file

```sh
./vik mad_world.mod > audio_file.raw
```

### Listen to the MOD file (streaming to mplayer)

```sh
./vik randowan.mod | mplayer -demuxer rawaudio -
```

(Don't forget the last `-` as it makes mplayer read from stdin.)

### Obfuscation

The IOCCC rules did not put a limit on the entropy of the source code,
and it appears that the general entropy rules don't apply. An estimate
is that the code density entropy of this entry is `~1.2` which means that
there are around 2500 characters of code carrying information, yet there
are only 2037 IOCCC characters of actual code. Most of the additional
characters are encoded with non-counting characters in the frequency
table. But there are also `~50` or so white space characters spread out
through the source code that carry information.

The use of macros certainly adds to the obfuscation but the reason for
using them is mainly to fit as many features as possible within the size
limits. So please excuse the use of them.

Once the preprocessor is run, the code gets more interesting. The MOD player is
basically a register based [state
machine](https://en.wikipedia.org/wiki/Finite-state_machine) and all the
[magic][] is hidden in a fog of short statements. Many of the register updates
are conditional and the program uses the `?:` operator (sigh) mainly to save
space, but also to leverage the comma operator and precedence more efficiently.

[magic]: https://en.wikipedia.org/wiki/Magic_(programming)#Variants

### Portability

The program is portable to most platforms. The only system dependency is
that the program relies on writing binary data to stdout.

Microsoft compilers adds a carriage return to newlines, and to compile
the program with this platform, the following line can be added after
the main declaration in order for the program to run correctly:

```c
_setmode(_fileno(stdout), 0x8000);
```

### Limitations

The program only runs when a valid MOD file is passed as argument. If
no argument is passed, the program crashes.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
