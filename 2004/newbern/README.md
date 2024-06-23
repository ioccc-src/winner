## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./newbern [file.dat arg]
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

The program is formatted using the same font glyphs as the example
data file.


## Author's remarks:

This is a configurable `banner(1)`-like program.


### Examples:

- To convert a character glyph into a data file:

``` <!---sh-->
    ./newbern char < some_nicely_shaped_text >> data_file
```


- To print a string using glyphs from a data file:

``` <!---sh-->
    ./newbern data_file a_string
```


### Extra functionality

The program can also act as a Morse encoder, unarguably.

It also has double-super-secret encryption capabilities.
Decryption is left as an exercise for the reader.


### Portability

The program assumes an ASCII operating environment.

The program is best viewed with tab-stops set to 8.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
