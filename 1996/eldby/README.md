# Best Output

Thor Eldby<br>
Norway


## To build:

```sh
make alt
```


## To run:

```sh
./eldby.alt
```

To see why we recommend the alternate version instead of the original version,
see the [original code](#original-code) section.

NOTE: to reset the sanity of your terminal after this program ends try `reset`.

## Try:

This alternate version, which we recommend that you use in order to see what is
happening with modern systems, and to not flash too quickly, which can be
problematic for some people, can be configured to different speeds by way of the
value used in `usleep()`. The default is `-DZ=35000` but you can easily change
it. To do so try:

```sh
make CFLAGS+="-DZ=20000" clobber alt
./eldby.alt
```

### Original code:

Besides the fact that modern systems make it impossible to see what this program
does the rapid movement can be a problem for some people. It is for these
reasons that we recommend you first try the alternate version as described
above. If however you wish to see the original version in modern systems, try:

```sh
make all
```

Use `./eldby` as you would `./eldby.alt` above.


## Judges' remarks:

We were impressed by the author's ability to render spheres in 3D\
in a very small chunk of code.


## Author's remarks:

This program shows flying spheres. The program eats CPU on lesser
equipped systems. The program will run until termination. Terminal\
must be vt100 or better with 80 columns and 24 rows or more.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
