## To build:

``` <!---sh-->
    make
```

NOTE: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".


## To use:

``` <!---sh-->
    ./grothe carrier_freq pixelclock horizontal_total < some_input.txt
```


## Try:

Put on your "electronic ears" and then try:

``` <!---sh-->
    ./try.sh
```

You may find using
a tunable scanning electronic ear helps.


## Judges' remarks:

Most of the time, interference is annoying.  This entry is the
exception that proves the rule.  What is a bug to some is a
feature to this entry.  :-)


## Author's remarks:

The program draws patterns on the screen that can be picked up by a
[shortwave radio](https://en.wikipedia.org/wiki/Shortwave_radio).  It emulates
the frequencies for an old fashion touch tone phone, so old songs can be played
by hitting `0-9`,`#`, and `*`.

To be able to run the program you need to determine the following
parameters:

```
    carrier_freq     - base frequency used to host music
    pixelclock       - refresh rate of the monitor
    horizontal_total - total scan along the horizontal axis
```

If you have `xvidtune` installed you can get the `pixelclock` and
`horizontal_total` with the following command

``` <!---sh-->
    xvidtune -show | head -n 1 | awk '{ print "pixelclock " $2 * 1000000 " horizontal_total = " $6 }'
```

Example from my laptops:

``` <!---sh-->
    ./grothe 65000000 10000000 1344 < twinkle.txt
```

Even if the user gets a setting off, the sound will usually be able to be
heard on [AM](https://en.wikipedia.org/wiki/AM_broadcasting) at a multiple of
the original frequency.

The core idea of using a machine to play music on AM radio goes all the
way back to the [Altair computers](https://en.wikipedia.org/wiki/Altair_8800)
and [Timex Sinclair ZX-81](https://en.wikipedia.org/wiki/ZX81)s.


### Several example songs

Olympics Fanfare - from `antang@phakt.usc.edu` - Tony:

```
    4-9-91231,2222-321123123-9-91231,2222-32112321
```

Twinkle Twinkle Little Star - from `fsufunkyb@aol.com` - Ben Schmidt:

```
    1199##9-6633221-9966332-9966332-1199#9-6633221-
```

Generic Arabian Tune - from `rdippold@qualcomm.com` - Ron "Asbestos" Dippold:

```
    453,54,4569564459,9#95458,8987453 54
```

Others can be found by doing a search for "touch tone phone songs".


### Obfuscations

- Some numbers expressed in Octal, some in hex and some in decimal:
"A foolish consistency is the hobgoblin of little minds" - Ralph Waldo
Emerson.

- Funky scoping, looking at the nanosleep section and `XsetWindowAttributes`
declares local variables.
- Algorithm is very weird, uses `y` dimension to draw carrier frequency
  and `x` dimension to draw audio frequency, based on [Erik
  Thiele](http://www.erikyyy.de)'s
  [Tempest for Eliza](http://www.erikyyy.de/tempest/).
- lack of `#define`s confuses many people :-)
- figuring out your `pixelclock` and `horizontal_total` and which `carrier_freq`
  to use can be an exercise in obfuscation for the user.
- use of commas in various places, confuses most C code beautifiers
  sometimes making the beautified code harder to read
- use of `static` to ensure initialization is EVIL and done in several
  places
- uses `static` declarations & `void` function returns we don't care about
  making the code harder to read.
- does sound using only [X11 libs](https://en.wikipedia.org/wiki/Xlib), no other
libs required.
- demonstrates tempest emissions in a fun/easy way.
- follows good programming practices of actually setting exit codes and giving
usage when run with incorrect parameters.

### References

[Tempest for Eliza - Basis for Algorithms](http://www.erikyyy.de/tempest/).

[Tempest
AM](https://web.archive.org/web/20070612152538if_/http://silcnet.org/priikone/programs/tempest-AM-1.0.tar.gz)
\- Another early program in this field. See
[here](https://web.archive.org/web/20070612152538/http://silcnet.org/priikone/programs.php?lang=en)
for a bit more information on the program (search for `Tempest-AM Radio Signal
Transmitter`).

The paper
[Soft Tempest: Hidden Data Transmission Using Electromagnetic
Emanations](https://www.cl.cam.ac.uk/~mgk25/ih98-tempest.pdf) by Markus G.
Kuhn's and Ross J. Anderson's.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
