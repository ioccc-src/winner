# Strangest appearing program

Ed Lycklama


## To build:

```sh
make alt
```


If you have an old enough compiler you can try:

```sh
make lycklama.orig
```


## To use:

```sh
./lycklama.alt < some_file
```

To see why we recommend the alternate version instead of the original version,
see below and the [original code](#original-code) section.

## Try:

This alternate version, which we recommend you you try first, prior to the
original, so that you can see what it does in modern systems, slows down the
output which will provide more fun output. It is slowed down by the `usleep(3)`
library call with a configurable time to sleep. The default is 500 but you can
reconfigure it like:


```sh
make CDEFINE+="-DZ=700" clobber alt
```

which would set it at 700. Then, whether you use the default value or not, try:

```sh
./lycklama.alt < lycklama.c

# notice the difference between the above and this one:
./lycklama.alt < lycklama.alt.c

# also try:
./lycklama.alt < lycklama.orig.c

./lycklama.alt < README.md

./lycklama.alt < Makefile

```

## Original code:

As explained above, because modern systems run this entry way too fast to fully
appreciate what it does, we encourage you to first try the alternate version.
After this, however, you might wish to try the original version, fixed for
modern systems.

#### To build:

```sh
make all
```

#### To use:


```sh
./lycklama < some_file
```

#### Try:

```sh
./lycklama < lycklama.c
./lycklama < lycklama.alt.c
./lycklama < lycklama.orig.c
./lycklama < Makefile
```


## Judges' remarks:

Run the program, redirecting a file into it, and notice how it redisplays it.
The program itself looks like tty noise.


## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
