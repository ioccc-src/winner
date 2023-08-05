# Best visuals

Mark Isaak  
Imagen Corporation  
2650 San Tomas Expy.  
Santa Clara, CA   
95052-8101  
US  

## To build:

```sh
make all
```

## To run:

```sh
./isaak
```

### Alternate code:

The original version of this code is in [isaak.alt.c](isaak.alt.c).
The original entry starts with the line:

```c
	main(){};
```

This works on some systems.  Why?  Note that `#include <stdio.h>` is given on
the last line.  Why is this needed?  Note the unusual calls to sprintf.

This version also relied on being able to define define to something else and
using that macro for `#define`. This version will not likely work on modern
systems if you can even get it to compile.


## Judges' remarks:

NOTE:  The program relies heavily on ASCII.  Don't even think of running it on
an EBCDIC machine.  If you name the file anything other than "isaak.c", you must
change the `#include` on line 7.

NOTE: The use of null comments to separate macros to construct different tokens
from a single macro (e.g., `"O/**/O"` creates either `++` or `--` by defining
`O` to be `+` or `-`) may cause some strict ANSI C preprocessors to object.

NOTE: Most System V machines were not be able to execute this program correctly
due to the fact that BSD style systems have an sprintf() that returns a `char *`.
Due to the above problems, we placed the output of this program in the file:
isaak.encode.  To read this file do:

```sh
uudecode < isaak.encode
cat isaak.output
```

Since this was fixed, this file is not strictly necessary. See the
[isaak.orig.c](isaak.orig.c) for the original source.

FYI: We are likely to be more strict about portability in the future.

## Author's remarks:

No remarks were provided by the author.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
