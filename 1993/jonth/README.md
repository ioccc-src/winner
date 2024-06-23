## To build:

NOTE: this entry requires `X11/Xlib.h` header file and the X11 library to
compile. macOS users running Mountain Lion and later will need to download and
install [XQuartz](https://www.xquartz.org) in order to compile and run this
entry.

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./jonth	# must be run on an X11 server
```


## Judges' remarks:

Use `h` and `l` to shift objects left or right.  Use `k` to
rotate and press SPACE to drop.

This program's output may be even more obfuscated when played
on inverse video.  :-)


## Author's remarks:

This is `jonth` (`jon's t(h)etris`) for the X Window System.

This program is also an example of data abstraction.  The X array is
after initialization hidden by the well defined macros `t`, `u` and `F`.

This program is highly portable as it runs on a "Notebook" size SPARC.
This program will not work on machines where `sizeof(int)!=sizeof(void *)`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
