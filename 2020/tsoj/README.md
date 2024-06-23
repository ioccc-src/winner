## To build:

``` <!---sh-->
    make
```


There is an alternate version which has controls that will make much more sense
to those familiar with vi. See [Alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    # Make your terminal as large as possible, possibly reduce your font size
    # then...
    ./prog
```


## Alternate code:

This version has the difference of moving forwards, left, backwards and right,
where instead of `w`, `a`, `s` and `d`, you can use `k`, `h`, `j` and `l`.


### Alternate build:

``` <!---sh-->
    make alt
    ```


### Alternate use:

``` <!---sh-->
    # Make your terminal as large as possible, possibly reduce your font size
    # then...
    ./prog.alt
```

..and maybe curse less than you might otherwise, but still probably curse (see
below) :-)


## Judges' remarks:

This game does not use curses, but you may end up cursing.

The code is made more difficult to read using an innovative, right justified,
reverse indentation style.


## Author's remarks:

### Controls

- Movement: `w` (forwards), `a` (left), `s` (backwards), `d` (right)
- Fire: space
- Quit: `q`
- Pause: `p`, then use any other key to resume


```
       /\
      //\\
     /    \
    /______\
      /\/\
```


### Compile and run

#### Linux
```
    cc -std=c99 -O3 prog.c -o prog
    ./prog
```

#### Windows

The only way I found to make it work is to use [MSYS2](https://www.msys2.org).
When using the MSYS2 shell you can install gcc via pacman.

```
    cc -std=c99 -O3 prog.c -o prog
    ./prog.exe
```

#### Warnings

- `-Wno-missing-prototypes`
- `-Wno-shorten-64-to-32`
- `-Wno-sign-conversion`
- `-Wno-implicit-int-float-conversion`
- `-Wno-missing-field-initializers`
- `-Wno-implicit-float-conversion`
- `-Wno-vla`
- `-Wno-float-conversion`
- `-Wno-comma`
- `-Wno-shadow`
- `-Wno-format`
- `-Wno-empty-body`
- `-Wno-misleading-indentation`
- `-Wno-maybe-uninitialized`
- You may experience a mild [motion
aftereffect](https://en.wikipedia.org/wiki/Motion_aftereffect) when playing for
too long.


### High score

Score will be shown in the top left corner.
My best was **156**. If you beat that I'll send you the image of a very
expensive chocolate.


### Features

- Procedural star generation.
- Very space-efficient `for` loops.
- No use of `!=` or `==`.
- Smooth rendering even on slow terminals.
- Advanced ASCII art.
- Cutting edge physics engine and collision detection.
- Probably not many segfaults.
- Every letter in the English alphabet has a variable or function named after
  it.
- Not a virus.
- Runs on my machine.


### Tips

- Adjust your terminal size for different experiences.
- Run this program in a virtual console to immerse yourself in the game.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
