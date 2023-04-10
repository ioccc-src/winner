# Best handling of beeps

    Daniel Vik  
    <daniel@vik.cc>  
    <http://danielvik.com/>  

## To build:

```sh
make
```

## To run:

```sh
./prog > foo.c
```

## Try:

```sh
echo 'Want to hear me beep?' | ./prog > audio_file.raw

echo 'No. I want chocolate!' | ./prog | mplayer -demuxer rawaudio -
```

## Judges' remarks:

This program sets a new tone for obfuscation. But do you understand
what it says about obfuscation? Perhaps:

```sh
./prog < prog.c > prog.raw
```

might speak to your coding style? If not, then perhaps:

```sh
./prog < README.md | mplayer -demuxer rawaudio -

```

might help? :-)

NOTE: In 2020 [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) found a
minor bug when working on his [Enigma machine entry](../../2020/ferguson2); see
his [README.md](../../2020/ferguson2/README.md) for details (search for `vik`).

## Author's remarks:

### Remarks

This program converts ascii text to Morse audio file and vice versa. As far as
I can tell, there are at least six chocolate references in this program.

This program can convert text to Morse to a raw 44.1kHz stereo audio file.
Via streaming to mplayer, you can listen to the Morse audio.

Don't forget the last '-' as it makes mplayer read from stdin.


## Convert audio file with Morse signals to text

```sh
./prog e < audio_file.raw
```

or alternatively pass a .wav file as input.

The preferred input format 44.1kHz stereo, but it does a decent job on mono
input and different frequencies as well.

### Portability

The program is portable to most platforms. The only system dependency is that
the program relies on writing binary data to stdout.

Microsoft compilers add a carriage return to newlines, and to compile the
program with this platform, the following line can be added after the main
declaration in order for the program to run correctly:

```c
_setmode(_fileno(stdout), 0x8000);
```

### Known Issues

The program uses a quite simple algorithm for detecting tone on and off events
in the Morse signal. Hence the program does not work well with noisy input
signals. I have tested it with several samples of man made Morse recordings as
well as computer generated ones.

Generally, any recording from ham radio transmissions does not decode due to
noise and echoes. Other man made recordings may decode, but some characters
can be incorrect due to too big variation in length of tones and pauses.
However I found some man made recordings on that decode reasonable well.

If a recording doesn't decode, you could try to pre-process the input with a
narrow bandpass filter on the frequency of the transmission.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
