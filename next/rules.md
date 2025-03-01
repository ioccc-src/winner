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
Copyright &copy; 2024-2025 Leonid A. Broukhis and Landon Curt Noll.
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

<p class="leftbar">
These [IOCCC rules](rules.html) are version **28.27 2025-03-01**.
</p>

<p class="leftbar">
The markdown form of these rules <a href="rules.md" download="rules.md">is
available for download</a>.
</p>

**IMPORTANT**: Be sure to read the [IOCCC guidelines](guidelines.html).


Jump to: [top](#)


<div id="change_marks">
### Change marks
</div>

<p class="leftbar">
**&larr; Lines that start with this symbol indicate a change from the previous IOCCC**
</p>

<p class="leftbar">
Most lines that were modified since the previous IOCCC start with a solid
4 pixel black left border (or, in the case of a code block or blockquote,
just a vertical bar).  We say _most lines_ because we sometimes forget
to bar modified sections.
</p>


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
*  To emphasize the value of perspicuous code by use of negative examples.
*  To stress C compilers with unusual code.
*  To illustrate some of the subtleties of the C language.
*  To provide a safe forum for poor C code. :-)
*  To have fun with C!


Jump to: [top](#)


<div id="dates">
# Important IOCCC dates
</div>

<p class="leftbar">
This IOCCC runs from **2024-12-29 23:58:13.213455 UTC** to **2025-06-05 04:03:02.010099 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[pending](../faq.html#pending)** state on or about
**2024-12-29 23:58:13.213455 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[open](../faq.html#open)** state on **2025-03-05 23:19:17.131107 UTC**.
</p>

<p class="leftbar">
This contest will enter the **[judging](../faq.html#judging)** state on **2025-06-05 04:03:02.010099 UTC**.
</p>

<p class="leftbar">
**IMPORTANT NOTE**: Until the contest enters the **[open](../faq.html#open)** state, any or all
of the above **dates and times may change**!
</p>

<p class="leftbar">
Those who [register](register.html) while the contest status is **[pending](../faq.html#pending)**
will receive email with their [submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html) shortly after the contest status becomes **[open](../faq.html#open)**.
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
Just as C starts at 0, so the IOCCC starts at [Rule 0](#rule0).  :-)
</p>

<p class="leftbar">
The "[Important IOCCC dates](#dates)" section above is part of this rule.
</p>


Jump to: [top](#)


<div id="rule1">
## Rule 1
</div>

<p class="leftbar">
Your submission must be a C program.
</p>

<p class="leftbar">
You see, the contest is not called the **International Obfuscated JSON Contest**
(**IOJSONC**), even if the [so-called JSON
spec](https://github.com/xexyl/jparse/blob/master/json_README.md#so-called-json-spec) might be called obfuscated. :-)
</p>


Jump to: [top](#)


<div id="rule2">
## Rule 2
</div>

The size rule requires your submission to satisfy **BOTH** [Rule 2a](#rule2a) and [Rule 2b](#rule2b):

<p class="leftbar">
If you use the most recently released official IOCCC submission
packaging tool (hereby referred to as `mkiocccentry(1)`), which we **STRONGLY
recommend you do** (see also [Rule 17](#rule17)), then the `mkiocccentry(1)`
tool will warn you if there appears to be a [Rule 2a](#rule2a) violation.
</p>

Jump to: [top](#)


<div id="rule2a">
## Rule 2a
</div>

<p class="leftbar">
The size of your program source **should NOT exceed 4993 bytes**.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will give you the option of overriding the [Rule
2a](#rule2a) warning.  Overriding the [Rule 2a](#rule2a) warning carries a
**fair amount of risk that your submission will be rejected**.  Be sure to
consult the [IOCCC guidelines](guidelines.html) ahead of time if you plan to
override the [Rule 2a](#rule2a) warning.
</p>

<p class="leftbar">
If you do override the [Rule 2a](#rule2a) warning from the `mkiocccentry(1)`
tool, or otherwise plan to violate [Rule 2a](#rule2a), then you **MUST CLEARLY
EXPLAIN THE RATIONALE** of why you are doing so in your `remarks.md` file.
**_Even if you do_ explain this in your `remarks.md` file you submission may
still be rejected**.
</p>

<p class="leftbar">
You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:
</p>

``` <!---sh-->
    iocccsize prog.c
```

<p class="leftbar">
Alternatively, you may use the `mkiocccentry(1)` option `-d` to verify that
things check out okay (i.e. no problems are detected) without having to answer
all the questions. See the
FAQ on "[how to test your submission without having
to answer questions](../faq.html#mkiocccentry_test)" for more details.
</p>

Jump to: [top](#)


<div id="rule2b">
## Rule 2b
</div>

<p class="leftbar">
When the filename of your program source is given as a command line argument to
the latest version of the official IOCCC size tool (hereby referred to as
`iocccsize(1)`), the value printed **should NOT exceed _2503_**.
</p>

<p class="leftbar">
The source to `iocccsize(1)` may be found in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).
</p>

<p class="leftbar">
If you use the `mkiocccentry(1)` tool, which we **STRONGLY recommend
you do** (again, see also [Rule 17](#rule17)),
then `mkiocccentry(1)` will invoke the `iocccsize(1)` checks before packaging
your submission.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will give you the option of overriding the [Rule
2b](#rule2b) warning.  Overriding the [Rule 2b](#rule2b) warning carries a **fair
amount of risk that your submission will be rejected**.  Be sure to consult the
[IOCCC guidelines](guidelines.html) ahead of time if you plan to override the
[Rule 2b](#rule2b) warning.
</p>

<p class="leftbar">
If you do override the [Rule 2b](#rule2b) warning from the `mkiocccentry(1)`
tool, or otherwise plan to violate [Rule 2b](#rule2b), then you **MUST CLEARLY
EXPLAIN THE RATIONALE** of why you are doing so in your `remarks.md` file.
**_Even if you do_ explain this in your `remarks.md` file your submission may
still be rejected**.
</p>

<p class="leftbar">
You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:
</p>

``` <!---sh-->
    iocccsize prog.c
```


Jump to: [top](#)


<div id="rule3">
## Rule 3
</div>

<p class="leftbar">
You must [register](register.html) in order to submit your entry to the IOCCC.
You may [register](register.html) while the contest is either
**[pending](../faq.html#pending)** or  **[open](../faq.html#open)**.
</p>

<p class="leftbar">
See the
FAQ on "[how to register and submit to the IOCCC](../quick-start.html#enter)"
for instructions on registering and participating in the IOCCC, as the process has changed from previous years!
</p>

<p class="leftbar">
When the contest is **[open](../faq.html#open)**, an
[IOCCC judge](../judges.html) will email you your [submit server](https://submit.ioccc.org)
**Username** and **Initial password**.  It takes some time (maybe even a few days) for an
[IOCCC judge](../judges.html) to process your registration and email you your
initial login and password.
</p>

<p class="leftbar">
Those who [register](register.html) while the contest status is **[pending](../faq.html#pending)**
will receive email with their [submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html) shortly after the contest status becomes **[open](../faq.html#open)**.
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
If you have [registered](register.html) and received by email your
[submit server](https://submit.ioccc.org) **Username** and **Initial password**
from an [IOCCC judge](../judges.html), you may upload your submission to
the [submit server](https://submit.ioccc.org) **ONLY** while the
contest is **[open](../faq.html#open)**.
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
While the contest is **[open](../faq.html#open)**, you may modify your previously
uploaded submission by rebuilding your submission with the `mkiocccentry(1)` tool
and then re-uploading it to the same slot number on the [submit server](https://submit.ioccc.org).
</p>

<p class="leftbar">
Once the contest enters the **[judging](../faq.html#judging)** state, you will
**NOT** be allowed to upload your submission files.
</p>

<p class="leftbar">
The [submit server](https://submit.ioccc.org) will become active when the contest is **[open](../faq.html#open)**.
Until the contest status becomes **[open](../faq.html#open)**,
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
then modify your submission's `Makefile` to **COPY** (**NOT** move!) the files
accordingly.
</p>

<p class="leftbar">
See also [Rule 5](#rule5), [Rule 18](#rule18) and [Rule 21](#rule21).
</p>


Jump to: [top](#)


<div id="rule5">
## Rule 5
</div>

Your submission must **NOT** modify the content or filename of any part of your
original submission including, but not limited to `prog.c`, the `Makefile`
as well as any data files you submit.

If you submission needs (or wishes :-) ) to modify such content, it **MUST**
first copy the file to a new filename and then modify that copy.

<p class="leftbar">
You may use your submission (program) to form a copy, or you can make use of
your `Makefile` to form that copy.
</p>

<p class="leftbar">
If you do make a copy and then modify that copy, **PLEASE** be sure that
the `clobber` rule of your `Makefile` removes that copy in order to
restore the contents of your submission to its original submission.
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

<p class="leftbar">
The obfuscated C program must be your own original work.
</p>

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
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) clones) or the
[dbg repo](https://github.com/lcn2/dbg) (that the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) clones) or the [dyn_array
repo](https://github.com/lcn2/dyn_array) (that the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) clones) are
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
while the contest is **[open](../faq.html#open)**.
</p>

<p class="leftbar">
Once the contest is in the **[judging](../faq.html#judging)** state (or
**[closed](../faq.html#closed)**), you may **NOT** upload submissions.
</p>

<p class="leftbar">
While the contest is **[open](../faq.html#open)** or in the **[judging](../faq.html#judging)** state,
the [IOCCC judges](../judges.html) **MAY** (but are not required to) modify the slot comment of your submission to indicate
that they have received it.  If uploaded submission is malformed, the [IOCCC judges](../judges.html)
**MAY** (but are not required to) modify the slot comment accordingly.
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
Each **PERSON** may register **ONLY ONE** account and each account may submit up to
and including **10.000000** (ten in base 10) submissions **PER** contest.
</p>

**Each submission _must be submitted separately_**.

<p class="leftbar">
If this seems unreasonable we suggest you wait until the next contest, and in
the interim ponder this modified quote purportedly said by Bill Gates:
</p>

<p class="leftbar">
> 10 submissions ought to be enough for anybody. :-)
>
>    -- Bill Gates
</p>

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
it is needed in your submission's `remarks.md` file.


Jump to: [top](#)


<div id="rule12">
## Rule 12
</div>

**Legal** abuse of the rules is somewhat encouraged.  **A submission that, in
the opinion of the [judges](../judges.html), violates the rules WILL BE DISQUALIFIED**.
Submissions that attempt to abuse the rules **MUST** try to justify why
their rule abuse is legal, in the `remarks.md` file.


Jump to: [top](#)


<div id="rule13">
## Rule 13
</div>

<p class="leftbar">
7 out of 13 UTF-8 characters in C code agree that this rule number is lucky
enough to be a prime number.
</p>

<p class="leftbar">
Fun fact: the fear of the number 13 is called _triskaidekaphobia_.
</p>

Jump to: [top](#)


<div id="rule14">
## Rule 14
</div>

<p class="leftbar">
Any C source that fails to compile because of lines with trailing
control-M's (i.e., lines with a trailing octet `015`) **_might_** be rejected.
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

The [judges](../judges.html) **are NOT responsible for delays in email**, please plan
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

You are **STRONGLY** encouraged to submit an **original submission**.
Submissions that are similar to previous entries are
discouraged. As we judge anonymously, submissions that have already
been published may be disqualified.


Jump to: [top](#)


<div id="rule17">
## Rule 17
</div>

<p class="leftbar">
Your submission must be in the form of **xz compressed tarball**
that `mkiocccentry(1)` tool would generate.  The files, directories,
and paths **MUST** conform to the limits imposed by `mkiocccentry(1)`
including but **NOT LIMITED** to their names, count, path length
and directory tree depth.
</p>

<p class="leftbar">
Your **xz compressed tarball** submission file must pass the tests performed by:
</p>

* <p class="leftbar">`txzchk(1)`</p>

<p class="leftbar">
Your **xz compressed tarball** submission filename must pass the tests performed by:
</p>

* <p class="leftbar">`fnamchk(1)`</p>

<p class="leftbar">
The resulting directory produced when your **xz compressed tarball** submission file uncompressed
must pass the checks performed by:
</p>

* <p class="leftbar">`chkentry(1)`</p>

<p class="leftbar">
`txzchk(1)` uses the `fnamchk(1)` tool on your tarball to obtain the proper
directory name. If either name is wrong, it will be flagged as an error.
</p>

<p class="leftbar">
The resulting `prog.c` file must pass the [Rule 2](#rule2) size checked performed by:
</p>

* <p class="leftbar">`iocccsize(1)`</p>

<p class="leftbar">
The `.auth.json` and `.info.json` must be compatible with what hat `mkiocccentry(1)` tool
would produce as well as pass the tests performed by:
</p>

* <p class="leftbar">`jparse(3)`</p>
* <p class="leftbar">`chkentry(1)`</p>

<p class="leftbar">
The `Makefile` must **NOT** be empty.
</p>

<p class="leftbar">
The `remarks.md` must **NOT** be empty.
</p>


### TL;DR Rule 17 - Use `mkiocccentry(1)` to form your submission

Let the `mkiocccentry(1)` tool form your **xz compressed tarball** submission
file and don't try to override its checks and limits, in order to be sure you
submission conforms to this rule.

### Warning

Using command line flags or input prompts to override checks and
limits made by the above mentioned tools is **NOT** recommended
and may result in your submission being rejected by the [IOCCC
submit server](https://submit.ioccc.org) and/or the [IOCCC
Judges](../judges.html).

<p class="leftbar">
See the
FAQ on the "[mkiocccentry tool](../faq.html#mkiocccentry)
for how to obtain and use the above mentioned tools.
</p>

<p class="leftbar">
**IMPORTANT**: See the
FAQ on "[Rule 17](../faq.html#rule17)"
for very important details behind this rule.
</p>


Jump to: [top](#)


<div id="rule18">
## Rule 18
</div>

The entirety of your submission must be submitted under the following license:

<p class="leftbar">
**[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**
</p>

You (the author(s)) **MUST** own the content of your submission **OR**
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
You are **ENCOURAGED** to use the
Makefile example, renamed as `Makefile` of course, for help in constructing your
`Makefile`. See the [Makefile section](guidelines.html#makefile) in the
guidelines for more details.
</p>

The target of the `Makefile` must be called `prog`.  The original
C source file must be called `prog.c`.

To invoke the C compiler, use `${CC}`. To invoke the C preprocessor use
`${CPP}`.

Do **NOT** assume that `.` (the current directory) is in the `$PATH`.

<p class="leftbar">
When `make clobber` is invoked, we request that submission directory be restored
to its original submission state.  For example, any temporary files
created during the build process, or during execution should be
removed by the `clobber` rule.
</p>

<p class="leftbar">
Your `Makefile` **MUST** use a syntax that is compatible with `bash(1)`
and GNU `make(1)`.  You are **ENCOURAGED** to use `SHELL= bash` in
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

Your submission **MUST NOT** create or modify files **ABOVE** the current directory
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

<p class="leftbar">
And don't assume that we won't be able to determine your name even if it's not
obvious, because you stand a significant chance of violating this rule if you
do.
</p>

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
