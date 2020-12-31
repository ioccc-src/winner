# Best handling of beeps

Daniel Vik  
<daniel@vik.cc>  
<http://danielvik.com/>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog > foo.c

### Try:

    echo 'Want to hear me beep?' | ./prog  > audio_file.raw

    echo 'No. I want chocolate!' | ./prog | mplayer -demuxer rawaudio -

### Selected Judges Remarks:

This program sets a new tone for obfuscation.  But do you understand
what it says about obfuscation?  Perhaps:

    ./prog < prog.c > prog.raw

might speak to your coding style?  If not, then perhaps:

    ./prog < remarks.markdown | mplayer -demuxer rawaudio -

might help? :-)

## Author's comments:
### Remarks

This program converts ascii text to morse audio file and vice versa. As far as
I can tell, there are at least six chocolate references in this program.

This program can convert text to morse to a raw 44.1kHz stereo audio file.
Via streaming to mplayer, you can listen to the morse audio.

Don't forget the last '-' as it makes mplayer read from stdin.)

## Convert audio file with morse signals to text

    $ ./prog e < audio_file.raw

or alternatively pass a .wav file as input.

The preferred input format 44.1kHz stereo,   but it does  a decent job on mono
input and different frequencies  as well.

### Portability

The program is portable to most platforms. The only system  dependency is that
the program relies on writing binary data to stdout.

Microsoft compilers adds a carriage  return to  newlines,   and to compile the
program with this platform,   the following line  can be added  after the main
declaration in order for the program to run correctly:

    _setmode(_fileno(stdout), 0x8000);

### Known Issues

The program uses a quite simple algorithm for detecting tone on and off events
in the morse signal.   Hence the program  does not work well  with noisy input
signals. I have tested it with several samples of man made morse recordings as
well as computer generated ones.

Generally, any recording from ham  radio transmissions  does not decode due to
noise and echoes.   Other man made recordings may decode,  but some characters
can be  incorrect  due to too big  variation  in length  of tones  and pauses.
However I found some man made recordings on that decode reasonable well.

If a recording don't decode,   you could try to  pre-process the input  with a
narrow bandpass filter on the frequency of the transmission.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
