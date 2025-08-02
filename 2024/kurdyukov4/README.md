## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: known bug - please help us fix**

For more detailed information see [2024/kurdyukov4 in bugs.html](../../bugs.html#2024_kurdyukov4).

In fixing this bug you will come to a better appreciation of how the
code was able to process random data files as large as 64K.


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
