# A todo list of known things to check and/or do
*Last updated: Tue 10 Oct 2023 13:08:59 UTC*

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

- Check for typos in README.md files. Although I did up through I believe 2011 I
have to do another pass through all except that as of 12 July 2023 I went
through 1984 and 1985. At the same time the formatting has to be / is being
checked.
    * UPDATE on 06 July 2023: some while back I noticed that _ALL_ years will
    have to be checked again but most of the years checked through 2011 (I think
    it is but I have this vague memory I did a couple more years - that will be
    checked when I return to this item) can be checked more quickly.
    * UPDATE on 06 July 2023: see below list under the item _Verify which
    README.md files have not been checked for correct formatting_ as well.
    * UPDATE on 06 July 2023: note that this does NOT include the
    `YYYY/README.md` files! See the below item for that.

- Go through all year README.md files that is 1984/README.md, 1985/README.md and
so on. As of *Sun 30 Apr 2023 13:45:52 UTC* the following years have been
finished: 1984, 1985, 1986, 2004, 2005.

- Verify which README.md files have not been checked for correct formatting and
fix any issues.
    * This includes author information: not only at first column but making sure
    that the lines end with `<br>` so that the rendered output does not end up
    on one line only. Note that earlier spaces were being added to the end of
    the line but after discussion on GitHub it was decided it is preferable to
    have `<br>` instead.
    * [Cody Boone
    Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson) has done
    many and has some kind of record of what he's done but these can be added
    later by having a list of years to check. However, as noted on 06 July 2023,
    all years will have to be checked again so this might not be as important
    except that the years not checked / fixed should only need one pass (but
    probably will have a second pass anyway just to make sure things are good as
    seeing things a second time is a good way to find additional errors).

- Remove addresses from older winning entries but (if known) keep country code +
add country code and name to the respective JSON file in the [author](/author)
subdirectory. As of half past 4 Pacific time on 22 April 2023 only the years
through 1986 have been done entirely. This should not take much time but I
(Cody) am bored with it for now and would rather do other more important things.
This will likely not be updated until after it's done (and when I remember to
remove it - I expect that when I go for it I'll do it in one sitting or maybe a
few sittings with a few brief breaks).

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

- For the YYYY/README.md files where it refers to emailing the judges fixes
instead change it to make pull requests. See the
[1995/README.md](1995/README.md) file for example.

- Check the YYYY/README.md files for other things besides the GitHub pull
requests rather thane mailing judges. This can be done on the final pass of the
files.
