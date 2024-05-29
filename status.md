# format

The following JSON members are required to be present [status.json](status.json).


## no_comment

This is a **mandatory** comment for which we offer no comment other
than this comment.  :-)

The JSON member value must be the following JSON quoted string:

``` <!---json-->
    "mandatory comment: because comments were removed from the original JSON spec"
```


## IOCCC_status_version

This is the version of format of the [status.json](status.json) file.

The JSON member value of is a JSON quoted string the form "_version YYYY-MM-DD_".

This document describes version "**1.0 2024-03-09**".


## contest_status

The current status of the IOCCC.

The following JSON member value string may be one of the following JSON quoted strings:


#### "**pending**"

The IOCCC is not yet open, however there is a tentative scheduled
date and time by which the IOCCC will open for submissions.

A preliminary IOCCC rules, guidelines, and tools have been posted.
Comments and suggestions on these preliminary items are welcome.
See the [IOCCC news](news.html) for details including the tentative
scheduled opening date.


#### "**open**"

The IOCCC is open for submissions.

See the [IOCCC news](news.html) page for details on rules, guidelines, tools and deadlines.

Be sure to review the official IOCCC rules, guidelines, and tools
for any changes that may have been made while the IOCCC was "**pending**".


#### "**judging**"

The IOCCC is closed to new submissions.  The [IOCCC judges](judges.html)
are in the process of judging the submissions they received while
the IOCCC was open.

Watch the [@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for updates.

Once the [IOCCC](index.html) closes, the judges will:

* Select the [winning entries](years.html) announce them on the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc).

* Notify the authors of entries that won the IOCCC via email using their previously
registered email address.

* Announce who are authors of this year's winning IOCCC entries via the [@IOCCC mastodon
feed](https://fosstodon.org/@ioccc).

* Upload the winning code to the [Official IOCCC winner repo](https://github.com/ioccc-src/winner)

* Update the [Official IOCCC web site](index.html), and in particular
display this year's winning IOCCC entries at the top of the [IOCCC
winning entries page](years.html).

* Update the [IOCCC news](news.html) page.


#### "**closed**"

The IOCCC is closed and is **NOT** accepting new submissions.

See the [IOCCC winning entries page](years.html) for the entries that have won the IOCCC.

**NOTE**: From time to time, winning IOCCC entries may have their write-ups updated,
Makefiles improved and source code fixed.  See [IOCCC news](news.html) for details.

Watch both [the IOCCC status page](status.html) and  [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) for information about future IOCCC openings.


## news_update

This shows the latest modification date for the [IOCCC news](news.html) page.

The JSON member value is a JSON quoted string obtained from the date field
of the following `ls(1)` command:

``` <!---ls-->
    TZ=UTC ls -D '%FT%T+00:00' -ld news.html
```

**NOTE**: The date and time are given with respect to **UTC** timezone.

**Sorry**: It is possible that for some reason, the [IOCCC news](news.html) page
was modified without the content being changed.  While we will try to minimize
the cases where this happen, we apologize in advance (Sorry tm Canada 🇨🇦) when it does.


## status_update

This shows the latest modification date [status.json](status.json) file.

The JSON member value is a JSON quoted string obtained from the date field
of the following `ls(1)` command:

``` <!---ls-->
    TZ=UTC ls -D '%FT%T+00:00' -ld status.json
```

**NOTE**: The date and time are given with respect to **UTC** timezone.

**Sorry**: It is possible that for some reason, the [status.json](status.json) file
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
