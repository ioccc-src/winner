## To build:

```sh
make
```


## To use:

```sh
echo "2013/10/03" | ./morgan1
```


## Try:

```sh
echo "1985/10/28" | ./morgan1

echo "1996/12/31" | ./morgan1

echo "1986/03/31" | ./morgan1 # Comet Halley (look for 'Ha')

echo "1997/04/01" | ./morgan1 # Comet Hale-Bopp (look for 'Hb')
```

Try pressing the arrow keys when your focus is in the window.


## Judges' remarks:

To verify the output, try echoing the date of an evening with a clear sky.
Use binoculars and/or telescope as needed.  In some cases you may need
to wait for a better time of the evening.  In a few cases, such as
the South Pole in the summer, you may need to move to a different
observing site.


## Author's remarks:

### Instructions

It displays the position of the 8 planets of the solar system around the Sun.
The date given in the command line is in the format YYYY/MM/DD (year, month and
day). The direction keys can be used to move in time :

* Left  : go back 1 day.
* Right : go forward 1 day.
* Down  : go back 20 days.
* Up    : go forward 20 days.

It handles correctly all leap years and the switch between [Julian
calendar](https://en.wikipedia.org/wiki/Julian_calendar) and
[Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar) (10 days
missing between 1582/10/04 and 1582/10/15).

The scale is logarithmic to be able to display the [8
planets](http://news.bbc.co.uk/2/hi/5282440.stm) without having
[Mercury](https://science.nasa.gov/mercury),
[Venus](https://science.nasa.gov/venus/),
[Earth](https://science.nasa.gov/earth/facts) and
[Mars](https://science.nasa.gov/mars) squeezed around the
[Sun](https://science.nasa.gov/sun/).

The size is not proportional either.


### Bonus

It also displays the position of 2 famous comets during their last approach:

- The [first one](https://science.nasa.gov/solar-system/comets/1p-halley/)
around the [third IOCCC](/years.html#1986).
- The [second
one](https://science.nasa.gov/solar-system/comets/c-1995-o1-hale-bopp/) between
the [thirteenth](/years.html#1996) and [fourteenth](/years.html#1998) IOCCC.


### Limitations

* ASCII character set is assumed.
* A C99 compiler is required (for some `math.h` functions).
* The position should be correct for years between (-1000; +3000)
* The approximations done in the formula are OK for displaying the position
around the [Sun](https://science.nasa.gov/sun/) but not for other applications
like [ephemeride](https://en.wikipedia.org/wiki/Ephemeris) or sky view from
[Earth](https://science.nasa.gov/earth/facts) (angles may be off by 1 or 2
degrees sometimes).


### Obfuscation

* Reuse of 1 letter variables.
* Only the `main()` function with some `for` loops.
* Constants for orbital elements encoded in a string.
* Hexadecimal and decimal values used inconsistently.
* Comparisons order are not consistent.
* A lot of stuff is done in the different parts of the `for` loop.


### Compilation warnings

With gcc 4.7.2 on Linux Ubuntu 12.10:

```
morgan1.c:38:3: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
morgan1.c:40:34: warning: value computed is not used [-Wunused-value]
morgan1.c:56:6: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
morgan1.c:58:50: warning: value computed is not used [-Wunused-value]
morgan1.c:61:5: warning: suggest parentheses around ‘-’ inside ‘>>’ [-Wparentheses]
```

With clang 3.1 on Linux Ubuntu 12.10 :

```
morgan1.c:38:49: warning: '&&' within '||' [-Wlogical-op-parentheses]
morgan1.c:38:27: warning: '&&' within '||' [-Wlogical-op-parentheses]
morgan1.c:55:13: warning: '&&' within '||' [-Wlogical-op-parentheses]
morgan1.c:56:14: warning: '&&' within '||' [-Wlogical-op-parentheses]
```

This is due to most of the parentheses and braces being removed when
unnecessary.

To verify the display, you can look at one of these programs :
* xephem : <https://web.archive.org/web/20130310133219/http://www.clearskyinstitute.com/xephem/>
* homeplanet : <https://www.fourmilab.ch/homeplanet/>
* <https://www.theplanetstoday.com>


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
