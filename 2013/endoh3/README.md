# Most tweetable 1-liner

    Yusuke Endoh  
    <mame@ruby-lang.org>  
    <https://github.com/mame/>  

# To build:

```sh
make
```

### To run:

```sh
./endoh3
```

### Try:

Trying this out will depend on how your system can play sounds. The author's
remarks include some options for different operating systems.

The simplest way is to create a .wav file and have your system play that.

```sh
echo 'CDEFGABc' | ./endoh3 | ruby wavify.rb > cde.wav
```

There are also some other musical samples, twinkle.abc and menuet.abc.

## Judges' comments:

This endoh3ram can tweet out a tune and is small enough to tweet.

## Author's comments:

### Remarks

This is a sound synthesizer for a subset of [ABC music notation](http://en.wikipedia.org/wiki/ABC_notation).

Try:

```sh
cc -o endoh3 endoh3.c
echo "CDEFGABc" | ./endoh3 > /dev/dsp
```

If `/dev/dsp` is not available on your system, use an OSS sound wrapper such
as `padsp` or `aoss`:

```sh
echo "CDEFGABc" | ./endoh3 | padsp tee /dev/dsp > /dev/null
```

If you are using Mac OS X, try [sox](http://sox.sourceforge.net/):

```sh
echo "CDEFGABc" | ./endoh3 | sox -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio
```

If they do not work, use the attached script to convert the output
into a wave file format:

```sh
echo "CDEFGABc" | ./endoh3 | ruby wavify.rb > cde.wav
```

and play `cde.wav`.

You can enjoy some music scores that I attached:

```sh
cat twinkle.abc | ./endoh3 > /dev/dsp
cat menuet.abc | ./endoh3 > /dev/dsp
```

### Obfuscation

The following sequence of questions may be helpful to understand the endoh3ram.

- How does it convert ABC notes into the frequency?
- What is `89/84.`?  I found it by using Stern-Brocot tree.
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

The following features are *not* supported:

- Sharp and flat: `^C` `_C`
  - But it is possible to emit the half tones.  Do you see how?
- Shorter note lengths than 1: `C1/2`
  - But you can use `C0.5` instead.
- Higher and lower notes: `c'` `C,`
- Any meta fields: `T:title` `L:1/4`
- Bar line, repeat, ties and slurs, and everything else.

### Known Bugs

You can *not* write a note length immediately followed by a note `E`,
such as `C2E2`.
Can you know why?
You can work it around by inserting a whitespace: `C2 E2`.

### Portability

I tested it on:

* Ubuntu 13.10 with gcc 4.7.3, clang 3.2, and tcc 0.9.25.
* Mac OS X 10.6 with gcc 4.2.1 and clang 1.7.

### Legal

I believe that all the scores that I attached are out-of-copyright.

I did write a score of the Happy Birthday song too.
(It does not matter because the song is out-of-copyright in my country.)
But I do not attach it to protect you from W\*\*\*\*r.

For the same reason, do not play a score that contains only `z1092`.
You know, it is ["the famous song"](http://en.wikipedia.org/wiki/4%E2%80%B233%E2%80%B3).

### Spoiler (rot13)

Urer vf n zntvpny rkcerffvba juvpu V sbhaq ol oehgr-sbepr:

```c
(p % 32 + 5) * 9 / 5 % 13 + a / 32 * 12 - 22
```

Vagrerfgvatyl, vg pbairegf na NFPVV ahzore bs NOP abgrf
gb gur pbeerfcbaqvat gbar ahzore.

    'P' (NFPVV  67) =>  3
    'Q' (NFPVV  68) =>  5
    'R' (NFPVV  69) =>  7
    'S' (NFPVV  70) =>  9
    'T' (NFPVV  71) => 10
    'N' (NFPVV  65) => 12
    'O' (NFPVV  66) => 14
    'p' (NFPVV  99) => 15
    'q' (NFPVV 100) => 17
    'r' (NFPVV 101) => 19
    's' (NFPVV 102) => 20
    't' (NFPVV 103) => 22
    'n' (NFPVV  97) => 24
    'o' (NFPVV  98) => 26

Ol gur jnl, lbh pna jevgr n unys-gbar ol gur sbyybjvat punenpgref.

    'X' =>  4 (= P#)
    'Y' =>  6 (= Q#)
    'H' =>  8 (= S#)
    'I' => 11 (= T#)
    'C' => 13 (= N#)

Abgr gung gur gbar ahzoref fvzcyl rahzrengr gur frzv-gbar fgrcf.
Fb jr pna pnyphyngr gur serdhrapl rnfvyl: `cbj(2, a / 12.0)`.
Gura, ubj pna jr pnyphyngr `cbj` jvgubhg `zngu.u`?
`cbj(2, 1.0 / 12.0)` vf nccebkvzngrq ol `89/84.`.
(V sbhaq guvf nccebkvzngvba ol hfvat [Fgrea-Oebpbg gerr](uggc://ra.jvxvcrqvn.bet/jvxv/Fgrea%R2%80%93Oebpbg_gerr).)
Jr pna tnva gur serdhrapl ol zhygvcylvat gur inyhr `a` gvzrf.

Svanyyl, gur sbyybjvat pbqr trarengrf n fnj jnir:

    sbe(p = 0; p < yra; p++) chgpune(n = a * Q);

jurer `Q` vf n serdhrapl naq `n` vf n inevnoyr jubfr glcr vf pune.
Ol nffvtavat sybng gb pune inevnoyr, gur vzcyvpvg glcr pbairegvba vf cresbezrq sebz sybng gb pune (zbqhyb 256).
(Fgevpgyl fcrnxvat, guvf orunivbe vf haqrsvarq nppbeqvat gb 6.3.1.4 va P99;
lbh pna ercynpr vg jvgu `(ybat)(a*Q)` vs lbh ner crqnagvp.)

Nyy gung jnf yrsg jnf gb pbzovar naq pbaqrafr gur pbzcbaragf.
Gur xrl vf fdhnfuvat gurz vagb whfg bar sbe-ybbc.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
