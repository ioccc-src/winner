# A todo list of known things to check and/or do
*Last updated: Tue 28 Nov 2023 18:20:54 UTC*

This document is primarily for [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) as he (that is I :-) ) wanted a way
to keep track of things in a way that did not require the information getting
lost in the thousands of changes in the repo and because it might be too much to
add to the todo list in the issues themselves.

More things will likely be added over time and as items are done they _should
be_ removed from the list IF AND ONLY IF (!!) we are _absolutely certain_ it is
done (many times it's thought that a task was done only to find out it wasn't).
It is hoped that this will be referenced and updated as this is an easy way to
keep track of things that have been done already and what hasn't been done (in
this file the case is mostly _NOT_ been done).

- Find entries with bugs as well INABIAF and add to [bugs.md](/bugs.md).
    As far as I am aware the ones that have not been checked are > 2011 (and two
    entries in 2011, vik and zucker) and possibly some of the earlier years. I
    ([Cody Boone Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson)) have spent too
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
fixed but I added an alt version that does what it used to do so it's fine) but
many certainly can be - and actually most have been - fixed.

- Format fix remaining README.md files. As of **16 October 2023** the entries of
years through 2013 and up through 2014/endoh1 have been checked. As for the
`YYYY/README.md` files years up through 2001 have had a first pass but some
things have to be done in those years. These things, such as dealing with old
email addresses and such, can likely be done with the typo pass (see below).

- Typo fix ALL markdown files. For the README.md files years 1984-1989 have been
done (along with the format fixes) except that YYYY/README.md files have not
been completed. See below item for details on that.

- Go through all year README.md files: that is 1984/README.md, 1985/README.md and
so on. As of **Mon 16 Oct 11:22:52 UTC 2023** the following years have had a
first pass: 1984 through 2001. However there are changes that are required
namely to do with email addresses that no longer exist. At this point it is not
determined if this will be done with the typo pass (what should be the final
pass) or not but it's very possible that it can be just to speed things along.

- Verify which README.md files have not been checked for correct formatting and
fix any issues found.
    * This includes author information: not only at first column but making sure
    that the lines end with `\` so that the rendered output does not end up
    on one line only. Note that earlier spaces were being added to the end of
    the line but after discussion on GitHub it was decided it is preferable to
    have `\` instead.
	NOTE that this has been done already BUT it was not done manually so
	there are some lines that should not end in `\` including some in code
	blocks.
    * [Cody Boone
    Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson) has done
    many and has some kind of record of what he's done but these can be added
    later by having a list of years to check. However, as noted on 06 July 2023,
    all years will have to be checked again so this might not be as important
    except that the years not checked / fixed should only need one pass (but
    probably will have a second pass anyway just to make sure things are good as
    seeing things a second time is a good way to find additional errors).
    * NOTE that as of some days ago (today being 02 November 2023) the years
    1984-1989 have been checked for formatting and other issues including typos.
    Whether a quick final pass will be made is not determined yet.

- Remove addresses from older winning entries but (if known) keep country code
and if known add it and the name to the respective JSON file in the
[author](/author) subdirectory. As of half past 4 Pacific time on 22 April 2023
only the years through 1986 have been done entirely. This should not take much
time but I (Cody) am bored with it for now and would rather do other more
important things.  This will likely not be updated until after it's done (and
when I remember to remove it - I expect that when I go for it I'll do it in one
sitting or maybe a few sittings with a few brief breaks).

- NOTE: do this AFTER everything else is done! Verify that
[2004/gavin](2004/gavin/)'s [img/fs.tar](2004/gavin/img/fs.tar) contains the
same version of files as under [2004/gavin](2004/gavin/) itself.  This should be
verifiable by extracting the tarball in the entry's [img/](img/) subdirectory
and then typing the below from the entry's main directory
([2004/gavin](2004/gavin)), making sure no output is displayed:

	diff -r . img/fs|grep -v 'Only in'

- Check all Makefiles for notes / warnings on compilation and see if they can be
copied to _after_ the compilation as they're more likely to be seen this way. In
some cases this will have to be done in the Makefile via `|| :` (that might be
good to have in the Makefiles anyway so that additional rules / targets are
run) or else they'll have to be put above the compilation.
    * Make compilation of targets use `|| :` in the Makefiles to allow
    additional targets to compile and/or let warnings/notes be printed. An
    important use of this is that some entries won't compile with clang due to
    defects (though as I'm updating this on 12 July 2023 all but one in some
    versions of clang have been fixed if we consider in some cases alt versions)
    * Update on 06 July 2023: note that in some cases the `|| :` _**CANNOT**_ be
    added to the rule because the following rules require that the previous
    rules run successfully.

- Check the [GitHub issue #3 comment
1615962832](https://github.com/ioccc-src/temp-test-ioccc/issues/3#issuecomment-1615962832)
for links about the todo items wrt the [FAQ](/faq.md).

- Check for dead links of all kinds: not only author URLs but file URLs on the
website. I (Cody) would be seriously surprised if I did not make a typo
somewhere (or some places!) in the many thousands of changes I made in the
README.md files, the [bugs.md](/bugs.md) files and maybe even the
[thanks-for-fixes.md](/thanks-for-fixes.md) file plus others that might be
there.
    * In the case of author URLs sometimes the Internet Wayback Machine is
    helpful (and has helped) but in other cases it has not. Note that sometimes
    the Internet Wayback Machine helped find more recent URLs so this should be
    attempted first before adding the last archive link.
    * Remember to update the author JSON files if it's an author URL!
    * For URLs that cannot be located at all remove them entirely but add them
    to [bugs.md](/bugs.md) as a missing link to the respective entry. See that file for the
    correct status to add. Remember that each type of issue per entry in the
    [bugs.md](/bugs.md) file should have its own status.
    * If it's a link in the repo then there's no need (in almost all cases if
    not all cases) to have the Internet Wayback Machine: instead just update the
    link to point to the right location.
    * Do we need to update the links that point to GitHub raw content? I'm not
    sure.


- Remove WHERE CORRECT the references to those who fixed or provided alt code in
entries in the respective README.md files. This cannot be done without examining
each because some names are mentioned by the author. For instance I (Cody) can
think of at least three where I have been mentioned explicitly by the author:
one in 2018, one in 2019 and one in 2020.
    * NOTE: this _appears_ to be done as of some time back from this writing (02
    November 2023). This is being verified as each README.md file is checked.

- For the YYYY/README.md files where it refers to emailing the judges fixes
instead change it to make pull requests. See the
[1995/README.md](1995/README.md) file for example.

- Check the YYYY/README.md files for other things besides the GitHub pull
requests rather than emailing judges. This can be done on the final pass of the
files.

- In the entries with the alt code that use `usleep(3)` make the macro name
consistent across all entries. At one point `Z` was used but in one entry `Z`
was taken so this would not work. It appears at this time (16 November 2023)
that it might be that `S` will work in all cases (currently?) though one has two
values so the second would could be changed to `SS` (which is convenient as it's
for SDL). This is low priority but it would be nice to have done as it would
make it consistent and easy to remember.

- With the entries that we recommend the alt code first when it comes to it
going too fast we should say not what it looks like in modern systems but rather
what it LOOKED LIKE AT THE TIME. At Wed 22 Nov 2023 13:02:04 UTC the only entry
that has had this done is [1985/lycklama](1985/lycklama/README.md).

- Check 2001/westley for making `main()` have two args. Easy to make it have two
args but harder to make it function right.

- Check for video links in README.md files and see if the videos can be
embedded into the README.md files themselves. An entry that the video file is
downloaded already is 2006/sykes1. There are others that I need to look at once
the rest of the entries are done, assuming that it's possible.
