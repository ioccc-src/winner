repo START: this line starts content from: inc/rules.closed.hdr -->

# WARNING: These rules are OUT OF DATE

These rules are a **VERY TENTATIVE proposal** for the next IOCCC
and are **VERY LIKELY** to be updated before the next IOCCC.
They are are provided as a **very tentative** hint at **what
MIGHT** be used in the next IOCCC.


# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the [IOCCC
winning entries page](../years.html) for the entries that have won the IOCCC in
the past.

Watch both [the IOCCC status page](../status.html) and the
[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about
future IOCCC openings.

<!-- END: the next line ends content from: inc/rules.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->
# 28th International Obfuscated C Code Contest Official Rules

**`|`**   Copyright &copy; 2024 Leonid A. Broukhis and Landon Curt Noll.

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing by [contacting the judges](../contact.html).


<div id="rule_version">
## IOCCC Rules version
</div>

**`|`**   These [IOCCC rules](rules.html) are version **2024-06-25-v28**.

**IMPORTANT**: Be sure to read the [IOCCC guidelines](guidelines.html).


### Change marks

**`|`**   **&larr; Lines that start with this symbol indicate a change from the previous IOCCC**

Most lines (we sometimes make mistakes) that were modified since the previous
IOCCC start with the **`|`** symbol.


# Obfuscate defined:

tr.v. -cated, -cating, -cates.
<BR><BR>
**1a.** To render obscure.<BR>
**1b.** To darken.
<BR><BR>
**2.** To confuse: his emotions obfuscated his judgment.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;[LLat. obfuscare, to darken : ob(intensive) + Lat. fuscare,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;to darken &lt; fuscus, dark.] -obfuscation n. obfuscatory adj.


# Goals of the Contest

The goals of the IOCCC:

*  To write the most Obscure/Obfuscated C program within the [IOCCC rules](rules.html).
*  To show the importance of programming style, in an ironic way.
*  To stress C compilers with unusual code.
*  To illustrate some of the subtleties of the C language.
*  To provide a safe forum for poor C code. :-)


# Important IOCCC dates

**`|`**   This IOCCC runs from **2024-MMM-DD HH:MM:SS UTC** to **202x-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**

**`|`**   Until the start of this IOCCC, these [IOCCC rules](rules.html),
[IOCCC guidelines](guidelines.html) and iocccsize.c (contained in the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) and invoked by the
`mkiocccentry(1)` tool) should be considered provisional **BETA** versions and
**may be adjusted _AT ANY TIME_**.

When the IOCCC is open, the submission URL is:
[https://submit.ioccc.org/](https://submit.ioccc.org/), at all other
times that link is likely to be unresponsive.

Please check the [How to enter FAQ](../faq.html#submit)
for **important information** on how to submit to the IOCCC.

**`|`**   The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**

Please wait to submit your entries until after that time.

The official [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) will be
available on the [official IOCCC website](../index.html) on or slightly before
the start of this IOCCC. The `mkiocccentry` toolkit may be obtained at any time
at the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

Please recheck on or after the start of this IOCCC to be sure you
are using the correct versions of these items before using the IOCCC
submission URL.


# IOCCC RULES

To help us with the volume of entries, we ask that you follow these rules:


## Rule 0

We need a rule 0.  :-)


<div id="rule1">
## Rule 1
</div>

Your submission must be a complete program.


<div id="rule2">
## Rule 2
</div>

The size rule requires your submission to satisfy **BOTH** [Rule 2a](#rule2a) and [Rule 2b](#rule2b):


<div id="rule2a">
## Rule 2a
</div>

**`|`**   The size of your program source **should not exceed 4993 bytes**.

**`|`**   If you use the most recently released official IOCCC submission packaging tool
(hereby referred to as `mkiocccentry(1)`), which we **STRONGLY recommend you use**,
then the `mkiocccentry(1)` tool will warn you if there appears to be a [Rule 2a](#rule2a) violation.

**`|`**   The `mkiocccentry(1)` tool will give you the option of overriding the [Rule 2a](#rule2a) warning.
Overriding a [Rule 2a](#rule2a) warning carries a **fair amount of risk** that your submission
will be **rejected**.  Be sure to consult the [IOCCC guidelines](guidelines.html)
ahead of time if you plan to override the [Rule 2a](#rule2a) warning.

**`|`**   If you do override the [Rule 2a](#rule2a) warning from the `mkiocccentry(1)` tool,
or otherwise plan to violate [Rule 2a](#rule2a), then you **must clearly explain the rationale**
of why you are doing so in your `remarks.md` file.  Even if you do explain this in your `remarks.md` file
your submission may still be rejected.

**`|`**   You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:

``` <!---sh-->
    ./iocccsize prog.c
```


<div id="rule2b">
## Rule 2b
</div>

**`|`**   When the filename of your program source is given as a command line argument to the latest version
of the official IOCCC size tool (hereby referred to as `iocccsize(1)`), the value printed **should not exceed 2503**.

**`|`**   The source to `iocccsize(1)` may be found in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

**`|`**   If you use the `mkiocccentry(1)` tool, which we **STRONGLY recommend you use**,
then `mkiocccentry(1)` will invoke `iocccsize(1)` before packaging your submission.

**`|`**   The `mkiocccentry(1)` tool will give you the option of overriding the [Rule 2b](#rule2b) warning.
Overriding a [Rule 2b](#rule2b) warning carries a **fair amount of risk** that your submission
will be **rejected**.  Be sure to consult the [IOCCC guidelines](guidelines.html)
ahead of time if you plan to override the [Rule 2b](#rule2b) warning.

**`|`**   If you do override the [Rule 2b](#rule2b) warning from the `mkiocccentry(1)` tool,
or otherwise plan to violate [Rule 2a](#rule2b), then you **must clearly explain the rationale**
of why you are doing so in your `remarks.md` file.  Even if you do explain this in your `remarks.md` file
your submission may still be rejected.

**`|`**   You may check your code prior to submission by giving the filename
as a command like argument to the `iocccsize(1)` tool. For example:

``` <!---sh-->
    ./iocccsize prog.c
```

<div id="rule3">
## Rule 3
</div>

Submissions should be performed using the instructions outlined at:
the [How to enter FAQ](../faq.html#submit).

To submit to an open IOCCC, you must use the [IOCCC submit server](https://submit.ioccc.org/).

When the IOCCC is not open, that link will likely be unresponsive.

**`|`**   The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**

Please wait to submit your entries until after that time.


<div id="rule4">
## Rule 4
</div>

**`|`**   If your submission is selected as a winner, it may be modified in order
for into the Makefile structure of the [Official IOCCC winner website](https://www.ioccc.org/index.html).

**`|`**   For example, your submission's 'Makefile' maybe be modified.

**`|`**   Your source code will be the file **prog.c**.  The compiled binary
will be called **prog**.  If you submission requires different filenames,
then modify your submission's 'Makefile' to **COPY** (**NOT** move)
the files accordingly.

**`|`**   See also [Rule 5](#rile5), [Rule 18](#rule18) and [Rule 21](#rule21).


<div id="rule5">
## Rule 5
</div>

Your submission **MUST** not modify the content or filename of any part of your
original submission including, but not limited to **prog.c**, the **Makefile**
(that we create from your how to build instructions), as well as any data
files you submit.

If you submission wishes to modify such content, it **MUST** first copy the
file to a new filename and then modify that copy.


<div id="rule6">
## Rule 6
</div>

**`|`**   I am not a rule, I am a `free(void *human);` ‼️

**`|`**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`while (!(ioccc(rule(you(are(number(6)))))) {`<br>
**`|`**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ha_ha_ha();`<br>
**`|`**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`}`


<div id="rule7">
## Rule 7
</div>

The obfuscated C program must be an original work that you own.

You (the author(s)) must own the contents of your submission OR
you must have permission from the owner(s) to submit their content
under the following license:

**`|`**   **[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**

If you submit any content that is owned by others, you **MUST**
detail that ownership (i.e., who owns what) **AND document the
permission you obtained**.

Please note that the IOCCC size tool is **NOT** an original work.


<div id="rule8">
## Rule 8
</div>

**`|`**   Entries must be received prior to the end of this IOCCC which is **2024-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**


A confirmation of submission will be sent to the submitting email address
before the close of the contest.


<div id="rule9">
## Rule 9
</div>

**`|`**   Each person may submit up to and including 10.000000 entries per contest.

Each submission must be submitted separately.


<div id="rule10">
## Rule 10
</div>

Entries requiring human interaction to be initially compiled are not permitted.


<div id="rule11">
## Rule 11
</div>

Programs that require special privileges (`setuid(2)`, `setgid(2)`, super-user,
special owner, special group, etc.) are still highly discouraged. We
do not guarantee these functions will behave as you expect on our test
platforms. If your program needs special permissions **please document
them** in the remarks file.


<div id="rule12">
## Rule 12
</div>

Legal abuse of the rules is somewhat encouraged.  An submission that, in
the opinion of the judges, violates the rules will be disqualified.
Entries that attempt to abuse the rules **MUST** try to justify why
their rule abuse is legal, in the submission's `remarks.md` file.


<div id="rule13">
## Rule 13
</div>

**`|`**   Any C source that fails to compile because of unescaped octets with
the high bit set (octet value >= 128) might be rejected.


<div id="rule14">
## Rule 14
</div>

**`|`**   Any C source that fails to compile because of lines with trailing
control-M's (i.e., lines with a tailing octet `015`) might be rejected.

Please do **NOT** put trailing control-M's on remarks file lines.
Please check to be sure, before submitting, that you have removed
any control-M at the end of remark file lines.


<div id="rule15">
## Rule 15
</div>

**`|`**   In order to register for the IOCCC, you **MUST** have a valid Email address.

The judges are not responsible for delays in email, please plan
enough time for one automated exchange of email as part of your
submission.

**`|`**  See [How may I register for the IOCCC?](../faq.html#register) in the
[FAQ](../faq.html) for details.


<div id="rule16">
## Rule 16
</div>

You are **STRONGLY** encouraged to submit a previously unpublished _AND_
original submission. Submissions that are similar to previous entries are
discouraged. As we judge anonymously, submissions that have already
been published may be disqualified.


<div id="rule17">
## Rule 17
</div>


### TL;DR Rule 17 - Use `mkiocccentry(1)`

**`|`**   This is a **COMPLEX** rule.  Violating this rule will cause your submission to **REJECTED**.
To help you avoid such a rejection, you are **HIGHLY ENCOURAGED** to use the `mkiocccentry(1)` tool,
based on the latest release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
to form your submission's bzip2 compressed tarball.

**`|`**   The [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
contains **IMPORTANT** tools such as:

* `chkentry(1)`
* `iocccsize(1)`
* `mkiocccentry(1)`
* `txzchk(1)`

**`|`**   The above mentioned tools will help you verify that your submission
conforms to [Rule 17](#rule17).

**`|`**   Each above mentioned tools has a **`-h`** that provides command line help.  For additional details, see the tool man pages.


### Rule 17 - The COMPLEX details

**`|`**   Each submission **MUST** be in the form of a bzip2 compressed tarball file.

**`|`**   The bzip2 compressed tarball filename must be of the form:

*  ^submit\." + _username_ + - + _slot_num_ + \.[1-9][0-9]{9,}\.txz$

where _`username`_ is the your IOCCC registration username in the form of a
[UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) (see
[RFC 9562](https://datatracker.ietf.org/doc/html/rfc9562) for
details), and where _`slot_num`_ is a single decimal digit integer
(i.e., >= 0 and < 9), and where _`+`_ is the concatenation operator,

**`|`**   Your bzip2 compressed tarball file **MUST** contain, at a minimum,
the following files:

* `Makefile`
* `prog.c`
* `remarks.md`
* `.info.json`
* `.auth.json`

**`|`**   The `.info.json` must be valid JSON and pass the `chkentry(1)` test.

**`|`**   The `.auth.json` must be valid JSON and pass the `chkentry(1)` test.

**`|`**   You submission may have additional files, however `basename(1)` of the filenames of those additional files **MUST**:

* Be less than **100** characters in length
* Match the regular expression: `^[0-9A-Za-z][0-9A-Za-z._+-]*$`

**`|`**   The `Makefile` must be a non-empty file in [Gnu Makefile](https://www.gnu.org/software/make/manual/make.html) form.

**`|`**   The `remarks.md` must be a non-empty file in markdown form.  See also [Rule 18](#rule18).

**`|`**   The bzip2 compressed tarball file **MUST** be less than
or equal **3999971** octets in size.

**`|`**   When your submission's bzip2 compressed tarball is uncompressed,
the total size of your submission: the sum of the size of the program,
hints, comments, build and info files **MUST** be less than or equal
to 28314624 octets (27651K) in size.

**`|`**   You are **HIGHLY ENCOURAGED** to use the `mkiocccentry(1)`
tool to form your submission's bzip2 compressed tarball.  The

**`|`**   You submission may have additional files, however filenames of those additional files **MUST**:

* be less than **100** characters in length
* conform to the regular expression: `^[0-9A-Za-z][0-9A-Za-z._+-]*$`

**`|`**   Your entry may have sub-directories, however the sub-directories **MUST** only
reside under the submission's top level directory.

**`|`**   The directory names of sub-directories path, **MUST**:

* Be less than **100** characters in length
* **NOT** start with: **`/`**
* **NOT** contain a path component of: **`.`**
* **NOT** contain a path component of: **`..`**
* Match the regular expression `^[0-9A-Za-z][0-9A-Za-z._+-]*$`.

**`|`**   The `Makefile` must be a non-empty file.

**`|`**   The `remarks.md` must be a non-empty file in markdown form.  See also [Rule 18](#rule18).

**`|`**   The bzip2 compressed tarball file **MUST** be less than
or equal **3999971** octets in size.

**`|`**   When your submission's bzip2 compressed tarball is uncompressed,
the total size of your submission: the sum of the size of the program,
hints, comments, build and info files **MUST** be less than or equal
to 28314624 octets (27651K) in size.

**`|`**  Your submission's bzip2 compressed tarball **MUST** pass the `txzchk(1)` test.

**`|`**  Where [Rule 17](#rule17) and the tools from the latest
release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)
conflict, the [IOCCC Judges](../judges.html) will use their best judgment which
is likely to favor [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) code.

**`|`**  To state the obvious: submissions that violate [Rule 17](#rule17) **will be rejected**,
so be sure to use the latest release of the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
to form and test your submission's bzip2 compressed tarball.


<div id="rule18">
## Rule 18
</div>

The entirety of your submission must be submitted under the following license:

**`|`**   **[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**

You (the author(s)) **MUST** own the contents of your submission **OR**
you **MUST HAVE PERMISSION** from the owner(s) to submit their content.

You must not submit anything that cannot be submitted under that license.


<div id="rule19">
## Rule 19
</div>

**`|`**  The `remarks.md` file, a required non-empty file, must be written in markdown format. See
the Daring Fireball [Markdown: Basics](http://daringfireball.net/projects/markdown/basics)
for more information.

**`|`**   We currently use [pandoc](https://pandoc.org) to convert markdown to HTML.

**`|`**   Please see our [IOCCC markdown guidelines](../markdown.html) for additional markdown guidance.


<div id="rule20">
## Rule 20
</div>

The how to build instructions must be in Makefile format. See [the FAQ about
make&#x28;1&#x29; compatibility the IOCCC
supports](../faq.html#make_compatibility) for more details.

**`|`**   You are **ENCOURAGED** to use
[Makefile.example](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example),
renamed as `Makefile` of course, for help in constructing your Makefile.

The target of the Makefile must be called `prog`.  The original
C source file must be called `prog.c`.

To invoke the C compiler, use `${CC}`.
To invoke the C preprocessor use `${CPP}`.

Do not assume that `.` (the current directory) is in the `$PATH`.

**`|`**   Your `Makefile` **MUST** use a syntax that is compatible with bash.  You are **ENCOURAGED** to use set `SHELL= bash` in your `Makefile.`

**`|`**   Assume that commands commonly found in [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) are
available in the `$PATH` search path.


<div id="rule21">
## Rule 21
</div>

Your submission must not create or modify files above the current directory
with the exception of the `/tmp` and the `/var/tmp` directories.  Your submission
**MAY** create subdirectories below the current directory, or in `/tmp`,
or in `/var/tmp` provided that `.` is **NOT** the first octet in any
directory name or filename you submit.


<div id="rule22">
## Rule 22
</div>

Catch 22:

Your source code, data files, remarks and program output must **NOT**
identify the authors of your code.  The judges **STRONGLY prefer** to
NOT know who is submitting entries to the IOCCC.

Even if you are a previous IOCCC winner, catch 22 still applies.

Identifying the author(s) of your submission in an obvious way anywhere
within your code, data, remarks or program output (unless you are
_Peter Honeyman_ or pretending to be _Peter Honeyman_) will be grounds
for disqualification of your submission.

Yes, Virginia, **WE REALLY MEAN IT!**


<div id="rule23">
## Rule 23
</div>

This prime rule number is reserved for future use.


<div id="rule24">
## Rule 24
</div>

Even though 24 is not prime, you should still see [Rule 23](#rule23).


<div id="rule25">
## Rule 25
</div>

**`|`**   The [IOCCC rule set](rules.html) needs more than 5^2 rules: see [Rule 26](#rule26).


<div id="rule26">
## Rule 26
</div>

**`|`**   "The quick brown fox jumps over the lazy dog".<br>
**`|`**   "Pack my box with five dozen liquor jugs."<br>
**`|`**   "How vexingly quick daft zebras jump!"<br>
**`|`**   "Sphinx of black quartz, judge my vow."<br>
**`|`**   "Waltz, bad nymph, for quick jigs vex."<br>
**`|`**   "Mr. Jock, TV quiz PhD, bags few lynx."<br>
**`|`**   "abcdefg, hijklmnop, qrstu&v, wxy&z."


<div id="rule27">
## Rule 27
</div>

**`|`**   Unless otherwise needed, [Rule 27](#rule27) is reserved for something cubic.  :-)


<div id="rule28">
## Rule 28
</div>

**`|`**   [Rule 28](#rule28) is a perfect way end to the list of [IOCCC rules](rules.html) as we do **NOT** plan to have **496** rules. :-)



# FOR MORE INFORMATION:

**`|`**   For questions or comments about the contest, see [Contacting the IOCCC](../contact.html).

**`|`**   Be sure to review the [IOCCC Rules and Guidelines](index.html) as
[IOCCC rules](rules.html) and the [IOCCC guidelines](guidelines.html) may (and often do) change from year to year.

**`|`**   You should be sure you have the current [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting entries.

**`|`**   See the [Official IOCCC website news](../news.html) for additional information.

**`|`**   For the updates and breaking IOCCC news, you are encouraged to follow
the [IOCCC on Mastodon](https://fosstodon.org/@ioccc) account.  See our
[FAQ](../faq.html#try_mastodon) for more information. Please do note that unless
you are mentioned by us you will **NOT** get a notification from the app so you
should refresh the page even if you do follow us.

**`|`**   Check out the [Official IOCCC winner website](https://www.ioccc.org/index.html) in general.


Leonid A. Broukhis<br>
chongo (Landon Curt Noll) `/\cc/\`


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)
