<!-- START: this line starts content from: inc/guidelines.closed.hdr -->

# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entries that have won the
IOCCC in the past.

These guidelines are a **TENTATIVE proposal** for the next IOCCC
and are **likely be to be updated** before the next IOCCC.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[about asking questions](../faq.html#question)"
about these guidelines. You might also find the FAQ in general useful, especially the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)".

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
Copyright &copy; 2024-2025 Leonid A. Broukhis and Landon Curt Noll.
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
These [IOCCC guidelines](guidelines.html) are version **28.49 2025-11-17**.
</p>

The markdown form of these guidelines <a href="guidelines.md"
download="guidelines.md">is available for download</a>.

**IMPORTANT**: Be **SURE** to read the [IOCCC rules](rules.html).


Jump to: [top](#)


<div id="change_marks">
# Change marks
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
**hints** and **suggestions**.  **Submission that violate the
[guidelines](guidelines.html) _but remain within the [rules](rules.html)_** _are
allowed_.  Even so, you are safer if you remain within the [IOCCC
guidelines](guidelines.html).

Of course if a guideline is talking about a rule and you break that guideline,
you stand a good chance of having your submission rejected for breaking the
rule, not the guideline.

You **SHOULD read the CURRENT [IOCCC rules](rules.html)**, _prior_ to submitting
code to the contest.


Jump to: [top](#)


<div id="new">
# WHAT'S NEW THIS IOCCC
</div>

<p class="leftbar">
This IOCCC runs from **2024-12-29 23:58:13.213455 UTC** to **2025-06-05 04:03:02.010099 UTC**.
This IOCCC marks the **40th anniversary** of the contest!
</p>

<p class="leftbar">
This contest will enter the **[pending](../faq.html#pending)** state on or about
**2024-12-29 23:58:13.213455 UTC**.
When this happens, you may begin registering to enter the IOCCC.
</p>

<p class="leftbar">
This contest will enter the **[open](../faq.html#open)** state on **2025-03-05 23:19:17.131107 UTC**.
When this happens, you may begin uploading your submissions to the IOCCC.
</p>

<p class="leftbar">
This contest will enter the **[judging](../faq.html#judging)** state on **2025-06-05 04:03:02.010099 UTC**.
When this happens, you may no longer upload your submissions to the IOCCC.
</p>

**IMPORTANT NOTE**: Until the contest enters the **[open](../faq.html#open)** state, any or all
of the above **dates and times may change _AT ANY TIME_**!

<p class="leftbar">
The reason for the times of day are so that key IOCCC events are **calculated**
to be a **fun**ctional UTC time.  :-)
</p>

Until the contest status becomes **[open](../faq.html#open)**,
the [IOCCC rules](rules.html),
[IOCCC guidelines](guidelines.html) and the tools in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) **SHOULD be
considered** provisional **BETA** versions and **may be adjusted _AT ANY TIME_**
before the contest status becomes **[open](../faq.html#open)**.

See the
FAQ on "[how to register and submit to the IOCCC](../quick-start.html#enter)"
for instructions on registering and participating in the IOCCC, as the process
may change from contest to contest.

To assist in the formation of the xz compressed tarball for submission, use the
`mkiocccentry(1)` tool as found in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

See FAQs regarding:

- [obtaining the latest mkiocccentry tools](../faq.html#obtaining_mkiocccentry)
- [compiling the mkiocccentry tools](../faq.html#compiling_mkiocccentry)
- [installing the mkiocccentry tools](../faq.html#install)
- [using the mkiocccentry tools](../faq.html#using_mkiocccentry)

Uploading a tarball not formed by `mkiocccentry(1)` puts you at a very big risk of
violating
[Rule 17 Packaging](rules.html#rule-17-packaging),
especially as `mkiocccentry(1)` does a
great number of things that are required, and it also runs many checks, and if
any of those checks fail, you are at a very great risk of having your submission
rejected for violating
[Rule 17 Packaging](rules.html#rule-17-packaging).

We **STRONGLY** recommend you **do** install the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry).

**IMPORTANT NOTE**: the tools that require other tools, `mkiocccentry(1)` and
`txzchk(1)`, will, as of version `2.0.2 2025-03-11`, search under `$PATH`. If
you have an earlier version and you have not installed the tools and run the
tools from outside the repo directory, you will have to use the options to the
tools to set the path to the required tools.

See the
FAQ on "[obtaining and compiling the most recent mkiocccentry tools](../faq.html#mkiocccentry)"
and the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)"
as that FAQ has important details on
[how to register](../next/register.html)
as well as
[how to upload your submission](../next/submit.html) to the IOCCC.

While the contest is **[open](../faq.html#open)**, you may modify your
previously uploaded submission by rebuilding your submission with the
`mkiocccentry(1)` tool and then re-uploading it to **the same slot number** on the
[submit server](https://submit.ioccc.org).

**HINT:** so that you do not have to repeatedly answer all the
questions, the `mkiocccentry(1)` tool has the options `-a answers`, `-A answers`
and `-i answers`, where `-a` will write to an answers file (if it does not
already exist), `-A` **WILL OVERWRITE THE FILE** and `-i` will read the answers from
the file. If you use `-A`, **BE SURE** you don't overwrite another file by accident!

Be aware that even with the `-i answers` you will still be required to confirm
most if not all `y/n` questions - you just don't have to input the name of the
submission, the abstract, the author details etc. If you really wish to
circumvent this you can use the `-Y` option but we do not recommend this because
if your update breaks a rule or there is some problem, you might not see it.

To help with not having to repeatedly enter a UUID, whether for the same
submission or multiple submissions, you can use the `-u uuidfile` or `-U UUID`
option. See the
FAQ on "[how to avoid re-entering your UUID](../faq.html#uuid)"
for more details. Note that the `-i answers` option cannot be used with the UUID
options as the answers file includes the UUID.

The overall size limit (see Rule 2a Gross Size](rules.html#rule-2a-gross-size)) on `prog.c` has been
**increased from 4096 to 4993** bytes.
The [Rule 2b Next Size](rules.html#rule-2b-net-size)size was changed from
**4096** to **4993** to keep the "2b to 2a" size ratio to a
value similar to the [2001-2012](../faq.html#size_rule2001-2012) and
[2013-2020](../faq.html#size_rule2013-2020) IOCCC eras.

The [Rule 2b Next Size](rules.html#rule-2b-net-size) size has **increased from 2053 to 2503**
bytes.

<p class="leftbar">
However, you should pay especial attention to our remarks in the [IOCCC28
index.html](../2024/index.html):
</p>

<p class="leftbar">
> **IMPORTANT HINT**: Only 3 of the 23 **IOCCC28 winners** came close to the
[Rule 2 Size](rules.html#rule-2-size) limit.
Large code size isn't
everything.  :-) Those submitting to future contents should **take a careful
note** of that fact.
</p>


Your submission must satisfy **BOTH** the maximum size
[Rule 2a Gross Size](rules.html#rule-2a-gross-size)
**AND**
the IOCCC size
[Rule 2b Next Size](rules.html#rule-2b-net-size).

To check your code against
[Rule 2 Size](rules.html#rule-2-size), use the `iocccentry(1)` tool.
For example:

``` <!---sh-->
    iocccsize prog.c
```

The IOCCC size tool algorithm can be summarized as follows:

> The size tool counts most C reserved words (keyword, secondary, and selected
preprocessor keywords) as 1.  The size tool counts all other bytes as 1
excluding ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' followed by
ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' byte immediately
before the end of file.

ASCII whitespace includes ASCII tab, ASCII space, ASCII newline,
ASCII formfeed, and ASCII carriage return.

When '`;`', '`{`' or '`}`' are within a C string, they may still not be
counted by the IOCCC size tool.  This is a **feature**, not a bug!

In cases where the above summary and the algorithm implemented by
the IOCCC size tool `iocccsize(1)` conflict, the algorithm implemented
by the current version of `iocccsize(1)` is preferred by the [IOCCC judges](../judges.html).

In other words, make sure `iocccsize` does not flag any issues with your
`prog.c`.

There are at least 2 other reasons for selecting 2503 as the 2nd limit besides
the fact that 2503 is a prime. These reasons may be searched for and discovered
if you are ["Curios!" about 2503](https://t5k.org/curios/page.php/2503.html).
:-) Moreover, 2053 was the number of the kernel disk pack of one of the judge's
BESM-6, and 2503 is a decimal anagram of 2053.

Take note that this secondary limit imposed by the IOCCC size tool
obviates some of the need to `#define` C reserved words in an effort
to get around the size limits of
[Rule 2 Size](rules.html#rule-2-size).

Yes Virginia, **that is a hint**!

The **official locale** of the **IOCCC** is **C**.

<p class="leftbar">
Did you really think anything else? :-)
</p>

The [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry),
as of [Release version 2.4.4 2025-03-15](https://github.com/ioccc-src/mkiocccentry/releases/tag/2.4.4),
will run with a locale set to **C**.
</p>


Jump to: [top](#)


<div id="hints">
<div id="suggestions">
# HINTS AND SUGGESTIONS:
</div>
</div>

You are **encouraged** to examine the [winners of previous contests](../years.html).

Keep in mind that [rules](rules.html) change from year to year, so some [winning
entries](../years.html) might not be valid submissions this year; what _was_ unique
and novel one year _might be 'old' the next year_.

A submission is usually examined in a number of ways.  We typically apply
a number of tests to a submission:

* look at the original source
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
cases, a test is not important.  Submissions that compete for the
'**strangest/most creative source layout**' need not do as well as
others in terms of their algorithm.  On the other hand, given
two such submissions, we are more inclined to pick the submission that
does something interesting when it's executed.

We try to avoid limiting creativity in our [rules](rules.html).  As such, we
leave the contest open for creative rule interpretation.  As in [real
life](https://en.wikipedia.org/wiki/Real_life) programming, interpreting a
requirements document or a customer request is important.  For this reason, we
often award '**Best abuse of the [rules](rules.html)**' or '**Worst abuse of the
[rules](rules.html)**' or some variation to a submission that illustrates this
point in an ironic way.

The IOCCC has a rich history of remarkable winning entries created by
authors who skillfully employed various techniques to develop their code.
While it is **NOT** required, you are allowed to use tools to develop
and test your submission.  These tools may include, but are not limited
to code generators, code analysis tools, static code analysis tools,
runtime analysis tools, machine learning tools, natural language models,
code copilot tools, so-called AI services, large language models (LLMS), etc.
If you do make use of such tools or services, then we **ENCOURAGE you to describe
how you used such tools** in your `remarks.md` file.

You may use git, or services such as [GitHub](https://www.github.com)
to develop and maintain your submission.  However, we **DISLIKE**
submissions that **require** them in order to build/compile your submission.

Submissions will be judged in an environment that has no **IDE**.
Any submission that fails to compile/build because it requires
an **IDE** will be rejected.

We will use the `make(1)` tool, your `Makefile`, and other tools found in
[Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
in the building and compiling of your submission.

We do realize that there are holes in the [rules](rules.html), and invite
submitters to attempt to exploit them.  We may award '**Worst abuse of the
[rules](rules.html)**' or '**Best abuse of the [rules](rules.html)**' or some
variation and then plug the hole next year.

When we do need to plug a hole in the [IOCCC rules](rules.html) or [IOCCC
guidelines](guidelines.html), we will attempt to use a very small plug, if not
smaller.  Or, maybe not.  :-)

There may be fewer than 2^7+1 reasons why these [IOCCC
guidelines](guidelines.html) seem obfuscated.

**IMPORTANT:** Be sure that **your submission works** as documented in your
`remarks.md` file.  We sometimes make an effort to debug a submission
that has a slight problem, particularly in or near the final round.
On the other hand, we have seen some otherwise excellent submissions
fall down because they didn't work as documented.

If you submission has bugs and/or mis-features, you are **MUCH BETTER** off
documenting such bugs and/or mis-features in your `remarks.md` file.

Consider an example of a [prime number](https://en.wikipedia.org/wiki/Prime_number)
printing program that claims that 16 is a prime number.
Noting such a bug in your `remarks.md` file could save your submission:

> "_this submission sometimes prints the 4th power of a prime by mistake_"

Sometimes a strange bug or (mis-)feature can even help the submission!  Of course, a correctly
working submission might be better.

We tend to look down on a [prime
number](https://en.wikipedia.org/wiki/Prime_number) printer that claims that
16 is a prime number.
Clever people will note that 16 might be prime
under certain conditions.  ;-)  Wise people, when submitting something clever
will fully explain such cleverness in their submission's `remarks.md` file.

People who are considering to just use some complex mathematical
function or state machine to spell out something such as "_hello,
world!_" **really really, _and we do mean REALLY_, do need to be more creative**.

Ultra-obfuscated programs are, in some cases, easier to
deobfuscate than subtly-obfuscated programs.  Consider using
misleading or subtle tricks layered on top of or under an
appropriate level of obfuscation.  A clean looking program with
misleading comments and variable names might be a **VERY GOOD START**
to a great submission!


Jump to: [top](#)


<div id="mkiocccentry">
# `mkiocccentry`
</div>

[Rule 17 Packaging](rules.html#rule-17-packaging)
(the `mkiocccentry(1)` rule) states that
you **REALLY SHOULD** use the `mkiocccentry(1)` tool to package your submission tarball.

See the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
for the `mkiocccentry(1)` tool and below for more details.

**IMPORTANT NOTE**: make **CERTAIN** you have the most recent version of the
`mkiocccentry` toolkit! See the
FAQ on "[obtaining the mkiocccentry toolkit](../faq.html#obtaining_mkiocccentry)".

`mkiocccentry` runs a number of checks, by the tool itself and by executing
other tools, _before_ packaging your xz compressed tarball, including running
`chksubmit(1)` on the submission directory.

If `mkiocccentry` encounters an **error**, the program will exit and the xz
compressed tarball **will not be formed**. For instance, if
[chksubmit](#chksubmit) fails to validate the submission directory, either because
of a validation error in the `.auth.json` or `.info.json`
[JSON](https://www.json.org/json-en.html) files or because of
something else that `mkiocccentry(1)` creates or does, it is an
**error** and **possibly** a bug that you should [report as a bug at the
mkiocccentry bug report
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
**PLEASE run the `bug_report.sh` script to help us out here!**  See the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".

Once the tarball is packaged it will
run `txzchk(1)`, which will also run `fnamchk(1)`, as part of its algorithm.

However, even if `mkiocccentry` or one of the tools it invokes reports an error,
it **does not** necessarily mean it is a bug in the code. It might be an issue with
your submission. Thus if you report an error as a bug it might not be something
that will be fixed as there might not be anything wrong with the tools.

On the other hand, some conditions flagged by `mkiocccentry(1)` are **warnings**
and it allows you to override these, if you wish. If you're brave enough you can
use the `-W` option to ignore all warnings but this is a big risk; the `-y`
option will assume '_yes_' to most questions but this is also a big risk. Using
`-Y` will say '_yes_' to even more prompts. Needless to say, we do **NOT**
recommend these options.

In many places it will prompt you to verify what you input, allowing you to
correct details as you go along. Be advised that there is a default answer and
if you press enter it will proceed with that default, so make sure you have
provided the correct answer.

If you wish to **test** that your submission passes the `mkiocccentry(1)` tests
without having to type in in answers each time, you can use the `-d` or `-s seed`
option to `mkiocccentry` for the tool to pseudo-randomly create answers for you.
For example:

``` <!---sh-->
    mkiocccentry -d workdir topdir
```

**IMPORTANT NOTE**: if you run an IOCCC related tool outside the repo directory
(specifying the absolute or relative path to the tool) and you have not
installed the tools (and we **STRONGLY** recommend you **do** install them),
then you will have to specify the options (such as paths) for the tools that are required like
`chksubmit(1)`, `txzchk(1)` and `fnamchk(1)`.

Make sure you have
the latest version of of the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
so that you do not violate
[Rule 17 Packaging](rules.html#rule-17-packaging)
by mistake.


Jump to: [top](#)


<div id="mkiocccentry-synopsis">
## `mkiocccentry(1)` synopsis
</div>

The synopsis of the `mkiocccentry(1)` tool is:

``` <!---sh-->
    mkiocccentry [options] workdir topdir
```

To help you with editing a submission, the `mkiocccentry(1)` tool has
some options to write _OR_ read from an answers file so you do not have to input
the information about the author(s) and the submission more than once, unless of
course you need to make some changes, in which case you can use the option that
overwrites the file. If you do use the overwrite option, **MAKE SURE** you do
not overwrite another file!

See the
FAQ on the
"[mkiocccentry tool](../faq.html#mkiocccentry)"
for how to use this tool and the
FAQ on the
"[finer details of mkiocccentry](../faq.html#mkiocccentry_details)"
for even more information.


<div id="tools">
# Other mkiocccentry tools
</div>

The `mkiocccentry(1)` tool will execute a number of tools, some of which will
execute one or more additional tools.

<div id="iocccsize">
## `iocccsize`
</div>

`mkiocccentry(1)` will use code from `iocccsize(1)` which detects a number of
issues (such as [Rule 2 Size](rules.html#rule-2-size)) that you may ignore, if you wish, as
noted above.

In other words, you no longer need to run `iocccsize` manually. However, the
checks described above are still made but through the `mkiocccentry(1)` tool itself.

Jump to: [top](#)


<div id="chksubmit">
## `chksubmit`
</div>

`mkiocccentry(1)` will write two JSON files: `.auth.json` and
`.info.json`. These files contain information about the author(s) and about the
submission. After these files are formed, the `chksubmit(1)` tool will be run on
the submission directory; this tool not only validates the two JSON files
(and runs specific checks on them after validating the JSON), but it also
verifies that what is in the manifest in `.info.json` matches the contents of
the directory, in addition to other checks. If `chksubmit(1)` fails to validate
anything at all, your submission **WILL BE** rejected!

**IMPORTANT**: although `chksubmit(1)` validates the files in the directory, it
only inspects the contents of the two JSON files; it performs other kinds of
checks on the other files, and those checks are run on the two JSON files as
well.

If you submit your own JSON files (other than `.auth.json` and
`.info.json`) then they do **NOT** have to be valid JSON.
However, if you do provide such invalid JSON files, **PLEASE**
document and explain this in your `remarks.md` file.

<p class="leftbar">
On the other hand, some people might question what actually constitutes a valid
JSON file. :-)
</p>

If `chksubmit` does not pass and you used `mkiocccentry(1)` it is **very likely** a
bug and you should [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
**PLEASE** run the command:

``` <!---sh-->
    make bug_report
```

from the top level repo directory itself and attach the bug report file (it will
tell you the name of the file). See also the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".

Assuming that `chksubmit(1)` successfully validates your submission directory,
the tarball will be formed and then `txzchk(1)` will be executed on it. In this
case, there should be no problems, as `mkiocccentry(1)` should **NOT** form a
tarball if there are any issues.

If `mkiocccentry(1)` is used and `chksubmit(1)` fails to validate your submission
directory, then unless it is a system specific problem, it could be a bug in
`mkiocccentry(1)`, `chksubmit(1)` or possibly `jparse`, although this is unlikely.
Nonetheless, if you believe there is a bug, you may report it as explained above.

If you want to know what `.auth.json` is, see the
FAQ on "[.auth.json](../faq.html#auth_json)".
If you want to know what the `.info.json` file is, see the
FAQ on "[.info.json](../faq.html#info_json)".
On the other hand, if you want to know a bit more details about `chksubmit(1)`, see the
FAQ about "[chksubmit](../faq.html#chksubmit)".

`chksubmit` uses the `jparse` library. See the
[jparse
README.md](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/README.md)
in the [mkiocccentry GitHub repo subdirectory
jparse](https://github.com/ioccc-src/mkiocccentry/tree/master/jparse) as well as
the [jparse library README.md
file](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jparse_library_README.md)
in the [mkiocccentry GitHub repo subdirectory
jparse](https://github.com/ioccc-src/mkiocccentry/tree/master/jparse), for more
details.

The `jparse` parser, library and tools were co-developed by [Cody Boone
Ferguson](../authors.html#Cody_Boone_Ferguson) and [Landon Curt
Noll](http://www.isthe.com/chongo/index.html) in 2022-2025 and come from the
[jparse repo](https://github.com/xexyl/jparse). However, the **mkiocccentry
tools use a _clone_** of the [jparse repo](https://github.com/xexyl/jparse) **at
a _specific_ release**.  Thus the `mkiocccentry` will at times be behind the
[jparse repo](https://github.com/xexyl/jparse)!

You do **NOT need to install** `jparse` from the [jparse
repo](https://github.com/xexyl/jparse)! The `mkiocccentry` tools link in the
static library from `mkiocccentry`'s _clone_.

The `mkiocccentry` toolkit _also_ has a clone of _both_ the [dbg
library](https://github.com/lcn2/dbg) and the
[dyn_array library](https://github.com/lcn2/dyn_array); the [dyn_array
library](https://github.com/lcn2/dyn_array) uses the [dbg
library](https://github.com/lcn2/dbg) and the [jparse
library](https://github.com/xexyl/jparse) uses both libraries but unlike in the
[jparse repo](https://github.com/xexyl/jparse), the libraries do not need to be
installed separately, in order to use the tools in `mkiocccentry`.

In other words, `mkiocccentry` **contains everything** you need, and _even if you
do install_ the libraries from their respective repos, it/they will **not be
used** when compiling the `mkiocccentry` tools. This is important to
make sure that you're using the correct versions, which is also verified by
`chksubmit` (in the JSON files created by `mkiocccentry(1)`). See
[Rule 17 Packaging](rules.html#rule-17-packaging)!

<p class="leftbar">
We **HIGHLY** recommend you install the `mkiocccentry` toolkit, however.
</p>

Please see the
FAQ on "[validating your submission directory](../faq.html#chksubmit)
for more details on `chksubmit(1)`.

You might also wish to see the
FAQ on "[.auth.json](../faq.html#auth_json)"
and the
FAQ on "[.info.json](../faq.html#info_json)"
for much more information on these files.


Jump to: [top](#)


<div id="txzchk">
## `txzchk`
</div>

`txzchk(1)` performs a wide number of sanity checks on the xz compressed
tarball; if any issues are found ('`feathers are stuck in the tarball`' :-) )
**AND if and _ONLY IF_ you used `mkiocccentry(1)`**, then it is **possibly** a
bug in one of the tools and you might want to [report it as a bug at the
mkiocccentry bug report
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
**PLEASE run the `bug_report.sh` script to help us out here!** You may do this
by running from the top level directory of the repo `make bug_report`. See the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".

As part of its algorithm, `txzchk(1)` will run `fnamchk(1)` on the
_tarball_ to verify that the _filename_ is valid. See the
FAQ on "[fnamchk](../faq.html#fnamchk)"
and the [fnamchk section](#fnamchk) below for more details on this tool.

It is beyond the scope of this document to discuss the many tests that
`txzchk(1)` performs; if you wish to know, we refer you to the [source
code](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c) or the man
page. You might just find a fun option if you do either of these!

Of course, as `txzchk` does not extract the tarball, it is possible that if you
manually package your submission tarball and/or find and exploit a missing
check, you could still be violating
[Rule 17 Packaging](rules.html#rule-17-packaging).

<div id="extra-files">
## Including optional and extra files
</div>

<p class="leftbar">
The maximum total number of _extra files_ that may be submitted is 31.
</p>

<p class="leftbar">
An _extra file_ is defined as a file that is not `prog.c`, `prog.alt.c`,
`try.sh`, `try.alt.sh`, `remarks.md`, `Makefile`, `.auth.json` and `.info.json`:
unless it's not in the top level directory, in which case it **IS** an _extra
file_. The non-extra files are considered _free files_.
</p>

<p class="leftbar">
Of course any dot file that is not `.auth.json` and `.info.json` will result in
a violation of
[Rule 17 Packaging](rules.html#rule-17-packaging),
regardless of its depth.
</p>

If you use an optional filename for something other than their intended use
in order to get past the file limit, we will consider that an
abuse of rules.

<p class="leftbar">
For information on the `try` script files see the
FAQ on the "[try.sh script system](../faq.html#try_script)"
and for more details on alt code (including the `try.alt.sh` script) see the
FAQ on "[alt code](../faq.html#alt_code)".
</p>

<p class="leftbar">
If you really **MUST** include more files than the limit allows, then you may do
so by including as an extra file, a tarball. This does **NOT** have to pass
`txzchk(1)` tests; only the submission tarball must pass the `txzchk(1)` tests.
</p>

<p class="leftbar">
You **MUST** justify including extra files beyond the limit, should you do so.
Even so this does not mean it will be considered valid.
</p>

<p class="leftbar">
If you use a tarball for a depth beyond the maximum, you **MUST** justify this
as well. Even so this does not mean it will be considered valid.
</p>

If you **DO** include a tarball, and the build process or the program extracts
said tarball(s), the make `clobber` rule **MUST** remove the extracted files.

**IMPORTANT REMINDER**: make **SURE** your tarball does **NOT** reveal who you are!
The `mkiocccentry(1)` tool creates a v7 format tarball to prevent this. You can
do the same like:

``` <!---sh-->
    tar --format=v7 -cJf foo.txz directory
```

See
[Rule 17 Packaging](rules.html#rule-17-packaging)
and also the
FAQ on "[maximum number of files](../faq.html#max-files)".

If you do not follow these points, you
are at a great risk of violating
[Rule 17 Packaging](rules.html#rule-17-packaging)!

**NOTE**: if you want to include a test-suite that requires a lot of files,
please suggest this in your `remarks.md` and if your submission wins it can
be done. In other words you should NOT use a tarball for a test-suite unless you
have a very good reason for this (and if you do, make **SURE** you specify why
in your `remarks.md` file).

See also the
FAQ on "[txzchk](../faq.html#txzchk)".

Jump to: [top](#)


<div id="fnamchk">
## `fnamchk(1)`
</div>

As an important part of its algorithm, [txzchk&lpar;1&rpar;](#txzchk) directly executes
`fnamchk(1)`.  If the filename is invalid (or the filename does not match the
directory name of the tarball) then it is an **error** and you risk violating
[Rule 17 Packaging](rules.html#rule-17-packaging).
Nevertheless, you can run the tool manually,
should you wish to.

For more information on `fnamchk` and how to manually validate your submission
tarball filename, see the
FAQ on "[fnamchk](../faq.html#fnamchk)".

It is extremely unlikely that `fnamchk(1)` reporting an invalid filename is a
bug in `fnamchk(1)` and as such, ignoring such an issue risks violating
[Rule 17 Packaging](rules.html#rule-17-packaging)
which is a big risk. Of course, using `mkiocccentry(1)`
would prevent this from happening as it would not create such a file anyway. If
`mkiocccentry(1)` was used it would rather suggest a bug in one of the tools and
you should [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
See the
FAQ on "[reporting mkiocccentry bugs](../faq.html#mkiocccentry_bugs)".

As you can see, the use of `mkiocccentry(1)` is **HIGHLY RECOMMENDED**, and at
the risk of stating the obvious, you run **A VERY BIG RISK** of having
your submission rejected if you package your own tarball, and there are **ANY
problems**. For instance, if `chksubmit(1)` found a problem in your `.info.json`
file, the `mkiocccentry(1)` tool would not package it. But if you were to package
it manually, you would be violating
[Rule 17 Packaging](rules.html#rule-17-packaging).
But even if
everything checks out OK you should **NOT** assume that everything **IS** OK.

<div id="bugs">
# Problems and/or bugs in the mkiocccentry toolkit
</div>

Although the tools have been tested extensively, it is nonetheless possible for bugs to
exist in the code, as all programmers know. In this case, **please** ask for help or report what
you think is a bug via the [bug report issues page in the mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).

Of course, it is also possible for `mkiocccentry(1)`, or one or more of the
tools it executes (or another tool executes), to fail, but **NOT** because of a
bug. An example problem is if there is not enough memory available or if some
other library or syscall fails. Nonetheless it might be worth reporting as a
bug; it is a judgement call: if it's a bug it'll be addressed and if it's not
that's OK too!


<div id="make">
<div id="makefile">
# Makefiles
</div>
</div>

We **recommend** AND **encourage** you to use the example Makefile,
as the starting point for your submission's required `Makefile`:

- [view example Makefile](%%REPO_URL%%/next/Makefile.example)
- <a href="Makefile.example" download="Makefile">download example Makefile</a>

Feel free to modify the `Makefile` to suit your obfuscation
needs.

**Please** add a space between the `=` and the value of variables, in the
`Makefile`, making sure that the `=` comes immediately after the name. See the
example `Makefile` for examples.

<p class="leftbar">
This helps us fit the Makefile into a winning entry, should your submission win.
</p>

The rest of this section and its subsections will assume that you are using some
variant of the example `Makefile`, again renamed as `Makefile`.

We suggest that you compile your submission with a commonly available
`-std=gnu17` (ISO C 2017 with GNU extensions) C compiler, via `clang(1)`
and/or `gcc(1)`.

<div id="cflags">
<div id="flags">
## Default compiler flags
</div>
</div>

Unless you **clearly state** otherwise in your `remarks.md` file, **AND** put in
your submission's `Makefile`, we **will** compile using `-std=gnu17 -O3`!

It **is OK** if you need to require your submission to **NOT be** compiled
using the default `-std=gnu17 -O3` settings.  Simply **explain why**
your submission should NOT be compiled using `-std=gnu17 -O3` in
your `remarks.md` file, **AND** adjust your `Makefile` accordingly.

<p class="leftbar">
You really should **NOT** redefine `CC` because doing so makes it less portable. <-- **Hint!**
</p>

One reason that you might have to change the flags, is that the optimiser is
known to break some programs, but there are certainly other possible valid
reasons. Again, just update the `Makefile` and explain it in your `remarks.md`.
See the [optimiser section](#optimiser) for details for changing optimiser
flags.

For more fun when it comes to optimisers breaking code, see
[1986/marshall/compilers.html](../1986/marshall/compilers.html).


<div id="compilers">
## Default compiler
</div>

**IMPORTANT NOTE**: The use of `-std=gnu17` does **NOT** imply the use of the `gcc`
compiler!  We often start by compiling using the **clang** C compiler instead.

**PLEASE NOTE**: in macOS, the compiler `gcc` found at `/usr/bin/gcc` is
in truth the `clang` compiler, as `/usr/bin/gcc --version` will show!


<div id="cstd">
<div id="standard">
## C standard
</div>
</div>

You may change the standard under which your submission is compiled
by modifying the `CSTD` Makefile variable.  For example, to use `c99` instead:

``` <!---make-->
    CSTD= -std=c99
```

<div id="opt">
<div id="optimization">
<div id="optimisation">
<div id="optimizer">
<div id="optimiser">
## Default optimisation level
</div>
</div>
</div>
</div>
</div>

You may change the level of optimization and compiler debug level
that your submission is compiled with, by modifying the `OPT` Makefile variable.
For example, to compile without optimization, and to include debug symbols:

``` <!---make-->
    OPT= -O0 -g3
```

<div id="warnings">
<div id="cwarn">
## Compiler warnings
</div>
</div>

The default warning flags are set via the `CWARN` variable, as shown in the
example `Makefile`:

``` <!---make-->
    # Common C compiler warning flags
    #
    CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}
```

For details on `CSILENCE` and `CUNKNOWN`, see the [section on disabling
warnings](#disabling-warnings).

<div id="weverything">
### The `-Weverything` option
</div>

For compilers, such as `clang`, that have the `-Weverything` option,
while you may wish to try it, you should read our
FAQ on "[clang -Weverything](../faq.html#weverything)".
We do **NOT** recommend that you put
the use of `-Weverything` into your submission's `Makefile` for the reasons
cited there. This goes even if your version does not trigger a warning as some
other version might!

On the other hand, if `${CC}` has "`clang`" in the name, the example `Makefile` will
automatically enable `-Weverything`, so you might have to use `-Wno-foo`
options anyway, as detailed below. See the
FAQ on "[-Weverything](../faq.html#weverything)"
for more details.

If "`clang`" is NOT in `${CC}`, the `CWARN` variable will not be further
modified.

There is no real penalty for compiler warnings.  Sometimes
compiler warnings cannot be helped: especially in the case of
obfuscated C.  :-)  So if you cannot easily get rid of a compiler
warning, try not to fret too much.

We **LIKE** code that has a minimum of warnings, especially under the
more strict ` -Wall -Wextra -pedantic` mode:

``` <!---make-->
    CWARN= -Wall -Wextra -pedantic
```

The two previous guidelines might be thought by some as being somewhat
contradictory.  Isn't life, and isn't trying to satisfy "contradictory customer
requirements" all too often like that?  :-)  Try to minimize warnings if you
can.

If you manage to produce very few warnings, or perhaps no warnings at
all under the `-Wall -Wextra -pedantic` mode, then by all means brag about it in
your `remarks.md` file **AND BE SURE TO TELL US** the OS, OS version, compiler
and compiler version in which you observed this occurring (in case our OS and
compiler produces a different result: so your submission won't be penalized for
not meeting your claims).

On the other hand, some warnings cannot be disabled and are enabled by compilers
without any warning option specified. These are sometimes inevitable in
obfuscated code and even in some non-obfuscated code, and you should not worry
about this, though it might be worth pointing out.

For instance, some compilers like to warn about use of pointers as arrays, which seems to
be dubious, as it obviously can't (always) be avoided, being a big part of C, so
you should not worry about this either; this is the warning
`-Wunsafe-buffer-usage` and the way to disable it is `-Wno-unsafe-buffer-usage`.
See also the
FAQ on "[forced warnings](../faq.html#forced_warnings)"
and the
FAQ on "[-Weverything](../faq.html#weverything)".

<div id="disabling-warnings">
## Disabling warnings
</div>

<p class="leftbar">
If you do have to disable warnings due to `-Weverything` automatically being
included, you might wish to state this fact in your `remarks.md` file.
And even without `-Weverything` there can be warnings, as noted above.
</p>

If your submission issues lots of warnings but is otherwise
marvelously obfuscated in multiple levels, don't worry about it.  Nevertheless,
be sure that the warnings do not constitute a potential "**show stopper**"
compiler problem.  Be sure that compilers such as both `gcc` and `clang` won't
produce a compiler **error** and refuse to compile your code: unless for some
reason that is what you intend to happen in which case document that too in your
`remarks.md` file.  :-)

All other things being equal, a program that must turn off fewer
warnings will be considered better, for certain values of better.

To turn off a compiler warning, in your submission's `Makefile`,
try something such as:

``` <!---make-->
    CSILENCE= -Wno-some-thing -Wno-another-thing
```

<p class="leftbar">
For instance:
</p>

``` <!---make-->
    CSILENCE= -Wno-parentheses -Wno-binding-in-condition -Wno-misleading-indentation
```

<div id="macros">
## Defining macros in the Makefile
</div>

If you need to define something on the compile line, use
the `CDEFINE` Makefile variable.  For example:

``` <!---make-->
    CDEFINE= -Dfoo -Dbar=baz
```

**NOTE**: just because we offer a default way to use the `-D` option, we still
do not like excess use of `-D` to get past size limits, especially since you
could use `#define` in your code instead.

<div id="include">
## Include files in the Makefile
</div>

If you need to include a file (as in `#include`) on the command line, use the
`CINCLUDE` Makefile variable.  For example:

``` <!---make-->
    CINCLUDE= -include stdio.h
```


<div id="magic">
## Magic in the Makefile
</div>

If you need to add other "**magic**" flags to your compile line,
use the `COTHER` Makefile variable.  For example:

``` <!---make-->
    COTHER= -fno-math-errno
```

**NOTE**: **We only recommend using "_magic_" flags if _BOTH_ `gcc`
_and_ `clang`** support it.

Again, please note that in macOS, `/usr/bin/gcc` is actually `clang`!


<div id="clobber">
## The clobber rule
</div>

When `make clobber` is invoked, we request that submissions be restored
to their original submission state.  For example, any temporary files
(**including** the compiled program(s)) created during the build process, or
during execution should be removed by the `clobber` rule. In other words, the
only things that should be in the directory after running `make clobber` is what
is in your submission tarball itself.

While people are free to manage their submission under `git(1)` or even use a
GitHub repo, dot-files and dot-directories such as `.git` are not allowed in a
submission.

The `mkiocccentry(1)` tool will ignore dot-files and dot-directories (such as
`.vimrc`, `.bashrc`, `.git` and `.github`) and not put them in the submission's
compressed tarball. So while you may use such files and
directories to help develop your submission, they won't be included when you run
the `mkiocccentry(1)` tool.

Even if you did manage to get dot files or dot directories in the tarball
somehow, `txzchk(1)` will flag it as an error. When the judges run `txzchk(1)`
on the uploaded submission compressed tarball, if anything is wrong, for
instance if you "sneak in" any dot files or dot directories, the submission
**WILL BE REJECTED** for violating
[Rule 17 Packaging](rules.html#rule-17-packaging)!

You may use whatever tools you need to develop your submission, including the
use of `git(1)` or `gh(1)`, just be sure that your submission code and your
submission Makefile don't depend on such tools.

Of course if you do use GitHub to work on your submission, you might want to
make the repo private so you don't reveal who you are. :-)

<p class="leftbar">
In other words, make **SURE** you keep anonymous who submitted the code!
</p>

<p class="leftbar">
Please do **NOT** use these tools to help with the
`clobber` rule! For instance, do **NOT** use `git clean`! Not only does this
depend on the user having `git(1)` but it also does not account for the
submission tarballs. Even worse is when someone does have it in a `git(1)` repo
it will remove files that are not under `git(1)` control! Instead, see the
`clobber` rule in the example Makefile to see how to manage this.
</p>

In other words, for `make clobber`, do something like:


``` <!---makefile-->
    clobber:
            ${RM} -f foo bar baz
```

and **NOT** something like this:

``` <!---makefile-->
    # do NOT do this!
    clobber:
            -git clean -f   # WRONG !!!
```

And do **NOT** use `git` for any other `Makefile` rule either.


**NOTE**: `mkiocccentry(1)` will directly run `make clobber` in the submission
directory. And although it is not an error if this fails, if it fails because the
Makefile does not have a clobber rule, it will be flagged by `mkiocccentry(1)`
(you may ignore this but it does put you at a risk of violating the rules).


Jump to: [top](#)


<div id="likes">
<div id="dislikes">
# OUR LIKES AND DISLIKES:
</div>
</div>

We **VERY MUCH LIKE** submissions that use an edited variant of the
example Makefile, as described and linked to in the [Makefile section](#makefile),
renamed as `Makefile` of course.  This makes it easier for the [IOCCC judges](../judges.html)
to test your submission. And if your submissions wins, it makes it easier to integrate it into
the [Official IOCCC winner website](https://www.ioccc.org/index.html).

We **VERY MUCH LIKE** submissions that have some educational value. This does **NOT** mean
that your submission should not be obfuscated but rather that the IOCCC has moved away from
the idea of "spoilers". You should not encrypt or rot13 content in your `remarks.md` file.

It is **VERY MUCH** appreciated if your remarks have some educational
value. And although educational value is not required, it is an
**EXCELLENT** bonus.


We **LIKE** submissions that use an edited version of the
`try.sh` example script (and if you have alternate code,
the same applies with the `try.alt.sh` script):

- [view example try.sh](%%REPO_URL%%/next/try.sh)
- <a href="try.sh">download example try.sh</a>

- [view example try.alt.sh](%%REPO_URL%%/next/try.alt.sh)
- <a href="try.alt.sh">download example try.alt.sh</a>

Of course, it is quite possible that only one invocation is
possible, so it is not necessarily detrimental to your submission if you do not
include one, though we do like interesting and creative uses of submissions. See
also the
FAQ on "[submitting try.sh and try.alt.sh scripts](../faq.html#try_scripts)".

<p class="leftbar">
Even if it only has one invocation we still **LIKE** the try scripts.
</p>

<p class="leftbar">
If you do include a `try.sh` then **PLEASE** remove the `try` rule in the
Makefile.
</p>

<p class="leftbar">
If you do include a `try.alt.sh` then **PLEASE** remove the `try.alt` rule in
the Makefile.
</p>

<p class="leftbar">
If you don't have a prog.alt.c, then **PLEASE** remove the `try.alt` rule as
well.
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

In other words, it is a compilation error, and in order to get older
IOCCC winning entries that did this to compile, we had to update them to not do this.

When declaring local or global variables, you should declare the type:

``` <!---c-->
    int this_is_fine;
    this_is_not;       /* <-- Try to avoid implicit type declarations */
```

We tend to **like _less_** a submission that requires either
`gcc` **OR** `clang`.  **We _prefer_ submissions** that can compile
under **BOTH** `gcc` **AND** `clang`. **Hint!**

We **RECOMMEND** that the compiler flags you use in your
submission's `Makefile` are supported by **BOTH** `gcc` **AND** `clang`.

We **DISLIKE** the use of obscure compiler flags, especially
if `gcc` and/or `clang` do not support it.  We **suggest**
that you not use any really obscure compiler flags if you can help it.

One side effect of the above is that you cannot assume the use
of nested functions such as:

``` <!---c-->
     int main() {
|        void please_dont_submit_this() {
|           printf("The machine that goes BING!!\n");
         }
|        please_dont_submit_this();
     }
```

On 2012 July 20, the [IOCCC judges](../judges.html) rescinded the encouragement of
nested functions.  Such constructions, while interesting and sometimes
amusing, will have to wait until they are required by a C standard that are
actually implemented in **BOTH** `gcc` **AND** `clang`.

We **DISLIKE** submissions that require the use of `-fnested-functions`.

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

In particular, do not treat `va_list` variables as if they were a `char **`.

We **DISLIKE** the use of `varargs.h`.  Use `stdarg.h` instead.

We **DISLIKE** the use of `gets(3)`.  Use `fgets(3)` instead.

We tend to **DISLIKE** the blatant use of tarballs in an attempt to simply get
around the extra file number limit. We realize there may be cases where a
tarball containing a number of extra files may be needed. Such a need for a
tarball **MUST** be explained in the `remarks.md` file.

<p class="leftbar">
Using a mass of `goto`s to obfuscate your code has become 'old' and is unlikely
to make it through the final rounds, if it even gets that far.
</p>

On 28 January 2007, the Judges rescinded the requirement that the
`#` in a C preprocessor directive must be the 1st non-whitespace byte.

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

While those who are used to temperatures found on [dwarf
planets](https://science.nasa.gov/dwarf-planets/)
(**yes Virginia, dwarf planets _ARE_ planets!**), such as
[Pluto](https://science.nasa.gov/dwarf-planets/pluto/), might be able to
explain to the Walrus why our seas are boiling hot, the question of
whether pigs have wings is likely to remain a debatable point to most.

One line programs should be short one line programs: say around **80** to **132**
bytes long.  Going well beyond **132** bytes is a bit too long to be called
a one-liner in our vague opinion.

We tend to **DISLIKE** programs that:

* are very hardware specific
* are very OS version specific (`index(3)`/`strchr(3)` differences are OK, but
sockets/streams specific code is likely not to be)
* dump core or have compiler warnings (it is OK only if
you warn us in your `remarks.md` file)
* won't compile or run in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environment
* depend on a utility or application not normally found
in systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
* abuse the build file to get around the size limit
* obfuscate by use of ANSI trigraphs
* obfuscate by use of digraphs
* are larger than they need to be
* have more lines than they need to have
* are "blob-ier" (just a pile of unformatted C code) than they need to be
* are rather similar to **[previous winners](../years.html)** :-(
* are **identical** to **[previous losers](https://en.wikipedia.org/wiki/Null_device)** :-)
* that mandate the exclusive use of a specific Integrated Development Environment (IDE)

In order to encourage submission portability, we **DISLIKE** submissions that
fail to build unless one is using an IDE. For example, do not
mandate that one must use Microsoft Visual Studio to compile
your submission.

The program must compile and link cleanly in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environment. Therefore do not assume the system has a
[windows.h](https://en.wikipedia.org/wiki/Windows.h) include file:


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
after the minute mark is **60**.

The `Makefile` should not be used to try and get around the size limit.  It is
one thing to make use of a several `-D`s on the compile line to help out, but it
is quite another to use many bytes of `-D`s in order to try and squeeze the
source under the size limit.

Your source code, post-pre-processing, should not exceed the size of
[Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows). :-)

Other windows, on the other hand, might be OK: especially where "**X
marks the spot**".  Yet on the third hand, windows are best when they are
"unseen" (i.e., not dirty).  :-)

The [IOCCC judges](../judges.html), as a group, have a history giving wide degree of latitude
to reasonable submissions.  And recently they have had as much longitudinal
variation as it is possible to have on [Earth](https://science.nasa.gov/earth/).  :-)

You should try to restrict commands used in the build file to commands found in
[Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).

You may compile and use your own programs.  If you do, try to build and execute
from the current directory.  This restriction is not a hard and
absolute one.  The intent is to ensure that the building of your
program is reasonably portable.

We prefer programs that are portable across a wide variety of UNIX-like
operating systems (e.g., Linux, GNU Hurd, BSD, UNIX, etc.).

> You are in a maze of twisty _guidelines_, all different.

There are at least zero [IOCCC judges](../judges.html) who think that
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

and then include special notes in your `remarks.md` file for
alternate / human intervention based building.

We want to get away from source that is simply a compact blob of
bytes.   **REALLY TRY** to be more creative than blob coding. **HINT!**

Please do not use things like `gzip(1)` to get around the size limit.
Please try to be much more creative.

We really **DISLIKE** submissions that make blatant use of including
large data files to get around the source code size limit.

<p class="leftbar">
We do not recommend submitting [systemd](https://systemd.io) source code to the IOCCC,
if nothing else because that code is likely to exceed
[Rule 2 Size](rules.html#rule-2-size).
This isn't to say that another highly compact and obfuscated
replacement of `init(8)` would not be an interesting submission.
</p>

Did we remember to indicate that programs that blatantly use
some complex state machine to do something simple, are boring?
We think we did.  :-)

> All generalizations are false, including this one. -- **Mark Twain**

Given two versions of the same program, one that is a compact blob
of code, and the other that is formatted more like a typical C
program, we tend to favor the second version.  Of course, a third
version of the same program that is formatted in an interesting
and/or obfuscated way, would definitely win over the first two!
Remember, you can submit more than one submission.  See the
[IOCCC rules](rules.html)
for details (in particular,
[Rule 8 Submission](rules.html#rule-8-submission)).

We suggest that you avoid trying for the '**smallest self-replicating**'
source.  The smallest, a [zero byte entry](../1994/smr/index.html), won in
[1994](../years.html#1994).

Programs that claim to be the smallest C source that does something, really
better be the smallest such program or they risk being rejected because
they do not work as documented.

Please note that the C source below, besides lacking in obfuscation,
is **NOT** the smallest C source file that when compiled and run, dumps core:

``` <!---c-->
    main;
```

Unless you specify `-fwritable-strings` (see `COTHER` in the example
Makefile, described in the [Makefile section](#makefile)), do not assume this
sort of code will work:

``` <!---c-->
    char *T = "So many primes, so little time!";
    ...
    T[14] = ';';    /* modifying a string requires: -fwritable-strings */
```

Even so, one should probably not assume that this is universally accepted.

Initialized char arrays are OK to write over.  For instance, this is OK:

``` <!---c-->
    char b[] = "Is this OK";
    b[9] = 'k';     /* modifying an initialized char array is OK */
```

There are more than 1 typos in this very sentence.

X client submissions should be as portable as possible.  Submissions that
adapt to a wide collection of environments will be favored.  For
example, don't depend on a particular type or size of display.
Don't assume the use of a particular browser.  Instead assume a
generic browser that forms to a widely used [W3C
standard](https://www.w3.org/standards/).
Don't assume a particular sound sub-system or video driver is installed
in the OS. Instead, make use of a well known and widely available open
source program (one that actually works) to display audio/visual data.

X client submissions should avoid using X related libraries and
software that are not in wide spread use.

As of Red Hat RHEL9.0, the X.org server is deprecated. See the
FAQ on "[Xorg deprecation"](../faq.html#Xorg_deprecated)"
for more details. This does not mean that a submission using this will
necessarily be rejected, but it would be better if it can support Wayland in
some way or another.

This could be the only _guideline_ that contains the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin).

However, do you know how to play [fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin)?
You do?!?  (Except on Tuesday?)

OK, there are actually 2 _guidelines_ that contain the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin),
unless you count this one, in which case there are 3. :-)

We **DISLIKE** submissions that use proprietary toolkits such as the `M*tif`,
`Xv*ew`, or `OpenL*ok` toolkits, since not everyone has them.  Use an
open source toolkit that is widely and freely available instead.

**NOTE**: The previous _guideline_ in this spot has been replaced by this _guideline_:

X client submissions should try to not to depend on particular items in
`.Xdefaults`.  If you must do so, be sure to note the required lines
in the your `remarks.md` file.  They should also not depend on any
particular window manager.

Try to avoid submissions that play music that some people believe is copyrighted
music.

While we recognize that UNIX is not a universal operating system, the contest
does have a bias towards such systems.  In an effort to expand the scope of the
contest, we phrase our bias to favor the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).

You are **well advised** to submit code that conforms to the [Single UNIX
Specification Version 4](https://unix.org/version4/overview.html).

To quote the [IOCCC judges](../judges.html):

> You very well might not be completely prohibited from failing to not partly
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

You are better off explaining what your submission does in your
`remarks.md` file section rather than leaving it obscure for the
[IOCCC judges](../judges.html) as we might miss something and/or be too tired to
notice.

Please avoid this specific individual _guideline_, if it at all possible.

We freely admit that interesting, creative or humorous comments in
your `remarks.md` file help your chances of winning.  If you had to
read so many twisted submissions, you too would enjoy a good laugh or two.
We think the readers of the contest winners do as well.  We do read
your `remarks.md` content during the judging process, so it is worth your
while to write a remarkable `remarks.md` file.

We **DISLIKE** C code with trailing control-M's (`\r` or `\015`) that results
in compilation failures.  Some non-UNIX/non-Linux tools such as
MS Visual C and MS Visual C++ leave trailing control-M's on lines.
Users of such tools should strip off such control-M's before submitting
their submissions.  In some cases tools have a "Save As" option that will
prevent such trailing control-M's being added.

One should restrict libcurses to portable features found on BSD
or Linux curses.

<p class="leftbar">
If you do `#include <curses.h>` make **CERTAIN** you link in curses (i.e.
`-lcurses`) and not ncurses (i.e. `-lncurses`).
</p>

[Rule 13 Newlines](rules.html#rule-13-newlines)
no longer discourages the use of UTF-8
characters in C code.

It is a very good idea to, in your `remarks.md` file, tell us why you
think your submission is obfuscated.  This is particularly true if
your submission has some very subtle obfuscations that we might
otherwise overlook.  **<<-- Hint!**

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

We prefer code that can run on either a 64-bit or 32-bit
processor.  However, it is **UNWISE **to assume it will run on an
some Intel-like x86 architecture**.

We believe that Mark Twain's quote:

> Get your facts first, then you can distort them as you please.

... is a good motto for those writing code for the IOCCC.

The IOCCC size tool source is not an original work, unless you are [Anthony C
Howe](../authors.html#Anthony_C_Howe), in which case it is original!  :-)
Submitting source code that uses the contents of
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c),
_unless_ you are [Anthony C Howe](../authors.html#Anthony_C_Howe), might run the
risk of violating
[Rule 7 Original Work](rules.html#rule-7-original-work).

The IOCCC submission tarball validator source is not an original work,
unless you are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson), in
which case it is original!  :-) Submitting source code that uses the contents of
[txzchk.c](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c),
_unless_ you are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson), might
run the risk of violating
[Rule 7 Original Work](rules.html#rule-7-original-work).

In addition to the above tools, none of the [mkiocccentry
tools](https://github.com/ioccc-src/mkiocccentry), _including, **but not
limited**_ to
[mkiocccentry](https://github.com/ioccc-src/mkiocccentry/blob/master/mkiocccentry.c),
[chksubmit](https://github.com/ioccc-src/mkiocccentry/blob/master/chksubmit.c),
[chksubmit](https://github.com/ioccc-src/mkiocccentry/blob/master/chksubmit.c),
[fnamchk](https://github.com/ioccc-src/mkiocccentry/blob/master/test_ioccc/fnamchk.c)
and
[location](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/location_main.c),
nor the [JSON parser and
library](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/README.md),
[jstrencode](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jstrencode.c),
[jstrdecode](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/jstrdecode.c)
or any of the other [jparse
tools](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse)
(see the [jparse repo](https://github.com/xexyl/jparse/)), are original works,
unless you are [Cody Boone Ferguson](../authors.html#Cody_Boone_Ferguson) or
[Landon Curt Noll](http://www.isthe.com/chongo/index.html), in which case they
are original!  :-) Submitting source code that uses the content of any of these tools or
library, _unless_ you are [Cody Boone
Ferguson](../authors.html#Cody_Boone_Ferguson) or [Landon Curt
Noll](http://www.isthe.com/chongo/index.html), might run the risk of violating
[Rule 7 Original Work](rules.html#rule-7-original-work).

And unless you are [Landon Curt Noll](https://en.wikipedia.org/wiki/Landon_Curt_Noll),
the code in
[dbg](https://github.com/ioccc-src/mkiocccentry/tree/master/dbg) and
[dyn_array](https://github.com/ioccc-src/mkiocccentry/tree/master/dyn_array) are
not original works. Submitting source code that uses the contents of those
libraries, _unless_ you [Landon Curt Noll](https://en.wikipedia.org/wiki/Landon_Curt_Noll),
might run the risk of violating
[Rule 7 Original Work](rules.html#rule-7-original-work).

[Rule 7 Original Work](rules.html#rule-7-original-work)
does not prohibit you from writing your own
obfuscated versions of these tools, unless of course you are [Landon Curt
Noll](http://www.isthe.com/chongo/index.html), in which case you _probably_
won't win since [IOCCC judges](../judges.html) should not enter the IOCCC! :-)
However, **_if_** you do write your own version, you **_might_** wish to make it do something
**_more_ interesting** than simply implementing the [IOCCC](../index.html)
tools' algorithms.

Even so, we do not recommend you try and submit a JSON parser due to
the fact it will likely exceed
[Rule 2 Size](rules.html#rule-2-size)
and because you likely can't beat [flex](https://github.com/westes/flex) and
[bison](https://www.gnu.org/software/bison/) in obfuscation. This isn't to
say that [the so-called JSON spec](https://github.com/xexyl/jparse/blob/master/json_README.md#so-called-json-spec) is not
obfuscated, but unless you have some really clever way to compact and
obfuscate a JSON parser more than [flex](https://github.com/westes/flex) and
[bison](https://www.gnu.org/software/bison/) you will likely not win, either
because of the
[Rule 2 Size](rules.html#rule-2-size)
or because it is not
as obfuscated as the [flex](https://github.com/westes/flex) and [bison](https://www.gnu.org/software/bison/)
generated code of
[jparse](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse).

While programs that only run in a specific word size are OK, if you have
to pick, choose a 64-bit word size.

If the [IOCCC judges](../judges.html) are feeling ornery we
might choose to compile your program for running on an Arduino or
a PDP-11.  Heck, should we ever find an emulator of 60-bit CDC Cyber
CPU, we might just try your submission on that emulator as well :-)

If your submission **MUST** run only on a 64-bit or 32-bit architecture,
then you **MUST** specify the `-arch` on your command line
(see `ARCH` in the example
Makefile, described in [Makefile section](#makefile)).  Do not assume a
processor word size without specifying `-arch`.  For example:

``` <!---make-->
    ARCH= -m64
```

Note, however, that some platforms will not necessarily support some
architectures. For instance, more recent versions of `macOS` do **NOT** support
32-bit!

If there are limitations in your submission, you are highly encouraged
to note such limitations in your `remarks.md` file.  For example if your
submission factors values up to a certain size, you might want to state:

>   This submission factors values up `2305567963945518424753102147331756070`.
Attempting to factor larger values will produce unpredictable results.

The [IOCCC judges](../judges.html) might try to factor the value -5, so you want to might state:

>   This submission factors positive values up
`2305567963945518424753102147331756070`. Attempting to factor large values will
produce unpredictable results.

However the [IOCCC judges](../judges.html) might try to also factor 0, so you want to might state:

>   This submission factors values between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor values outside
that range will produce unpredictable results.

Moreover they might try to also factor 3.5 or 0x7, or Fred, so you want to might state:

>   This submission factors integers between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor anything else
will produce unpredictable results.

You submission might be better off catching the attempt to factor bogus values
and doing something interesting.  So you might want to code accordingly and state:

>   This submission factors integers between 1 and `2305567963945518424753102147331756070`.
>   Attempting to factor anything else will cause the program to insult your pet fish Eric.

The [IOCCC judges](../judges.html) might not have a pet fish named Eric, so you might want to state:

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

Do not fear if you're not 100% sure of the significance of
`2305567963945518424753102147331756070` as it is not of prime importance: or is
it?  :-)

We **DISLIKE** the use of ASCII tab characters in markdown files, such as in the required `remarks.md` file.

We don't mind the use of ASCII tab characters in your C code.  Feel free
to use ASCII tab characters if that suits your obfuscation needs.  If is
perfectly **OK** to use tab characters elsewhere in your submission, just not in
markdown files as this tends annoy us when it comes time to
rendering your markdown content as it complicates the process.

If you do use ASCII tab characters in your non-markdown files, be
aware that some people may use a tab stop that is different than the common 8
character tab stop.

**PLEASE** observe our [IOCCC markdown guidelines](../markdown.html)
when forming your submission's `remarks.md` file.  And if your submission
contains additional markdown files, please follow those same guidelines for
those files. See also
[Rule 4 Files](rules.html#rule-4-files),
and the
FAQ on "[markdown](../faq.html#markdown)".

We **LIKE** reading `remarks.md` files, especially if they contain
useful, informative, and even humorous content about your submission.  Yes, this
is a **hint**.  :-)

We **RECOMMEND** you put a reasonable amount effort into the content of the
`remarks.md` file: it is a required file for a reason.  :-)

Try to be even more creative!


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
submissions, regardless of if they receive an award, result in changes to
the next year's [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html).

Legal abuse of the [IOCCC rules](rules.html) is **NOT** an invitation to violate the
[IOCCC rules](rules.html). A submission that violates the [rules](rules.html) in the
opinion of the [IOCCC judges](../judges.html), **WILL** be
disqualified.  **_RULE ABUSE CARRIES A CERTAIN LEVEL OF RISK!_**  If you
have a submission that might otherwise be interesting, you might want to
submit two versions; one that does not abuse the [IOCCC rules](rules.html) and one that
does.

If you intend to abuse the [IOCCC rules](rules.html),
indicate so in your `remarks.md` file.  You **MUST** try to justify
why you consider your rule abuse to be allowed under the
[IOCCC rules](rules.html).  That is, you must plead your case as to why
your submission is valid.  Humor and/or creativity help plead a case.
As there is no guarantee that you will succeed, you might consider
submitting an alternate version that conforms to the
[IOCCC rules](rules.html).

If you do bypass the `mkiocccentry(1)` warnings about
[Rule 2a Gross Size](rules.html#rule-2a-gross-size)
and/or about
[Rule 2b Next Size](rules.html#rule-2b-net-size)
or any other
rule and submit a submission anyway, you **MUST** try to justify why the IOCCC
[IOCCC judges](../judges.html) should not reject your submission due to a rule
violation, and you would be wise to do this towards the top of your `remarks.md`
file.

Abusing the web submission procedure tends to annoy us more
than amuse us.  Spend your creative energy on content of your
submission rather than on the submission process itself.

We are often asked why the contest [IOCCC rules](rules.html) and [IOCCC
guidelines](guidelines.html) seem strange or contain mistakes, flaws or
grammatical errors.  One reason is that we sometimes make genuine mistakes.  But
in many cases such problems, flaws or areas of confusion are deliberate.
Changes to [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) in
response to rule abuses, are done in a minimal fashion.  Often we will
deliberately leave behind holes (or introduce new ones) so that future rule
abuse can continue.  A clever author should be able to read them and "drive a
truck through the holes" in the [IOCCC rules](rules.html) and [IOCCC
guidelines](guidelines.html).

At the risk of stating the obvious, this contest is a parody of the software
development process.  The [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html)
are only part of the overall contest.  Even so, one might think the
contest [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) process as a parody
of the sometimes tragic mismatch between what a customer (or marketing) wants
and what engineering delivers.  Real programmers must face obfuscated and
sometimes conflicting specifications and requirements from marketing, sales,
product management and even from customers themselves on an all too regular basis.
This is one of the reasons why the [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) are written in obfuscated form.


Jump to: [top](#)


<div id="judging">
# JUDGING PROCESS:
</div>

Submissions are judged by Leonid A. Broukhis and Landon Curt Noll.

Each submission submitted is given a random string and subdirectory.  The
submission files including, but not limited to `prog.c`, `Makefile`,
`remarks.md`, `.info.json`, `.auth.json` as well as any data files that you
submit, are all placed under their own directory and stored and judged from this
directory.

Any information about the authors is not read by the [IOCCC judges](../judges.html) until
the judging process is complete, and then only from entries that have
won an award.  Because we do not read this information for entries that
do not win, we do not know who did not win.

The above process helps keep us biased for/against any one particular
individual.  Therefore you **MUST** refrain from putting any information
that reveals your identity in your submission.

Now some people point out that coding and/or writing style might reveal the
information about the authors.  However we consider this to be simply
circumstantial and outside the scope of the above paragraph.

Some people, in the past, have attempted to obfuscate their identity by
including comments of famous Internet personalities such as [Peter
Honeyman](http://www.citi.umich.edu/u/honey).  The [IOCCC judges](../judges.html) are on to this trick
and therefore consider any obfuscated source or data file claiming to be from
Honeyman to not be from Honeyman.  This of course creates an interesting paradox
known as the "**obfuscated Peter Honeyman paradox**".  Should Peter Honeyman
actually submit to the IOCCC, he alone is excluded from the above, as we
will likely believe it's just another attempt at confusion.  This _guideline_ is
known as the "**Peter Honeyman is exempt**" _guideline_.

**BTW**: None of the submissions claiming to be from Peter Honeyman have ever
won an award.  So it is theoretically possible that Peter Honeyman
did submit to the IOCCC in the past.  In the past, Peter had denied
submitting anything to the IOCCC.  Perhaps those submissions were
submitted by one of his students?

Hopefully we are **VERY CLEAR** on this point!  The rules now strongly state:
**PLEASE _DO NOT_ put a name of an author**, in an obvious way, into your
source code, `remarks.md`, data files, etc., the above "**Peter Honeyman is
exempt**" notwithstanding.

We seemed to have digressed again ... :-)  Returning to the judging process:

We prefer to be kept in the dark as much as you are until the final
awards are given.  We enjoy the surprise of finding out in the end,
who won and where they are from.

We attempt to keep all submissions anonymous, unless they win an award.
Because the main 'prize' of winning is being announced, we make all
attempts to send non-winners into oblivion.  We remove all non-winning
files, and shred all related printouts.  By tradition, we do not even
reveal the number of submissions that we receive.

During the judging process, a process that spans multiple sessions over
a few weeks, we post general updates from our [Mastodon
account](https://fosstodon.org/@ioccc).

**Make sure you reload the feed** every so often **because unless you
are mentioned you will NOT get a push notification!**


Jump to: [top](#)


<div id="rounds">
## JUDGING ROUNDS:
</div>

Judging consists of a number of elimination rounds.  During a round,
the collection of submissions are divided into two roughly equal piles;
the pile that advances on to the next round, and the pile that does
not.  We also re-examine the submissions that were eliminated in the
previous round.  Thus, a submission gets at least two readings and
often more than two.


Jump to: [top](#)


<div id="readings">
## JUDGING READINGS:
</div>

A reading consists of a number of actions:

* Reading `prog.c`, the C source and reviewing the `remarks.md` information
* Briefly looking at any supplied data files
* Passing the source thru the C pre-processor skipping over any `#include`d files
* Performing a number of C beautify/cleanup edits on the source
* Passing the beautified source thru the C pre-processor skipping over any `#include`d files
* Compiling/building the source
* Running the program
* Doing other things that only [IOCCC judges](../judges.html) know about :-)

In later rounds, other actions are performed including performing
miscellaneous tests on the source and binary.

This is the very **guideline** that goes, **BING!**

Okay, technically that was the _second_ **guideline** that goes **BING**, and this
is the third. :-)

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
* **best X program** (see [OUR LIKES AND DISLIKES](#likes) and the FAQ on "[Xorg
being deprecated](../faq.html#Xorg_deprecated)")
* **best abuse of ISO C or ANSI C standard** (see above about compilers)
* **best abuse of the C preprocessor**
* **worst/best abuse of the rules** (or some variation)
* (anything else so strange that it deserves an award)

We do not limit ourselves to this list.  For example, a few submissions are so
good/bad that they are declared winners at the start of the final round.
We will invent awards categories for them, if necessary.

In the final round process, we perform the difficult tasks of
reducing the remaining submissions (typically about 25) down to to about
half that number: declaring those remaining to be winners.

Often we are confident that the submissions that make it into
the final round are definitely better than the ones that do not
make it.  The selection of the winners out of the final round, is
less clear cut, however.

Sometimes a final round submission is good enough to win, but is beat out by a
similar, but slightly better submission.  For this reason, it is sometimes
worthwhile to resubmit an improved version of a submission that failed to win in
a previous year, the next year.  This assumes, of course, that the submission is
worth improving in the first place!

Over the years, more than one [IOCCC judge](../judges.html)
has been known to **bribe** another [IOCCC judge](../judges.html) into voting for a
winning submissions by offering a bit of high quality chocolate, or
other fun item.

<p class="leftbar">
Over the years some judges have submitted code that had to be rejected once it
was discovered to be a judge.
</p>

One **should NOT** attempt to **bribe** an [IOCCC
judge](../judges.html), **unless you are an [IOCCC judge](../judges.html)**,
because **bribing** an [IOCCC judge](../judges.html) by a non-judge
has been shown to **NOT** be effective when the **person _attempting_
the _bribe_ is made known** to the [IOCCC judges](../judges.html)
(i.e., they are not anonymous) AND/OR the **bribe** is otherwise
associated with a submission to the [IOCCC](../index.html).

With the previous guideline in mind: **anonymous** gifts
for the [IOCCC judges](../judges.html) that are **NOT ASSOCIATED
WITH** a submission to the [IOCCC](../index.html) may be sent to the
[IOCCC judges](../judges.html) via the
[IOCCC Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/3HSNTEL8RQ1M0?ref_=wl_share).
It has been shown that receiving  **anonymous** gifts provides the
[IOCCC judges](../judges.html) with a nice
[dopamine](https://en.wikipedia.org/wiki/Dopamine) boost, and happy
[IOCCC judges](../judges.html) help make the [IOCCC](../index.html) better for everyone. :-)

See the
FAQ on "[supporting the IOCCC](../faq.html#support)".

More often than not, we select a small submission (usually one line) and a
strange/creative layout submission.  We sometimes also select a
submission that abuses the [IOCCC guidelines](guidelines.html) in an interesting way,
or that stretches the contest [rules](rules.html) that while legal, it
nevertheless goes against the **intent** of the [rules](rules.html).

Nevertheless, see
[Rule 10 Privileges](rules.html#rule-10-privileges).


In the end, we traditionally pick one submission as '**best**'.  Sometimes such
a submission simply far exceeds any of the other submissions.  More often, the
'**best**' is picked because it does well in a number of categories.

In years past, we renamed the winning submission from `prog.c` to a
name related to the author(s)' names.  This is no longer done.
Winning source is called `prog.c`. A compiled binary is called `prog`.


Jump to: [top](#)


<div id="announcements">
# ANNOUNCEMENT OF WINNERS:
</div>

The [IOCCC judges](../judges.html) will toot initial announcement of who won, the name
of their award, and a very brief description (award title) of the winning entry
from the [@IOCCC Mastodon account](https://fosstodon.org/@ioccc).

We recommend that you follow us on mastodon but **please make sure to
refresh the feed** every so often (if not more often) because unless you are
mentioned or someone boosts your post you will not get a push notification.


Jump to: [top](#)


<div id="winners">
## How the new IOCCC winners will be announced
</div>

The [current status of the IOCCC](../status.html) will change from
**[judging](../faq.html#judging)** to **[closed](../faq.html#closed)** .

The **contest_status** in the [status.json](../status.json) file will change
from **judging** to **closed** as well.

When the above happens, the winning entries have been selected by the [IOCCC
judges](../judges.html).

The [IOCCC judges](../judges.html) will begin to prepare to release the source
code of the new IOCCC winners.

The [IOCCC judges](../judges.html) will commit the winning source to the
[IOCCC winner repo](https://github.com/ioccc-src/winner) which will update the
[Official IOCCC website](https://www.ioccc.org/index.html).

The [IOCCC news](../news.html) will also contain an announcement of the winners.


Jump to: [top](#)


<div id="mastodon">
## An important update to how winners are announced
</div>

<p class="leftbar">
The IOCCC no longer uses twitter.  Winning IOCCC entries will be announced by a
`git` commit to the [IOCCC entries repo](https://github.com/ioccc-src/winner)
that, in turn, updates the [Official IOCCC
website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
In addition a note is posted to the [IOCCC Mastodon account](https://fosstodon.org/@ioccc).
</p>

<p class="leftbar">
We will also post a notice to the IOCCC discord server.
</p>

Consider joining the IOCCC discord community via this link:
[https://discord.gg/Wa42Qujwnw](https://discord.gg/Wa42Qujwnw)


Jump to: [top](#)


<div id="entries">
## Back to announcement of winners
</div>

It is pointless to ask the [IOCCC judges](../judges.html) how many
submissions we receive.  See [How many submissions do the judges receive for a
given IOCCC?](../faq.html#how_many).

Often, winning entries are published in selected magazines from around the
world.  Winners have appeared in books ('`The New Hacker's Dictionary`',
'`Obfuscated C and Other Mysteries`', '`Pointers On C`', others) and on t-shirts
(sometimes by the author(s) themselves).  There have been multiple classes
that have focused in part, on IOCCC winning entries.  And more than one winner has been turned
into a tattoo!

Last, but not least, [winners](../authors.html) receive international fame and flames!  :-)


Jump to: [top](#)


<div id="more-information">
<div id="information">
# FOR MORE INFORMATION:
</div>
</div>

For questions or comments about the contest, see [Contacting the IOCCC](../contact.html).

**Be SURE** to review the [IOCCC Rules and Guidelines](index.html) as they
may (and **often do**) change from year to year.

**PLEASE** be sure you have the current [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting to the contest.

See the [Official IOCCC website news](../news.html) for additional information.

For the updates and breaking IOCCC news, you are encouraged to follow
the [IOCCC on Mastodon](https://fosstodon.org/@ioccc).  See our
FAQ on "[Mastodon](../faq.html#try_mastodon)"
for more information. Please do note that unless
you are mentioned by us you will **NOT** get a notification from the app _so you
should refresh the page **even if you do follow us**_.

Check out the [Official IOCCC winner website](https://www.ioccc.org/index.html) in general.

Consider joining the IOCCC discord community via this link:
[https://discord.gg/Wa42Qujwnw](https://discord.gg/Wa42Qujwnw)

See the
FAQs on "[obtaining, compiling, installing and using the mkiocccentry tools](../faq.html#mkiocccentry)"
and the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)"
as that FAQ has important details on
[how to register](../next/register.html)
as well as
[how to upload your submission](../next/submit.html) for the IOCCC.


<hr style="width:10%;text-align:left;margin-left:0">


Jump to: [top](#)
