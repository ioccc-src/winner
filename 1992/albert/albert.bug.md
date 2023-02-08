From: leo _at_ zycad -dot- com (Leo Broukhis)
Date: Tue, 30 Jan 96 17:37:51 PST
To: judges _at_ toad -dot- com
Subject: IOCCC 1992 - a bug

Dear Judges,

albert.c (even in its fixed form) still has a bug. Although I don't
remember the number that exposed the bug (afair, resulting in coredump)
in albert.orig.c that has been fixed in albert.c,
I've found a number exposing another bug: 10000000001 (that's 9 0's).
Both albert and albert.orig loop without printing anything, although
the first factor is 101 and is usually found in an instant.

Unfortunately, the e-mail address in albert.hint is no longer valid,
and neither whois, nor replacing old domain name with a new one according
to the MX records, nor Altavista Web search were successful.

...Fortunately, Albert van der Horst did send me an unobfuscated
(but somewhat limited - it doesn't check the number for factors 2, 3, 5, 7)
version of his program. I didn't have a chance to augment its functionality
to the one of the contest entry.
