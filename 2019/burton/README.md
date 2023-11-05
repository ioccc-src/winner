## To build:

```sh
make
```


## To use:

```sh
./prog < prog.c
```


### Try:

```sh
echo "Do or do not. There is no try."
```


## Judges' remarks:

A tiny, but punctually correct way of POSIX counting for text files. This one
line, one word, 127 character beauty continues to expand the number of classic
unix utilities available as winning entries.


## Author's remarks:

### Synopsis:

Feed it anything on stdin.
The output should look familiar.

Compiles cleanly with:

```sh
WARN="-Wno-implicit-int -Wno-missing-variable-declarations -Wno-parentheses"
cc -Wall -Wextra -Weverything -pedantic $WARN -include stdio.h -o prog prog.c
```

### Description:

Included is a test script, useful for the corner cases.  As in all good Unix
programs, it is silent upon success; any output demonstrates an error.  Instead
of checking correctness, the check script can simply output the results:   (The
Makefile contains the spoiler):

```sh
out=cat ./check ./prog
```

Interestingly, and a spoiler here: macOS and FreeBSD implement the common
utility "correctly".  CentOS and Ubuntu both share a "flawed" utility that
changes output format based upon input redirection or pipeline(!).  As well, the
latter two also behave slightly differently on what they count as whitespace:
`\a` and `\b` are both counted whitespace(!), even though the relevant man pages
on these systems omit these characters from the description.

This program follows FreeBSD and macOS, the arbiters of correct for these purposes.

### Limits:

Requires the C locale and ASCII character set.
Input should be less than ten million octets "toavoidthisproblem".

### See Also:

You can enjoy this code from beginning to end.
No whitespace was harmed in the creation of this program.
All your base belong to us, but the constants seem a bit ... off?

### Bonus

The script `cow` provides a closer analog, and perhaps a more useful interface.

Included is a version without compilation warnings:

```sh
cc -Wall -Wextra -Weverything -pedantic -include stdio.h -o prog.clean prog.clean.c
```

### Bugs

The flags are not supported.  Although they could easily be added into `cow`.
This exercise left to the reader.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
