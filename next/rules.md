<!-- START: this line starts content from: inc/rules.closed.hdr -->

# WARNING: These rules are OUT OF DATE

These rules are a **VERY TENTATIVE proposal** for the next IOCCC
and are **VERY LIKELY** to be updated before the next IOCCC.
They are are provided as a **VERY TENTATIVE** hint at **what
MIGHT** be used in the next IOCCC.  In some cases they might
even be a copy of the rules from the previous IOCCC.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[about asking questions](../faq.html#question)"
about these rules. You might also find the
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

<!-- END: the next line ends content from: inc/rules.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->
# 28th International Obfuscated C Code Contest Official Rules

<p class="leftbar">
Copyright &copy; 2024 Leonid A. Broukhis and Landon Curt Noll.
</p>

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing by [contacting the judges](../contact.html).

Jump to: [top](#)

<div id="rules_version">
<div id="version">
## IOCCC Rules version
</div>
</div>

Jump to: [top](#)

<p class="leftbar">
These [IOCCC rules](rules.html) are version **28.11 2024-12-01**.
</p>

**IMPORTANT**: Be sure to read the [IOCCC guidelines](guidelines.html).


Jump to: [top](#)

<div id="change_marks">
### Change marks
</div>

<p class="leftbar">
**&larr; Lines that start with this symbol indicate a change from the previous IOCCC**
</p>

Most lines (we sometimes make mistakes) that were modified since the previous
IOCCC start with a solid 4 pixel black left border (or, in the case of a code
block or blockquote, just a vertical bar).

Jump to: [top](#)

<div id="obfuscate">
# Obfuscate defined:
</div>

tr.v. -cated, -cating, -cates.
<br><br>
**1a.** To render obscure.<br>
**1b.** To darken.
<br><br>
**2.** To confuse: his emotions obfuscated his judgment.<br>
&nbsp;&nbsp;&nbsp;&nbsp;[LLat. obfuscare, to darken : ob(intensive) + Lat. fuscare,<br>
&nbsp;&nbsp;&nbsp;&nbsp;to darken &lt; fuscus, dark.] -obfuscation n. obfuscatory adj.

Jump to: [top](#)

<div id="goals">
# Goals of the Contest
</div>

The goals of the IOCCC:

*  To write the most Obscure/Obfuscated C program within the [IOCCC rules](rules.html).
*  To show the importance of programming style, in an ironic way.
*  To stress C compilers with unusual code.
*  To illustrate some of the subtleties of the C language.
*  To provide a safe forum for poor C code. :-)

Jump to: [top](#)

<div id="dates">
# Important IOCCC dates
</div>

<p class="leftbar">
This IOCCC runs from **2024-MMM-DD HH:MM:SS UTC** to **202x-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>

<p class="leftbar">
Until the start of this IOCCC, these [IOCCC rules](rules.html),
[IOCCC guidelines](guidelines.html) and the [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) should be considered
provisional **BETA** versions and **may be adjusted _AT ANY TIME_**.
</p>

When the IOCCC is open, the submission URL is:
[https://submit.ioccc.org](https://submit.ioccc.org); at all other
times that link is likely to be unresponsive.

Please review our
FAQ on "[how to submit](../faq.html#submit)"
for **important information** on how to submit to the IOCCC.

<p class="leftbar">
The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>

Please wait to submit your entries until after that time.

The official [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) will be
available on the [official IOCCC website](../index.html) on or slightly before
the start of this IOCCC. The `mkiocccentry` toolkit may be obtained at any time
at the [report mkiocccentry bugs](https://github.com/ioccc-src/mkiocccentry).

**IMPORTANT**: Please recheck on or after the start of this IOCCC to be sure you
are using the correct versions of these items _before using the IOCCC
submission URL_.

See the
FAQ on "[obtaining and compiling the mkiocccentry
tools](../faq.html#mkiocccentry)"
and the
FAQ on "[submitting to the IOCCC](../faq.html#submit)".

Jump to: [top](#)

<div id="rules">
# IOCCC RULES
</div>

To help us with the volume of submissions, we ask that you follow these rules:

Jump to: [top](#)

<div id="rule0">
## Rule 0
</div>

We need a [rule 0](#rule0).  :-)

Jump to: [top](#)

<div id="rule1">
## Rule 1
</div>

Your submission must be a complete program.

Jump to: [top](#)

<div id="rule2">
## Rule 2
</div>

The size rule requires your submission to satisfy **BOTH** [Rule 2a](#rule2a) and [Rule 2b](#rule2b):

Jump to: [top](#)

<div id="rule2a">
## Rule 2a
</div>

<p class="leftbar">
The size of your program source **should not exceed 4993 bytes**.
</p>

<p class="leftbar">
If you use the most recently released official IOCCC submission
packaging tool (hereby referred to as `mkiocccentry(1)`), which we **STRONGLY
recommend you do** (see also [Rule 17](#rule17)), then the `mkiocccentry(1)`
tool will warn you if there appears to be a [Rule 2a](#rule2a) violation.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will give you the option of overriding the [Rule 2a](#rule2a) warning.
Overriding a [Rule 2a](#rule2a) warning carries a **fair amount of risk that your submission
will be rejected**.  Be sure to consult the [IOCCC guidelines](guidelines.html)
ahead of time if you plan to override the [Rule 2a](#rule2a) warning.
</p>

<p class="leftbar">
If you do override the [Rule 2a](#rule2a) warning from the
`mkiocccentry(1)` tool, or otherwise plan to violate [Rule 2a](#rule2a), then
you **MUST CLEARLY EXPLAIN THE RATIONALE** of why you are doing so in your
`remarks.md` file.  **_Even if you do_ explain this in your `remarks.md` file your
submission may still be rejected**.
</p>

<p class="leftbar">
You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:
</p>

``` <!---sh-->
    ./iocccsize prog.c
```

Jump to: [top](#)

<div id="rule2b">
## Rule 2b
</div>

<p class="leftbar">
When the filename of your program source is given as a command line argument to the latest version
of the official IOCCC size tool (hereby referred to as `iocccsize(1)`), the
value printed **should NOT exceed _2503_**.
</p>

<p class="leftbar">
The source to `iocccsize(1)` may be found in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).
</p>

<p class="leftbar">
If you use the `mkiocccentry(1)` tool, which we **STRONGLY recommend
you do** (again, see also [Rule 17](#rule17)),
then `mkiocccentry(1)` will invoke `iocccsize(1)` before packaging your submission.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will give you the option of overriding the [Rule 2b](#rule2b) warning.
Overriding a [Rule 2b](#rule2b) warning carries a **fair amount of risk that your submission
will be rejected**.  Be sure to consult the [IOCCC guidelines](guidelines.html)
ahead of time if you plan to override the [Rule 2b](#rule2b) warning.
</p>

<p class="leftbar">
If you do override the [Rule 2b](#rule2b) warning from the `mkiocccentry(1)` tool,
or otherwise plan to violate [Rule 2a](#rule2b), then you **MUST CLEARLY EXPLAIN THE RATIONALE**
of why you are doing so in your `remarks.md` file.  **_Even if you do_ explain this in your `remarks.md` file
your submission may still be rejected**.
</p>

<p class="leftbar">
You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:
</p>

``` <!---sh-->
    ./iocccsize prog.c
```

Jump to: [top](#)

<div id="rule3">
## Rule 3
</div>

Submissions should be performed using the instructions outlined in our
FAQ on "[how to submit](../faq.html#submit)"

To submit to an open IOCCC, you must use the [IOCCC submit
server](https://submit.ioccc.org/). Unless the IOCCC is open, that link will
likely be unresponsive.

<p class="leftbar">
The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>

**Please wait to submit** your entries until after that time.

Jump to: [top](#)

<div id="rule4">
## Rule 4
</div>

<p class="leftbar">
If your submission is selected as a winner, it may be modified in order
to fit into the structure of the [Official IOCCC winner website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
For example, your submission's `Makefile` might be modified.
</p>

<p class="leftbar">
Your source code will be the file `prog.c`.  The compiled binary
will be called `prog`.  If you submission requires different filenames,
then modify your submission's `Makefile` to **COPY** (**NOT** move)
the files accordingly.
</p>

<p class="leftbar">
See also [Rule 5](#rule5), [Rule 18](#rule18) and [Rule 21](#rule21).
</p>

Jump to: [top](#)

<div id="rule5">
## Rule 5
</div>

Your submission **MUST** not modify the content or filename of any part of your
original submission including, but not limited to `prog.c`, the `Makefile`
(that we create from your how to build instructions), as well as any data
files you submit.

If you submission wishes to modify such content, it **MUST** first copy the
file to a new filename and then modify that copy.

Jump to: [top](#)

<div id="rule6">
## Rule 6
</div>

<p class="leftbar">
I am not a rule, I am a `free(void *human);` ‼️
</p>

<p class="leftbar">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`while (!(ioccc(rule(you(are(number(6)))))) {`<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ha_ha_ha();`<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`}`
</p>

Jump to: [top](#)

<div id="rule7">
## Rule 7
</div>

The obfuscated C program must be an original work that you own.

You (the author(s)) must own the contents of your submission OR
you must have permission from the owner(s) to submit their content
under the following license:

<p class="leftbar">
**[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**
</p>

If you submit any content that is owned by others, you **MUST
detail that ownership** (i.e., who owns what) **_AND_ document the
permission you obtained**.

Please note that the IOCCC size tool is **NOT** an original work.

Jump to: [top](#)

<div id="rule8">
## Rule 8
</div>

<p class="leftbar">
Entries must be received prior to the end of this IOCCC which is **2024-MMM-DD HH:MM:SS UTC**.<br>
**XXX - date/time is TBD - XXX**
</p>


A confirmation of submission will be sent to the submitting email address
before the close of the contest.

Jump to: [top](#)

<div id="rule9">
## Rule 9
</div>

<p class="leftbar">
Each person may submit up to and including **10.000000** (ten) entries per contest.
</p>

**Each submission _must be submitted separately_**.

Jump to: [top](#)

<div id="rule10">
## Rule 10
</div>

Entries requiring human interaction to be initially compiled **are not
permitted**. However, see the [guidelines](guidelines.html).

Jump to: [top](#)

<div id="rule11">
## Rule 11
</div>

Programs that require special privileges (`setuid(2)`, `setgid(2)`,
super-user, special owner, special group, etc.) are still **HIGHLY
DISCOURAGED**. We do not guarantee these functions will behave as
you expect on our test platforms. If your program needs special
permissions you **MUST** document this fact, and explain why
it is needed in your submissions `remarks.md` file.

Jump to: [top](#)

<div id="rule12">
## Rule 12
</div>

**Legal** abuse of the rules is somewhat encouraged.  **A submission that, in
the opinion of the [judges](../judges.html), violates the rules will be disqualified**.
Submissions that attempt to abuse the rules **MUST** try to justify why
their rule abuse is legal, in the `remarks.md` file.

Jump to: [top](#)

<div id="rule13">
## Rule 13
</div>

<p class="leftbar">
Any C source that fails to compile because of unescaped octets with
the high bit set (octet value >= 128) **_might_** be rejected.
</p>

Jump to: [top](#)

<div id="rule14">
## Rule 14
</div>

<p class="leftbar">
Any C source that fails to compile because of lines with trailing
control-M's (i.e., lines with a tailing octet `015`) **_might_** be rejected.
</p>

Please do **NOT** put trailing control-M's on remarks file lines.
Please check to be sure, before submitting, that you have removed
any control-M at the end of remark file lines.

Jump to: [top](#)

<div id="rule15">
## Rule 15
</div>

<p class="leftbar">
In order to register for the IOCCC, you **MUST** have a valid email address.
</p>

The [judges](../judges.html) **are not responsible for delays in email**, please plan
enough time for one automated exchange of email as part of your
submission.

<p class="leftbar">
See the
FAQ on "[how to register](../faq.html#register)"
for details.
</p>

Jump to: [top](#)

<div id="rule16">
## Rule 16
</div>

You are **STRONGLY** encouraged to submit **a previously unpublished _AND_
original submission**. Submissions that are similar to previous entries are
discouraged. As we judge anonymously, submissions that have already
been published may be disqualified.

Jump to: [top](#)

<div id="rule17">
## Rule 17
</div>


### TL;DR Rule 17 - Use `mkiocccentry(1)`

<p class="leftbar">
This is a **COMPLEX** rule.  **Violating this rule will cause your submission to REJECTED!**
To help you avoid such a rejection, you are **HIGHLY ENCOURAGED** to use the `mkiocccentry(1)` tool,
based on the latest release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
to form your submission's xz compressed tarball.
</p>

<p class="leftbar">
The [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
contains **IMPORTANT** tools such as:
</p>

* <p class="leftbar">`chkentry(1)`</p>
* <p class="leftbar">`iocccsize(1)`</p>
* <p class="leftbar">`mkiocccentry(1)`</p>
* <p class="leftbar">`txzchk(1)`</p>
* <p class="leftbar">`fnamchk(1)`</p>
* <p class="leftbar">`jparse(1)` and `jparse(8)` (which `chkentry(1)` uses)</p>

<p class="leftbar">
The above mentioned tools will help you verify that your submission
conforms to [Rule 17](#rule17).
</p>

<p class="leftbar">
Each above mentioned tools has a `-h` option that provides command
line help.  For additional details, see the tools' man pages and the
[guidelines](guidelines.html).
</p>

<p class="leftbar">
You do not explicitly need to invoke `jparse(1)` but the `jparse(8)`
library will be used when compiling various tools.
</p>

<p class="leftbar">
Of course you **can** invoke `jparse(1)` if you wish to validate your own JSON
data file or some other JSON file.
</p>

**IMPORTANT**: Make **SURE** you have the most recent version of the
`mkiocccentry` toolkit! Not doing so will put you at a great risk of violating
this rule! See the
FAQ on "[obtaining the mkiocccentry toolkit](../faq.html#mkiocccentry)"
for more details.

Jump to: [top](#)

### Rule 17 - The COMPLEX details

<p class="leftbar">
Each submission **MUST** be in the form of a xz compressed tarball.
The xz compressed tarball filename must be of the form:
</p>

``` <!---re-->
    ^submit.username-slot_num.[1-9][0-9]{9,}.txz$
```

<p class="leftbar">
... where _`username`_ is your IOCCC registration username **in the form of a
[UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier)** (see
[RFC 9562](https://datatracker.ietf.org/doc/html/rfc9562) for
details), and where _`slot_num`_ is a single decimal digit integer
(i.e., >= `0` and < `9`).
</p>

<p class="leftbar">
In particular, _`username`_ is in the form of:
`xxxxxxxx-xxxx-4xxx-axxx-xxxxxxxxxxxx` where `x` is a hexadecimal digit in the
range `[0-9a-f]`.  And yes, there is a 4 (UUID version 4) and an `a` (UUID variant
1) in there.
</p>

<p class="leftbar">
Your xz compressed tarball **MUST** contain, **at a minimum**, the following files:
</p>

* <p class="leftbar">`Makefile`</p>
* <p class="leftbar">`prog.c`</p>
* <p class="leftbar">`remarks.md`</p>
* <p class="leftbar">`.info.json`</p>
* <p class="leftbar">`.auth.json`</p>

<p class="leftbar">
The `.info.json` must be valid JSON and pass the `chkentry(1)` tests.
It is generated by the `mkiocccentry(1)` tool.
</p>

<p class="leftbar">
The `.auth.json` must be valid JSON and pass the `chkentry(1)` tests.
It is generated by the `mkiocccentry(1)` tool.
</p>

<p class="leftbar">
You submission may have additional files, however the filenames of those additional files **MUST**:
</p>

* <p class="leftbar"> Be less than **100** characters in length.</p>
* <p class="leftbar">Match the regular expression:
`^[0-9A-Za-z][0-9A-Za-z._+-]*$`</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will not package any files that do not meet
those requirements.
</p>

<p class="leftbar">
The `Makefile` **MUST** be a **non**-empty file in **[GNU
Makefile](https://www.gnu.org/software/make/manual/make.html)** form. See the
[Makefile.example](https://github.com/ioccc-src/temp-test-ioccc/blob/master/next/Makefile.example),
the
FAQ on "[submission Makefile](../faq.html#submission_makefiles)"
and the
FAQ on "[Makefile compatibility](../faq.html#make_compatibility)"
for help.
</p>

<p class="leftbar">
The `remarks.md` **MUST** be a **non**-empty file in markdown form.  See also
[Rule 18](#rule18) and our
FAQ on "[remarks.md](../faq.html#remarks_md)"
and our
FAQ on "[markdown](../faq.html#markdown)"
and our [markdown guidelines](../markdown.html).
</p>

<p class="leftbar">
See also the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide
and the [CommonMark Spec](https://spec.commonmark.org/current/).
</p>

<p class="leftbar">
The xz compressed tarball file **MUST** be less than or equal **3999971** octets in size.
</p>

<p class="leftbar">
When your submission's xz compressed tarball is uncompressed,
the total size of your submission: the sum of the size of the program,
hints, comments, build and info files **MUST** be less than or equal
to **28314624** octets (**27651K**) in size.
</p>

<p class="leftbar">
Your submission's xz compressed tarball **MUST** pass the `txzchk(1)` test. See
the [guidelines](guidelines.html) for more details on this tool.
</p>

<p class="leftbar">
You are **HIGHLY ENCOURAGED** to use the `mkiocccentry(1)` tool to form your
submission's xz compressed tarball. See the [guidelines](guidelines.html) for
more details on this tool and the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry).
</p>

<p class="leftbar">
Your entry may **NOT** have subdirectories. However, you can provide files that
are in different directories as `mkiocccentry(1)` will copy them to the work
directory (see the [guidelines](guidelines.html) for more details).
</p>

<p class="leftbar">
Filenames in your entry (that is, not including the files generated by the
`mkiocccentry(1)` tool or the tools it or any other tool invokes) **MUST**:
</p>

* <p class="leftbar">Be less than **100** characters in length</p>
* <p class="leftbar">**NOT** have a **`/`** (excluding the entry directory that
the `mkiocccentry(1)` tool generates).</p>
* <p class="leftbar">**NOT** contain a path component of: **`.`** (that is, with
the exception of files generated by `mkiocccentry(1)` itself, it must have
**NO** **`.`**).</p>
* <p class="leftbar">**NOT** contain a path component of: **`..`** (that is,
**NO** **`..`**).</p>
* <p class="leftbar">Match the regular expression
`^[0-9A-Za-z][0-9A-Za-z._+-]*$` (again, excluding files generated by
`mkiocccentry(1)`).</p>

<p class="leftbar">
Additionally, the tarball **MUST** have the following files (generated
by the `mkiocccentry(1)` tool):
</p>

* <p class="leftbar">`.auth.json` which contains information about the author or
authors (that will only be looked at if the submission wins).</p>
* <p class="leftbar">`.info.json` which contains information about the
entry.</p>

<p class="leftbar">
The `txzchk(1)` tool will verify these (and other things) for you and
the `chkentry(1)` tool will do additional checks on the contents of the
`.auth.json` and `.info.json` files (including JSON validity). If these checks
fail it is an error and `mkiocccentry(1)` will fail. In this case it is very
**possibly** a bug; please [report it as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
</p>

<p class="leftbar">
The tarball filename **MUST** pass `fnamchk(1)`; the tool `txzchk(1)`
will run `fnamchk(1)` as part of its algorithm. If you use `mkiocccentry(1)`
there should be no problem but if you were to package things manually it is
possible there could be a problem and this poses a big risk of violating [Rule
17](#rule17).
</p>

<p class="leftbar">
The `fnamchk(1)`, which `txzchk(1)` executes, will verify that the
filename is correct.
</p>

<p class="leftbar">
These checks **MUST PASS**.
</p>

<p class="leftbar">
Where [Rule 17](#rule17) and the tools from the latest
release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
conflict, the [IOCCC Judges](../judges.html) will use their best judgment which
is likely to favor [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) code.
</p>

<p class="leftbar">
This means you should **MAKE SURE** that you use `mkiocccentry(1)` to
package your submission; `mkiocccentry(1)` will run the above mentioned tools
(that do not act on the tarball) **before** creating the tarball and after the
tarball is created it will then verify that the tarball is okay by running
`txzchk(1)` on it.
</p>

<p class="leftbar">
**MAKE SURE** you use the correct release of the repository; you should do this
**AFTER** the contest opens (pull any changes or if you prefer download the
repository via the download option at GitHub).
</p>

<p class="leftbar">
We recommend that you run `make` and then install the tools (and man pages) via
`make install` (as root or using `sudo(1)` to help you run these tools from your
submission's directory. The `make install` will install in `/usr/local`.
</p>

<p class="leftbar">
These tools will link in the `jparse(8)` library; `chkentry(1)` uses the parser
to validate the [JSON](https://www.json.org/json-en.html) but the other tools
use parts of the library as well.
</p>

<p class="leftbar">
If you run into a problem with one or more of these tools, **PLEASE** [report it
as a bug at the mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E),
**making sure to run `bug_report.sh`**. See the [guidelines](guidelines.html)
for help here and also read our
FAQ on "[mkiocccentry repo bugs](../faq.html#mkiocccentry_bugs)".
</p>

<p class="leftbar">At the risk of stating the obvious: submissions that violate [Rule
17](#rule17) **will be rejected**, so **be sure** to use the latest release of the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry), to form and test
your submission's xz compressed tarball. Do **NOT** assume you have the most
recent release without pulling or downloading via GitHub and **make sure** you
do this **AFTER** the [contest status](../status.html) has changed to
[open](../status.html#open).
</p>

Jump to: [top](#)

<div id="rule18">
## Rule 18
</div>

The entirety of your submission must be submitted under the following license:

<p class="leftbar">
**[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**
</p>

You (the author(s)) **MUST** own the contents of your submission **OR**
you **MUST HAVE PERMISSION** from the owner(s) to submit their content.

You **MUST NOT** submit anything that cannot be submitted under that license.

Jump to: [top](#)

<div id="rule19">
## Rule 19
</div>

<p class="leftbar">
The `remarks.md` file, a required non-empty file, must be written in
markdown format. See the [Daring Fireball Markdown:
Basics](http://daringfireball.net/projects/markdown/basics).
</p>

<p class="leftbar">
We currently use [pandoc](https://pandoc.org) to convert markdown to HTML.
</p>

<p class="leftbar">
Please see our FAQ "[remarks.md](../faq.html#remarks_md)" and the [IOCCC markdown
guidelines](../markdown.html) for additional markdown guidance.
</p>

Jump to: [top](#)

<div id="rule20">
## Rule 20
</div>

The how to build instructions must be in Makefile format. See [the FAQ about
make&lpar;1&rpar; compatibility the IOCCC
supports](../faq.html#make_compatibility) for more details.

<p class="leftbar">
You are **ENCOURAGED** to use
[Makefile.example](https://github.com/ioccc-src/temp-test-ioccc/blob/master/next/Makefile.example),
renamed as `Makefile` of course, for help in constructing your `Makefile`.
</p>

The target of the Makefile must be called `prog`.  The original
C source file must be called `prog.c`.

To invoke the C compiler, use `${CC}`. To invoke the C preprocessor use
`${CPP}`.

Do **NOT** assume that `.` (the current directory) is in the `$PATH`.

<p class="leftbar">
Your `Makefile` **MUST** use a syntax that is compatible with `bash(1)`
and GNU `make(1)`.  You are **ENCOURAGED** to use set `SHELL= bash` in
your `Makefile`.
</p>

<p class="leftbar">
Assume that commands commonly found in [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) are
available in the `$PATH` search path.
</p>

Jump to: [top](#)

<div id="rule21">
## Rule 21
</div>

Your submission **MUST NOT** create or modify files above the current directory
_with the exception of_ the `/tmp` and the `/var/tmp` directories.  Your submission
**MAY** create subdirectories below the current directory, or in `/tmp`,
or in `/var/tmp` provided that `.` is **NOT** the first octet in any
directory name or filename you create.

Jump to: [top](#)

<div id="rule22">
## Rule 22
</div>

Catch 22:

Your source code, data files, remarks and program output **MUST NOT**
identify the authors of your code.  The [judges](../judges.html) **STRONGLY PREFER** to
**NOT** know who is submitting entries to the IOCCC.

Even if you are a previous IOCCC winner, catch 22 still applies.

Identifying the author(s) of your submission in an obvious way anywhere
within your code, data, remarks or program output (unless you are
**Peter Honeyman** or pretending to be **Peter Honeyman**) will be grounds
for disqualification of your submission.

Yes, Virginia, **WE REALLY MEAN IT!**

Jump to: [top](#)

<div id="rule23">
## Rule 23
</div>

This prime rule number is reserved for future use.

Jump to: [top](#)

<div id="rule24">
## Rule 24
</div>

Even though 24 is not prime, you should still see [Rule 23](#rule23).

Jump to: [top](#)

<div id="rule25">
## Rule 25
</div>

<p class="leftbar">
The [IOCCC rule set](rules.html) needs more than 5^2 rules: see [Rule 26](#rule26).
</p>

Jump to: [top](#)

<div id="rule26">
## Rule 26
</div>

> "The quick brown fox jumps over the lazy dog".<br>
> "Pack my box with five dozen liquor jugs."<br>
> "How vexingly quick daft zebras jump!"<br>
> "Sphinx of black quartz, judge my vow."<br>
> "Waltz, bad nymph, for quick jigs vex."<br>
> "Mr. Jock, TV quiz PhD, bags few lynx."<br>
> "abcdefg, hijklmnop, qrstu&v, wxy&z."

Jump to: [top](#)

<div id="rule27">
## Rule 27
</div>

<p class="leftbar">
Unless otherwise needed, [Rule 27](#rule27) is reserved for something cubic.  :-)
</p>

Jump to: [top](#)

<div id="rule28">
## Rule 28
</div>

<p class="leftbar">
[Rule 28](#rule28) is a perfect way end to the list of [IOCCC rules](rules.html)
as we do **NOT** plan to have **496** rules. :-)
</p>

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
**Be SURE** to review the [IOCCC Rules and Guidelines](index.html) as
[IOCCC rules](rules.html) and the [IOCCC guidelines](guidelines.html) may (and
**often do**) change from year to year.
</p>

<p class="leftbar">
You should be sure you have the current [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting entries.
</p>

See the [Official IOCCC website news](../news.html) for additional information.

<p class="leftbar">
For the updates and breaking IOCCC news, you are encouraged to follow
the [IOCCC on Mastodon](https://fosstodon.org/@ioccc) account.  See our
FAQ on "[Mastodon](../faq.html#try_mastodon)"
for more information. Please do note that unless
you are mentioned by us you will **NOT** get a notification from the app _so you
should refresh the page **even if you do follow us**_.
</p>

<p class="leftbar">
Check out the [Official IOCCC winner website](https://www.ioccc.org/index.html) in general.
</p>

Jump to: [top](#)

**Leonid A. Broukhis**<br>
**chongo (Landon Curt Noll) `/\cc/\`**



<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)
