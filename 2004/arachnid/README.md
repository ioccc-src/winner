# Best use of Vision

Nick Johnson\
New Zealand\
<https://web.archive.org/web/20051030162356/http://www.notdot.net/>


## To build:

```sh
make
```


## To use:

```sh
./arachnid [mazefile]
```


## Try:

```sh
./arachnid arachnid.info
```

and then try:

```sh
./arachnid arachnid.c
```

Navigation is through the use of the `wasd` inverted-T formation on
QWERTY keyboards.  Rogue players, vi users, and Dvorak typists are
invited to get lost (or use the alt version)!


## Alternate code:

To use:

```sh
make alt
```

Use `arachnid.alt` as you would `arachnid` above.


## Judges' remarks:

The fun part comes when you realize that the maze scrolls.  The overall
visual effect is quite pleasing (at least on some displays), and, well,
it's a lot of fun.


## Author's remarks:

This program accepts ASCII formatted mazes as input, and renders
them on screen for the user to explore, complete with Line Of Sight
\- you cannot see parts of the maze your avatar (the `@`) could not
have seen.

The maze files will be interpreted with spaces `' '` as gaps, tilde
`~` symbols (if any) as exits (which get represented as a
[NetHack](https://www.nethack.org) style `<` once loaded), and any other
characters as walls.

Feed the program its own source for a default maze. Running it with no command
line parameters will do this. In a nice symmetry, the character constant `~`
that recognises exits to input mazes itself forms the exit to the default maze.
Another maze, [arachnid.txt](arachnid.txt) has also been provided. This maze is
255x255, about the largest maze supported, for the particularly insane maze
explorers out there.

### Usage

```sh
./arachnid [mazefile]
```

You can explore the maze using the `w`,`a`,`s`, and `d` keys.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
