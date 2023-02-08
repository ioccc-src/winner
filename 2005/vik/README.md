# Most circuitous walk

Daniel Vik
926 Genter Street
La Jolla Ca 92037
USA
daniel@vik.cc

## Judges' comments

An amazing use of the X libraries with twisty code passages,
all different.  One risks running in code path circles as main is
called again and again.  be sure to pay attention to commas!  :-)

### To build

        cc -O3 -ansi vik.c -L/usr/X11R6/lib -lX11 -lm -o vik

### To run

        vik
        vik maze.map

## Author's comments

This entry is a Wolfenstein style graphics engine where a user can navigate in
a 3D world. The maze has walls with bitmap textures. The application contains
a default world with textures, but the power of the engine is exposed through
user configured maps. User defined worlds support up to 26 different wall
textures that can even be animated. One example of a user defined world is
submitted with the entry.

### Features

This program is a complete 3D engine with

  * Easy configurable maze maps
  * Up to 26 differnt bitmap textures in a maze
  * Support for animated bitmap textures
  * Uses default bitmaps in case the configured bitmaps can't be found
  * A default map in case no one is specified
  * Configurable window size
  * Navigation using cursor keys (rotate left and right, move forward and
backward)

### Build and Run

Compile the source code and link x libraries if nessecary. The program takes
three options which have to be typed in a specific order as described below.

        Usage: prog [-w <width>] [mapfile]
        width   - Specifies the width of the window
        mapfile - Filename containing a map

Here are a few examples:

> | Command line:            | Description:           |
> | ------------------------ | ---------------------- |
> | $ ./prog                 | Starts the engine using a built in labyrinth and texture bitmaps |
> | $ ./prog maze.map        | Starts the engine and loads the labyrinth defined in the file maze.map |
> | $ ./prog -w 400 maze.map | Starts the engine using maze.map in a window that is 400 pixels wide |

Note that the mapfile has to be the last argument and the -w option if present
has to be the first. The map definition files and the bitmap files should be
located in the current directory.

Use the cursor keys to navigate through the labyrinth.

### Creating mazes

A maze consist of a map file and texture bitmap files. The map file is an
ascii text file where lower case letters represent walls. The letter tells the
engine what bitmap texture file to use. The '*' character lets the engine know
where to position the user. The example below shows how a map file can look:

       aaaaaaaaaaaaa
       a           a
       a      *    a
       a    bbbb   cccccccc
       c                  c
       cccccccccccccccccccc

The engine loads the map, and creates walls. When a character 'a'-'z' is found,
the engine will load the corresponding texture bitmap. The bitmap file must be
named `*.bmp` where `*` is substituted with the letter of the wall in the map.

So to load the map above, the files `a.bmp`, `b.bmp`, and `c.bmp` should be
located in the same directory as the engine executable (or rather in the
current directory).

### Obfuscation

The program is obfuscated in several ways, bad use of variables, use of the ?
operator, recursive calls to main, bad use of for variables and the comma
operator. To make the final obfuscated touch I ran indent which really made
the program unreadable (I guess that is not really the intent with indent ;)

### Compiler warnings

There are no compiler warnings when compiling with -ansi but there are quite
many warnings from lclint. Mainly because the program is very optimized for
code size.

### Limitations

The program only compiles and runs on X based systems.

The program does not run that smooth under cygwin. It seems to be a priority
issue with cygwin and it can easily be solved by increasing the priority of
the application a little bit.
