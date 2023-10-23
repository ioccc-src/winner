# Third place

Mike Laman

## To build:

```sh
make all
```

## To run:

```sh
./laman <positive number>
```

### Bugs and (Mis)features

This entry a listed in [bugs.md](/bugs.md) as:

```
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [bugs.md](/bugs.md#1984laman-readmemd).

## Try:

The program accepts ONE POSITIVE number.  Seeing is believing, so try things
like:

```sh
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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
