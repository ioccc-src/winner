## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC29 - 2025/tompng - Most soothing](https://www.youtube.com/watch?v=aimO4cTCOyc)


## To build:

``` <!---sh-->
    make all
```


## To use:

To generate `sound.wav`:

``` <!---sh-->
    ./prog duration seed filename
```

To play the sound immediately, for example:

``` <!---sh-->
    # using sox sound player
    ./prog - | sox --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null

    # using ffplay sound player
    ./prog - | ffplay

    # using aplay sound player
    ./prog - | aplay
```

Or use your favorite sound player able to read the input from stdin.


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This entry provided a welcome relief after several grueling judging sessions.  See what the C seas, si?


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#tompng) for this winning entry.


## Author's remarks:


### Synthetic Seashore

Close your eyes. You are sitting by the ocean. Nearby, someone is playing
quiet music — the kind that makes you forget you had anywhere else to
be. The waves agree. The silence agrees. You agree.

Don't open your eyes. Once you do, you'll see something you can't unsee,
and you'll know that the beach was arithmetic, the music was probability,
and the peace you felt was born from layers upon layers of the same
forgetting, until the forgetting became a shore. And yet, all of it felt
real. The sea, for its part, does not know it doesn't exist.


#### Description

This program generates a 5-minute stereo WAV file of ocean ambiance:
layered wave sounds combined with procedurally generated music: slow,
resonant notes that settle into the sound of water as if they were always
there. Each run produces a unique result.


##### Usage

``` <!---sh-->
    ./prog duration seed filename
```

- Defaults: 300 seconds, random seed, output file `sound.wav`
- Example: `./prog 60 123 sound-60sec-seed123.wav`
- Pass `-` as the filename to write to stdout: `./prog - | ffplay -`


#### Implementation Notes

The sound of ocean waves is, at its core, the sound of countless
overlapping bubbles. This program begins with a single bubble and
repeatedly synthesizes pairs of sounds — layering them again and again
— until millions of bubbles accumulate into a wave. The same synthesis
operation drives every level of this hierarchy.

A single filter function, distinguished only by its arguments, handles
everything from bubble resonance and bandpass noise shaping to stereo
envelope tracking and musical dynamics. The layers of sound and the
layers of reuse converge on the same principle. This is, perhaps, how
the world is also made.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
