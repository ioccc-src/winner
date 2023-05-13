# Best layout

Merlyn LeRoy (Brian Westley)  
Rosemount, Inc.  
1121 Hamline Ave. N. #17  
St. Paul, MN    
55108  
U.S.A.  
<http://www.westley.org>  

## To build:

```sh
make all
```

Misha Dynin provided a fix for [westley.c](westley.c) so that it may compile on 
both K&R and more modern C compilers. Thank you Misha! The original code, used
for entertainment and educational value, is in [westley.alt.c](westley.alt.c),
described below.

## Try:

```sh
./westley
```

## Judges' remarks:

Your compiler must parse

```c
#define _ -a
-_
```

as `--a` and not `-(-a)` or some other tokenized form.  Some strictly
conforming ANSI C Preprocessors may object to this: for such
compilers, you can elide the non-standard token-pasting requirement
by changing the #define line to:

```c
#define _ F-->00||F-OO--;
```

You might enjoy looking at the output of:

```sh
cc -E westley.c
```

### Alternate code:

To see if your compiler has the problem described above try:

```sh
make alt
./westley.alt
```

Does it show the same output as `westley`?


## Author's remarks:

No remarks were provided by the author.



## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
