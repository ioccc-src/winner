## 2020 marked the "The Twenty Seventh International Obfuscated C Code Contest"

Copyright (C) 2020, Landon Curt Noll, Simon Cooper, and Leonid A.
Broukhis. All Rights Reserved. Permission for personal, educational
or non-profit use is granted provided this copyright and notice are
included in its entirety and remains unaltered.  All other uses
must receive prior permission from the contest judges.


## Standard IOCCC stuff

The primary IOCCC web site can be found at,

>	<http://www.ioccc.org/>

Use make to compile entries.  It is possible that on non-Un\*x / non-Linux
systems the makefile needs to be changed.  See the Makefile for details.

Look at the source and try to figure out what the programs do, and run
them with various inputs.  If you want to, look at the hints files for
spoilers - this year we included most of the information included
by the submitter.

Read over the makefile for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a #define).

Some C compilers are not quite as good as they should be.  If yours is
lacking, you may need to compile using clang or gcc instead of your local
compiler.


## Remarks on some of the winners

This year's Best of Show (carlini) is such a novel way of obfuscation that it would be
worth of a special mention in the (future) Best of IOCCC list!

For some reason, this year's set of winners contains three nostalgic games,
Asteroids (tsoj), Minesweeper (endoh1), and Snake (ferguson1).

An entry (kurdyukov1) pays homage to a previous winner (2015/hou).

...We'll stop spouting spoilers now. Have fun exploring all the entries!


## Remarks on some of submissions that did not win

As a rule, we try to compile the entries on a variety of platforms.
Quite a few entries this year could not be built or executed on some of them due to reliance on
library internals or the system runtime.

A few entries were violating the "2053 significant bytes" rule. If an entry could not be brought to
compliance within a few seconds of looking at the source, it was disqualified.

One entry tried to get around the size limit by putting the code into
makefile variables and using -D. This is already called out as discouraged
technique in the guidelines, but it is worth a reminder.

Several promising entries attempted to make use of the `syscall` function using literal syscall numbers.
This is utterly non-portable.

A note to the authors: when submitting multiple entries, don't let us easily correlate them by
coding style or documentation content, and definitely don't submit nearly identical versions
of your program separately. As we try to judge the entries anonymously, the similarities will cause such
entries to compete against one another, making each less likely to win.

We hope the authors of non-winning entries will refine their entries and
perhaps re-submit them for the next IOCCC.

## Final Comments

One more thing that feels dated is digraphs and trigraphs.

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

-----------------------------------------------------------------------------------------------------
(c) Copyright 1984-2020, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-----------------------------------------------------------------------------------------------------
