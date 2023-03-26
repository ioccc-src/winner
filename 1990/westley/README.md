# Best Layout

	Brian Westley (Merlyn LeRoy on usenet)
	DigiBoard, Inc.
	1026 Blair Ave.
	St. Paul, MN  55104  
	USA

	http://www.westley.org

## To build:

        make all

## To run:

	./westley number

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. Thank you Cody for your assistance!

NOTE: this entry will segfault without an arg and will enter an infinite loop if
input is not a positive number.


## Try:

	./westley 1
	./westley 2
	./westley 3
	./westley 5

## Judges' comments


If you would rather "Daisy" someone other than Westley, rename 
the program as needed.  :-)

Read each block of code as if it were a piece of correspondence.
For example, the first block of code would read:

	charlie,
		doubletime me, OXFACE!
		not interested, get out
		mainly die, charly, *die*
			signed charlotte

The original source had control-L's after each code block.  To 
make it easier on news readers, we converted each control-L to 
a blank line.

Some modern compilers will not accept '1s' as a short integer - for
these compilers we replaced the instances of `1s` with `1`.


## Author's comments

This is a "Picking the Daisy" simulation.  Now, instead of mangling a 
daisy, simply run this program with the number of petals desired as 
the argument.

This is a good counter-example to peoples' complaints that C doesn't
have an "English-like" syntax.

Lint complains about everything - null effect, xxx may be used before
set, statement not reached, return(e) and return.  Lint dumps core
on some systems.  My personal favorite lint complaint is

    	"warning: eroticism unused in function main".
    
Also obviously, `(char)lotte` and `(char*)lie` are incompatible types...

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
