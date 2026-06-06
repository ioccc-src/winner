# Twenty Ninth International Obfuscated C Code Contest


## Where to start

See below for links to the [2025 winning IOCCC entries](#inventory).

Check out the `index.html` web pages for each winning entry.  They have
most of the information you need to compile and run the winning program.
Take a look at the winning source code and try to figure out how it works.
You might also want to check out the author’s remarks for even more details.

You may [download all winning entries](2025.tar.bz2) in the form
of a compressed tarball for this year's contest.


## General remarks on this contest

For **IOCCC29**, the volume and quality of submissions were at near-historic heights.

**IOCCC28** was speculated to have attracted a record number of submissions
due to the 4-year absence, allowing authors to refine their submissions,
resulting in a higher-than-usual submission quality.

**IOCCC29** was the second consecutive contest after the 2020-2024 hiatus.
And yet, the number of submissions for **IOCCC29** was similar to last
year's contest, and the overall submission quality remained high for
this contest.  So perhaps the increased submission volume, combined
with a higher-than-usual submission quality, is due to factors such
as improved website design, increased social media presence, authors
building on the ideas of past winning entries, and other factors?

Starting with the close of **IOCCC28**, the procedures used for
closing the contest to new submissions, the judging process,
selecting the winning entries, preparing the update to the website,
and the process to create the live show on the
[Our Favorite Universe](https://www.youtube.com/ourfavoriteuniverse)
were carefully documented.  And while this documentation required
additional time as well as more effort, the documentation process
resulted in overall improvements to how the **IOCCC** is run.

A few days after the presentation of the winning entries for **IOCCC29** has been made
on the [Our Favorite Universe](https://www.youtube.com/ourfavoriteuniverse)
YouTube channel. The recording of the main show will be divided up into individual segments.
Then, each winning entry will be updated to include a link to a YouTube
segment under a new **Award presentation** near the top of the winning
entry's `index.html` page.


<div id="fun_challenge_info">
### Fun challenge info
</div>

We have added fun challenges to this year's winning entries
competition, under the "**Judges' remarks**" section. After you figure
out what a given winning entry does, we encourage you to attempt the
fun challenge.

Some of these challenges are easier than others. In some cases, you’re
asked to create an alternative version of `prog.c` or a related file.
In some cases you are asked to produce an explanation about something.

If the fun challenge is **still open** (check the "**A fun challenge**"
section for the given winning entry), consider submitting a
[GitHub pull request](../faq.html#pull_request) as a contribution.

If the fun challenge is closed, but you think you have a better solution,
consider submitting a [GitHub pull request](../faq.html#pull_request) as a contribution.
If the IOCCC Judges agree that you solution is better, we will consider it.


### Rules and Guidelines for this contest

The final versions of the IOCCC rules and guidelines that were in effect for this contest were:

* [2025 rules](rules.html) version **29.15 2025-12-02**
* [2025 guidelines](guidelines.html) version **29.08 2025-12-02**

The IOCCC rules and guidelines for **IOCCC29** represented a substantial
rewrite over previous contests, thanks in part to a number of volunteers:
giving the IOCCC judges useful edits, text rewrites, consolidation,
as well as overall improved organization.


### Looking forward to the next contest

We plan to open **IOCCC30** towards the end of 2025 and have the contest run
for a similar amount of time, closing sometime towards the end of Q1 2026.

As we perform the actions needed to open **IOCCC30**, we plan to internally
document the process as we did during the closing of **IOCCC29**.

<div id="mkiocccentry_update">
About two or three weeks after the **IOCCC29** winning entries
have been posted, and we process some of the early
[pull requests](https://github.com/ioccc-src/winner/pulls)
against the [2025 directory tree](index.html), the
[IOCCC Judges](https://www.ioccc.org/judges.html) plan to go on an **IOCCC vacation**.

We had intended to go on an **IOCCC vacation** after releasing the winners of
**IOCCC28**, but then the efforts to process bug fixes and enhancements
to the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
took so much time that by the time that repo was stable, it was time to
open **IOCCC29**.  Therefore, this time, we plan to wait until after
the end of our post-**IOCCC29** **IOCCC vacation** before working on any
[mkiocccentry repo PRs](https://github.com/ioccc-src/mkiocccentry/pulls).
</div>


## Remarks on some of the winning entries

While working on creating potential write-ups for submissions that entered
the final round of the set of judging rounds:

* A few submissions were set aside in the final round of the final set of rounds.
* We gained an additional level of appreciation for a number of the remaining entries.

While the winning entry authors came from
[locations of previous winning authors](https://www.ioccc.org/location.html),
this **IOCCC29** had an [author - jingp49](%%REPO_URL%%/authors.html#jingp49)
from a new location: [Taiwan](../location.html#TW).

This contest saw a [Hat trick](https://en.wikipedia.org/wiki/Hat_trick_&lpar;disambiguation&rpar;)
of [Hat-tricks](https://en.wikipedia.org/wiki/Hat-trick) by:

* [Yusuke Endoh](../authors.html#Yusuke_Endoh): [2025/endoh1](endoh1/index.html), [2025/endoh2](endoh2/index.html), and [2025/endoh3](endoh3/index.html)
* [Nick Craig-Wood](../authors.html#Nick_Craig_Wood): [2025/ncw1](ncw1/index.html), [2025/ncw2](ncw2/index.html), and [2025/ncw3](ncw3/index.html)
* [Don Yang](../authors.html#Don_Yang): [2025/yang1](yang1/index.html), [2025/yang2](yang2/index.html), and [2025/yang3](yang3/index.html)

Notable and remarkable winning entries of **IOCCC29** include, but are not limited to:

* [2025/cable](cable/index.html) - Subleq computer
* [2025/cesmoak](cesmoak/index.html) - Black hole punchcard Fortran
* [2025/endoh3](endoh3/index.html) - patch/diff quine
* [2025/jhshrvdp](jhshrvdp/index.html) - Quasi-rogue-like game
* [2025/jingp49](jingp49/index.html) - Dr. WHO sequence
* [2025/ncw1](ncw1/index.html) - GameBoy emulator
* [2025/tompng](tompng/index.html) - Ocean sound generator
* [2025/uellenberg](uellenberg/index.html) - Quine pong
* [2025/yang2](yang2/index.html) - Zoltraak encoding

Those are just a few of the **many amazing winners** of the **IOCCC29**, so be sure to check out the rest!


### Remarks on some of the submissions that did not win

As we discussed above, there were quite a few excellent submissions that
didn’t quite make the final cut. We truly appreciate the hard work
each author put into their entries, but we’re sorry that we can’t
award based solely on effort.

We received many great submissions that didn’t quite make the cut
as winners. If you submitted something for **IOCCC29** that didn’t
win, think about polishing your code and giving it another shot for
**IOCCC30**. Interestingly, more than one winner of **IOCCC29** was
actually an improved version of code that didn’t win in a previous
contest.


### Encouragement for those who did not win this year

We know many of you that submitted to the IOCCC put in a ton of effort
into your submissions for this year’s IOCCC.  We can’t just give out
awards to everyone.  That would mean taking away from the submissions
that we think are the best and deserve to win.

Sometimes, a final round submission might be good enough to be a
winning IOCCC entry, only to be beaten by a similar, but slightly better
submission.  If you think this happened with your submission, consider
submitting an enhanced version to the next IOCCC.

**PLEASE DO NOT** give up hope! There are some submissions that have been
submitted with revisions, multiple times before rising to the level of
a winning IOCCC entry.  You might also want to try with a different type
of submission altogether for the next IOCCC.

If you’re not planning to improve and resubmit your non-winning entry
for the next IOCCC, you’re welcome to publish it.


## On compiling and running winning entries

Some C compilers aren’t as great as they could be. If yours isn’t
working well, you might want to try compiling with an updated version
of clang and/or gcc instead.

If you encounter problems in compiling and/or running the winning entries, see the FAQ on:

* [Compiling IOCCC entries](../faq.html#compiling)
* [IOCCC entry dependencies](../faq.html#dependencies)
* [Problems compiling entries](../faq.html#compile_problems)
* [Running IOCCC entries](../faq.html#running_entries)

For additional information on how to submit fixes, see the FAQ on:

* [How to submit a fix](../faq.html#fix_an_entry) - how to submit a fix to an entry
* [Update author information](../faq.html#fix_author) - how to correct or update an IOCCC author’s information


## For even more information

* [Reporting an IOCCC website problem](../faq.html#report_website_problem)
* [Submitting a fix to the IOCCC website](../faq.html#fix_website)
* [How to contact the IOCCC](../contact.html) - up-to-date contact details
* [IOCCC FAQ](../faq.html) - additional information on the IOCCC
* [www.ioccc.org](https://www.ioccc.org) - the primary IOCCC website


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
