## To build:

```sh
make all
```


## To use:

```sh
./esde data-file word
```

where data-file contains lines of < 255 chars in length.


### Try:

```sh
./esde esde.data Johanson
./esde esde.data2 read
./esde README.md date
```


## Judges' remarks:

When reading the source be careful to distinguish between variable
names and library functions.

If you still don't know what it does, try
[https://en.wikipedia.org/wiki/Soundex](https://en.wikipedia.org/wiki/Soundex).


## Author's remarks:

### what this program does

This program searches in the file words which have the same Soundex code
of the given word, and print out lines with those words.

The Soundex code is used to find similar sounding words.

Soundex code begins with the first letter of the word followed by a
three-digit code. This is the algorithm:

0. Every letter in the word beyond the first letter is replaced by a digit.
1. Replace all pairs of the same code by single code (ex. R011235 -> R01235).
2. Remove all 0-codes (ex. R01235 -> R1235).
3. If length of code is > 4, get only first 4 codes (ex. R1235 -> R123).
4. If length of code is < 4, add zeros (ex. T12 -> T120).

These are the codes:

```
0  =  A, E, H, I, O, U, W, Y
1  =  B, P, F, V
2  =  C, S, G, J, K, Q, X, Z
3  =  D, T
4  =  L
5  =  M, N
6  =  R
```

### information about an info file:

An info file should be a text file consisting of lines of text (max. 256 bytes
in each line).


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
