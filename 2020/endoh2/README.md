## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```

What happens if you do

``` <!---sh-->
    ./prog prog.c
```

?


## Judges' remarks:

Clever use of the C99 complex data type. The [obfuscation](obfuscation/index.html) directory
contains clues as to how some winning authors create / edit programs into ASCII
shapes.

With the source from the [obfuscation](obfuscation/index.html) directory could you make the code
render for a larger terminal window?  How about adding more glyphs?


## Author's remarks:

No!  Try not.  Do, or do not.  There is no try.

``` <!---sh-->
    cc -std=c99 prog.c
    ./a.out
    ./a.out hello.txt
    ./a.out yoda.txt
    ./a.out bear.txt
```

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
