## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2024/kurdyukov4 in bugs.html](../../bugs.html#2024_kurdyukov4).


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


### Large input size issues

The author, [Ilya Kurdyukov](../../authors.html#Ilya_Kurdyukov), was
kind enough to provide us with an improvement to his amazing code that
allows for larger input sizes.  To see what was patched run the following
within the `2024/kurdyukov4` directory:

``` <!---sh-->
    make make diff_orig_prog
```

The above patch extended the original standard input size limit from 128K bytes to 64M bytes.

While the [2024/kurdyukov4/try.sh](%%REPO_URL%%/2024/kurdyukov4/try.sh) script will attempt
to run the code in steps starting from 64K of random data up to 64M bytes of random data,
it is unlikely that you will be able to limitations by the compiler, linker, processor
architecture, memory, system, other resource limits if not run out of patience.

On fairly normal systems, we experienced the following while running
[2024/kurdyukov4/try.sh](%%REPO_URL%%/2024/kurdyukov4/try.sh):

```
    | random |        |    C code |  compile time |   compile time |                            |
    |  input | try.sh |   size in |  clang 17.0.0 |     gcc 11.5.0 |                            |
    |  bytes |  stage |     bytes | Apple silicon |         x86 64 | notes                      |
    |--------|--------|-----------|---------------|----------------|----------------------------|
    |    64K |  test3 |    515764 |        10 sec |         75 sec | gcc 7.5x slower than clang |
    |     1M |  test4 |   3939019 |        80 sec |  1 hour 15 min | gcc  56x slower than clang |
    |     4M |  test5 |  13296449 |  1 min 50 sec | 14 hour  2 min | gcc 460x slower than clang |
    |    16M |  test6 | 136786072 |  4 min 40 sec |      very long | clang excutable crashes    |
    |    64M |  test7 | 200412713 | 44 min 40 sec | extremely long | clang excutable crashes    |
```

We never had the time nor resources to attempt to compile using `gcc(1)`, the code needed for
any random input larger than 4M bytes.

For 16M bytes and larger on Apple silicon, for random input size of 16M bytes and 64M bytes,
the `clang(1)` linker phase issues the following warning:

> ld: warning: atom '\_main' ... is larger than the max code size between branch island clusters,
> this may lead to unreachable branches

If you attempt to run the `clang(1)` generated executable anyway, is crashes with:

> segmentation fault

Compiling `gcc(1)` with a random input size of 16M bytes and 64M bytes was **never attempted**
because such a compile attempt would **take too long** and require a **large amount of ram**.

**PLEASE NOTE**: The above problems are **NOT** code bugs.  They represent compiler mis-features,
linker limitations, and/or architecture limitations.

**macOS NOTE**: The macOS `/usr/bin/gcc` is actually `clang(1)`, and so using `gcc(1)` under macOS doesn't count.


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
