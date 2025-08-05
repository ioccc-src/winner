## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

It is necessary to avoid collisions with C keywords when generating names for variables, for example: if do asm int for EOF.

The original code had a collision with the keywords "asm" and "int", now it is fixed.

Also, the size of the static buffers has increased from 1MB to 16MB, which should ensure processing of at least 4MB of input. If you want to increase the limit, look for `24` in the source code (this is a power of two, for 8MB of input data you would need `25`, and so on).

Current code was tested with an input of 1MB.


## To use:

``` <!---sh-->
    ./prog < data > out.c
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This program assembles data from standard input and write C code on standard output:

``` <!---sh-->
    ./prog < input > out.c
```

When if you have the patience to compile and if your C compiler does not object,
the resulting program when run:

``` <!---sh-->
    cc out.c -o out
    ./out > output
```

re-assemble the original input **WITHOUT USING ANY LITERALS** in the C code it produced!

You mind may go into a spiral as you attempt to read and understand how this is done.  :-)


## Author's remarks:


### No Literals Encoder

This program creates C code that will output the specified data to stdout. There are no literals used in the generated code.

- Binary data is supported.
- If there was a lot of data on the input (even just 64KB), then compiling the generated code can be a good stress test for the compiler.
- Why a spiral? I don't know, just because it looks cooler this way.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
