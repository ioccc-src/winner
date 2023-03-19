# Best simple task performed in a complex way

Bruce Holloway  
Digital Research, Inc.  
Monterey, CA  
USA  

## To build:

        make all


[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to
compile and work with clang (it already worked with gcc).  The problem was that
clang is more strict about the type of second arg to main(). However simply
changing it to a `char **` and updating the `*s` to `**s` caused a segfault. By
adding a new variable, `char *t`, initialising it to `s` and then using `t`
instead of `s` it compiles and runs successfully under clang and gcc. Thank you
Cody for your assistance!

## Try:

	./holloway


## Judges' comments:

Believe it or not, this is the old standard "Hello, world" program
performed in a very complex way.  The judges and the author defy you
to determine how it does it.  It is a good thing that K&R didn't use
this version as the first C program!

## Author's comments:

No comments were provided by the author.



Copyright (c) 1986, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
