## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC29 - 2025/kurdyukov - Most likely to count](https://www.youtube.com/watch?v=UTAluKAaJek)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog number .. 0 answer ..
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

How many arithmetic ways can we form numbers out of other numbers?
The answer is a great deal.  But to find the shortest mathematical
expression: that is more of a challenge.  To do that in only 1196 bytes
of C code: that is impressive!


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#kurdyukov) for this winning entry.


## Author's remarks:


## Magic Equations


### Usage

```
    ./prog 7 77 777 0 2025 2026 2027 2028 2029
    (777 / 7 - 7) * (77 + 7) / 7 + 777 = 2025
    777 / 7 * 77 / 7 + 777 + 77 - 7 * 7 = 2026
    777 + 777 - 77 + 77 * 7 + 77 / 7 = 2027
    (77 + 7 / 7) * (7 + 7 + (77 + 7) / 7) = 2028
    77 * (7 + 7 + 77 / 7) + 777 / 7 - 7 = 2029
```

The program finds the shortest mathematical expression that uses numbers
from the first list and `+-*/` operators along with parentheses to
represent numbers in the second list. Lists are separated by a zero.


### Notes

- Numbers are limited in the interval [1, 2^15).
- The shortest in terms of string length (spaces are counted).
- This may not be the shortest possible for some numbers due to the limited search range.
- When compiled with -O3, the program calculates the result in about 4 seconds on an average PC. The computation time is almost independent of the length of the lists.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
