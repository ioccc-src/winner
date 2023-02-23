# Most misleading indentation

tsoj <tsoj.tsoj@gmx.de>  
<https://gitlab.com/tsoj>  


The code for this entry can be found in prog.c

## Judges' comments:
### To use:

    make
    ./prog


### Try:

    # Make your terminal as large as possible, possibly reduce your font size
    # then...
    ./prog

### Selected Judges Remarks:

This game does not use curses, but you may end up cursing.

The code is made more difficult to read using an innovative, right justified,
reverse indentation style.

## Author's comments:
#### Controls
- Movement:  
`w` (forwards), `a` (left), `s` (backwards), `d` (right)
- Fire:  
`space`
- Quit:  
`q`
- Pause:  
`p`, then use any other key to resume

```
   /\
  //\\
 /    \
/______\
  /\/\
```
#### Compile and run
###### Linux
```
cc -std=c99 -O3 prog.c -o prog
./prog
```

###### Windows
The only way I found to make it work is to use [MSYS2](https://www.msys2.org). When using the MSYS2 shell you can install gcc via pacman.
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
- You may experience a mild [motion aftereffect](https://en.wikipedia.org/wiki/Motion_aftereffect) when playing for too long
#### High score
Score will be shown in the top left corner.  
My best was **156**. If you beat that I'll send you the image of a very expensive chocolate.
#### Features
- Procedural star generation
- Very space-efficient for-loops
- No use of `!=` or `==`
- Smooth rendering even on slow terminals
- Advanced ascii-art
- Cutting edge physics engine and collision detection
- Probably not many segfaults
- Every letter in the English alphabet has a variable or function named after it
- Not a virus
- Runs on my machine
#### Tips
- Adjust your terminal size for different experiences
- Run this program in a virtual console to immerse yourself in the game
-----------------------------------------------------------------------------------------------------
(c) Copyright 1984-2020, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-----------------------------------------------------------------------------------------------------
