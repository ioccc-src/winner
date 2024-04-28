<!-- START: this line starts content from: inc/rules.closed.hdr -->

# WARNING: These rules are OUT OF DATE

They are a **very tentative proposal** for the next IOCCC
that is **VERY LIKELY** to be updated before the next IOCCC.
They are are provided as a **very tentative** hint at what
might be used in a future IOCCC.

Please regard these rules as a historic archive.


# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entires that have won the IOCCC.

Watch both [the IOCCC status page](../status.html) and the
[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about future IOCCC openings.

<!-- END: the next line ends content from: inc/rules.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->
# 27th International Obfuscated C Code Contest Official Rules

**`|`** Copyright &copy; 2024 Leonid A. Broukhis, Landon Curt Noll.

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing from the [contest judges](../contact.html).


## Rules version

**`|`** These rules are version **2024-04-04-v28**.

**IMPORTANT**: Be sure to read the [IOCCC guidelines](guidelines.html).


### Change marks

**`|`** **&larr; Lines that start with this symbol indicate a change from the previous IOCCC**

Most lines (we sometimes make mistakes) that were modified start the **`|`** symbol.


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

*  To write the most Obscure/Obfuscated C program within the rules.
*  To show the importance of programming style, in an ironic way.
*  To stress C compilers with unusual code.
*  To illustrate some of the subtleties of the C language.
*  To provide a safe forum for poor C code. :-)


# Important IOCCC dates

**`|`** This IOCCC runs from **2019-Dec-26 06:01:41 UTC** to **2020-Mar-15 06:26:49 UTC**.

Until the start of this IOCCC, these rules, guidelines and iocccsize.c
tool should be considered provisional BETA versions and may be
adjusted at any time.

When the IOCCC is open, the submission URL is:
[https://submit.ioccc.org/](https://submit.ioccc.org/), at all other
times that link is likely to be unresponsive.

Please check the [How to enter link](../faq.html#submit) link
for **important information** on how to submit to the IOCCC.

**`|`** The submit URL should be active on or slightly before **2020-Jan-15 12:21:37 UTC**.
Please wait to submit your entries until after that time.

The official rules, guidelines and iocccsize.c tool will be available
on the official IOCCC web site on or slightly before start of this IOCCC.


Please recheck on or after the start of this IOCCC to be sure you
are using the correct versions of these items before using the IOCCC
entry submission URL.


# RULES

To help us with the volume of entries, we ask that you follow these rules:


## Rule 0

We need a rule 0.  :-)


## Rule 1

Your entry must be a complete program.


## Rule 2

**`|`** The size rule requires your entry to satisfy BOTH rule 2a and rule 2b:


## Rule 2a

The size of your program source **must be <= 4096 bytes**in length.

## Rule 2b

When your program source is fed as input to the current IOCCC size
tool, and the IOCCC size tool -i command line option is used, the
value printed **shall not exceed 2053**.

**`|`** The source to the current IOCCC size tool is found in the
[mkiocccentry tool repo](https://github.com/ioccc-src/mkiocccentry).


## Rule 3

Submissions should be performed using the instructions outlined at:
the [How to enter link](../faq.html#submit) link.

To submit to an open IOCCC, you must the [IOCCC submit server](https://submit.ioccc.org/).

When the IOCCC is not open, that link will likely be unresponsive.

**`|`** The submit URL should be active on or slightly before **2020-Jan-15 12:21:37 UTC**.
Please wait to submit your entries until after that time.


## Rule 4

If your entry is selected as a winner, it will be modified as follows:

Your 'build' instructions will be incorporated into a Makefile.

Your source code will be the file **prog.c**.  The compiled binary
will be called **prog**.


## Rule 5

Your entry must not modify the content or filename of any part of your
original entry including, but not limited to prog.c, the Makefile
(we create from your how to build instructions), as well as any data
files you submit.

If you entry wishes to modify such content, it must first copy the
file to a new filename and then modify that copy.


## Rule 6

**`|`** I am not a rule, I am a free(void \*man)!

``` <!---c-->
        while (!understand(ioccc(rule(you(are(number(6))))))) { ha_ha_ha(); }
```


## Rule 7

The obfuscated C program must be an original work that you own.

You (the authors) must own the contents of your submission OR
you must have permission from the owners to submit their content
under the following license:

**`|`** **[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**

See also Rule 18.

If you submit any content that is owned by others, you MUST
detail that ownership (i.e., who owns what) and document the
permission you obtained.

Please note that the IOCCC size tool is not an original work.


## Rule 8

**`|`** Entries must be received prior to the end of this IOCCC which is:

```
    2020-Mar-15 06:26:49 UTC
```

A confirmation of submission will be sent to the submitter email address before the close of the contest.


## Rule 9

**`|`** Each person may submit up to and including 8.000000 entries per contest.

Each entry must be submitted separately.


## Rule 10

Entries requiring human interaction to be initially compiled are not permitted.


## Rule 11

Programs that require special privileges (setuid, setgid, super-user,
special owner, special group, etc.) are still highly discouraged. We
do not guarantee these functions will behave as you expect on our test
platforms. If your program needs special permissions please document
them in the remarks file.


## Rule 12

Legal abuse of the rules is somewhat encouraged.  An entry that, in
the opinion of the judges, violates the rules will be disqualified.
Entries that attempt to abuse the rules must try to justify why
their rule abuse is legal in the remarks file.


## Rule 13

Any C source that fails to compile because of unescaped octets with
the high bit set (octet value >= 128) will be rejected.


## Rule 14

Any C source that fails to compile because of lines with trailing
control-M's (i.e., lines with a tailing octet 015) will be rejected.

Please do not put trailing control-M's on remarks file lines.
Please check to be sure, before submitting, that you have removed
any control-M at the end of remark file lines.


## Rule 15

When you submit your entry you must have a valid email address
that can both send and receive email.  The online submission
method is a two phase process that requires the use of an
approval code. This code will be emailed to you as part of
phase 1.

Entries submitted without a working or valid email address will
be disqualified.

The judges are not responsible for delays in email, please plan
enough time for one automated exchange of email as part of your
submission.

After your email address has been confirmed, the submission code will
be valid for submitting and editing the entry for the lifetime of the
competition.


## Rule 16

You are STRONGLY encouraged to submit a previously unpublished and
original entry. Submissions that are similar to previous entries are
discouraged. As we judge anonymously, submissions that have already
been published may be disqualified.


## Rule 17

The total size of your submission: the sum of the size of the program,
hints, comments, build and info files MUST be less than or equal
to 1048576 octets in size.


## Rule 18

The entirety of your entry must be submitted under the following license:

**`|`** **[CC BY-SA 4.0 DEED Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)**

You (the authors) must own the contents of your submission OR
you must have permission from the owners to submit their content

You must not submit anything that cannot be submitted under that license.


## Rule 19

The remarks file must be written in markdown format. See
the Daring Fireball {Markdown: Basics](http://daringfireball.net/projects/markdown/basics)
for more information.

**`|`** We currently use [pandoc](https://pandoc.org) to convert markdown to HTML.


## Rule 20

The how to build instructions must be in make form.

The target of the make file must be called prog.  The original
C source file must be called prog.c.

To invoke the C compiler, use `${CC}`.
To invoke the C preprocessor use `${CPP}`.

Do not assume that . (the current directory) is in the `$PATH`.

Use a shell command syntax that is compatible with bash.

Assume that commands commonly found in POSIX-like / Linux-like systems
are available in the search path.

Do not assume any particular given value of `${CFLAGS}` or other
commonly used make variables.


## Rule 21

Your entry must not create nor modify files above the current directory
with the exception of the `/tmp` and the `/var/tmp` directories.  Your entry
may create subdirectories below the current directory, or in /tmp,
or in `/var/tmp` provided that "**.**" is **not** the first octet in any
directory name.


## Rule 22

Catch 22:

Your source code, data files, remarks and program output must **NOT**
identify the authors of your code.  The judges **STRONGLY prefer** to
not know who is submitting entries to the IOCCC.

Even if you are a previous IOCCC winner, catch 22 still applies.

Identifying the authors of your entry in an obvious way anywhere
within in your code, data, remarks or program output (unless you are
_Peter Honeyman_ or pretending to be _Peter Honeyman_) will be grounds
for disqualification of your entry.

Yes, Virginia, **we really mean it**!


## Rule 23

This prime rule number is reserved for future use.


## Rule 24

Even though 24 is not prime, you should still see rule #23.


## Rule 25

**`|`** The IOCCC rule set consists of at least 26 rules.


## Rule 26

**`|`** Rule 26 is also a rule.


# FOR MORE INFORMATION:

The judging will be done by Leonid A. Broukhis, Simon Cooper,
Landon Curt Noll.

**`|`** Please send questions or comments about the contest, to:

```
    q.2020@ioccc.org
```

**`|`** **IMPORANT**: You must include the words **ioccc 2020 question**
in the subject of your email message when sending email to the judges.

The rules and the guidelines may (and often do) change from year to
year.  You should be sure you have the current rules and guidelines
prior to submitting entries.

**`|`** See the [Official IOCCC web site](../index.html) for additional information.

For the updates and breaking IOCCC news, you are encouraged to follow
the twitter handle:

```
    @IOCCC
```

You do not have to be a twitter user to follow @IOCCC.  Non-twitter users should access:

```
    https://twitter.com/ioccc
```

Non-twitter users should force their browsers to reload the above URL
to be sure they are seeing the most recent tweets.


## An important update to this historic note

**-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**

**`|`** **The IOCCC no longer uses twitter**.

**`|`** Today the [IOCCC uses Mastodon](../contact.html#mastodon).

**`|`** For more information and to see our IOCCC Mastodon posts, see:

```
    https://fosstodon.org/@ioccc
```

**-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-**

Leonid A. Broukhis<br>
Simon Cooper<br>
chongo (Landon Curt Noll) `/\cc/\`


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)
