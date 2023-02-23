2016 marked the "The Twenty Sixth International Obfuscated C Code Contest"
==========================================================================


Standard IOCCC stuff
--------------------

Look at the README.md file for the given winner for information
on how to compile the winner and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's comments for even more details.

The primary IOCCC web site can be found at,

>	<http://www.ioccc.org/>

Use make to compile entries.  It is possible that on non-Un\*x / non-Linux
systems the makefile needs to be changed.  See the Makefile for details.

Read over the makefile for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a #define).

Some C compilers are not quite as good as they should be.  If yours is
lacking, you may need to compile using clang or gcc instead of your local
compiler.


Remarks on some of the winners
------------------------------

This year's winners are impressive!

The "Most in need of debugging" (endoh) is very inventive in a way it produces its own text!

The "Most likely to be awarded" (ciura) has an amazing vocabulary!

There are again nods to winners of the years:

	[1991/davidguy](http://ioccc.org/years.html#1991_davidguy)
	[2011/blakely](http://ioccc.org/years.html#2011_blakely)

These nods to not run afoul of the guideline:

	We tend to dislike programs that:
	...
	are rather similar to previous winners

because the entry (dogon) appropriately pays homage to past winners
without blatantly reusing their code.

...We'll stop spouting spoilers now. Have fun exploring all the entries!


Remarks on some of submissions that did not win
-----------------------------------------------

Some entries tried to get around the size limit by submitting a data
file that was really C code and then blindly including code in prog.c.

Quite a few entries suffered from undefined behavior like accessing
uninitialized locals and/or reading-writing below the stack.
We advise running your entry through valgrind to make sure those mistakes
are avoided.

Using extra arguments to main, or arguments of wrong types as a quick and dirty
way of declaring variables is now passé. Clang, for example, rejects them outright.

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

Some entries seemed to have a good idea, but the implementation of
the idea was limited in scope.


Final Comments
--------------

Please feel free to send us comments and suggestions about the
competition, this README or anything else that you would like to see in
future contests.

If you use, distribute or publish these entries in some way, please drop
us a line.  We enjoy seeing who, where and how the contest is used.

If you have problems with any of the entries, AND YOU HAVE A FIX, please
send us the fix (patch file or the entire changed file).

For the latest information on how to contact the IOCCC Judges please visit

>	<http://www.ioccc.org/contact.html>

For news of the next contest watch:

>	<http://www.ioccc.org/>

=-=

Copyright (C) 2019, Landon Curt Noll, Simon Cooper, and Leonid A.
Broukhis. All Rights Reserved. Permission for personal, educational
or non-profit use is granted provided this copyright and notice are
included in its entirety and remains unaltered.  All other uses
must receive prior permission from the contest judges.
