# A todo list of known things to check and/or do
*Last updated: Wed 31 May 2023 09:52:55 UTC*

More things will likely be added over time and as items are done they _should
be_ removed from the list IF AND ONLY IF (!!) we are _absolutely certain_ it is
done (many times it's thought that a task was done only to find out it wasn't).
It is hoped that this will be referenced and updated as this is an easy way to
keep track of things that have been done already and what hasn't been done (in
this file the case is mostly _NOT_ been done).

- Find entries with bugs as well INABIAF and add to [bugs.md](/bugs.md).
    For instance a INABIAF section should be added to [bugs.md](bugs.md) for
    [2004/jdalbec](2004/jdalbec/jdalbec.) based on the README.md file.
    As far as I am aware the ones that have not been checked are > 2011 (and two
    entries in 2011, vik and zucker) and possibly some of the earlier years. I
    ([Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)) have spent too
    much time when working on formatting the README.md files on finding problems
    out (and in some cases fixing or trying but not yet succeeding to fix an
    entry); if I did not do that I would be done with fixing the README.md files
    (format wise and mostly typos too). Of course when working on finding bugs
    it might necessitate updating the README.md file but that can be done at
    that time. I might or might not end up following this idea but I probably
    should so this needs to be noted.

- Resolve as many of the issues in [bugs.md](/bugs.md) with the exception of the
INABIAF ones. This is likely not possible for all (one in particular comes to
mind that abuses a bug in a now very old gcc version - this obviously cannot be
fixed) but many certainly can be (and have been) fixed.

- Check for typos in README.md files. Most years have been done. I (Cody) need
to check the late 80s through mid 1990s plus the last two entries in 2011 and
the following years. At the same time the formatting is being fixed.

- Go through all year README.md files that is 1984/README.md, 1985/README.md and
so on. As of *Sun 30 Apr 2023 13:45:52 UTC* the following years have been
finished: 1984, 1985, 1986, 2004, 2005.

- Verify which README.md files have not been checked for correct formatting and
fix any issues.
    * This includes author information: not only at first column but making sure
    that the lines end with spaces so that the rendered output does not end up
    on one line only.
    * [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has done many and
    has some kind of record of what he's done but these can be added later by
    having a list of years to check.
    * NOTE: as of 03 May 2023 years up through most of 2011 have been checked
    except that a few years I am pretty sure I did not check typos (I'd say about
    1987 or 1988 through 1995 should be rechecked for typos).  It's very likely
    I won't keep this updated until it's finished but I wanted to note it now.
    * NOTE: a while back (as of 31 May 2023) Cody noticed that some of the files
    he already checked could be improved wrt formatting so he'll have to have a
    quick look at the previously edited files; some he has done already but the
    vast majority have not been checked. These should be relatively easy to fix
    but will only be done _after_ the rest of the files are processed
    (presumably with complete changes made :-) ).

- Remove addresses from older winning entries but (if known) keep country code +
add country code to winners.csv. As of half past 4 Pacific time on 22 April 2023
only the years through 1986 have been done entirely. This should not take much
time but I (Cody) am bored with it for now and would rather do other more
important things.  This will likely not be updated until after it's done (and
when I remember to remove it - I expect that when I go for it I'll do it in one
sitting or maybe a few sittings with a few brief breaks).

- Verify that [2004/gavin](2004/gavin/)'s [img/fs.tar](2004/gavin/img/fs.tar)
contains the same version of files as under [2004/gavin](2004/gavin/) itself.
This should be verifiable by extracting the tarball in the entry's [img/](img/)
subdirectory and then typing the below from the entry's main directory
([2004/gavin](2004/gavin)), making sure no output is displayed:

	diff -r . img/fs|grep -v 'Only in'

- Try and see if I (Cody) can make [1985/sicherman](1985/sicherman/sicherman.c)
even more like its original form. I have some ideas here but it might involve
some discussion too. See 22 May 2023 commits for the improvements already made.

- Check all Makefiles for notes / warnings on compilation and see if they can be
moved to _after_ the compilation as they're more likely to be seen this way. In
some cases this will have to be done in the Makefile via `|| :` (that might be
good to have in the Makefiles anyway so that additional rules / targets are
run) or else they'll have to be put above the compilation.
    * Make compilation of targets use `|| :` in the Makefiles to allow
    additional targets to compile and/or let warnings/notes be printed. An
    important use of this is that some entries won't compile with clang due to
    defects but the alternate version will. Whether this is a good idea is TBD
    but it's noted here as a reminder to be discussed.


