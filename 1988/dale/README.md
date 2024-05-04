## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1988/dale in bugs.html](../../bugs.html#1988_dale).


## Try:

``` <!---sh-->
    ./try.sh
```

Observe that three of the commands in the script are:

``` <!---sh-->
    ./dale these files are in this directory: *
    ./dale $(printf "the following files exist in this directory:\n%s\n" *)
    ./dale "$(printf "the following files exist in this directory:\n%s\n" *)"
```

As the script asks what do the last two do and why do they do it? Why do they
differ in format from the first command? Finally how can you get the more likely
desired behaviour?


## Judges' remarks:

This entry has a very twisted flow of control via recursion, iteration
and multi-processing.  Try to understand what is being done with the
system calls.

NOTE: This program assumes the ASCII character set is being used.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
