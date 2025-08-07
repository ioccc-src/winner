## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/stedolan - Best one liner](https://www.youtube.com/watch?v=NJ-e4SgXGpw)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    echo {10-hex-digits} | ./prog > out.pbm
```


## Try:

``` <!---sh-->
    md5sum prog.c | ./prog | display -
```


## Judges' remarks:

There are no magic numbers in the program, and bits of the input map to pixels of the output
in a regular way, yet it outputs a nice icon for itself, if given the MD5 hash of its own source. How?


## Author's remarks:

This program is a decoder for a very compact icon format, producing 80x80
pixel **pbm images** based on small bitmapped icons:

``` <!---sh-->
    echo faf6bdafe6 | ./prog | display -   # calendar
    echo f843928fe0 | ./prog | display -   # mail
    echo f0b42d0bd8 | ./prog | display -   # battery
    echo f39ce33bc0 | ./prog | display -   # 1
    echo f0aced1bc0 | ./prog | display -   # 2
    echo f1b4ed1bc0 | ./prog | display -   # 3
    echo 4010881098 | ./prog | display -   # ?
    echo c6018c7398 | ./prog | display -   # !
    echo de848d2c3c | ./prog | display -   # the tetrominos
```

**NOTE**: The use of `| display -` is optional.  If omitted,
just view the resulting output in a terminal with a small font size.

**NOTE**: Else if do not have ImageMagick's `display(1)` tool installed
the use **pbm image** viewing tool of your choice.

Effort has been made to reduce the size of the program text to a single
longish line (135 characters, including newline). Regrettably, this left no
space in which to store the program's own icon, a picture of a computer
screen displaying 'C'.

Accordingly, the program's icon is instead stored in the program's MD5 hash:

``` <!---sh-->
    md5sum prog.c | ./prog | display -
```

**NOTE**: On machines without `md5sum(1)`, try `md5` or `openssl md5 -r`.


### Notes

  - While terseness was preferred over obscurity, this program hopefully
    still lives down to IOCCC's usual standards of clarity.

    The program should be readable to any C programmer familiar with its
    less common operators, including French-quoted literals (`<<5>>`), the
    interrobang (`?!`) and the wink (`^-`).

  - To fit on one line, the program commits two anachronistic sins: it
    assumes an implicit `int` return type for `main`, and it uses several
    stdlib functions without including the relevant header.

    It can be compiled by switching to `-std=c89` (remembering a time when
    such crimes were let off with a warning), or by covering up the crimes
    with `-Dmain='int main' -include stdio.h`, at which point it is valid
    under any version of C.

  - Even with these compiler options, Clang and GCC with `-Wall` also issue
    a warning complaining that the program correctly uses weird parts of
    the C operator precedence table. No apology is made for this one.

  - Several variants of this program were considered. Several.

  - The icon format is compressed, not just bit-packed: there are more
    pixels in the output than bits in the input.

  - By an astonishing coincidence, the number of bits in the input format
    is approximately the log2 of the number of MD5 evaluations that a
    five-year-old GPU can do in an hour.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
