## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/straadt - Prize in sound coding](https://www.youtube.com/watch?v=QYFXRvt0VJo)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./prog
```

and then play the resulting `prog.wav` using a sound player.


## Judges' remarks:

When you run the program, after several moments, a `prog.wav` sound file is produced.

Using a sound player (you may find `sox(1)` is a good choice), you may enjoy the result.

Can you figure out how it produces the various layers of instruments?


## Author's remarks:


### Obfuscations

 - "Helpful" formatting
 - Character salad
 - Loop exit trying to hide by a switch statement
 - Strong string encryption. By that I mean "fmt"=>"gnu".
 - A `/*{*/` that throws off bracket matching in vim. Begun the editor wars
   have! (Wait, I'm **on** the vim-team!)
 - `cm` and `ap` stands for "allpass" and "comb", respectively.
 - One effect was created with deliberate "memory corruption".

To encourage tinkering I've obfuscated the song data and program (see Y()) less
than the "library code". Sorry if you wanted to tinker with the library code!

### Sound quality

The sample rate of prog.wav is 256kHz because creating aliasing-free waveforms
would require more code, but you can always oversample the audio and pass the
anti-aliasing problem on to the audio player :-) However, the downsampler in my
`mplayer(1)` is poor, but you can use the high-quality resampler in `sox(1)` to create a
48kHz version:

``` <!---c--->
    sox prog.wav -r 48000 prog.48kHz.wav
```

### Tricks (the condescending part)

 - Kick drum from sines, pitched up to create toms.
 - Roland TR-808 style hi-hats (a bunch of high-pass filtered square waves).
 - SID/C64-style snare drum (oscillates between noise and square wave).
 - There's some FM synthesis in the bass.
 - Schroeder reverberator a la Freeverb. The same building blocks are used for
   the echo effect.
 - Waveshaping/overdrive using tanh(x), ohh yeaaah..

I used this Python snippet to generate `q0[2]` and `q0[3]`:

``` <!---python-->
    def X(s): print(hex(int(s.replace("x","1").replace(".","0")[::-1],2))) # not for iopcc-use
    X(".x.x..xx.x.xx.xxx.xx.xxx..xx.xxx")
    X("x.xx.x.x.x.xxxxxx.xx.xxx.xxxxxxx")
```


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
