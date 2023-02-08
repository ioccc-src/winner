# Homage to a classic game

Sandro Maffiodo  
<smaffer@gmail.com>  
<http://www.assezeta.com/sandromaffiodo>  


## Judges' comments:
### To build:

    make

### To run:

    cat mario.level | ./prog 320 200 800 300 128 144 mario.rgba mario8.wav 10343679

### Try:

    cat giana.level | ./prog 320 200 1000 300 192 168 giana.rgba giana8.wav 5459393

    cat mario.level | ./prog 320 200 800 300 128 144 mario.rgba mario8.wav 10343679 && telnet towel.blinkenlights.nl

### Selected Judges Remarks:

A classic for a particular generation. Like all good programs, being data
driven means you can do fun things in small spaces.

## Author's comments:
### Remarks

Use tabsize=4 to see the magic

	./expand -t 4 < prog.c

The program returns 0 if the user win or *not-zero* if loose so you can test it and make something useful (or not), like that:

	cat mario.level | ./prog 320 200 800 300 128 144 mario.rgba mario8.wav 10343679 && telnet towel.blinkenlights.nl

This is an engine for **Platform Games**. It can be used to create games like the legendary [Super Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.).
With this simple and clear sourcecode you can create all the games you want, for free!

In my two tests i tried to create one level of [Super Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.) and one of [The Great Giana The Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters).
Both games are classic *platform games* and both share the same fundamental rules:

- there is a player
- there is a powerup that can change the look of the player and/or give to him/her more power!
- there are walls, floors and ceilings. the player can move and jump over these type of obstacles but cannot walk through them
- there are enemies and, if the player collides with an enemy, the player dies or loses its powers

### Regards running under Mac OS X

The color of the sky is wrong on MacOS. You need to flip some bytes from the last parameter of the program:

	MARIO LAST PARAMETER: 4292124159

	GIANA LAST PARAMETER: 3243070463

### Regarding how to compile

The code requires libSDL1.X.

The build process will generate some warnings  (60~ on clang) about:

- **incompatible pointer types**: because all pointers are declared to *int* or *char*, to save tokens
- **type specifier missing, defaults to 'int'**: because i need to save tokens
- **using the result of an assignment as a condition without parentheses**: because while(c=getchar()) is not evil

### How it works

## Parameters

1. Window width
2. Window height
3. Level width
4. Level height
5. Sprites image width
6. Sprites image height
7. Filename of the sprites image (raw RGBA image)
8. Filename of the music (WAVE 8000 Hz 8bit Mono)
9. Sky color. This number depends on the system where you run the program. See **NOTE on MacOS**

## Sprites

The program read a single image that contains all the game sprites. The image must be a grid of 8xN sprites. The size of a single sprite must be square. The program calculates the size in this way:

	sprite_size = image_width / 8

Each sprite is identified by its position inside the grid, counting line by line, from left to right (for example sprite 0 is the top left sprite in the grid, sprite 8 is the first sprite of the second row of the grid).

Some positions of the grid have a predefined purpose:

Position          | Description
:-----------------|:--------------
0                 | Player stand right
1                 | Player walk right frame 0
2                 | Player walk right frame 1
3                 | Player jump right
4                 | Player stand left
5                 | Player walk left frame 0
6                 | Player walk left frame 1
7                 | Player jump left
8 *(second row)*  | Super player stand right
9                 | Super player walk right frame 0
10                | Super player walk right frame 1
11                | Super player jump right
12                | Super player stand left
13                | Super player walk left frame 0
14                | Super player walk left frame 1
15                | Super player jump left
24                | Player dead
32                | Player win
40                | Super player win

All the others sprites can be used as you want, depending on the game you want to create.

## Levels

The program reads the level description from **stdin**.

The level description is a sequence of rows where each row describe an object. You can input as many objects as you want but the maximum number of objects handled by the program is 333. You can modify this value by editing the source here:

	C[333*7],d=333;

Each row have six columns:

1. Screen X: x position of the object in the level
2. Screen Y: y position of the object in the level
3. Sprite: id of the sprite to be used for the object
4. CLASSFLAGS: a bitmask that describe how the object behaves
5. CLASSPARAM0: a parameter that depends on CLASSFLAGS
6. CLASSPARAM1: a parameter that depends on CLASSFLAGS

CLASSFLAGS must be a combination (bitwise or) of some of these constants:

NAME       | CONSTANT  | CLASS
:----------|:----------|:---------
ENEMY      | 1         | An enemy. CLASSPARAM0 can be 0 if the enemy don't move, 1 if the initial move direction is right, -1 if direction is left. All enemies that walk will change its direction after 20 pixels. The sprite of an enemy must have 2 others adjacent sprites: SPRITE-1, used when the enemy die, and SPRITE+1, used when it walks
BLOCK      | 2         | A wall. Player can walk over the object but can not pass through it
GIFT BLOCK | 4         | When the player hits the object from below, a new object is created. CLASSFLAGS of the new object is defined in CLASSPARAM0. The sprite used for the new object is defined in CLASSPARAM1. The sprite of the gift object must have an adjacent sprite: SPRITE+1, used when the block is hit
POWERUP    | 8         | This is the classic Mario's mushroom. When the player hit the powerup object, the player become  *Super player*. If CLASSFLAGS has the bit ZOOM, the player height will be doubled.<br>The *Super player* can hit the enemies without die, but when this happens, the *Super player* goes back to being normal
END         | 16       | When the player hits this object the level ends. Player win
ZOOM        | 32       | This flag can be used with POWERUP to indicate a powerup that will doubles the size of the player (like Mario's mushroom)
DESTROY     | 64       | When the player hits the object the object disappear. This is the classic Mario's coin, but the engine does not counts the points, so, from the user point of view, this object is useless
DESTROYUP   | 128      | This object is like a BLOCK but when the player hits the object from below, the object disappear

If CLASSFLAGS is zero the object has only an aesthetic function.

The last row of the level descriptor must have all its columns set equal to -1.

### Limitations

Some classical features are missing: throw objects, shoot, multiple lives, points counter. You can add those features if you want!

The program allow to run one level only. It's easy to add a menu and multiple levels but the size of the engine will grow too much.

When the *Super player* become bigger (ZOOM flag), the player can collide with blocks and get stuck inside them. This is a KNOWN BUG. When your player become bigger, stay away from blocks!

There is one audio track only (game effects are missing).

### Credits

Some of the sprites used in the examples are identical to those of the original games, others were designed by me.

The music used in the examples have been resampled, starting from the original versions for the [Commodore Amiga](http://en.wikipedia.org/wiki/Amiga) and [Nintendo NES](http://en.wikipedia.org/wiki/Nintendo_Entertainment_System).

[Super Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.) is a game created by Nintendo Entertainment, my use of the sprites does not intend to infringe the intellectual property of Nintendo but only demonstrate the operation of the program. From my point of view this is a tribute to the legendary game [Super Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.)!

[The Great Giana The Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters) is the game created by Time Warp Productions and also for this game worth my previous notes. Long live [The Great Giana The Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters) !! :)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
