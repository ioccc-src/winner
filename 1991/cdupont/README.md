## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./cdupont
```


## Judges' remarks:

Why is the following label necessary?

``` <!---c-->
    sorryfor_this_unused_but_very_needed_label:
```

Notice that if you C beautify (cb) or pre-process this program, it
will no longer work correctly, if at all.  Go ahead, try it... :-)

**NOTE**: One should remove the final trailing newline to obtain the
original source file.  This step is not needed to compile
this entry.


## Author's remarks:

The source code holds the letters of the message. Each letter, combined
with another key letter, is used to compute the coordinates of the next
letter and key. Thus, the message is code.  That is why I use silly
comments, most often badly spaced.

The space character sequence between the words is given by a simple
computation in an octal constant (given here as an hex value, of
course).

This way, any message can be mixed into a code, since the keys allow
you to place the meaningful letters wherever you want.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
