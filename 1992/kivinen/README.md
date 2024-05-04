## To build:

If your machine support the X Window System, Version 11:

``` <!---sh-->
    make alt
```

We recommend that you try the alt version first so you can get a better idea of
what this looked like back in 1992. See [original code](#original-code) for the
original should you wish to see what we mean.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: known bug - please help us fix
```

For more detailed information see [1992/kivinen in bugs.html](../../bugs.html#1992_kivinen).


## To use:

``` <!---sh-->
    ./kivinen.alt

    ./kivinen.alt a

    ./kivinen.alt a b
```

See also the author's remarks for other variations.


## Try:

Also try changing the speed that the game moves. For instance if you wish to
change the `usleep(3)` value to `30000` from `20000`, try:


``` <!---sh-->
    make clobber SLEEP=30000 alt # make it slower

    make clobber SLEEP=10000 alt # make it faster
```

Then use the same syntax as above and described by the author.


## Original code:

As noted above, the alt version is recommended because the code goes too fast in
modern systems. If you wish to see the original you may do so with the original
code.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

Use `kivinen` as you would `kivinen.alt`.


## Judges' remarks:

The type of entertainment depends on number of arguments
you have with the program.  :-)

NOTE: Some systems do not need (or have) `-lsocket -lresolv -lnsl`.
Such systems should compile using `-lX11`.

NOTE: The original winning source [kivinen.orig.c](%%REPO_URL%%/1992/kivinen/kivinen.orig.c) assumed that
`exit(3)` returned a value which cause problems for some systems where `exit(3)` returns
`void`.  The file [kivinen.c](%%REPO_URL%%/1992/kivinen/kivinen.c) avoids this problem.


## Author's remarks:

### X Entertainment Kit

This kit includes three games from the early era of video games designed for
the X Window System Version 11 Release 5. It should work with earlier releases,
though.


#### Space Invaders

The classic game of shooting aliens from outer space, trying to
exterminate all life on earth. The game ends when the first line
of aliens touches the ground, or destroy you. To win the game you
must destroy all the aliens. If you evade out from the screen you
lose.

##### Controls

- Button 1 = Move left
- Button 2 = Fire missile
- Button 3 = Move right


####  Breakout

Break all the bricks with the ball, using your paddle. If you miss
the ball the game ends.

##### Controls

- Button 1 = Move left
- Button 3 = Move right


#### Dropout

Catch all the falling pieces, before they reach the ground. If you
miss it, game ends. To win you must catch all 30 pieces.

##### Controls

- Button 1 = Move left
- Button 3 = Move right



### Starting a game

The type of the game is determined by the number of arguments
given to the program.

- no arguments = Space Invaders
- 1 argument   = Breakout
- 2 arguments  = Dropout
- 3 arguments  = double sized Breakout
- 4 arguments  = triple sized Space Invaders
- 5 arguments  = triple sized Breakout
- 6 arguments  = double sized Dropout
- 7 arguments  = quadruple sized Breakout

...and so on...


### Scores

The exit value of the game is your score. The smaller the score
the better it is. The exit value of zero means you have won.


### Features

The game has a cheat system, which can be found after examining the
event loop at the end of program. It is not a bug, it's a feature!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
