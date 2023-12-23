# A todo list of known things to check and/or do
*Last updated: Sat 23 Dec 2023 13:28:11 UTC*

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

- Resolve as many of the issues in [bugs.md](/bugs.md) with the exception of the
INABIAF ones. This is likely not possible for all (one in particular comes to
mind that abuses a bug in a now very old gcc version - this obviously cannot be
fixed but I added an alt version that does what it used to do so it's fine) but
many certainly can be - and actually most have been - fixed. Another one crashes
in macOS but this is almost certainly because of the version of perl installed.
Another one crashes in macOS but this is almost certainly because of
`mmap(2)`/JIT code with the Apple silicon chip etc.

- Typo fix ALL markdown files. For the README.md files the entries have all been
done (along with format fixes) but the YYYY/README.md files have not been
completed. See below item for details on that (several items in this file refer
to those).

- Go through all year README.md files: that is 1984/README.md, 1985/README.md and
so on. As of **Mon 16 Oct 11:22:52 UTC 2023** the following years have had a
first pass: 1984 through 2001. However there are changes that are required
namely to do with email addresses that no longer exist. At this point it is not
determined if this will be done with the typo pass (what should be the final
pass) or not but it's very possible that it can be just to speed things along.

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
[thanks-for-help.md](/thanks-for-help.md) file plus others that might be
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

- Although I will have to do this when another issue is opened up I am aware of
some issues in 2020/ferguson1/.winner.json. I do not want to forget this,
however, so I am noting it here.
