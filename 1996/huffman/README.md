## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: uses gets() - change to fgets() if possible
```

For more detailed information see [1996/huffman in bugs.html](../../bugs.html#1996_huffman).


## To use:

``` <!---sh-->
    echo 'Huffman Decoding' | ./huffman
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

If you are still confused and want to run the deobfuscation command, check out
the source and it will be clear as mud!

And for a misleading hint, consider who won!  :-)

And if you really can't see what is going on, try this deobfuscation command:

``` <!---sh-->
    ./huffman < huffman.c 2>/dev/null
```

This entry was very well received at the IOCCC BOF.


## Author's remarks:

This filter program is really not obfuscated code.  It compiles cleanly
with an ANSI C compiler and comes with user documentation that even a
blind person could read.

The program is a bidirectional filter with the output of the program
suitable for its input.  The output of this program, when used as input,
undoes the original program filtering.

This program accepts any alphanumeric text that has lines less than 100
characters.  The user is encouraged to use the program's source as input
to the executable.

This program is best appreciated on a tactile monitor.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
