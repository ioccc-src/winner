# Best Font Engine

    Jeff Newbern
    28 Jeanette Ave. #1
    Belmont, MA 02478

## To build:

```sh
make
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) and Landon individually
fixed this to work with clang. Cody turned the second arg to main, which clang
requires to be a `char **`, to be not the same name as a function defined
earlier in the code and to use that variable which `main()` used. Thank you Cody
for your assistance!


## To run:

```sh
./newbern [file.dat arg]
```

## Try:

```sh
./newbern newbern.dat "IOCCC 2004"
echo SOS | ./newbern
```

## Judges' remarks:

The program is formatted using the same font glyphs as the example
data file.

## Author's remarks:

This is a configurable banner-like program.

### Examples:

- To convert a character glyph into a data file

```sh
./newbern char < some_nicely_shaped_text >> data_file
```

- To print a string using glyphs from a data file

```sh
./newbern data_file a_string
```

### Extra functionality:

The program can also act as a Morse encoder, unarguably.

It also has double-super-secret encryption capabilities.
Decryption is left as an exercise for the reader.

### Portability:

The program assumes an ASCII operating environment.

The program is best viewed with tab-stops set to 8.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
