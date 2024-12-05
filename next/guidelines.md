<!-- START: this line starts content from: inc/guidelines.closed.hdr -->

# WARNING: These guidelines are OUT OF DATE

These guidelines are a **VERY TENTATIVE proposal** for the next IOCCC
and are **VERY LIKELY** to be updated before the next IOCCC.
They are are provided as a **VERY TENTATIVE** hint at **what
MIGHT** be used in the next IOCCC.  In some cases they might
even be a copy of the guidelines from the previous IOCCC.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[asking questions](../faq.html#question)"
about these guidelines. You might also find the
FAQ in general useful, especially the
[FAQ section "How to enter: the bare minimum you need to know"](../faq.html#submit).

# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entries that have won the
IOCCC in the past.

Watch both [the IOCCC status page](../status.html) and the
[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about
future IOCCC openings.

**HINT to mastodon users**: You may wish to refresh the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) page and/or mastodon
app from time to time to view IOCCC mastodon updates.

<!-- END: the next line ends content from: inc/guidelines.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->
# 28th International Obfuscated C Code Contest Official Guidelines

<p class="leftbar">
Copyright &copy; 2024 Leonid A. Broukhis and Landon Curt Noll.
</p>

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing by [contacting the judges](../contact.html).

Jump to: [top](#)

<div id="guidelines_version">
<div id="version">
# IOCCC Guidelines version
</div>
</div>

<p class="leftbar">
These [IOCCC guidelines](guidelines.html) are version **28.25 2024-12-05**.
</p>

**IMPORTANT**: Be **SURE** to read the [IOCCC rules](rules.html).

Jump to: [top](#)

<div id="change_marks">
## Change marks
</div>

<p class="leftbar">**&larr; Lines that start with this symbol indicate a change from the
previous IOCCC**.
</p>

Most lines (we sometimes make mistakes) that were modified since the previous
IOCCC start with a solid 4 pixel black left border (or, in the case of a code
block or blockquote, just a vertical bar).

Jump to: [top](#)

<div id="about_guidelines">
# ABOUT THIS FILE:
</div>

This file contains _guidelines_ intended to help people who wish to
participate in the [International Obfuscated C Code Contest
&lpar;IOCCC&rpar;](https://www.ioccc.org).

These are **NOT the [IOCCC rules](rules.html)**, though it does contain comments
about them.  The [IOCCC guidelines](guidelines.html) should be viewed as
**hints** and **suggestions**.  **Entries that violate the
[guidelines](guidelines.html) _but remain within the [rules](rules.html)_** _are
allowed_.  Even so, you are safer if you remain within the [IOCCC
guidelines](guidelines.html).

**You should read the current [IOCCC rules](rules.html), prior to submitting
entries**. The [rules](rules.html) are typically published along with the [IOCCC
guidelines](guidelines.html)..

Jump to: [top](#)

<div id="new">
# WHAT'S NEW THIS IOCCC
</div>

<p class="leftbar">
This IOCCC runs from **2024-MMM-DD HH:MM:SS UTC** to **YYYY-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>

<p class="leftbar">
The reason for the times of day are so that key IOCCC events are **calculated**
to be a **fun**ctional UTC time.  :-)
</p>

<p class="leftbar">
Until the start of this IOCCC, the [IOCCC rules](rules.html),
[IOCCC guidelines](guidelines.html) and the tools in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry), should be
considered provisional **BETA** versions and **may be adjusted _AT
ANY TIME_**.</p>

<p class="leftbar">
The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>

<p class="leftbar">
The [IOCCC rules](rules.html) and these [IOCCC
guidelines](guidelines.html) will be available on the [Official IOCCC
website](https://www.ioccc.org) on or slightly before start of this IOCCC.  Please check our
FAQ on "[how to submit](../faq.html#submit)"
to see how to submit entries, on or after the start of this IOCCC, to be sure
you are using the correct versions of these items before using the
IOCCC submission URL.
</p>

<p class="leftbar">
The [Rule 2a](rules.html#rule2a) size has **increased from 4096 to 4993** bytes.
</p>

<p class="leftbar">
The [Rule 2b](rules.html#rule2b) size has **increased from 2053 to 2503**
bytes.
</p>

<p class="leftbar">The new default way to compile submissions: `-std=gnu17 -O3 -g3
-Wall -Wextra -pedantic`.
You **are encouraged** to use the example Makefile here, rather than the
`mkiocccentry` repo. For details and help, see below in the [Makefile
section](#makefile).
</p>

<p class="leftbar">
Submissions are in the form of a single xz compressed tarball.
</p>

<p class="leftbar">
To assist in the formation of the xz compressed tarball for submission, use the
`mkiocccentry(1)` tool as found in the  [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry).
</p>

<p class="leftbar">
[Rule 17](rules.html#rule17) has been **significantly modified**
to account for the new [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) tools.
</p>

<p class="leftbar">
The IOCCC submission URL, [when the IOCCC is open](../status.html#open), is
[submit.ioccc.org](https://submit.ioccc.org/).
</p>

Jump to: [top](#)

<div id="hints">
<div id="suggestions">
# HINTS AND SUGGESTIONS:
</div>
</div>

You are encouraged to examine the [winners of previous contests](../years.html).

Keep in mind that [rules](rules.html) change from year to year, so some [winning
entries](../years.html) might not be valid submissions this year; what _was_ unique
and novel one year _might be 'old' the next year_.

A submission is usually examined in a number of ways.  We typically apply
a number of tests to a submission:

* look at the original source
* convert ANSI trigraphs to ASCII
* C pre-process the source ignoring `#include` lines
* C pre-process the source ignoring `#define` _and_ `#include` lines
* run it through a C beautifier
* examine the algorithm
* compile it (with flags to enable all warnings)
* execute it

You should consider how your submission looks in each of the above tests.
You should ask yourself if your submission remains obscure after it has been
'_cleaned up_' by the C pre-processor and a C beautifier.

Your submission need not pass all of the above tests.  In certain
cases, a test is not important.  Entries that compete for the
'**strangest/most creative source layout**' need not do as well as
others in terms of their algorithm.  On the other hand, given
two such entries, we are more inclined to pick the submission that
does something interesting when you run it.

We try to avoid limiting creativity in our [rules](rules.html).  As such, we
leave the contest open for creative rule interpretation.  As in [real
life](https://en.wikipedia.org/wiki/Real_life) programming, interpreting a
requirements document or a customer request is important.  For this reason, we
often award '**Best abuse of the [rules](rules.html)**' or '**Worst abuse of the
[rules](rules.html)**' or some variation to a submission that illustrates this
point in an ironic way.

We do realize that there are holes in the [rules](rules.html), and invite
entries to attempt to exploit them.  We will award '**Worst abuse of the
[rules](rules.html)**' or '**Best abuse of the [rules](rules.html)**' or some
variation and then plug the hole next year.

<p class="leftbar">
When we do need to plug a hole in the [IOCCC rules](rules.html) or [IOCCC
guidelines](guidelines.html), we will attempt to use a very small plug, if not
smaller.  Or, maybe not.  :-)
</p>

<p class="leftbar">
There may be less than 2^7+1 reasons why these [IOCCC
guidelines](guidelines.html) seem obfuscated.
</p>

Check out your program and be sure that it works.  We sometimes make
the effort to debug a submission that has a slight problem, particularly
in or near the final round.  On the other hand, we have seen some
of the best entries fall down because they didn't work.

<p class="leftbar">
We tend to look down on a [prime
number](https://en.wikipedia.org/wiki/Prime_number) printer that claims that
16 is a prime number.  If you do have a bug, you are better off
documenting it.  Noting "_this submission sometimes prints the 4th power
of a prime by mistake_" would save the above submission.  And sometimes,
a strange bug/feature can even help the submission!  Of course, a correctly
working submission is best.  Clever people will note that 16 might be prime
under certain conditions.  Wise people, when submitting something clever
will fully explain such cleverness in their submission's `remarks.md` file.</p>

People who are considering to just use some complex mathematical
function or state machine to spell out something such as "_hello,
world!_" **really really, _and we do mean REALLY_, do need to be more creative**.

Ultra-obfuscated programs are, in some cases, easier to
deobfuscate than subtly-obfuscated programs.  Consider using
misleading or subtle tricks layered on top of or under an
appropriate level of obfuscation.  A clean looking program with
misleading comments and variable names might be a good start.

When programs use VTxxx/ANSI sequences, they should NOT be limited to a
specific terminal brand.  Those programs that work in a standard xterm
are considered more portable.

<p class="leftbar">
[Rule 2](rules.html#rule2) (the size rule) refers to the use of the IOCCC size
tool called `iocccsize(1)`.
</p>

<p class="leftbar">See the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) for the `iocccsize(1)` tool.
</p>

<p class="leftbar">
To further clarify [Rule 2](rules.html#rule2), we subdivided it into two parts,
**2a** and **2b**.
</p>

<p class="leftbar">
The overall size limit (see [Rule 2a](rules.html#rule2a)) on `prog.c` is now **4993 bytes**.
</p>

<p class="leftbar">
Your submission must satisfy BOTH the maximum size [Rule
2a](rules.html#rule2a) **AND** the IOCCC size tool [Rule 2b](rules.html#rule2b).
</p>

<p class="leftbar">
This IOCCC size tool imposes a 2nd limit on C code size (see [Rule
2a](rules.html#rule2a)).  To check your code against [Rule 2](rules.html#rule2):
</p>

``` <!---sh-->
    iocccsize prog.c
```

The IOCCC size tool algorithm may be summarized as follows:

> The size tool counts most C reserved words (keyword, secondary, and selected
preprocessor keywords) as 1.  The size tool counts all other octets as 1
excluding ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' followed by
ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' octet immediately
before the end of file.

ASCII whitespace includes ASCII tab, ASCII space, ASCII newline,
ASCII formfeed, and ASCII carriage return.

<p class="leftbar">
When '`;`', '`{`' or '`}`' are within a C string, they may still not be
counted by the IOCCC size tool.  This is a _feature_, not a bug!</p>

In cases where the above summary and the algorithm implemented by
the IOCCC size tool source code conflict, the algorithm implemented
by the IOCCC size tool source code is preferred by the [judges](../judges.html).

<p class="leftbar">
There are at least 2 other reasons for selecting 2503 as the 2nd limit besides
the fact that 2503 is a prime. These reasons may be searched for and discovered
if you are ["Curios!" about 2503](https://t5k.org/curios/page.php/2503.html).
:-) Moreover, 2053 was the number of the kernel disk pack of one of the judge's
BESM-6, and 2503 is a decimal anagram of 2053.
</p>

Take note that this secondary limit imposed by the IOCCC size tool
obviates some of the need to `#define` C reserved words in an effort
to get around the size limits of [Rule 2](rules.html#rule2).

Yes Virginia, **that is a hint**!

<p class="leftbar">
The [Rule 2a](rules.html#rule2a) size was changed from
4096 to 4993: a change that keeps the "2b to 2a" size ratio to a
value similar to the [2001-2012](../faq.html#size_rule2001-2012) and
[2013-2020](../faq.html#size_rule2013-2020) IOCCC eras.
</p>


Jump to: [top](#)

<div id="mkiocccentry">
## `mkiocccentry`
</div>

<p class="leftbar">
[Rule 17](rules.html#rule17) (the `mkiocccentry(1)` rule) states that
you **MUST** use the `mkiocccentry(1)` tool to package your submission tarball.
</p>

<p class="leftbar">
See the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
for the `mkiocccentry(1)` tool and below for more details.
</p>

<p class="leftbar">
**IMPORTANT NOTE**: make **CERTAIN** you have the most recent version of the
`mkiocccentry` toolkit! See the
FAQ on "[obtaining the mkiocccentry toolkit](../faq.html#obtaining_mkiocccentry)".

<p class="leftbar">
`mkiocccentry` runs a number of checks, by the tool itself and by executing
other tools, _before_ packaging your xz compressed tarball. Once the tarball is
packaged it will run `txzchk(1)`, which will also run `fnamchk(1)`, as part of
its algorithm.
</p>

<p class="leftbar">
If `mkiocccentry` encounters an **error** the program will exit and the xz
compressed tarball **will not be formed**. For instance, if `chkentry(1)` (see
below) fails to validate the `.auth.json` or `.info.json`
[JSON](https://www.json.org/json-en.html) files that `mkiocccentry(1)` creates,
it is an error and **possibly** a bug that you should [report as a bug at the
mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
**PLEASE run the `bug_report.sh` script to help us out here!**  See the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".
</p>

<p class="leftbar">
If you want to know what `.auth.json` is, see the FAQ on
"[.auth.json](../faq.html#auth_json)".  If you want to know what the
`.info.json` file is, see the FAQ on "[.info.json](../faq.html#info_json)".  On
the other hand, if you want to know a bit more details about `chkentry`, see the
FAQ about "[chkentry](../faq.html#chkentry)".
</p>

<p class="leftbar">
However, just because there are errors **does not** mean it is a bug in the
code. It might be an issue with your submission. Thus if you report an error as
a bug it might not be something that will be fixed as there might not be
anything wrong.
</p>

<p class="leftbar">
On the other hand, some conditions are **warnings** and it allows you to
override these, if you wish. If you're brave enough you can use the `-W` option
to ignore all warnings but this is a big risk; the `-y` option will assume
'_yes_' to most questions but this is also a big risk. Needless to say, we do
NOT recommend these options.
</p>

<p class="leftbar">
In many places it will prompt you to verify what you input, allowing you to
correct details as you go along.
</p>

Jump to: [top](#)

<div id="mkiocccentry-synopsis">
## `mkiocccentry(1)` synopsis
</div>

<p class="leftbar">
The synopsis of the `mkiocccentry(1)` tool is:
</p>

``` <!---sh-->
    mkiocccentry [options] work_dir prog.c \
         Makefile remarks.md [file ...]
```

<p class="leftbar">
To help you with editing a submission, the `mkiocccentry(1)` tool has
some options to write _OR_ read from an answers file so you do not have to input
the information about the author(s) and the submission more than once (unless of
course you need to make some changes, in which case you can use the option that
overwrites the file).
</p>

<p class="leftbar">
See the
FAQ on "[mkiocccentry](../faq.html#mkiocccentry)"
for how to use this tool in more detail.
</p>

<p class="leftbar">
Below are the tools that `mkiocccentry(1)` will run.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will execute a number of tools, some of which will
execute one or more additional tools; `chkentry(1)` will use the JSON parser
library `jparse(3)`; see the [jparse
README.md](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/README.md)
in the [mkiocccentry GitHub repo subdirectory
jparse](https://github.com/ioccc-src/mkiocccentry/tree/master/jparse) as well as
the [jparse library README.md
file](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jparse_library_README.md)
in the [mkiocccentry GitHub repo subdirectory
jparse](https://github.com/ioccc-src/mkiocccentry/tree/master/jparse), for more
details.
</p>

<p class="leftbar">
The original `jparse` code, co-developed by
[Landon Curt Noll](http://www.isthe.com/chongo/index.html) and
[Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson) in
2022, comes from the [jparse repo](https://github.com/xexyl/jparse) **but the
mkiocccentry tools use a _clone_** of this repo **at a _specific_ release**.
Thus the `mkiocccentry` will at times be behind the `jparse` repo!
</p>

<p class="leftbar">
You do **NOT need to install** `jparse` from the [jparse
repo](https://github.com/xexyl/jparse)! The `mkiocccentry` tools link in the
static library from the `mkiocccentry` clone. This also goes for the
[dbg](https://github.com/lcn2/dbg) and
[dyn_array](https://github.com/lcn2/dyn_array) libraries that the tools use.
</p>

<p class="leftbar">
In other words, `mkiocccentry` **contains everything** you need, and _even if you
do install_ the libraries from their respective repos, it/they will **not be
used** when compiling the `mkiocccentry` tools.
</p>


Jump to: [top](#)

<div id="iocccsize">
## `iocccsize`
</div>

<p class="leftbar">`mkiocccentry(1)` will use code from `iocccsize(1)` which
detects a number of issues that you may ignore, if you wish, as described above.
As we already discussed how to invoke `mkiocccentry`, we will not include it
here again.
</p>

<p class="leftbar">
In other words, you no longer need to run `iocccsize` manually.
</p>

<p class="leftbar">
The `iocccsize` tool was originally part of a winning entry by [Anthony C
Howe](../authors.html#Anthony_C_Howe), but with some modifications over time, as
things have changed.
</p>

Jump to: [top](#)

<div id="chkentry">
## `chkentry`
</div>

<p class="leftbar">`mkiocccentry(1)` will write two JSON files: `.auth.json` and
`.info.json`. These files contain information about the author(s) and about the
submission. These files **MUST** pass the checks of `chkentry(1)`!
</p>

<p class="leftbar">
If `chkentry` does not pass and you used `mkiocccentry(1)` it is **very likely** a
bug and you should [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
See the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".
</p>

<p class="leftbar">
Assuming that `chkentry(1)` successfully validates both `.auth.json` and
`.info.json` then the tarball will be formed and then `txzchk(1)` will be
executed. In this case, there should be no problems, as `mkiocccentry(1)` should
**NOT** form a tarball if there are any issues.
</p>

<p class="leftbar">
If `mkiocccentry(1)` is used and `chkentry(1)` fails to validate either of the
files, then unless it is a system specific problem, it is likely a bug in
`mkiocccentry(1)`, `chkentry(1)` or possibly `jparse`, though these are quite
unlikely.
</p>

<p class="leftbar">
Please see the
FAQ on "[validating .auth.json and/or .info.json files](../faq.html#chkentry)
for more details on this tool and how you can use it to validate your
`.auth.json` and `.info.json` files manually, without having to repackage your
submission.
</p>

<p class="leftbar">
You might also wish to see the
FAQ on "[.auth.json](../faq.html#auth_json)"
and the
FAQ on "[.info.json](../faq.html#info_json)"
for much more information on these files.
</p>


Jump to: [top](#)

<div id="txzchk">
## `txzchk`
</div>

<p class="leftbar">
`txzchk(1)` performs a wide number of sanity checks on the xz
compressed tarball; if any issues are found ('`feathers are stuck in the
tarball`' :-) ) **AND if and _ONLY IF_ you used
`mkiocccentry(1)`**, then it is **possibly** a bug in one of the tools and you
might want to [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E). **PLEASE run the
`bug_report.sh` script to help us out here!** See the
FAQ on "[report mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".
</p>

<p class="leftbar">
As part of its sanity checks, `txzchk(1)` will run `fnamchk(1)` on the
_filename_ to verify that the name is valid. See the
FAQ on "[fnamchk](../faq.html#fnamchk)"
and [fnamchk below](#fnamchk) for more details on this tool.
</p>

<p class="leftbar">
It is beyond the scope of this document to discuss the many tests that
`txzchk(1)` do. In this case we refer you to the [source
code](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c) or the man
page. You might find a fun option if you do either of these!
</p>

<p class="leftbar">
Of course, as `txzchk` does not extract the tarball, it is possible that if you
manually package your submission tarball, you could still be violating [Rule
17](rules.html#rule17).
</p>

<p class="leftbar">
See also the
FAQ on "[txzchk](../faq.html#txzchk)".
</p>

Jump to: [top](#)

<div id="fnamchk">
## `fnamchk`
</div>

<p class="leftbar">
A tool that [txzchk](#txzchk) runs is `fnamchk`. This is an important part of
its algorithm. If the filename is incorrect (or the filename does not match the
directory name of the tarball) then it is an **error** and you risk violating
[Rule 17](rules.html#rule17). Nevertheless, you can run the tool manually should
you wish to.
</p>

<p class="leftbar">
For more information on `fnamchk` and how to manually validate your submission
tarball filename, see the
FAQ on "[fnamchk](../faq.html#fnamchk)".
</p>

<p class="leftbar">
Note that the `txzchk(1)` tool uses `fnamchk(1)` tool as part of its algorithm.
Thus `mkiocccentry(1)` does not directly invoke `fnamchk(1)`, although we will
in the judging process.
</p>

<hr>

<p class="leftbar">
At the risk of stating the obvious: you run **a VERY BIG risk** of having
your submission rejected if you package your own tarball and there are **ANY
problems**. For instance, if `chkentry(1)` found a problem in your `.info.json`
file, the `mkiocccentry(1)` tool would not package it. But if you were to package
it manually, you would be violating [Rule 17](rules.html#rule17). But even if
everything checks out OK you should **NOT** assume that everything **IS** OK.
</p>

<p class="leftbar">
It is extremely unlikely that `fnamchk(1)` reporting an invalid filename is a
bug in `fnamchk(1)` and as such, ignoring such an issue risks violating [Rule
17](rules.html#rule17) which is a big risk. Of course, using `mkiocccentry(1)`
would prevent this from happening as it would not create such a file anyway. If
`mkiocccentry(1)` was used it would rather suggest a bug in one of the tools and
you should [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
See the
FAQ on "[report mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".
</p>

<p class="leftbar">
As you can see, the use of `mkiocccentry(1)` is **HIGHLY RECOMMENDED**.
</p>


<div id="bugs">
# Problems and/or bugs in tools
</div>

<p class="leftbar">
Although the tools have been tested quite a bit, and although it is quite
unlikely that there are bugs in it, it is nonetheless possible for bugs to
exist, as all programmers know. In this case, **please** ask for help or report what
you think is a bug as a bug, via the [bug report issues page in the mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
</p>

<p class="leftbar">
Of course, it is also possible for `mkiocccentry(1)`, or one or more of the
tools it executes (or another tool executes), to fail, and **NOT** because of a
bug. An example problem is if there is not enough memory available or if some
other library or syscall fails. Nonetheless it might be worth reporting as a
bug; it is a judgement call; if it's a bug it'll be addressed and if it's not
that's OK too!
</p>


<div id="make">
<div id="makefile">
# Makefiles
</div>
</div>

<p class="leftbar">
We **recommend** AND **encourage** you to use the example Makefile **here**,
rather than the `mkiocccentry` repo's `Makefile.example`, renamed as `Makefile`
of course, as the starting point for your submission's required `Makefile`:
</p>

- <p class="leftbar">[view example
Makefile](%%REPO_URL%%/next/Makefile.example)</p>
- <p class="leftbar"><a href="Makefile.example"
download="Makefile">download example Makefile</a></p>

<p class="leftbar">
Feel free to modify the `Makefile` to suit your obfuscated
needs.
</p>

<p class="leftbar">
The rest of this section and its subsections will assume that you are using some
variant of the example `Makefile`, again renamed as `Makefile`.
</p>

<p class="leftbar">
We suggest that you compile your submission with a commonly available
`-std=gnu17` (ISO C 2017 with GNU extensions) C compiler.
</p>

<div id="flags">
## Default compiler flags
</div>

<p class="leftbar">
Unless you **clearly state** otherwise in your `remarks.md` file **AND** put in your
submission's `Makefile`, we **will** compile using `-std=gnu17 -O3 -g3`!
</p>

<p class="leftbar">
It **is OK** if you need to require your submission to **not be** compiled
using the default `-std=gnu17 -O3 -g3` settings.  Simply **explain why**
your submission should not be compiled using `-std=gnu17 -O3 -g3` in
your `remarks.md` file **and** adjust your `Makefile` accordingly.
</p>

<p class="leftbar">
An example reason is that the optimiser is known to break some programs, but
there are certainly other possible valid reasons. Again, just update the
`Makefile` and explain it in your `remarks.md`.
</p>

<div id="compilers">
## Default compiler
</div>

<p class="leftbar">
**IMPORTANT NOTE**: The use of `-std=gnu17` does **NOT** imply the use of the `gcc`
compiler!  We often start by compiling using the **clang** C compiler instead.
</p>

<p class="leftbar">
**PLEASE NOTE**: in macOS, the compiler `gcc` found at `/usr/bin/gcc` is
in truth the `clang` compiler, as `/usr/bin/gcc --version` will show!
</p>


<div id="cstd">
<div id="standard">
## C standard
</div>
</div>

<p class="leftbar">
You may change the standard under which your submission is compiled
by modifying the `CSTD` Makefile variable.  For example, to use `c17` instead:
</p>


``` <!---make-->
    CSTD= -std=c17
```

<div id="opt">
## Default optimisation level
</div>

<p class="leftbar">
You may change the level of optimization and compiler debug level
that your submission is compiled with, by modifying the `OPT` Makefile variable.
For example, to compile without optimization and with debug symbols:
</p>

``` <!---make-->
    OPT= -O0 -g3
```

<div id="warnings">
## Compiler warnings
</div>

<p class="leftbar">
For compilers, such as `clang`, that have the `-Weverything` option,
while you may wish to try it, you should read our
FAQ on "[clang -Weverything](../faq.html#weverything)".
We do **NOT** recommend that you put
the use of `-Weverything` into your submission's `Makefile` for the reasons
cited there. This goes even if your version does not trigger a warning as some
other version might!
</p>

<p class="leftbar">
On the other hand, if `${CC}` has "`clang`" in the name, the example `Makefile` will
automatically enable `-Weverything`, so you might have to use `-Wno-foo`
options, as detailed below.
</p>

<div id="disabling-warnings">
## Disabling warnings
</div>

<p class="leftbar">
There is no real penalty for compiler warnings.  Sometimes
compiler warnings cannot be helped: especially in the case of
obfuscated C.  :-)  So if you cannot easily get rid of a compiler
warning, try not fret too much.
</p>

<p class="leftbar">
We **LIKE** code that has a minimum of warnings, especially under the
more strict ` -Wall -Wextra -pedantic` mode:
</p>

``` <!---make-->
    CWARN= -Wall -Wextra -pedantic
```

<p class="leftbar">
The two previous guidelines might be thought by some as being somewhat
contradictory.  Isn't life, and isn't trying to satisfy "contradictory customer
requirements" all too often like that?  :-)  Try to minimize warnings if you
can.
</p>

<p class="leftbar">
If you manage to produce very few warnings, or perhaps no warnings at
all under the `-Wall -Wextra -pedantic` mode, then by all means brag about it in
your `remarks.md` file **AND BE SURE TO TELL US** the OS, OS version, compiler
and compiler version in which you observed this occurring (in case our OS and
compiler produces a different result: so your submission won't be penalized for
not meeting your claims).
</p>

<p class="leftbar">
On the other hand, some warnings cannot be disabled and are enabled by compilers
without any warning option specified. These are sometimes inevitable in
obfuscated code and even in some non-obfuscated code, and you should not worry
about this, though it might be worth pointing out (see below for an example).
</p>

<p class="leftbar">
Some compilers like to warn about certain use of `char *`s which
might not only be dubious itself, but it obviously can't (always) be avoided, so you
should not worry about this either; this is the warning
`-Wunsafe-buffer-usage` and the way to disable it is `-Wno-unsafe-buffer-usage`. See also the
FAQ on "[forced warnings](../faq.html#forced_warnings)"
and the
FAQ on "[-Weverything](../faq.html#weverything)".
</p>


<p class="leftbar">
If you do have to disable warnings due to `-Weverything` automatically being
included, you might wish to state this fact. :-)
And even without `-Weverything` there can be warnings, as noted above.
</p>

<p class="leftbar">
If your submission issues lots of warnings but is otherwise
marvelously obfuscated in multiple levels, don't worry about it.  Nevertheless,
be sure that the warnings do not constitute a potential "**show stopper**"
compiler problem.  Be sure that compilers such as both `gcc` and `clang` won't
produce a compiler **error** and refuse to compile your code: unless for some
reason that is what you intend to happen in which case document that too in your
`remarks.md` file.  :-)
</p>

All other things being equal, a program that must turn off fewer
warnings will be considered better, for certain values of better.

<p class="leftbar">
To turn off a compiler warning, in your submission's `Makefile`,
try something such as:
</p>

``` <!---make-->
    CSILENCE= -Wno-some-thing -Wno-another-thing
```

For instance:


``` <!---make-->
    CSILENCE= -Wno-parentheses -Wno-binding-in-condition -Wno-misleading-indentation
```


<p class="leftbar">
If you do add "`-Wno-foo`" to your Makefile, consider changing:

``` <!---make-->
    CUNKNOWN=
```

to:

``` <!---make-->
    CUNKNOWN= -Wno-unknown-warning-option
```

<p class="leftbar">
Some compilers have reported this as an error, however, and if you have
such a compiler you might want to not add it, or at least note in your
`remarks.md` the OS, OS version and compiler that this shows up.
</p>

<div id="macros">
## Defining macros in the Makefile
</div>

<p class="leftbar">
If you need to define something on the compile line, use
the `CDEFINE` Makefile variable.  For example:
</p>

``` <!---make-->
    CDEFINE= -Dfoo -Dbar=baz
```

<div id="include">
## Include files in the Makefile
</div>

<p class="leftbar">
If you need to include a file (as in `#include`) on the command line, use the
`CINCLUDE` Makefile variable.  For example:
</p>

``` <!---make-->
    CINCLUDE= -include stdio.h
```


<div id="magic">
## Magic in the Makefile
</div>

<p class="leftbar">
If you need to add other "**magic**" flags to your compile line,
use the `COTHER` Makefile variable.  For example:
</p>

``` <!---make-->
    COTHER= -fno-math-errno
```

<p class="leftbar">
**NOTE**: **We only recommend using "_magic_" flags if _BOTH_ `gcc`
_and_ `clang`** support it.
</p>

<p class="leftbar">
Again, please note that in macOS, `/usr/bin/gcc` is actually `clang`!
</p>

Jump to: [top](#)

<div id="likes">
<div id="dislikes">
# OUR LIKES AND DISLIKES:
</div>
</div>

<p class="leftbar">
We **LIKE** submissions that use an edited variant of the
example Makefile, as described in the [Makefile section](#makefile),
renamed as `Makefile` of course.  This makes it easier for the [IOCCC Judges](../judges.html)
to test your submission. And if your submissions wins, it makes it easier to integrate it into
the [Official IOCCC winner website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
We **LIKE** submissions that use an edited version of the
`try.sh` example script (and if you have alternate code,
the same applies with the `try.alt.sh` script):
</p>

- <p class="leftbar">[view example try.sh](%%REPO_URL%%/next/try.sh)</p>
- <p class="leftbar"><a href="try.sh">download example try.sh</a></p>
- <p class="leftbar">[view example try.alt.sh](%%REPO_URL%%/next/try.alt.sh)</p>
- <p class="leftbar"><a href="try.alt.sh">download example try.alt.sh</a></p>

<p class="leftbar">
Of course, it is quite possible that only one invocation is
possible, so it is not necessarily detrimental to your submission if you do not
include one, though we do like interesting and creative uses of submissions. See
also the
FAQ on "[submitting try.sh and try.alt.sh scripts](../faq.html#try_scripts)".
</p>

<p class="leftbar">
You might wish to add `./try.sh` to the `try` rule in the Makefile you submit.
If you have alternate code, then you could add a `try.alt` rule or something
like that.
</p>

Doing masses of `#define`s to obscure the source has become 'old'.  We
tend to 'see thru' masses of `#define`s due to our pre-processor tests
that we apply.  Simply abusing `#define`s or `-Dfoo=bar` won't go as far
as a program that is more well rounded in confusion.

**Many** C compilers **DISLIKE** the following code, and so do we:

``` <!---c-->
    #define d define
    #d foo             /* <-- don't expect this to turn into #define foo */
```

<p class="leftbar">
In other words, it is a compilation error.
</p>

When declaring local or global variables, you should declare the type:

``` <!---c-->
    int this_is_fine;
    this_is_not;       /* <-- Try to avoid implicit type declarations */
```

<p class="leftbar">
We tend to **like _less_** a submission that requires either
`gcc` **OR** `clang`.  **We _prefer_ submissions** that can compile
under **BOTH** `gcc` **AND** `clang`.
</p>

<p class="leftbar">
We **RECOMMEND** that the compiler flags you use in your
submission's `Makefile` are supported by **BOTH** `gcc` **AND** `clang`.
</p>

<p class="leftbar">
We **DISLIKE** the use of obscure compiler flags, especially
if `gcc` and/or `clang` do not support it.  We **suggest**
that you not use any really obscure compiler flags if you can help it.
</p>

One side effect of the above is that you cannot assume the use
of nested functions such as:

``` <!---c-->
     main() {
|        void please_dont_submit_this() {
|           printf("The machine that goes BING!!\n");
         }
|        please_dont_submit_this();
     }
```

On 2012 July 20, the [judges](../judges.html) rescinded the encouragement of
nested functions.  Such constructions, while interesting and sometimes
amusing, will have to wait until they required by a C standard that are
actually implemented in **BOTH** `gcc` **AND** `clang`.

<p class="leftbar">
We **DISLIKE** submissions that require the use of `-fnested-functions`.
</p>

We prefer programs that do not require a fish license: crayons and
cat detector vans not withstanding.

If your submission uses functions that have a variable number of
arguments, **be careful**. Systems implement `va_list` in a wide variety
of ways.  Because of this, a number of operations using `va_list` **are
not portable and _must not_ be used**:

* assigning a non-`va_list` variable to/from a `va_list` variable
* casting a non-`va_list` variable into/from a `va_list` variable
* passing a `va_list` variable to a function expecting a non-`va_list` arg
* passing a non-`va_list` variable to a function expecting a `va_list` arg
* performing arithmetic on `va_list` variables
* using `va_list` as a structure or union

In particular, do not treat `va_list` variables as if they were a `char **`s.

<p class="leftbar">
We **DISLIKE** the use of `varargs.h`.  Use `stdarg.h` instead.
</p>

<p class="leftbar">
We **DISLIKE** the use of `gets(3)`.  Use `fgets(3)` instead.
</p>

On 28 January 2007, the Judges rescinded the requirement that the
`#` in a C preprocessor directive must be the 1st non-whitespace octet.

The `exit(3)` function returns `void`.  Some broken systems have `exit(3)`
return `int`; your submission should assume that `exit(3)` returns a `void`.

<p class="leftbar">
This _guideline_ has a change mark at the very start of this line.
</p>

Small programs are best when they are short, obscure and concise.
While such programs are not as complex as other winners, they do
serve a useful purpose: they are often the only program that people
attempt to completely understand.  For this reason, we look for
programs that are compact, and are instructional.

<p class="leftbar">
While those who are used to temperatures found on [dwarf
planets](https://science.nasa.gov/dwarf-planets/)
(**yes Virginia, dwarf planets _ARE_ planets!**), such as
[Pluto](https://science.nasa.gov/dwarf-planets/pluto/), might be able to
explain to the Walrus why our seas are boiling hot, the question of
whether pigs have wings is likely to remain a debatable point to most.
</p>

One line programs should be short one line programs: say around 80 to 120
octets long.  Going well beyond 140 octets is a bit too long to be called
a one-liner in our vague opinion.

We tend to **DISLIKE** programs that:

* are very hardware specific
* are very OS version specific (`index(3)`/`strchr(3)` differences are OK, but
sockets/streams specific code is likely not to be)
* dump core or have compiler warnings (it is OK only if
you warn us in your `remarks.md` file)
* <p class="leftbar">won't compile or run in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environment</p>
* <p class="leftbar">depend on a utility or application not normally found
in systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)</p>
* abuse the build file to get around the size limit<br>
* <p class="leftbar">obfuscate by use of ANSI trigraphs</p>
* <p class="leftbar">obfuscate by use of digraphs</p>
* <p class="leftbar">are larger than they need to be</p>
* <p class="leftbar">have more lines than they need to have</p>
* <p class="leftbar">are "blob-ier" (just a pile of unformatted C code)
than they need to be</p>
* <p class="leftbar">are rather similar to **[previous
winners](../years.html)** :-(</p>
* <p class="leftbar">are **identical** to **[previous
losers](https://en.wikipedia.org/wiki/Null_device)** :-)</p>
* that mandate the exclusive use of a specific Integrated Development Environment (IDE)

In order to encourage submission portability, we **DISLIKE** entries that
fail to build unless one is using an IDE. For example, do not
mandate that one must use Microsoft Visual Studio to compile
your submission.  Nevertheless some of the better IDEs have command-line
interfaces to their compilers, once one learns how to invoke a shell.

<p class="leftbar">
The program must compile and link cleanly in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environment. Therefore do not assume the system has a
[windows.h](https://en.wikipedia.org/wiki/Windows.h) include file:
</p>


``` <!---c-->
    #include <windows.h>  /* we DISLIKE this */
```

Unless you are cramped for space, or unless you are entering the
'**Best one liner**' category, we suggest that you format your program
in a more creative way than simply forming excessively long lines.

At least one judge prefers to maintain the use of the
[leap-second](https://en.wikipedia.org/wiki/Leap_second)
as part of the world's time standard.  If your code prints time
with seconds, we prefer that your code be capable of printing the
time of day during a leap-second where the value in seconds
after the minute mark is 60.

The "**how to build**" process (via the `Makefile` or otherwise) should not be
used to try and get around the size limit.  It is one thing to make use of a
several `-D`s on the compile line to help out, but it is quite another to use
many bytes of `-D`s in order to try and squeeze the source under the size limit.

Your source code, post-pre-processing, should not exceed the size of
[Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows). :-)

<p class="leftbar">
Other windows, on the other hand, might be OK: especially where "**X
marks the spot**".  Yet on the third hand, windows are best when they are
"unseen" (i.e., not dirty).  :-)
</p>

The [judges](../judges.html), as a group, have a history giving wide degree of latitude
to reasonable entries.  And recently they have had as much longitudinal
variation as it is possible to have on [Earth](https://science.nasa.gov/earth/).  :-)

<p class="leftbar">
You should try to restrict commands used in the build file to
commands found in [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) environments
and systems that conform to the [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).
</p>

<p class="leftbar">
You may compile and use your own programs.  If you do, try to build and execute
from the current directory.  This restriction is not a hard and
absolute one.  The intent is to ensure that the building if your
program is reasonably portable.
</p>

We prefer programs that are portable across a wide variety of Unix-like
operating systems (e.g., Linux, GNU Hurd, BSD, Unix, etc.).

> You are in a maze of twisty _guidelines_, all different.

There are at least zero [judges](../judges.html) who think that
[Fideism](https://en.wikipedia.org/wiki/Fideism) has little
or nothing to do with the IOCCC judging process.

Don't forget that the building of your program should be done
**WITHOUT human intervention**.  So don't do things such as:

```
    prog: prog.c
        #echo this next line requires data from standard input
        cat > prog.c
        ${CC} prog.c -o prog
```

However, you can do something cute such as making your program
do something dumb (or cute) when it is built 'automatically', and
when it is run with a human involved, do something more clever.
For example, one could put in their `Makefile`:

```
    prog: prog.c
        ${CC} prog.c -DNON_HUMAN_COMPILE -o prog
        @echo "See remarks section about alternate ways to compile"
```

and then include special notes in their `remarks.md` file for
alternate / human intervention based building.

We want to get away from source that is simply a compact blob of
octets.   Really try to be more creative than blob coding. **HINT!**

Please do not use things like `gzip(1)` to get around the size limit.
Please try to be much more creative.

We really **DISLIKE** entries that make blatant use of including
large data files to get around the source code size limit.

We do not recommend submitting [systemd](https://systemd.io) source code to the IOCCC,
if nothing else because that code is likely to exceed [the source code
size limit](rules.html#rule2).  This isn't to say that another highly compact and obfuscated
replacement of `init` would not be an interesting submission.

Did we remember to indicate that programs that blatantly use
some complex state machine to do something simple are boring?
We think we did.  :-)

> All generalizations are false, including this one. -- **Mark Twain**

Given two versions of the same program, one that is a compact blob
of code, and the other that is formatted more like a typical C
program, we tend to favor the second version.  Of course, a third
version of the same program that is formatted in an interesting
and/or obfuscated way, would definitely win over the first two!
Remember, you can submit more than one submission.  See the [IOCCC
rules](rules.html) for details (in particular, [Rule 9](rules.html#rule9)).

We suggest that you avoid trying for the '**smallest self-replicating**'
source.  The smallest, a [zero byte entry](../1994/smr/index.html), won in
[1994](../years.html#1994).

Programs that claim to be the smallest C source that does something, really
better be the smallest such program or they risk being rejected because
they do not work as documented.

Please note that the C source below, besides lacking in obfuscation,
is NOT the smallest C source file that when compiled and run, dumps core:

``` <!---c-->
    main;
```

<p class="leftbar">
Unless you specify `-fwritable-strings` (see `COTHER` in the example
Makefile, described in the [Makefile section](#makefile)), do not assume this
sort of code will work:
</p>

``` <!---c-->
    char *T = "So many primes, so little time!";
    ...
    T[14] = ';';    /* modifying a string requires: -fwritable-strings */
```

<p class="leftbar">
Even so, one should probably not assume that this is universally accepted.
</p>

<p class="leftbar">
Initialized char arrays are OK to write over.  For instance, this is OK:
</p>

``` <!---c-->
    char b[] = "Is this OK";
    b[9] = 'k';     /* modifying an initialized char array is OK */
```

<p class="leftbar">
There are more than 1 typos in this very sentence.
</p>

X client entries should be as portable as possible.  Submissions that
adapt to a wide collection of environments will be favored.  For
example, don't depend on a particular type or size of display.
Don't assume the use of a particular browser.  Instead assume a
generic browser that forms to a widely used [W3C
standard](https://www.w3.org/standards/).
Don't assume a particular sound sub-system or video driver is installed
in the OS. Instead, make use of a well known and widely available open
source program (one that actually works) to display audio/visual data.

X client entries should avoid using X related libraries and
software that are not in wide spread use.

This is the only _guideline_ that contains the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin).

<p class="leftbar">
However, do you know how to play [fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin)?
You do?!?  (Except on Tuesday?)
</p>

<p class="leftbar">
OK, there are actually 3 _guidelines_ that contain the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin).
</p>

We **DISLIKE** entries that use proprietary toolkits such as the `M*tif`,
`Xv*ew`, or `OpenL*ok` toolkits, since not everyone has them.  Use an
open source toolkit that is widely and freely available instead.

**NOTE**: The previous _guideline_ in this spot has been replaced by this _guideline_:

<p class="leftbar">
X client entries should try to not to depend on particular items in
`.Xdefaults`.  If you must do so, be sure to note the required lines
in the your `remarks.md` file.  They should also not depend on any
particular window manager.
</p>

<p class="leftbar">
Try to avoid entries that play music that some people believe is copyrighted
music.
</p>

<p class="leftbar">
While we recognize that UNIX is not a universal operating system, the contest
does have a bias towards such systems.  In an effort to expand the scope of the
contest, we phrase our bias to favor the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).
</p>

<p class="leftbar">
You are **well advised** to submit entries that conform to the [Single UNIX
Specification Version 4](https://unix.org/version4/overview.html).
</p>

<p class="leftbar">
To quote the [IOCCC judges](../judges.html):
</p>

> You very well might not be completely be prohibited from failing to not partly
misunderstand this particular _guideline_, but of course, we could not possibly
comment!  :-)  Nevertheless, you are neither prohibited, nor are you fully
required to determine that this or the previous sentence is either false and/or
perhaps misleading.  Therefore, it might be wise for you to not fail to consider
to not do so, accordingly. Thank you very much.

Any complaints about the above _guideline_ could be addressed to the
Speaker of the House of Commons, or to the speaker of your national
parliament should you have one.

We **LIKE** programs that:

* are as concise and small as they need to be
* do something at least quasi-interesting
* are portable
* are unique or novel in their obfuscation style
* make use of a **NUMBER OF DIFFERENT TYPES OF OBFUSCATIONS!**  **<== HINT!!**
* make us laugh and/or throw up  :-)  (humor really helps!)
* make us want to eat good chocolate

Some types of programs can't excel (anti-tm) in some areas.  Your
program doesn't have to excel in all areas, but doing well in several
areas really does help.

<p class="leftbar">
You are better off explaining what your submission does in your
`remarks.md` file section rather than leaving it obscure for the
[judges](../judges.html) as we might miss something and/or be too tired to
notice.
</p>

<p class="leftbar">
Please avoid this specific individual _guideline_, if it at all possible.
</p>

<p class="leftbar">
We freely admit that interesting, creative or humorous comments in
your `remarks.md` file help your chances of winning.  If you had to
read so many twisted submissions, you too would enjoy a good laugh or two.
We think the readers of the contest winners do as well.  We do read
your `remarks.md` content during the judging process, so it is worth your
while to write remarkable `remarks.md` file.
</p>

We **DISLIKE** C code with trailing control-M's (`\r` or `\015`) that results
in compilation failures.  Some non-Unix/non-Linux tools such as
MS Visual C and MS Visual C++ leave trailing control-M's on lines.
Users of such tools should strip off such control-M's before submitting
their entries.  In some cases tools have a "Save As" option that will
prevent such trailing control-M's being added.

One should restrict libcurses to portable features found on BSD
or Linux curses.

[Rule 13](rules.html#rule13)  states any C source that fails to compile because of unescaped
octets with the high bit set (octet value >= 128) **might** be rejected.
Instead of unescaped octets, you should use \octal or \hex escapes:

``` <!---c-->

              /* 123456789 123456789 123456789 123456 */
    char *foo = "This string is 36 octets in length \263";
          /* This octet requires 4 octets of source ^^^^ */
    if (strlen(foo) == 36) printf("foo is 36 octets plus a final NUL\n");
    else printf("This code should not print this message\n");
```

<p class="leftbar">
It is a very good idea to, in your `remarks.md` file, tell us why you
think your submission is obfuscated.  This is particularly true if
your submission has some very subtle obfuscations that we might
otherwise overlook.  **<<-- Hint!**
</p>

Anyone can format their code into a dense blob.  A really clever
author will try format their submission using a "normal" formatting style
such that at first glance (if you squint and don't look at the details)
the code might pass for non-obfuscated C.  Deceptive comments,
and misleading formatting, in some cases, may be a plus.  On the
other hand, a misleading code style requires more source bytes.

If you do elect to use misleading formatting and comments, we
suggest you remark on this point in your `remarks.md` where you talk
about why you think your submission is obfuscated.  On the other hand,
if you are pushing up against the size limits, you may be forced
into creating a dense blob. Such are the trade-offs that obfuscators face!

<p class="leftbar">
We prefer code that can run on either a 64-bit or 32-bit
processor.  However, it is **UNWISE **to assume it will run on an
some Intel-like x86 architecture.
</p>

We believe that Mark Twain's quote:

> Get your facts first, then you can distort them as you please.

... is a good motto for those writing code for the IOCCC.

The IOCCC size tool source is not an original work, unless you are [Anthony C
Howe](../authors.html#Anthony_C_Howe), in which case it is original!  :-)
Submitting source that uses the content of
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c), unless you are
[Anthony C Howe](../authors.html#Anthony_C_Howe), might run the risk of
violating [Rule 7](rules.html#rule7).

<p class="leftbar"> The `txzchk(1)` tool source is not an original work,
unless you are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson), in
which case it is original!  :-) Submitting source that uses the content of
[txzchk.c](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c),
unless you are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson), might
run the risk of violating [Rule 7](rules.html#rule7).</p>

<p class="leftbar">
Neither the [chkentry tool source](https://github.com/ioccc-src/mkiocccentry/blob/master/chkentry.c)
nor the [JSON parser and library](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/README.md)
nor [jstrencode](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jstrencode.c)
nor [jstrdecode](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jstrdecode.c)
nor any of the other [jparse
tools](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse)
are original works (see the [jparse repo](https://github.com/xexyl/jparse/) for
the original), unless you are [Cody
Boone Ferguson](../authors.html#Cody_Boone_Ferguson) or [Landon Curt
Noll](http://www.isthe.com/chongo/index.html), in which case they are original!
:-) Submitting source that uses the code of these tools or library, unless you
are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson) or [Landon Curt
Noll](http://www.isthe.com/chongo/index.html), might run the risk of violating
[Rule 7](rules.html#rule7).</p>

<p class="leftbar">
Unless you are [Landon Curt Noll](http://www.isthe.com/chongo/index.html), the
remaining tools in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
are **NOT** original works. Submitting source that uses the content of those tools,
unless you are [Landon Curt Noll](http://www.isthe.com/chongo/index.html), might
run the risk of violating [Rule 7](rules.html#rule7).
</p>

<p class="leftbar">
[Rule 7](rules.html#rule7) does not prohibit you from writing your own
obfuscated versions of these tools, unless of course you are [Landon Curt
Noll](http://www.isthe.com/chongo/index.html), in which case you _probably_
won't win since [judges](../judges.html) are disqualified! :-) However, **_if_**
you do write your own version, you **_might_** wish to make it do something
**_more_ interesting** than simply implementing the [IOCCC](../index.html)
tools' algorithms; on the other hand, if you do this, you might want to keep in
mind that writing an obfuscated version of a library runs the risk of violating
[Rule 1](rules.html#rule1) as it is likely not a complete program.
</p>

<p class="leftbar">
Even so, we do not recommend you try and submit a JSON parser due to
the fact it will likely exceed [the source code size limit](rules.html#rule2)
and because you likely can't beat [flex](https://github.com/westes/flex) or
[bison](https://www.gnu.org/software/bison/) in obfuscation. This isn't to
say that [the so-called JSON spec](https://github.com/xexyl/jparse/blob/master/json_README.md#so-called-json-spec) is not
obfuscated, but unless you have some really clever way to compact and
obfuscate a JSON parser more than [flex](https://github.com/westes/flex) and
[bison](https://www.gnu.org/software/bison/) you will likely not win, either
because of the [source code size limit](rules.html#rule2) or because it is not
as obfuscated as the lexer/parser part of
[jparse](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse).
</p>

While programs that only run in a specific word size are OK, if you have
to pick, choose a 64-bit word size.

<p class="leftbar">
If [IOCCC judges](../judges.html) are feeling ornery we
might choose to compile your program for running on an Arduino or
a PDP-11.  Heck, should we ever find an emulator of 60-bit CDC Cyber
CPU, we might just try your submission on that emulator as well :-)
</p>

<p class="leftbar">
If your submission **MUST** run only on a 64-bit or 32-bit architecture,
then you **MUST** specify the `-arch` on your command line
(see `ARCH` in the example
Makefile, described in [Makefile section](#makefile)).  Do not assume a
processor word size without specifying `-arch`.  For example:
</p>

``` <!---make-->
    ARCH= -m64
```

<p class="leftbar">
Note, however, that some platforms will not necessarily support some
architectures. For instance, more recent versions of `macOS` do **NOT** support
32-bit!
</p>

Try to be even more creative!

<p class="leftbar">
If there are limitations in your submission, you are highly encouraged
to note such limitations in your `remarks.md` file.  For example if your
submission factors values up to a certain size, you might want to state:
</p>

>   This submission factors values up `2305567963945518424753102147331756070`.
Attempting to factor larger values will produce unpredictable results.

The [judges](../judges.html) might try to factor the value -5, so you want to might state:

>   This submission factors positive values up
`2305567963945518424753102147331756070`. Attempting to factor large values will
produce unpredictable results.

However the [judges](../judges.html) might try to also factor 0, so you want to might state:

>   This submission factors values between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor values outside
that range will produce unpredictable results.

Moreover the might try to also factor 3.5 or 0x7, or Fred, so you want to might state:

>   This submission factors integers between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor anything else
will produce unpredictable results.

You submission might be better off catching the attempt to factor bogus values
and doing something interesting.  So you might want to code accordingly and state:

>   This submission factors integers between 1 and `2305567963945518424753102147331756070`.
>   Attempting to factor anything else will cause the program to insult your pet fish Eric.

The [judges](../judges.html) might not have a pet fish named Eric, so you might want to state:

>   This submission factors integers between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor anything else
will cause the program to insult your pet fish Eric, or in the case that you
lack such a pet, will insult the pet that you do not have.

When all other things are equal, a submission with fewer limitations will be judged
better than a submission with lots of limitations.  So you might want to code accordingly
and state:

>   This submission attempts to a factor value of any size provided that the
program is given enough time and memory.  If the value is not a proper integer,
the program might insult a fish named Eric.

<p class="leftbar">
Do not fear if you're not 100% sure of the significance of
`2305567963945518424753102147331756070` as it is not of prime importance: or is
it?  :-)
</p>

<p class="leftbar">
We **DISLIKE** the use of use ASCII tab characters in markdown files, such as in the required `remarks.md` file.
</p>

<p class="leftbar">
We don't mind the use ASCII tab characters in your C code.  Feel free
to use ASCII tab characters if that suits your obfuscation needs.  If is
perfectly **OK** to use tab characters elsewhere in your submission, just not in
markdown files as this tends complicate and annoy us when it comes time to
rendering your markdown content.
</p>

<p class="leftbar">
If you do use ASCII tab characters in your non-markdown files, be
aware that some people may use tab stop that is different than the common 8
character tab stop.
</p>

<p class="leftbar">
**PLEASE** observe our [IOCCC markdown guidelines](../markdown.html)
when forming your submission's `remarks.md` file.  And if your submission
contains additional markdown files, please follow those same guidelines for
those files. See also [Rule 19](rules.html#rule19) and our
FAQ on "[markdown](../faq.html#markdown)".
</p>

<p class="leftbar">
We **LIKE** reading `remarks.md` files, especially if they contain
useful, informative, and even humorous content about your submission.  Yes, this
is a **hint**.  :-)
</p>

<p class="leftbar">
We **RECOMMEND** you put a reasonable amount effort into the content of the
`remarks.md` file: it is a required for a reason.  :-)
</p>

Jump to: [top](#)

<div id="rules_abuse">
<div id="abusing_rules">
# ABUSING THE RULES:
</div>
</div>

Legal abuse of the [IOCCC rules](rules.html) is somewhat encouraged.  Legal rule abuse
may involve, but is not limited to, doing things that are technically allowed by
the [IOCCC rules](rules.html) and yet do not fit the spirit of what we intended to be
submitted.

Legal rule abuse is encouraged to help promote creativity.  Rule abuse
entries, regardless of if they receive an award, result in changes to
the next year's [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html).

Legal abuse of the [IOCCC rules](rules.html) is **NOT** an invitation to violate the
[IOCCC rules](rules.html). A submission that violates the [rules](rules.html) in the
opinion of the [judges](../judges.html), **WILL** be
disqualified.  **_RULE ABUSE CARRIES A CERTAIN LEVEL OF RISK!_**  If you
have a submission that might otherwise be interesting, you might want to
submit two versions; one that does not abuse the [IOCCC rules](rules.html) and one that
does.

<p class="leftbar">
If you intend to abuse the [IOCCC rules](rules.html),
indicate so in your `remarks.md` file.  You **MUST** try to justify
why you consider your rule abuse to be allowed under the
[IOCCC rules](rules.html).  That is, you must plead your case as to why
your submission is valid.  Humor and/or creativity help plead a case.
As there is no guarantee that you will succeed, you might consider
submitting an alternate version that conforms to the
[IOCCC rules](rules.html).
</p>

<p class="leftbar">
If you do bypass the `mkiocccentry(1)` warnings about [Rule
2a](rules.html#rule2a) and/or about [Rule 2b](rules.html#rule2b)
and submit a submission anyway, you **MUST** try to justify why the IOCCC
[judges](../judges.html) should not reject your submission due to a rule violation.
</p>

Abusing the web submission procedure tends to annoy us more
than amuse us.  Spend your creative energy on content of your
submission rather than on the submission process itself.

We are often asked why the contest [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) seem too
strange or contain mistakes, flaws or grammatical errors.  One reason
is that we sometimes make genuine mistakes.  But in many cases such
problems, flaws or areas of confusion are deliberate.  Changes to
[IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) in response to rule abuses, are done in a minimal
fashion.  Often we will deliberately leave behind holes (or introduce
new ones) so that future rule abuse may continue.  A clever author
should be able to read them and "drive a truck through the holes" in
the [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html).

At the risk of stating the obvious, this contest is a parody of the software
development process.  The [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html)
are only a small part of the overall contest.  Even so, one may think the
contest [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) process as a parody
of the sometimes tragic mismatch between what a customer (or marketing) wants
and what engineering delivers.  Real programmers must face obfuscated and
sometimes conflicting specifications and requirements from marketing, sales,
product management an even from customers themselves on a all too regular basis.
This is one of the reasons why the [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) are written in obfuscated form.

Jump to: [top](#)

<div id="judging">
# JUDGING PROCESS:
</div>

Entries are judged by Leonid A. Broukhis and Landon Curt Noll.

Each submission submitted is given a random id number and subdirectory.  The
submission files including, but not limited to `prog.c`, `Makefile`,
`remarks.md` as well as any data files that you submit, are all placed under
their own directory and stored and judged from this directory.

Any information about the authors is not read by the [judges](../judges.html) until
the judging process is complete, and then only from entries that have
won an award.  Because we do not read this information for entries that
do not win, we do not know who did not win.

The above process helps keep us biased for/against any one particular
individual.  Therefore you **MUST** refrain from putting any information
that reveals your identity in your submission.

Now some people point out that coding style might reveal the information
about the others.  However we consider this to be simply circumstantial
and outside the scope of the above paragraph.

Some people, in the past, have attempted to obfuscate their identity by
including comments of famous Internet personalities such as [Peter
Honeyman](http://www.citi.umich.edu/u/honey).  The [judges](../judges.html) are on to this trick
and therefore consider any obfuscated source or data file claiming to be from
Honeyman to not be from Honeyman.  This of course creates an interesting paradox
known as the "**obfuscated Peter Honeyman paradox**".  Should Peter Honeyman
actually submit to the IOCCC, he alone is excluded from the above, as we
will likely believe it's just another attempt at confusion.  This _guideline_ is
known as the "**Peter Honeyman is exempt**" _guideline_.

BTW: None of the entries claiming to be from Peter Honeyman have ever
won an award.  So it is theoretically possible that Peter Honeyman
did submit to the IOCCC in the past.  In the past, Peter had denied
submitting anything to the IOCCC.  Perhaps those entries were
submitted by one of his students?

Hopefully we are **VERY CLEAR** on this point!  The rules now strongly state:
**PLEASE _DO NOT_ put a name of an author**, in an obvious way, into your
source code, `remarks.md`, data files, etc., the above "**Peter Honeyman is
exempt**" notwithstanding.

We seemed to have digressed again ... :-)  Returning to the judging process:

We prefer to be kept in the dark as much as you are until the final
awards are given.  We enjoy the surprise of finding out in the end,
who won and where they are from.

We attempt to keep all entries anonymous, unless they win an award.
Because the main 'prize' of winning is being announced, we make all
attempts to send non-winners into oblivion.  We remove all non-winning
files, and shred all related printouts.  By tradition, we do not even
reveal the number of entries that we received.

<p class="leftbar">
During the judging process, a process that spans multiple sessions over
a few weeks, we post general updates from our [Mastodon
account](https://fosstodon.org/@ioccc).
</p>

<p class="leftbar">
**Make sure you reload the feed** every so often **because unless you
are mentioned you will NOT get a push notification!**
</p>

Jump to: [top](#)

<div id="rounds">
## JUDGING ROUNDS:
</div>

Judging consists of a number of elimination rounds.  During a round,
the collection of entries are divided into two roughly equal piles;
the pile that advances on to the next round, and the pile that does
not.  We also re-examine the entries that were eliminated in the
previous round.  Thus, a submission gets at least two readings.

Jump to: [top](#)

<div id="readings">
## JUDGING READINGS:
</div>

A reading consists of a number of actions:

* <p class="leftbar">reading `prog.c`, the C source, reviewing the `remarks.md` information</p>
* briefly looking any any supplied data files
* passing the source thru the C pre-processor
    skipping over any `#include`d files
* performing a number of C beautify/cleanup edits on the source
* passing the beautified source thru the C pre-processor
    skipping over any `#include`d files
* compiling/building the source
* running the program
* Doing other things that only [IOCCC judges](../judges.html) know about :-)

In later rounds, other actions are performed including performing
miscellaneous tests on the source and binary.

<p class="leftbar">
This is the very **guideline** that goes, **BING!**
</p>

Until we reduce the stack of submissions down to about 25 submissions,
submissions are judged on an individual basis.  A submission is set aside because it
does not, in our opinion, meet the standard established by the round.
When the number of submissions thins to about 25 submissions, we begin to form
award categories.  Submissions begin to compete with each other for awards.
A submission will often compete in several categories.

The actual award category list will vary depending on the types of submissions
we receive.  A typical category list might be:

* **best small one line program** (see above about one line programs)
* **best small program**
* **strangest/most creative source layout**
* **most useful obfuscated program**
* **best game that is obfuscated**
* **most creatively obfuscated program**
* **most deceptive C code** (code with deceptive comments and source code)
* **best X program** (see [OUR LIKES AND DISLIKES](#likes))
* **best abuse of ISO C or ANSI C standard** (see above about compilers)
* **best abuse of the C preprocessor**
* **worst/best abuse of the rules** (or some variation)
* (anything else so strange that it deserves an award)

We do not limit ourselves to this list.  For example, a few entries are so
good/bad that they are declared winners at the start of the final round.
We will invent awards categories for them, if necessary.

In the final round process, we perform the difficult tasks of
reducing the remaining entries (typically about 25) down to to about
half that number: declaring those remaining to be winners.

Often we are confident that the entries that make it into
the final round are definitely better than the ones that do not
make it.  The selection of the winners out of the final round, is
less clear cut.

Sometimes a final round submission is good enough to win, but is beat out by a
similar, but slightly better submission.  For this reason, it is sometimes
worthwhile to resubmit an improved version of a submission that failed to win in
a previous year, the next year.  This assumes, of course, that the submission is
worth improving in the first place!

<p class="leftbar">
Over the years, more than one [IOCCC judge](../judges.html)
has been known to **bribe** another IOCCC [judge](../judges.html) into voting for a
winning entry by offering a bit of high quality chocolate, or
other fun item.
</p>

<p class="leftbar">
One **should NOT** attempt to **bribe** an [IOCCC
judge](../judges.html), **unless you are an [IOCCC judge](../judges.html)**,
because **bribing** an [IOCCC judge](../judges.html) by a non-judge
has been shown to **NOT** be effective when the **person _attempting_
the _bribe_ is made known** to the [IOCCC judges](../judges.html)
(i.e., they are not anonymous) AND/OR the **bribe** is otherwise
associated with a submission to the [IOCCC](../index.html).
</p>

<p class="leftbar">
With the previous guideline in mind: **anonymous** gifts
for the [IOCCC judges](../judges.html) that are **NOT ASSOCIATED
WITH** a submission to the [IOCCC](../index.html) may be sent to the
[IOCCC judges](../judges.html) via the
[IOCCC Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/3HSNTEL8RQ1M0?ref_=wl_share).
It has been shown that receiving  **anonymous** gifts provides the
[IOCCC judges](../judges.html) with a nice
[dopamine](https://en.wikipedia.org/wiki/Dopamine) boost, and happy
[IOCCC judges](../judges.html) help make the [IOCCC](../index.html) better for everyone. :-)
</p>

<p class="leftbar">
See the
FAQ on "[support the IOCCC](../faq.html#support)".
</p>

More often than not, we select a small submission (usually one line) and a
strange/creative layout submission.  We sometimes also select a
submission that abuses the [IOCCC guidelines](guidelines.html) in an interesting way,
or that stretches the contest [rules](rules.html) that while legal, it
nevertheless goes against the **intent** of the [rules](rules.html).

<p class="leftbar">
Nevertheless, see [Rule 12](rules.html#rule12).
</p>

In the end, we traditionally pick one submission as '**best**'.  Sometimes such
a submission simply far exceeds any of the other entries.  More often, the
'**best**' is picked because it does well in a number of categories.

In years past, we renamed the winning submission from `prog.c` to a
name related to the author(s)' names.  This is no longer done.
Winning source is called `prog.c`. A compiled binary is called `prog`.

Jump to: [top](#)

<div id="announcements">
# ANNOUNCEMENT OF WINNERS:
</div>

<p class="leftbar">
The [judges](../judges.html) will toot initial announcement of who won, the name
of their award, and a very brief description of the winning entry
from the [@IOCCC Mastodon account](https://fosstodon.org/@ioccc).
</p>

<p class="leftbar">
We recommend that you follow us on mastodon but **please make sure to
refresh the feed** every so often (if not more often) because unless you are
mentioned or someone boosts your post you will not get a push notification.
</p>

Jump to: [top](#)

<div id="winners">
## How the new IOCCC winners will be announced
</div>

<p class="leftbar">
The [current status of the IOCCC](../status.html) will change from
**[judging](../status.html#judging)** to **[closed](../status.html#closed)** .
</p>

<p class="leftbar">
The **contest_status** in the [status.json](../status.json) file will change
from **judging** to **closed** as well.
</p>

<p class="leftbar">
When the above happens, the winning entries have been selected by the [IOCCC
judges](../judges.html).
</p>

<p class="leftbar">
The [IOCCC judges](../judges.html) will begin to prepare to release the source
code of the new IOCCC winners.
</p>

<p class="leftbar">
The [IOCCC judges](../judges.html) will commit the winning source to the
[IOCCC winner repo](https://github.com/ioccc-src/winner) which will update the
[Official IOCCC website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
The [IOCCC news](../news.html) will also contain an announcement of the winners.
</p>

Jump to: [top](#)

<div id="mastodon">
## An important update to how winners are announced
</div>

<p class="leftbar">
The IOCCC no longer uses twitter.  IOCCC entries will be announced by a
`git` commit to the [IOCCC entries repo](https://github.com/ioccc-src/winner)
that, in turn, updates the [Official IOCCC
website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
In addition a note is posted to the [IOCCC Mastodon account](https://fosstodon.org/@ioccc).
</p>

Jump to: [top](#)

<div id="entries">
## Back to announcement of winners
</div>

<p class="leftbar">
It is pointless to ask the [IOCCC judges](../judges.html) how many
submissions we receive.  See [How many submissions do the judges receive for a
given IOCCC?](../faq.html#how_many).
</p>

Often, winning entries are published in selected magazines from around the
world.  Winners have appeared in books ('`The New Hacker's Dictionary`',
'`Obfuscated C and Other Mysteries`', '`Pointers On C`', others) and on t-shirts.
More than one winner has been turned into a tattoo!

Last, but not least, [winners](../authors.html) receive international fame and flames!  :-)

Jump to: [top](#)

<div id="more-information">
<div id="information">
# FOR MORE INFORMATION:
</div>
</div>

<p class="leftbar">
For questions or comments about the contest, see [Contacting the IOCCC](../contact.html).
</p>

<p class="leftbar">
Be sure to review the [IOCCC Rules and Guidelines](index.html) as the
[IOCCC rules](rules.html) and the [IOCCC guidelines](guidelines.html) may (and often do) change from year to year.
</p>

<p class="leftbar">
You should be sure you have the current [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting entries.
</p>

<p class="leftbar">
See the [Official IOCCC website news](../news.html) for additional information.
</p>

<p class="change marker">
For the updates and breaking [IOCCC news](../news.html), you are encouraged to follow
the [IOCCC on Mastodon](https://fosstodon.org/@ioccc).  See our
FAQ on "[Mastodon](../faq.html#try_mastodon)"
for more information. **Please be
aware** that unless you are mentioned you most likely will **NOT** get a
notification so you should make sure to check the page.
</p>

<p class="leftbar">
Check out the [Official IOCCC website](https://www.ioccc.org/index.html) in general.
</p>

Jump to: [top](#)

Leonid A. Broukhis<br>
chongo (Landon Curt Noll) /\\cc/\\


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)
