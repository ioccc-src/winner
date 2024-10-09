## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    some_command | ./biggar | od -c

    ./biggar < file | od -c
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

By changing the compile line you can make this program do anything you
want. This is a very efficient way to transfer source, though it
increases the size of Makefiles.

With only slight variations, this program can be set to many uses.
Consider how easy it would be to release `Unix` source in this form;
so what if the Makefiles grow a little!  :-)

One vendor's lint got hung in an infinite loop over this entry!

FYI:  We will let Mark get away with this truly sick entry this time, but
for the future on we have placed a limit on the size of a compile line.

**NOTE**: originally we made a comment in [Larry Wall](../../authors.html#Larry_Wall)'s
[1987/wall](../wall/index.html) entry regarding Mark's contribution but it seems to have
been lost in time. If anyone knows about its whereabouts we'd appreciate letting
us know. Thanks!

Passes BSD and UTS lint.  At least one version of lint is thrown into
an infinite loop by this entry.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
