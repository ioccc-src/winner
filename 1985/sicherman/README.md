## To build:

``` <!---sh-->
    make all
```

There is another version that can be compiled in case the first fails.
See [Alternate code](#alternate-code) below for more details on it.


## To use:

``` <!---sh-->
    ./sicherman < file

    echo foo | ./sicherman

    ./sicherman
    # type or paste some text, making sure to hit enter after each line typed
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The [sicherman.alt.c](%%REPO_URL%%/1985/sicherman/sicherman.alt.c) is a slight change in the fixed version
(fixed so it does not require `-traditional-cpp`) in that it has two args to
`main()` as some compilers object to certain number of args in `main()`.


### Alternate build:


``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./sicherman.alt < file
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

This program abuses the C preprocessor so much that some `cpp`s fail to strip
out all of the comments on the first pass!  If you were able to understand
[Dave Decot's](../../authors.html#Dave_Decot) [entry in 1984](../../1984/decot/index.html), you
will have a head start on this one.

Be sure to run this program through lint!  If your lint works
correctly, it should warn you that the argument 'Manual' isn't used.
Like the program says, what's that mean?

Run the program without arguments and enter the letters 'a' through 'm'
on a line.  Now enter the letters 'n' through 'z'.  But to borrow a quote
from Richard Stallman: If you think you understand what this code
does, then you don't, so read it again!  Explain why:

``` <!---sh-->
    ./sicherman < sicherman.c | ./sicherman | diff - ./sicherman.c
```

results in diff reporting a difference on some machines.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
