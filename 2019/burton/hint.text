# Best one-liner

Dave Burton  


## Judges' comments:
### To use:

    make

### Try:

    ./prog < prog.c

### Selected Judges Remarks:

A tiny, but punctually correct way of POSIX counting for text files. This one
line, one word, 127 character beauty continues to expand the number of classic
unix utilities available as winning entries.

## Author's comments:
Synopsis
--------

Feed it anything on stdin.   
The output should look familiar.

Compiles cleanly with:

	WARN="-Wno-implicit-int -Wno-missing-variable-declarations -Wno-parentheses"
	clang -Wall -Wextra -Weverything -pedantic $WARN -include stdio.h -o prog prog.c

Description
-----------
Included is a test script, useful for the corner cases.
As in all good Unix programs, it is silent upon success; any output demonstrates an error.
Instead of checking correctness, the check script can simply output the results:   
(The Makefile contains the spoiler):

	out=cat ./check ./prog

Interestingly, and a spoiler here: MacOS and FreeBSD implement the common utility "correctly".
Centos and Ubuntu both share a "flawed" utility that changes output format based upon input redirection or pipeline(!).
As well, the latter two also behave slightly differently on what they count as whitespace:
\a and \b are both counted whitespace(!), even though the relevant man pages on these systems
omit these characters from the description.

This program follows FreeBSD and MacOS, the arbiters of correct for these purposes.

Limits
------
Requires the C locale and ASCII character set.   
Input should be less than ten million octets toavoidthisproblem.   

See Also
--------
You can enjoy this code from beginning to end.   
No whitespace was harmed in the creation of this program.   
All your base belong to us, but the constants seem a bit ... off?

Bonus
-----
The script `cow` provides a closer analog, and perhaps a more useful interface.

Included is a version without compilation warnings:

	clang -Wall -Wextra -Weverything -pedantic -include stdio.h -o prog.clean prog.clean.c

Bugs
----
The flags are not supported.  Although they could easily be added into `cow`.
This exercise left to the reader.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
