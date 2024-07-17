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

The current status of the [IOCCC](index.html).

The following **JSON** member value string may be one of the following **JSON** quoted strings:


<div id="pending">
#### "**pending**"
</div>

The [IOCCC](index.html) is not yet [open](#open), however there is a tentative scheduled
date and time by which the [IOCCC](index.html) will open for submissions.

A preliminary [IOCCC](index.html) rules, guidelines, and tools have been posted.
Comments and suggestions on these preliminary items are welcome.
See the [IOCCC news](news.html) for details including the tentative
scheduled opening date.


<div id="open">
#### "**open**"
</div>

The [IOCCC](index.html) is [open](#open) for [submissions](faq.html#submit).

See the [IOCCC news](news.html) page for details on rules, guidelines, tools and deadlines.

Be sure to review the official [IOCCC](index.html) rules, guidelines, and tools
for any changes that may have been made while the [IOCCC](index.html) was
"**[pending](#pending)**".

<div id="judging">
#### "**judging**"
</div>

The [IOCCC](index.html) is [closed](#closed) to new submissions.  The [IOCCC judges](judges.html)
are in the process of judging the [submissions](faq.html#how_many) they received while
the [IOCCC](index.html) was open.

Watch the [@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for updates.

Once the [IOCCC](index.html) [closes](#closed), the judges will:

* Select the [winning entries](years.html) and announce them on the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc).

* Notify the [authors](authors.html) of entries that won the [IOCCC](index.html)
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

The [IOCCC](index.html) is closed and is **NOT** accepting [new
submissions](faq.html#submit).

See the [IOCCC winning entries page](years.html) for the entries that have won
the [IOCCC](index.html).

**NOTE**: From time to time, [winning IOCCC entries](years.html) may have their write-ups updated,
`Makefiles` improved, source code fixed etc.  See [IOCCC news](news.html) for details.

Watch both [this IOCCC status page](status.html) and the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) for information about future
[IOCCC](index.html) [openings](#open).


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
