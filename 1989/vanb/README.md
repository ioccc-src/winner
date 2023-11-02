# Best one liner

David Van Brackle\
Department of Computer Science\
University of Central Florida\
Orlando, Florida\
32816\
US


## To build:

```sh
make all
```


### Try:

```sh
./vanb the rug gary lent
./vanb unix is better than os/2
```


## Judges' remarks:

This program computes all proper subsets of the set of
arguments passed to it.  Each subset is printed with one
element on each line, followed by a line of ten dashes.


## Author's remarks:

The program has the following charming and possibly
non-portable features:

* It has no local or global variables, only the command-line parameters.

* It calls `main()` recursively.

* It alters the command-line parameters.

* It uses the fact that if the high bit is set in a character variable, the
value is negative.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
