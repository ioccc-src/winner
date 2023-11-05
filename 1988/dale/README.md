## To build:

```sh
make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1988 dale in bugs.md](/bugs.md#1988-dale).


### Try:

```sh
./dale hello world
./dale these files are in this directory: *
```

What do the following commands do and why do they do it? Why do they differ in
format from the above command? Finally how can you get the more likely desired
behaviour?


```sh
./dale $(printf "the following files exist in this directory:\n%s\n" *)
./dale "$(printf "the following files exist in this directory:\n%s\n" *)"
```


## Alternate code:

If you have an old enough compiler you can try the original version in
[dale.alt.c](dale.alt.c). To use:

```sh
make clobber alt
```

Use `dale.alt` as you would `dale` above. To understand the differences in more
detail, see [thanks-for-fixes.md](/thanks-for-fixes.md).


## Judges' remarks:

This entry has a very twisted flow of control via recursion, iteration
and multi-processing.  Try to understand what is being done with the
system calls.

NOTE: This program assumes the ASCII character set is being used.


## Author's remarks:

No remarks were provided by the author.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
