# Strangest appearing program 

Ed Lycklama  


## To build:

```sh
make all
```

If you have an old enough compiler you can try:

```sh
make lycklama.orig
```


## To run:

```sh
./lycklama < some_file
```

There is an alternate version which slows down the output for a more fun display
with modern systems. For this reason we encourage you to try that version
as well. See Alternate code section below. 


## Try:

```sh
./lycklama < lycklama.c

# notice the difference between the above and this one:
./lycklama < lycklama.alt.c
# also try:
./lycklama < lycklama.orig.c

./lycklama < README.md

./lycklama < Makefile

```


### Alternative code:

This alternate version slows down the output which will provide more fun
output. The default time passed to `usleep(3)` is `500` but you can reconfigure
it like:


```sh
make CDEFINE+="-DZ=700" clobber alt
```

#### Try:

```sh
./lycklama.alt < lycklama.c
./lycklama.alt < lycklama.alt.c
./lycklama.alt < lycklama.orig.c
./lycklama.alt < Makefile
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
