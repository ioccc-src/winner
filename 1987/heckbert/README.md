# Best Obfuscator of Programs

Paul Heckbert  
Pixar  

## To build:

        make all


On System V systems, we had to compile with `-Dindex=strchr`.
To compile on a 16 bit machine, change 300000 to 30000.



### Try:

	./heckbert 40 < heckbert.c > ph.c; make ph
	./ph 21 < heckbert.c > bar.c; make bar
	# or more generally fold some other file at a positive column:
	./ph col < file

Ask yourself what happens to `foo.md` if you try:

	./ph 40 < README.md > foo.md


## Judges' comments:

Folding at the wrong length may be equivalent to a "Spindle or Mutilate" operation. For example:

	./heckbert 40 < heckbert.c > ph.c ; make ph ; ./ph 20 < heckbert.c > bar.c ; make bar

Try not to
[Fold, Spindle or Mutilate](https://repository.library.brown.edu/studio/item/bdr:788264/PDF/)
files. :-)


## Author's comments:

No comments were provided by the author.


The judges used this program to fold up very long lines which the
BSD fold(1) was unable to process. This program has been added
to the contest tool chest.



Copyright (c) 1987, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
