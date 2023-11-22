# FAQ Table of Contents

## Section  0 - [History of the IOCCC](#faq0)
- [0.0  - How did the IOCCC get started?](#faq0_0)
- [0.1  - Why are some years missing IOCCC winners?](#faq0_1)
- [0.2  - Why do some IOCCC winners receive the Grand Prize or Best of Show award?](#faq0_2)

## Section  1 - [Submitting entries to a new IOCCC](#faq1)
- [1.0  - What types of entries have been over-submitted to the IOCCC?](#faq1_0)
- [1.1  - What should I put in my entry's Makefile?](#faq1_1)
- [1.2  - May I use a different source or compiled filename than prog.c or prog?](#faq1_2)
- [1.3  - What platform should I assume for my entry?](#faq1_3)

## Section  2 - [IOCCC Judging process](#faq2)
- [2.0  - How many entries do the judges receive for a given IOCCC?](#faq2_0)
- [2.1  - What should I put in the remarks.md file of my entry?](#faq2_1)
- [2.2  - Why don't you publish non-winners?](#faq2_2)
- [2.3  - How much time does it take to judge the contest?](#faq2_3)
- [2.4  - How many judging rounds do you have?](#faq2_4)

## Section  3 - [Compiling and running IOCCC winners](#faq3)
- [3.0  - What Makefile are available to build or clean up IOCCC winners?](#faq3_0)
- [3.1  - Why doesn't this IOCCC winner compile?](#faq3_1)
- [3.2  - Why does a IOCCC winner fail on my 64-bit system?](#faq3_2)
- [3.3  - Why do some IOCCC winners fail to compile under macOS?](#faq3_3)
- [3.4  - Why does clang or gcc fail to compile an IOCCC winner?](#faq3_4)
- [3.5  - What is this cb tool that is mentioned in the IOCCC?](#faq3_5)
- [3.6  - An IOCCC winner missed by my terminal application, how do I fix this?](#faq3_6)
- [3.7  - How do I compile and use on macOS, an IOCCC winner that requires X11?](#faq3_7)
- [3.8  - How do I compile an IOCCC winner that requires SDL1 or SDL2?](#faq3_8)
- [3.9  - How do I compile an IOCCC winner that requires (n)curses?](#faq3_9)
- [3.10 - How do I compile and use on macOS, an IOCCC winner that requires sound?](#faq3_10)
- [3.11 - Why do Makefiles use -Weverything with clang?](#faq3_11)
- [3.12 - How do I find out how to send interrupt/EOF etc. for entries that
require it?](#faq3_12)

## Section  4 - [Changes made to IOCCC winners](#faq4)
- [4.0  - Why are some winning author remarks incongruent with the winning IOCCC code?](#faq4_0)
- [4.1  - Why were some calls to the libc function `gets(3)` changed to use `fgets(3)`?](#faq4_1)
- [4.2  - What was changed in an IOCCC winner source code?](#faq4_2)
- [4.3  - Why do author remarks sometimes not match the source / why are there
other inconsistencies with the original entry?](#faq4_3)
- [4.4  - What is the meaning of the file ending in .orig.c in IOCCC winners?](#faq4_4)

## Section  5 - [Updating or correcting IOCCC web site content](#faq5)
- [5.0  - Why does an IOCCC winner fail to compile or or fail run?](#faq5_0)
- [5.1  - How do I report a bug in an IOCCC winner?](#faq5_1)

## Section  6 - [Miscellaneous IOCCC](#faq6)
- [6.0  - How did an entry breaks the size rule 2, win the IOCCC?](#faq6_0)
- [6.1  - Is there a list of known bugs and (mis)features of IOCCC winners?](#faq6_1)
- [6.2  - May I mirror the IOCCC web site?](#faq6_2)
- [6.3  - May I use parts of the IOCCC in an article, book, newsletter, or instructional material?](#faq6_3)
- [6.4  - Why do you sometimes use the first person plural?](#faq6_4)


# The IOCCC FAQ


## <a name="faq0"></a>Section 0: History of the IOCCC


### <a name="faq0_0"></a>FAQ 0.0: How did the IOCCC get started?

One day (1984 March 23 to be exact), Larry Bassel and I (Landon Curt
Noll) were working for National Semiconductor's Genix porting group, we
were both in our offices trying to fix some very broken code.

Larry had been trying to fix a bug in the classic Bourne shell (C code #defined
to death to sort of look like Algol) and I had been working on the finger
program from early BSD (a bug ridden finger implementation to be sure).

We happened to both wander (at the same time) out to the hallway
in Building 7C to clear our heads.

We began to compare notes: '_You won't believe the code I am trying to fix_'.

And: '_Well you cannot imagine the brain damage level of the code I'm trying to
fix'_.

As well as: '_It's more than bad code, the author really had to try to make it
this bad!_

After a few minutes we wandered back into my office where I posted a
[flame to
net.lang.c](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=789%40nsc.UUCP&rnum=3&filter=0")
inviting people to try and out obfuscate the UN\*X source code we had just been working on.

BTW: I (Landon Curt Noll) had to post this [typo
correction](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=795%40nsc.UUCP&rnum=10&filter=0).
Thus began the tradition of putting typos in the contest rules and guidelines
... to make them more obfuscated of course! :-)

BTW: This posting was made back in the days when AT&amp;T was the evil giant.
Now, Microsoft makes AT&amp;T look mild and kind in comparison. :-( (IMHO) ).

BTW: See the story about the '[Bill Gates](/1993/mills/README.md)' award. :-)

OK, back to the story.

We (Larry and I) received a number of entries by email.
When we began to receive messages from outside of the US, Larry and I
decided to include International in the name.

The
[1st IOCCC winners](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
were posted on 17 April 1984.

There were 4 winners in 1984:

1. [(dis)honorable mention](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=842%40nsc.UUCP&rnum=8&filter=0)
2.  [3rd place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=843%40nsc.UUCP&rnum=7&filter=0)
3. [2nd place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=844%40nsc.UUCP&rnum=6&filter=0)
4. [1st place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=845%40nsc.UUCP&rnum=5&filter=0)

BTW: The (dis)honorable mention wished to remain anonymous.
While many have asked who it was, we have continued to follow the
author's wish to remain anonymous.

A few years ago, we asked the author if they still wanted to remain anonymous.
They said: '_Yes, I want to keep my anonymity.  But you can tell them that I am well known for my connection to the
C language_'. It was not until 2001 that another [anonymous
entry](/years.html#2001_anonymous) received an award.

BTW: The [1984 winner](/years.html#1984_mullender) remains one of my (Landon Curt Noll) all time favorites.

The name used in the posting of the [1st IOCCC
winner](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
posting was **I**nternational **O**bfuscated **C** **C**ode **C**ontest or
**IOCCC** for short.

The posting said '_1st annual_', so in 1985 we held the [2nd IOCCC contest](/years.html#1985)
and the tradition continues as the longest running contest on the Internet.

P.S. Part of the inspiration for making the IOCCC a contest goes to the
[Bulwer-Lytton fiction contest](http://www.bulwer-lytton.com/).

P^2.S. See the [overall README](/all/README) for more details.


### <a name="faq0_1"></a>FAQ 0.1: Why are some years missing IOCCC winners?

Some years, such as 1997, 1999, 2002-2003, 2007-2010, 2016-2017, 2021-2023, no IOCCC was held.

While we try to hold the IOCCC every year, sometime the other demands on the IOCCC judges
so not permit us to hold a new IOCCC.

The pause during the 2021-2023 period was due to the IOCCC judges developing tools to
make is much more likely for the IOCCC to be held in a yearly basis later on.


### <a name="faq0_2"></a>FAQ 0.2: Why do some IOCCC winners receive the Grand Prize or Best of Show award?

In some years, the IOCCC judges discover a truly amazing IOCCC winner that
stands out among all of the other IOCCC entries received that year.
For such an IOCCC winner, the IOCCC judges award a "Grand Prize"
or "Best of Show award.

In 1984-1987, the grand prize winners are:

- [1984/mullender](years.html#1984_mullender)

- [1985/shapiro](years.html#1985_shapiro)

- [1986/wall](years.html#1986_wall)

- [1987/lievaart](years.html#1987_lievaart)

Starting from 1988, the entry we liked the most in that year is called
"Best of Show". Here are the "Best of Show" entries:

- [1988/applin](years.html#1988_applin)

- [1989/jar.2](years.html#1989_jar.2)

- [1990/theorem](years.html#1990_theorem)

- [1991/brnstnd](years.html#1991_brnstnd)

- [1992/vern](years.html#1992_vern)

- [1996/august](years.html#1996_august)

- [1998/banks](years.html#1998_banks)

- [2000/jarijyrki](years.html#2000_jarijyrki)

- [2020/carlini](years.html#2020_carlini)


In 1993, 1994 and 1995 the judges were unable to select a clear overall
winner. So to give a nod to the entry that had the highest approval ranking
from the judges, they used the following awards:

- [1993/rince](years.html#1993_rince) - Most Well Rounded

- [1994/shapiro](years.html#1994_shapiro) - Most Well Rounded

- [1995/leo](years.html#1995_leo) - Best Use of Obfuscation

These could be considered the 'best entry' for those years with 1 or
more other entries that came in close behind.


## <a name="faq1"></a>Section 1: Submitting entries to a new IOCCC


### <a name="faq1_0"></a>FAQ 1.0: What types of entries have been over-submitted to the IOCCC?

There are types of entries that show up over and over again.  The
IOCCC judges, and we suspect the public that enjoy viewing the
results of the IOCCC, like variety.

While it is possible to win a new IOCCC with one of these
__over-submitted__ types of entries, level of the competition from
previous IOCCC winners make it more challenging to be successful.


It is also important to note that the [guidelines](guidelines.html) say:

> _We tend to dislike programs that: are similar to previous winners_


#### maze generator
- [1985/shapiro](years.html#1985_shapiro)

- [1991/buzzard](years.html#1991_buzzard)

- [1995/cdua](years.html#1995_cdua)

- [1995/dodsond2](years.html#1995_dodsond2)

- [1998/bas1](years.html#1998_bas1)


#### tic-tac-toe/noughts and crosses/Xs and Os game

- [1991/westley](years.html#1991_westley)

- [1996/jonth](years.html#1996_jonth)

- [2020/carlini](years.html#2020_carlini)


#### solitaire/Othello game

- [1987/lievaart](years.html#1987_lievaart)

- [1994/dodsond1](years.html#1994_dodsond1)


#### generating small primes (below is the list of all prime related winners)

- [1985/august](years.html#1985_august)

- [1988/applin](years.html#1988_applin)

- [1994/weisberg](years.html#1994_weisberg)

- [1995/makarios](years.html#1995_makarios)

- [1996/dalbec](years.html#1996_dalbec)

- [2000/bellard](years.html#2000_bellard)

_As you can see, just a list of primes (let alone small primes) does not cut it
anymore._


#### self reproducing program

- [1990/scjones](years.html#1990_scjones)

- [1994/smr](years.html#1994_smr) - _do not claim your program is the smallest one without seeing this!

- [2000/dhyang](years.html#2000_dhyang) - _unless you beat this one, your chances are slim_


#### entries that just print "Hello, world!"

- [1984/anonymous](years.html#1984_anonymous)

- [1985/applin](years.html#1985_applin)

- [1986/applin](years.html#1986_applin)

- [1986/holloway](years.html#1986_holloway)

- [1989/jar.1](years.html#1989_jar.1)

- [1992/lush](years.html#1992_lush)

- [2000/tomx](years.html#2000_tomx)

_**...it's so 20th century...**_


#### entries that use some complex state machine/table to print something

- [1988/isaak](years.html#1988_isaak)

- [1988/phillipps](years.html#1988_phillipps)

- [2018/ciura](years.html#2018_ciura)

- [2018/giles](years.html#2018_giles)


#### rot13

- [1985/sicherman](years.html#1985_sicherman)

- [1989/westley](years.html#1989_westley)

- [1990/dg](years.html#1990_dg)

- [1991/fine](years.html#1991_fine)


#### **pi** or **e** computation

- [1986/august](years.html#1986_august)

- [1988/robison](years.html#1988_robison)

- [1988/westley](years.html#1988_westley)

- [1989/roemer](years.html#1989_roemer)


#### Hints on overused themes

HINT: It is not fatal to send in those types of entries, it is just MUCH
HARDER to win. Such an entry would have to do something _really unique **AND**
interesting_ to even make it into the final judging rounds. Entries that
reuse these 'worn out' themes frequently lose to other entries that do
something different.

HINT: If you really MUST send in an entry based on an 'overused theme', be sure
that it is obfuscated in several new and novel ways. Be sure to _clearly_
explain near the beginning of your remarks why you are submitting a entry based
on an 'overused theme' and why the judges should not simply toss it out as being
boring.


### <a name="faq1_1"></a>FAQ 1.1: What should I put in my entry's Makefile?

We recommend starting with the [sample
Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example)
as found in the [mkiocccentry GitHub repo](https://github.com/ioccc-src/mkiocccentry),
(renamed as `Makefile` of course) as a starting point for your
entry's `Makefile`.

The `Makefile` is a file used by the `make(1)` command that contains
rules and UNIX shell-style commands.

The first and default rule should be the "all" rule and should build your entry's executable file.

If your entry depends on a particular source file name during compilation or execution,
your `Makefile` should copy `prog.c` into the desired filename.  For example:

If you are not familiar `Makefile`s, you might consider the following tutorials:

- [GNU make](https://www.gnu.org/software/make/manual/make.html#Introduction)
- [What is a Makefile and how does it work?](https://opensource.com/article/18/8/what-how-makefile)
- [Learn Makefiles](https://makefiletutorial.com)

For the `make(1)` _connoisseur_: As of 2023, IOCCC judges use [GNU
make compatible](https://www.gnu.org/software/make/) `make(1)`
command that is compatible with GNU Make version 3.81.


### <a name="faq1_2"></a>FAQ 1.2: May I use a different source or compiled filename than prog.c or prog?

While your entry's source filename, as submitted, must be `prog.c`, your entry's `Makefile`
may copy `prog.c` to a different filename as part of the compiling/building process.  For example:

```make
all: desired_name

desired_name: desired_name.c
	cc desired_name.c -o $@

desired_name.c: prog.c
	rm -f $@
	cp -f prog.c $@

clobber:
	rm -f desired_name.c desired_name
```

We recommend that the `make clobber` rule remove files that your entry
creates as part of the compiling/building process.

You may also copy the compiled `prog` into a different file as part of compiling process.
For example:

```make
different_name: prog
	rm -f $@
	cp -f prog $@
```


### <a name="faq1_3"></a>FAQ 1.3: What platform should I assume for my entry?

Your entry must compile with GCC and run under at least one flavor of UNIX (e.g.
Linux or Solaris). To improve chances to win, it should work under both BSD and
SysV style UNIX (think **stty cbreak**), and should not depend on endianness.
If it can compile and run on Windows and/or Mac  (see
[2000/thadgavin](/years.html#2000_thadgavin) for one example, amongst others),
even better. Being able to compile with other compilers like clang is also a
good thing.


## <a name="faq2"></a>Section 2: IOCCC Judging process


### <a name="faq2_0"></a>FAQ 2.0: How many entries do the judges receive for a given IOCCC?

By tradition, we do not say.


### <a name="faq2_1"></a>FAQ 2.1: What should I put in the remarks.md file of my entry?

While you may put in as much or as little as you wish into your entry's
`remarks.md` file, we do have few important suggestions:

We recommend that you explain how to use your entry.  Explain the
command line (if any command line options and arguments are used)
and any input or actions if applicable.

We highly recommend that you explain why you think your entry is
well obfuscated.

For those entries that win the IOCCC, we often use much of text from the
`remarks.md` file in the _Author's remarks_ section of the `README.md` file.
For this reason, a well written `remarks.md` file is considered a plus.

While not required, consider adding bit of humor to your `remarks.md`
as most people who are not humor impaired, as well as the IOCCC judges
appreciate the opportunity for a fun read as well as a chuckle or two.


#### What helps:

- explaining what your entry does

- how to entice it to do what it is supposed to do

- what obfuscations are used

- what are the limitations of your entry in respect of portability and/or input data

- how it works (if you are really condescending)


#### What does not help:

- admitting that your entry is not very obfuscated (you see, the contest is
called the **IOCCC**, not the **INVOCCC** :-) ); but even if you do not admit
it, not very obfuscated entries have a minuscule chance to win (although
[2000/tomx](years.html#2000_tomx) is a notable counterexample).

- mentioning your name or any identifying information in the remark section (or
in the C code for that matter) - we like to be unbiased during the judging
rounds; we look at the author name only if an entry wins. See the guidelines if
this is not clear!

- leaving the remark section empty.


### <a name="faq2_1"></a>FAQ 2.2: Why don't you publish non-winners?

Because the publication on the IOCCC site **_IS_** the award!
Anyone is free to put their IOCCC hopefuls, lookalikes and/or
non-winners on their web page for everyone to see.


### <a name="faq2_3"></a>FAQ 2.3: How much time does it take to judge the contest?

It takes a fair amount of time to setup, run, answer email, process entries,
review entries, trim down the set entries to a set of winners, doing the
write-up of the winners, announcing the winners, reviewing final edits of the
winning entry set, posting the winners, being flamed :-), tell folks who send in
late entries to wait until the next contest, etc... It takes a few weekends and
a number nights of study and work ... which is hard given that we are busy with
many other activities as well.

Note that we do not contact the author if an entry does not compile or does not
work as advertised, we might attempt to fix obvious compilation problems or
incompatibilities, but no more than that - so be sure that your entry does work
on at least a couple different platforms, at least one of them being UNIX or
POSIX-conforming.


### <a name="faq2_4"></a>FAQ 2.4: How many judging rounds do you have?

By tradition, we do not say how many judging rounds we have in a given IOCCC.

We often report when the IOCCC judges start the 1st round, and
when usually report when the IOCCC judges start near final judging rounds, and
sometimes we also report when we enter what we believe is the final judging round, so you may guess that we have at least 3 rounds.  :-)  The actual number of rounds is certainly more than 3.


## <a name="faq3"></a>Section 3: Compiling and running IOCCC winners


### <a name="faq3_0"></a>FAQ 3.0: What Makefile are available to build or clean up IOCCC winners?

In general the best way to compile everything in an entry directory is to run:

```sh
make clobber all
```

If you wish to compile every entry for every year you should go to the top level
directory and run the same command as above, `make clobber all`.

The `all` rule will build everything necessary except for the alternate
versions. Every Makefile has an `alt` rule but it will only do something if an
alternate version exists. To build all the entries along with any alternate code
you can do from the top level directory:

```
make clobber everything
```

If you wish to only build alternate code you can do:

```sh
make clobber alt
```

If you wish to not remove the entry binaries and only compile the additional alt
versions:

```sh
make alt
```

The following Makefile rules should be in all Makefiles:

- all: build the entry programs (main program and any supplementary program)
- alt: build alternate code
- clobber: clean up object files and all binary files (except for those that are
not compiled)
- clean: a simpler version of `clobber` that only removes object files. `make
clobber` depends on `clean` so running `make clobber` will invoke `make clean`.
- everything: equivalent to `make all alt`.

Are there any other rules? You tell us!

NOTE about the above rules: the Makefile default assumes `cc` which might be a
gcc-based compiler, or a clang-based compiler, or some other compiler. Only by
forcing `CC=clang` or `CC=gcc` will one invoke a specific compiler to, say,
enable or disable additional warnings or flags. Even so different versions or
compilers might do different things, have different defects or other issues.


### <a name="faq3_1"></a>FAQ 3.1: Why doesn't this IOCCC winner compile?

Some winners, particularly winners from long ago, no longer compile on more
modern systems because the C language has evolved (i.e. the modern C compilers
are much more strict in what they accept as a valid program), or the entry
depended on operation system and library features that where common back then
but are different/missing today.

Please see the [bugs.md](/bugs.md) file for details about known problems with IOCCC winners.  In some cases you may be dealing with a problematic entry.  In a few fun cases, the IOCCC does not compile by design!

If you have a fix that makes a minimal impact to the entry, then please consider submitting that change in the form of a pull request.  Please
see the FAQ 5.1 <a href="#pullrequst">"How do I report a bug in an IOCCC
winner"</a> for details.

In some cases alterinive code has been added that does compile on some or most systems.  Check the writeup for the entry for "alt" code and possible ways to compile and run that code.  In some cases we replaced the original code (but not the `.orig.c` file!) with code
that works for modern systems but one can view the original code in the
`.orig.c` files (sometimes the original code is also in the directory as a
`winner.alt.c` or `prog.alt.c`).


### <a name="faq3_2"></a>FAQ 3.2: Why does a IOCCC winner fail on my 64-bit system?

Unfortunately some older entries are non-portable and require 32-bit support or
32-bit binaries. A problem system here is macOS Catalina (10.15) as as of that
version macOS no longer supports 32-bit binaries. If the entry acts on a certain
type of binary, say ELF, then that will also be a problem depending on the
entry. For example [2001/anonymous](2001/anonymous/README.md) requires 32-bit
ELF binaries.

There are numerous example entries that require 32-bit binaries. We have tried
to note these in both the respective Makefiles and README.md files but it is
possible that some were missed. These entries are very likely in the
[bugs.md](/bugs.md) file and we welcome any help in making an alternate version
for 64-bit systems. Many were fixed to work with modern systems but some are
supposed to only work with 32-bit systems so any updated version of these
entries should be an alternate version.

Other entries like [2001/herrmann2](/thanks-for-fixes.md#2001herrmann2-readmemd)
now work with 32-bit AND 64-bit systems.

Please see the [bugs.md](/bugs.md) file for the problematic entry in question to see if the problem is known, and if a fix is wanted, consider trying to port the code to a 64-bit system and submitting a pull request with that change.  Pull requests that fix such code while trying to minimize the impact of any changes and preserving the spirit of the orignal code are very welcome!
Please
see the FAQ 5.1 <a href="#pullrequst">"How do I report a bug in an IOCCC
winner"</a> for details.


### <a name="faq3_3"></a>FAQ 3.3: Why do some IOCCC winners fail to compile under macOS?

If the entry requires gcc and you did not explicitly install gcc in macOS you
will not be able to run or use these entries. This is because macOS gcc is
actually clang, even `/usr/bin/gcc`.

That being said many (if not most) of these entries have been fixed and some
others will be looked at, when found.

In some cases the [bugs.md](/bugs.md) file may note a known macOS problem with an entry.  Should you manage to port the entry, and assuming your changes also attempt to preserve the orignal intent of the IOCCC entry, we would encourage you to submit a pull request with your ported code.
Please
see the FAQ 5.1 <a href="#pullrequst">"How do I report a bug in an IOCCC
winner"</a> for details.


### <a name="faq3_4"></a>FAQ 3.4: Why does clang or gcc fail to compile an IOCCC winner?

Although we have fixed numerous entries to work with clang (sometimes in an alt
version but usually in the program itself) there are some that simply cannot be
fixed or if they are fixable they have not yet been fixed (we are working on
this but other things have to be done too and all on free time).

This is because clang has some defects where the args of main() are required to
be a specific type and some versions of clang allow only 1, 2 or 3 args, not 4,
to main(). In the case of types of args many were changed to the right type and
then what was main() became another function of the original main() type.

At the same time some entries are not designed to work with clang. There might
be alternate code added at some point but as above this depends on free time and
other things that have to be done plus remembering to do it.

See if the problem is mentioned in [bugs.md](/bugs.md).  If you have a change that fixes the problem (even if it just a change to the `Makefile`) that doesn't negatively impact the entry too much, consider submitting that change in the form of a pull request.
Please
see the FAQ 5.1 <a href="#pullrequst">"How do I report a bug in an IOCCC
winner"</a> for details.


### <a name="faq3_5"></a>FAQ 3.5: What is this cb tool that is mentioned in the IOCCC?

This was a C beautifier for Unix, both AT&T and Berkeley, but it seems to no
longer be available, code wise, except for Plan 9, but Plan 9 was never used for
judging the IOCCC. A Unix man page for `cb`
[still exists](https://www.ibm.com/docs/en/aix/7.3?topic=c-cb-command).


### <a name="faq3_6"></a>FAQ 3.6: An IOCCC winner missed by my terminal application, how do I fix this?

The simplest way to do this is to type `reset`. If echo was disabled you can get
usually away with `stty echo`. Sometimes you can also get away with `stty sane`.
`reset` does the most but note that it will clear the screen (obviously `clear`
will too but it won't reset the terminal).


### <a name="faq3_7"></a><a name="X11macos"></a>FAQ 3.7: How do I compile and use on macOS, an IOCCC winner that requires X11?

As an example we will use [1993/jonth](1993/jonth/README.md) which works well
with macOS.

First of all you will need to install the [most recent
XQuartz](https://www.xquartz.orgl), preferably on an [Apple supported version of
macOS, preferably the most recent version](https://support.apple.com/macos).
Then open the "XQuartz" application (usually located in
`/Applications/Utilities/XQuartz.app`) by typing at the command line:

```sh
open /Applications/Utilities/XQuartz.app
```

With the "XQuartz" application open you will get an [X Window System
Manager](https://www.x.org/wiki/) launched with an [Xterm window
shell](https://en.wikipedia.org/wiki/Xterm) started:

<img alt="xterm-launch in macOS" src="png/xquartz-shell.png">

At this point you need to cd to the winning directory and compile it. For example:

<img alt="compiling an entry in xterm in macOS" src="png/xquartz-entry-compile.png">

And then run the program as directed by the `README.md` file. For example with
`1993/jonth`:

<img alt="running 1993/jonth in macOS" src="png/xquartz-1993-jonth.png">

Note that you can compile the code in your regular terminal prior to opening
XQuartz, should you wish to.


### <a name="faq3_8"></a>FAQ 3.8: How do I compile an IOCCC winner that requires SDL1 or SDL2?

This depends on your operating system but below are instructions for Linux and
macOS with alternative methods for macOS and different package managers with Linux.

#### Red Hat based linux

Execute one of the following as root or via sudo:

```sh
dnf install SDL2 SDL2-devel sdl12-compat sdl12-compat-devel
yum install SDL2 SDL2-devel sdl12-compat sdl12-compat-devel
```

In the past it was said that one might need to run `make` like:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

but this might not be necessary in more modern days especially as we use
`sdl-config` and `sdl2-config` which should find the proper paths.


#### Debian based linux

Execute the following as root or via sudo:

```sh
apt install libsdl1.2debian libsdl1.2-dev libsdl2-dev
```

and then try `make all` again.

In the past it was said that one might need to run `make` like:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

but this might not be necessary in more modern days especially as we use
`sdl-config` and `sdl2-config` which should find the proper paths.


#### Other linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### macOS

If you're using macOS there are at least three ways to obtain it. You can
download it from the SDL website and install the package. That will not
work well for the IOCCC but these will:


##### MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


```sh
sudo port install libsdl libsdl2
```


##### Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SDL and SDL2, execute the following command:

```sh
brew install sdl2 sdl12-compat
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### NOTE: there might be extra SDL packages required

In the case that some entries do not work even with SDL1/SDL2 installed it might
be that you need additional SDL libraries. See the entry's README.md for
details. If something is not noted you're welcome to report it as an issue or
fix it and make a new pull request.


### <a name="faq3_9"></a>FAQ 3.9: How do I compile an IOCCC winner that requires (n)curses?

This depends on your operating system but below are instructions for Linux and
macOS with alternative methods for macOS and different package managers with Linux.

#### Red Hat based linux

Execute one of the following as root or via sudo:

```sh
dnf install ncurses ncurses-devel
yum install ncurses ncurses-devel
```


#### Debian based linux

Execute the following as root or via sudo:

```sh
apt-get install libncurses5-dev libncursesw5-dev
```

and then try `make all` again.


#### Other linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### macOS

With macOS it should already be installed. If it is not you might have to do:

```sh
xcode-select --install
```

and agree to the terms and conditions and proceed with the install.


### <a name="faq3_10"></a>FAQ 3.10: How do I compile and use on macOS, an IOCCC winner that requires sound?

This might depend on the entry but in some cases like
[2001/coupard](2001/coupard/coupard.c) one needs to do more work in order to get
it to work. In this case you should be able to use the Swiss Army Knife of sound
processing programs, [SoX](https://sox.sourceforge.net). To install this easily
you can use either MacPorts or Homebrew. See below for instructions for each.

Usually the README.md file will explain how to use it in linux so we do not
include this here, at least for now.


#### MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


```sh
sudo port install sox
```


#### Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SoX, execute the following command:

```sh
brew install sox
eval "$(/opt/homebrew/bin/brew shellenv)"
```


### <a name="faq3_11"></a>FAQ 3.10: Why do Makefiles use -Weverything with clang?

While we know that use of `-Weverything` is generally not recommended
by `clang` C compiler developers, we do use the `-Weverything`
option in a certain case in IOCCC winner `Makefile`s.

The use of `-Weverything` is limited to when one forces `CC=clang` or more
generally if the string 'clang' is in `$(CC)`. If `$(CC)` contains 'gcc' the
'gcc' specific options are run instead.

Users with clang compilers are not required to set `CC=clang` or equivalent but
when they do, `-Weverything` is enabled with all of its challenges, pedantic
warnings, and sometimes warnings about things that do not matter, some of which
are frankly frivolous and often downright dubious.

To enable this feature:

```sh
make clobber all CC=clang
```

or:

```sh
make clobber all 'CWARN+= -Weverything'
```

though it should be noted that if one tries `-Weverything` with compilers that
are not `clang` they _might_ see something like:

```sh
echo 'int main(void) {}' > foo.c ; cc -Weverything foo.c -o foo
cc: error: unrecognized command-line option '-Weverything'
```

which means that it can't even be compiled. Thus the proper way to do it is the
first way, `make clobber all CC=clang`.

IOCCC authors who have access to `clang` might wish to try their
hand at compiling with `-Weverything` while using a minimum of `-Wno-foo`
statements.  Sometimes there is a technical or pedantic issue that
`-Weverything` warns about that would merit a change to your C code; often,
however, it is not even possible to fix let alone is it worth it. Of course
if you're running out of bytes due to rule 2[ab] one might not have much choice.
This is something that obfuscators simply sometimes have to deal with!

If you try to minimize the number of `-Wno-foo` options needed with
`-Weverything`, please mention this in your remarks about the entry, as the
judges note you attempt to honor it (see also below). In some cases your
obfuscated code will issue warnings with `-Weverything` no matter what: the
`-Wno-poison-system-directories` is a common example of this but there are
others as well, sometimes depending on the version of `clang`.

If you do try for a compile with `clang -Weverything`, keep on mind that while _your_
compile environment might be warning free, a different clang version or a
different build environment might still have warnings. For instance the warning
set is different in macOS (which by default is `clang`: even when run as `gcc`!)
than linux (due to versions and possibly other things)!

Given that your entry **MUST** work as documented, you may be safer to
say that your entry keeps the number of warnings and `-Wno-foo` options while
compiling with `clang -Weverything` at a minimum. You might want to say the
version number and platform too as an extra safety net. Because if you claim zero
warnings, and we find a warning situation, this may diminish the value of your
entry as it is not as documented. Thus it might be wise to point this out and
if you can test it in multiple platforms (or versions of `clang`, see
below note) this would be advisable.

NOTE: different versions of `clang` have other differences as well. For instance
a defect of `clang` that required numerous entries to be fixed for clang is that it
requires that `main()`'s arguments to be of a specific type. However some
versions of `clang` are more strict in the number of args allowed. These reasons
are part of why numerous entries had to be modified so that `main()` calls
another function instead of doing it all in `main()` (another reason was that
some entries that recursively called `main()` caused a crash or otherwise broke
the entry in modern systems). Some entries do not work in `clang` (or at least do
not work completely) due to these defects, for instance
[1989/westley](1989/westley/README.md); [Cody Boone
Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson) was able to
get much of it to work and looking at that entry might be of value to your
submissions, at least if you can figure the code out :-). To see the
differences, try from `1989/westley`:

```sh
make diff_orig_prog
```

If you have `colordiff` try:

```sh
make DIFF=colordiff diff_orig_prog
```

Alternatively you can try:

```sh
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..eb9e69fde657acc8c85a618a8a99af4c2f93b21d westley.c
```

As you can see, using `clang` has some additional problems to work out but if
you can get your entry to work well in `clang` it might very well be considered
better than other entries.


### <a name="faq3_12"></a>FAQ 3.12: How do I find out how to send interrupt/EOF etc. for entries that require it?

For some entries one needs to send interrupt or EOF or some other signal/other
special characters. There are typical defaults like (where `^` = ctrl):

- `^D` for EOF (`eof`)
- `^C` for interrupt (`intr`)
- `^U` for kill (`kill`)

and various others. But if you don't know this you can find out through the
`stty(1)` command with the `-a` option. For instance with macOS you might see:

```sh
$ stty -a
speed 9600 baud; rows 40; columns 155;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; [..snip..]
```

If you know the name you can use `grep` to find the correct line and if your
implementation of `grep(1)` has the `-o` option you can filter it. For instance
to find what the `intr` is set to:

```sh
$ stty -a |grep -o 'intr = ^[[:alpha:]]'
intr = ^C
```

... assuming of course that it's a ctrl combination :-) If for some strange
reason it's not you might have to do something else including just piping it to
just `grep intr` or whatever.



## <a name="faq4"></a>Section 4: Changes made to IOCCC winners


### <a name="faq4_0"></a>FAQ 4.0: Why are some winning entry remarks incongruent with the winning IOCCC code?

It is very likely in this case that the code was fixed to work for modern
systems as part of the reworking of the website. If you have this problem in
some entries you should look at the original code as in `winner.orig.c` or
`prog.orig.c`. `winner` is the directory name. For instance, one of Landon's
favourite entries of all time is [1984/mullender](1984/mullender/README.md) and
the winner there would be `mullender`. Sometimes the original is in an alt
version like `winner.alt.c` or `prog.alt.c`. In fact it is advisable to look at
the original code when reading the author's (and sometimes authors') remarks.


### <a name="faq4_1"></a>FAQ 4.1: Why were some calls to the libc function `gets(3)` changed to use `fgets(3)`?

Some may wonder: "Doesn't this tamper with the entry too much?"

A fine line indeed has to be drawn here but it was decided that it is worth it
because of alarming warnings that can be displayed, in some systems at runtime
interspersed with the output of the program.

For instance in macOS the entry [1990/tbr](1990/tbr/README.md) would output the
warning in such a way that caused confusing output for the entry, looking like:

```sh
$ ./tbr
$ warning: this program uses gets(), which is unsafe.
# nothing here, what to do?
```

In some cases changing the code to use `fgets()` is not so easy to fix and in
one case at least there is an alternate version that has the fix instead due to
a problem it creates (correct output but segfaults after the output in one of
the forms of input).

In some cases it is not possible to fix or at least it is highly unlikely and so
those have mainly not been touched except one that has had the buffer size
increased (which could be done for others that are not possible to change to
`fgets()` though this has not been done).

Some entries can be made to look almost identical to the original entry. For
instance the fix to [1988/reddy](1988/reddy/README.md) required only a single
`#define` be added.

In the future we, the judges, would prefer that entries use `fgets()` to prevent
these problems.

An annoying fact is that for '"compatibility" reasons' `fgets()` retains the
newline and `gets()` does not.  As the v7 man page used to say:

```
BUGS

The fgets(3) function retains the newline while gets(3) does not, all in the
name of backward compatibility.
```

We're not sure how this is compatibility but either way it can cause a
problem and it is this that has complicated most of the fixes though again some
can look almost identical.



### <a name="faq4_2"></a>FAQ 4.2: What was changed in an IOCCC winner source code?

We have set up make rules to easily do see what was changed in the IOCCC
winner source.  Using the `Makefile` in the winner directory, use
one of the following _make(1)_ rules:

The following `make` rules exist to make a difference:

* `make diff_orig_prog`:
    - This rule will show the diff of the _original_ source to the
    current source (that is `entry.orig.c` to `entry.c`).
* `make make diff_alt_orig`:
    - This rule will show the diff of the alt code to the original
    code (that is `entry.alt.c` to `entry.orig.c`). If no alt code exists
    nothing will be shown.
* `make diff_alt_prog`:
    - This rule will show the diff of the alt code to the entry as it
    stands (that is `entry.alt.c` to `entry.c`).
* `make diff_orig_alt`:
    - This rule will show the diff of the original code to the alt code
    (that is `entry.orig.c` to `entry.alt.c`).
* `make diff_prog_alt`:
    - This rule will show the diff of the entry to the alt code (that is
    `entry.c` to `entry.alt.c`).
* `make diff_prog_orig`:
    - This rule will show the diff of the entry to the original code (that is
    `entry.c` to `entry.orig.c`).

For instance one of Landon's all time favourite entries is
[1984/mullender](1984/mullender/README.md) so the file names would be:
`mullender.orig.c`, `mullender.alt.c` and `mullender.c`. For later years, it
would be instead `prog.orig.c`, `prog.alt.c` and `prog.c`.

Note that you might see something like:

```
make: [Makefile:170: diff_orig_prog] Error 1 (ignored)
```

at the end of the output but this is completely normal if there are differences.

If the alt code is the same as the original, say with
[1984/anonymous](1984/anonymous/README.md), then naturally there is no point in
running the rule and the same applies for all the other rules but this system
allows for easily seeing the diffs.

As some examples we'll first look at one that has really long lines which
will make it harder to see what is different,
[2001/anonymous](2001/anonymous/README.md). What you would do is `cd
2001/anonymous` and then do:

```sh
make diff_orig_prog
```

and then be really confused! :-)

But for an entry like [1991/dds](1991/dds/README.md), you can see the
differences much more easily. `1991/dds` is a good example where it's very
simple to see what is different as it's just a couple lines.

You might be quite surprised how little some entries had to be changed and at
the same time how much other entries had to be changed, often with quite complex
differences! In some cases if the line is rather long, like the above mentioned
one, it will be harder to see what changed but in other cases like
[1984/decot](1984/decot/README.md) or [1986/wall](1986/wall/README.md) it's a
lot easier.

Well, at least it's easier see the differences on a line-by-line basis but maybe
not what actually changed, especially since it's easier to know what was fixed
when you have compiler errors :-) (though there are, as noted, some examples
where it's quite easy to see the differences).

[1991/dds](1991/dds/README.md) is also a good example to see the alt difference
very easily. To do that `cd 1991/dds` and then do:

```sh
make diff_alt_prog
```

and you'll see a single line changed and very simply.


#### Tip: if you have `colordiff` installed it's a lot easier to see the differences

To use these rules but provide a different `diff`, for instance `colordiff`,
just do:

```sh
make DIFF=colordiff diff_orig_prog # for orig to prog diff
make DIFF=colordiff diff_alt_prog # for alt to prog diff
```

Obviously if you want to view the alt code or the orig code you can just open
the files as described above.


### <a name="faq4_3"></a> FAQ 4.3  - Why do author remarks sometimes not match the source / why are there other inconsistencies with the original entry?

If the entry has been fixed for modern systems and this fix required
modification to the code then invariably there will be entries where the remarks
of the author or authors are inconsistent with the original code, the size of
the code might be against rule 2 and other kinds of inconsistencies might also
be there.

This is why we recommend that when you read the remarks, sometimes the judges'
remarks and always the author's or authors' remarks, we recommend that you look
at the original code. When the entry source code is called `prog.c` the original
code is in `prog.orig.c`; otherwise it is `winner.orig.c`. For instance one of
Landon's all time favourite entries is
[1984/mullender](1984/mullender/README.md) and the original code is in
[mullender.orig.c](1984/mullender/mullender.orig.c). In some cases, such as
`1984/mullender`, the original code is the same as the code as no changes were
made (there is an alt version for systems that are not VAX-11/PDP-11, however).

See also [FAQ 4.2: What was changed in an IOCCC winner source code?](#faq4_2)


### <a name="faq4_4"></a>FAQ 4.4: What is the meaning of the file ending in .orig.c in IOCCC winners?

Due to the fact that the original code has sometimes had to change these files
are the original winning entry or as close to as possible to the original that
we can find.


## <a name="faq5"></a>Section 5: Updating or correcting IOCCC web site content


### <a name="faq5_0"></a>FAQ 5.0: Why does an IOCCC winner fail to compile or or fail run?

What may have worked years ago may not work well or work at all today.
Please note that the IOCCC judges do **NOT** support IOCCC winners.
Nevertheless, there may be a number of reasons why an IOCCC winner
may fail to compile or run well or fail to run on your system.

In some cases the American National Standards Institute's ANSI C
committee has damaged the C standard to the point where perfectly
valid C programs no longer compile with modern compilers.  As such
some old IOCCC winners cannot no longer be compiled with modern compilers.

In some cases programs that may have worked on an old computer system
longer work on modern computers.  Some IOCCC winners do not work well,
or no longer work on modern computers or modern operating systems.
Some IOCCC winners fail to compile under clang, or gcc.
Some IOCCC winners require operating system services that
may not be present on your system.

In some cases the IOCCC winner simply has bugs or (Mis)features.

If you are having problems compiling or running an IOCCC winner,
we recommend that you look in [bugs.md](/bugs.md) to see if
there is a known bugs or (Mis)feature.  In some cases what you
may think is a bug is actually an feature that was intentionally
written by the authors.  In some cases the problem is well
known and we are looking for someone to attempt to fix it.

In some cases there is an alternate version of the IOCCC winner
that you may wish to try.

It also possible that you may have discovered a bug in an IOCCC
winner.  If so, you are invited to try an fix the IOCCC winner and
submit that fix by way of a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls).  Please
see the FAQ 5.1 <a href="#pullrequst">"How do I report a bug in an IOCCC
winner"</a> for details.


### <a name="faq5_1"></a><a name="pullrequst"></a>FAQ 5.1: How do I report a bug in an IOCCC winner?

We do not 'maintain' the contest winners as such. The code is made available on an 'AS
IS' basis. If you have a FIX for an entry, we suggest that you submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) as we welcome pull requests that have a minimal impact on the entry while improving the portbility, functionality, and/or addressing known problems.

If you do submit a pull request, we ask that each pull request address just one IOCCC winner at a time.

Note that just because you have a fix does not mean it'll be accepted. This
might be because the author objects or it doesn't fit in some way or another. Of
course if the entry does not work we'll certainly be more inclined to accept the
fix. If it is accepted we'll be happy to credit you in the
[thanks](/thanks-for-fixes.md) file. If you're a previous winner we will happily
link to your entries; if you're not we can link to your website if you wish.

More generally please see the file [how-to-help.md](/how-to-help.md). Note
that this file is not a tutorial on how to fix X, Y and Z problems but rather
what to do to get the fix in.


## <a name="faq6"></a>Section 6: Miscellaneous IOCCC


### <a name="faq6_0"></a>FAQ 6.0: How did an entry breaks the size rule 2, win the IOCCC?

As entries have been fixed it is entirely possible that some of the entries no
longer fit within the year's size restrictions. Invariably the length of columns
and/or number of rows have also changed.

The `winner.orig.c` file contains the original source code that was
subjected to rule 2 of the given IOCCC.  You may also wish to see
the [/archive](/archive) directory where you can find all the
original winning entries as compressed tar files for a given year.

In some cases the entry may have abused rule 2 and declared an
"abuse of the rules" (although now blatant abuse of the rules to
get around rule 2 size limits is discouraged).


### <a name="faq6_1"></a>FAQ 6.1: Is there a list of known bugs and misfeatures of IOCCC winners?

Yes! Please see [bugs.md](/bugs.md) for a list of known bugs and/or issues of a
variety of kinds.

Note that just because an entry is not in the bugs file does not mean there is
not an issue and note that some issues are simply missing files, dead URL(s) or
something like that.


### <a name="faq6_2"></a>FAQ 6.2: May I mirror the IOCCC web site?

We are not accepting mirror requests at this time, sorry.  However you are free to fork the [IOCCC winner repo](https://github.com/ioccc-src/winner).  We do ask that your fork keep up to date with the latest changes when possible.


### <a name="faq6_3"></a>FAQ 6.3: May I use parts of the IOCCC in an article, book, newsletter, or instructional material?

While IOCCC judges look favorably on most requests to use IOCCC material,
we request that you ask the [IOCCC judges](/judges.html) first.

Please send your request using the instructions on the [contacting
the IOCCC Judges](/contact.html) page.


### <a name="faq6_4"></a>FAQ 6.4: Why do you sometimes use the first person plural?

As a precedent for [first person
plural](https://en.wikipedia.org/wiki/Nosism), we may sight [Two-,
Three-, and Four-Atom Exchange Effects in bcc in
3He](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.35.1442) and
the co-authorship of [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) as well
as the [APS New Open Access
Initiative](https://journals.aps.org/2014/04/01/aps-announces-a-new-open-access-initiative).

The number of [IOCCC judges](https://www.ioccc.org/judges.html) has
always been "> 1" such that IOCCC judges often prefer to themselves
in the plural, sometimes [in the common
plural](https://en.wikipedia.org/wiki/Plural), sometimes in the
[first person plural](https://en.wikipedia.org/wiki/Nosism), there
may be some who reject such a practice.  Therefore please consider
that when you believe that just one of the [IOCCC
judges](https://www.ioccc.org/judges.html) is in action, you may
consider that [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) has been
consulted, agreed, and has authorized the statement thus allowing
the [in the common plural](https://en.wikipedia.org/wiki/Plural)
to be used without offense.

And while some might claim that [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) died in
1982, we suggest that the [Schrödinger's
cat](https://en.wikipedia.org/wiki/Schrödinger%27s_cat) superposition
may still be in effect and the 1982 [report of death was an
exaggeration](https://books.google.com/books?id=ms3tce7BgJsC&lpg=PA134&vq=%22the%20report%20of%20my%20death%20was%20an%20exaggeration%22&pg=PA134#v=onepage&q=%22the%20report%20of%20my%20death%20was%20an%20exaggeration%22&f=false).

p.s. Here is an image of F. D. C. Willard:

[F D C Willard](png/F.D.C.Willard.png)
