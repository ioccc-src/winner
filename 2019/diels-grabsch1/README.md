## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog < file > file.Z
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Finally, IOCCC now has its own text compression program, and it is short enough
to qualify for the Best Short Program award! That said, can you compress it down
to a one-liner, still producing files in the UNIX compress format, albeit
sacrificing the compression ratio?

Can you explain why the `/dev/zero` file compresses identically by the entry and
the standard `compress(1)` tool, see [try.sh](%%REPO_URL%%/2019/diels-grabsch1/try.sh), but the text file
compresses differently? The judges know. :)


## Author's remarks:

### A tiny "compress" tool:

#### Usage:

``` <!---sh-->
    ./prog < input.txt > input.txt.Z
```

#### Example:

``` <!---sh-->
    ./prog < guidelines.txt > guidelines.txt.Z
```

#### Check for correctness:

``` <!---sh-->
    zcat guidelines.txt.Z > guidelines2.txt
    diff -s guidelines.txt guidelines2.txt
```

Of course you can  also use [2015/mills2prog.c](%%REPO_URL%%/2015/mills2/prog.c) instead of
`zcat` to verify the output file. The achieved compression ratio roughly matches
that of the classic Unix `compress(1)` tool. And the source code is very
compressed, too: It has exactly the same size as the  paragraph you are reading
right now. And exactly the same shape. Nevertheless, it is portable C99 code
that runs on 32-bit and 64-bit platforms. It compiles without warnings on both
GCC and Clang even with `-Wextra and -Weverything`.

**2023 note**: the above paragraph might not be true as far as number of bytes goes.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
