## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dorssel
    # input some text

    echo text | ./dorssel
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

How does the program decide which way to convert?

What obsolescent feature are we talking about?  (No, it's not a
C language feature.)

The author suggests that you try to answer the following questions:

- Which character in the initializing string is totally irrelevant?

- Which two relevant characters in the initializing string may be exchanged
without altering the behavior?

- Which characters in the initializing string are somewhat irrelevant, and to
what values may they be changed without altering the behavior?

- Which characters may be used to enlarge the initializing string by one without
altering the behavior ?


### Extra credit:

Try doing what the last part of the last command in [try.sh](%%REPO_URL%%/1998/dorssel/try.sh) suggests.
As in, do the following:

``` <!---sh-->
    echo ". -..- . .-. -.-. .. ... .
    -.-. .... .- -. --. .  - .... .  .--. .-. --- --. .-. .- --  ... ---  .. -  -.. --- . ...  -. --- -  ... .... --- ..- -" | ./dorssel
```

and make the necessary adjustments.

You might also want to read the [dorssel.html](dorssel.html) file.


## Author's remarks:

### Usage

This program converts ASCII to [Morse
code](https://en.wikipedia.org/wiki/Morse_code), and vice versa.

The program reads in lines from standard input and writes its result to
standard output.  The direction of conversion is determined on a per
line basis.  Each line must consist of a maximum of 952 characters
followed by a new line character and they must not contain any NUL
characters.  Otherwise, some characters may be lost in the conversion.

- Encoding to Morse code: The program knows the Morse codes for all Latin
letters (a-z, case insensitive) and decimal digits (0-9).  Any other characters
are replaced by an ASCII space, `' '`.  Morse code per converted character is
written as a sequence of `.` and `-` characters, each sequence followed by a
space.

- Decoding from Morse code: Morse code should be typed as sequences of `.` and
`-` characters, separated by a space.  Extra spaces will be echoed back (to
separate words).  Unknown sequences will be converted to a `?` character.

### Notes

The program assumes both source and execution character sets to be
ASCII.  As far as I can tell, the program is conforming and does not
invoke undefined behavior.

### Hints

Try:

``` <!---sh-->
    ./dorssel < dorssel.c | ./dorssel
```

to see what variables, numbers, and functions are used.  (Does a
better job than most C beautifiers).

- Filter your text twice (as in the previous sample) to obtain a version of your
text that can be reversibly Morsified, i.e.

``` <!---sh-->
    ./dorssel < dorssel.c | ./dorssel | ./dorssel | ./dorssel
```

is the same as

``` <!---sh-->
    ./dorssel < dorssel.c | ./dorssel
```


### NOTICE to those who wish for a greater challenge

**If you want a greater challenge, don't read any further**:
just try to understand the program without running the command below.

If you get stuck, come back and run the following command:

``` <!---sh-->
    ./dorssel < dorssel.md
```


### NOTICE to those who wish for a greater challenge

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.

- The file [dorssel.html](dorssel.html) contains all the information needed to
understand this program.  For spoiler information, try:


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
