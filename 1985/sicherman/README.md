# The worst abuse of the C preprocessor

Col. G. L. Sicherman

## To build:

        make all

NOTE: This entry requires a compiler that support `-traditional-cpp`.

## Try:

	./sicherman  < sicherman.c

## Judges' comments:

This program abuses the C preprocessor so much that some /lib/cpp fail to
strip out all of the comments on the first pass!  If you were able to
understand Decot's entry in 1984, you will have a head start on this
one.

Be sure to run this program through lint!  If your lint works
correctly, it should warn you that the argument 'Manual' isn't used.
Like the program says, what's that mean?

Run the program without arguments and enter the letters 'a' through 'm'
on a line.  Now enter the letters 'n' through 'z'.  But to borrow a quote
from Richard Stallman: If you think you understand what this code
does, then you don't, so read it again!  Explain why:

	./sicherman < sicherman.c | ./sicherman | diff - ./sicherman.c

results in diff reporting a difference on some machines.


## Author's comments:

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
