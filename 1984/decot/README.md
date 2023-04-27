# Second place award 

Dave Decot  

## To build:

```sh
make all
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to not
require `-traditional-cpp` which not all compilers support (clang does not
support it for example). Clang is also more strict about the args' types in
`main()` and this was also a problem that Cody fixed, making it work with both
clang and gcc. For the original code with the gcc fix described below, see the
alternate code section below. Thank you Cody for your assistance!

Originally [Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch so that
this entry would compile with gcc - but not clang - or at least some versions.
Thank you Yusuke!

## To run:

```sh
./decot
```

### Alternate code:

The alternate code, [decot.alt.c](decot.alt.c), is the original code that
requires `-traditional-cpp` and will also run afoul with clang's requirement for
the second and third arguments to main() being a `char **` (the fixed version's
main() only has one arg, an int). It is a minor fix to Yusuke's fix. Thank you
Yusuke and Cody!

To try this version:

```sh
make alt
./decot.alt
```


## Judges' remarks:

This program prints out a string of garbage.

The judges also offer this one comment: understand remarks!

### Historical remarks:

Some new (in 1984) compilers disliked line 15 of the original source, so we changed it
from:

```c
for(signal=0;*k * x * __FILE__ *i;) do {
```

to:

```c
for(signal=0;*k *x * __FILE__ *i;) do {
```


To see what we mean look at the source file in the
[archive/archive-1984.tar.bz2](/archive-1984.tar.bz2) tarball or
[decot.alt.c](decot.alt.c).

## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
