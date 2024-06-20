## To build:

``` <!---sh-->
    make all
```

On System V systems, we had to compile with `-Dindex=strchr`.
To compile on a 16 bit machine, change 300000 to 30000.


## To use:

``` <!---sh-->
    ./heckbert col < file
```

where col is the number of columns to fold at and file is the file to fold.


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Folding at the wrong length may be equivalent to a "Spindle or Mutilate" operation. For example:

``` <!---sh-->
    ./heckbert 40 < heckbert.c > ph.c ; make ph ; ./ph 20 < heckbert.c > bar.c ; make bar
```

Try not to
[Fold, Spindle or Mutilate](FoldSpindleMutilate.pdf)
files. :-)

The judges used this program to fold up very long lines which the
BSD `fold(1)` was unable to process. This program has been added to
the contest tool chest.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
