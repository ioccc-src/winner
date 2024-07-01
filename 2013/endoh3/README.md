## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2013/endoh3 in bugs.html](../../bugs.html#2013_endoh3).


## To use:

``` <!---sh-->
    ./endoh3
```

This program plays sound. See [FAQ 3.10 - How do I compile and use an IOCCC
entry that requires sound?](../../faq.html#sox) if you do not know how to set your
system up for this or if you want to verify that everything is oky.


## Try:

``` <!---sh-->
    ./try.sh

    ./try.sh ABC

    ./try.sh test.abc yankee.abc

    ./try.sh *.abc
```

The script will check for SoX first and next `padsp` from `PulseAudio` and
finally if neither are found if you have `ruby(1)` installed it'll use the
included ruby script to convert it to a WAV file for you to play.

If no args are passed to the script it will play [twinkle.abc](%%REPO_URL%%/2013/endoh3/twinkle.abc) and
the string `ABC`. Otherwise while there's a remaining arg if it's a file it will
run the program on the file. If it's not a file it'll run it as a string.

The `*.abc` files are provided as music samples.


## Judges' remarks:

This program can toot out a tune that is small enough to posted to most social
media platforms that have small message length limits.

This endoh3ram can toot out a tune that is small enough.


### A modern day (2023) note about the award 'Most tweetable 1-liner' and twitter:

The IOCCC no longer endorses the use of what was once twitter, or whatever it
might be called today. We recommend that you pick a responsible social media
platform to post the program's output on. Nevertheless the award of this entry
will remain the same for historical purposes.


## Author's remarks:

### Remarks

This is a sound synthesizer for a subset of [ABC music
notation](http://en.wikipedia.org/wiki/ABC_notation).

Try:

``` <!---sh-->
    cc -o endoh3 endoh3.c
    echo "CDEFGABc" | ./endoh3 > /dev/dsp
```

If `/dev/dsp` is not available on your system, use an OSS sound wrapper such
as `padsp` or `aoss`:

``` <!---sh-->
    echo "CDEFGABc" | ./endoh3 | padsp tee /dev/dsp > /dev/null
```

If you are using Mac OS X, try [sox](http://sox.sourceforge.net/) like so:

``` <!---sh-->
    echo "CDEFGABc" | ./endoh3 | sox -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio
```

If that does not work, use the attached script to convert the output into a wave
file format:

``` <!---sh-->
    echo "CDEFGABc" | ./endoh3 | ruby wavify.rb > cde.wav
```

and play `cde.wav`.


You can also enjoy some music scores that I attached. With `/dev/dsp` you can
do so like:


``` <!---sh-->
    cat twinkle.abc | ./endoh3 > /dev/dsp
    cat menuet.abc | ./endoh3 > /dev/dsp
```

but you should be able to modify it a way to meet your system requirements as
described above.


### Obfuscation

The following sequence of questions may be helpful to understand the `endoh3ram`
program:

- How does it convert ABC notes into the frequency?
- What is `89/84.`?  I found it by using the [Stern-Brocot
tree](https://en.wikipedia.org/wiki/Stern-Brocot_tree).
- How does it generate a wave?  Hint: it generates a saw wave.


### Limitation

The following features are supported:

- Notes:
  - `C` `D` `E` `F` `G` `A` `B` (in low octave)
  - `c` `d` `e` `f` `g` `a` `b` (in high octave)
- Rests: `z`
- Note lengths:
  - `A` (an eighth note)
  - `A2` (a quarter note)
  - `A3` (a dotted quarter note)
  - `A4` (a half note)

The following features are *NOT* supported:

- Sharp and flat: `^C` `_C`
  - But it is possible to emit the half tones.  Do you see how?
- Shorter note lengths than 1: `C1/2`
  - But you can use `C0.5` instead.
- Higher and lower notes: `c'` `C,`
- Any meta fields: `T:title` `L:1/4`
- Bar line, repeat, ties and slurs, and everything else.


### Known Bugs

You can *NOT* write a note length immediately followed by a note `E`,
such as `C2E2`.

Can you figure out why?

A workaround is inserting a whitespace: `C2 E2`.


### Portability

I tested it on:

* Ubuntu 13.10 with gcc 4.7.3, clang 3.2, and tcc 0.9.25.
* Mac OS X 10.6 with gcc 4.2.1 and clang 1.7.

### Legal

I believe that all the scores that I attached are out-of-copyright.

I did write a score of the Happy Birthday song too.
(It does not matter because the song is out-of-copyright in my country.)
But I do not attach it to protect you from W\*\*\*\*r.

For the same reason, do not post a score that contains only `z1092`.
You know, it is ["the famous song"](http://en.wikipedia.org/wiki/4%E2%80%B233%E2%80%B3).


### Deobfuscation

Here is a magical expression which I found by brute-force:

``` <!---c-->
    (c % 32 + 5) * 9 / 5 % 13 + n / 32 * 12 - 22
```

Interestingly, it converts an ASCII number of ABC notes
to the corresponding tone number.

```
    'C' (ASCII  67) =>  3
    'D' (ASCII  68) =>  5
    'E' (ASCII  69) =>  7
    'F' (ASCII  70) =>  9
    'G' (ASCII  71) => 10
    'A' (ASCII  65) => 12
    'B' (ASCII  66) => 14
    'c' (ASCII  99) => 15
    'd' (ASCII 100) => 17
    'e' (ASCII 101) => 19
    'f' (ASCII 102) => 20
    'g' (ASCII 103) => 22
    'a' (ASCII  97) => 24
    'b' (ASCII  98) => 26
```

By the way, you can write a half-tone by the following characters.

```
    'K' =>  4 (= C#)
    'L' =>  6 (= D#)
    'U' =>  8 (= F#)
    'V' => 11 (= G#)
    'P' => 13 (= A#)
```

Note that the tone numbers simply enumerate the semi-tone steps.  So we can
calculate the frequency easily: `pow(2, n / 12.0)`.  Then, how can we calculate
`pow` without `math.h`?  `pow(2, 1.0 / 12.0)` is approximated by `89/84.`.  (I
found this approximation by using the [Stern-Brocot
tree](http://en.wikipedia.org/wiki/Stern%E2%80%93Brocot_tree).) We can gain the
frequency by multiplying the value by `n` times.

Finally, the following code generates a saw wave:

``` <!---c-->
    for(c = 0; c < len; c++) putchar(a = n * D);
```

where `D` is a frequency and `a` is a variable whose type is `char`.  By
assigning `float` to `char` variable, the implicit type conversion is performed
from `float` to `char` (modulo 256).

(Strictly speaking, this behavior is undefined according to 6.3.1.4 in C99; you
can replace it with `(long)(n*D)` if you are pedantic.)

All that was left was to combine and condense the components.  The key is
squashing them into just one `for`-loop.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
