# Twenty Fourth International Obfuscated C Code Contest


## Standard IOCCC stuff

View the `index.html` web page for the given winning entry for information on how
compile the entry and how to run the winning program.  Look at the winning
source and try to figure how it does what it does!  You may then wish to look at
the Author's remarks for even more details. This year we included most of the
information included by the submitter.

The IOCCC has a website and now has a number of international mirrors.
The primary site can be found at [www.ioccc.org](https://www.ioccc.org).

Use `make` to compile entries.  It is possible that on non-Unix / non-Linux
systems the Makefile needs to be changed.  See the Makefile for details.

Look at the source and try to figure out what the programs do, and run
them with various inputs.

Read over the Makefile for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a `#define`).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using gcc instead of your
local compiler.


## Remarks on some of the winning entries

We believe you will again be impressed with this year's winning entries.

The fraction of worthy entries was higher than usual.

We call to your attention the [hou](hou/index.html) entry that performs the MD5
cryptographic hash.  Normally implemented with a set of integer and boolean
operations, this code uses floating point variables inside a single `while` loop
filled with unusual constants, cosine, square root, and exponent function calls.
The number of lines of code is also smaller than the original algorithm.

The [mills2](mills2/index.html) source code is a very compressed version of a
decompression algorithm.  We think those who enjoy compression algorithms will
particularly enjoy this entry.

We suggest that you attempt to completely understand the
[endoh4](endoh4/index.html) 1-liner program: another impressive compact piece of
C code.

And while you are at it, cat the [endoh2 prog.c](%%REPO_URL%%/2015/endoh2/prog.c) code.  Compile it
and look at the source code again.

In a "Back to the Future" moment, [endoh3](endoh3/index.html) gave us a twist on
one of the all time best IOCCC entries from 1984.

We also suggest that you take a very good look at how the
[muth](muth/index.html) code makes full use of the C Pre-Processor.

...We'll stop spouting spoilers now. Have fun exploring all the entries!


## Remarks on some of submissions that did not win

The number of entries that would have made it into the final rounds
would have been much higher had some people paid attention to rules 2
and 22 (one third of 666).

Rule 22, now known as **Catch 22** states:

```
    22) Your source code, data files, remarks and program output must NOT
        identify the authors of your code.  The judges STRONGLY prefer to
        not know who is submitting entries to the IOCCC.

        The "Peter Honeyman is exempt" guideline also applies to this rule.
        Identifying yourself, in an obvious way in your code, data, remarks
        or program output, unless you are Peter Honeyman or pretending
        to be Peter Honeyman, will be grounds for disqualification of your entry.
```

A number of other entries were based on [iocccsize.c](%%REPO_URL%%/2015/iocccsize.c), making
derivative works rather than original works.

Still other entries were too large, violating the first line of rule 2:

```
    2) The size of your program source must be <= 4096 bytes in length.
```

While these entries might have passed under the 2053 limit for iocccsize,
they were larger than <= 4096 bytes, sometimes by an order or magnitude.

We hope the authors of some of those entries will fix and re-submit
them for the next IOCCC.


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
