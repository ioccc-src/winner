# [2004](/years.html#2004) marked the "The Seventeenth International Obfuscated C Code Contest"


## Standard IOCCC stuff

Look at the `README.md` file for the given winner for information
on how to compile the entry and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

The IOCCC has a web site and now has a number of international mirrors.
The primary site can be found at <https://www.ioccc.org/>.

Use `make(1)` to compile entries.  It is possible that on non-Unix / non-Linux
systems the `Makefile` needs to be changed.  See the `Makefile` for details.

Read over the `Makefile` for compile/build issues.  Your system may
require certain changes (add or remove a library, add or remove a
`#define`).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using `gcc` instead of your
local compiler.


## Remarks on some of the entries

We believe you will be impressed with this year's winners.  The [Best of
Show](gavin/gavin.c) is a fine example of obfuscation.  But don't ignore the
other winners!  There are games, utilities, programs that output images and a
one-liner that is incredibly compact for what it can do.

The [Best Abuse of the Guidelines](hibachi/hibachi.c) is technically allowed by
the rules.  This year we allowed it due to the functionality of the program.
This entry is one of the easiest to read!  Don't assume you can win using
similar techniques next time ... :-)

This year a [single person](/winners.html#Daniel_Vik) won two awards!  We also
had repeat winners with their 6th, 4th and 2nd winning entries this year!
(Please note that judging is done completely anonymously.  Be warned that we may
disqualify entries that reveal the identity of the submitter.)

### Remarks on some losing entries

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

* depended too much on non-portable side effects in expressions; and/or
* depended too much on a particular byte order; and/or
* required the use of a special script, data file or pseudo-machine
  language that was not supplied with the entry.

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

## Final Comments

Please feel free to send us comments and suggestions about the
competition, this [README.md](README.md) or anything else that you would like to
see in future contests.

If you use, distribute or publish these entries in some way, please drop
us a line.  We enjoy seeing who, where and how the contest is used.

If you have problems with any of the entries, AND YOU HAVE A FIX, please
send us the fix please submit your fixes fix as a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls).

We will be happy to credit those who submit successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls) in the entry's
`README.md`.

For the latest information on how to contact the [IOCCC
Judges](https://www.ioccc.org/judges.html) please visit
<https://www.ioccc.org/contact.html>.

    https://www.ioccc.org/contact.html

For news of the next contest watch <https://www.ioccc.org/>.

=-=

Copyright (C) 2001-2004, Landon Curt Noll, Simon Cooper, Peter Seebach
and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
educational or non-profit use is granted provided this copyright and
notice are included in its entirety and remains unaltered.  All other
uses must receive prior permission from the contest judges.
