## To build:

```sh
    make all
```


## To use:

```sh
    ./laman <positive number>
```


## Try:

The program accepts ONE POSITIVE number.  Seeing is believing, so try things
like:

```sh
    ./try.sh

    ./laman 4
    ./laman 9
    ./laman 16
```

This code should run you in circles.


## Judges' remarks:

Some new compilers (in 1984) dislike lines 6 and 10 of the source, so we changed
them from:

```c
    ;++f)a[		b<<5|c]		=d++,b+		=e;for(		f=0;f<O
    <<5|c]^		=a[b<<5		|c]^=a[		(k-(b+1		))<<5|c]
```

to:

```c
    ;++f)a[		b<<5|c]		=d++,b+=	e;for(		f=0;f<O
    <<5|c]^=	a[b<<5		|c]^=a[		(k-(b+1		))<<5|c]
```

I hope you have a C beautifier!


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
