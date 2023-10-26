# Best one liner

Jan Stein

## To build:

```sh
make all
```

## To use:

```sh
./stein $(printf "\015\015"); echo
```

## Judges' remarks:

NOTE: to avoid problems with news and mail, the single line was split
into 3 lines.  Join all lines into a single line to recreate
the original file.


The 015 in the above printf command produces a control-N.

One some machines, a control-M control-N arg is needed
to get the command to output cleanly:

```sh
./stein $(printf "\014\015"); echo
```

Your system may require another set of characters.
In time, you will figure out what it does. :-)

## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
