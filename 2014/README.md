# Twenty Third International Obfuscated C Code Contest


## Standard IOCCC stuff

View the `index.html` web page for the given winning entry for information on how
compile the entry and how to run the winning program.  Look at the winning
source and try to figure how it does what it does!  You may then wish to look at
the Author's remarks for even more details.

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using gcc instead of your
local compiler.

The IOCCC has a website and now has a number of international mirrors.
The primary website can be found at [www.ioccc.org](https://www.ioccc.org).


## Remarks on some of the entries

We believe you will again be impressed with this year's winning entries.

This year, 2014:

We, the judges, were very surprised by this as many of the multiple
authors submitted very different styles of entries.

This [year](index.html) was the second time [the IOCCC size
tool](%%REPO_URL%%/2014/iocccsize.c) was used. Rule 2
required that when program source is fed as input to the current IOCCC size
tool, and the IOCCC size tool `-i` command line option is used, the value
printed should be less than or equal to 2053.

We were pleased to see that abuse of the rules was extended to abuse to the
IOCCC size tool.  [Matt Zucker](../authors.html#Matt_Zucker), followed by a few
users, were able to discover clever use of certain `//` comments to perplex the
size tool.  The abuse was so bad that the judges released a critical and
mandatory patch to the IOCCC size tool on 2014-09-23.

There were some great entries that did not win.  Unfortunately
some entries lost because they:

+ were too large according the IOCCC size tool and didn't
  even attempt to justify their excess by a clever abuse of the rules

+ depended on a single obfuscation trick

+ didn't work as documented

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

There is a risk in submitting an entry that is similar to a well
used theme by previous winning entries.  Previous authors set a very high
bar.  A new winning entry must not only compete against submissions
from the current year, they must also excel over any similar entries
in some particularly impressive way.


## On the delay in releasing the winning entries

We apologize on the delay of sending the authors the tarball for them
to review.  There were some unforeseen events, such as unplanned mandatory
business travel, the death of an IOCCC judge's mother, etc. that impacted
our planned schedule for building the tarball of this year's winning entries.

During some of these forced delays, we took the time to better automate
some of the tools needed to package the source for the winning entries to review
and to post the edited entries to the website.  It is our intent that
these changes made during those delays will make releasing future winning IOCCC
entries a faster procedure.

p.s. The final advice given to Landon by his mom: "_Have fun._"
We recommend following this advice where possible.


## Final Comments

Please feel free to send us comments and suggestions about the
competition, this README or anything else that you would like to see in
future contests.

If you use, distribute or publish these entries in some way, please drop
us a line.  We enjoy seeing who, where and how the contest is used.

If you have problems with any of the entries, AND YOU HAVE A FIX, please
send us the fix (patch file or the entire changed file).

For the latest information on how to contact the IOCCC Judges please visit

* [contact.html](../contact.html)

For news of the next contest watch:

* [news.html](../news.html)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
