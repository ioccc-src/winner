# Best utility

Ilya Kurdyukov  
<https://github.com/ilyakurdyukov>  
Twitter: @ilyakurdyukov  

## Judges' comments:

    make all

### To use:

    ./prog

### Try:

    echo IOCCC | ./prog

    ./prog < prog.x86.asm

    ./prog < prog.x86_64.asm

### Selected Judges Remarks:

This hash of a C code makes a hash out of input.
Do you understand how?
You should get a-round-to-it figuring it out!

An even smaller alternate version of this entry, prog.alt.c, is provided.  This code does not contain any headers, nor any workaround for WIN32 based platforms.  

To compile the alternate program:

    make alt

    echo IOCCC | ./prog.alt
    ./prog.alt < prog.x86.asm
    ./prog.alt < prog.x86_64.asm

## Author's comments:

### MD5 with integers

Just a tiny MD5 checksum utility. Prints hash string of data from stdin.
Work same as `(openssl md5 | cut -d' ' -f2)` command.

### My objectives

1. reduce code size as much as possible
2. avoid warnings from GCC/CLANG `-Wall -Wextra -pedantic`
3. portable (regardless of register size and endianness)
4. fit code in a round shape
5. no macro defines
6. no floating-point arithmetics

### Notes

The main difficulty of making MD5 code smaller is a 64x4 bytes long table with constants. Which will take more than 512 bytes in text hex encoding. This table is a results of a sine function, so can be generated dynamically, but merging floating-point arithmetics with precise integer calculations is not a great idea, because can make portability issues.

Attempts to satisfy CLANG `-Weverything` will ruin comma magic, that is so great for obfuscation, so I don't want to care about that.

Probably, should work correctly on any machines, but I have nothing exotic (like BE or not 32/64) to try it.

Added a macro hack to make stdin work in binary mode under Windows (tested under mingw64), otherwise the hashes can be incorrect.

### Bonus

- `prog.extra.c` the same with the sine function (so smaller), and in different shapes. 

- `prog.x86_64.asm` contains same program, but written on assembly for x86_64 Linux, for the sake of less executable size. Which is 500 bytes long (where 120 is for ELF headers) after compilation. Algorithm details is slightly differ (like constants packing), just to make smaller binary code. It's interesting to compare density of binary code and obfuscated C.

- `prog.x86.asm` and for x86, although the headers are smaller, but the binary code is larger due to fewer registers and lack of 64-bit multiply.


-----------------------------------------------------------------------------------------------------
(c) Copyright 1984-2020, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-----------------------------------------------------------------------------------------------------
