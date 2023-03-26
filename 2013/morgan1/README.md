# Smallest large system simulator

    Yves-Marie Morgan  
    <yves-marie.morgan@parrot.com>  

# To build:

```sh
make
```

### To run:

```sh
echo "2013/10/03" | ./morgan1
```

### Try:

```sh
echo "1985/10/28" | ./morgan1

echo "1996/12/31" | ./morgan1
```

Try pressing the arrow keys when your focus is in the window.

## Judges' comments:

To verify the output, try echoing the date of an evening with a clear sky.
Use binoculars and/or telescope as needed.  In some cases you may need
to wait for a better time of the evening.  In a few cases, such as
the South Pole in the summer, you may need to move to a different
observing site.

## Author's comments:

### Instructions

It displays the position of the 8 planets of the solar system around the sun.
The date given in the command line is in the format YYYY/MM/DD (year, month and
day). The direction keys can be used to move in time :

    Left  : go back 1 day.
    Right : go forward 1 day.
    Down  : go back 20 days.
    Up    : go forward 20 days.

It handles correctly all leap years and the switch between julian calendar and
gregorian calendar (10 days missing between 1582/10/04 and 1582/10/15).

The scale is logarithmic to be able to display the 8 planets without having
Mercury, Venus, Earth and Mars squizzed around the sun.

The size is not proportinal either.

### Bonus

It also displays the position of 2 famous comets during their last approach :
- The first one arround the third IOCCC.
- The second one between the thirteenth and fourteenth IOCCC.

### Limitations

* ASCII character set is assumed.
* a c99 compiler is required (for some math.h functions).
* The position should be correct for years between (-1000; +3000)
* The approximations done in the formula are OK for displaying the
  position around the sun but not for other applications like ephemeride or
  sky view from Earth (angles may be off by 1 or 2 degrees sometimes).

### Obfuscation

* Reuse of 1 letter variables.
* Only the main function with some for loops.
* Constants for orbital elements encoded in a string.
* Hexadecimal and decimal values used inconsitentely.
* Comparisons order are not consitent.
* A lot of stuff is done in the different parts of the for loop.

### Compilation warnings

with gcc 4.7.2 on Linux Ubuntu 12.10 :
* prog.c:38:3: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
* prog.c:40:34: warning: value computed is not used [-Wunused-value]
* prog.c:56:6: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
* prog.c:58:50: warning: value computed is not used [-Wunused-value]
* prog.c:61:5: warning: suggest parentheses around ‘-’ inside ‘>>’ [-Wparentheses]

with clang 3.1 on Linux Ubuntu 12.10 :
* prog.c:38:49: warning: '&&' within '||' [-Wlogical-op-parentheses]
* prog.c:38:27: warning: '&&' within '||' [-Wlogical-op-parentheses]
* prog.c:55:13: warning: '&&' within '||' [-Wlogical-op-parentheses]
* prog.c:56:14: warning: '&&' within '||' [-Wlogical-op-parentheses]

Due to most parentheses and braces removed when unecessary.

To verify the display, you can look at one of this programs :
* xephem : http://www.clearskyinstitute.com/xephem/
* homeplanet : http://www.fourmilab.ch/homeplanet/
* http://www.theplanetstoday.com/

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
