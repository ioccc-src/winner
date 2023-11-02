# Best Obfuscated Character Set Utility

Ken Huffman\
Applied Innovation Inc\
5800 Innovation Dr.\
Dublin, OH 43016\
US\
<http://www.huffmancoding.com>\
huffmancoding@gmail.com


## To build:

```sh
make all
```


## To use:

```sh
echo 'Huffman Decoding' | ./huffman
```

NOTE: this program uses `gets()` so you will likely get a warning when compiling
and/or running on modern systems.


### Try:

```sh
echo 'seeing or feeling is believing' | ./huffman
echo 'CC OR NOT CC' | ./huffman
echo 'CC OR NOT CC' | ./huffman | ./huffman
```


## Judges' remarks:

If you are still confused and want to read a spoiler, check out
the source and it will be clear as mud!

And for a misleading hint, consider who won!  :-)

And if you really can't see what is going on, here is an extra spoiler:

```sh
./huffman < huffman.c
```

This entry was very well received at the IOCCC BOF.


## Author's remarks:

This filter program is really not obfuscated code.  It compiles cleanly
with an ANSI C compiler and comes with user documentation that even a
blind person could read.

The program is a bidirectional filter with the output of the program\
suitable for its input.  The output of this program, when used as input,
undoes the original program filtering.

This program accepts any alphanumeric text that has lines less than 100
characters.  The user is encouraged to use the program's source as input
to the executable.

This program is best appreciated on a tactile monitor.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
