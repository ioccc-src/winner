## To build:

``` <!---sh-->
    make
```

There are alternate versions of this entry. See [Alternate
code](#alternate-code) below for more details.


## To use:

``` <!---sh-->
    ./prog
    # input some text

    echo text | ./prog

    ./prog < file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

There are a number of alternate versions for this program, some in C and some in
assembly.

The file [prog.alt.c](%%REPO_URL%%/2020/kurdyukov1/prog.alt.c) is smaller and does not contain any
headers or any workaround for WIN32 based platforms.

The file [prog.extra.c](%%REPO_URL%%/2020/kurdyukov1/prog.extra.c) has a number of layouts including some for
different social media profile covers as well as different shapes.

The files [prog.x86_64.asm](%%REPO_URL%%/2020/kurdyukov1/prog.x86_64.asm) and [prog.x86.asm](%%REPO_URL%%/2020/kurdyukov1/prog.x86.asm)
are the program in assembly for x86_64 linux and x86 linux respectively.


### Alternate build:

To build [prog.alt.c](%%REPO_URL%%/2020/kurdyukov1/prog.alt.c):

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


## Judges' remarks:

This hash of a C code makes a hash out of input.
Do you understand how?
You should get a-round-to-it figuring it out!


## Author's remarks:

### MD5 with integers

Just a tiny MD5 checksum utility. Prints hash string of data from `stdin`.
Works the same as `openssl md5 | cut -d' ' -f2` command.

### My objectives

1. Reduce code size as much as possible.
2. Avoid warnings from gcc/clang `-Wall -Wextra -pedantic`.
3. Portable (regardless of register size and endianness).
4. Fit code in a round shape.
5. Mo macro defines.
6. No floating-point arithmetics.


### Notes

The main difficulty of making MD5 code smaller is a 64x4 bytes long table with
constants which will take more than 512 bytes in hex encoding. This table is a
results of a sine function, so can be generated dynamically, but merging
floating-point arithmetics with precise integer calculations is not a great
idea, because it can cause portability issues.

Attempts to satisfy `clang -Weverything` will ruin comma magic, that is so great
for obfuscation, so I don't want to care about that.

Probably, should work correctly on any machines, but I have nothing exotic (like
BE or not 32/64) to try it.

Added a macro hack to make `stdin` work in binary mode under Windows (tested
under mingw64), otherwise the hashes can be incorrect.


### Bonus

- [prog.extra.c](%%REPO_URL%%/2020/kurdyukov1/prog.extra.c) is the same with the sine function (so smaller),
and in different shapes.

- [prog.x86_64.asm](%%REPO_URL%%/2020/kurdyukov1/prog.x86_64.asm) contains the same program, but written in
assembly for x86_64 Linux, for the sake of smaller executable size which is 500
bytes long (where 120 is for the ELF headers) after compilation. Algorithm
details is slightly different (like constants packing), just to make smaller
binary code. It's interesting to compare density of binary code and obfuscated
C.

- [prog.x86.asm](%%REPO_URL%%/2020/kurdyukov1/prog.x86.asm) is for x86, although the headers are smaller, but
the binary code is larger due to fewer registers and lack of 64-bit multiply.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
