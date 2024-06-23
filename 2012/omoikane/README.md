## To build:

``` <!---sh-->
    make
```

There is an alternate version that will read from the compiled file itself, in
case you don't have a `/dev/urandom` file. There is also a version that should
theoretically work with Windows which distinguishes binary and text. See
[alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./nyaruko [seed.txt] < original.bin > output.c
    bash output.c > key.c
    perl output.c > data.c

    cat key.c data.c > output.c

    cc output.c -o output
    ./output > regenerated.bin
```

NOTE: if your OS does not have `/dev/urandom` then you should specify a seed
file or use the [alternate version](#alternate-code) which reads in the compiled
binary itself.


## Try:

``` <!---sh-->
    ./try.sh
```

The script [try.sh](%%REPO_URL%%/2012/omoikane/try.sh) will check if you have perl before trying to use the
perl parts of the script.


## Alternate code:

The alternate version will, if no file is specified, read in the compiled binary
itself rather than trying to open `/dev/urandom`, which is the default for the
original entry. This is useful if your system does not have a `/dev/urandom`
file and you do not want to specify an extra file. The second alternate version
is like the first except it also should theoretically work with Windows, setting
binary mode on `stdin` and `stdout`.


### Alternate build:

For the first version:


``` <!---sh-->
    make alt
```

For the second version:

``` <!---sh-->
    make alt2
```


### Alternate use:

Use `nyaruko.alt` or `nyaruko.alt2` as you would `nyaruko` above.


### Alternate try:

For the first alternate version:

``` <!---sh-->
    ./try.alt.sh
```

We have no way to test the second version, sorry (tm Canada :-) )!


## Judges' remarks:

The judges have nothing to add that has not already been written about in the
[spoiler.html](spoiler.html) (requires JavaScript) file!  :-)


## Author's remarks:

### Usage

`Nyaruko` is a binary to text filter.  Given some input on `stdin`,
`Nyaruko` will produce C code that reproduces this input on `stdout`:

``` <!---sh-->
    ./nyaruko < original.bin > output.c
    gcc output.c -o output
    ./output > regenerated.bin
```

Output is encrypted, but both key and data are included in the output.
To separate the key from the data, run these commands:

``` <!---sh-->
    bash output.c > key.c
    perl output.c > data.c
```

The key-less `data.c` still compiles, but produces a different message
on `stdout` instead of the original input.  This message is a hint to
why the code is formatted the way it is.

To combine the key and data, concatenate them together in either
order:

``` <!---sh-->
    cat key.c data.c > output.c
    cat data.c key.c > output.c
```

By default, `Nyaruko` generates a unique random key for every message,
using `/dev/urandom` as the seed.  If given an extra command line
argument, `Nyaruko` will seed using that file instead of `/dev/urandom`:

``` <!---sh-->
    ./nyaruko seed.txt < input.bin > output.c
```

This makes the output key deterministic, allowing the same key to be shared
across different files.  On operating systems that do not have `/dev/urandom`,
users should always specify this extra seed argument to avoid indeterministic
keys, or else use the alternate version which will by default read the compiled
alternate version itself, which might or might not be deterministic, depending
on where and how it's used.


### Features

Implementation details that make `Nyaruko` more obfuscated than usual
programs:

* `Nyaruko` recycles variables and buffers to reduce internal state.
 The variable names are also carefully chosen for mixed-case
 madness.
* `Nyaruko` employs some preprocessor magic to share much of the same
 code and state between the encoder and decoder, and to increase
 occurrences of smileys ;)

Output code has these features:

* Fits nicely under 80 columns, and does not contain any trigraphs.
* Uses a fairly efficient encoding scheme, better than `uuencode` for
 files larger than ~13K, and better than `base64` for files larger
 than 20K.
* Encryption with [ISAAC](https://en.wikipedia.org/wiki/ISAAC_&#x28;cipher&#x29;), a
cryptographically secure pseudorandom number generator.
* Trivial 3 language polyglot.

Code layout is meant to resemble
[Nyaruko](https://en.wikipedia.org/wiki/Nyarlathotep), also known as
`Nyarlathotep`, the Crawling Chaos.  The most obvious thing to do with chaos is
to make a random number generator, and the most obvious thing to do with a
random number generator is to make
[one-time-pads](https://en.wikipedia.org/wiki/One-time_pad) for encryption.


### Compatibility

`Nyaruko` has these environment dependencies:

* Requires ASCII character set.
* Assumes `sizeof(unsigned int) == 4`.
* Best viewed with tab stops set to 8 spaces.

Output code has the same dependencies, with the additional
requirement that the compiler must support arbitrarily long string
literals.  Maximum input size that can be encoded while still
producing standard-compliant output is ~276 bytes for C89, and ~3168
bytes for C99.

`Nyaruko` has been to verified to work with these compiler/OS
combinations:

* gcc 4.4.5 on Linux (32bit and 64bit)
* clang 3.1 on Windows (Cygwin)
* gcc 4.5.3 on Windows (Cygwin)
* gcc 4.5.3 on Windows (MingW)
* gcc 4.3.5 on JSLinux
* tcc 0.9.25 on JSLinux

Note that on MingW, `stdin` and `stdout` are not opened in binary mode by
default, this means `Nyaruko` may not faithfully encode files on MingW.


### Extra files

[spoiler.html](spoiler.html) - Contains full recording of how the code went from
blank state to an obfuscated program, gzipped to fit under 1MB. Requires
JavaScript.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
