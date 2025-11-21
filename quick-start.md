This quick start guide is version **28.0.2 2025-03-12**.

<div id="enter_questions">
<div id="enter">
# Entering the IOCCC: the bare minimum you need to know
</div>
</div>

To submit your code to the IOCCC, you **MUST** follow these steps:


<div id="step_0">
## 0. Verify that the IOCCC is pending or open for submissions
</div>

First, check the "**[current status of the IOCCC](status.html)**" page to see current contest status.
You may **only register for the IOCCC when the IOCCC is either [pending](faq.html#pending)
or [open](faq.html#open)**.

You may **only submit your entries to the IOCCC when the IOCCC is [open](faq.html#open)**.

See also the [IOCCC news](news.html#news) for more information.


<div id="step_1">
## 1. Read the latest IOCCC rules and review the IOCCC guidelines
</div>

Please pay close attention to the [official IOCCC rules](next/rules.html).

You are also **highly encouraged** to review the
[official IOCCC guidelines](next/guidelines.html) as they contain important
suggestions, useful hints, and IOCCC humor.  :-)


<div id="step_2">
<div id="register">
## 2. Register for the IOCCC
</div>
</div>

**IMPORTANT**: You may **only register for the IOCCC when the IOCCC is either [pending](faq.html#pending)
or [open](faq.html#open)**.  See "**[current status of the IOCCC](status.html)**" page for details.

If the contest is [pending](faq.html#pending) or [open](faq.html#open),
then follow the directions on "**[how to register for the IOCCC](next/register.html)**".


<div id="step_3">
## 3. Wait for your submit server username and initial password
</div>

Once you have [registered for the IOCCC](next/register.html),
and once the contest is **[OPEN](faq.html#open)**, one of the
[IOCCC judges](judges.html) will send via email within a few days,
your [IOCCC submit server](https://submit.ioccc.org) **Username** and
**Initial password**.

**PLEASE NOTE**: After registering, it could take up to a **few days**
before an [IOCCC judge](judges.html) sends the that email, so **PLEASE
be patient**. This means that you should **GIVE YOURSELF TIME** before the
contest closes!

**IMPORTANT NOTE**: Unless the contest is [open](faq.html#open),
then you will **NOT** receive your **Username** and **Initial password**
by email.  For example, if the contest is [pending](faq.html#pending),
you will have to **WAIT UNTIL THE CONTEST IS [OPEN](faq.html#open)**.

Please check the "**[current status of the IOCCC](status.html)**" page and
visit the "**[how to register for the IOCCC](next/register.html)**" page for detailed instructions.

**NOTE**: If are having trouble receiving your **Username** and **Initial
password**, and the **CONTEST IS [OPEN](faq.html#open)**, and
have you checked your spam folder, [Contact the IOCCC](contact.html)
for assistance.


<div id="step_4">
## 4. Login to the submit server and change your password
</div>

Using the **Username** and **Initial password** you receive via email in
[step 3](#step_3), you need to login to the [IOCCC submit server](https://submit.ioccc.org).

**IMPORTANT NOTE**: You must change your password **WITHIN 72 HOURS**
from when one of the [IOCCC judges](judges.html) sent that email.

**NOTE**: The [IOCCC submit server](https://submit.ioccc.org)
is ready for submissions **ONLY WHEN THE CONTEST IS [open](faq.html#open)**.

Please visit the "**[change your submit server initial password](next/pw-change.html)**" page for detailed instructions.


<div id="step_5">
## 5. Obtain and compile the latest mkiocccentry toolkit
</div>

Once the contest is [open](faq.html#open), download the most recent
version of the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry).

**IMPORTANT NOTE**: While the contest is [pending](faq.html#pending),
the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
could change.  Once the content is [open](faq.html#open), be sure
you **have the latest** version installed.

To help you, please see the
FAQ on "[how to obtain the most recent mkiocccentry](faq.html#obtaining_mkiocccentry)",
the
FAQ on "[compiling mkiocccentry toolkit](faq.html#compiling_mkiocccentry)"
and the
FAQ on "[installing the mkiocccentry tools](faq.html#install)"
for more details.


<div id="step_6">
## 6. Run the mkiocccentry tool to form your submission tarball
</div>

For more details on `mkiocccentry`, what it is, how to obtain it and how to use
it, see the
FAQ on "[mkiocccentry](#mkiocccentry)"
(especially the
FAQ on "[what mkiocccentry is in simple terms](#about_mkiocccentry),
the
FAQ on "[how to use mkiocccentry](#using_mkiocccentry)")
and the [mkiocccentry section in the
guidelines](next/guidelines.html#mkiocccentry).


``` <!---sh-->
    mkiocccentry [options] workdir topdir
```

where:

* `workdir`

    directory where the submission directory and tarball are formed

* `topdir`

    directory where your files to be packaged are in

Three files are required to exist in `topdir`:

* `prog.c`

    path to the C source for your submission

* `Makefile`

    Makefile to build (make all) and clean up (make clean & make clobber) as well
    as the other required files

* `remarks.md`

    Remarks about your entry in markdown format: see the
    FAQ on "[remarks.md](faq.html#remarks_md)"
    for more info.

**NOTE**: Please see our [IOCCC markdown guide](markdown.html) for **important information** on using markdown in the IOCCC.

If the `mkiocccentry` tool indicates that there is a problem with your
submission, especially if it identifies a
[Rule 2 - Size](next/rules.html#rule-2---size),
or any other [rule](next/rules.html), related problem, you are **strongly** encouraged to revise and
correct your entry and then re-run the `mkiocccentry` tool.

If you choose to risk violating [Rules](next/rules.html), be sure and explain your reason
for doing so in your `remarks.md` file.

See also
[Rule 17 - Packaging](next/rules.html#rule-17---packaging)!

**IMPORTANT NOTE**: the tools that require other tools, `mkiocccentry(1)` and
`txzchk(1)`, will, as of version `2.0.2 2025-03-11`, search under `$PATH`. If
you have an earlier version and you have not installed the tools and run the
tools from outside the repo directory, you will have to use the options to the
tools to set the path to the required tools.

Do remember to make sure you have the latest vers
`chksubmit(1)`, `txzchk(1)` and `fnamchk(1)`. And remember to make sure you have
the latest version so you do not violate
[Rule 17 - Packaging](next/rules.html#rule-17---packaging).
See the
FAQ on "[obtaining the latest mkiocccentry tools](faq.html#obtaining_mkiocccentry)",
the
FAQ on "[compiling the mkiocccentry tools](faq.html#compiling_mkiocccentry)",
the
FAQ on "[installing the mkiocccentry tools](faq.html#installing)"
and the
FAQ on "[using the mkiocccentry tools](faq.html#using_mkiocccentry)"
for more help.

See also the
FAQ on "[what the minimum required versions are for this
contest](faq.html#minimum_versions)"
for more details on how to verify you have the correct versions for this
contest.

<div id="step_7">
<div id="submit">
## 7. Upload your submission to the IOCCC submit server
</div>
</div>

The screenshots on the "**[how to upload your submission to the IOCCC](next/submit.html)**" page
might be a helpful guide when using the [IOCCC submit server](https://submit.ioccc.org).

**NOTE**: You may modify a previous uploaded submission, if the contest is
[open](faq.html#open), by replacing the file in a slot.  Please use the
[mkiocccentry tool](#mkiocccentry) to rebuild the compressed tarball as
this will update the timestamps and the filename generated, as well as packaging
any changes: making it clear to the [IOCCC judges](judges.html) that you intend
to replace the older upload.

**IMPORTANT NOTE**: The [IOCCC submit server](https://submit.ioccc.org)
is ready for submissions
**ONLY WHEN THE CONTEST IS [open](faq.html#open)**.

See the "**[current status of the IOCCC](status.html)**" page for details on the contest status.

**IMPORTANT NOTE**: When the contest is [closed](faq.html#closed), the
[IOCCC submit server](https://submit.ioccc.org)
might be offline and unreachable as a website.

**NOTE**: if you do need to update a submission, you might find the
FAQ on "[how to not have to re-enter information more than once](#answers_file)"
useful.
