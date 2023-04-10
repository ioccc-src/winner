# Second place award 

Dave Decot

## To build:

        make all

Originally [Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch so that
this entry would compile with gcc - but not clang - or at least some versions.
Thank you Yusuke!  [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
noticed this did not work under fedora linux and it definitely didn't work with
macOS as it required a compiler that supports `-traditional-cpp` which clang
does not. Clang also requires that the second and third arguments to main be a
`char **`. Cody fixed both problems and now it works under both macOS and linux
- clang and gcc. Thank you Cody for your assistance!

## To run:

```sh
./decot
```

### Alternative code:

The alternative code, [decot.alt.c](decot.alt.c), is the fix that Cody made to
the version that does require `-traditional-cpp` and still runs afoul with
clang's requirement for the second and third arguments to main() being a `char
**` (the fixed version's main() only has one arg, an int). It is a minor fix to
Yusuke's fix. Thank you Yusuke and Cody!

To try this version:

```sh
make alt
./decot.alt
```


## Judges' remarks:

This program prints out a string of garbage.

The judges also offer this one comment: understand remarks!

### Historical comments:

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

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
