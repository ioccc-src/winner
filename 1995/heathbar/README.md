# Best Layout

Heather Downs & Selene Makarios\
The Software Bungalow\
900 High School Way, #2202\
Mountain View, CA 94041\
US

## To build:

```sh
make all
```

## To use:

```sh
./heathbar num num
```

where num is a non-negative number.

## Try:

```sh
./heathbar 4253 2281
```


## Judges' remarks:

The main reason we liked this entry was mainly because the main
effect of the source was self documenting!  :-)

## Author's remarks

Run this program with two non-negative integer arguments
(e.g. `./heathbar 1234 999`).

My goal was to create the fastest possible C program. To that
end, I made three critical observations:

1. If there's one thing computers are good at, it's math.
2. Simple operations take less time than complicated ones.
3. Every C program seems to contain the word "main".

Based on #1, I knew that the Fastest Program had to be one that
performed addition. From #2, I reasoned that it ought to directly
manipulate the bits, rather than wasting time dealing with bloated,
high-level, fuzzy-logic, artificial-intelligence, neural-net,
client-server, object-oriented abstractions like the C language "+"
operator. And it was obvious from #3 that the program should
resemble, as closely as possible, a long sequence of the familiar
word "main" repeated over and over, so the computer would be
comfortable running the program and wouldn't get distracted dealing
with unfamiliar variable names.

Also, I've looked at some past winning entries of your contest, and
if you don't mind a little constructive criticism, some of them are
kind-of hard to figure out. I didn't want my program to fall into
the same trap, so I went out of my way to write self-documenting
code.  Anyone who so much as glances at my program will immediately
see that it adds two 16-bit unsigned integers by streaming their
bits through a simulated cascade of hardware adders. I hope my
diligent effort to write especially clear code gets me extra points!

P.S. What does "obfuscated" mean?

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
