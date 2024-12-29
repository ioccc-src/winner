## To build:

``` <!---sh-->
    make clobber all
```

and follow the instructions this will give you.

If your compiler will not read from `/dev/tty` see the [Alternate
code](#alternate-code) section below.


## To use:

``` <!---sh-->
    ./spinellis
```

Type in or copy paste some C code, perhaps from [input.txt](input.txt), and send
EOF (typically ctrl-d).

Now run again:

``` <!---sh-->
    ./spinellis
```


## Alternate code:

For clang or compilers that won't read from `/dev/tty`, we provide this version.


### Alternate build:

``` <!---sh-->
    make clobber alt
```

and follow the instructions.


### Alternate use:

``` <!---sh-->
    ./spinellis.alt
```

Type in or copy paste some C code, perhaps from [input.txt](input.txt), and send
EOF (typically ctrl-d).

Now run again:

``` <!---sh-->
    ./spinellis.alt
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


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
