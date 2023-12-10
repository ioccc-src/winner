# FAQ Table of Contents

## Section  0 - [Submitting entries to a new IOCCC](#faq0)
- [0.0  - How may I submit to the IOCCC?](#faq0_0)
- [0.1  - What types of entries have been over-submitted to the IOCCC?](#faq0_1)
- [0.2  - What should I put in my entry's Makefile?](#faq0_2)
- [0.3  - May I use a different source or compiled filename than prog.c or prog?](#faq0_3)
- [0.4  - What platform should I assume for my entry?](#faq0_4)

## Section  1 - [History of the IOCCC](#faq1)
- [1.0  - How did the IOCCC get started?](#faq1_0)
- [1.1  - Why are some years missing IOCCC winners?](#faq1_1)
- [1.2  - What is the history of the IOCCC web site?](#faq1_2)

## Section  2 - [IOCCC Judging process](#faq2)
- [2.0  - How many entries do the judges receive for a given IOCCC?](#faq2_0)
- [2.1  - What should I put in the remarks.md file of my entry?](#faq2_1)
- [2.2  - Why don't you publish non-winners?](#faq2_2)
- [2.3  - How much time does it take to judge the contest?](#faq2_3)
- [2.4  - How many judging rounds do you have?](#faq2_4)
- [2.5  - Why do some IOCCC winners receive the Grand Prize or Best of Show award?](#faq2_5)
- [2.6  - How are IOCCC winners announced?](#faq2_6)

## Section  3 - [Compiling and running IOCCC winners](#faq3)
- [3.0  - What Makefile rules are available to build or clean up IOCCC winners?](#faq3_0)
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
- [3.12 - How do I find out how to send interrupt/EOF etc. for entries that require it?](#faq3_12)
- [3.13 - Why does an IOCCC winner fail to compile or or fail run?](#faq3_13)

## Section  4 - [Changes made to IOCCC winners](#faq4)
- [4.0  - Why are some winning author remarks incongruent with the winning IOCCC code?](#faq4_0)
- [4.1  - Why were some calls to the libc function `gets(3)` changed to use `fgets(3)`?](#faq4_1)
- [4.2  - What was changed in an IOCCC winner source code?](#faq4_2)
- [4.3  - Why do author remarks sometimes not match the source / why are there
other inconsistencies with the original entry?](#faq4_3)
- [4.4  - What is the meaning of the file ending in .orig.c in IOCCC winners?](#faq4_4)

## Section  5 - [Helping the IOCCC](#faq5)
- [5.0  - How may I help the IOCCC?](#faq5_0)
- [5.1  - How do I report a bug in an IOCCC winner?](#faq5_1)
- [5.2  - How may I submit a fix to an IOCCC winner?](#faq5_2)
- [5.3  - How may I report an IOCCC web site problem?](#faq5_3)
- [5.4  - How may I submit a fix to an IOCCC web site?](#faq5_4)
- [5.5  - How may I correct or update IOCCC author information?](#faq5_5)

## Section  6 - [Miscellaneous IOCCC](#faq6)
- [6.0  - How did an entry breaks the size rule 2, win the IOCCC?](#faq6_0)
- [6.1  - Is there a list of known bugs and (mis)features of IOCCC winners?](#faq6_1)
- [6.2  - May I mirror the IOCCC web site?](#faq6_2)
- [6.3  - May I use parts of the IOCCC in an article, book, newsletter, or instructional material?](#faq6_3)
- [6.4  - Why do you sometimes use the first person plural?](#faq6_4)
- [6.5  - What is an author handle?](#faq6_5)
- [6.6  - What is a author_handle.json file and how are they used?](#faq6_6)
- [6.7  - What is a winner_id?](#faq6_7)
- [6.8 -  What is the purpose of the .top, .year and .path files?](#faq6_8)


# The IOCCC FAQ


## <a name="faq0"></a>Section 0: Submitting entries to a new IOCCC


### <a name="faq0_0"></a><a name="submif"></a>FAQ 0.0: How may I submit to the IOCCC?

To submit your code to the IOCCC, you **MUST** follow these steps:

0. Verify that the IOCCC is open for submissions

Check the [status.json](status.json) URL and
check the [IOCCC news](news.html#news) to
see of the IOCCC is open.

You may only register for the IOCCC
and you may only submit your entries to the IOCCC when the IOCCC is **OPEN**.

1. Read the latest IOCCC rules and review the IOCCC guidelines

Please read any pay close attention to the [official IOCCC rules](/rules.html).

You are also **highly encouraged** to review the
[official IOCCC guidelines](/guidelines.html) as they contain important
suggestions, useful hints, and IOCCC humor.  :-)

2. Register for the IOCCC

```
XXX - instructions TBD - XXX
```

Once you have been registered, you will receive an email message for how to
prepare your entries for submission, and how to upload the compressed tarballs
to our submission portal.

3. Obtain the latest mkiocccentry toolkit

If you do not have an mkiocccentry tool directory:

```sh
cd some_directory
git clone git@github.com:ioccc-src/mkiocccentry.git
cd mkiocccentry
```

If you already have an mkiocccentry tool directory:

```sh
cd mkiocccentry
git fetch
git rebase
```

4. Make the mkiocccentry toolkit

```sh
make clobber all
```

5. Run the mkiocccentry tool to form your entry tarball

```sh
./mkiocccentry work_dir prog.c Makefile remarks.md [file ...]
```

where:

```
work_dir	directory where the entry directory and tarball are formed
prog.c		path to the C source for your entry


Makefile	Makefile to build (make all) and cleanup (make clean & make clobber)

remarks.md	Remarks about your entry in markdown format
		NOTE: See the [markdown syntax[(https://www.markdownguide.org/basic-syntax) guide.

[file ...]	extra data files to include with your entry
```

NOTE: It is *NOT* necessary to install the tools to use them as you can run
the tools from the top of the _mkiocccentry repo_ directory just fine.

If `mkiocccentry` tool indicates that there is a problem with your entry,
especially if it identifies a [rule 2](/rules.html#2) related problem,
you are **strongly** encouraged to revise and correct your entry and
then re-run the `mkiocccentry` tool.

If you choose to risk of violating rules, be sure an explain your reason
for doing so in your _remarks.md_ file.

6. upload your entry to the IOCCC submit server

```
XXX - instructions TBD - XXX
```


### <a name="faq0_1"></a>FAQ 0.1: What types of entries have been over-submitted to the IOCCC?

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


### <a name="faq0_2"></a>FAQ 0.2: What should I put in my entry's Makefile?

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


### <a name="faq0_3"></a>FAQ 0.3: May I use a different source or compiled filename than prog.c or prog?

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


### <a name="faq0_4"></a>FAQ 0.4: What platform should I assume for my entry?

Your entry must compile with GCC and run under at least one flavor of UNIX (e.g.
Linux or Solaris). To improve chances to win, it should work under both BSD and
SysV style UNIX (think **stty cbreak**), and should not depend on endianness.
If it can compile and run on Windows and/or Mac  (see
[2000/thadgavin](/years.html#2000_thadgavin) for one example, amongst others),
even better. Being able to compile with other compilers like clang is also a
good thing.


## <a name="faq1"></a>Section 1: History of the IOCCC


### <a name="faq1_0"></a>FAQ 1.0: How did the IOCCC get started?

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


### <a name="faq1_1"></a>FAQ 1.1: Why are some years missing IOCCC winners?

Some years, such as 1997, 1999, 2002-2003, 2007-2010, 2016-2017, 2021-2023, no IOCCC was held.

While we try to hold the IOCCC every year, sometime the other demands on the IOCCC judges
so not permit us to hold a new IOCCC.

The pause during the 2021-2023 period was due to the IOCCC judges developing tools to
make is much more likely for the IOCCC to be held in a yearly basis later on.


### <a name="faq1_2"></a>FAQ 1.2: What is the history of the IOCCC web site?

#### In the beginning of www.ioccc.org

The long history of the [official IOCCC web site](https://www.ioccc.org) can be
viewed at the [Internet Wayback Machine Wayback Machine](https://web.archive.org).

One can view several thousand snapshots showing how the [IOCCC web site has
evolved](https://web.archive.org/web/20230000000000*/www.ioccc.org) going back
as far as [1998 Dec 12
www.ioccc.org](https://web.archive.org/web/19981212030016/https://www.ioccc.org/).

On 2020 Dec 31, the IOCCC source tree was moved to the [IOCCC winner
repo](https://web.archive.org/web/20210101211346/https://www.ioccc.org/) on
[GitHub](https://github.com).  From this point on, the [official IOCCC web
site](https://www.ioccc.org) became a [GitHub Pages](https://pages.github.com)
web site.

#### 2020 Dec 28 bzip2 compressed tarball archive

Furthermore, a bzip2 compressed tarball containing the released
IOCCC winner source code may be found under the
[archive/historic](/archive/histroic) directory.  The file
[archive-all.tar.bz2](/archive/historic/archive-all.tar.bz2) contains
all years and the individual years are in the form
_archive/historic/archive-YYYY.tar.bz2_.

These files were obtained from the [Internet Wayback
Machine](https://web.archive.org) from the [snapshot of the website
on 2020 Dec
28](https://web.archive.org/web/20201228005211/https://www.ioccc.org/).
See [archive/historic/README.md](/archive/historic/README.md) for
details about these bzip2 compressed tarballs.

**XXX**: Change the references to _temp-test-ioccc_ to _winners_
when these fixes are merged.

#### 2022 Dec 29 repo fork

On 2022 Dec 29, the [IOCCC winner repo](https://github.com/ioccc-src/winner),
from which the [official IOCCC web site of 2022 Dec
29](https://web.archive.org/web/20221231001721/https://www.ioccc.org/) was
generated, was forked into a temporary repo where it is currently undergoing
changes with several thousand changes and important improvements already such
as:

--

***XXX**: change the above text to read:

... where it underwent several thousand changes and important improvements such
as:

--

* Moving IOCCC winners into their own separate directories
* Fixing lots and lots of typos
* Fixing Makefiles and code to allow for nearly all winners to be compiled and
work on modern systems
* Reworking the Makefiles to use a consistent set of rules
* Reworking the Makefiles specific to the gcc and clang C compilers
* Replacing the various hint files with a README.md markdown that is more consistent across IOCCC years
* Setting up a system whereby authors of IOCCC entries may update their own contact information via a GitHub pull request
* Setting up to generate the top level years.html file via a tool
* Setting up to generate the top level winners.html file via a tool
* etc.

#### 20yy mm dd pull request

On 20yy mm dd, the temporary repo was merged back into the [IOCCC winner
repo](https://github.com/ioccc-src/winner) resulting in substantial improvements
to the [official IOCCC web site](https://www.ioccc.org).

**XXX**: Fill in the date when the pull request happens including the
size of the pull request and/or number of changes that went into the pull request.


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


### <a name="faq2_5"></a>FAQ 2.5: Why do some IOCCC winners receive the Grand Prize or Best of Show award?

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


### <a name="faq2_6"></a>FAQ 2.6: How are IOCCC winners announced?

Once the [IOCCC](https://www.ioccc.org/index.html#enter) closes, the judges
will select the [winning entries](https://www.ioccc.org/years.html) announce them
on the [@IOCCC mastodon feed](https://fosstodon.org/@ioccc), notify the winners
via email using their previously registered email address, and upload the
winning code to the [winner repo](https://github.com/ioccc-src/winner)
which in turn will cause them to be displayed on the [IOCCC winning entries
page](https://www.ioccc.org/years.html).


## <a name="faq3"></a>Section 3: Compiling and running IOCCC winners


### <a name="faq3_0"></a>FAQ 3.0: What Makefile rules are available to build or clean up IOCCC winners?

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

Other entries like [2001/herrmann2](/thanks-for-help.md#2001_herrmann2)
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


### <a name="faq3_8"></a><a name="SDL"></a>FAQ 3.8: How do I compile an IOCCC winner that requires SDL1 or SDL2?

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


### <a name="faq3_13"></a>FAQ 3.13: Why does an IOCCC winner fail to compile or or fail run?

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
request](https://github.com/ioccc-src/temp-test-ioccc/pulls).
Please see [FAQ 5.2](#faq5_2) for how to submit a fix to an IOCCC winner.



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


### <a name="faq4_1"></a><a name="gets"></a>FAQ 4.1: Why were some calls to the libc function `gets(3)` changed to use `fgets(3)`?

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


### <a name="faq5_0"></a><a name="how_to_help"></a>FAQ 5.0: How may I help the IOCCC?

### We welcome your help in fixing IOCCC winners

The [known bugs](bugs.md) file, order by IOCCC years, contains a
list of known bugs & (mis)features.  If you are looking for an IOCCC winner
to try and fix, this file is a good place to start.

See [FAQ 5.2](#faq5_2) for information on how to submit a fix to
an IOCCC winner.  Before you consider trying to fix an IOCCC winner,
please check the [known bugs](bugs.md) file for the IOCCC winner
in question.  Note that in several cases what you may have discovered,
while a (mis)feature is not considered a bug and should **not be fixed**.
In cases where the bug is known, the entry's [known bugs](bugs.md) file
section may offer you important fixing clues.

### We welcome your help on fixing the IOCCC web site


### <a name="faq5_1"></a><a name="pullrequst"></a>FAQ 5.1: How do I report a bug in an IOCCC winner?

We do not 'maintain' the contest winners as such. The code is made available on an 'AS
IS' basis. If you have a FIX for an entry, we suggest that you submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) as we welcome pull requests that have a
minimal impact on the entry while improving the portability, functionality, and/or addressing known problems.

If you do submit a pull request, we ask that each pull request address just one IOCCC winner at a time.

Note that just because you have a fix does not mean it'll be accepted. This
might be because the author objects or it doesn't fit in some way or another. Of
course if the entry does not work we'll certainly be more inclined to accept the
fix. If it is accepted we'll be happy to credit you in the
[thanks](/thanks-for-help.md) file. If you're a previous winner we will happily
link to your entries; if you're not we can link to your website if you wish.

See [FAQ 5.2](#faq5_2) for information on how to submit a fix to an IOCCC entry.


### <a name="faq5_2"></a><a name="fix_a_winner"></a>FAQ 5.2: How may I submit a fix to an IOCCC winner?

If you see a problem with an IOCCC entry, first check the [known bugs](bugs.md)
file.  In some cases what you might think of as a bug is instead a known
feature.  In some cases the bug is known, but no fix has ever been submitted.
In other cases you may have found a new problem.

If you do have a fix, and the [known bugs](bugs.md) file **does not recommend
against fixing it**, then please consider opening a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls) against the master
[branch](https://github.com/ioccc-src/winner/branches) of the [ioccc-src/winner
repo](https://github.com/ioccc-src/winner).

BTW: A **problem** is not limited to the code itself.  Fixing typos in files
such as "_README.md_" files, fixing issues in a "_Makefile_", or otherwise
correcting an IOCCC winner is **VERY MUCH WELCOME**!  Please use the same
[GitHub pull request](https://github.com/ioccc-src/winner/pulls) process against
the master [branch](https://github.com/ioccc-src/winner/branches) of the
[ioccc-src/winner repo](https://github.com/ioccc-src/winner).

NOTE: some of the issues in the [bugs.md](/bugs.md) file includes just missing
files and we welcome these too!

**Please also help us fix typos and / or otherwise improve the write-up** of how
IOCCC winning entries are presented!

In any event we will happily add you to the
[thanks](/thanks-for-help.md) file for your help!

And of course, an IOCCC winner may update their own entries
(metadata as well as source code and any extra files) by opening a
[GitHub pull request](https://github.com/ioccc-src/winner/pulls)
against the master [branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner).

Note that we're much more inclined to accept an author's fixes but the judges
have the final say in the matter.


### <a name="faq5_3"></a>FAQ 5.3: How may I report an IOCCC web site problem?

If you discover a problem with the IOCCC web site that is related
to a particular IOCCC winner, please see [FAQ 5.1](#faq5_1) for
information about reporting a bug in an IOCCC winner, and see [FAQ
5.2](#faq5_2) for information on how to submit a fix to an IOCCC winner.

If you discover a problem with the IOCCC web site (such as a broken
link) that is **not related to a particular IOCCC winner**, the
best way you can help is to submit a fix to the IOCCC web site.
See [FAQ 5.4](#faq5_4) for information on submitting fixes to the
IOCCC web site.

If you do not have a IOCCC web site fix, and just wish to report a
general IOCCC web site problem, we ask that you first look at the
[IOCCC issues](https://github.com/ioccc-src/winner/issues) to see
if the problem has already been reported.  If it has been reported,
feel free to add a comment to the issue.  If you do not find an it
has been reported, then fee free to open a [new IOCCC
issue](//github.com/ioccc-src/winner/issues).


### <a name="faq5_4"></a><a name="fix_web_site"></a>FAQ 5.4: How may I submit a fix to an IOCCC web site?

For IOCCC web site problems that relate to a particular IOCCC winner, please
see [FAQ 5.2](#faq5_2) for information on how submit a fix to an IOCCC winner.

You may open a [GitHub pull request](https://github.com/ioccc-src/winner/pulls)
against the master [branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner)
to submit a fix.

#### Some HTML files should NOT be directly modified

Most HTML files on the [IOCCC web site](https://www.ioccc.org)
are built from [markdown](https://daringfireball.net/projects/markdown/) files.
If you see lines containing:

```
!!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!!
!!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!!
!!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!!
```

This means that the file is generated by a tool from the
[build-ioccc repo](https://github.com/ioccc-src/build-ioccc)
using files found in the
[ioccc-src/winner repo](https://github.com/ioccc-src/winner).

You will find a HTML comment of the form indicating which tool
was used to generate the contents:

```
file: __some_file_path__ created by: __something__ version: __something__
```

Along with HTML comments of the form indicating which files were
used by the tool to generate the HTML file;

```
content source: __some_file_path__
content source: __another_file_path__
...
```

Those **content source:** comment lines will give you a clue to the content that
is used by the tool to generate the **DO NOT MODIFY THIS FILE** HTML file.

When in doubt, consider opening up an [IOCCC issue](https://github.com/ioccc-src/winner/issues).
See [FAQ 5.3](#faq5_3) for information on opening up an IOCCC issue.


## <a name="faq5_5"></a><a name="fix_author"></a>FAQ 5.5: How may I correct or update IOCCC author information?

Authors of IOCCC winning entries are kept in JSON files of the form:

```
author/author_handle.json
```

where _author_handle_ is an author handle.  See [FAQ 6.5](#faq6_5) for more
information about an author handles.

The contents of these JSON files contain the best known information
about authors of IOCCC winners.  See [FAQ 6.6](#faq6_6) for information
about the contents of these JSON file and how they are used.

You may update IOCCC author information in a `author_handle.json` file
by opening a [GitHub pull request](https://github.com/ioccc-src/winner/pulls)
against the master [branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner).


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


### <a name="faq6_5"></a><a name="author_handle"></a>FAQ 6.5: What is an author handle?

An `author_handle` is string that refers to a given author and is unique to the
IOCCC.  Each author has exactly one `author_handle`.

For each `author_handle`, there will be a JSON file of the form:

```
author/author_handle.json
```

See [FAQ 6.6](#faq6_6) for information about the contents of these JSON file and
how they are used.

Because the `author_handle` is used to form a JSON filename, the string must be
POSIX safe string.  Furthermore, the `author_handle` must be an ASCII
string that matches this regexp:

```re
^[0-9A-Za-z][0-9A-Za-z_]*$
```

Default `author_handle`'s do not have multiple consecutive `_` (underscore)
characters.  Nevertheless, multiple consecutive `_` (underscore) characters are
allowed. Contest submitters who wish to override their default `author_handle` may do so.

The `author_handle` is derived from the name of the author.  While there is a
algorithm that maps the name of the author (which can contain any UTF-8
characters) into a default `author_handle` string, those who submit an entry to
the IOCCC are free to choose a different `author_handle` string if they so
desire.

An `author` who has won a previous IOCCC is encouraged to reuse their
`author_handle` so that new winning entries can be associated with the same
author.

For an anonymous `author`, their handle is one of these forms:

```
Anonymous_year
```

or:

```
Anonymous_year.digits
```


The latter form is in case there are more than one anonymous author in a given
year.

NOTE: even if the directory name is not `anonymous` the above rules apply as in
in the case of [2005/anon](/2005/anon/anon.c).

Anonymous `author_handle`'s match this regexp:

```re
Anonymous_[0-9][0-9][0-9][0-9][.0-9]*$
```

See [FAQ 5.5](#faq5_5) for information about how to update
and/or correct IOCCC author information.


### <a name="faq6_6"></a><a name="author_json"></a>FAQ 6.6: What is a author_handle.json file and how are they used?

**TL:DR**: The contents of these JSON files contain the best known
information about authors of IOCCC winners and is used to help form
HTML files as well to contact an author.

The content of these JSON files are used by tools from the [build-ioccc
repo](https://github.com/ioccc-src/build-ioccc) to help build HTML
content for the [official IOCCC web site](https://www.ioccc.org).
For example, the `index.html` file for each IOCCC winner contains
selected information about the authors.  Tools from the [build-ioccc
repo](https://github.com/ioccc-src/build-ioccc) use the content of
these JSON files to generate the `index.html` files for each IOCCC
winning entry.

Moreover, should the [IOCCC judges](judges.html) need to
contact an authors of a IOCCC winner, they will consult the contents
of the author's JSON file for ways to contact them.

Each author of an IOCCC winning entry has their own `author_handle.json` file
of the form:

```
author/author_handle.json
```

where _author_handle_ is an author handle.  See [FAQ 6.5](#faq6_5) for more
information about an author handles.

#### author_handle.json JSON file contents

The syntax of a `author_handle.json` follows the _So-called JSON spec_.
See [json_README.md](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/json_README.md#so_called_json_spec)
for information on the _So-called JSON spec_.

A good way to understand the JSON file contents of a `author_handle.json` file
is to look at an example, the `author_handle.json` file for Yusuke Endoh:

```
author/Yusuke_Endoh.json
```

As of _Thu Nov 30 23:51:12 UTC 2023_, the contents was as follows:

```json
{
    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
    "author_JSON_format_version" : "1.0 2023-06-10",
    "author_handle" : "Yusuke_Endoh",
    "full_name" : "Yusuke Endoh",
    "sort_word" : "endoh",
    "location_code" : "JP",
    "location_name" : "Japan",
    "email" : "mame@ruby-lang.org",
    "url" : "https://mametter.hatenablog.com",
    "alt_url" : null,
    "deprecated_twitter_handle" : null,
    "mastodon" : "@mame@ruby.social",
    "mastodon_url" : "https://ruby.social/@mame",
    "github" : "@mame",
    "affiliation" : null,
    "winning_entry_set" : [
	{ "winner_id" : "2012_endoh1" },
	{ "winner_id" : "2012_endoh2" },
	{ "winner_id" : "2013_endoh1" },
	{ "winner_id" : "2013_endoh2" },
	{ "winner_id" : "2013_endoh3" },
	{ "winner_id" : "2013_endoh4" },
	{ "winner_id" : "2014_endoh1" },
	{ "winner_id" : "2014_endoh2" },
	{ "winner_id" : "2015_endoh1" },
	{ "winner_id" : "2015_endoh2" },
	{ "winner_id" : "2015_endoh3" },
	{ "winner_id" : "2015_endoh4" },
	{ "winner_id" : "2018_endoh1" },
	{ "winner_id" : "2018_endoh2" },
	{ "winner_id" : "2019_endoh" },
	{ "winner_id" : "2020_endoh1" },
	{ "winner_id" : "2020_endoh2" },
	{ "winner_id" : "2020_endoh3" }
    ]
}
```

We now will walk thru the above JSON document looking at various JSON members:


##### no_comment

``` json
    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
```

Because the authors of the so-called JSON spec removed the ability to use comments in JSON
(for reason(s) that seem to be less than credible), the IOCCC mandates this _JSON member_
be present in all IOCCC related JSON files.

There **MUST** be one and only one `no_comment` _JSON member_ and the _JSON value_ **MUST**
be the exact _JSON string_ as shown above.


##### author_JSON_format_version

```json
    "author_JSON_format_version" : "1.0 2023-06-10",
```

This _JSON member_ holds the format version of the `author_handle.json` JSON file.

There **MUST** be one and only one `author_JSON_format_version`
_JSON member_ and the _JSON value_ **MUST** be a _JSON string_.

This is **NOT** the version of the contents!  When updating an
`author_handle.json` JSON file, **DO NOT MODIFY author_JSON_format_version**!
As of _Thu Nov 30 23:51:12 UTC 2023_, the _JSON value_ **MUST** be _"1.0 2023-06-10"_.

The _author_JSON_format_version_ would only changed when the overall format
of the these files is modified: and then only those who maintain the
[official IOCCC web site](https://www.ioccc.org) would be the one to do this
in conjunction with changes to the [build-ioccc
repo](https://github.com/ioccc-src/build-ioccc).


##### author_handle

```json
    "author_handle" : "Yusuke_Endoh",
```

This _JSON member_ holds the author handle of the author.

There **MUST** be one and only one `author_handle` _JSON member_
and the _JSON value_ **MUST** be a _JSON string_ that is also a value author handle.

See [FAQ 6.5](#faq6_5) for more information about an author handles.

Normally the _author_handle_ _JSON value_ should **NOT** be changed
**unless there is a strong reason to do so**.  If the  _JSON value_
changes, then all of the `.winner.json` files for all of this authors
winning IOCCC entries should also be changed.  The _author_handle_
_JSON value_ must match the basename (without the leading path and
without the trailing `.json`) of the `author_handle.json` file.  So
a change of _author_handle_ _JSON value_ would also require the
`author_handle.json` file to also be renamed.


##### full_name

```json
    "full_name" : "Yusuke Endoh",
```

This _JSON member_ holds the full name of the author.

There **MUST** be one and only one `full_name` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.

The full name of an author may use non-ASCII characters so long as the
full name is properly encoded as a _JSON string_.


##### sort_word

```json
    "sort_word" : "endoh",
```

This _JSON member_ holds the string that will be used to sort the author.

There **MUST** be one and only one `sort_word` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.  Moreover the string **MUST** be a lower case ASCII
alphanumeric string that starts with a lower case ASCII letter.

The _JSON value_ is used, for example, to place a reference to the author
in the `/winners.html` file.

Normally the `sort_word` _JSON member_ _JSON value_ is the last
name of the author, translated into lower case ASCII alphanumeric
string that starts with a lower case ASCII letter.  If the author
wishes to be found in the `/winners.html` file under a different
string, such as if they wish to be listed under their first name
or their username, then they may change this accordingly.


##### location_code

```json
    "location_code" : "JP",
```

This _JSON member_ holds the string that is the
[ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table)
of the author's location or country.

There **MUST** be one and only one `location_code` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.  Moreover the string **MUST** be 2 character UPPER case ASCII
alphabetic string that is **NOT** an Unassigned
[ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table) value
(not a 2 character symbol with a gray background on that Wikipedia table)

The `soup/location` tool from the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
when run without arguments, will print the ISO 3166-1 alpha-2 codes that permitted, along with
the location name.

We use the term "location" (and not "country") because some of the
ISO 3166-1 alpha-2 codes belong to locations that are not technically
a country, such as "Antarctica" or a User-assigned code.

If the author wishes to not specify a location, they should select **XX**.


##### location_name

```json
    "location_name" : "Japan",
```

This _JSON member_ holds the string that is the canonical location name as reported by the
`soup/location` tool from the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
when given the [location code](#location_code) as specified above.

There **MUST** be one and only one `location_code` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.  Moreover the string **MUST** be what the `soup/location` tool prints
when given the `location_code` as an argument.

We use the term "location" (and not "country") because some of the
ISO 3166-1 alpha-2 codes belong to locations that are not technically
a country, such as "Antarctica" or a User-assigned code.

Often a given location may have a long official name, and multiple common names.
For names associated with the location **DE** might be:

```
Germany
Federal Republic of Germany
Bundesrepublik Deutschland
Deutschland
...
```

The "location_name" printed by the `soup/location` tool is often a
short, common string that is sometimes called the formal location
name for the given ISO 3166 code.  Thus in the above example for _DE_,
the location name of _Germany_ is used.

If the author wishes to not specify a location, they should select **Anonymous location**.


##### email

```json
    "email" : "mame@ruby-lang.org",
```

This _JSON member_ holds the email address of the author, or is the value null.

There **MUST** be one and only one `email` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

If the author wishes to not specify an email address, or if the email address is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "email" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### url

```json
    "url" : "https://mametter.hatenablog.com",
```

This _JSON member_ holds the URL of the author's home page.

There **MUST** be one and only one `url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

If the author wishes to not specify an email address, or if the URL is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "url" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### alt_url

```json
    "alt_url" : null,
```

This _JSON member_ holds an alternate or 2nd URL a home page for the author.

There **MUST** be one and only one `url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

In some cases the author may wish to record a special URL for their IOCCC entry,
or a 2nd URL such as a work or school or personal home page.  For example,
Cody as of  _Thu Nov 30 23:51:12 UTC 2023_ used:

```json
    "alt_url" : "https://ioccc.xexyl.net",
```

If the author wishes to not specify an email address, or if the alternate URL is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "url" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### deprecated_twitter_handle

This _JSON member_ used to hold the twitter handle of the author.

There **MUST** be one and only one `deprecated_twitter_handle` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

The IOCCC no longer is associated with twitter (or whatever someone chooses to call it),
and so the `deprecated_twitter_handle` is **no longer used**.  A _JSON value_ that is
not a _JSON null_ is kept for only historic reasons.  For example, Anthony C. Howe
once used:

```json
    "deprecated_twitter_handle" : "@SirWumpus",
```

If the author wishes to not specify an twitter handle, or if the twitter handle is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "deprecated_twitter_handle" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### mastodon

```json
    "mastodon" : "@mame@ruby.social",
```

This _JSON member_ holds the
[Mastodon social network](https://en.wikipedia.org/wiki/Mastodon_\(social_network\))
handle of the author.

There **MUST** be one and only one `mastodon` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The _JSON string_ just be a valid
Mastodon handle.  In particular is must start with an at sign (_@_), followed by the
Mastodon username, followed by a 2nd sign (_@_), followed by the Mastodon server instance
used by the author.

For more information in Mastodon, see the [Mastodon help](https://mastodon.help) guide.
See the "Mastodon Address" section of that page in particular.

The IOCCC Mastodon handle is:

```json
@ioccc@fosstodon.org
```

The IOCCC uses the Mastodon social network for announcements such
as the opening and closing of a new IOCCC, changes to the IOCCC web
site, updates during the judging process, and when new IOCCC winners
are selected.  We recommend you follow us on Mastodon.

If the author wishes to not specify an Mastodon handle, or if the Mastodon handle is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "mastodon" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### mastodon_url

```json
    "mastodon_url" : "https://ruby.social/@mame",
```

This _JSON member_ holds the URL of the author's Mastodon page.

There **MUST** be one and only one `mastodon_url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The _JSON string_ just be a valid URL.
If the `mastodon` handle is a _JSON null_, them the `mastodon_url` **MUST** be a _JSON null_.
If the `mastodon` handle is a _JSON string_, then the `mastodon_url` **MUST** be a _JSON string_.

The `mastodon_url` is just a translation of the above mentioned [mastodon](#mastodon) handle.
For example, if the Mastodon handle is:

```
@user@server.domain
```

Then the `mastodon_url` would be:

```
https://server.domain/@user
```

If the author wishes to not specify an Mastodon URL, or if the Mastodon URL is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "mastodon_url" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### github

```json
    "github" : "@mame",
```

This _JSON member_ holds the [GitHub](https://github.com) handle of the author.

There **MUST** be one and only one `github` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The `github` _JSON string_ **MUST**
start with an at sign (_@_) and **MUST** be a valid GitHub username.

The IOCCC uses GitHub to hold the [official winner repo of the IOCCC](https://github.com/ioccc-src/winner),
and hosts [official IOCCC web site](https://www.ioccc.org) on GitHub pages.

The IOCCC GitHub handle is:

```
@ioccc-src
```

If the author wishes to not specify an GitHub handle, or if the GitHub handle is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "github" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### affiliation

```json
    "affiliation" : null,
```

This _JSON member_ holds the affiliation of the author.

There **MUST** be one and only one `affiliation` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

An affiliation might be the name of a school, university, company, or organization.
It is recommended that the affiliation _JSON string_ be the formal affiliation name.
For example, the affiliation for the IOCCC would be:

```
The International Obfuscared C Code Contest
```

If the author wishes to not specify an affiliation, or if the affiliation is
unknown, they should use the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

```json
    "affiliation" : null,
```

NOTE: The _JSON null_ is **NOT** enclosed in quotes!


##### winning_entry_set
##### winner_id

```json
    "winning_entry_set" : [
        { "winner_id" : "2012_endoh1" },
        { "winner_id" : "2012_endoh2" },
	{ "winner_id" : "2013_endoh1" },
...
	{ "winner_id" : "2020_endoh1" },
        { "winner_id" : "2020_endoh2" },
        { "winner_id" : "2020_endoh3" }
    ]
```

The `winning_entry_set` _JSON member_ holds _JSON array_ containing one or more `winner_id` _JSON member_s.

There **MUST** be one and only one `winning_entry_set` and the  _JSON value_ **MUST**
be a non-empty _JSON array_.  Each value in that _JSON array_ **MUST** must contain
a _JSON member_ whose _JSON name_ **MUST** be "_winner_id_" and those _JSON value_
is a valid winner ID.

Due to the nature of the  _So-called JSON spec_, the last value of the `winning_entry_set`
_JSON array_ cannot end in a comma (_,_).

See [FAQ 6.7](#faq6_7) for information about winner ids.

See [FAQ 5.5](#faq5_5) for information about how to update
and/or correct IOCCC author information.


### <a name="faq6_7"></a><a name="author_json"></a>FAQ 6.7: What is a winner_id?

A `winner_id` is a string that identifies a winning entry of the IOCCC.

A `winner_id` is a 4-digit year, followed by an underscore, followed by a directory name.

For example, the `winner_id` associated with Cody Boone Ferguson's 2nd winning IOCCC entry
of 2020 is found under the following directory:

```
2020/ferguson2
```

The `winner_id` for that winning entry is:

```
2020_ferguson2
```


### <a name="faq6_8"></a>FAQ 6.8: What is the purpose of the .top, .year and .path files?

The [.top](/.top) file resides at the top directory.  This file contains the complete list
of IOCCC years.

Under each IOCCC year. one will find a `.year` file.  These files contain directory paths from the top directory,
of the IOCCC winner directories for a given year.  For example, see the [1984/.year](/.1984/.year) file.

Under each IOCCC winner directory, you will find a `.path` file.
These files contain the directory path from the top directory.
For example see [1984/anonymous/.path](/1984/anonymous/.path).

The .top, .year and .path files are generated from the top level Makefile, by:

```sh
make genpath
```
