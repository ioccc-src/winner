Award: Who won award

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog columns lines
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This program is definitely bigger on the inside than the outside.
Can you find out where the volume of output comes from in the
[prog.c source code](%%REPO_URL%%/2025/jingp49/prog.c)?


### A fun challenge

Create an alternative form of [prog.c](%%REPO_URL%%/2025/jingp49/prog.c) (i.e., `prog.alt.c`)
so that video displays **IOCCC 2025** instead of **DOCTOR WHO**.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### 1963 Doctor Who title sequence

This is an ASCII animation resembling the 1963 Doctor Who title sequence.


#### How to run

``` <!---sh-->
    ./prog width height
```

The first argument after "./prog" should a positive integer that
is smaller than your terminal width (in characters), and the next
argument being positive integer smaller than your terminal height (in
characters). Please do not enter a negative number.

It's recommended that the width to be at least 120 characters and height
to be at least 30 characters for a clearer animation. Also, the program
assumes the terminal to be a "black background" and "white text" one,
please flip the ASCII brightness map if you are using a terminal with a
"light color background. and "dark color text". Lastly, the terminal
must support ANSI escape codes to work properly.


#### Overview

From 1963 to 1973, the title sequences in the BBC Sci-Fi show Doctor Who
was made using a technique called "HowlRound" effect, which is done by
pointing a camera to its output. This program simulates the "HowlRound"
effect by first scanning a portion of the screen buffer, enlarging it and
storing it into a temporary buffer same size as the screen buffer, then
copy everything back into the screen buffer, resulting in a continuous
video feedback.


#### Obfuscations and Features

- Box shaped formatting (possibly caused by a broken chameleon circuit)
- "while loop" instead of "for loop" for output and scanning buffers
- "for loop" instead of "while loop" for the animation's main loop
- Uninitialized variable instead of `time(0)` for `srand(t)` seed (`time(0)` unusable during time travel flight)
- "prog.c" does not appear bigger on the inside upon opening it


#### Warnings

- Flickering on the screen may not be suitable for people with photosensitive epilepsy


#### Portability

This code is tested on :
- Ubuntu 24.04.3 LTS on Windows 10 x86_64
- Debian GNU/Linux 12 (BookWorm) x86_64

This code is NOT tested on :
- TT capsule computer system


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
