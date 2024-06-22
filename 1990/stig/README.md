## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    make all
```

**NOTE**: that's not a typo or mistake but one can also do:

``` <!---sh-->
    ./o
```


## Judges' remarks:

We changed the alias that the author's suggested alias from a
C-shell alias to a Bourne-like shell alias.

Note that `shst.c` is renamed to [stig.c](%%REPO_URL%%/1990/stig/stig.c) in the distribution.

**WARNING**: This program's `how to compile` is too specific to a particular shell.
The obfuscation of this program is more related to shell obfuscation than C
obfuscation.  This type of entry will not be permitted in future contests.


## Author's remarks:

If you like shell programming you may also admire my creative quoting. (I use
`echo` to create an alias which when run calls cc with the `-D` option to create
a C macro with double quotes in it. ARRRRRGGGHHH!)

The program is totally portable, but the compile commands are very shell
specific so don't be TOO mad at me if they don't work for you.

If you want to put these commands in a Makefile you must add 4 - four -
backslashes at the end on first line. (At least that's what works here.)

If everything works correctly it create an executable named `o` which checks
whether your compiler supports nested comments. I've stolen the `"/*/*/0*/**/1"`
from somewhere so don't give me any points for it. Of course neither ANSI nor
K&R support nested comments when properly implemented, but what the heck.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
