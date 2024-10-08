## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./sykes2
```


## Try:

``` <!---sh-->
    ./try.sh
```

This will repeatedly remake the program and run it then sleep for one second for
a nice show of time.

## Judges' Comments:

As they say, "Lather, rinse, repeat"! :-)

If you have the time :-), figure out how this small 1-line entry works!


## Author's remarks:

At 130 characters of C code (without the newline at the end), this
should fit into the "1-liner" category.

The clock numerals are rendered as an old fashioned 7 segment display.
The encodings for which segments light for which number, and for where
each segment appears on screen are hidden in the two strings.

When reading the program, you may want to refer to a table of operator
precedence (try `man 7 operator`) - careful choices were made to keep the usage
of brackets to a minimum, and to keep the character count as low as possible.

One interesting bit of obfuscation - the null at the end of the second
string actually forms part of the lookup table.

Intel CC warns about the lack of a declaration for the argument to `main()`.
(`gcc` does not notice this though, even with `-Wall`.)  But anyway it can
easily be declared as `int` at the expense of 4 more characters.

I'm not sure of the effects on a hard disk of rewriting the same file
multiple times per second for a long time.  Run at your own risk!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
