# Best Layout

Brian Westley (Merlyn LeRoy on usenet)\
DigiBoard, Inc.\
1026 Blair Ave.\
St. Paul, MN  55104\
US\
<http://www.westley.org>


## To build:

```sh
make all
```


### Bugs and (Mis)features

The current status of this entry is:

```
STATUS: known bug - please help us fix
```

For more detailed information see [1990 westley in bugs.md](/bugs.md#1990-westley).


## To use:

```sh
./westley number
```


### INABIAF - it's not a bug it's a feature :-)

This entry will very likely crash or do something else without an arg.

This program will enter an infinite loop if input is not a number > 0.


## Try:

```sh
./westley 1
./westley 2
./westley 3
./westley 5
```

## Alternate code:

If you have an old enough compiler try and to see how C has changed over the years:

```sh
make alt
```

Use `westley.alt` as you would `westley`.


## Judges' remarks:

If you would rather "Daisy" someone other than Westley, rename\
the program as needed.  :-)

Read each block of code as if it were a piece of correspondence.
For example, the first block of code would read:

```
charlie,
	doubletime me, OXFACE!
	not interested, get out
	mainly die, charly, *die*
		signed charlotte
```

The original source had control-L's after each code block.  To\
make it easier on news readers, we converted each control-L to\
a blank line.


## Author's remarks:

This is a "Picking the Daisy" simulation.  Now, instead of mangling a
daisy, simply run this program with the number of petals desired as
the argument.

This is a good counter-example to peoples' complaints that C doesn't
have an "English-like" syntax.

Lint complains about everything - null effect, xxx may be used before
set, statement not reached, return(e) and return.  Lint dumps core
on some systems.  My personal favorite lint complaint is

**_"warning: eroticism unused in function main"._**

Also obviously, `(char)lotte` and `(char*)lie` are incompatible types...


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
