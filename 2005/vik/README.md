## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./vik [file.map]
```


## Try:

``` <!---sh-->
    ./vik maze.map
```


## Judges' remarks:

An amazing use of the X libraries with twisty code passages, all different.  One
risks running in code path circles as `main()` is called again and again. Be
sure to pay attention to commas! :-)


## Author's remarks:

This entry is a [Wolfenstein](https://en.wikipedia.org/wiki/Wolfenstein) style
[graphics engine](https://en.wikipedia.org/wiki/Rendering_&#x28;computer_graphics&#x29;)
where a user can navigate in a
[3D](https://en.wikipedia.org/wiki/3D_computer_graphics) world. The
[maze](https://en.wikipedia.org/wiki/Maze) has walls with [bitmap
textures](https://en.wikipedia.org/wiki/Bitmap_textures). The application
contains a default world with textures, but the power of the engine is exposed
through user configured [maps](https://en.wikipedia.org/wiki/Map). User defined
worlds support up to 26 different wall textures that can even be animated. One
example of a user defined world is submitted with the entry.


### Features

This program is a complete 3D engine with

* Easy configurable maze maps.
* Up to 26 different bitmap textures in a maze.
* Support for animated bitmap textures.
* Uses default bitmaps in case the configured bitmaps can't be found.
* A default map in case none is specified.
* Configurable window size.
* Navigation using cursor keys (rotate left and right, move forward and
backward).


### Build and Run

Compile the source code and link in [X
libraries](https://en.wikipedia.org/wiki/Xlib) if necessary. The program takes
three options which have to be typed in a specific order as described below.

``` <!---sh-->
    ./vik [-w <width>] [mapfile]
```

where:

```
    width   - Specifies the width of the window
    mapfile - Filename containing a map
```

#### Examples

Start the engine using a built in labyrinth and texture bitmaps:

``` <!---sh-->
    ./vik
```

Start the engine and loads the labyrinth defined in the file
[maze.map](%%REPO_URL%%/2005/vik/maze.map):

``` <!---sh-->
    ./vik maze.map
```

Start the engine using [maze.map](%%REPO_URL%%/2005/vik/maze.map) in a window that is 400 pixels wide:

``` <!---sh-->
    ./vik -w 400 maze.map
```

Note that the `mapfile` has to be the last argument and the `-w` option if present
has to be the first. The map definition files and the bitmap files should be
located in the current directory.

Use the cursor keys to navigate through the labyrinth.


### Creating mazes

A maze consists of a map file and texture bitmap files. The map file is an
ASCII text file where lower case letters represent walls. The letter tells the
engine what bitmap texture file to use. The `*` character lets the engine know
where to position the user. The example below shows how a map file can look:

```
    aaaaaaaaaaaaa
    a           a
    a      *    a
    a    bbbb   cccccccc
    c                  c
    cccccccccccccccccccc
```

The engine loads the map, and creates walls. When a character in the range `a-z`
is found, the engine will load the corresponding texture bitmap. The bitmap file
must be named `*.bmp` where `*` is substituted with the letter of the wall in
the map (note that only `a`, `b` and `c` exist).

So to load the map above, the files `a.bmp`, `b.bmp`, and `c.bmp` should be
located in the same directory as the engine executable (or rather in the
current directory).


### Obfuscation

The program is obfuscated in several ways:

* Bad use of variables.
* Use of the `?` operator.
* Recursive calls to `main()`.
* Bad use of `for` loops and the comma operator.
* To make the final obfuscated touch I ran indent which really made the program
unreadable (I guess that is not really the intent with indent ;) )


### Compiler warnings

There are no compiler warnings when compiling with `-ansi` but there are quite
a few warnings from `lclint`. Mainly because the program is very optimized for
code size.


### Limitations

The program only compiles and runs on [X based
systems](https://en.wikipedia.org/wiki/X_Window_System).

The program does not run that smooth under
[Cygwin](https://en.wikipedia.org/wiki/Cygwin). It seems to be a priority issue
with Cygwin and it can easily be solved by increasing the priority of the
application a little bit.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
