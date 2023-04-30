# 2005 marked the "The Eighteenth International Obfuscated C Code Contest"


## Standard IOCCC stuff

Look at the `README.md` file for the given winner for information
on how to compile the entry and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

The IOCCC has a web site and now has a number of international mirrors.
The primary site can be found at <https://www.ioccc.org/>.

Use `make(1)` to compile entries.  It is possible that on non-Unix / non-Linux
systems the `Makefile` needs to be changed.  See the `Makefile` for details.

This year we included most of the information included by the submitters
in the `README.md` files.

Read over the `Makefile` for compile/build issues.  Your system may require
certain changes (add or remove a library, add or remove a `#define`).

Some ANSI C compilers are not quite as good as they should be.  If
yours is lacking, you may need to compile using `gcc` instead of your
local compiler.


## Remarks on some of the entries

We believe you will be impressed with this year's winners.

In particular:

+ The [Abuse of the rules](klausler/klausler.c) used local dictionary data to
get around the size limit.

+ The [Most beauteous visuals](vince/vince.c) made clever use of `{}`s and
whitespace in their source code and during execution.

+ The [Most circuitous walk](vik/vik.c) entry is just amazing.

+ The [Best game](toledo/toledo.c) makes full use of its single function.

+ The [Best emulator](sykes) may allow you to reconnect to your first
[PET](https://en.wikipedia.org/wiki/Commodore_PET).

+ Our [Best of Show](persano/persano.c) this year was simply (or non-simply :-) ) the best!

+ (And we need only mention (parenthetically speaking) that the best use of parenthesis is self reproducing).

+ The [Most sonorous output](jetro/jetro.c) might `sound` :-) like a good idea.

+ The [Best 2D puzzle](giljade/giljade.c) takes editorial license with expressions as well as the
with the [vi editor](https://en.wikipedia.org/wiki/Vi).

+ The [Most ambiguous language](chia/chia.c) winner is really a C program.

+ The [Most superfluous output](boutines/boutines.c) winner is simply
[Voronoi](Voronoi)-lific!

+ Try not to have your sense of good coding offended by the [Most
discourteous interpreter](timwi/timwi.c) winner.

+ The [Best use of the www](mynx/mynx.c) doesn't include those letters.

+ You will be puzzled by the [Best 3D puzzle](anon/anon.c) winner; we are sure!

+ The [Most ingenious puzzle solution](aidan/aidan.c) might puzzle you more while it
puzzles out some puzzles: all in a puzzling way!  :-)

### Remarks on some of the losing entries

There were some outstanding entries that did not win.  Unfortunately
some very good entries lost because they:

+ depended too much on non-portable side effects in expressions; and/or

+ depended too much on a particular byte order; and/or

+ required the use of a special script, data file or pseudo-machine
  language that was not supplied with the entry.

We hope the authors of some of those entries will fix and resubmit
them for the next IOCCC.


## Final Comments

Please feel free to send us comments and suggestions about the competition, this
[README.md](README.md) or anything else that you would like to see in future
contests.

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

For news of the next contest watch <https://www.ioccc.org/>.

=-=

Copyright (C) 2005, Landon Curt Noll, Simon Cooper, and Leonid A.
Broukhis. All Rights Reserved. Permission for personal, educational
or non-profit use is granted provided this copyright and notice are
included in its entirety and remains unaltered.  All other uses
must receive prior permission from the contest judges.
