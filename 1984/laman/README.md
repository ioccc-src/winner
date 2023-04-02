# Third place

Mike Laman

## To build:

        make all

## To run:

	./laman <positive number>

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this entry to not
segfault if no arg is specified. Instead it'll print nothing. Thank you Cody for
your assistance!

## Try:

The program accepts ONE POSITIVE argument.  Seeing is believing, so try things
like:

	./laman 4
	./laman 9
	./laman 16

This code should run you in circles.

## Judges' comments:

Some new compilers dislike lines 6 and 10 of the source, so we changed
them from:

	;++f)a[		b<<5|c]		=d++,b+		=e;for(		f=0;f<O
	<<5|c]^		=a[b<<5		|c]^=a[		(k-(b+1		))<<5|c]

to:

	;++f)a[		b<<5|c]		=d++,b+=	e;for(		f=0;f<O
	<<5|c]^=	a[b<<5		|c]^=a[		(k-(b+1		))<<5|c]

I hope you have a C beautifier!

## Author's comments:

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
