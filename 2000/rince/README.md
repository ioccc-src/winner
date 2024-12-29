## To build:

``` <!---sh-->
    make all
```

**NOTE**: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2000/rince in bugs.html](../../bugs.html#2000_rince).


## To use:

``` <!---sh-->
    ./rince number number2
```

If `DISPLAY` is not set the program will very likely crash or do something
different.


## Try:

``` <!---sh-->
    ./try.sh
```

This will run the program several times with different parameters to show
different types of things. See the author's remarks for more details.


## Judges' remarks:

This program may have you going around in circles :-) Try running it first
before reading the author's remarks below.

The judges verified the correctness of output for recent dates through visual
observation.


## Author's remarks:

### How to use it

The simplest way to run it is with no arguments. Just type:

``` <!---sh-->
    ./rince
```

You will need to have access to X windows, although it doesn't require
desperately high resolution and there are no known limitations on colour
depth.

The display will change slowly over time, although it may take 10 minutes
or more to be visible. For those that cannot wait that long the program
has a built in time machine. Indeed the program knows the speed of light,
which is used to ensure that we see the "live" pictures. Simply specify
the fraction of a day to skip forward for each screen refresh. I suggest:

``` <!---sh-->
    ./rince 0.01
```

To display the output (still guessing?) for a given date, specify two
arguments. The first argument is as before and the second argument is a
Julian day number (given as a fractional component). E.g.:

``` <!---sh-->
    ./rince 0 2441193.6
    ./rince 0.01 2441193.6
```

A Julian day is defined to be the number of days since January 1st in the year
`-4712 (4713BC)`, starting at 12 noon GMT.[^1][^2] To aid conversion from our time
(GMT) to Julian day there is a supplementary program named:
[dmy2jd.c](%%REPO_URL%%/2000/rince/dmy2jd.c). Run it with `day_float month year` as arguments. See below
for an example.


### What it does

This program plots the positions of the four [Galilean
moons](https://en.wikipedia.org/wiki/Galilean_moons) of
[Jupiter](https://science.nasa.gov/jupiter/), as seen from
[Earth](https://science.nasa.gov/earth/). It doesn't correct for your
location on Earth, but I assure you that the
[parallax](https://en.wikipedia.org/wiki/Parallax#Astronomy) is minimal!

The moons are labelled with Roman numerals from `I` to `IV`, `I` being the
closest to the planet and `IV` being the furthest. They are:

- `I`
    * [Io](https://science.nasa.gov/jupiter/moons/io)
- `II`
    * [Europa](https://science.nasa.gov/jupiter/moons/europa/)
- `III`
    * [Ganymede](https://science.nasa.gov/jupiter/moons/ganymede/)
- `IV`
    * [Callisto](https://science.nasa.gov/jupiter/moons/callisto)

Amazingly, all it takes is a pair of binoculars to see the Galilean moons,
so the results can be experimentally checked. (Note that at present, the
best views of Jupiter are over the autumn/winter.)

The positions of the moons should be correct for binoculars, but possibly
not if you have a telescope or if you are in the southern hemisphere. In
that case I suggest that to get the correct image you look at the screen
from inside the monitor whilst standing on your head. In case of
confusion, please consult the following chart (\*):

```
               N
               ^
               |
         E <---+---> W
               |
               v
               S
```

(\*) Not to scale.


### History

Galileo discovered the moons in January 1610.
<https://web.archive.org/web/20001204212000/http://www-isds.jpl.nasa.gov/cwo/cwo_54ga/html/cd/galileo.htm>
states the following:

> By early 1610, Galileo had further improved his telescope by double its power,
so it now enlarged objects a thousand times. He began looking at the stars and
couldn't believe how many more he could now see! The number seemed infinite. He
was beginning to realize the fixed stars weren't a flat distant wall on a globe,
but a three-dimensional expanse bigger than anyone had ever thought!
>
> Then, on January 7, about an hour after sunset, Jupiter rose in the east,
and Galileo happened to turn his powerful scope on its bright disk. It wasn't
the first time he had looked at Jupiter, but before it was with one of his
lesser-powered telescopes. This time, though, he noticed three small but bright
stars near the planet, two to one side and one to the other. He wondered at how
bright the small stars were and how they were arranged in what seemed like a
straight line. The next night he decided to look at Jupiter again, and to his
surprise, the stars had moved. But not in such a way as he would expect. If
Jupiter was moving as it normally should, the stars would be east of Jupiter.
But all three were to the west! The next night was cloudy, but on January 10,
Galileo was able to observe the planet again. One of the stars was gone, and the
other two were now on the east side. As the stars moved around Jupiter on each
succeeding night, and were finally joined by a fourth star, it dawned on Galileo
that what he had found were moons orbiting Jupiter!  Almost at once he realized
that this was proof that not all objects orbited the Earth. Here were four
bodies that were orbiting Jupiter. One argument against the sun-centered theory
was, if the Earth orbited the sun, wouldn't the moon get left behind?  Here he
could see for himself that somehow, a planet could orbit the sun, and not leave
a moon behind!

Thus we can plot Galileo's discoveries using the following three plots:

``` <!---sh-->
    ./rince 0 $(./dmy2jd  7.8 1 1610)
    ./rince 0 $(./dmy2jd  8.8 1 1610)
    ./rince 0 $(./dmy2jd 10.8 1 1610)
```

However we can go one better by seeing what Galileo would have seen if it
wasn't cloudy on the 9th. Try:


``` <!---sh-->
    ./rince 0 $(./dmy2jd 9.85 1 1610)
```

to see what he was missing out on. I wonder what he'd have made of that!

Galileo discovered the fourth moon a few days later.

I've tried typing these dates into two Java based Jovian moon plotters,
but both I tried had problems dealing with dates earlier than 1900. More
professional software, such as the
[SkyMap](http://www.bmsoftware.com/skymappro9.htm) gets these values
correct and this compares well with the above description and with this
IOCCC entry.

The year 4713BC was chosen by [Joseph Justus
Scaliger](https://en.wikipedia.org/wiki/Joseph_Justus_Scaliger) in the 16th
Century, so clearly this program has a long history :-) A more complete
description of the origins of Julian Days can be found at
<https://web.archive.org/web/20001206152200/http://aa.usno.navy.mil/AA/faq/docs/millennium.html>.


### Assumptions

This program assumes:

1. The ASCII character set is used.

2. That an enormous comet hasn't changed the course of
[Jupiter](https://science.nasa.gov/jupiter/) (or
[Earth](https://science.nasa.gov/earth/)!).

3. That the date has not been specified as the gap between the
[Julian](https://en.wikipedia.org/wiki/Julian_calendar) and
[Gregorian](https://en.wikipedia.org/wiki/Gregorian_calendar) calendar.

4. That the `DISPLAY` environment variable is set and the X display can opened.
If this is not the case the program will crash.

5. There is a year 2000BC problem :-)

    More specifically, the plots for dates that far back are too inaccurate to
    be of realistic use. Comparisons against [SkyMap
    Pro](http://www.bmsoftware.com/skymappro9.htm) show that there is a good
    similarity (but not much more) up to about 500BC.

6. The code definitely is not portable - it will produce incorrect results if
run from the surface of [Mars](https://science.nasa.gov/mars/).


### Obfuscations

In addition to the normal obfuscations, I feel that the code contains some less
common tricks. Taken through the standard rounds listed in the
[guidelines](../guidelines.txt), the code attempts to pass these as follows:

1. Look at the original source

    With luck, pure casual inspection should not reveal much except
    that the program contains the X Windows logo (a big clue) and
    contains a date. This date may give a clue to a few people that
    this is an astronomical program.

    Unfortunately I was stretched for space which meant that the
    large string constant could not be split up using a "partA"
    "partB" method which clearly limits the code layout. However the
    space saved by using a single long string constant is more than
    outweighed by the ability to further obfuscate.

2. convert ANSI trigraphs to ASCII

    These are not used.

3. C pre-process the source ignoring `#include` lines
4. C pre-process the source ignoring `#define` and `#include` lines

    This does a good job of expanding out the code, but it does not
    clarify things greatly. The use of `#define`s has been restricted
    primarily to a space-saving mechanism.

    Additionally, the use of `typedef`s means that the types used are
    still obscured unless further replacement edits are made.

5. Run it through a C beautifier.

    GNU `indent(1)` seems to do a reasonable job, provided that the
    `#define`s are expanded first. This doesn't lay the algorithm
    particularly bare though as most of the obfuscations are not
    simple code layouts.

6. Examine the algorithm.

    The algorithm operates on two levels. The main visible level is
    by taking a large string and breaking this down into a series of
    opcodes (which I have termed J-code). These are then executed.

    To get to the real method of how it works, you need to decode the opcode
    string (which deliberately contains as many `;`, `{` and `}` symbols as
    possible), which will give you a [Reverse Polish
    notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) chunk of
    mathematics.

    Sensible people amongst you will simply refer to the referenced book :-)

7. Lint it.

    I no longer have lint, although I do have access to Purify. I'm
    happy to say that purify does not detect any memory errors or
    memory leaks.

    See below for compilation warnings.

8. Compile it.

    I'm sorry to say that there are several warnings issued by the
    compiler.

    Firstly, the return type for `X()` is not specified, so it defaults to `int`.
    Horror of all horrors - this function does not return an integer type (it
    doesn't contain any specific `return`s). The return value from `X()` is not
    accessed. The same problem occurs in `main()` - it does not return. However
    `main()` never exits unless there is a serious error.

    The 6th argument of `XDrawText` (which should be `XTextItem`) is
    passed as a compatible structure, but without casting. This is
    to reduce code space. A more elegant solution is to remove the
    `struct {...} Z` completely and use `XTextItem
    f={i-127+r/3*2,r%3+r/3+1,0,E}` at the start of `XDrawText`
    block. Although this is accepted by several compilers, it is not
    strict ANSI due to the non-constant initialisers. A pity.

    Note that I make use of `usleep()`. This is a POSIX call (it is BSD), but it's
    supported on many systems. It may be implemented using `select()` or `poll()` if
    required, or as a final solution you can change the `usleep(10000)` to
    `sleep(1)`. To compile on systems which do not have `usleep()`, but do have
    `select()`, the following may suffice as an additional compiler argument:

    ```
        -Dusleep={time_t v[2]={0,10000};select(0,0,0,0,v);}
    ```

    `gcc` complains about "unreachable code at beginning of switch
    statement", although removing some of this code will prevent
    the algorithm from working.

    `gcc` also suggests that I should be using extra parenthesis, but
    I'm taking this as good comment :-)

In addition to the above, the program has the following useful(?)
obfuscations:

1.  The algorithm requires many floating point numbers (about 50). These are
encoded as ASCII.

2.  The J-code algorithm has opcodes designed to be space saving. They are all
one byte, but many are also considered as whitespace by the rules. This
algorithm forms part of the same string that the floating point constants are
embedded within. What does the `;` command do in J-code?

3.  The J-code language is both stack based and variable based. This
"uncleanliness" is not ideal from a computer science angle, but when has
cleanliness been considered as good in IOCCC? :-)

4.  Association of unconnected data by implied function usage. E.g. use of
`strlen()` and `sizeof()` simply to return useful numerical values, using
irrelevant arguments.

5. As we already have a dependency on ASCII this has been abused further.
Specifically some integer constants are specified as ASCII and some ASCII
constants are integers. This hides the true meaning for the values.

6.  Red herrings: there are a couple of pieces of code whose appearance is just
there to mislead the infirm of mind.  I've only tried to include such examples
in places where at first glance the code appears to be executed.

### References

[^1]: Astronomical algorithms (1st ed): page 59
Jean Meeus. Published by Willmann-Bell Inc.

[^2]: Astronomical algorithms (1st ed): pages 285-299.
Jean Meeus. Published by Willmann-Bell Inc.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
