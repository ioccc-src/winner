# Twenty Seventh International Obfuscated C Code Contest


## Standard IOCCC stuff

View the `index.html` web page for the given winning entry for information on how
on how to compile it and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

Some C compilers are not quite as good as they should be.  If yours is
lacking, you may need to compile using clang or gcc instead of your local
compiler.

The primary website can be found at [www.ioccc.org](https://www.ioccc.org).

## Remarks on some of the winning entries

This year's [Best of Show - abuse of libc - 2020/carlini](carlini/index.html) is such a novel way of
obfuscation that it would be worthy of a special mention in the (future) Best of
IOCCC list!

For some reason, this year's set of winning entries contains three nostalgic games,
[Asteroids - 2020/tsoj](tsoj/index.html), [Minesweeper - 2020/endoh1](endoh1/index.html),
and [Snake - 2020/ferguson1](ferguson1/index.html).

An entry, [kurdyukov1](kurdyukov1/index.html), pays homage to the previous entry
[2015/hou](../2015/hou/index.html).

...We'll stop spouting too many details now. Have fun exploring all the entries!


## Remarks on some of submissions that did not win

As a rule, we try to compile the entries on a variety of platforms.  Quite a few
entries this year could not be built or executed on some of them due to reliance
on library internals or the system runtime.

A few entries were violating the "2053 significant bytes" rule. If an entry
could not be brought to compliance within a few seconds of looking at the
source, it was disqualified.

One entry tried to get around the size limit by putting the code into
Makefile variables and using `-D`. This is already called out as discouraged
technique in the guidelines, but it is worth a reminder.

Several promising entries attempted to make use of the `syscall` function using
literal syscall numbers.  This is utterly non-portable.

A note to the authors: when submitting multiple entries, don't let us easily
correlate them by coding style or documentation content, and definitely don't
submit nearly identical versions of your program separately. As we try to judge
the entries anonymously, the similarities will cause such entries to compete
against one another, making each less likely to win.

We hope the authors of non-winning entries will refine their entries and
perhaps re-submit them for the next IOCCC.


## Final Comments

One more thing that feels dated is digraphs and trigraphs.

**IMPORTANT NOTE**: See [contact.html](../contact.html) for up to date contact details
as well as details on how to provide fixes to any of the entries.
See also the [IOCCC FAQ](../faq.html) for additional information on the IOCCC.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
