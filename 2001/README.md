# Sixteenth International Obfuscated C Code Contest


## Standard IOCCC stuff

Look at the README.md file for the given winning entry for information
on how to compile it and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

The IOCCC has a web site and now has a number of international mirrors.  The
primary site can be found at <https://www.ioccc.org>.

Use `make` to compile entries.  It is possible that on non-Unix / non-Linux
systems the Makefile needs to be changed.  See the Makefile for details.

Read over the Makefile for compile/build issues.  Your system may
require certain changes (add or remove a library, add or remove a
`#define` i.e. the `-D` flag).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using gcc instead of your
local compiler.


## Remarks on some of the entries

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

- depended too much on non-portable side effects in expressions;
- depended too much on a particular byte order;
- required the use of a special script, data file or pseudo-machine
  language that was not supplied with the entry.

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.

We believe you will be impressed with this year's winners.  The [Best of
Show](ollinger/README.md) is a fine example of obfuscation.  But don't ignore
the other winners!  There are games, programs that speak, ones that compile code
and [one that might run binaries you already have](2001/anonymous/README.md).

The [Best/Worst Abuse of the Rules](bellard/README.md) is technically allowed by the
[rules](rules.txt).  This year we awarded it again, but don't assume you can get
away with using the same technique next time ... :-)

This year there were several repeat winners.  This is understating the
achievement a little - [one
person](https://www.ioccc.org/winners.html#Brian_Westley) has won 8 times
before! (Please note that judging is done completely anonymously.)


## Why has it taken so long to post the winning source?

This is somewhat my (Simon Cooper's) fault.  I do apologize to the IOCCC
community for this!  Judging does take quite a lot of time, and I
over-committed myself several times this year.  Without divulging too much,
we do look at and work out what every entry does.


## Final Comments

Please send us comments and suggestions what we have expressed above.
Also include anything else that you would like to see in future contests.
Send such email to:

```
questions@ioccc.org
```

**IMPORTANT NOTE**: The email addresses found above are for historical
purposes only, and should not be used today.  See
[contact.html](/contact.html) for up to date contact details
as well as details on how to provide fixes to any of the entries.
See also [the IOCCC FAQ](/faq.html) for addition information on the IOCCC.


# Copyright and License

Copyright (c) 2001,2002,2023, Landon Curt Noll, Peter Seebach and Leonid A. Broukhis, All Rights Reserved.
This work is licensed under a [Creative Commons CC BY-SA 4.0 DEED Attribution-ShareAlike
4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.
If you do use this work in some form, the [IOCCC judges](/judges.html) would appreciate
(but does not require) if you were to [send us a note about your use](/contact.html).
