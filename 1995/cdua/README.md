# Best Output

Carlos Duarte\
Portugal


## To build:

```sh
make all
```

NOTE: on modern systems this was hard to see it solve it in real time because it
goes so quickly so an alternate version which makes it easier with
modern systems to see the maze actually being solved in real time. We encourage
you to use that version but we keep the original here to both preserve the
original code (the bug fixes notwithstanding) and it will also let you see just
how fast your computer is :-) (and you can also use both to see the difference).
For this alternate, slower version, please see below.


## To run:

```sh
./cdua
```


## INABIAF - it's not a bug it's a feature! :-)

NOTE: sometimes the program needs you to press enter a second time to continue
solving the maze. This is a feature, not a bug. See [bugs.md](/bugs.md) for more
details.


### Alternate code:

This version uses `usleep(3)` with the `Z` (defined in the Makefile, default
`3000`) microseconds to make it easier to see the maze being solved in real
time. You can redefine Z to reconfigure it in case it's going too slow, too
fast :-) or you're doing some strange experiment like making it 100000.

To compile and use without reconfiguring the 3000
microseconds, try:

```sh
make clobber alt
./cdua.alt # press enter
```

Use `cdua.alt` as you would `cdua` above.

To use a 1500 for `Z` try something like:

```sh
make CFLAGS="-DZ=1500" clobber alt
./cdua.alt # press enter and watch it move a bit slower
```

Also try:

```sh
make CFLAGS="-DZ=65000" clobber alt
./cdua.alt # press enter and watch it go much slower!
```

Do you see anything strange in this version when `Z` is a high value like
`65000`? What happens if you use `100000`? Is this strange output still there?
Why?


## Judges' remarks:

This could be used as the basis of an a-maze-ing screen exerciser.


## Author's remarks:

A program that generates a maze, and then solves it, all this being
seen by the user.  Some highlights of obfuscation are: 3 steps
functions in one - main(), several recursive calls with conditional
actions, and just one (big and ugly) statement to solve the maze.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
