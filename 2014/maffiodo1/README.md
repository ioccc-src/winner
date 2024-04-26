## To build:

This entry requires SDL to be installed. See [FAQ 3.8](../../faq.html#SDL) if you
don't know how to do this for your system.

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2014 maffiodo1 bugs](../../bugs.html#2014_maffiodo1).


## To use:

``` <!---sh-->
    cat game.level | ./prog 320 200 800 300 128 144 game.rgba game.wav 10343679
```

The parameters to the program are:

1. Window width.
2. Window height.
3. Level width.
4. Level height.
5. Sprites image width.
6. Sprites image height.
7. Filename of the sprites image (raw RGBA image).
8. Filename of the music (WAVE 8000 Hz 8bit Mono).
9. Sky color. This number depends on the system where you run the program. See
note on macOS.


## Try:

``` <!---sh-->
    ./giana.sh

    ./mario.sh
```

If you end up telnetting to the server (feature of [mario.sh](%%REPO_URL%%/2014/maffiodo1/mario.sh) script) you can
try:


```
    ls # show files including games
    wumpus.bas # play Hunt the Wumpus
    advent.gam # you know what this is! :-)
    starwars # animated Star Wars 'film'
```

If you wish to change the width and height, defaulting at 640 x 480, say to
800 x 800, try:

``` <!---sh-->
    ROWS=800 COLS=800 ./mario.sh

    ROWS=800 COLS=800 ./giana.sh
```


## Judges' remarks:

A classic for a particular generation. Like all good programs, being data
driven means you can do fun things in small spaces.

NOTE: the author states to use `tabsize=4` to see the magic of the formatting of
the code. In `vim` you can do:

```
    :set tabstop=4
```

in command mode to see this effect. You don't need to modify your `.vimrc` file!
You can also use `expand` as described below by the author if your terminal has
enough rows and you don't want to move about in the code. The vim command should
immediately take effect.


## Author's remarks:

### Remarks

Use `tabsize=4` to see the magic.

``` <!---sh-->
    expand -t 4 prog.c
```

The program returns 0 if the player wins or *non-zero* if the player loses so
you can test it and make something useful (or not), like this:

``` <!---sh-->
    cat mario.level | ./prog 320 200 800 300 128 144 mario.rgba mario8.wav 10343679 && telnet telehack.com 23
```

and type in: `starwars`


This is an engine for [platform
game](https://en.wikipedia.org/wiki/Platform_game). It can be used to create
games like the legendary [Super Mario
Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.).

With this simple and clear source code you can create all the games you want,
for free!

In my two tests I tried to create one level of [Super Mario
Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.) and one of [The Great
Giana Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters).

Both games are classic [platform
games](https://en.wikipedia.org/wiki/Platform_game) and both share the same
fundamental rules:

- There is a character.

- There are power-ups that can change the look of the character and/or give the
character more or different powers or abilities!

- There are walls, floors and ceilings. The character can move and jump over
these type of obstacles but cannot walk through them.

- There are enemies and if the character collides with an enemy, the character
dies or loses its powers.


###  Running under macOS

[NOTE: this seems to no longer be the case as of 2023 and most likely much
earlier. However one can change the look of the game doing this anyway:]

The color of the sky is wrong on macOS. You need to flip some bytes from the
last parameter of the program:

* MARIO LAST PARAMETER: `4292124159`

* GIANA LAST PARAMETER: `3243070463`


### Regarding how to compile

The code requires `SDL1`.

The build process will generate some warnings (~60 with clang) about:

- `incompatible pointer types`: because all pointers are declared to `int` or
`char`, to save bytes.
- `type specifier missing, defaults to 'int'`: because I need to save bytes.
- `using the result of an assignment as a condition without parentheses`:
because `while(c=getchar())` is not evil.


### How it works

## Parameters

1. Window width.
2. Window height.
3. Level width.
4. Level height.
5. Sprites image width.
6. Sprites image height.
7. Filename of the sprites image (raw RGBA image).
8. Filename of the music (WAVE 8000 Hz 8bit Mono).
9. Sky color. This number depends on the system where you run the program. See
note on macOS.

## Sprites

The program read a single image that contains all the game sprites. The image
must be a grid of 8xN sprites. The size of a single sprite must be square. The
program calculates the size in this way:

```
    sprite_size = image_width / 8
```

Each sprite is identified by its position inside the grid, counting line by
line, from left to right (for example sprite 0 is the top left sprite in the
grid, sprite 8 is the first sprite of the second row of the grid etc.).

Some positions of the grid have a predefined purpose:

```
    Position          | Description
    :-----------------|:--------------
    0                 | Player standing right
    1                 | Player walking right frame 0
    2                 | Player walking right frame 1
    3                 | Player jumping right
    4                 | Player standing left
    5                 | Player walking left frame 0
    6                 | Player walking left frame 1
    7                 | Player jumping left
    8 *(second row)*  | Super player standing right
    9                 | Super player walking right frame 0
    10                | Super player walking right frame 1
    11                | Super player jumping right
    12                | Super player standing left
    13                | Super player walking left frame 0
    14                | Super player walking left frame 1
    15                | Super player jumping left
    24                | Player dead
    32                | Player won
    40                | Super player won
```

All the others sprites can be used as you want, depending on the game you want
to create.


## Levels

The program reads the level description from `stdin`.

The level description is a sequence of rows where each row describe an object.
You can input as many objects as you want but the maximum number of objects
handled by the program is 333. You can modify this value by editing the source
here:

``` <!---c-->
    C[333*7],d=333;
```

Each row has six columns:

1. `Screen X`	: `x` position of the object in the level.
2. `Screen Y`	: `y` position of the object in the level.
3. `Sprite`	: `id` of the sprite to be used for the object.
4. `CLASSFLAGS`	: a bitmask that describe how the object behaves.
5. `CLASSPARAM0`: a parameter that depends on `CLASSFLAGS`.
6. `CLASSPARAM1`: a parameter that depends on `CLASSFLAGS`.

`CLASSFLAGS` must be a combination (bitwise OR) of some of these constants:

* `ENEMY` (`1`)

	    An enemy. CLASSPARAM0 can be 0 if the enemies don't move, 1 if the
	    initial move direction is right, -1 if that direction is left. All
	    enemies that walk will change their direction after 20 steps. The
	    sprite of an enemy must have 2 other adjacent sprites: SPRITE-1,
	    used when the enemy dies, and SPRITE+1, used when it moves.

* `BLOCK` (`2`)

	    A wall. Player can walk over the object but can not pass through it.

* `OBJECT BLOCK` (`4`)

	    When the player hits the object from below, a new object is created.
	    CLASSFLAGS of the new object is defined in CLASSPARAM0. The sprite
	    used for the new object is defined in CLASSPARAM1. The sprite of the
	    new object must have an adjacent sprite: SPRITE+1, used when the
	    block is hit.

* `POWERUP` (`8`)

	    This is a power-up like the classic Mario mushroom. When the
	    character hits the power-up object, the character becomes the Super
	    character. If CLASSFLAGS has the bit ZOOM, the character height will
	    be doubled.  The Super character can hit the enemies without dying,
	    but when this happens, the Super character goes back to being
	    normal.

* `END` (`16`)

	    When the player hits this object the level ends; the player wins.

* `ZOOM` (`32`)

	    This flag can be used with POWERUP to indicate a power-up that
	    will double the size of the player (like the Mario mushroom).

* `DESTROY` (`64`)

	    When the player hits the object (e.g. the classic Mario coin) the
	    object disappears but the engine does not count the points, so,
	    from the player point of view, this object is useless.

* `DESTROYUP` (`128`)

	    This object is like a BLOCK but when the player hits the object
	    from below, the object disappears.

If `CLASSFLAGS` is `0` the object only has an aesthetic function.

The last row of the level descriptor must have all its columns set equal to
`-1`.


### Limitations

Some classical features are missing: throwing objects, shooting, multiple lives,
score tracking. You can add those features if you want!

The program allows only one level. It's easy to add a menu and multiple levels
but the size of the engine would too big for the contest.

When the `Super character` becomes bigger (`ZOOM` flag), the character can
collide with blocks and get stuck inside them. This is a KNOWN BUG. When your
player become bigger, stay away from blocks!

There's only one audio track (game effects are missing).

### Credits

Some of the sprites used in the examples are identical to those of the original
games; the others were designed by me.

The music used in the examples have been
[resampled](https://en.wikipedia.org/wiki/Sample-rate_conversion), starting from
the original versions for the [Commodore
Amiga](http://en.wikipedia.org/wiki/Amiga) and [Nintendo
NES](http://en.wikipedia.org/wiki/Nintendo_Entertainment_System).

[Super Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.) is a game
created by [Nintendo Co., Ltd](https://en.wikipedia.org/wiki/Nintendo). My use
of the [sprites](https://en.wikipedia.org/wiki/Sprite_&#x28;computer_graphics&#x29;) does
not intend to infringe the [intellectual
property](https://en.wikipedia.org/wiki/Intellectual_property) of Nintendo but
only demonstrates the operation of the program. From my point of view this is a
tribute to the legendary game [Super Mario
Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.)!

[The Great Giana
Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters) is the game
created by [Time Warp
Productions](https://www.ign.com/games/producer/time-warp-productions) and my
justification for the sprites for Mario are the same for this game. Long live
[The Great Giana
Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters) !! :)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
