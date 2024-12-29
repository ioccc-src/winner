## To build:

``` <!---sh-->
    make all
```

There is alternate code which allows one to change the size of the maze. See
[Alternate code](#alternate-code) below.


### To run:

``` <!---sh-->
    ./shapiro
```


## Alternate code:

The code has a define `C` set to 39 but this can be modified to change the size
of the maze. The alternate code allows one to easily do this.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate try:

If you wish to change the value you can do it like:

``` <!---sh-->
    make clobber SIZE=5 alt
```

Note that if it is not a number then obviously there will be a compilation
error. If it's <= 0 || >= 5000 then it is set to 39, the default.

You might also wish to try:

``` <!---sh-->
    ./try.alt.sh
```

This script will compile the program five times with a random value and then
prompt you in an infinite loop for values to try, exiting only if non-digits are
in the input.

Also try printing out various sized mazes and solving them with pencil or pen or
in your head.


## Judges' remarks:

As submitted, this program was 3 lines (two `#define`s, one code).
To make news & mail happy we split the last line into seven lines.

This program was selected for the 1987 t-shirt collection.

We found this program is be simply a**maze**ing! Run this program without
arguments and notice the output.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
