2013 marked the "The Twenty Second International Obfuscated C Code Contest"
===========================================================================

Copyright (C) 2013, Landon Curt Noll, Simon Cooper, and Leonid A.
Broukhis. All Rights Reserved. Permission for personal, educational
or non-profit use is granted provided this copyright and notice are
included in its entirety and remains unaltered.  All other uses
must receive prior permission from the contest judges.


Standard IOCCC stuff
--------------------

The IOCCC has a web site and now has a number of international mirrors.
The primary site can be found at,

>	<http://www.ioccc.org/>

Use make to compile entries.  It is possible that on non-Un\*x / non-Linux
systems the makefile needs to be changed.  See the Makefile for details.

Look at the source and try to figure out what the programs do, and run
them with various inputs.  If you want to, look at the hints files for
spoilers - this year we included most of the information included
by the submitter.

Read over the makefile for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a #define).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using gcc instead of your
local compiler.


Remarks on some of the entries
------------------------------

We believe you will again be impressed with this year's winners. 

This year, several 8 people won 9 people won 15 awards.  For the
first time in the history of the contest, one person, Yusuke Endoh,
won 4 times while Adrian Cable won 3 times!  It is also worth noting
that Chris Mills previous win was in 1993.  Welcome back Chris!

We, the judges, were very surprised by this as many of the multiple
winners submitted very different styles of entries.

This year was the first time the IOCCC size tool was used.  Entries
had to print a value 2053 or less when the -i flag was used.

Several people discovered an undocumented feature in that
certain comments such as:

	///*

or:

	*\
	/

were not correctly parsed by the tool.  The guidelines stated:

    In cases where the above summary and the algorithm implemented by
    the IOCCC size tool source code conflict, the algorithm implemented
    by the IOCCC size tool source code is preferred by the judges.

so this abuse was allowed (and encouraged).  The judges hope that
the IOCCC size tool author will patch the tool to block this kind
of size abuse in future contests.

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

+ were way way oversize and didn't even attempt to justify their
  excess by a clever abuse of the rules

+ depend on a single obfuscation trick

+ could only be run on a particular vendor's platform

+ were very similar to previous winners

+ didn't work as documented

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

There is a risk in submitting an entry that is similar to a well
used theme by previous winners.  Previous winners set a very high
bar.  A new winner must not only compete against other submissions
from the current year, they must also excel over similar winners
in some particularly impressive way.

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


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2013, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
