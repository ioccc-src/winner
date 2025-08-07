## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/weaver - Sur prize](https://www.youtube.com/watch?v=e1h5N6EDehg)


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
    ./try.sh
```


## Judges' remarks:


Why did this winning entry win the **Sur** prize?  As the expression goes,
"Seeing (and hearing) is believing": or at least can lead to better
understanding of the code.  :o)

In addition to the visual output, this program will attempt to use
`/usr/bin/aplay` to play a raw 8kHz/8-bit unsigned sound file (a copy
of which may be find found in the file `ref.raw`).

In case you do not hear any sound, or lack `/usr/bin/aplay`, or otherwise
cannot play a raw 8kHz/8-bit unsigned sound file: in separate window
using your favorite sound player, play the WAVE file `ref.mp3` while
you are running this code.


## Author's remarks:


### Requirements

This requires a terminal emulator that supports 24-bit ANSI colors.
These days most Linux terminal emulators do, including stock xterm
(at least on Debian).

There is sound too!  On a Debian system at least if you have `/usr/bin/aplay`
it will attempt to pipe the sound into it at the default 8kHz/8-bit unsigned.
If `aplay(1)` is not detected it will write the sound to the file `r.raw`
which you can then try to play on your sound program of choice, or if
you have a SUN machine, cat it to `/dev/audio`.


### Obfuscation

It was so hard to get this to fit in the size requirements that I stopped
obfuscating once I made it fit.

Attempts to make things look cooler or shrink things more only seemed
to make things bigger somehow.


### Background

Hopefully it's obvious what this is.  I wish I had more space, I could
have made it sneakier and also had a few more frames of animation.

It's about half animation, half music right now.  I should have optimized
the music better.

Believe it or not this is actually a rough port of an Atari 2600 version
of this program.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
