## To build:

``` <!---sh-->
    make
```

There is an unobfuscated version for those who wish to see the original final
prior to obfuscation. See [Alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2020/otterness in bugs.html](../../bugs.html#2020_otterness).


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```

Now play `output.mid` and `output2.mid` in an audio player that can play MIDI
files.


## Alternate code:

### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't check this version**:
just try to understand the program via the entry source.

If you get stuck, come back and take a look at the alternate, unobfuscated code,
described by the author as:

> If you're curious about the un-obfuscated program that I originally wrote,
this was the final working version. I tried to keep the functions names and
comments understandable, but it will make a lot more sense to readers familiar
with the MIDI "SMF" file format.

... at their [web page about the
entry](https://www.nathanotterness.com/2021/04/obfuscated_c_2020.html).


### Alternate use:

Use `prog.alt` as you would `prog`.


### Alternate try:

``` <!---sh-->
     ./try.alt.sh
```


## Judges' remarks:

In an entry that boasts not using literals, one would expect to see
straightforward ways to produce small integers like `!(x^x)<<!(x^x)`, etc. but
this entry is trickier than that. Deciphering what it does, apart from reading
`stdin` and writing to `stdout`, would take a while.

While doing that, you can be audibly *entertained* by a sample of its output.


## Author's remarks:

### MIDI "boots and cats"

This program seeks to automatically "improve" standard MIDI files (.mid) by
adding an extra track that provides a driving drum beat to bring some
excitement into boring video-game music rips or classical music sequences that
otherwise only see the light of day when modern musicians import them into FL
Studio to copy a few chords.


#### Prerequisites

If you're not using Windows Media Player or already familiar with MIDI files,
you may need to install some additional software to be able to listen to them.
For example, on Ubuntu, I was able to play them in VLC after installing
`vlc-plugin-fluidsynth` and `fluid-soundfont-gm`.

You can obtain MIDIs in many places, but I mostly tested the program using files
I found [here](http://www.kunstderfuge.com/beethoven/variae.htm#Symphonies).
However, as discussed under the [Limitations](#limitations) section below, not
all of them work correctly.  I will admit to having used
`http://www.kunstderfuge.com/-/midi.asp?file=beethoven/symphony_6_1_(c)cvikl.mid`
for most of my testing, see [cvikl.mid](cvikl.mid).


### Usage

Compile the program using the following command (I tested this using both
`clang` and `gcc`):

``` <!---sh-->
    cc -pedantic -Wall -Werror -Wextra -O3 -o prog prog.c
```

The program expects a MIDI on `stdin`, and writes a modified MIDI to `stdout`:

```
    ./prog <input.mid >output.mid
```

If the program encounters an error, no output will generally be produced, and
it will exit with a specific status code. Meanings of the various status codes
are listed below, under the "Program error codes" heading. On success, the
program exits with a code of 0.


### Limitations

1. The program does not support MIDI files over 4 MB (specifically, it will
not take input files larger than `2^22 - 1` bytes).  This is unlikely to be a
big limitation in practice, since even lengthy MIDIs are rarely over a
couple hundred KB.

2. Not all MIDIs set (or *correctly* set) their timing information, which will
lead to the tempo of the drum beat not matching the track.  This will be
especially true for "live performance" .mid files.

3. There may be some types of MIDI messages that the program is unable to
correctly parse, but I have rarely seen this in practice.  The largest
cause of program failures, in my experience, has been Limitation 2.

### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


#### Obfuscation notes

I had one primary goal when writing this program: include no C literals
whatsoever.  The final C file includes no numerical, string, or character
literals.  Instead, all literals have been replaced with a handful of global
variables, which are occasionally modified throughout the file to prevent
simple uses of find-and-replace.

So, in a sense, this obfuscation is simply an intentional use of global
variables' classic problem: absolute spaghetti code.  The absence of any sort
of literals has the added benefit of forcing any would-be reader to trace the
contents of many variables starting from `main()`, since, without literals, very
little of the code gives any inherent visual cues as to its purpose.

I already took the liberty of running `prog.c` through `clang-format`, since it
still fits in the size limit and the formatting of the code was never intended
to be an obfuscation technique here.


#### Other remarks

MIDI files are generally divided up into one or more "tracks" that play
concurrently.  While it is easy to find the positions of each of these tracks
in the file, figuring out the amount of time each track is supposed to play is
more difficult, and requires parsing every track in its entirety.  This means
that generating a drum beat that covers the entire piece of music requires
parsing every track (the entire file) in order to determine the longest track.

Once the program has determined the longest track in the file, it generates a
new track, containing the simple 4-note percussion sequence, to match the
length (in beats) of the longest-running track. It appends the new track onto
the end of the file, taking care to update the file header, as well.


### Program error codes

If the program encounters an error, it will exit with a nonzero code. The error
codes can be interpreted as follows:

- `1`: Encountered an invalid MIDI variable-length integer in the input.
- `2`: Attempted to write an invalid MIDI variable-length integer to output.
(This would be an internal error).
- `3`: Encountered an unsupported MIDI event in the input.
- `4`: Encountered a bad MIDI track header in the input.
- `5`: The input MIDI file uses SMPTE time division, which isn't supported.
- `6`: Failed allocating a temporary buffer to hold a single copy of our "beat"
messages.
- `7`: Failed allocating a buffer to hold the new track data.
- `8`: Failed allocating a buffer to hold the input file.
- `9`: The input file was too large.
- `10`: The input file's MIDI header was incorrect (but this isn't checked
very thoroughly).

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
