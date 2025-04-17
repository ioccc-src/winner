<!-- START: this line starts content from: inc/rules.open.hdr -->

# Official IOCCC rules

These rules are **OFFICIAL**.

Unless some significant problem turns up (such as a need to delay
in when the IOCCC will close, or some major bug is discovered) they
will remain **OFFICIAL** for this IOCCC.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[about asking questions](../faq.html#question)"
about these rules. You might also find the FAQ in general useful, especially the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)".

**SUGGESTION**: Watch both the [IOCCC news](../news.html) and the
[IOCCC Mastodon](https://fosstodon.org/@ioccc) feed for the latest news
about any _mentions_ changes.

**HINT to mastodon users**: You may wish to refresh the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) page and/or mastodon
app from time to time to view IOCCC mastodon updates.


# The IOCCC open for submissions

See "[FAQ - How may I enter the IOCCC](../quick-start.html#enter)"
for information on how to register for the IOCCC, how to create a proper
bzip2 compressed tarball of your submission, and how to upload your
bzip2 compressed tarball to the IOCCC submit server.

<!-- END: the next line ends content from: inc/rules.open.hdr -->
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
These [IOCCC rules](rules.html) are version **28.30 2025-03-03**.
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
# Goals of the IOCCC (International Obfuscated C Code Contest)
</div>

<p class="leftbar">
See the [IOCCC goals](../index.html#goals).
</p>

Jump to: [top](#)


<div id="dates">
# Important IOCCC dates
</div>

<p class="leftbar">
This IOCCC runs from **2024-12-29 23:58:13.213455 UTC** to **2025-06-05 04:03:02.010099 UTC**.
This IOCCC marks the **40th anniversary** of the contest!
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

To help us with the volume of submissions, we ask that you follow the rules below.

<div id="rule_abuse">
#### A warning about rule abuse
</div>

<p class="leftbar">
**WARNING:** Abusing these rules comes with a **fair amount of risk**
that your submission will be rejected.  If you do plan to abuse the
rules, then you **MUST CLEARLY EXPLAIN THE RATIONALE** in your `remarks.md` file,
as to why you think your rule abuse should be allowed, and as to why you think
your submission should not be rejected for a rule violation.
**Nevertheless, _even if you do_ explain this in your `remarks.md` file
you submission may still be rejected**.
</p>

<p class="leftbar">
If you use the most recently released official IOCCC submission packaging tool
(hereby referred to as `mkiocccentry(1)`), which we **STRONGLY recommend you
do**, then the `mkiocccentry(1)` tool will warn you if there appears to be a
violation in certain rules (not all can be detected).  The `mkiocccentry(1)`
tool also runs `chkentry(1)` and `txzchk(1)`, the latter of which runs
`fnamchk(1)`.  Overriding problems detected by any of these tools comes with a
**fair amount of risk** that your submission will be rejected.
</p>

<p class="leftbar">
If you do override a rule violation warning from the `mkiocccentry(1)` or
another related IOCCC tool, or otherwise plan to abuse the rules, then you
**MUST CLEARLY EXPLAIN THE RATIONALE** of why you are attempting to abuse the
rules in your `remarks.md` file.  **_Even if you do_ explain this in your
`remarks.md` file your submission may still be rejected**.
</p>

<p class="leftbar">
**HINT:** If you do submit such a rule abusing / rule violating
submission, then consider also submitting an alternate version in a
**different submission** server slot that does **NOT** violate the rules
in case your rule abuse excuse is rejected.
</p>
<p class="leftbar">
**IMPORTANT**: if you do submit such an alternate non-rule abusing version,
**PLEASE** indicate that in your `remarks.md` file of your non-rule abusing
version so that the [IOCCC judges](../judges.html) do not think you uploaded a
duplicate into a wrong slot by mistake.
</p>

<p class="leftbar">
Uploading a tarball not formed by `mkiocccentry(1)` puts you at a very big risk of
violating [Rule 17](rules.html#rule17), especially as `mkiocccentry(1)` does a
great number of things that are required, and it also runs many checks, and if
any of those checks fail, you are at a very great risk of having your submission
rejected for violating [Rule 17](rules.html#rule17).
</p>

<p class="leftbar">
See also [Rule 12](#rule13).
</p>


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
spec](https://github.com/xexyl/jparse/blob/master/json_README.md#so-called-json-spec) might be called obfuscated
by some people. :-)
</p>


Jump to: [top](#)


<div id="rule2">
## Rule 2
</div>

[Rule 2](#rule2) requires that your submission satisfy **BOTH** [Rule
2a](#rule2a) **AND** [Rule 2b](#rule2b).

<p class="leftbar">
You may check your code with respect to [Rule 2a](#rule2a) and [Rule
2b](#rule2b) prior to submitting your code by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:
</p>

``` <!---sh-->
    iocccsize prog.c
```

<p class="leftbar">
The source to `iocccsize(1)` may be found in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).
</p>

<p class="leftbar">
See also the
FAQ on "[how to further test your submission](../faq.html#mkiocccentry_test)"
for more more thorough testing, including [Rule 2](#rule2).
</p>


<p class="leftbar">
See also [Rule 2a](#rule2a), [Rule 2b](#rule2b), and [Rule 17](#rule17).
</p>

Jump to: [top](#)


<div id="rule2a">
## Rule 2a
</div>

<p class="leftbar">
The size of your program source **should NOT exceed 4993 bytes**.
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
See also [Rule 17](#rule17).
</p>

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
When the contest is **[open](../faq.html#open)**, the [submit server](https://submit.ioccc.org)
will email you your [submit server](https://submit.ioccc.org)
**Username** and **Initial password**.  **Please be patient** as it may take some time,
perhaps as much as a few days, for your registration to be processed and for that email to be sent.
</p>

<p class="leftbar">
Those who [register](register.html) while the contest status is **[pending](../faq.html#pending)**
will receive their email (containing their [submit server](https://submit.ioccc.org) **Username**
and **Initial password**), later: usually a few days around the time when the contest status
becomes **[open](../faq.html#open)**.
</p>

<p class="leftbar">
Once that email with your **Username** and **Initial password** is sent, you
will have **72 hours** to [change your submit server initial password](pw-change.html).
</p>

<p class="leftbar">
If you do not change your **Initial password** in time, **you will have
to [contact an IOCCC judge](../contact.html)** by email and ask them to reset
your password.  Not only is this a hassle for everyone involved, it will
delay your IOCCC registration process, perhaps by a number of days that
`egrep(1)` would be able to pattern match.  By `egrep(1)`, we refer to the
long standing **UNIX** utility that should just run and **NOT** whine about
the command being allegedly deprecated.
</p>

<p class="leftbar">
Because it takes time (maybe even a few days) to process your registration
and for the server to email you your initial login and password, you
should **MAKE SURE** you give yourself enough time to register well
before the contest closes.  In other words, **DO NOT WAIT UNTIL THE FINAL DAYS**
of the contest to register!  The [IOCCC judges](../judges.html)
are **NOT** responsible for delayed or lost email, or for those who wait
until the last minute to try to register!
</p>

<p class="leftbar">
See the
FAQ on "[how to register and submit to the IOCCC](../quick-start.html#enter)"
for instructions on registering and participating in the IOCCC, as the process
may change from contest to contest.
</p>

<p class="leftbar">
See also [Rule 8](#rule8).
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
Of course your program may also do this, as long as it works, but you're welcome
to use your `Makefile` as well.
</p>

<p class="leftbar">
See also [Rule 5](#rule5), [Rule 18](#rule18) and [Rule 21](#rule21).
</p>


Jump to: [top](#)


<div id="rule5">
## Rule 5
</div>

Your submission must **NOT** modify the _content_ **OR** _filename_ of **ANY**
part of your original submission including, but not limited to `prog.c`, the
`Makefile` or any data files you submit.

If you submission needs (or wishes :-) ) to modify such content, it **MUST**
first copy the file to a new filename and then modify that copy.

<p class="leftbar">
You may use your submission (program) to form a copy, or you can make use of
your `Makefile` to form that copy.
</p>

<p class="leftbar">
If you do make a copy of a submission file, **PLEASE** be sure that
the `clobber` rule of your `Makefile` removes that copy in order to
restore your submission to its original submission state.
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
You (the author(s)) **MUST** own the contents of your submission **OR**
you **MUST** have permission from the owner(s) to submit their content.
</p>

<p class="leftbar">
If you submit any content that is owned by others, you **MUST
detail that ownership** (i.e., who owns what) **_AND_ document the
permission you obtained from them**, in your `remarks.md` file.
</p>

<p class="leftbar">
Please note that the tools in [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) are **NOT** original works,
unless of course you're the original authors, in which case they are original. :-)
</p>

<p class="leftbar">
Nevertheless tools such as those listed are **NOT** obfuscated.  If submitted, they
would probably violate a number of rules.  :-)
</p>

- [mkiocccentry&lpar;1&rpar;](https://github.com/ioccc-src/mkiocccentry/blob/master/mkiocccentry.c)
- [iocccsize&lpar;1&rpar;](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)
- [chkentry&lpar;1&rpar;](https://github.com/ioccc-src/mkiocccentry/blob/master/chkentry.c)
- [txzchk&lpar;1&rpar;](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c)
- [location&lpar;1&rpar;](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/location_main.c)
- [jparse repo as cloned by the mkiocccentry repo](https://github.com/xexyl/jparse)
- [dbg repo as cloned by the mkiocccentry repo](https://github.com/lcn2/dbg)
- [dyn_array repo as cloned by the mkiocccentry repo](https://github.com/lcn2/dyn_array)

<p class="leftbar">
The IOCCC has a rich history of remarkable winning entries created by
authors who skillfully employed various techniques to develop their code.
While it is **NOT** required, you are _allowed_ to use tools to develop
and test your submission.  These tools may include, but are not limited
to code generators, code analysis tools, static code analysis tools,
runtime analysis tools, machine learning tools, natural language models,
code copilot tools, so-called AI services, large language models (LLMs), etc.
If you do make use of such tools or services, then we **ENCOURAGE you to describe
what tools and how you used those tools**, in your `remarks.md` file.
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
If you have [registered](register.html) and received by email your [submit
server](https://submit.ioccc.org) **Username** and **Initial password** you may
upload your submission to the [submit server](https://submit.ioccc.org) but
**ONLY** while the contest is **[open](../faq.html#open)**.
</p>

<p class="leftbar">
The [submit server](https://submit.ioccc.org), in accordance with [Rule
17](rules.html#rule17), places a limit of **3999971** bytes on the size of your
upload.
</p>

<p class="leftbar">
Once the contest is in the **[judging](../faq.html#judging)** state (or
**[closed](../faq.html#closed)** state), you may **NOT** upload submissions.
</p>

<p class="leftbar">
While the contest is **[open](../faq.html#open)** or in the
**[judging](../faq.html#judging)** state, the [IOCCC judges](../judges.html)
**MAY** (but are not required to) modify the slot comment of your submission to
indicate that they have received it.  If uploaded submission is malformed, the
[IOCCC judges](../judges.html) **MAY** (but are not required to) modify the slot
comment accordingly.
</p>

<p class="leftbar">
You are **STRONGLY** advised to use the `mkiocccentry(1)` tool
as found in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
to form the file to upload to the [submit server](https://submit.ioccc.org).
</p>

<p class="leftbar">
The [submit server](https://submit.ioccc.org) will become active when the
contest is **[open](../faq.html#open)**.  Until the contest status becomes
**[open](../faq.html#open)**, the [submit server](https://submit.ioccc.org) may
be offline and/or unresponsive.
</p>

<p class="leftbar">
See the
FAQs on "[obtaining, compiling, installing and using the latest release of the mkiocccentry tools](../faq.html#mkiocccentry)"
for more information about the `mkiocccentry(1)` tool.
</p>

<p class="leftbar">
See the "[Important IOCCC dates](#dates)" section above for when these contest states are scheduled.
</p>

<p class="leftbar">
See also [Rule 3](#rule3) and [Rule 17](#rule17).
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
If this seems unreasonable we suggest you wait until the next contest and in
the interim ponder this (modified or not) quote said by Bill Gates:
</p>

> 640K submissions ought to be enough for anybody.
>
>    -- Bill Gates s/640K/10/ (allegedly :-) )


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

<p class="leftbar">
Furthermore, if you need a supplementary program that you include, to have these
permissions, you will also have to explain this, because these bits are not
allowed in submissions and those bits will not be copied by `mkiocccentry(1)`.
</p>

<p class="leftbar">
See also [Rule 17](#rule17).
</p>

Jump to: [top](#)


<div id="rule12">
## Rule 12
</div>

**Legal** abuse of the rules is somewhat encouraged.  **A submission that, in
the opinion of the [judges](../judges.html), violates the rules WILL BE DISQUALIFIED**.
Submissions that attempt to abuse the rules **MUST** try to justify why
their rule abuse is legal, in the `remarks.md` file.

<p class="leftbar">
See also [the warning about rule abuse](#rule_abuse).
</p>

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
control-M's (i.e., lines with a trailing byte `015`) **might** be rejected.
</p>

<p class="leftbar">
Please do **NOT** put trailing control-M's on `prog.c`, `Makefile`, or
`remarks.md` files but instead end lines with a trailing newline (i.e.,
byte `012`) character.
</p>

<p class="leftbar">
As we do **NOT** use DOS, please also be sure that the `Makefile` and
`remarks.md` files end in final newline (i.e., byte `012`) character.
</p>

<p class="leftbar">
You are permitted, in order to try and squeeze your `prog.c` under
a [Rule 2a](#rule2a) and/or [Rule 2b](#rule2b) limit, to **NOT**
end your `prog.c` with a newline  (i.e., byte `012`) character.
If you need to do this, **PLEASE** document that in your `remarks.md` file and
if your compiler complains about this, document this too and update your
`Makefile` to account for this.
</p>


Jump to: [top](#)


<div id="rule15">
## Rule 15
</div>

<p class="leftbar">
In order to register for the IOCCC, you **MUST** have a valid email address.
</p>

<p class="leftbar">
The [judges](../judges.html) **are NOT responsible for delays in email**, so please plan
enough time accordingly.
</p>

<p class="leftbar">
See the
FAQ on "[how to register](../quick-start.html#register)"
for details.
</p>


Jump to: [top](#)


<div id="rule16">
## Rule 16
</div>

Submissions that are similar to previous winning IOCCC entries are discouraged.

<p class="leftbar">
You are allowed to resubmit to a later contest, a submission that
did not win the IOCCC.  If you do so, then you would be well advised
to try and enhance and improve your submission.
If you do resubmit something that did not previously win, then
you are **encouraged** to mention this in your `remarks.md` file
as this **sometimes** helps.
</p>

<p class="leftbar">
Resubmitting an improved submission that did not become an
IOCCC winning entry is a **time honored** tradition of the IOCCC.
There are some IOCCC winning entries that were submitted to multiple contests
before they were improved enough to "climb over" (as the expression
goes) all the other submissions for a given contest.
</p>

Jump to: [top](#)


<div id="rule17">
## Rule 17
</div>

<p class="leftbar">
Your submission must be in the form of a **xz compressed tarball** that
the **current released version** of the `mkiocccentry(1)` tool would generate.
The files, directories, and paths **MUST** conform to the limits imposed
by `mkiocccentry(1)` including but **NOT LIMITED** to their names, count,
path length, directory tree depth and permissions.
</p>

<p class="leftbar">
Your **xz compressed tarball** must be larger than **0** bytes and no larger
than **3999971** bytes.
</p>

<p class="leftbar">
The sum of the byte lengths of all files, after the **xz compressed tarball** is untarred,
must **NOT** exceed `27651*1024` bytes.
</p>

<p class="leftbar">
Your **xz compressed tarball** submission _file_ **MUST** pass the tests performed by
the current version of `txzchk(1)`.
</p>

<p class="leftbar">
Your **xz compressed tarball** submission _filename_ **MUST** pass the tests
performed by the current version of `fnamchk(1)`.
</p>

<p class="leftbar">
When your **xz compressed tarball** submission file is untarred, the
resulting _directory_ **MUST** pass the checks performed by the current version
of `chkentry(1)`.
</p>

<p class="leftbar">
The resulting `prog.c` file **MUST** pass the [Rule 2](#rule2) size checks performed by the current
version of `iocccsize(1)`.
</p>

<p class="leftbar">
The `.auth.json` and `.info.json` **MUST** be compatible with what the
current version of the `mkiocccentry(1)` tool would produce.  They **MUST
ALSO** pass the tests performed by the current version of `chkentry(1)`.
</p>

<p class="leftbar">
The required `Makefile` must **NOT** be empty.
</p>

<p class="leftbar">
The required `remarks.md` must **NOT** be empty.
</p>

<p class="leftbar">
You may **NOT** submit a tarball created by the `-d` or `-s seed` option of
`mkiocccentry(1)`.
</p>

<p class="leftbar">
The maximum number of files your submission tarball may contain, not counting
the optional files (`prog.alt.c`, `try.sh`, `try.alt.sh`) and the mandatory
files (`prog.c`, `Makefile`, `remarks.md`) is 31.
</p>

See the
FAQ on "[what extra files are and how to include more](../faq.html#extra-files)"
as well as the [guidelines on extra files](guidelines.html#extra-files)
for more details.

### TL;DR Rule 17 - Use `mkiocccentry(1)` to form your submission

<p class="leftbar">
Let the current version of the `mkiocccentry(1)` tool form your **xz
compressed tarball** submission file.
</p>

### Warning

<p class="leftbar">
Using command line flags or input prompts to override checks and
limits made by the above mentioned tools is **NOT** recommended
and may result in your submission being rejected by the [IOCCC
submit server](https://submit.ioccc.org) and/or the [IOCCC Judges](../judges.html).
</p>

<p class="leftbar">
See the
FAQ on the "[mkiocccentry toolkit](../faq.html#mkiocccentry)
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

> **[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**

<p class="leftbar">
See also [Rule 7](#rule7).
</p>


Jump to: [top](#)


<div id="rule19">
## Rule 19
</div>

<p class="leftbar">
The `remarks.md` file, a required non-empty file, must be written in
[Markdown format](https://www.markdownguide.org/basic-syntax/).
</p>

<p class="leftbar">
We currently use [pandoc&lpar;1&rpar;](https://pandoc.org) to automatically
convert markdown to HTML.  Please try to avoid submitting an HTML file
translation to any markdown file.  If you **MUST** submit such an HTML
translation, **PLEASE** mention this in your `remarks.md` file.
</p>

<p class="leftbar">
For any submission that wins the contest, we modify your `remarks.md` file and
rename it as `README.md` and then use [pandoc&lpar;1&rpar;](https://pandoc.org)
to generate the `index.html` file in the top level directory of your submission.
For this reason, `mkiocccentry(1)` will **NOT** package such files (in the top
level submission directory) and both `txzchk(1)` and `chkentry(1)` will flag
them as errors (in the top level submission directory) as well, so please do
**NOT** try and slip these files in the top level directory where your
`remarks.md` resides.
</p>

<p class="leftbar">
See the [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
for a handy quick reference to the Markdown syntax.
</p>

<p class="leftbar">
See the [Markdown guide](https://www.markdownguide.org)
for free and open-source reference guide that explains
how to use markdown.
</p>

<p class="leftbar">
See also the [Daring Fireball Markdown:
Basics](http://daringfireball.net/projects/markdown/basics) for
information on the markdown format.
</p>

<p class="leftbar">
**PLEASE** see our
FAQ on "[remarks.md](../faq.html#remarks_md)"
**AND** the
[IOCCC markdown guidelines](../markdown.html) for additional markdown guidance.
</p>


Jump to: [top](#)


<div id="rule20">
## Rule 20
</div>

The how to build instructions must be in GNU Makefile format. See the
FAQ about "[make&lpar;1&rpar; compatibility the IOCCC supports](../faq.html#make_compatibility)
for more details.

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
When `make clobber` is invoked, we request that your submission directory be restored
to its original submission state.  For example, any temporary files
created during the build process, or during execution should be
removed by the `clobber` rule.
</p>

<p class="leftbar">
Your `Makefile` **MUST** use a syntax that is compatible with `bash(1)`
**AND** GNU `make(1)`.  You are **ENCOURAGED** to use `SHELL= bash` in
your `Makefile`. Please add a space between the `=` and the value.
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

<p class="leftbar">
Your submission **MUST NOT** create or modify files **ABOVE** the current directory
_with the exception of_ the `/tmp` and the `/var/tmp` directories.  Your submission
**MAY** create subdirectories **below** the submission directory, or in `/tmp`,
or in `/var/tmp` provided that `.` is **NOT** the first byte in any
directory name or filename you create.
</p>

<p class="leftbar">
If you do create files and directories, **PLEASE** be sure that
the `clobber` rule of your `Makefile` removes such created files
in order to restore your submission to its original submission state.
</p>

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
The [IOCCC rule set](rules.html) needs more than `5^2` rules: see [Rule 26](#rule26).
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
[Rule 28](#rule28) is a perfect way to end the list of [IOCCC rules](rules.html)
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
**Be SURE** to review the [IOCCC Rules and Guidelines](index.html) as they
may (and **often do**) change from year to year.
</p>

<p class="leftbar">
**PLEASE** be **SURE** you have the **current** [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting to the contest.
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
Consider joining the IOCCC discord community via this link:
[https://discord.gg/Wa42Qujwnw](https://discord.gg/Wa42Qujwnw)
</p>

<p class="leftbar">
See the
FAQ on "[obtaining, compiling, installing and using the mkiocccentry tools](../faq.html#mkiocccentry)"
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
