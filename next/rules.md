<!-- START: this line starts content from: inc/rules.closed.hdr -->

# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entries that have won the
IOCCC in the past.

These rules are a **TENTATIVE proposal** for the next IOCCC
and are **likely be to be updated** before the next IOCCC.

See our
FAQ on "[rules, guidelines and tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[asking questions](../faq.html#question)"
about these rules. You might also find the FAQ in general useful, especially the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)".

Watch both [the IOCCC status page](../status.html) and the
[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about
future IOCCC openings.

**HINT to mastodon users**: You may wish to refresh the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) page and/or mastodon
app from time to time to view IOCCC mastodon updates.

<!-- END: the next line ends content from: inc/rules.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->

# 29th International Obfuscated C Code Contest Official Rules

Copyright (c) 2025 Leonid A. Broukhis and Landon Curt Noll.

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this copyright and notice are included in its entirety
and remains unaltered.  All other uses **MUST** receive prior permission in
writing by [contacting the judges](../contact.html).


## Rules Version

These IOCCC Rules are version **29.09 2025-11-29**.

Reminder: be SURE to read the [IOCCC guidelines](guidelines.html).


<div id="rule0">
## Rule 0 - Dates
</div>

This IOCCC runs from `2025-12-03 20:25:12.045045 UTC` to `2026-03-13
17:19:23.293137 UTC`.

This contest will enter the **pending state** on `2025-12-03 20:25:12.045045 UTC`,
allowing people to register for the IOCCC.

This contest will enter the **open state** on `2025-12-15 18:21:24.273033 UTC`,
allowing people to upload submissions to the [IOCCC submit server](https://submit.ioccc.org).

This contest will enter the **judging state** on `2026-03-13 17:19:23.293137 UTC`,
when people will no longer be allowed to upload submissions.

Until the contest enters the **open** state, any or all
of the above **dates and times may change _AT ANY TIME_**!

The above timestamps are in "_YYYY-MM-DD HH:MM:SS.micros UTC_" format.

See the [current status of the IOCCC](../status.html).


<div id="rule1">
## Rule 1 - C program
</div>

Your submission **MUST** be a C program that does NOT `#include` data files.


<div id="rule2">
<div id="rule2-size-restrictions">
<div id="rule2-size">
## Rule 2 - Size restrictions
</div>
</div>
</div>

`Rule 2` requires that your submission satisfy **BOTH**
[Rule 2a &lpar;Gross Size&rpar;](rules.html#rule2a)
and
[Rule 2b &lpar;Net Size&rpar;](rules.html#rule2b).
During development this can be checked using `iocccsize(1)`:

``` <!---sh-->
    iocccsize prog.c
```

See the [Guidelines for Rule 2 - Size restrictions](guidelines.html#guideline-2---size).


<div id="rule2a">
<div id="rule2a-gross-size">
### Rule 2a - Gross Size
</div>
</div>

The overall maximum size of your `prog.c` program source **MUST NOT**
exceed **4993** bytes.

**NOTE**: by default `iocccsize` will only report the rule 2b size, unless the
code surpasses the limit.

See [Entering the IOCCC: the bare minimum you need to know](../quick-start.html#enter).


<div id="rule2b">
<div id="rule2b-net-size">
### Rule 2b - Net Size
</div>
</div>

When the filename of your program source (i.e., `prog.c`) is given as a
command line argument to the latest version of the official IOCCC size
tool (hereby referred to as `iocccsize(1)`), the value printed **MUST
NOT** exceed **2503**.

**NOTE**: `iocccsize` does **NOT** calculate the filename length. See [Rule 17 -
Use mkiocccentry](#rule17-mkiocccentry).


<div id="rule3">
<div id="rule3-register">
## Rule 3 - Register for the IOCCC
</div>
</div>

You **MUST** register, using a valid email address, in order to submit
to the IOCCC. You may register while the contest is **pending** or **open**.

A few days after registering, you'll receive your UUID username and
temporary password, which you **MUST** change within 14 days. If you
fail to change it in a timely manner, you'll need to
[contact the Judges](../contact.html) by email to request a reset.

It can take a few days to process your registration and for the server to
email your details, therefore make sure to allow yourself ample time to
register and submit your entries; **DO NOT WAIT UNTIL THE FINAL DAYS**
to register! The judges are **NOT** responsible for delayed or lost
email or for those who wait until the last minute to try to register!

See [Entering the IOCCC: the bare minimum you need to know](../quick-start.html#enter).

See [Rule 8 - Submitting requirements](rules.html#rule8).

See [Guidelines for Rule 3 - Register for the IOCCC](guidelines.html#guideline-3---register).


<div id="rule4">
<div id="rule4-required-files">
## Rule 4 - Required files
</div>
</div>

Your submission **MUST** include at least these files: `Makefile`, `prog.c`,
`remarks.md`,`.info.json`, and `.auth.json`, the latter two of which are
generated by `mkiocccentry(1)`. See [Rule 17 -
Use mkiocccentry](#rule17-mkiocccentry).

At a **minimum** the following requirements apply.  Additional requirements
may be imposed by `mkiocccentry(1)` updates that have yet to be listed
below.

**NOTE**: `mkiocccentry(1)` will reject any directory which has prohibited
files.

**NOTE**: by 'top directory' we mean the directory with `prog.c`, `Makefile`,
`remarks.md` and the `mkiocccentry(1)` generated files `.auth.json` and
`.info.json` and **NOT** the `topdir` arg to `mkiocccentry(1)`.


* `.info.json` and `.auth.json` **MUST** be generated by `mkiocccenty(1)`
when packing a submission. When `chksubmit(1)` is run on the submission
directory  **ALL** tests must pass and if there is **ANY** problem with these
JSON files or if either is missing it will fail. See [Rule 17 - use
mkiocccentry](#rule17-mkiocccentry).

* The `Makefile`, `remarks.md`,`.info.json`, and `.auth.json` **MUST**
have a file size **greater than 0** and **MUST** have content. Note that
`mkiocccentry(1)` will check for file **size** but will **NOT** check for
content.

* Your submitted source code **MUST** be called `prog.c`. When the `Makefile`
compiles your code, the executable (if applicable) **MUST** be called `prog`.
The `Makefile` may compile your source code into other filenames as well, if you
want.

* As `prog`, `prog.alt`, `prog.alt.o`, `prog.o` may be created by your
`Makefile`, your submission **MUST NOT** include those files in your **top**
directory.

* Your submission may **NOT** have any file that starts with `COPYING`,
`COPYRIGHT`, or `LICENSE` as those files are reserved by IOCCC.

* Your submission may **NOT** have in the **top** directory: `prog.orig.c`,
`README.md` or `index.html` as those files are reserved by the IOCCC.

* Your submission may **NOT** have in the **top** directory any file
that matches a file glob pattern form `[0-9][0-9][0-9][0-9]_*.tar.bz2`
as those files are reserved by IOCCC.

* Your submission may **ONLY** contain files and directories.  Other file
types such as symlinks, sockets etc. are **NOT** allowed.

* **All** directories **MUST** have permission mode of **0755**.  All files
**MUST** have the file mode of **0444**, EXCEPT for files that
end in `.sh` which must have a mode of **0555**.

* All files that end in `.md` **MUST** be in markdown format.
We recommend that markdown files observe our
[IOCCC markdown guidelines](../markdown.html).

* All filenames are treated as case insensitive.  For example, `REMARKS.MD`,
and `Remarks.md`, and `remarks.md` are considered by `mkiocccenty(1)`
to be the **SAME** file.  When preparing a submission on a case
sensitive filesystem, ensure that the submission will work on
a case insensitive filesystem.

The `remarks.md` and `Makefile` are explained in more detail in the Guidelines.

See [IOCCC markdown guidelines](../markdown.html).

See [Rule 17 - Use mkiocccentry](rules.html#rule17-mkiocccentry).

See the
FAQ on "[What permissions may my files be and what if I need different permissions?](../faq.html#file_perms)".

See the [Guidelines on the mkiocccentry toolkit](guidelines.html#mkiocccentry_toolkit).

See the [Guidelines on the Makefile](guidelines.html#makefile).


<div id="rule5">
<div id="rule5-modifying-files">
## Rule 5 - Do NOT modify submitted files or filenames or parent directories
</div>
</div>

Your submission **MUST NOT** modify the filenames or content of any of your
original submission, such as `prog.c`, `Makefile`, or **ANY** other supplied
files. To modify files, your program can make a copy or you can use the
`Makefile` to setup working copies.  Any working copies **MUST** be cleaned up
by the `Makefile` `clobber` target, so as to restore the directory to its
original state.

Your submission **MUST NOT** create or modify directories and files
ABOVE the current directory (with the exception of the `/tmp` and the `/var/tmp`
directories and as long as the directory name or filename does **NOT** start
with a `.` (dot)).

The `Makefile` `clobber` target **MUST** restore your submission to its
original form, including the removal of any created files and directories.

Your code should be able to run under a
[SUS environment](https://pubs.opengroup.org/onlinepubs/9799919799/).


<div id="rule6">
<div id="rule6-free-rule">
## Rule 6 - Free Rule
</div>
</div>

I am **NOT** a Rule, I am a `free(void *human);` ‼️

``` <!---c-->
    while (!(ioccc(rule(you(are(number(6)))))) {
        ha(); ha(); ha();
    }
```
See [Rule 19 - Prime](rules.html#rule-19---prime).


<div id="rule7">
<div id="rule7-original-work">
## Rule 7 - Original Work
</div>
</div>

You, the author(s), **MUST** own the contents of your submission, **OR**, IF you
do **NOT** own the work, then you **MUST** have permission from the original
owner(s) to its use.  If you submit **ANY** content that is owned by others, you
**MUST** detail that ownership, i.e., who owns what, and document the permission
you obtained from them in your `remarks.md` file.

You are permitted to use tools to write your code.

See [Rule 16 - Anonymous Judging](rules.html#rule16-anonymous-judging).

See [Guidelines for Rule 7 - Original Work](guidelines.html#guideline-7---original-work).


<div id="rule8">
<div id="rule8-submitting-requirements">
## Rule 8 - Submitting requirements
</div>
</div>

The submit server will accept submissions **ONLY** from those who have
registered and **ONLY** while the contest is open.

The submit server places a total size limit of **3999971** bytes **PER**
submission.

Each account has ten (**10.000**) submission slots (**0..9)**.  Each submission
slot should be annotated by the server as to whether its was received,
processed, malformed, etc.  Please take note of any errors, rectify,
and resubmit. In order to avoid potential packaging errors, it is **highly
recommended** to use `mkiocccentry(1)`, **AND** to check from time to time the
status on the submit server, to see if any tests run by the server failed to
validate your submission.

Do **NOT** register more than one account!

See
[Rule 3 - Registering for the IOCCC](rules.html#rule3-register),
[Rule 15 - GNU Makefile compatibility](rules.html#rule15-gnu-makefile),
and
[Rule 17 - Use mkiocccentry](rules.html#rule-17-mkiocccentry).


<div id="rule9">
## Rule 9 - No interactive compiling allowed
</div>

Entries requiring human interaction to be initially compiled are **NOT**
permitted. However, see the guidelines. Each entry **MUST** automate the
build process using `bash`, `gmake`, `gcc` and/or `clang` and other commonly
available tools under an [SUS
environment](https://pubs.opengroup.org/onlinepubs/9799919799/).

**NOTE**: The references to `gmake(1)` can be any GNU Make compatible tool.

**NOTE**: it is better to use the `${MAKE}` variable as then one may override
the make command.

**NOTE**: it is better and more portable to **NOT** modify the `${CC}` variable
in the Makefile.

See [Rule 15 - GNU Makefile compatibility](rules.html#rule-15---building).


<div id="rule10">
## Rule 10 - Program file permissions
</div>

Programs that require special privileges (`setuid(2)`, `setgid(2)`,
super-user, special owner, special group, etc.) are **HIGHLY DISCOURAGED**.
We do **NOT** guarantee these functions will behave as you expect on our
test platforms. If your program needs special permissions you **MUST**
document this fact and explain why it is needed in your submission’s
`remarks.md` file, preferably close to the top.

Furthermore, if you need a supplementary program that you include to
have these permissions, you will also have to explain this as well, because these
bits are **NOT** allowed in submissions and those bits will **NOT** be copied by
`mkiocccentry(1)`.

See [Rule 4 - Required files](rules.html#rule4-required-files),
and
[Rule 5 - Do NOT modify files](rules.html#rule5-modifying-files).


<div id="rule11">
<div id="rule11-legal-rule-abuse">
## Rule 11 - Legal rule abuse
</div>
</div>

Legal abuse of the rules is **somewhat** encouraged, but comes with risks.
A submission that, in the opinion of the Judges, **violates** the rules **WILL
BE DISQUALIFIED**.  Submissions that plan to abuse the rules **MUST** justify
why their rule abuse is legal (or interesting) in the `remarks.md` file.

Submission packaging abuse will **NOT** be tolerated and for this reason,
amongst many others, it is recommended that you use `mkiocccentry(1)`.  During
development you can check your `prog.c` size limits using `iocccsize(1)`, e.g.,
`iocccsize -v1 prog.c`.  Overriding problems detected by any of the IOCCC tools
risks that the submission will be rejected.

If you do submit a rule abusing or violating submission, then consider
also submitting an alternate version in a different submission server
slot that does **NOT** violate the rules in case your rule abuse excuse
is rejected.

**IMPORTANT**: If you do submit such an alternate non-rule abusing
version, **PLEASE** indicate that in your `remarks.md` file of your non-rule
abusing version so that the Judges don't think you uploaded a duplicate into a
wrong slot by mistake.

See [Guidelines for Rule 11 - Legal rule
abuse](guidelines.html#guideline-11---abuse).


<div id="rule12">
<div id="rule12-utf8">
## Rule 12 - UTF-8
</div>
</div>

Use of UTF-8 is supported by `C89` standard and its updates and so too by the
IOCCC.


<div id="rule13">
## Rule 13 - No carriage returns in prog.c
</div>

Any C source that fails to compile because lines contain carriage-returns
(CTRL+M, `\r`) in particular as part of DOS/Windows style newlines might
be rejected.  Please do **NOT** put trailing CTRL+M in `prog.c`, `Makefile`,
or `remarks.md` files, but instead end lines with Unix newline (line-feed,
CTRL+J, `\n`).

You are permitted, in order to try and squeeze your `prog.c` under a
[Rule 2a Gross Size](rules.html#rule-2a-gross-size) and/or
[Rule 2b Net Size](rules.html#rule-2b-net-size)
limits, to **NOT** end source with a newline. If you
need to do this, please document that in your `remarks.md` file and if
your compiler complains about this, document this too and update your
`Makefile` to account for this.


<div id="rule14">
## Rule 14 - Resubmitting lost submissions
</div>

Submissions that are substantially similar to previous winning IOCCC
entries are discouraged.

You are allowed to resubmit to a later contest, a submission that didn't win the
IOCCC. If you do so, then you would be **WELL ADVISED** to try and enhance and
improve your submission. If you do resubmit something that didn't previously
win, then you are encouraged to mention this in your `remarks.md` file as this
**sometimes** helps.


<div id="rule15">
<div id="rule15-gnu-makefile">
## Rule 15 - GNU Makefile
</div>
</div>

The `Makefile` **MUST** adhere to GNU Makefile syntax. It's highly recommended
that you copy the [Makefile.example](Makefile.example) as a template, renaming
it to `Makefile`. The primary target of the `Makefile` **MUST** be `prog` and
the source file is `prog.c`.  The C compiler and preprocessor **MUST** be
invoked using `${CC}` and `${CPP}` macros respectively.

The `clobber` target **MUST** clean and restore the submission directory tree to
its original state, such as removing temporary files or any modified data files.
Don't assume that `git` tool chain is installed, i.e. do **NOT** expect `git
clean -f` to work. To be clear: do **NOT** use `git` to clean out files as this
can cause problems in the winner repo!

The `Makefile` **MUST** use a syntax that is compatible with
`bash(1)` and GNU `make(1)`. You are encouraged to use `SHELL=
bash` in your `Makefile`; please add a space between the `=` and
the value such as:

``` <!---makefile-->
    SHELL= bash
```
Assume that commands commonly found in [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems are available in the search
`$PATH`. Avoid command options that aren't part of
[SUS](https://en.wikipedia.org/wiki/Single_UNIX_Specification), such as
GNU long name options (such as `--example`) or extensions like `grep -P`.

Do **NOT** assume that `.` (current directory) is in the `$PATH` environment
variable.

See [Rule 4 - Required files](rules.html#rule4-required-files).

See FAQ on "[What are the detailed recommendations for a submission Makefile?](../faq.html#makefile_details)".

See [Guidelines for Rule 15 - GNU Makefile compatibility](guidelines.html#guideline-15---building).


<div id="rule16">
<div id="rule16-anonymous-judging">
## Rule 16 - Anonymous judging
</div>
</div>

Your source code, data files, remarks, and program output **MUST NOT**
identify the author(s) of your code (unless you are **Peter Honeyman**
or pretending to be **Peter Honeyman**). In order to be impartial the
[Judges](https://www.ioccc.org/judges.html) do **NOT** know who is submitting
programs to the IOCCC until final selection is made, and **only** submissions
that won.

Even if you are a past winner, you **MUST NOT** reveal your identity
deliberately or by accident anywhere in your submission. **_Failure to comply
may result in the submission being disqualified_**.


<div id="rule17">
<div id="rule17-mkiocccentry">
## Rule 17 - Use `mkiocccentry`
</div>
</div>

TL;DR: use `mkiocccentry(1)` to package your submission.

The files, directories, and paths **MUST** conform to the limits imposed by
`mkiocccentry(1)`, including but **NOT** limited, to their names, count, path
length, directory tree depth, and permissions.

The submission tree may have at most **13** directories and maximum
directory depths of **4**. The maximum number of files, excluding
`prog.c`, `remarks.md`, `Makefile`, `prog.alt.c`, `try.sh`, `try.alt.sh`,
`.info.json` and `.auth.json` is **31**.  And the maximum file-path
component is **38** and maximum path length is **60**.

The submission **MUST** be a `.txz` compressed tarball (i.e., tarball compressed by `xz(1)`)
as constructed by `mkiocccentry(1)`, which **MUST** be within **[1..3999971]** bytes in size.

The tarball **MUST** be a **v7 format** tarball, and any supplementary tarballs
you provide **MUST** also be **v7 format**.

The sum of all file lengths, after unpacking from the tarball, **MUST** be
less than `27651*1024` (**28314624**) bytes.

The submission **MUST** pass all `txzchk(1)` checks, and the tarball filename
**MUST** pass all `fnamchk(1)` checks as well.

You may **NOT** submit a tarball created by the `-d`, `-e` **OR** by the `-s
seed` options of `mkiocccentry(1)`.

The unpacked submission directory **MUST** pass the checks performed by the
minimum required version of `chksubmit(1)`.

Submissions may **NOT** use a [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) command line options that
are labelled as "**for TESTING purposes**", **OR** labelled as "**for the use by
the IOCCC judges only**", in their respective man pages.

Submissions may **ONLY** use [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) command lines that confirm
to the command's `-h` "_print help message_", again notwithstanding the options
for testing and the IOCCC judges.

The `prog.c` file **MUST** pass the [Rule 2 - Size](rules.html#rule-2---size)
checks performed by `iocccsize(1)`.

The `.auth.json` and `.info.json` files **MUST** be compatible with what
`mkiocccentry(1)` generates.

Any submission that fails to pass the checks performed by the minimum required
version of the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
**WILL be rejected**!

See [Rule 4 - Required files](rules.html#rule4-required-files).

See the
FAQ on "[What is the mkiocccentry tool, how do I obtain it and how do I use it?](../faq.html#mkiocccentry)".

See the [Guidelines for Rule 17 - Use mkiocccentry](guidelines.html#guideline-17---packaging).


<div id="rule18">
## Rule 18 - Submission license
</div>

The entirety of your submission **MUST** be submitted under the following license:

[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)

See [Rule 7 - Original Work](rules.html#rule-7---original-work).


<div id="rule19">
## Rule 19 - Prime
</div>

This 19th rule, while prime, is reserved for future abuse 😁.
Additional rules, both humorous and otherwise, may be added
below this rule in future contests.

See [Rule 6 - Free Rule](rules.html#rule6-free).


## Further Reading

Please read the [Guidelines](guidelines.html) next for further commentary on these rules.

Read the
[Entering the IOCCC: the bare minimum you need to know](https://www.ioccc.org/quick-start.html#enter)
for an overview of how to enter the contest.

See also the [FAQ](../faq.html).

And now [for something completely different](guidelines.html#fun)

Consider joining the [IOCCC Discord Server](https://discord.com/invite/Wa42Qujwnw)
for discussions about The Rules, questions for the Judges, and `C` in general.

Leonid A. Broukhis
chongo (Landon Curt Noll) /\\cc/\\
