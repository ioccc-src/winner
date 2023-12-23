## To build:

```sh
make all
```

There is an alternate version for those with an old enough compiler or one that
accepts `-traditional-cpp`. The second alt version will be compiled in the case
that you have a compiler that does not support 1 arg only in `main()`. For
instance clang has a number of defects and some versions say that `main()` can
only have 0, 2 or 3 args. The versions that have this that we know about do
support 1 arg but in case this is ever changed the
[sicherman.alt2.c](sicherman.alt2.c) is provided. See [Alternate
code](#alternate-code) below for details on the alt code, the original entry.


## To use:

```sh
./sicherman < file

echo foo | ./sicherman
```


### Try:

```sh
./sicherman  < sicherman.c

echo IOCCC | ./sicherman

./sicherman < sicherman.c | ./sicherman
```


## Alternate code:

The [sicherman.alt.c](sicherman.alt.c) is the original entry and requires either
an old enough compiler or a compiler that supports `-traditional-cpp`. If you have such
a compiler you can try this version.


### Alternate build:

```sh
make alt

```


### Alternate use:

```sh
./sicherman.alt < file
```


### Alternate try:

```sh
./sicherman.alt < README.md | ./sicherman.alt
```


## Judges' remarks:

This program abuses the C preprocessor so much that some `cpp`s fail to strip
out all of the comments on the first pass!  If you were able to understand
[Decot's](/winners.html#Dave_Decot) [entry in 1984](/1984/decot/README.md), you
will have a head start on this one.

Be sure to run this program through lint!  If your lint works
correctly, it should warn you that the argument 'Manual' isn't used.
Like the program says, what's that mean?

Run the program without arguments and enter the letters 'a' through 'm'
on a line.  Now enter the letters 'n' through 'z'.  But to borrow a quote
from Richard Stallman: If you think you understand what this code
does, then you don't, so read it again!  Explain why:

```sh
./sicherman < sicherman.c | ./sicherman | diff - ./sicherman.c
```

results in diff reporting a difference on some machines.


## Author's remarks:

No remarks were provided by the author.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
