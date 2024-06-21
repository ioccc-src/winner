## To build:

``` <!---sh-->
    make all
```


## Try:

``` <!---sh-->
    ./roemer
```


## Judges' remarks:

Do you know what this program does?  If you do, look again, there is more here
than meets the PI.


## Author's remarks:

Passes lint, but not with the strictest options, for it contains some
"null-statements", as well as two identifiers which are, if compilers only take 6
characters, the same.  It also uses `write(2)`, so not totally system
independent.

You are very much invited to pass this program through a C-beautifier (first
strip newlines and tabs, if your `cb` can't do that).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
