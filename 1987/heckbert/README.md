# Best Obfuscator of Programs

Paul Heckbert  
Pixar  

## To build:

        make all


On System V systems, we had to compile with `-Dindex=strchr`.
To compile on a 16 bit machine, change 300000 to 30000.



## Try:

	./heckbert 40 < heckbert.c > ph.c; make ph
	./ph 21 < heckbert.c > bar.c; make bar
	# or more generally fold some other file at a positive column:
	./ph col < file

Ask yourself what happens to `foo.md` if you try:

	./ph 40 < README.md > foo.md


## Judges' remarks:

Folding at the wrong length may be equivalent to a "Spindle or Mutilate" operation. For example:

	./heckbert 40 < heckbert.c > ph.c ; make ph ; ./ph 20 < heckbert.c > bar.c ; make bar

Try not to
[Fold, Spindle or Mutilate](https://repository.library.brown.edu/studio/item/bdr:788264/PDF/)
files. :-)


## Author's remarks:

No comments were provided by the author.

The judges used this program to fold up very long lines which the
BSD fold(1) was unable to process. This program has been added
to the contest tool chest.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
