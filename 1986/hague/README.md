# Worst abuse of the C preprocessor

Jim Hague    
UK  

## To build:

```sh
make all
```

There is an alternate version which uses `fgets()`. See the Alternate code
section below as well as the [bugs.md](/bugs.md) file for more details as to why
it is worth having as an alternate version.

## To run:

```sh
./hague
# enter some text
```

## Try:

```sh
./hague
IOCCC
International Obfuscated C Code Contest
Jim Hague
```

Also try:

```sh
echo IOCCC | ./hague
```

### Alternate code:

Whereas with some entries the change to `fgets()` (see the [FAQ](/faq.md) for
details on why this has been done) can be done in the original code this entry
is more complicated in that although both forms of input show the correct
output, one form segfaults after the output.

If you wish to use this alternate code, do:

```sh
make alt
```

Use `hague.alt` as you would `hague` above. As for which form will segfault
after outputting the text it is when text is piped into the program. Again see
the [bugs.md](/bugs.md) file for more details.



## Judges' remarks:

Compile this program and feed ASCII text into standard input.  This
program is known to pass lint on some systems and abort lint on
others.

This program was selected for the 1987 t-shirt collection.

Think Morse code when you ponder this program.  Note how use of
similar variables can be obfuscating!  The author noted that this
program implements the international Morse standard.  Now for extra
credit, what Morse message does the program spell out?

## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
