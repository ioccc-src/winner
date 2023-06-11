# Best abuse of the rules

Diomidis Spinellis  
Greece  
<https://www.spinellis.gr/>  
Mastodon: <https://mstdn.social/@DSpinellis>

## To build:

```sh
make all
```

and then type a C program into followed by EOF (usually `^D`, ctrl-d).

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made a version (also
one line) for clang. See the Alternate code section below for how to use.
Thank you Cody for your assistance!

## Try:

```sh
make clobber all
main()
{
    printf("Hello world\n");
}
^D
./spinellis

make clobber all
int main()
{
    int i;
    for (i = 0; i < 5; ++i)
	printf("%d\n", i);
}
^D
./spinellis
```

NOTE: you need to make clobber first for this entry to work right.

## Alternate code:

For clang try the alt code like:

```sh
make clobber alt
#include <stdio.h>
main()
{
    puts("Hello world\n");
}
^D
./spinellis

```

NOTE: you need to make clobber first for this entry to work right.

## Judges' remarks:

We enjoyed this entry this year, however in the future programs must be able to
be compiled from within a Makefile without the need of human intervention.

Meanwhile Cody was twisted enough to point out (though to be fair he felt sick
doing this) that with a slight modification this entry can be C++ instead. We don't
thank him for this ghastly point! :-)

## Author's remarks:

This program can be configured to do almost everything.  The configuration is
done during compile time by typing in, C code, that one would like the program
to perform.  A trivial example is given in the `how to compile' section but the
possibilities are clearly limited only by your imagination and programming
skills.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
