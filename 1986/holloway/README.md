# Best simple task performed in a complex way

Bruce Holloway  
Digital Research, Inc.  
Monterey, CA  
USA  

## To build:

```sh
make all
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to
compile and work with clang (it already worked with gcc).  The problem was that
clang is more strict about the type of second arg to main(). However simply
changing it to a `char **` and updating the `*s` to `**s` caused a segfault. By
adding a new variable, `char *t`, initialising it to `s` and then using `t`
instead of `s` it compiles and runs successfully under clang and gcc. Thank you
Cody for your assistance!

## Try:

```sh
./holloway
```


## Judges' remarks:

Believe it or not, this is the old standard "Hello, world" program
performed in a very complex way.  The judges and the author defy you
to determine how it does it.  It is a good thing that K&R didn't use
this version as the first C program!

## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
