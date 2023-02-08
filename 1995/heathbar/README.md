Best Layout:

    Heather Downs, Selene Makarios
    The Software Bungalow
    900 High School Way, #2202
    Mountain View, CA 94041
    USA


Judges' comments:

    To use:
	make heathbar

    To run:
	heathbar 4253 2281

    The main reason we liked this entry was mainly because the main
    effect of the source was self documenting!  :-)


Selected Author's comments:

    Run this program with two non-negative integer arguments
    (e.g. "prog 1234 999").

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
    if you don't mind a little constructive criticsm, some of them are
    kind-of hard to figure out. I didn't want my program to fall into
    the same trap, so I went out of my way to write self-documenting
    code.  Anyone who so much as glances at my program will immediately
    see that it adds two 16-bit unsigned integers by streaming their
    bits through a simulated cascade of hardware adders. I hope my
    diligent effort to write especially clear code gets me extra points!

    P.S. What does "obfuscated" mean?
