## To build:

``` <!---sh-->
    make
```

There is an alternate version of this program. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The alternate version, [prog.alt.c](%%REPO_URL%%/2020/kurdyukov3/prog.alt.c), has the main code as a macro.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


## Judges' remarks:

It is interesting how well smeonoe can raed txet wtih lots of tyops in it.
How well can you raed porg.c, C prgoarm that is in the shpae of an SD card (or
is it a pnuch crad)?

BTW: this funny reading of English (which also works with several other
languages) is called
[typoglycemia](https://www.mrc-cbu.cam.ac.uk/personal/matt.davis/Cmabrigde/)
(the article however is incorrect in stating that if the letters were more
jumbled or if other words were formed one could not read it: we know of some who
can in fact do exactly that). Also, to be clear, there was no such study stated
in [input.txt](input.txt) but as you'll likely see you should be able to do
exactly what it says nonetheless.


## Author's remarks:

### Letter Mixer

Compile and try this:

``` <!---sh-->
    cat input.txt | ./prog
```

The program can work with letters that are not represented in English, as long
as these letters are encoded in the higher part of the single-byte character set
(use `iconv` to convert from UTF-8 and back).

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
