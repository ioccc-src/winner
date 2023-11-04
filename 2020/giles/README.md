# Most phony

Edward Giles\
<https://id523a.com/>


## To build:

```sh
make
```


## To use:

```sh
./prog
```


### Try:

```sh
./prog < pi.wav

# [https://en.wikipedia.org/wiki/867-5309/Jenny]
./prog 867-5309 > jenny.wav

# Use an audio player to play jenny.wav
```


## Judges' remarks:

A cross platform utility for both encoding and decoding tones.


## Author's remarks:

### Introduction and Usage

This program encodes and decodes [dual-tone multiple frequency](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling) signals used in telephone systems, more commonly known as Touch-Tones.

If the program is executed with no arguments, it will read a WAV file from standard input, decode the touch-tones in the file, and output the corresponding digits to standard output. This program only supports WAV files that have exactly 16 bits per sample, but it allows any sample rate and any number of audio channels.

```sh
$ ./prog < pi.wav
31415926
```

If the program is executed with a command-line argument, it will generate the tones corresponding to the specified characters, writing them to standard output as a WAV file.

```sh
$ ./prog 867-5309 | aplay
```

### Interesting Features

* When compiled with `gcc -pedantic -Wall -Wextra` there are no compiler warnings.
* This program can be successfully compiled and run on Windows, using both Microsoft's C compiler and [TCC](https://bellard.org/tcc/).
* This program resamples the incoming audio, so that it can accept audio data at any sample rate.
* The code that generates the output sine-waves is the same as the code that looks for sine-waves in the input. (see Algorithm Details for roughly how this works)
* Despite handling lots of sine waves, the program only uses basic arithmetic operations. It does not depend on `libm`.
* All type punning is done with `memcpy` so there are no strict-aliasing violations.
* The size of the source code using the IOCCC size tool is 1963, the year the first push-button telephones were made available to customers.
* The source code is roughly in the shape of a telephone handset.

### Assumptions

* Code is compiled using the C99 or C11 standard
* `CHAR_BIT == 8`
* Machine is little-endian
* `int16_t`, `uint16_t`, and `uint32_t` exist
* `int16_t` is 2's-complement
* `double` is an IEEE 754 binary64 floating-point type
* `sizeof(double) == 8`

### Obfuscations

  * DSP code is inherently somewhat difficult to understand.
  * Lots of identifier reuse. Each identifier is used for about 2.2 different tasks, on average.
    For example, `aa` is both a variable and a macro for error handling,
    and `memcpy` is both a library function and a goto-label.
  * Most of the identifiers are only 1 or 2 characters long, and are unrelated to their actual function.
  * The `f` macro is used to unroll some of the loops.
  * Some numerical constants are replaced with character literals, so the actual value is unclear.
  * All of the strings used by the program have been combined into a single string literal.
  * Most of the values used for the actual signal-processing all reside in one array, named `l`. This array is usually accessed at index `z` plus a constant. Accesses of this type have been rewritten from, e.g. `l[z+17]` to `17[l+z]`. `[l+z]` ends up occurring quite often, so I created the macro `a` as a shorthand.


### Algorithm Details

Each tone in a DTMF signal is a combination of two frequencies. The lower frequency determines which row the digit is in, and the higher frequency determines the column. There are 4 possible row frequencies and 4 possible column frequencies.

```
|            | **1209 Hz** | **1336 Hz** | **1477 Hz** | **1633 Hz** |
|------------|-------------|-------------|-------------|-------------|
| **697 Hz** | 1           | 2 abc       | 3 def       | A           |
| **770 Hz** | 4 ghi       | 5 jkl       | 6 mno       | B           |
| **852 Hz** | 7 pqrs      | 8 tuv       | 9 wxyz      | C           |
| **941 Hz** | *           | 0           | #           | D           |
```

This program determines which frequencies are present in the input by passing it through a set of 8 virtual resonators, each tuned to one of the frequencies used for DTMF. These can be implemented using only basic arithmetic, and they are able to 'select' a specific frequency from the input sound, blocking all other frequencies from reaching the output. The loudness of the sound output from each resonator can therefore be used as a measure of how much of a particular frequency was present in the input. The program then decides, over the course of one tone, which row frequency and which column frequency were most prominent.

Tones are generated using those same resonators by providing [an impulse](https://en.wikipedia.org/wiki/Kronecker_delta#Digital_signal_processing) as input. An impulse can be thought of as consisting of sine-waves at all frequencies, and when it is put through one of the resonators, the result is a single pure sine wave.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
