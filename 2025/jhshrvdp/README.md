## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC29 - 2025/jhshrvdp - Most likely to teleport](https://www.youtube.com/watch?v=_LSMQOuul20)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    # A - move left
    # D - move right
    # W - move up
    # S - move down
    #
    # T - teleport if score>=3. Lowers score with 3
    # Q - quit

    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Up, down, left, and right: stay away from your those moving carrots ("^"),
grab the cash ("$"), use the stairs (">" "<"), and teleport if you must!
You are in a maze of C code, for which if you are code spelunker, you
will find an impressive maze of logic!


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#jhshrvdp) for this winning entry.


## Author's remarks:


## What does the entry do.

It is a rogue-like game with a finite amount of procedurally generated
levels that you play in the terminal.  You are the '@' symbol. Enemies are
'^'. Score points are '$'. Walls are '#'. You travel up/down floors with
'>'/'<'. Enemies will chase you and they deal contact damage. Health
regenerates back over time.


### Controls

```
    A: move left
    D: move right
    W: move up
    S: move down

    T: teleport if score>=3. Lowers score with 3.
    Q: quit
```

You can load specific game states by passing the information inbetween {}
after argv in the game hud as the program's first argument:

```
    ./prog 'game state data'
```


## How to entice it to do what it is supposed to do.

<p>Just run it without arguments. If you want to load a 'save file', pass it as the first argument. You can whisper sweet words to it if you want, it might like that. You need to have ncurses installed.</p>


## What obfuscations are used.

- One letter or otherwise non-sensible variable and function names.
- Purposefully omitting curly braces, normal braces, etc.
- Operations / steps are liberally squished and nested into each other.
- Everything is a nice juicy global. Variables are (re)used for multiple purposes.
- Variable shadowing.
- Undressing all enums / constants into magic numbers. Everyone gets their Hogwarts letter.
- Constants are sometimes written in different number systems.
- Breaking up keywords across multiple lines.
- Macros. Macros inside macros.
- plain-text strings are encrypted with a [Caesar cipher](https://en.wikipedia.org/wiki/Caesar_cipher).
- Digraphs.
- Code that is just there for fluff / flavour. It does not do anything.
- Ternary statement = is ? love : life.
- Using comma operator like Uncle Roger uses MSG in egg fried rice.
- Substituting logical operators with bitwise operators.
- Labels instead of loops.
- bitwise f~cker& like it's Katy Perry's Hot N Cold.
- Reversing array access syntax order (i[a] instead of a[i])
- The code is formatted in a special way. What do you mean this is C code? It's just a lil' guy! :)


## What are the limitations of your entry in respect of portability and/or input data.

- You need to have ncurses installed to compile / run it.
- It runs in a terminal that needs a minimum width of 80 characters and a minimum height of 24 lines.
- Because of the ncurses dependency it is limited to Linux only.
- It does not depend on any compiler-specific tricks to work. Compiles without any warnings (tested with gcc).
- It can take one argument as input: a string describing the game state you wish to load in as 'save file'. Putting in a wrongly formatted string (incorrect start, incorrect number of arguments, incorrect values) will cause the program to reject it and continue as if you did not input anything. Manually editing it to give yourself more score or change your position is possible.
- - Example string = :69879ddb:00:0a:10:43:00:


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
