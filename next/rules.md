<!-- START: this line starts content from: inc/rules.pending.hdr -->

# WARNING: These rules are TENTATIVE

One might think of them as a **beta** release for the IOCCC
that is about to open.

**IMPORTANT**: All **tentative** [rules](rules.html) and [guidelines](guidelines.html)
are subject to change by the [IOCCC judges](../judges.html) at any time.
See both the [IOCCC news](../news.html) and the [IOCCC
Mastodon](https://fosstodon.org/@ioccc) feed as _sometimes_ the
[IOCCC judges](../judges.html) _mention_ changes there.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[about asking questions](../faq.html#question)"
about these rules. You might also find the FAQ in general useful, especially the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)".


# The IOCCC is pending

While the IOCCC is not open now, there is a tentative opening date for the next IOCCC.

Comments and suggestions on these preliminary rules are welcome.  See the
[FAQ](../faq.html#feedback) for how to suggest, correct or provide feedback
about these rules.

<!-- END: the next line ends content from: inc/rules.pending.hdr -->
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
These [IOCCC rules](rules.html) are version **28.17 2025-01-18**.
</p>

<p class="leftbar">
The <a href="rules.md" download="rules.md">markdown form of these rules</a>
is available for download.
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
This IOCCC runs from **2024-12-29 23:58:13.213455 UTC** to **2025-04-01 23:29:31.374143 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[pending](../status.html#pending)** state on or about
**2024-12-29 23:58:13.213455 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[open](../status.html#open)** state on **2025-01-31 23:19:17.130705 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[judging](../status.html#judging)** state on **2025-04-01 23:29:31.374143 UTC**.
</p>

<p class="leftbar">
**IMPORTANT NOTE**: Until the content enters the **[open](../status.html#open)** state, any or all
of the above **dates and times may change**!
</p>

<p class="leftbar">
Those who [register](register.html) while the contest status is **[pending](../status.html#pending)**
will receive email with their [submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html) shortly after the contest status becomes **[open](../status.html#open)**.
</p>

<p class="leftbar">
Once an [IOCCC judge](../judges.html) emails you your **Username** and **Initial password**, you
will have 72 hours to [change your submit server initial password](pw-change.html).
If you do not change your **Initial password** in time, you will have to [re-register](register.html).
</p>

<p class="leftbar">
Because it takes time (maybe even a few days) for an [IOCCC judge](../judges.html)
to process your registration and email you your initial login and password,
you should **MAKE SURE** you give yourself enough time before the contest closes.
In other words, **DO NOT WAIT UNTIL THE FINAL DAYS** of the contest to register!
The [IOCCC judges](../judges.html) are **NOT** responsible for delayed or lost email,
or for those who wait until the last minute to try to register!
</p>

<p class="leftbar">
See the
FAQ on "[obtaining and compiling the mkiocccentry tools](../faq.html#mkiocccentry)"
and the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)"
as that FAQ has important details on
[how to register](register.html)
as well as
[how to upload your submission](submit.html) to the IOCCC.
</p>


Jump to: [top](#)


<div id="rules">
# IOCCC RULES
</div>

To help us with the volume of submissions, we ask that you follow these rules:


Jump to: [top](#)


<div id="rule0">
## Rule 0
</div>

<p class="leftbar">
Just as C starts at 0, so the IOCCC starts at [rule 0](#rule0).  :-)
</p>

<p class="leftbar">
The "[Important IOCCC dates](#dates)" section above is part of this rule.
</p>


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

<p class="leftbar">
Alternatively, you may use the `mkiocccentry(1)` option `-d` to verify that
things check out without having to answer all the questions. See the
FAQ on "[how to test your submission without having to answer
questions](../faq.html#mkiocccentry_test)"
for more details.
</p>


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

<p class="leftbar">
You must [register](register.html) in order to submit your entry to the IOCCC.
You may [register](register.html) while the contest is either
**[pending](../status.html#pending)** or  **[open](../status.html#open)**.
</p>

<p class="leftbar">
See the
FAQ on "[how to register and submit to the IOCCC](../quick-start.html#enter)"
for instructions on registering and participating in the IOCCC, as the process has changed from previous years!
</p>

<p class="leftbar">
When the contest is **[open](../status.html#open)**, an
[IOCCC judge](../judges.html) will email you your [submit server](https://submit.ioccc.org)
**Username** and **Initial password**.  This takes some time (maybe even a few days) for an
[IOCCC judge](../judges.html) to process your registration and email you your
initial login and password.
</p>

<p class="leftbar">
Those who [register](register.html) while the contest status is **[pending](../status.html#pending)**
will receive email with their [submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html) shortly after the contest status becomes **[open](../status.html#open)**.
</p>

<p class="leftbar">
Once an [IOCCC judge](../judges.html) emails you your **Username** and **Initial password**, you
will have 72 hours to [change your submit server initial password](pw-change.html).
If you do not change your **Initial password** in time, you will have to [re-register](register.html).
</p>

<p class="leftbar">
Because it takes time (maybe even a few days) for an [IOCCC judge](../judges.html)
to process your registration and email you your initial login and password,
you should **MAKE SURE** you give yourself enough time before the contest closes.
In other words, **DO NOT WAIT UNTIL THE FINAL DAYS** of the contest to register!
The [IOCCC judges](../judges.html) are **NOT** responsible for delayed or lost email,
or for those who wait until the last minute to try to register!
</p>

<p class="leftbar">
If you have [registered](register.html) and received by email their
[submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html), you may upload your submission to
the [submit server](https://submit.ioccc.org) only while the
contest **[open](../status.html#open)**.
</p>

<p class="leftbar">
The [submit server](https://submit.ioccc.org), in accordance with [Rule 17](rules.html#rule17),
places a limit of **3999971** octets on the size of your upload.
</p>

<p class="leftbar">
You are **STRONGLY** advised to use the `mkiocccentry(1)` tool
as found in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
to form the file to upload to the [submit server](https://submit.ioccc.org).
</p>

<p class="leftbar">
See the
FAQ on "[obtaining and compiling the mkiocccentry tools](../faq.html#mkiocccentry)"
for more information about the `mkiocccentry(1)` tool.
</p>

<p class="leftbar">
While the contest is **[open](../status.html#open)**, you may modify your previously
uploaded submission by rebuilding your submission with the `mkiocccentry(1)` tool
and then re-uploading it to the same slot number on the [submit server](https://submit.ioccc.org).
</p>

<p class="leftbar">
Once the contest enters the **[judging](../status.html#judging)** state, you will
**NOT** be allowed to upload your submission files.
</p>

<p class="leftbar">
The [submit server](https://submit.ioccc.org) will become active when the contest is **[open](../status.html#open)**.
Until the contest status becomes **[open](../status.html#open)**,
the [submit server](https://submit.ioccc.org) may be offline and/or unresponsive.
</p>

<p class="leftbar">
See the
FAQ on "[obtaining and compiling the mkiocccentry tools](../faq.html#mkiocccentry)"
and the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)"
as that FAQ has important details on
[how to register](register.html)
as well as
[how to upload your submission](submit.html) to the IOCCC.
</p>


Jump to: [top](#)


<div id="rule4">
## Rule 4
</div>

<p class="leftbar">
If your submission is selected as a winning entry, then your submission may be modified in order
to fit into the structure of the [Official IOCCC winner website](https://www.ioccc.org/index.html).
</p>

<p class="leftbar">
For example, your submission's `Makefile` will be modified and your `remarks.md`
will become a `README.md` which will be used to generate an `index.html` file.
</p>

<p class="leftbar">
Your source code will be the file `prog.c`.  The compiled binary
will be called `prog`.  If you submission requires different filenames,
then modify your submission's `Makefile` to **COPY** (**NOT** move!)
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

If you submission needs (or wishes :-) ) to modify such content, it **MUST** first copy the
file to a new filename and then modify that copy.

<p class="leftbar">
You may use your submission to form a copy, or you can make use of your `Makefile` to form that copy.
</p>

<p class="leftbar">
If you do make a copy and then modify that copy, please be sure that
the `clobber` rule of your `Makefile` removes that copy in order to
restore the contents if your submission to its original submission.
</p>


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

<p class="leftbar">
You (the author(s)) must own the contents of your submission OR
you must have permission from the owner(s) to submit their content
under the following license:
</p>

<p class="leftbar">
**[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**
</p>

If you submit any content that is owned by others, you **MUST
detail that ownership** (i.e., who owns what) **_AND_ document the
permission you obtained**.

<p class="leftbar">
Please note that the IOCCC size tool, the tools in the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) and the tools and library in
the [jparse repo](https://github.com/xexyl/jparse/issues) (that the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) clones) are
**NOT** original works, unless of course you're the respective authors, in
which case they are. Of course, neither are any of the previous
winning entries, unless of course you're the winner! :-)
</p>

<p class="leftbar">
See also [Rule 5](#rule5), [Rule 18](#rule18) and [Rule 21](#rule21).
</p>


Jump to: [top](#)


<div id="rule8">
## Rule 8
</div>

<p class="leftbar">
Submissions may only be uploaded to the [IOCCC submit server](https://submit.ioccc.org)
while the contest is **[open](../status.html#open)**.
</p>

<p class="leftbar">
Once the contest is in the **[judging](../status.html#judging)** state (or **[closed](../status.html#closed)**),
you may **NOT** upload submissions.
</p>

<p class="leftbar">
While the contest is **[open](../status.html#open)** or in the **[judging](../status.html#judging)** state,
the [IOCCC judges](../judges.html) may (but are not required to) modify the slot comment of your submission to indicate
that they have received it.  If uploaded submission is malformed, the [IOCCC judges](../judges.html)
may (but are not required to) modify the slot comment accordingly.
</p>

<p class="leftbar">
See the "[Important IOCCC dates](#dates)" section above for when these contest states are scheduled.
</p>

<p class="leftbar">
See also [Rule 17](#rule17).
</p>


Jump to: [top](#)


<div id="rule9">
## Rule 9
</div>

<p class="leftbar">
Each person may submit up to and including **10.000000** (ten in base 10) entries per contest.
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
7 out of 13 UTF-8 characters in C code agree that this rule number is lucky enough to be a prime number.
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
enough time for the exchange of emails so you can upload your submission.

<p class="leftbar">
See the
FAQ on "[how to register](../quick-start.html#register)"
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
contains **IMPORTANT** tools and libraries such as:
</p>

* <p class="leftbar">`chkentry(1)`</p>
* <p class="leftbar">`iocccsize(1)`</p>
* <p class="leftbar">`mkiocccentry(1)`</p>
* <p class="leftbar">`txzchk(1)`</p>
* <p class="leftbar">`fnamchk(1)`</p>
* <p class="leftbar">`jparse(1)` (and other tools) and `jparse(3)` (which `chkentry(1)` uses)</p>

<p class="leftbar">
The above mentioned tools will help you verify that your submission
conforms to [Rule 17](#rule17).
</p>

<p class="leftbar">
Each above mentioned tool has a `-h` option that provides command line help. For
additional details of each tool, see its man page, and in some cases, the [IOCCC
guidelines](guidelines.html).
</p>

<p class="leftbar">
There is no need to use `jparse(1)` but the `jparse(3)` library
library will be linked when compiling the tools as they use various functions
provided by it, and `chkentry` uses the JSON parser API as well.
</p>

<p class="leftbar">
Of course you **may** invoke `jparse(1)` if you wish to validate a JSON file but
the only JSON files you might want to validate for the IOCCC are validated
by `chkentry(1)`, and that is what you should use to make sure you conform to
this rule.
</p>

<p class="leftbar">
The maximum number of **extra files** is 31. See the [maximum number of extra
files section](#max-files) below for finer details and the
FAQ on "[including additional files](../faq.html#extra-files)"
if you need to include more files than this maximum.
</p>

<p class="leftbar">
Extra files are defined as files that are not the required files (`prog.c`,
`Makefile`, `remarks.md` and the two generated by `mkiocccentry(1)` `.info.json`
and `.auth.json`) and the optional files (`try.sh`, `prog.alt.c` and
`try.alt.sh`).
</p>

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
In particular, `username` is in the form of:
`xxxxxxxx-xxxx-4xxx-Nxxx-xxxxxxxxxxxx` where `'x'` is a hex digit in the range
of `[0-9a-f]`, 4 is the UUID version, and `N` is one of `8`, `9`, `a`, or `b`.
And yes, there is a 4 (UUID version 4) and variants `0x8`, `0x9`, `0xa` and
`0xb` in there.
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
The `.info.json` is generated by the `mkiocccentry(1)` tool. If not, and it is
not valid JSON or it does not pass the `chkentry(1)` tool, your submission
**WILL BE** rejected! If you do use `mkiocccentry(1)` and it fails to pass
`chkentry(1)` then you might wish to [report it as a bug at the mkiocccentry
issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
</p>

<p class="leftbar">
The `.auth.json` is generated by the `mkiocccentry(1)` tool. If not, and it is
not valid JSON or it does not pass the `chkentry(1)` tool, your submission
**WILL BE** rejected! If you do use `mkiocccentry(1)` and it fails to pass
`chkentry(1)` then you might wish to [report it as a bug at the mkiocccentry
issues
page](https://github.com/ioccc-src/mkiocccentry/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D+%3Ctitle%3E).
</p>

<p class="leftbar">
You submission may have additional files, however the filenames of those additional files **MUST**:
</p>

* <p class="leftbar">Be less than **100** characters in length.</p>
* <p class="leftbar">Match the regular expression:
`^[0-9A-Za-z][0-9A-Za-z._+-]*$`</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will not package any files that do not meet
those requirements.
</p>

<p class="leftbar">
The `Makefile` **MUST** be a **non**-empty file in **[GNU
Makefile](https://www.gnu.org/software/make/manual/make.html)** form. See the
[Makefile section in the guidelines](guidelines.html#makefile),
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
**IMPORTANT**: Make **SURE** you have the most recent version of the
`mkiocccentry` toolkit! Not doing so will put you at a great risk of violating
this rule! See the
FAQ on "[obtaining the mkiocccentry toolkit](../faq.html#mkiocccentry)"
for more details.
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
These checks **MUST PASS**. If they do not you stand a significant chance of
having your submission rejected for violating [Rule 17](#rule17)!
</p>

<div id="max-files">
#### Maximum number of files per submission
</div>

<p class="leftbar">
The maximum number of files your submission tarball may contain, not counting
the optional files (`prog.alt.c`, `try.sh`, `try.alt.sh`) and the mandatory
files (`prog.c`, `Makefile`, `remarks.md`) is 31. This is defined in the macro
`MAX_EXTRA_FILE_COUNT` in
[soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry). See the
FAQ on "[how to include additional files](../faq.html#extra-files)"
if you need to include more files.
</p>

<p class="leftbar">
If you do include a tarball that takes your extra files count over the maximum,
you **MUST** explain this in your `remarks.md` file!
</p>

<p class="leftbar">
If you need to extract a tarball by some Makefile, or perhaps the program
itself, then `make clobber` **MUST** remove everything that the extraction
created!
</p>

<p class="leftbar">
Tarballs **MUST** only create files and directories _under them_. They may
**NOT** contain absolute paths (paths that start with `/`)!
</p>

<hr style="width:50%;text-align:left;margin-left:0">


<p class="leftbar">
**IMPORTANT**: where [Rule 17](#rule17) and the tools from the latest
release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
conflict, the [IOCCC judges](../judges.html) will use their best judgment which
is likely to favor [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) code.
</p>

<p class="leftbar">
This means you should **MAKE SURE** that you use `mkiocccentry(1)` to
package your submission; `mkiocccentry(1)` will run the above mentioned tools
(that do not act on the tarball) **before** creating the tarball and after the
tarball is created it will then verify that the tarball is okay by running
`txzchk(1)` on it. If any step fails it is an error and submitting the
submission will result in violating this rule.
</p>

<p class="leftbar">
**MAKE SURE** you use the correct release of the repository; you should do this
**AFTER** the contest opens (pull any changes or if you prefer download the
repository via the download option at GitHub). See the
FAQ on "[obtaining mkiocccentry](../faq.html#obtaining_mkiocccentry)"
for more help on ensuring you do have the most up to date release.
</p>

<p class="leftbar">
We recommend that you run `make` and then install the tools (and man pages) via
`make install` (as root or using `sudo(1)`) to help you run these tools from your
submission's directory. The `make install` will install in `/usr/local`.
However, **you do not have** to install them, but in that case you'll have to run it
from the toolkit's directory or use the correct options to specify the path to
the necessary tools, and also specify the path to your files.
</p>

<p class="leftbar">
These tools will link in the `jparse(3)` library; `chkentry(1)` uses the parser
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
Makefile example, renamed as `Makefile` of course, for help in constructing your
`Makefile`. See the [Makefile section](guidelines.html#makefile) in the
guidelines for more details.
</p>

The target of the Makefile must be called `prog`.  The original
C source file must be called `prog.c`.

To invoke the C compiler, use `${CC}`. To invoke the C preprocessor use
`${CPP}`.

Do **NOT** assume that `.` (the current directory) is in the `$PATH`.

<p class="leftbar">
When `make clobber` is invoked, we request that submission be restored
to its original submission state.  For example, any temporary files
created during the build process, or during execution should be
removed by the `clobber` rule.
</p>

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

<p class="leftbar">
See also [Rule 5](#rule5).
</p>


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

<p class="leftbar">
See the
FAQ on "[obtaining and compiling the mkiocccentry tools](../faq.html#mkiocccentry)"
and the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)"
as that FAQ has important details on
[how to register](register.html)
as well as
[how to upload your submission](submit.html) for the IOCCC.
</p>


Jump to: [top](#)


**Leonid A. Broukhis**<br>
**chongo (Landon Curt Noll) `/\cc/\`**


<hr style="width:10%;text-align:left;margin-left:0">


Jump to: [top](#)
