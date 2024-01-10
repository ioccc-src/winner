# 2014 marked the "The Twenty Third International Obfuscated C Code Contest"


## Standard IOCCC stuff

The IOCCC has a web site and now has a number of international mirrors.
The primary site can be found at,

* [http://www.ioccc.org/](http://www.ioccc.org/)

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


## Remarks on some of the entries

We believe you will again be impressed with this year's winners.

This year, 2014:

We, the judges, were very surprised by this as many of the multiple
winners submitted very different styles of entries.

This year was the second time the IOCCC size tool was used. Rule 2
required that when program source is fed as input to the current IOCCC size
tool, and the IOCCC size tool -i command line option is used, the value
printed should be less than or equal to 2053.

We were pleased to see that abuse of the rules was extended to abuse
to the IOCCC size tool.  Matt Zucker, followed by a few users, were
able to discover cleaver use of certain // comments to perplex the size tool.
The abuse was so bad that the judges released a critical and mandatory
patch to the IOCCC size tool on 2014-09-23.

There were some great entries that did not win.  Unfortunately
some entries lost because they:

+ were too large according the IOCCC size tool and didn't
  even attempt to justify their excess by a clever abuse of the rules

+ depended on a single obfuscation trick

+ didn't work as documented

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

There is a risk in submitting an entry that is similar to a well
used theme by previous winners.  Previous winners set a very high
bar.  A new winner must not only compete against submissions
from the current year, they must also excel over any similar winners
in some particularly impressive way.


## On the delay in releasing the winners

We apologize on the delay of sending the winners the tarball for them
to review.  There were some unforeseen events, such as unplanned mandatory
business travel, the death of a IOCCC judge mother, etc. that impacted
our planned schedule for building the IOCCC winner tarball.

During some of these forced delays, we took the time to better automate
some of the tools needed to package the source for the winners to review
and to post the edited winners to the web site.  It is our intent that
these changes made during those delays will make releasing future IOCCC
winners a faster procedure.

p.s. The final advice given to Landon by his mom: "Have fun."
We recommend following this advice were possible.


## Final Comments

Please feel free to send us comments and suggestions about the
competition, this README or anything else that you would like to see in
future contests.

If you use, distribute or publish these entries in some way, please drop
us a line.  We enjoy seeing who, where and how the contest is used.

If you have problems with any of the entries, AND YOU HAVE A FIX, please
send us the fix (patch file or the entire changed file).

For the latest information on how to contact the IOCCC Judges please visit

* [http://www.ioccc.org/contact.html](http://www.ioccc.org/contact.html)

For news of the next contest watch:

* [http://www.ioccc.org/](http://www.ioccc.org/)


# Copyright and License

Copyright (C) 2014,2024, Landon Curt Noll and Leonid A. Broukhis. All Rights Reserved.
This work is licensed under a [Creative Commons CC BY-SA 4.0 DEED Attribution-ShareAlike
4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.
If you do use this work in some form, the [IOCCC judges](/judges.html) would appreciate
(but does not require) if you were to [send us a note about your use](/contact.html).
