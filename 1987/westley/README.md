# Best Layout

    Brian Westley (aka Merlyn Leroy on usenet)  
    Starfire Consulting  
    1121 Hamline Ave. N. #17  
    St. Paul, MN  
    55108  
    USA  

    http://www.westley.org

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. The problem was 'assignment to cast is illegal, lvalue casts are not
supported'. For the original file see below. Thank you Cody for your assistance!


## Alternate code:

If you have an older compiler you can try compiling the original source code
which is true symmetry:

	make alt


## To run:

	./westley


## Judges' remarks:

Putchar must exist in the C library and not just as a macro.
If it fails to compile, add the line:  `#include <stdio.h>`  at the
top of the program.

Line by line symmetry performed better than any C beautifier.  Think
of if it as a C ink blot.  :-)

NOTE: This entry requires a non-standard K&R C compiler to compile.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
