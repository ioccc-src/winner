## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [1995/savastio in bugs.html](../../bugs.html#1995_savastio).


## To use:

``` <!---sh-->
    ./savastio
    # enter a POSITIVE number such as 100
```

NOTE: if you specify a negative number it will get stuck, showing no output. But
what happens if you give a non-number?


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

I know an l when I see a 1.


## Author's remarks:

This program is an infinite-precision factorial calculator.  It will
compute the factorial of any number entered to an infinite degree of
precision (or the limits of your machine's memory, whichever comes
first).  I'd suggest you start with small numbers the first few times
you run it and gradually work your way up in order to get a feel for
the computation time your machine will require.

Aside from having an artistic code layout and confusing variable names,
the algorithm itself takes advantage of some cute C-isms.  Try to
figure out how it prints the prompt "Enter number:".

Numbers are represented internally by a [linked
list](https://en.wikipedia.org/wiki/Linked_list) of blocks each
containing 1000 buckets of 4-digit integers.  To further confuse
matters, the buckets are arranged backwards in the block.  For example,
the number 8347108947139478934713847134 is represented as:

```
    7134 1384 9347 3947 9471 7108 834
```

### Platform limitations

Long integers must be at least 4 bytes.

### Features

In order to prevent the user from wasting too much time computing
useless factorials, the maximum factorial that can be computed is
429539!  This limit was selected through extensive research in
time management studies and the factorial arts.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
