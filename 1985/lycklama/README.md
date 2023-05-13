# Strangest appearing program 

Ed Lycklama  

## To build:

```sh
make all
```


[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile with
modern compilers. In the past 'define' in `#define` could even be defined but to
get this to work on modern systems Cody changed the `#o` lines to `#define`. The
`lycklama.alt.c` is the original source code as it provides some fun input for
the entry. Thank you Cody! With a tip from [Yusuke
Endoh](/winners.html#Yusuke_Endoh)  it was indirectly noticed that if one slows
down the call to `write()` one can see some fun output that's not visible with
modern systems so Cody added a call to `usleep()`. The default time is `0`
which disables it (in order to make it as close to original as possible; an alt
version already exists mostly for fun output). In order to change the speed (try
500 or 700) do:

```sh
make CDEFINE+="-DZ=700" clobber all
```

Thank you Yusuke!


## Try:


```sh
./lycklama < lycklama.c

# notice the difference between the above and this one:
./lycklama < lycklama.alt.c

./lycklama < README.md

./lycklama < Makefile
```

### Alternative code:

If you have an older compiler that lets you define some object to define and
then use it in place of `#define` you can run:

```sh
make alt
```

Use `./lylycklama.alt` as you would `./lycklama` above.

## To run:

```sh
./lycklama < some_file
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
