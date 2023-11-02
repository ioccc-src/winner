# Best non-chess game

Oscar Toledo G.\
Mexico\
<biyubi@gmail.com>\
<https://nanochess.org>


## To build:

```sh
make
```


## To use:

```sh
./toledo
```

NOTE: This requires X11 to run or modifications to use [layer.c](layer.c) on
Windows (see below).


### Try:

```sh
echo "Do or do not. There is no try."
```


## Judges' remarks:

This two player game uses X11. The control keys can be configured by
modifying the `A`, `B`, `C` and `D` macros at compilation.

After a quick splash screen the objective should be clear.  There
are Red, Green and Cyan tanks. A larger window can be made by altering
the source early on, right before the code gets hard to follow.

Like Oscar's previous winning X11 program for the 19th IOCCC, if
you remove both the X11 include files and replace them with

```c
#include "layer.c"
```
\
you ought to be able to compile and run this program on Windows.


## Author's remarks:

```
        /=========\\
        \==\   /==/                ||
           || ||   /====\  |\/=\   ||      //==\   ==\ |=\
           || ||       ||  ||  ||  ||  //  ||       =| | |
           || ||   //===|  ||  ||  ||=//   \\=\\   ==/ |=/
           || ||   ||  ||  ||  ||  || \\      ||   User's
           \===/   \\==//  ||  ||  ||  \\  \==//   Manual
```

This  is a color X11 3D tank-game for two players, just compile
and run it without arguments.

You will see briefly a tank spinning before each level.

Left  half  of  the  window shows the red player view and right
half shows the green player view, the background will change to
blue when the view goes inactive.

The  objective  is to chase and destroy the other player's tank,
there  is  also  an  aqua tank for testing your aim and getting
extra points.

> Caveat: You can shoot only 3 bullets at a time.
> Trick: You can fire faster if they explode on anything.
> Believe it or not, it has strategy!

When only one tank remains on the field, the level will advance.
Don't forget to destroy the aqua tank.

The  <strike>battle</strike>playground  is  surrounded by mountains  and each level is
filled with random obstacles (pyramids and cubes).

The  bars  show players energy and score, each bar shows energy
and  indicates  current  player view (wider on the left), right
part grows with every point.

Keys for player 1 (lowercase):

* Tab - Fire
* w   - Go ahead
* s   - Go backwards
* a   - Turn left
* d   - Turn right

Keys for player 2:

* Backspace   - Fire
* Up arrow    - Go ahead
* Down arrow  - Go backwards
* Left arrow  - Turn left
* Right arrow - Turn right

> Note: Numeric keys don't work.

If you don't like the keys assignment, you can change it in the
Makefile.

### PARENTAL ADVISORY WARNING:

This  game  is  highly  violent, when the tank explodes you can
see the little stick man blowing in parts.

Not really, just kidding :D

### PLATFORMS TESTED:

* openSUSE 10.2 x86-32, X11R6 1024x768 32-bits color.
* Fedora Core 8 x86-64, X11R6 1280x1024 32-bits color.
* Fedora Core 11 x86-64, X11R6 1024x768 32-bits color.
* Fedora Core 14 x86-64, X11R6 1024x768 32-bits color.

### COMPLETE FEATURE SET:

* Multiplayer out of the box.
* Totally self-contained, no external files.
* Fast-and-furious action at 29.97 frames per second.
* Just as the movies, 16:9 aspect-ratio.
* Beautiful mountains landscape plus horizon line :)
* Tanks and bullets exploding as wires with weird physics.
* Tanks back off when firing.
* There is an infinite number of levels.
* Always different levels.
* Animated intro.
* It has color!.

### FEATURES THAT PROGRAMMERS WILL FIND APPEALING:

* Works both with 32 and 64-bit CPUs.
* Double buffered, portable to any X11 with 24/32-bit color.
* Memory-hungry as must be any 3D program; uses a 256 MB array.
* Total and absolute irreverent coding style, so it generates a lot of warnings
  when compiled.
* It can take several minutes to compile (known culprits: Fedora Core 11-14 on
  x86-64 512 MB).
* It is written in the only true C: K&R, and no, that doesn't mean
  Katherine & Rose.
* Vectorial scalable graphics, do you want a bigger viewport? Change variables M
  `&` `N`.
* Half of the program is formatted as 3D cube. View with tabs at 8 columns and a\
  square font.
* The other half of the program is unprintable source code, so no typing from
  paper, you have to write a converter of tabs and form-feeds to its C escaped
  forms.
* No text, so this program can be used and understood easily in any country.
* This program is highly ecological, it sleeps when it is not doing anything.
* Virtual world with its own physics laws.
* When closing the window it will show an X11 error :P

### OBFUSCATION TRICKS:

* Loop code included inside loop test.
* Function arguments used as variables.
* Operators used freely.
* Pre-calculated values to save bytes.
* Uses the `+++`, `+-` and `*+` undocumented C operators :P

```

                                       ....,,,,---++++++--,,..\
                     .,,,.......     .$@@@@@@@@@@@@$$@@@@@@@@@@@@@@#+\
                     @@@@@###@@@@$$$@@@@$$$@@@-......-@+......,,,,,,##\
                     =++==++++++++=@@$==#$$$$$---,,,,@@@,,,,,,-------@@,..........,,.\
        ,===#$$$$$$###$####=======@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+=##$@@@@@@@@.
        +@,,++++++++=+=========++++===++++++++++-+++@@-,,,,,,,,---+++=++++--,,...   @.
        .@.                      .......,,,,-----++=@=++==@$=+--,,...               @.
         $#         S P O I L E R              .,,-#@--,,,@$.....                   @.
         .@                           ..,--+==++-,,,,.,,,,=@+++++====+++++---,,,....@.
          @+                ..,,-+++++++-,,..              @.         ....,,,,,---+@@\
          ,@       ..,--+++=+++,,..                        $#                   .==+\
           @#--++==++-,,..                                 ,@  S P O I L E R  .==+\
           ,#@@$+,,.                                        @.               ==+\
               .,,+++++,,.            S P O I L E R         $=             +=+\
                     ..,-==++-,.                            ,@           ---\
                            .,-+=+++,..                      @.       .++-\
                                  .,,++=++-,.                @+      ==+\
                                        .,-++==+-,.          +@    ==+\
                                              ..,+++=+-,..   .@. +=+\
                                                     .,-+++++,@@==

```

### THE HISTORY OF THIS PROGRAM:

When I started working on this program, I figured that it would
be easy to fit on the character limit, but I missed three things: the enormous
X11 names, the non-portable key codes and my 2 KB of artwork.

Very hard coding did the first thing. In fact I worked out twenty-nine different
versions and at one step I had four parallel versions with different
characteristics removed (mountains, horizon lines, score/status bars and
explosions) but I've managed to fit it all together!

The second thing was solved using the Makefile: it is under
160 bytes and you get adjustable controls. The greatest
mystery on the Earth is why X11 gives non-portable key codes to
the user.

And finally, the third "Thing" was growing and growing, and
growing, eating bytes for lunch...  after endless rounds of
crunching I obtained three-hundred seventy-eight  bytes  of
artwork and guess what? It doesn't fit.

So I had to integrate a decompressor based on the space, tabulators and other
non-counted characters.

The final program is composed of eight micro-functions: one is the core and does
most of the hard work and the other functions help do the X11 things, explosion
effects, 3D calculations and viewing.

* `K()`    - 3D transformation
* `s()`    - Rendering
* `b()`    - Line color selection
* `G()`    - Explosion animation
* `g()`    - Moves 3D object backward and forward
* `F()`    - Collision detection
* `T()`    - Core (also known as main loop :D)
* `main()` - Initialization and 'uncruncher', what a common name!;
             C programs should start in the cool() function :).

The source code was formatted as a cube using a specially written program. This
program is smaller and obfuscated what is needed so the reformatting doesn't
exceeded the character limits. The crunched vectors were generated by another
special program and the tank that surrounds this text was generated by yet
another program.

*Have fun!*


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
