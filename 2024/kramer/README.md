## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/kramer - Prize in linguistic arithmetic](https://www.youtube.com/watch?v=Wkt6FbOYMxs)


## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: known bug - please help us fix**

For more detailed information see [2024/kramer in bugs.html](../../bugs.html#2024_kramer).


## To use:

``` <!---sh-->
    ./prog phrase1 phrase2 ...
```


## Try:

``` <!---sh-->
    ./prog two plus one trillion five hundred seventy five million six hundred thousand sixty one
```

Or:


``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Arithmetic processing with English words: naturally obfuscated for your signed 64-bit programming amusement.

Enjoy!


## Author's remarks:


## Overview

The frequent computer user may, for reasons of ergonomics, wish to minimize the distance their hands travel while completing everyday tasks. The much beloved Thinkpad TrackPoint is a wonderful example of a technology built for this purpose, allowing the user to transition seamlessly from keyboard to mouse without the need for unnecessary repositioning of the hands. (One may wonder why a mouse would be necessary at all, given the rich text-based environment provided by the terminal, but that is a separate topic.)

For users who frequently switch between natural language writing and numeric calculations, the requirement to move their hands from the home-row position all the way over to the number pad represents an extreme hardship. It wastes valuable time, causes discomfort, and may lead to any number of serious health complications on a long enough time scale.

To address this problem, we present a simple calculator which operates entirely on natural language! Numbers and calculations can be entered in plain English as the program's argument vector, without the need to move away from the home-row. The program will handle the rest. Inputs of positive or negative values into the trillions are supported, with internal calculations supporting an even greater precision in the range `LLONG_MIN <= n <= LLONG_MAX`. The operators "plus" (+), "minus" (-), "times" (*), "divided by" (/), and "mod" (%) are implemented. Standard order-of-operations is respected. All calculations are performed using whole integers.

Order of operations is handled through the use of the [Shunting Yard Algorithm](https://en.wikipedia.org/wiki/Shunting_yard_algorithm), which uses stacks and queues to convert the infix input array into postfix (RPN) notation to be solved.  (Shout out to my boy Edsger Dijkstra for that one, sick algorithm dude!)


## Examples

```
$ ./prog one plus one
2

$ ./prog one thousand three hundred and thirty seven
1337

$ ./prog two times three plus five
11

$ ./prog seventeen times negative two
-34

$ ./prog one hundred and two divided by six plus nine
26

$ ./prog nineteen plus one hundred mod seven
21

$ ./a.out negative three hundred and seventy two trillion thirty six billion eight hundred and fifty four million seven hundred and seventy five thousand eight hundred and eight minus nine thousand two hundred and twenty three times one trillion times one thousand
-9223372036854775808
```

## Obfuscation

Obfuscation is greatly enhanced by the use of a custom hashing function to identify each natural language term. While a series of `strcmp()`'s would certainly be sufficient, including all of those human-readable words in the source would be much too obvious (not to mention that it bloats the source file, wasting valuable disk space). After much experimentation, it was determined that the following function produces a unique set of 8-bit numeric outputs for all required input terms.

```c
char hash(char *s) {

    char h = 1, i = 0;

    while (s[i]) {
        h >>= 1;
        h ^= s[i++];
    }

    return (h & 0xf) | (((i ^ s[0]) << 4) & 0xf0);

}
```

This allows the program to identify each unique term without having to explicitly declare them within the source file. The complete list of valid input terms and their cooresponding hash value is listed below for reference, sorted alphabetically.

```
 43 and
 90 billion
  8 by
 55 divided
  2 eight
223 eighteen
 48 eighty
 56 eleven
 31 fifteen
 49 fifty
 40 five
 47 four
238 fourteen
 52 forty
242 hundred
170 million
137 minus
232 mod
110 negative
165 nine
111 nineteen
130 ninety
201 one
 76 plus
106 seven
175 seventeen
 65 seventy
  0 six
 78 sixteen
103 sixty
113 ten
206 thirteen
 39 thirty
192 thousand
 17 three
 16 times
202 trillion
 45 twelve
 32 twenty
121 two
224 zero
```

To further obfuscate the code, we golf it down a bit using all the standard tricks.


## Limitations

If you compile this with nit-picky flags like `-Wall`, the compiler is likely to be very cross. >:( It will yell a bit. So... don't do that, I guess! Both `gcc` and `clang` are happy and quiet with the defaults.

Inputs into the trillions are handled, but inputs of one quadrillion or above are not. During calculation, only numbers which can be represented by an `int64_t` are supported.  But honestly... who needs numbers bigger than that anyway?

Input terms other than those explicitly implemented are considered undefined and will produce undefined results. Many will hash to unknown values, having no effect, while others may produce collisions when hashed, causing unexpected outputs. For instance, the term `give` hashes to the number `56` which is a collision with the term `eleven`.  Thus...

```
$ ./prog never gonna give you up
11
```

We recommend simply not doing that.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
