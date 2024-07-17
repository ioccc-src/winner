## To build:

``` <!---sh-->
    make
```

There is an alternate version that should work for Windows. See [alternate
code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2011/vik in bugs.html](../../bugs.html#2011_vik).


## To use:

``` <!---sh-->
    ./vik file.mod > audio_file.raw
```

If you have `mplayer(1)`:


``` <!---sh-->
    ./vik file.mod | mplayer -demuxer rawaudio -
```

Alternatively, you can convert the file to a WAV:

``` <!---sh-->
    ./vik file.mod > file.raw; ./raw2wav file.raw > file.wav
```

and then play `file.wav` with a program that can play WAV files.


## Try:

``` <!---sh-->
    ./try.sh
```

The script checks that you have `mplayer(1)` installed and if it is it will pipe
`vik` to `mplayer`. In this case it will also use `raw2wav` to convert the file
to a WAV file. If `mplayer(1)` cannot be found it will just use `raw2wav`. This
way even if one has an `mplayer(1)` that fails or is for some reason not what is
expected they can at least play the WAV file manually.

It is also possible to download a number of music module files from [The Mod
Archive](http://modarchive.org).


## Alternate code:

This version is based on the author's remarks and it should work for Windows.


### Alternate build:

Assuming that `make` is similar enough try:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `vik.alt` as you would `vik` above.


## Judges' remarks:

This entry converts .MOD audio files to a playable stream
in a most pleasing manner if you don't like tremolo or vibrato.

Also it abuses the C compiler and/or assembler with a partially
initialized 32MB array. Can you tell what that partial
initialization for?

Does it take your system a long time to compile?  You may want to do:

``` <!---sh-->
    cc -S vik.c
```

and examine the resulting assembly file `vik.s`.  On some platforms
the assembly file is about 128MB in size!

NOTE: The [randowan.mod](%%REPO_URL%%/2011/vik/randowan.mod) and [mad_world.mod](%%REPO_URL%%/2011/vik/mad_world.mod) files were
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

``` <!---sh-->
    gcc -o vik vik.c
```

### Usage


#### Convert MOD file to raw 44.1kHz stereo audio file

``` <!---sh-->
    ./vik mad_world.mod > audio_file.raw
```

#### Listen to the MOD file (streaming to mplayer)

``` <!---sh-->
    ./vik randowan.mod | mplayer -demuxer rawaudio -
```

(Don't forget the last `-` as it makes mplayer read from `stdin`.)


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
that the program relies on writing binary data to `stdout`.

Microsoft compilers adds a carriage return to newlines, and to compile
the program with this platform, the following line can be added after
the main declaration in order for the program to run correctly:

``` <!---c-->
    _setmode(_fileno(stdout), 0x8000);
```

NOTE: this is what the [alternate version](#alternate-code) is for.


### Limitations

The program only runs when a valid MOD file is passed as argument. If
no argument is passed, the program crashes.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
