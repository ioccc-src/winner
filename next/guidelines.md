<!-- START: this line starts content from: inc/guidelines.closed.hdr -->

# WARNING: These guidelines are OUT OF DATE

These guidelines are a **VERY TENTATIVE proposal** for the next IOCCC
and are **VERY LIKELY** to be updated before the next IOCCC.
They are are provided as a **VERY TENTATIVE** hint at **what
MIGHT** be used in the next IOCCC.  In some cases they might
even be a copy of the guidelines from the previous IOCCC.


# The IOCCC is closed

The IOCCC is **NOT** accepting new submissions at this time.  See the
[IOCCC winning entries page](../years.html) for the entries that have won the
IOCCC in the past.

Watch both [the IOCCC status page](../status.html) and the
[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about
future IOCCC openings.

<!-- END: the next line ends content from: inc/guidelines.closed.hdr -->
<!-- This is the last line modified by the tool: bin/gen-status.sh -->
# 28th International Obfuscated C Code Contest Official Guidelines

Copyright &copy; 2024 Leonid A. Broukhis and Landon Curt Noll.

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing by [contacting the judges](../contact.html).


<div id="guidelines_version">
## IOCCC Guidelines version
</div>

**`|`**   These [IOCCC guidelines](guidelines.html) are version **28.1 2024-06-29**.

**IMPORTANT**: Be **SURE** to read the [IOCCC rules](rules.html).


<div id="change_marks">
### Change marks
</div>

**`|`**   **&larr; Lines that start with this symbol indicate a change from the previous IOCCC**

Most lines (we sometimes make mistakes) that were modified since the previous
IOCCC start with the **`|`** symbol.


<div id="about_guidelines">
# ABOUT THIS FILE:
</div>

This file contains _guidelines_ intended to help people who wish to
participate in the [International Obfuscated C Code Contest
&#x28;IOCCC&#x29;](https://www.ioccc.org).

These are **NOT the [IOCCC rules](rules.html)**, though it does contain comments
about them.  The [IOCCC guidelines](guidelines.html) should be viewed as
**hints** and **suggestions**.  **Entries that violate the
[guidelines](guidelines.html) _but remain within the [rules](rules.html)_** _are
allowed_.  Even so, you are safer if you remain within the [IOCCC
guidelines](guidelines.html).

**You should read the current [IOCCC rules](rules.html), prior to submitting
entries**. The [rules](rules.html) are typically published along with the [IOCCC
guidelines](guidelines.html)..


<div id="new">
# WHAT'S NEW THIS IOCCC
</div>

**`|`**   This IOCCC runs from **2024-MMM-DD HH:MM:SS UTC** to **YYYY-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**

**`|`**   The reason for the times of day are so that key IOCCC events are **calculated**
to be a **fun**ctional UTC time.  :-)

**`|`**   Until the start of this IOCCC, the [IOCCC rules](rules.html),
[IOCCC guidelines](guidelines.html) and the tools in the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry), should be
considered provisional **BETA** versions and **may be adjusted _AT
ANY TIME_**.

**`|`**   The submit URL should be active on or slightly before **2024-MMM-DD HH:MM:SS UTC**.<br>
**`|`**   **XXX - date/time is TBD - XXX**

**`|`**   The [IOCCC rules](rules.html), [IOCCC
guidelines](guidelines.html) will be available on the [official IOCCC
website](https://www.ioccc.org) on or slightly before start of this IOCCC.  Please check
[the IOCCC FAQ about how to submit](../faq.html#submit) to see how
to submit entries, on or after the start of this IOCCC, to be sure
you are using the correct versions of these items before using the
IOCCC submission URL.

**`|`**   The [Rule 2a](rules.html#rule2a) size has **increased from 4096 to 4993** bytes.

**`|`**   The [Rule 2b](rules.html#rule2b) size has **increased from 2053 to 2503** bytes.

**`|`**   The default way to compile submissions is now `-std=gnu17 -O3 -g3 -Wall -Wextra -pedantic`.

**`|`**   Submissions are in the form of a single xz compressed tarball.

**`|`**   To assist in the formation of the xz compressed tarball for submission, use the
`mkiocccentry(1)` tool as found in the  [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

**`|`**   [Rule 17](rules.html#rule17) has been **significantly modified**
to account for the new [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) tools.

**`|`**   An [example
Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example)
is now available from the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) and you are encouraged to use
it.

**`|`**   The IOCCC submission URL, [when the IOCCC is open](../status.html#open), is [submit.ioccc.org](https://submit.ioccc.org/).


<div id="hints">
<div id="suggestions">
# HINTS AND SUGGESTIONS:
</div>
</div>

You are encouraged to examine the [winners of previous contests](../years.html).

Keep in mind that [rules](rules.html) change from year to year, so some [winning
entries](../years.html) might not be valid submissions this year; what _was_ unique
and novel one year _might be 'old' the next year_.

A submission is usually examined in a number of ways.  We typically apply
a number of tests to a submission:

* look at the original source
* convert ANSI trigraphs to ASCII
* C pre-process the source ignoring `#include` lines
* C pre-process the source ignoring `#define` _and_ `#include` lines
* run it through a C beautifier
* examine the algorithm
* compile it (with flags to enable all warnings)
* execute it

You should consider how your submission looks in each of the above tests.
You should ask yourself if your submission remains obscure after it has been
'_cleaned up_' by the C pre-processor and a C beautifier.

Your submission need not pass all of the above tests.  In certain
cases, a test is not important.  Entries that compete for the
'**strangest/most creative source layout**' need not do as well as
others in terms of their algorithm.  On the other hand, given
two such entries, we are more inclined to pick the submission that
does something interesting when you run it.

We try to avoid limiting creativity in our [rules](rules.html).  As such, we
leave the contest open for creative rule interpretation.  As in [real
life](https://en.wikipedia.org/wiki/Real_life) programming, interpreting a
requirements document or a customer request is important.  For this reason, we
often award '**Best abuse of the [rules](rules.html)**' or '**Worst abuse of the
[rules](rules.html)**' or some variation to a submission that illustrates this
point in an ironic way.

We do realize that there are holes in the [rules](rules.html), and invite
entries to attempt to exploit them.  We will award '**Worst abuse of the
[rules](rules.html)**' or '**Best abuse of the [rules](rules.html)**' or some
variation and then plug the hole next year.

**`|`**   When we do need to plug a hole in the [IOCCC rules](rules.html)
or [IOCCC guidelines](guidelines.html), we will attempt to use a very
small plug, if not smaller.  Or, maybe not.  :-)

**`|`**   There may be less than 2^7+1 reasons why these [IOCCC guidelines](guidelines.html) seem obfuscated.

Check out your program and be sure that it works.  We sometimes make
the effort to debug a submission that has a slight problem, particularly
in or near the final round.  On the other hand, we have seen some
of the best entries fall down because they didn't work.

**`|`**   We tend to look down on a [prime
number](https://en.wikipedia.org/wiki/Prime_number) printer that claims that
16 is a prime number.  If you do have a bug, you are better off
documenting it.  Noting "_this submission sometimes prints the 4th power
of a prime by mistake_" would save the above submission.  And sometimes,
a strange bug/feature can even help the submission!  Of course, a correctly
working submission is best.  Clever people will note that 16 might be prime
under certain conditions.  Wise people, when submitting something clever
will fully explain such cleverness in their submission's `remarks.md` file.

People who are considering to just use some complex mathematical
function or state machine to spell out something such as "_hello,
world!_" **really really, _and we do mean REALLY_, do need to be more creative**.

Ultra-obfuscated programs are, in some cases, easier to
deobfuscate than subtly-obfuscated programs.  Consider using
misleading or subtle tricks layered on top of or under an
appropriate level of obfuscation.  A clean looking program with
misleading comments and variable names might be a good start.

When programs use VTxxx/ANSI sequences, they should NOT be limited to a
specific terminal brand.  Those programs that work in a standard xterm
are considered more portable.

**`|`**   [Rule 2](rules.html#rule2) (the size rule) refers to the use of the IOCCC size tool called `iocccsize(1)`.

**`|`**   See the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry) for the `iocccsize(1)` tool.

**`|`**   To further clarify [Rule 2](rules.html#rule2), we subdivided it into two parts, **2a** and **2b**.

**`|`**   The overall size limit (see [Rule 2a](rules.html#rule2a)) on `prog.c` is now **4993 bytes**.

**`|`**   Your submission must satisfy BOTH the maximum size [Rule 2a](rules.html#rule2a) AND your submission
must satisfy the IOCCC size tool [Rule 2b](rules.html#rule2b).

**`|`**   This IOCCC size tool imposes a 2nd limit on C code size (see [Rule 2a](rules.html#rule2a).  To check your
code against the 2nd limit of [Rule 2](rules.html#rule2):

``` <!---sh-->
    ./iocccsize prog.c
```

**`|`**   The IOCCC size tool algorithm may be summarized as follows:

```
    The size tool counts most C reserved words (keyword, secondary,
    and selected preprocessor keywords) as 1.  The size tool counts all
    other octets as 1 excluding ASCII whitespace, and excluding any
    '`;`', '`{`' or '`}`' followed by ASCII whitespace, and excluding any
    '`;`', '`{`' or '`}`' octet immediately before the end of file.
```

ASCII whitespace includes ASCII tab, ASCII space, ASCII newline,
ASCII formfeed, and ASCII carriage return.

**`|`**   When '`;`', '`{`' or '`}`' are within a C string, they may still not be<br>
**`|`**   counted by the IOCCC size tool.  This is a feature, not a bug!

In cases where the above summary and the algorithm implemented by
the IOCCC size tool source code conflict, the algorithm implemented
by the IOCCC size tool source code is preferred by the judges.

**`|`**   There are at least 2 other reasons for selecting 2503 as the 2nd limit<br>
**`|`**   besides the fact that 2503 is a prime.  These reasons<br>
**`|`**   may be searched for and discovered if you are ["Curios!" about 2503](https://t5k.org/curios/page.php/2503.html). :-)<br>
**`|`**   Moreover, 2053 was the number of the kernel disk pack of one of the<br>
**`|`**   judge's BESM-6, and 2503 is a decimal anagram of 2053.

Take note that this secondary limit imposed by the IOCCC size tool
obviates some of the need to `#define` C reserved words in an effort
to get around the size limits of [Rule 2](rules.html#rule2).

Yes Virginia, **that is a hint**!

**`|`**   The [Rule 2a](rules.html#rule2a) size was changed from
4096 to 4993: a change that keeps the "2b to 2a" size ratio to a
value similar to the [2001-2020 IOCCC era](../faq.html#size_rule).

**`|`**   We recommend that you use the
[example Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example)
from the [IOCCC mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).
renamed as `Makefile` of course, as the starting point for your submissions
required `Makefile`.  Feel free to modify the Makefile to suit your obfuscated needs.

**`|`**   The rest of these guidelines will assume that you are using some variant of the
[example Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example),
renamed as `Makefile` of course.

**`|`**   We suggest that you compile your submission with a commonly available
`-std=gnu17` (ISO C 2017 with GNU extensions) C compiler.

**`|`**   Unless you clearly state otherwise in your `remarks.md` file AND put into your
submission's `Makefile`, we will compile using `-O3 -std=gnu17`.

**`|`**   It is **OK** to require your submission to not be compiled
using the default `-O3 -g3 -std=gnu17` settings.  Simply explain why
your submission should not be compiled using `-O3 -g3 -std=gnu17` in
your `remarks.md` file and adjust your `Makefile` accordingly.

**`|`**   **IMPORTANT NOTE**: The use of `-std=gnu17` does **NOT** imply the use of the `gcc`
compiler!  We often start by compiling using the **clang** C compiler instead.

**`|`**   You may change the standard under which your submission is compiled
by modifying the `CSTD` Makefile variable.  For example, to use `c17` instead:

``` <!---make-->
    CSTD= -std=c17
```

**`|`**   For compilers, such as clang, that have the `-Weverything` option,
while you may wish to try it, you should look at [the FAQ about clang
-Weverything](../faq.html#weverything).  We do **NOT** recommend that you put
the use of `-Weverything` into your submission's `Makefile` for the reasons
cited there. This goes even if your version does not trigger a warning as some
other version might.

**`|`**   You may change the level of optimization and compiler debug level
that your submission is compiled with, by modifying the `OPT` Makefile variable.
For example, to compile without optimization and debug symbols:

``` <!---make-->
    OPT= -O0 -g3
```

**`|`**   There is no real penalty for compiler warnings.  Sometimes
compiler warnings cannot be helped: especially in the case of
obfuscated C.  :-)  So if you cannot easily get rid of a compiler
warning, try not fret too much.

**`|`**   To turn off a compiler warning, to your submission's `Makefile`,
try something such as:

``` <!---make-->
    CSILENCE= -Wno-some-thing -Wno-another-thing -Wno-unknown-warning-option
```

**`|`**   If you do add "`-Wno-some-thing`" to your Makefile,
consider also adding `-Wno-unknown-warning-option` just in case the
warning you use is not available in the compilers we use test your
submission. Observe, however, that some compilers **DO NOT** have that option so
you might wish to note this in your **remarks.md** as it can be a command line
error.

**`|`**   If you need to define something on the compile line, use
the `CDEFINE` Makefile variable.  For example:

``` <!---make-->
    CDEFINE= -Dfoo -Dbar=baz
```

**`|`**   If you need to include a file on the command line, use
the `CINCLUDE` Makefile variable.  For example:

``` <!---make-->
    CINCLUDE= -include stdio.h
```


**`|`**   If need add other "_magic_" flags to your compile line,
use the `COTHER` Makefile variable.  For example:

``` <!---make-->
    COTHER= -fno-math-errno
```

**NOTE**: We recommend using "_magic_" flags **only if BOTH _gcc_
and _clang_** support it.


<div id="likes">
<div id="dislikes">
# OUR LIKES AND DISLIKES:
</div>
</div>

**`|`**   We **LIKE** entries that use an edited variant of the
[example Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example),
renamed as `Makefile` of course.  This makes it easier for the [IOCCC Judges](../judges.html)
to test your submission. And if your submissions wins, integrate it into
the [Official IOCCC winner website](https://www.ioccc.org/index.html).

Doing masses of `#defines` to obscure the source has become 'old'.  We
tend to 'see thru' masses of `#defines` due to our pre-processor tests
that we apply.  Simply abusing `#defines` or `-Dfoo=bar` won't go as far
as a program that is more well rounded in confusion.

Many C compilers **DISLIKE** the following code, and so do we:

``` <!---c-->
    #define d define
    #d foo             /* <-- don't expect this to turn into #define foo */
```

When declaring local or global variables, you should declare the type:

``` <!---c-->
    int this_is_fine;
    this_is_not;       /* <-- Try to avoid implicit type declarations */
```

**`|`**   We **LIKE** code that has a minimum of warnings, especially under the
more strict ` -Wall -Wextra -pedantic` mode:

``` <!---make-->
    CWARN= -Wall -Wextra -pedantic
```

All other things being equal, a program that must turn off fewer
warnings will be considered better, for certain values of better.

**`|`**   We tend to **like less** a submission that requires either
**gcc** or **clang**.  We prefer submissions that can compile
under both **gcc** and **clang**.

**`|`**   We **RECOMMEND** that the compiler flags you use in your
submission's `Makefile` are supported by both **gcc** and **clang**.

**`|`**  We **DISLIKE** the use of obscure compiler flags, especially
if either **gcc** or **clang** does not support it.  We **suggest**
that you not use any really obscure compiler flags if you can help it.

One side effect of the above is that you cannot assume the use
of nested functions such as:

``` <!---c-->
     main() {
|        void please_dont_submit_this() {
|           printf("The machine that goes BING!!\n");
         }
|        please_dont_submit_this();
     }
```

**`|`**  On 2012 July 20, the judges rescinded the encouragement of
nested functions.  Such constructions, while interesting and sometimes
amusing, will have to wait until they required by a C standard that are
actually implemented in both **gcc** and **clang**.

**`|`**  We **DISLIKE** submissions require the use of `-fnested-functions`.

We prefer programs that do not require a fish license: crayons and
cat detector vans not withstanding.

If your submission uses functions that have a variable number of
arguments, be careful. Systems implement `va_list` as a wide variety
of ways.  Because of this, a number of operations using `va_list` are
not portable and must not be used:

* assigning a non-`va_list` variable to/from a `va_list` variable
* casting a non-`va_list` variable into/from a `va_list` variable
* passing a `va_list` variable to a function expecting a non-`va_list` arg
* passing a non-`va_list` variable to a function expecting a `va_list` arg
* performing arithmetic on `va_list` variables
* using `va_list` as a structure or union

In particular, do not treat `va_list` variables as if they were a `char **`s.

**`|`**   We **DISLIKE** the use of `varargs.h`.  Use `stdarg.h` instead.

**`|`**   We **DISLIKE** the use of `gets(3)`.  Use `fgets(3)` instead.

On 28 January 2007, the Judges rescinded the requirement that the
`#` in a C preprocessor directive must be the 1st non-whitespace octet.

The `exit(3)` function returns `void`.  Some broken systems have `exit(3)`
return `int`, your submission should assume that `exit(3)` returns a `void`.

**`|`**   This _guideline_ has a change mark at the very start of this line.

Small programs are best when they are short, obscure and concise.
While such programs are not as complex as other winners, they do
serve a useful purpose.  They are often the only program that people
attempt to completely understand.  For this reason, we look for
programs that are compact, and are instructional.

While those who are used to temperatures found on [dwarf
planet](https://science.nasa.gov/dwarf-planets/),
(**yes Virginia, dwarf planets are planets**) such as
[Pluto](https://science.nasa.gov/dwarf-planets/pluto/) might be able to
explain to the Walrus why our seas are boiling hot, the question of
whether pigs have wings is likely to remain a debatable point to most.

One line programs should be short one line programs: say around 80 to 120
octets long.  Going well beyond 140 octets is a bit too long to be called
a one-liner in our vague opinion.

We tend to **DISLIKE** programs that:

* are very hardware specific
* are very OS version specific (index/strchr differences are OK, but socket/streams specific code is likely not to be)<br>
**`|`**   * dump core or have compiler warnings (it is OK only if you warn us in your 'remark.md' file)<br>
**`|`**   * won't compile or run a [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) environment
* depend on a utility or application not normally found systems that conform to the [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
* abuse the build file to get around the size limit<br>
**`|`**   * obfuscate by use of ANSI trigraphs<br>
**`|`**   * are larger than they need to be<br>
**`|`**   * have more lines than they need to have<br>
**`|`**   * are "blob-ier" (just a pile of unformatted C code) than they need to be
* are rather similar to **previous winners** :-(
* are identical to **previous losers** :-)
* that mandate the exclusive use of a specific Integrated Development Environment (IDE)

In order to encourage submission portability, we **DISLIKE** entries that
fail to build unless one is using an IDE. For example, do not
mandate that one must use Microsoft Visual Studio to compile
your submission.  Nevertheless some of the better IDEs have command-line
interfaces to their compilers, once one learns how to invoke a shell.

**`|`**   The program must compile and link cleanly in a [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) environment Therefore do not assume the system has a
[windows.h](https://en.wikipedia.org/wiki/Windows.h) include file:

``` <!---c-->
    #include <windows.h>        /* we DISLIKE this include */
```

Unless you are cramped for space, or unless you are entering the
'_Best one liner_' category, we suggest that you format your program
in a more creative way than simply forming excessively long lines.

At least one judge prefers to maintain the use of the
[leap-second](https://en.wikipedia.org/wiki/Leap_second)
as part of the world's time standard.  If your code prints time
with seconds, we prefer that your code be capable of printing the
time of day during a leap-second where the value in seconds
after the minute mark is 60.

The "_how to build_" make process should not be used to try and get
around the size limit.  It is one thing to make use of a several `-D`s
on the compile line to help out, but it is quite another to use many
bytes of `-D`s in order to try and squeeze the source under the size limit.

Your source code, post-pre-processing, should not exceed the size of
[Windows](https://en.wikipedia.org/wiki/Microsoft_Windows). :-)

The judges, as a group, have a history giving wide degree of latitude
to reasonable entries.  And recently they have had as much longitudinal
variation as it is possible to have on Earth.  :-)

**`|`**   You should try to restrict commands used on the build file to
commands found in [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) environments
and systems that conform to the [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).

**`|`**   You may compile and use your own programs.  If you do, try to build and execute
from the current directory.  This restriction is not a hard and
absolute one.  The intent is to ensure that the building if your
program is reasonably portable.

We prefer programs that are portable across a wide variety of Unix-like
operating systems (i.e., Linux, GNU Hurd, BSD, Unix, etc.).

You are in a maze of twisty _guidelines_, all different.

There are at least zero judges who think that Fideism has little
or nothing to do with the IOCCC judging process.

Don't forget that the building of your program should be done
**WITHOUT human intervention**.  So don't do things such as:

```
    prog: prog.c
        #echo this next line requires data from standard input
        cat > prog.c
        ${CC} prog.c -o prog
```

However, you can do something cute such as making your program
do something dumb (or cute) when it is built 'automatically', and
when it is run with a human involved, do something more clever.
For example, one could use the build instructions:

```
    prog: prog.c
        ${CC} prog.c -DNON_HUMAN_COMPILE -o prog
        @echo "See remarks section about alternate ways to compile"
```

and then include special notes in tour `remarks.md` file for
alternate / human intervention based building.

We want to get away from source that is simply a compact blob of
octets.   Really try to be more creative than blob coding. **HINT!**

Please do not use things like `gzip(1)` to get around the size limit.
Please try to be much more creative.

We really **DISLIKE** entries that make blatant use of including
large data files to get around the source code size limit.

We do not recommend submitting [systemd](https://systemd.io) source code to the IOCCC,
if nothing else because that code is likely to exceed [the source code
size limit](rules.html#rule2).  This isn't to say that another highly compact and obfuscated
replacement of `init` would not be an interesting submission.

Did we remember to indicate that programs that blatantly use
some complex state machine to do something simple are boring?
We think we did.  :-)

> All generalizations are false, including this one. -- Mark Twain

Given two versions of the same program, one that is a compact blob
of code, and the other that is formatted more like a typical C
program, we tend to favor the second version.  Of course, a third
version of the same program that is formatted in an interesting
and/or obfuscated way, would definitely win over the first two!
Remember, you can submit more than one submission.  See the [IOCCC rules](rules.html) for details.

We suggest that you avoid trying for the 'smallest self-replicating'
source.  The smallest, a zero byte submission, [won in 1994](../1994/smr/index.html).

Programs that claim to be the smallest C source that does something, really
better be the smallest such program or they risk being rejected because
they do not work as documented.

Please note that the C source below, besides lacking in obfuscation,
is NOT the smallest C source file that when compiled and run, dumps core:

``` <!---c-->
    main;
```

**`|`**   Unless you specify `-fwritable-strings` (see `COTHER` in the [example Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example) do not assume this sort of code will work:

``` <!---c-->
    char *T = "So many primes, so little time!";
    ...
    T[14] = ';';    /* modifying a string requires: -fwritable-strings */
```

**`|`**   Initialized char arrays are OK to write over.  This is OK:

``` <!---c-->
    char b[] = "Is this OK";
    b[9] = 'k';     /* modifying an initialized char array is OK */
```

**`|`**   There are more than 1 typos in this very sentence.

X client entries should be as portable as possible.  Entries that
adapt to a wide collection of environments will be favored.  For
example, don't depend on a particular type or size of display.
Don't assume the use of a particular browser.  Instead assume a
generic browser that forms to a widely used W3C standard.
Don't assume a particular sound sub-system or video driver is installed
in the OS. Instead, make use of a well known and widely available open
source program (one that actually works) to display audio/visual data.

X client entries should avoid using X related libraries and
software that is not in wide spread use.

This is the only _guideline_ that contains the word fizzbin.

**`|`**   However, do you know how to play [fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin)?
You do?!?  (Except on Tuesday?)

**`|`**   OK, there are actually 3 _guidelines_ that contain the word fizzbin.

We **DISLIKE** entries that use proprietary toolkits such as the `M*tif`,
`Xv*ew`, or `OpenL*ok` toolkits, since not everyone has them.  Use an
open source toolkit that is widely and freely available instead.

**NOTE**: The previous _guideline_ in this spot has been replaced by this _guideline_:

**`|`**   X client entries should try to not to depend on particular items on
`.Xdefaults`.  If you must do so, be sure to note the required lines
in the your `remarks.md` file.  They should also not depend on any
particular window manager.

**`|`**   Try to avoid entries that play some people believe is copyrighted music.

**`|`**   While we recognize that UNIX is not a universal operating system, the contest does have a bias towards such systems.  In an effort to expand the scope of the contest, we phrase our bias to favor the [Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).

**`|`**   You are **well advised** to submit entries that conform to the [Single UNIX Specification Version 4](https://unix.org/version4/overview.html).

**`|`**   To quote the [IOCCC judges](../judges.html):

> You very well might not be completely be prohibited from failing to not<br>
> partly misunderstand this particular _guideline_, but of course, we could<br>
> not possibly comment!  :-)  Nevertheless, you are neither prohibited, nor are<br>
> you fully required to determine that this or the previous sentence is either false<br>
> and/or perhaps misleading.  Therefore, it might be wise for you to not fail to<br>
> consider to not do so, accordingly. Thank you very much.

Any complaints about the above _guideline_ could be addressed to the
Speaker of the House of Commons, or to the speaker of your national
parliament should you have one.

We **LIKE** programs that:

* are as concise and small as they need to be
* do something at least quasi-interesting
* are portable
* are unique or novel in their obfuscation style
* make use of a **NUMBER OF DIFFERENT TYPES OF OBFUSCATIONS!**  **<== HINT!!**
* make us laugh and/or throw up  :-)  (humor really helps!)
* make us want to eat good chocolate

Some types of programs can't excel (anti-tm) in some areas.  Your
program doesn't have to excel in all areas, but doing well in several
areas really does help.

**`|`**   You are better off explaining what your submission does in your
`remarks.md` file section rather than leaving it obscure for the judges
as we might miss something and/or be too tired to notice.

**`|`**   Please avoid this specific individual _guideline_, if it at all possible.

**`|`**   We freely admit that interesting, creative or humorous comments in
your `remarks.md` file help your chances of winning.  If you had to
read so many twisted entries, you too would enjoy a good laugh or two.
We think the readers of the contest winners do as well.  We do read
the your `remarks.md` content during the judging process, so it is worth your
while to write remarkable `remarks.md` file.

We **DISLIKE** C code with trailing control-M's (`\r` or `\015`) that results
in compilation failures.  Some non-Unix/non-Linux tools such as
MS Visual C and MS Visual C++ leave trailing control-M's on lines.
Users of such tools should strip off such control-M's before submitting
their entries.  In some cases tools have a "Save As" option that will
prevent such trailing control-M's being added.

One should restrict libcurses to portable features found on BSD
or Linux curses.

[Rule 13](rules.html#rule13)  states any C source that fails to compile because of unescaped
octets with the high bit set (octet value >= 128) will be rejected.
Instead of unescaped octets, you should use \octal or \hex escapes:

``` <!---c-->

              /* 123456789 123456789 123456789 123456 */
    char *foo = "This string is 36 octets in length \263";
          /* This octet requires 4 octets of source ^^^^ */
    if (strlen(foo) == 36) printf("foo is 36 octets plus a final NUL\n");
    else printf("This code should not print this message\n");
```

**`|`**   It is a very good idea to, in your `remarks.md` file, tell us why you
think your submission is obfuscated.  This is particularly true if
your submission is has some very subtle obfuscations that we might
otherwise overlook.  **<<-- Hint!**

Anyone can format their code into a dense blob.  A really clever
author will try format their submission using a "normal" formatting style
such that at first glance (if you squint and don't look at the details)
the code might pass for non-obfuscated C.  Deceptive comments,
and misleading formatting, in some cases, may be a plus.  On the
other hand, a misleading code style requires more source bytes.

If you do elect to use misleading formatting and comments, we
suggest you remark on this point in your remarks where you talk
about why you think your submission is obfuscated.  On the other hand,
if you are pushing up against the size limits, you may be forced
into creating a dense blob. Such are the trade-offs that obfuscators face!

**`|`**   We prefer code that can run on either a 64-bit or 32-bit
processor.  However, it is **UNWISE **to assume it will run on an
some Intel-like x86 architecture.

We believe that Mark Twain's once wrote:

> Get your facts first, then you can distort them as you please.

... is a good motto for those writing code for the IOCCC.

**`|`**   The [IOCCC size tool source](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)
is not an original work, unless you are Anthony C Howe, in which case it is original!  :-)
Submitting source that uses the content of iocccsize.c, unless you are
Anthony C Howe, might run the risk of violating [Rule 7](rules.html#rule7).

[Rule 7](rules.html#rule7) does not prohibit you from writing your own obfuscated IOCCC size tool.
However if you do, you might wish to make your tool do something more
interesting than simply implementing the IOCCC size tool algorithm.

While programs that only run in a specific word size are OK.  If you have
to pick, choose a 64-bit word size.

**`|`**   If [IOCCC judges](../judges.html) are feeling ornery we
might choose to compile your program for running on an Arduino or
a PDP-11.  Heck, should we ever find an emulator of 60-bit CDC Cyber
CPU, we might just try your submission on that emulator as well :-)

**`|`**   If your submission **MUST** run only on a 64-bit or 32-bit architecture,
then you **MUST** specify the `-arch` on your command line
(see `ARCH` in the [example Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example).  Do not assume a processor word size without specifying `-arch`.  For example:

``` <!---make-->
    ARCH= -m64
```

**`|`**   Try to be even more creative!

**`|`**   If there are limitations in your submission, you are highly encouraged
to note such limitations in your `remarks.md` file.  For example if your
submission factors values up to a certain size, you might want to state:

>   This submission factors values up 2305567963945518424753102147331756070.<br>
>   Attempting to factor larger values will produce unpredictable results.

The judges might try to factor the value -5, so you want to might state:

>   This submission factors positive values up 2305567963945518424753102147331756070.<br>
>   Attempting to factor large values will produce unpredictable results.

However the judges might try to also factor 0, so you want to might state:

>   This submission factors values between 1 and 2305567963945518424753102147331756070.<br>
>   Attempting to factor values outside that range will produce unpredictable results.

Moreover the try to also factor 3.5 or 0x7, or Fred, so you want to might state:

>   This submission factors integers between 1 and 2305567963945518424753102147331756070.<br>
>   Attempting to factor anything else will produce unpredictable results.

You submission might be better off catching the attempt to factor bogus values
and doing something interesting.  So you might want to code accordingly and state:

>   This submission factors integers between 1 and 2305567963945518424753102147331756070.<br>
>   Attempting to factor anything else will cause the program to insult your pet fish Eric.

The judges might not have a pet fish named Eric, so might want to state:

>   This submission factors integers between 1 and 2305567963945518424753102147331756070.<br>
>   Attempting to factor anything else will cause the program to insult your pet fish Eric,<br>
>   or in the case that you lack such a pet, will insult the pet that you do not have.

When all other things are equal, a submission with fewer limitations will be judged
better than a submission with lots of limitations.  So you might want to code accordingly
and state:

>   This submission attempts to a factor value of any size provided that the program is<br>
>   given enough time and memory.  If the value is not a proper integer, the program<br>
>   might insult a fish named Eric.

**`|`**   Do not fear if you not 100% sure of the significance of `2305567963945518424753102147331756070` as it is not of prime importance: or is it?  :-)

**`|`**   We **DISLIKE** the use of use ASCII tab characters in markdown files, such as in the required `remarks.md` file.

**`|`**   We don't mind the use ASCII tab characters in your C code.  Feel free to use ASCII tab characters if that suits your obfuscation needs.  If is perfectly **OK** to use tab characters elsewhere in your submission, just not in markdown files as this tends complicate and annoys us when be comes to rendering your markdown content.

**`|`**   If you do use ASCII tab characters in your non-markdown files, be aware that some people may use tab stop that is different than the common 8 character tab stop.

**`|`**   **PLEASE** observe our [IOCCC markdown guidelines](../markdown.html) when forming your submission's `remarks.md` file.  And if your submission contains additional markdown files, please follow those same guidelines.  See also [Rule 19](rules.html#rule19).

**`|`**   We **LIKE** a reading `remarks.md` files, especially if they contain useful, informative, and even humorous content about your submission.  Yes, this is a **hint**.  :-)

**`|`**   We **RECOMMEND** you put a reasonable amount effort into the content of the `remarks.md` file: it is a required for for a reason.  :-)




<div id="rules_abuse">
<div id="abusing_rules">
# ABUSING THE RULES:
</div>
</div>

Legal abuse of the [IOCCC rules](rules.html) is somewhat encouraged.  Legal rule abuse
may involve, but is not limited to, doing things that are technically allowed by
the [IOCCC rules](rules.html) and yet do not fit the spirit of what we intended to be
submitted.

Legal rule abuse is encouraged to help promote creativity.  Rule abuse
entries, regardless of if they receive an award, result in changes to
the next year's [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html).

Legal abuse of the [IOCCC rules](rules.html) is NOT an invitation to violate the
[IOCCC rules](rules.html). A submission that violates the [rules](rules.html) in the
opinion of the judges, **WILL** be
disqualified.  **_RULE ABUSE CARRIES A CERTAIN LEVEL OF RISK!_**  If you
have a submission that might otherwise be interesting, you might want to
submit two versions; one that does not abuse the [IOCCC rules](rules.html) and one that
does.

**`|`**   If you intend to abuse the [IOCCC rules](rules.html),
indicate so in your `remarks.md` file.  You **MUST** try to justify
why you consider your rule abuse to be allowed under the
[IOCCC rules](rules.html).  That is, you must plead your case as to why
your submission is valid.  Humor and/or creativity help plead a case.
As there is no guarantee that you will succeed, you might consider
submitting an alternate version that conforms to the
[IOCCC rules](rules.html).

**`|`**   If do bypass the `mkiocccentry(1)` warnings about [Rule
2a](rules.html#rule2a) and/or about [Rule 2b](rules.html#rule2b)
and submit a submission anyway, you **MUST** try to justify why the IOCCC
judges should not reject your submission due to a rule violation.

Abusing the web submission procedure tends to annoy us more
than amuse us.  Spend your creative energy on content of your
submission rather than on the submission process itself.

We are often asked why the contest [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) seem too
strange or contain mistakes, flaws or grammatical errors.  One reason
is that we sometimes make genuine mistakes.  But in many cases such
problems, flaws or areas of confusion are deliberate.  Changes to
[IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) in response to rule abuses, are done in a minimal
fashion.  Often we will deliberately leave behind holes (or introduce
new ones) so that future rule abuse may continue.  A cleaver author
should be able to read them and "drive a truck through the holes" in
the [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html).

At the risk of stating the obvious, this contest is a parody of the software
development process.  The [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html)
are only a small part of the overall contest.  Even so, one may think the
contest [IOCCC rules](rules.html) and [IOCCC guidelines](guidelines.html) process as a parody
of the sometimes tragic mismatch between what a customer (or marketing) wants
and what engineering delivers.  Real programmers must face obfuscated and
sometimes conflicting specifications and requirements from marketing, sales,
product management an even from customers themselves on a all too regular basis.
This is one of the reasons why the [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) are written in obfuscated form.


<div id="judging">
# JUDGING PROCESS:
</div>

Entries are judged by Leonid A. Broukhis and Landon Curt Noll.

Each submission submitted is given a random id number and subdirectory.  The
submission files including, but not limited to prog.c, Makefile (that we
form from around your "how to build" information), as well as any
data files that you submit are all placed under their own directory
stored and judged from this directory.

Any information about the authors is not read by the judges until
the judging process is complete, and then only from entries that have
won an award.  Because we do not read this information for entries that
do not win, we do not know who did not win.

The above process helps keep us biased for/against any one particular
individual.  Therefore you **MUST** refrain from putting any information
that reveals your identity in your submission.

Now some people point out that coding style might reveal the information
about the others.  However we consider this to be simply circumstantial
and outside the scope of the above paragraph.

Some people, in the past, have attempted to obfuscate their identity by
including comments of famous Internet personalities such as [Peter
Honeyman](http://www.citi.umich.edu/u/honey).  The judges are on to this trick
and therefore consider any obfuscated source or data file claiming to be from
Honeyman to not be form Honeyman.  This of course creates an interesting paradox
known as the "obfuscated Peter Honeyman paradox".  Should Peter Honeyman
actually submit an obfuscated submission, he alone is excluded from the above, as we
will likely believe it just another attempt at confusion.  This _guideline_ is
known as the "Peter Honeyman is exempt" _guideline_.

BTW: None of the entries claiming to be from Peter Honeyman have ever
won an award.  So it is theoretically possible that Peter Honeyman
did submit a submission in the past.  In the past, Peter had denied
submitting anything to the IOCCC.  Perhaps those entries were
submitted by one of his students?

**`|`**   Hopefully we are **VERY CLEAR** on this point!  The rules now strongly state:
**PLEASE _DO NOT_ put a name of an author**, in an obvious way, into your
source code, `remarks.md`, data files, etc.  The above "Peter Honeyman is
exempt" notwithstanding.

We seemed to have digressed again ... :-)  Returning to the judging process:

We prefer to be kept in the dark as much as you are until the final
awards are given.  We enjoy the surprise of finding out in the end,
who won and where they were from.

We attempt to keep all entries anonymous, unless they win an award.
Because the main 'prize' of winning is being announced, we make all
attempts to send non-winners into oblivion.  We remove all non-winning
files, and shred all related paper.  By tradition, we do not even
reveal the number of entries that we received.

During the judging process, a process that spans multiple sessions
over a few weeks, we post general updates from our [Mastodon
account](https://fosstodon.org/@ioccc). Make sure you reload the feed every so
often as unless you are mentioned you will not get a push notification.

<div id="rounds">
## JUDGING ROUNDS:
</div>

Judging consists of a number of elimination rounds.  During a round,
the collection of entries are divided into two roughly equal piles;
the pile that advances on to the next round, and the pile that does
not.  We also re-examine the entries that were eliminated in the
previous round.  Thus, a submission gets at least two readings.

<div id="readings">
## JUDGING READINGS:
</div>

A reading consists of a number of actions:

* reading the "how to build" information and forming a Makefile
* reading prog.c, the C source<br>
**`|`**   * reviewing the `remarks.md` information
* briefly looking any any supplied data files
* passing the source thru the C pre-processor
    skipping over any #include files
* performing a number of C beautify/cleanup edits on the source
* passing the beautified source thru the C pre-processor
    skipping over any #include files
* compiling/building the source
* running the program
* Doing other things that only [IOCCC judges](../judges.html) know about :-)

In later rounds, other actions are performed including performing
miscellaneous tests on the source and binary.

**`|`**   This is the very _guideline_ that goes, BING!

Until we reduce the stack of entries down to about 25 entries, entries
are judged on an individual basis.  A submission is set aside because it
does not, in our opinion, meet the standard established by the round.
When the number of entries thins to about 25 entries, we begin to form
award categories.  Entries begin to compete with each other for awards.
A submission will often compete in several categories.

The actual award category list will vary depending on the types of entries
we receive.  A typical category list might be:

* best small one line program (see above about one line programs)
* best small program
* strangest/most creative source layout
* most useful obfuscated program
* best game that is obfuscated
* most creatively obfuscated program
* most deceptive C code (code with deceptive comments and source code)
* best X client (see OUR LIKES AND DISLIKES)
* best abuse of ISO C or ANSI C standard (see above about compilers)
* best abuse of the C preprocessor
* worst abuse of the rules
* (anything else so strange that it deserves an award)

We do not limit ourselves to this list.  For example, a few entries are so
good/bad that they are declared winners at the start of the final round.
We will invent awards categories for them, if necessary.

In the final round process, we perform the difficult tasks of
reducing the remaining entries (typically about 25) down to to about
half that number: declaring those remaining to be winners.

Often we are confident that the entries that make it into
the final round are definitely better than the ones that do not
make it.  The selection of the winners out of the final round, is
less clear cut.

Sometimes a final round submission is good enough to win, but is beat out
by a similar, but slightly better submission.  For this reason, it is
sometimes worthwhile to re-enter an improved version of a submission
that failed to win in a previous year.  This assumes, of course,
that the submission is worth improving in the first place!

**`|`**   Over the years, more than one [IOCCC judge](../judges.html)
has been known to _bribe_ another IOCCC judge into voting for a
winning submission by offering a bit high quality chocolate, or
other fun item.

**`|`**   One **should not** attempt to _bribe_ an [IOCCC
judge](../judges.html), unless you are an [IOCCC judge](../judges.html),
because _bribing_ a [IOCCC judge](../judges.html) by a non-judge
has been shown to **NOT** be effective when the **person attempting
the bribe is made known** to the [IOCCC judges](../judges.html)
(i.e., they are not anonymous) AND/OR the _bribe_ is otherwise
associated with a submission to the IOCCC.

**`|`**   With the previous guideline in mind: **anonymous** gifts
for the [IOCCC judges](../judges.html) that are **NOT** associated
with a submission to the IOCCC may be sent to the
[IOCCC judges](../judges.html) via the
[IOCCC Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/3HSNTEL8RQ1M0?ref_=wl_share).
It has been shown that receiving  **anonymous** gifts provides the
[IOCCC judges](../judges.html) with a nice dopamine boost, and happy
[IOCCC judges](../judges.html) help make the IOCCC better for everyone. :-)

**`|`**   See [FAQ: How may I support the IOCCC?](../faq.html#support).

More often than not, we select a small submission (usually one line), a
strange/creative layout submission.  We sometimes also select an
submission that abuses the [IOCCC guidelines](guidelines.html) in an interesting way,
or that stretches the content rules that while legal, is
nevertheless goes against the intent of the rules.

In the end, we traditionally pick one submission as 'best'.  Sometimes such
a submission simply far exceeds any of the other entries.  More often, the
'best' is picked because it does well in a number of categories.

In years past, we renamed the winning submission from prog.c to a
name related to the submitter(s) names.  This is no longer done.
Winning source is called prog.c  A compiled binary is called prog.


<div id="announcements">
# ANNOUNCEMENT OF WINNERS:
</div>

The judges will toot initial announcement of who won, the name
of their award, and a very brief description of the winning submission
from the [@IOCCC Mastodon account](https://fosstodon.org/@ioccc). You should
follow us on Mastodon and refresh the page (even if you do follow us) as unless
you are mentioned you will not get a notification.


<div id="winners">
## How the new IOCCC winners will be announced
</div>

**`|`**   The [Current status of the IOCCC](../status.html) will change from
**[judging](../status.html#judging)** to **[closed](../status.html#closed)** .

**`|`**   The **contest_status** in the [status.json](../status.json) file will change from **judging** to **closed** as well.

**`|`**   When the above happens, the winning entries have been selected by the [IOCCC judges](../judges.html).

**`|`**   The [IOCCC judges](../judges.html) will begin to prepare to release the source code of the new IOCCC winners.

**`|`**   The [IOCCC judges](../judges.html) will post the winning source to the [IOCCC winner repo](https://github.com/ioccc-src/winner) as well as to the [Official IOCCC winner website](https://www.ioccc.org/index.html).

**`|`**   The [IOCCC news](../news.html) will also contain an announcement of the winners.


<div id="mastodon">
## An important update to how winners are announced
</div>

**`|`** The IOCCC no longer uses twitter.  IOCCC entries will be announced by a
git commit to the [IOCCC entries repo](https://github.com/ioccc-src/winner)
that, in turn, updates the [official IOCCC
website](https://www.ioccc.org/index.html).

**`|`** In addition a note is posted to the [IOCCC Mastodon account](https://fosstodon.org/@ioccc).


<div id="entries">
## Back to announcement of winners
</div>

**`|`**   It is pointless to ask the [IOCCC judges](../judges.html) how many
submissions we receive.  See [How many submissions do the judges receive for a given IOCCC](../faq.html#how_many).

Often, winning entries are published in selected magazines from around
the world.  Winners have appeared in books ("The New Hackers Dictionary")
and on T-Shirts.  More than one winner has been turned into a tattoo!

Last, but not least, winners receive international fame and flames!  :-)


<div id="more-information">
<div id="information">
# FOR MORE INFORMATION:
</div>
</div>

**`|`**   For questions or comments about the contest, see [Contacting the IOCCC](../contact.html).

**`|`**   Be sure to review the [IOCCC Rules and Guidelines](index.html) as the
[IOCCC rules](rules.html) and the [IOCCC guidelines](guidelines.html) may (and often do) change from year to year.

**`|`**   You should be sure you have the current [IOCCC rules](rules.html) and
[IOCCC guidelines](guidelines.html) prior to submitting entries.

**`|`**   See the [Official IOCCC website news](../news.html) for additional information.

**`|`**   For the updates and breaking [IOCCC news](../news.html), you are encouraged to follow
the [IOCCC on Mastodon](https://fosstodon.org/@ioccc).  See our
[FAQ on Mastodon](../faq.html#try_mastodon) for more information. Please be aware that
unless you are mentioned you most likely will **NOT** get a notification
so you should make sure to check the page.

**`|`**   Check out the [Official IOCCC website](https://www.ioccc.org/index.html) in general.

Leonid A. Broukhis<br>
chongo (Landon Curt Noll) /\\cc/\\


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)
