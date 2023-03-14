# Best Layout

Brian Westley (aka Merlyn Leroy on usenet)  
Starfire Consulting  
1121 Hamline Ave. N. #17  
St. Paul, MN  
55108  
USA  

## To build:

        make all

NOTE: Cody Boone Ferguson fixed this so it could compile on modern systems. For
the original file see below.


## Alternate code:

If you have an older compiler you can try compiling the original source code
which is true symmetry:

	make alt


## To run:

	./westley


## Judges' comments:

Putchar must exist in the C library and not just as a macro.
If it fails to compile, add the line:  `#include <stdio.h>`  at the
top of the program.

Line by line symmetry performed better than any C beautifier.  Think
of if it as a C ink blot.  :-)

NOTE: This entry requires a non-standard K&R C compiler to compile.

Copyright (c) 1987, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
