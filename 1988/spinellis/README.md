## To build:

```sh
make all
```


### Try:

```sh
rm -f spinellis ; cc spinellis.c -o spinellis < input.txt && ./spinellis
```

and try:

```sh
rm -f spinellis ; cc spinellis.c -o spinellis < input2.txt && ./spinellis
```


## Alternate code:

For clang try the alt code like:

```sh
cc spinellis.alt.c -o spinellis.alt < input.txt && ./spinellis.alt
```

and try:

```sh
cc spinellis.alt.c -o spinellis.alt < input2.txt && ./spinellis.alt
```


## Judges' remarks:

We enjoyed this entry this year; however in the future programs must be able to
be compiled from within a Makefile without the need of human intervention.


## Author's remarks:

This program can be configured to do almost everything.  The configuration is
done during compile time by typing in C code that one would like the program
to perform.  A trivial example is given in the `how to compile' section but the
possibilities are clearly limited only by your imagination and programming
skills.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
