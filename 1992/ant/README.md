## To build:

```sh
make all
```


## To use:

```sh
./ant Makefile
```

where `Makefile` is a Makefile to use.


### Try:

First build the tool itself with our Makefile:

```sh
./ant Makefile am
```

Now use `am` to do some things:

```sh
./am Makefile am_clobber	# clobber everything except am
./am ant.test.mk		# run the test Makefile with am
```


## Judges' remarks:

Like much of POSIX, obfuscation has its place.  Your task is to
figure out where.

This entry comes complete with a POSIX-like command description.
Interested POSIX balloters should lobby the IEEE for an obfuscated
P1003 subcommittee.


## Author's remarks:

See the file [ant.README](ant.README).


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
