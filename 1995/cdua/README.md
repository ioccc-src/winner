# Best Output

Carlos Duarte  
Instituto Superior Tecnico  
Largo da Igreja, 5 R/C DTo  
Damaia  
2720 Amadora   
Portugal  

## To build:

```sh
make all
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so that it
would work with macOS. Once it could compile it additionally segfaulted under
macOS which he also fixed. Thank you Cody for your assistance!

NOTE: on modern systems this was hard to see it solve it in real time because it
goes so quickly so Cody added a macro `Z` defaulting to 3000 for a call to
`usleep()` to make it easier to see. The `Z` macro lets you configure it in case
you find it too slow or too fast. To do that:

```sh
make CFLAGS+="-DZ=1500" clobber all
```

## To run:

```sh
./cdua
```


NOTE: sometimes the program needs you to press enter a second time to continue
solving the maze. See [bugs.md](/bugs.md) for more details.


## Judges' remarks

This could be used as the basis of an a-maze-ing screen exerciser.

## Author's remarks

A program that generates a maze, and then solves it, all this being
seen by the user.  Some highlights of obfuscation are: 3 steps
functions in one - main(), several recursive calls with conditional
actions, and just one (big and ugly) statement to solve the maze.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
