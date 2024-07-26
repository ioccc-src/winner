## To build:

``` <!---sh-->
    make all
```


## To use:

**WARNING: DO NOT RUN this program without reading this text down to the end!**
It may render your system unusable for a limited amount of time
or force you to reboot using the Big Red Button!  This is **NOT** a joke.
You have been warned.

``` <!---sh-->
    ./schweikh3
```


## Judges' remarks:

The source fails to compile on compilers that recognize the inline
keyword by default.  For `gcc`, you may need to use `-ansi`.

See the file [schweikh3.info](%%REPO_URL%%/1996/schweikh3/schweikh3.info) for example output from various
systems.

But still it is a useful utility.  To use try:

``` <!---sh-->
    ./schweikh3
```

and thanks for the virtual memories!  :-)


## Author's remarks:

### Why I think my entry is obfuscated

There are some layout obfuscations that hinder readability, like
some (but not all) one character tokens in column 1. `#include`s,
`#define`s and declarations of data and functions appear intermixed.
`iso646.h` is even included in the middle of an expression, how
disgusting. Besides, requiring `iso646.h` will render the program
uncompilable on many systems that have not yet incorporated
Amendment One to The Standard.  If you, dear reader, suffer from
this disease, just read `iso646.h`.

There are no `if` statements. They have been replaced by
`switch () case 1:` or `switch () case 0:` etc. At least one
`switch` has a declaration after the opening brace, booh!
Identifiers are named after random programming languages, BASIC (as `Basic`),
COBOL, F77, awk etc.

You have to select maximum ANSI C conformance of your
compiler. The source fails to compile under a C++ compiler due to
the `new` identifier which is a C++ reserved word:

``` <!---sh-->
    $ g++ schweikh3.c
    schweikh3.c:9: parse error before `new'
    schweikh3.c:16: parse error before `new'
    schweikh3.c:46: parse error before `void'
    schweikh3.c:65: parse error before `Lisp'
    schweikh3.c:68: parse error before `;'
    [...]
    schweikh3.c:91: confused by earlier errors, bailing out
```

The source fails to compile on compilers that recognize the inline
keyword by default, e.g. `gcc`:

``` <!---sh-->
    $ gcc schweikh3.c
    schweikh3.c:46: parse error before `void'
    schweikh3.c: In function `main':
    schweikh3.c:91: parse error before `inline'
    schweikh3.c: At top level:
    schweikh3.c:97: parse error before `void'
```

The `-ansi` option to `gcc` fixes this.

The source fails to compile on obsolete systems with obsolete
memory models due to the identifier `far` (to be honest: this is
untested :-) ).

Does your `indent(1)` cope with backslash/newline pairs in between keywords like in
`re\turn` where the `re\` is at the end of a line? ? Solaris' `indent(1)` inserts
spaces and thereby renders the source uncompilable...

The indented source will exhibit different semantics when indenting
changes the number of lines (due to using the `__LINE__` macro in an
expression).

And what about `sizeof __TIME__`?  This one's for the philosophers
and physicists among us programmers. What is it? `sizeof (char *)`? -- no.
`strlen ("hh:mm:ss")`? -- no. It's the same as `sizeof __DATE__ -
sizeof "no"` :-)

The program is POSIX conformant and lints without warning under
Solaris' Sunpro lint. Allocated memory is correctly freed on all
possible execution paths.

### What this program does

This program tests your operating system's allocation honesty. It
forks a child that will allocate as much memory as possible with byte
granularity and then write to every 1024th byte, at the same time
writing a status report on `stdout`. This way each page of the
allocated virtual memory will eventually be referenced. Without
any arguments, `malloc(3)` will be used to allocate memory. If the
first arg starts with `c`, `calloc(3)` will be used instead.

I distinguish three different behaviours:

1. OS without memory overcommit: `malloc(3)` does not lie -- you can use all memory
the OS granted to you.

2. OS with memory overcommit: `malloc(3)` lies -- any program may get killed at
random when the OS can not acquire a free page.

3. OS with pseudo memory overcommit: `malloc(3)` lies -- The OS puts processes to
sleep for which it can not acquire a free page. Because other processes are also
affected this way, the system slows down and quickly becomes totally unusable
(also known as "thrashing"). Because more and more processes wait for memory
returned by other exiting processes the system eventually enters a deadlock
situation and effectively halts.

I had the pleasure and pain to find all three behaviours on the
platforms I use regularly.

The file [schweikh3.info](%%REPO_URL%%/1996/schweikh3/schweikh3.info) has output for
Solaris, FreeBSD and Linux. The Linux case is interesting in that
the behaviour changes when `calloc(3)` is used instead of `malloc(3)`.
For FreeBSD, the last two lines are not messages stemming from
my program but issued by the syslog daemon.


### Implementation remarks

How can we distinguish the three different OS types from the
table above?

Obviously, type (1), no overcommit, is easy.

For type (2), random kill, we need to fork a child that can be killed
and whose exit status the parent collects and decodes. Here's
where POSIX enters the scene.

Type (3), thrashing, was the hardest part. The first attempt was to
measure the elapsed processor time it takes to write a single byte
(using `clock()`). If a certain threshold is reached I assume the
system is thrashing. When thrashing, however, the process does not
consume processor time in a noticeable amount any longer and I lose.
So I switched to measuring wall clock time using `time(3)`. On the one
system that I observe thrashing (Linux) this works (although the
value returned by `time(3)` seems to 'hang' sometimes when the OS thrashes.
Exceeding a threshold of 5 seconds may be detected only after half a
minute or so.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
