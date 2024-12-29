# format

The following **JSON** members are required to be present [status.json](status.json).


<div id="no_comment">
## no_comment
</div>

This is a **mandatory** comment for which we offer no comment other
than this comment.  :-)

The **JSON** member value must be the following **JSON** quoted string:

``` <!---json-->
    "mandatory comment: because comments were removed from the original JSON spec"
```


<div id="IOCCC_status_version">
## IOCCC_status_version
</div>

This is the version of format of the [status.json](status.json) file.

The **JSON** member value of is a **JSON** quoted string the form "_version YYYY-MM-DD_".

This document describes version "**1.0 2024-03-09**".


<div id="contest_status">
## contest_status
</div>

This is the current status of the contest.

The following **JSON** member value string may be one of the following **JSON** quoted strings:


<div id="pending">
#### "**pending**"
</div>

While the contest **[PENDING](#pending)** the contest is not yet [open](#open), however there is a tentative scheduled
date and time by which the contest will [open](#open) for submissions.

A preliminary [IOCCC rules](next/rules.html), [IOCCC guidelines](next/guidelines.html),
and [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry) have
been released.

You may [register for the IOCCC](next/register.html) while the contest is [pending](#pending),
however you will **NOT** receive your own Email message containing your very own
**Username and Initial Password until the contest is [open](#open)**.  You will need these
to be able to [upload your submission](next/submit.html) to the [IOCCC submit
server](https://submit.ioccc.org).

Once contest moves from [pending](#pending") to [open](#open), an announcement
Email will be sent out to the mailing list of those have successfully registered for the IOCCC.
In addition, an announcement will be made to the [IOCCC news](news.html) in case you miss
that announcement Email.

While you are waiting for the contest to [open](#open), we **highly recommend**
that you review the [IOCCC rules](next/rules.html), [IOCCC guidelines](next/guidelines.html),
and [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry).

Should you have any comments, suggestions, and concerns about the above, and **while you waiting**
for the contest to [open](#open), please see the
FAQ on "[comment or make a suggestion on IOCCC rules, guidelines and tools](faq.html#feedback)"
as well as the
FAQ on "[best way to ask a question about the IOCCC rules, guideline and tools](faq.html#questions)"
for how.

See also the
FAQ on "[how to upload your submission](next/submit.html)"
for more information on the submission process when the IOCCC [reopens](#open).


<div id="open">
#### "**open**"
</div>

While contest is **[OPEN](#open)**, those who have [registered for the IOCCC](next/register.html)
may [upload their submissions](next/submit.html) to the [IOCCC submit server](https://submit.ioccc.org).

See the
FAQ on "[how to submit](faq.html#submit)"
for more information.

See the [IOCCC news](news.html) page for details on any IOCCC related deadlines
such as when the contest will [close](#closed).

The [IOCCC rules](next/rules.html), [IOCCC guidelines](next/guidelines.html),
and [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry)
are now official.  Should you have any questions about these, please see the
FAQ on "[best way to ask a question about the IOCCC rules, guideline and tools](faq.html#questions)"
for how to ask them.

Be sure to review the official [IOCCC rules](next/rules.html), [IOCCC guidelines](next/guidelines.html),
for any changes, as well as updating your [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry)
as changes to them may have been made while the contest was "**[pending](#pending)**".

See also the
FAQ on "[how to submit](faq.html#submit)"
for more information on the submission process when the IOCCC [reopens](#open).


<div id="judging">
#### "**judging**"
</div>

While contest is **[JUDGING](#judging)**, you cannot [register](next/register.html)
nor can you [upload submissions](next/submit.html).  This is because the
[IOCCC judges](judges.html) are in the process of judging the [submissions](faq.html#how_many)
they received while the contest was [open](#open).

Watch the [@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for updates.

Once the contest [closes](#closed), the judges will:

* Select the [winning entries](years.html) and announce them on the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc).

* Notify the [authors](authors.html) of entries that won the contest
via email using their registered email address.

* Announce who the [authors](authors.html) are of this year's [winning IOCCC
entries](years.html) via the [@IOCCC mastodon
feed](https://fosstodon.org/@ioccc).

* Upload the winning code to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner).

* Update the [Official IOCCC website](index.html), and in particular
display this year's [winning IOCCC entries](years.html) at the top of the [IOCCC
winning entries page](years.html).

* Update the [IOCCC news](news.html) page.


#### "**closed**"

While contest is **[CLOSED](#closed)**, you cannot [register](next/register.html)
nor can you [upload submissions](next/submit.html).  You have to wait for the
next contest to [open](#open).

See the [IOCCC winning entries page](years.html) for the entries that have won
the [IOCCC](index.html).

**NOTE**: From time to time, [winning IOCCC entries](years.html) may have their write-ups updated,
`Makefiles` improved, source code fixed etc.  See [IOCCC news](news.html) for details.

Watch both [this IOCCC status page](status.html) and the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) for information about future
contest [openings](#open).


<div id="news_update">
## news_update
</div>

This shows the latest modification date for the [IOCCC news](news.html) page.

The **JSON** member value is a **JSON** quoted string obtained from the date field
of the following `ls(1)` command:

``` <!---ls-->
    TZ=UTC ls -D '%FT%T+00:00' -ld news.html
```

**NOTE**: The date and time are given with respect to **UTC** timezone.

**NOTE**: It is possible that for some reason, the [IOCCC news](news.html) page
was modified without the content being changed.  While we will try to minimize
the cases where this happen, we apologize in advance (Sorry tm Canada 🇨🇦) when it does.


<div id="status_update">
## status_update
</div>

This shows the latest modification date of [status.json](status.json) file.

The **JSON** member value is a **JSON** quoted string obtained from the date field
of the following `ls(1)` command:

``` <!---ls-->
    TZ=UTC ls -D '%FT%T+00:00' -ld status.json
```

**NOTE**: The date and time are given with respect to **UTC** timezone.

**NOTE**: It is possible that for some reason, the [status.json](status.json) file
was modified without the content being changed.  While we will try to minimize
the cases where this happen, we apologize in advance (Sorry tm Canada 🇨🇦) when it does.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
