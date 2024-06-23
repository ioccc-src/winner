## To build:

``` <!---sh-->
    make
```

There is an alternate version that will theoretically work with Windows
compilers (if anything in Windows works :-) ). See the [Alternate
code](#alternate-code) section below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: known bug - please help us fix
```

For more detailed information see [2014/vik in bugs.html](../../bugs.html#2014_vik).


## To use:

``` <!---sh-->
    echo foo | ./prog > audio_file.raw

    echo foo | ./prog | mplayer -demuxer rawaudio -
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The alternate code, [prog.alt.c](%%REPO_URL%%/2014/vik/prog.alt.c), is based on the author's
instructions on how to get it to work with Windows.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above as well as below.


## Judges' remarks:

This program sets a new tone for obfuscation. But do you understand
what it says about obfuscation? Perhaps:

``` <!---sh-->
    ./prog < prog.c > prog.raw
```

might speak to your coding style? If not, then perhaps:

``` <!---sh-->
    ./prog < README.md | mplayer -demuxer rawaudio -
```

might help? :-)


## Author's remarks:

### Remarks

This program converts ASCII text to Morse audio file and vice versa. As far as
I can tell, there are at least six chocolate references in this program.

This program can convert text to Morse to a raw 44.1kHz stereo audio file.
Via streaming to `mplayer(1)`, you can listen to the Morse audio.

Don't forget the last '`-`' as it makes `mplayer(1)` read from `stdin`.


## Convert audio file with Morse signals to text

``` <!---sh-->
    ./prog e < audio_file.raw
```

or alternatively pass a .wav file as input.

The preferred input format 44.1kHz stereo, but it does a decent job on mono
input and different frequencies as well.


### Portability

The program is portable to most platforms. The only system dependency is that
the program relies on writing binary data to `stdout`.

Microsoft compilers add a carriage return to newlines, and to compile the
program with this platform, the following line can be added to `main()` before
any code in order for the program to run correctly:

``` <!---c-->
    _setmode(_fileno(stdout), 0x8000);
```

NOTE: see the [alternate code](%%REPO_URL%%/2014/vik/prog.alt.c) for this.


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


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
