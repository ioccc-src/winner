# Twenty Sixth International Obfuscated C Code Contest


## Standard IOCCC stuff

View the `index.html` web page for the given winning entry for information on how
on how to compile it and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

The primary site can be found at [www.ioccc.org](https://www.ioccc.org).

Use `make` to compile entries.  It is possible that on non-Unix / non-Linux
systems the Makefile needs to be changed.  See the Makefile for details.

Read over the Makefile for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a #define).

Some C compilers are not quite as good as they should be.  If yours is
lacking, you may need to compile using clang or gcc instead of your local
compiler.


## Remarks on some of the winning entries

This year's winning entries are impressive!

The "Most in need of debugging" (endoh) is very inventive in a way it produces its own text!

The "Most likely to be awarded" (ciura) has an amazing vocabulary!

There are again nods to entries of the years:

	[1991/davidguy](../years.html#1991_davidguy)
	[2011/blakely](../years.html#2011_blakely)

These nods to not run afoul of the guideline:

	We tend to dislike programs that:
	...
	are rather similar to previous entries

because the entry [2019/dogon](2019/dogon/index.html) appropriately pays homage to past entries
without blatantly reusing their code.

...We'll stop spouting spoilers now. Have fun exploring all the entries!


## Remarks on some of submissions that did not win

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


## Final Comments

**IMPORTANT NOTE**: See [contact.html](../contact.html) for up to date contact details
as well as details on how to provide fixes to any of the entries.
See also [the IOCCC FAQ](../faq.html) for addition information on the IOCCC.


# Copyright and License

Copyright (c) 2019,2023, Landon Curt Noll and Leonid A. Broukhis. All Rights Reserved.
This work is licensed under a [Creative Commons CC BY-SA 4.0 DEED Attribution-ShareAlike
4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.
If you do use this work in some form, the [IOCCC judges](../judges.html) would appreciate
(but does not require) if you were to [send us a note about your use](../contact.html).
