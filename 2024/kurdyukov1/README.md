## To build:

``` <!---sh-->
    make all
```

## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Comparing this entry to [2000/natori](https://ioccc.org/2000/natori), which does something similar, is quite instructive.
This entry does not use floating point, and the only common magic number is 2551443 (what does it mean?).
How is this entry able to achieve a similar result?

## Author's remarks:


### Moon Phase

This code draws the current moon phase to the console. So if you're a lycanthrope, you can monitor the phase of the moon.

#### Customization

1. It shows a view from the northern hemisphere, to see from the southern replace `<a*(~` with `>=a*(`. Can't show a view near the equator.

2. The code assumes that your terminal color is dark and the text color is bright. If not, you can change `"#."` characters in the source code to suit your case.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
