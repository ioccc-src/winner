2012 marked the "The Twenty First International Obfuscated C Code Contest"
========================================================================

Copyright (C) 2012, Landon Curt Noll, Simon Cooper, and Leonid A.
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

We believe you will be impressed with this year's winners.  We had
a very difficult time picking a single best from among the other winners
because the overall quality of the winners were so high.

This year we selected the top 4 entries for particularly high honors:

*   Gold award - Balanced use of obfuscation

    A very extremely subtle and twisted piece of source code!
    Even if you start with the zeitak_deobfucate.c source,
    you will still have a very challenging time to understand it!

*   Silver award - Most elementary use of C

    A fun program that could also have won "Best abuse of
    Ghostscript" because it managed to create some PDF files
    that Ghostscript could not read.

*   Bronze award - Best use of cocoa

    A picture within a picture is worth more than a
    thousand (4 byte) words. :-)

*   Honorable mention - Most complex ASCII fluid

    When you see this program in action, you too will
    very likely say [wow](http://bit.ly/R6ALpK) as we did!

But don't ignore the other winners!  There are games, utilities,
eye candy, calculators and graphical tools to explore.

This year, Yusuke Endoh won with two entries, one of which (endoh1)
won the special Honorable mention award.  Eight of the winning entries
were from people who won in previous years.

This year we had a number of winners from Asia.  We saw our second
winner from China and first from Korea.  We are pleased to see
outstanding entries from areas of the world that have not been
active in past contests.  Will we see an upswing of entries
from South America, Africa and Antarctica next year? :-)

Please note that judging is done completely anonymously.  Please
do NOT reveal your identity in your source code.  In the future we
may disqualify entries that reveal the identity of the submitter!

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

+ would take years to execute

+ were way way oversize and didn't even attempt to justify their
  excess by a clever abuse of the rules

+ obfuscate themselves by simply invoking a complex
  state machine

+ depend on a single obfuscation trick

+ could only be run on a particular vendor's platform

+ were very similar to previous winners

+ were based on an overused theme such as yet another
  fractal display program

+ didn't work as documented

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

There is a risk in submitting an entry that is similar to a well
used theme by previous winners.  Previous winners set a very high
bar.  A new winner must not only compete against other submissions
form the current year, they must also excel over similar winners
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
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
