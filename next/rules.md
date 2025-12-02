<!-- START: this line starts content from: inc/rules.closed.hdr -->

# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entries that have
won the IOCCC in the past.

These rules are a **TENTATIVE proposal** for the next IOCCC and are
**likely be to be updated** before the next IOCCC.

See our
FAQ on "[rules, guidelines, tools feedback](../faq.html#feedback)"
as well as our
FAQ on "[about asking questions](../faq.html#question)"
about these rules. You might also find the FAQ in general useful,
especially the
FAQ on "[how to enter the IOCCC](../quick-start.html#enter)".

Watch both [the IOCCC status page](../status.html) and the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) for information about
future IOCCC openings.

**HINT to mastodon users**: You may wish to refresh the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) page and/or mastodon app
from time to time to view IOCCC mastodon updates.

<!-- END: the next line ends content from: inc/rules.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->

# 29th International Obfuscated C Code Contest Official Rules

Copyright (c) 2025 Leonid A. Broukhis and Landon Curt Noll.

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this copyright and notice are included in its entirety
and remains unaltered.  All other uses **MUST** receive prior permission in
writing by [contacting the judges](../contact.html).


## Rules Version

These IOCCC Rules are version **29.14 2025-12-02**.

<p class="leftbar">
The <span style='font-size:28px;'><b>&verbar;</b></span> symbol
indicates a **change** from the previous IOCCC.
</p>

<p class="leftbar">
Because the **IOCCC29** rules was a substantial rewrite, only
**important changes** from **IOCCC28** have been marked.
</p>

Reminder: be SURE to read the [IOCCC guidelines](guidelines.html).


<div id="rule0">
## Rule 0 - Dates
</div>

<p class="leftbar">
This IOCCC runs from `2025-12-03 20:25:12.045045 UTC` to `2026-03-13
17:19:23.293137 UTC`.
</p>

<p class="leftbar">
This contest will enter the [pending state](../faq.html#pending) on
`2025-12-03 20:25:12.045045 UTC`, allowing people to [register for the
IOCCC](register.html).
</p>

<p class="leftbar">
This contest will enter the [open state](../faq.html#open) on
`2025-12-15 18:21:24.273033 UTC`, allowing people to [upload
submissions](submit.html).
</p>

<p class="leftbar">
This contest will enter the [judging state](../faq.html#judging) on
`2026-03-13 17:19:23.293137 UTC`, when people will no longer be allowed
to upload submissions.
</p>

The above **dates and times may change _AT ANY TIME_** until the
[contest status](../status.html) is **open**.

<p class="leftbar">
The above timestamps are in "_YYYY-MM-DD HH:MM:SS.micros UTC_" format.
</p>

See [Entering the IOCCC: the bare minimum you need to
know](../quick-start.html#enter).

See
FAQ on "[How can I comment or make a suggestion on IOCCC rules,
guidelines and tools?](../faq.html#feedback)".


<div id="rule1">
<div id="rule1-c">
## Rule 1 - C program
</div>
</div>

<p class="leftbar">
Your submission **MUST** be a C program.
</p>

See the [Guidelines for Rule 1 - C
program](guidelines.html#guideline1-c).


<div id="rule2">
<div id="rule2-size-restrictions">
<div id="rule2-size">
## Rule 2 - Size restrictions
</div>
</div>
</div>

`Rule 2` requires that your submission satisfy **BOTH** [Rule 2a
&lpar;Gross Size&rpar;](rules.html#rule2a) and [Rule 2b &lpar;Net
Size&rpar;](rules.html#rule2b).

During development this can be checked using `iocccsize(1)`:

``` <!---sh-->
    iocccsize prog.c
```

See the [Guidelines for Rule 2 - Size
restrictions](guidelines.html#guideline2-size).


<div id="rule2a">
<div id="rule2a-gross-size">
### Rule 2a - Gross Size
</div>
</div>

The overall maximum size of your `prog.c` program source **MUST NOT**
exceed **4993** bytes.

See [Entering the IOCCC: the bare minimum you need to
know](../quick-start.html#enter).


<div id="rule2b">
<div id="rule2b-net-size">
### Rule 2b - Net Size
</div>
</div>

Check your source code using the latest official IOCCC size tool,
`iocccsize(1)`. The value printed **MUST NOT** exceed **2503**.

See [Rule 17 - Use mkiocccentry](#rule17-mkiocccentry).


<div id="rule3">
<div id="rule3-register">
## Rule 3 - Register for the IOCCC
</div>
</div>

You **MUST** register, using a valid email address, in order to submit
to the IOCCC. You may register while the contest is **pending** or
**open**.

A few days after registering, you'll receive your UUID username and
temporary password, which you **MUST** change within 14 days.

See [How to register for the IOCCC](register.html).

See [Entering the IOCCC: the bare minimum you need to
know](../quick-start.html#enter).

See [Guidelines for Rule 3 - Register for the
IOCCC](guidelines.html#guideline3-register).


<div id="rule4">
<div id="rule4-required-files">
## Rule 4 - Required files
</div>
</div>

<p class="leftbar">
Your submission **MUST** include at least these files: `Makefile`,
`prog.c`, `remarks.md`,`.info.json`, and `.auth.json`, the latter two
of which are generated by `mkiocccentry(1)`. See [Rule 17 - Use
mkiocccentry](#rule17-mkiocccentry).
</p>

<p class="leftbar">
At a **minimum** the following requirements apply.  Additional
requirements may be imposed by `mkiocccentry(1)` updates that have yet
to be listed below:
</p>

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* `.info.json` and `.auth.json` **MUST** be generated by
`mkiocccenty(1)` when packing a submission. When `chksubmit(1)` is run
on the submission directory  **ALL** tests must pass and if there is
**ANY** problem with these JSON files or if either is missing it will
fail. See [Rule 17 - use mkiocccentry](#rule17-mkiocccentry).

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* The `Makefile`, `remarks.md`,`.info.json`, and `.auth.json` **MUST**
have a file size **greater than 0** and **MUST** have content. Note
that `mkiocccentry(1)` will check for file **size** but will **NOT**
check for content.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* Your submitted source code **MUST** be called `prog.c`. When the
`Makefile` compiles your code, the executable (if applicable) **MUST**
be called `prog`.  The `Makefile` may compile your source code into
other filenames as well, if you want.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* As `prog`, `prog.alt`, `prog.alt.o`, `prog.o` may be created by your
`Makefile`, your submission **MUST NOT** include those files in your
**top** directory.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* Your submission may **NOT** have any file that starts with `COPYING`,
`COPYRIGHT`, or `LICENSE` as those files are reserved by IOCCC.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* Your submission may **NOT** have in the **top** directory:
`prog.orig.c`, `README.md` or `index.html` as those files are reserved
by the IOCCC.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* Your submission may **NOT** have in the **top** directory any file
that matches a file glob pattern form `[0-9][0-9][0-9][0-9]_*.tar.bz2`
as those files are reserved by IOCCC.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* Your submission may **ONLY** contain files and directories.  Other
file types such as symlinks, sockets etc. are **NOT** allowed.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* **All** directories **MUST** have permission mode of **0755**.  All
files **MUST** have the file mode of **0444**, EXCEPT for files that
end in `.sh` which must have a mode of **0555**.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* All files that end in `.md` **MUST** be in markdown format.

<span style='font-size:28px;'><b>&verbar;</b></span>&nbsp;&nbsp;
* All filenames are treated as case insensitive.  For example,
`REMARKS.MD`, and `Remarks.md`, and `remarks.md` are considered by
`mkiocccenty(1)` to be the **SAME** file.  When preparing a submission
on a case sensitive filesystem, ensure that the submission will work on
a case insensitive filesystem.

<p class="leftbar">
**NOTE**: by 'top directory' we mean the directory with `prog.c`,
`Makefile`, `remarks.md` and the `mkiocccentry(1)` generated files
`.auth.json` and `.info.json` and **NOT** the `topdir` arg to
`mkiocccentry(1)`.
</p>

<p class="leftbar">
**NOTE**: `mkiocccentry(1)` will reject any directory which has
prohibited files.
</p>

The `remarks.md` and `Makefile` are explained in more detail in the
[Guidelines](guidelines.html).

See [IOCCC markdown guidelines](../markdown.html).

See [Rule 17 - Use mkiocccentry](rules.html#rule17-mkiocccentry).

See the
FAQ on "[What permissions may my files be and what if I need different
permissions?](../faq.html#file_perms)".

See the
FAQ on "[What are the detailed recommendations for a submission
Makefile?](../faq.html#makefile_details)".

See the [Guidelines on the mkiocccentry
toolkit](guidelines.html#mkiocccentry_toolkit).


<div id="rule5">
<div id="rule5-modifying-files">
## Rule 5 - Do NOT modify submitted files, filenames or parent directories
</div>
</div>

Your submission **MUST NOT** modify the filenames or content of any of
your original submission, such as `prog.c`, `Makefile`, or **ANY**
other supplied files. To modify files, your program can make a copy or
you can use the `Makefile` to setup working copies.  Any working copies
**MUST** be cleaned up by the `Makefile` `clobber` target, so as to
restore the directory to its original state.

With the exception of the `/tmp` and the `/var/tmp` directories,
assuming the directory name or filename does **NOT** start with a `.`
(dot), your submission **MUST NOT** create or modify directories and
files ABOVE the current directory.

The `Makefile` `clobber` target **MUST** restore your submission to its
original form, including the removal of any created files and
directories.

<p class="leftbar">
Your code should be able to run under a [SUS
environment](https://pubs.opengroup.org/onlinepubs/9799919799/).
</p>


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
See [Rule 19 - Prime](rules.html#rule19-prime).


<div id="rule7">
<div id="rule7-original-work">
## Rule 7 - Original Work
</div>
</div>

<p class="leftbar">
You, the author(s), **MUST** own the contents of your submission,
**OR**, IF you do **NOT** own the work, then you **MUST** have
permission from the original owner(s) to its use.  If you submit
**ANY** content that is owned by others, you **MUST** detail that
ownership, i.e., who owns what, and document the permission you
obtained from them in your `remarks.md` file.
</p>

<p class="leftbar">
You are permitted to use tools to write your code.
</p>

See [Rule 16 - Anonymous Judging](rules.html#rule16-anonymous-judging),
and
[Guidelines for Rule 7 - Original
Work](guidelines.html#guideline7-original).


<div id="rule8">
<div id="rule8-submitting-requirements">
## Rule 8 - Submitting requirements
</div>
</div>

The submit server will accept submissions **ONLY** from those who have
registered and **ONLY** while the contest is open and **ONLY** after
you have changed your initial password.

The submit server places a total size limit of **3999971** bytes
**PER** submission.

<p class="leftbar">
Each account has ten (**10.000**) submission slots (**0..9)**.
</p>

<p class="leftbar">
Each submission slot should be annotated by the server as to whether it
was received, processed, malformed, etc.  Please take note of any
errors, rectify, and resubmit.
</p>

<p class="leftbar">
In order to avoid potential packaging errors, it is **highly
recommended** to use `mkiocccentry(1)`, **AND** to check from time to
time the status on the submit server, to see if any tests run by the
server failed to validate your submission.
</p>

See
[Rule 3 - Registering for the IOCCC](rules.html#rule3-register),
[Rule 15 - GNU Makefile](rules.html#rule15-gnu-makefile),
and
[Rule 17 - Use mkiocccentry](rules.html#rule17-mkiocccentry).

See [Guidelines for Rule 8 - Submitting
requirements](guidelines.html#guideline8-submitting).


<div id="rule9">
<div id="rule9-no-interactive">
## Rule 9 - No interactive compiling allowed
</div>
</div>

Entries requiring human interaction to be initially compiled are **NOT**
permitted. However, see the [guidelines on rule
9](guidelines.html#guideline9-no-interactive) as you
**may** suggest alternative compilation steps to do something fun or
cute.

Each entry **MUST** automate the build process using `bash`, `gmake`,
`gcc` and/or `clang` and other commonly available tools under an [SUS
environment](https://pubs.opengroup.org/onlinepubs/9799919799/).

**NOTE**: any reference to `gmake(1)` can be any GNU Make compatible
tool.

**NOTE**: it is better to use the `${MAKE}` variable as then one may
override the `make` command.

**NOTE**: it is better to **NOT** modify `${CC}` in your Makefile as
this makes your program more portable.

See [Rule 15 - GNU Makefile](rules.html#rule15-gnu-makefile).

See [Guidelines for Rule 9 - No interactive compiling
allowed](guidelines.html#guideline9-no-interactive).


<div id="rule10">
## Rule 10 - Program file permissions
</div>

Programs that require special privileges (`setuid(2)`, `setgid(2)`,
super-user, special owner, special group, etc.) are **HIGHLY
DISCOURAGED**.  We do **NOT** guarantee these functions will behave as
you expect on our test platforms.

If your program needs special permissions you **MUST** document this
fact and explain why it is needed in your submission’s `remarks.md`
file, preferably close to the top, because `mkiocccentry(1)` will
**NOT** set those modes.

Furthermore, if you need a supplementary program that you include to
have these permissions, you will also have to explain this as well,
because these bits are **NOT** allowed in submissions and those bits
will **NOT** be copied by `mkiocccentry(1)` either.

See [Rule 4 - Required files](rules.html#rule4-required-files),
and
[Rule 5 - Do NOT modify files](rules.html#rule5-modifying-files).


<div id="rule11">
<div id="rule11-legal-rule-abuse">
## Rule 11 - Legal rule abuse
</div>
</div>

Legal abuse of the rules is **somewhat** encouraged, but comes with
risks.  A submission that, in the opinion of the Judges, **violates**
the rules **WILL BE DISQUALIFIED**.  Submissions that plan to abuse the
rules **MUST** justify why their rule abuse is legal (or interesting)
in the `remarks.md` file.

Submission packaging abuse will **NOT** be tolerated and for this reason,
amongst many other reasons, it is recommended that you use
`mkiocccentry(1)`. See also [Rule 17 - use
mkiocccentry](#rule17-mkiocccentry).

During development you can check your `prog.c` size limits using
`iocccsize(1)`, e.g., `iocccsize -v1 prog.c`.  Overriding problems
detected by any of the IOCCC tools risks that the submission will be
rejected.

If you do submit a rule abusing or violating submission, then consider
also submitting an alternate version in a different submission server
slot that does **NOT** violate the rules in case your rule abuse excuse
is rejected.

**IMPORTANT**: If you do submit such an alternate non-rule abusing
version, **PLEASE** indicate that in your `remarks.md` file of your
non-rule abusing version so that the Judges don't think you uploaded a
duplicate into a wrong slot by mistake.

See [Guidelines for Rule 11 - Legal rule
abuse](guidelines.html#guideline11-abuse).


<div id="rule12">
<div id="rule12-utf8">
## Rule 12 - UTF-8
</div>
</div>

Use of UTF-8 is supported by `C89` standard and its updates and so too
by the IOCCC.

See [Guidelines for Rule 12 - UTF-8](guidelines.html#guideline12-utf8).


<div id="rule13">
<div id="rule13-nocr">
## Rule 13 - No carriage returns in prog.c
</div>
</div>

Any C source that fails to compile because lines contain
carriage-returns (CTRL+M, `\r`) in particular as part of DOS/Windows
style newlines might be rejected.  Please do **NOT** put trailing
CTRL+M in `prog.c`, `Makefile`, or `remarks.md` files, but instead end
lines with Unix newline (line-feed, CTRL+J, `\n`).

You are permitted, in order to try and squeeze your `prog.c` under a
[Rule 2a Gross Size](rules.html#rule2a-gross-size) and/or [Rule 2b Net
Size](rules.html#rule2b-net-size) limits, to **NOT** end source with a
newline. If you need to do this, please document that in your
`remarks.md` file and if your compiler complains about this, document
this too and update your `Makefile` to account for this.

See [Guidelines for Rule 13 - No carriage returns in
prog.c](guidelines.html#guideline13-nocr).


<div id="rule14">
## Rule 14 - Resubmitting lost submissions
</div>

Submissions that are substantially similar to previous winning IOCCC
entries are discouraged. See the
FAQ on "[What types of entries have been frequently submitted to the
IOCCC?](../faq.html#frequent-themes).

You are allowed to resubmit to a later contest, a submission that
didn't win the IOCCC. If you do so, then you would be **WELL ADVISED**
to try and enhance and improve your submission. If you do resubmit
something that didn't previously win, then you are encouraged to
mention this in your `remarks.md` file as this **sometimes** helps.

<div id="rule15">
<div id="rule15-gnu-makefile">
## Rule 15 - GNU Makefile
</div>
</div>

<p class="leftbar">
The `Makefile` **MUST** adhere to GNU Makefile syntax. It's highly
recommended that you copy the [Makefile.example](Makefile.example) as a
template, renaming it to `Makefile`. The primary target of the
`Makefile` **MUST** be `prog` and the source file is `prog.c`.  The C
compiler and preprocessor **MUST** be invoked using `${CC}` and
`${CPP}` macros respectively.
</p>

The `clobber` target **MUST** clean and restore the submission
directory tree to its original state, such as removing temporary files
or any modified data files.  Don't assume that `git` tool chain is
installed, i.e. do **NOT** expect `git clean -f` to work. To be clear:
do **NOT** use `git` to clean out files as this **WILL** cause problems
in the winner repo!

<p class="leftbar">
The `Makefile` **MUST** use a syntax that is compatible with `bash(1)`
and GNU `make(1)`. You are encouraged to use `SHELL= bash` in your
`Makefile`; please add a space between the `=` and the value such as:
</p>

``` <!---makefile-->
    SHELL= bash
```

<p class="leftbar">
Assume that commands commonly found in [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
environments and systems are available in the search
`$PATH`.
</p>

<p class="leftbar">
Avoid command options that aren't part of
[SUS](https://en.wikipedia.org/wiki/Single_UNIX_Specification), such as
GNU long name options (such as `--example`) or extensions like `grep
-P`.
</p>

Do **NOT** assume that `.` (current directory) is in the `$PATH`
environment variable.

See [Rule 4 - Required files](rules.html#rule4-required-files).

See
FAQ on "[What are the detailed recommendations for a submission
Makefile?](../faq.html#makefile_details)".

See [Guidelines for Rule 15 - GNU
Makefile](guidelines.html#guideline15-gnu-makefile).


<div id="rule16">
<div id="rule16-anonymous-judging">
## Rule 16 - Anonymous judging
</div>
</div>

Your source code, data files, remarks, and program output **MUST NOT**
identify the author(s) of your code (unless you are **Peter Honeyman**
or pretending to be **Peter Honeyman**). In order to be impartial the
[Judges](https://www.ioccc.org/judges.html) do **NOT** know who is
submitting programs to the IOCCC until final selection is made, and
**only** submissions that won.

Even if you are a past winner, you **MUST NOT** reveal your identity
deliberately or by accident anywhere in your submission. **_Failure to
comply may result in the submission being disqualified_**.


<div id="rule17">
<div id="rule17-mkiocccentry">
## Rule 17 - Use `mkiocccentry`
</div>
</div>

TL;DR: use `mkiocccentry(1)` to package your submission.

The files, directories, and paths **MUST** conform to the limits
imposed by `mkiocccentry(1)`, including but **NOT** limited, to their
names, count, path length, directory tree depth, and permissions.

<p class="leftbar">
The submission tree may have at most **13** directories and maximum
directory depths of **4**. The maximum number of files, excluding
`prog.c`, `remarks.md`, `Makefile`, `prog.alt.c`, `try.sh`,
`try.alt.sh`, `.info.json` and `.auth.json` is **31**.  And the maximum
file-path component is **38** and maximum path length is **60**.
</p>

The submission **MUST** be a `.txz` compressed tarball (i.e., tarball
compressed by `xz(1)`) as constructed by `mkiocccentry(1)`, which
**MUST** be within **[1..3999971]** bytes in size.

The tarball **MUST** be a **v7 format** tarball, and any supplementary
tarballs you provide **MUST** also be **v7 format**.

The sum of all file lengths, after unpacking from the tarball, **MUST**
be less than `27651*1024` (**28314624**) bytes.

<p class="leftbar">
The submission **MUST** pass all `txzchk(1)` checks, and the tarball
filename **MUST** pass all `fnamchk(1)` checks as well.
</p>

<p class="leftbar">
You may **NOT** submit a tarball created by the `-d`, `-e` **OR** by
the `-s seed` options of `mkiocccentry(1)`.
</p>

<p class="leftbar">
The unpacked submission directory **MUST** pass the checks performed by
the minimum required version of `chksubmit(1)`.
</p>

<p class="leftbar">
Submissions may **NOT** use a [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) command line
options that are labelled as "**for TESTING purposes**", **OR**
labelled as "**for the use by the IOCCC judges only**", in their
respective man pages.
</p>

<p class="leftbar">
Submissions may **ONLY** use [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) command lines that
confirm to the command's `-h` "_print help message_", again
notwithstanding the options for testing and the IOCCC judges.
</p>

<p class="leftbar">
The `prog.c` file should pass the [Rule 2 - Size
restrictions](rules.html#rule2-size) checks performed by
`iocccsize(1)`.
</p>

<p class="leftbar">
The `.auth.json` and `.info.json` files **MUST** be exactly
what the minimum required `mkiocccentry(1)` version generates.
</p>

<p class="leftbar">
Any submission that fails to pass the checks performed by the minimum
required version of the [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) **WILL be
rejected**!
</p>

See [Rule 4 - Required files](rules.html#rule4-required-files).

See the
FAQ on "[What is the mkiocccentry tool, how do I obtain it and how do I
use it?](../faq.html#mkiocccentry)".

See the [Guidelines for Rule 17 - Use
mkiocccentry](guidelines.html#guideline17-mkiocccentry).


<div id="rule18">
## Rule 18 - Submission license
</div>

The entirety of your submission **MUST** be submitted under the
following license:

[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0
International](https://creativecommons.org/licenses/by-sa/4.0/).

See [Rule 7 - Original Work](rules.html#rule7-original-work).


<div id="rule19">
<div id="rule19-prime">
## Rule 19 - Prime
</div>
</div>

<p class="leftbar">
This 19th rule, while prime, is reserved for future abuse 😁.
Additional rules, both humorous and otherwise, may be added below this
rule in future contests.
</p>

See [Rule 6 - Free Rule](rules.html#rule6-free-rule).


## Further Reading

Please read the [Guidelines](guidelines.html) next for further
commentary on these rules.

Read the
FAQ on "[Entering the IOCCC: the bare minimum you need to
know](https://www.ioccc.org/quick-start.html#enter)"
for an overview of how to enter the contest.

See also the [FAQ](../faq.html) in general.

And now [for something completely different](guidelines.html#fun).

Consider joining the [IOCCC Discord
Server](https://discord.com/invite/Wa42Qujwnw) for discussions about
The Rules, questions for the Judges, and `C` in general.

Leonid A. Broukhis
chongo (Landon Curt Noll) /\\cc/\\
