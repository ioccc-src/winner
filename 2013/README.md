# Twenty Second International Obfuscated C Code Contest


## Standard IOCCC stuff

Look at the README.md file for the given winning entry for information on how to
compile the entry and how to run the winning program.  Look at the winning
source and try to figure how it does what it does!  You may then wish to look at
the Author's remarks for even more details.

The IOCCC has a web site and now has a number of international mirrors.
The primary site can be found at: <https://www.ioccc.org/>

Use `make` to compile entries.  It is possible that on non-Unix / non-Linux
systems the Makefile needs to be changed.  See the Makefile for details.

Read over the Makefile for compile/build issues.  Your system might require
certain changes (add or remove a library, add or remove a `#define` i.e. `-D`
flag).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using gcc instead of your
local compiler.


## Remarks on some of the entries

We believe you will again be impressed with this year's winners.

This year, 9 won 15 awards.  For the first time in the history of the contest,
one person, [Yusuke Endoh](https://www.ioccc.org/winners.html#Yusuke_Endoh) won
4 times while [Adrian Cable](https://www.ioccc.org/winners.html#Adrian_Cable)
won 3 times!  It is also worth noting that [Chris
Mills](https://www.ioccc.org/winners.html#Christopher_Mills) last win was in 1993.
Welcome back Chris!

We, the judges, were very surprised by this as many of the multiple
winners submitted very different styles of entries.

This year was the first time the IOCCC size tool was used.  Entries
had to print a value 2053 or less when the `-i` flag was used.

Several people discovered an undocumented feature in that
certain comments such as:

```c
	///*
```

or:

```c
	*\
	/
```

were not correctly parsed by the tool.  The guidelines stated:


```
In cases where the above summary and the algorithm implemented by
the IOCCC size tool source code conflict, the algorithm implemented
by the IOCCC size tool source code is preferred by the judges.
```

so this abuse was allowed (and encouraged).  The judges hope that
the IOCCC size tool author will patch the tool to block this kind
of size abuse in future contests.

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

* were way way oversized and didn't even attempt to justify their
  excess by a clever abuse of the rules
* depended on a single obfuscation trick
* could only be run on a particular vendor's platform
* were very similar to previous winners
* didn't work as documented

We hope that the authors of some of those entries will fix and resubmit them
for the next IOCCC.

There is a risk in submitting an entry that is similar to a well used theme by
previous winners. Previous winners set a very high bar. A new winner must not
only compete against other submissions from the current year but they must also
excel over similar previous winners in some particularly impressive way.


## Final Comments

**IMPORTANT NOTE**: See [contact.html](/contact.html) for up to date contact details
as well as details on how to provide fixes to any of the entries.
See also [the IOCCC FAQ](/faq.html) for addition information on the IOCCC.


# Copyright and License

Copyright (c) 2013,2023, Landon Curt Noll and Leonid A. Broukhis. All Rights Reserved.
This work is licensed under a [Creative Commons CC BY-SA 4.0 DEED Attribution-ShareAlike
4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.
If you do use this work in some form, the [IOCCC judges](/judges.html) would appreciate
(but does not require) if you were to [send us a note about your use](/contact.html).
