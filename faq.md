<HTML>
<BODY TEXT="#000000">

<center><img alt="IOCCC" SRC="png/ioccc.png"></center><br>
<center><font size="6"><I>The International Obfuscated C Code Contest </I></font></center><br>

<P>
<CENTER>
<A HREF="judges.html">The judges</A> |
<A HREF="main.html">IOCCC home page</A> |
<B>FAQ</B> |
<A HREF="index.html#enter">How to enter</A> |
<A HREF="contact.html">Contacting the IOCCC</A>
<BR><BR>
<A HREF="index.html#news">IOCCC news</A> |
<A HREF="winners.html">People who have won</A> |
<A HREF="years.html">Winning entries</A>
<BR><BR>
<A HREF="bugs.md">Known Bugs &amp; (Mis)features</A> |
<A HREF="how-to-bugfix.md">How to fix an IOCCC winner</A> |
<A HREF="thanks-for-fixes.md">Thanks for the fixes</A> |
<A HREF="www-history.md">A bit of web site history</A>
</CENTER>

<HR>

# The IOCCC FAQ

## Q: How many entries do you receive each year?

By tradition, we do not say.

## Q: How many judging rounds do you have?

Are you trying to trick us? We will not say that either.

## Q: What are the general Makefile rules used in order to clean and build entries for use?

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

## Q: How come some entries have code that is incongruent with what the author(s) wrote about the entry?

It is very likely in this case that the code was fixed to work for modern
systems as part of the reworking of the website. If you have this problem in
some entries you should look at the original code as in `winner.orig.c` or
`prog.orig.c`. Sometimes the original is in an alt version like `winner.alt.c`
or `prog.alt.c`.


## Q: I cannot get entry XYZZY from year 19xx to compile!

Some winners, particularly winners from long ago, no longer compile on more
modern systems because the C language has evolved (i.e. the modern C compilers
are much more strict in what they accept as a valid program), or the entry
depended on operation system and library features that where common back then
but are different/missing today.

E.g. it is highly unlikely that you'll be able to execute
[1984/mullender](years.html#1984/mullender) on a computer you're using to read
this FAQ. However for that entry [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) added alternative code so that you
can enjoy this entry. Try:

```sh
make alt
./mullender.alt [microseconds]
```

The microseconds defaults to 10000.

Thank you Cody!

See also [Yusuke Endoh](/winners.html#Yusuke_Endoh)'s entry
[2015/endoh3](/2015/endoh3/README.md) which lets one compile it and run
it. Another entry that you can enjoy it under is [Christopher
Mill](/winners.html#Christopher_Mills)'s entry
[2018/mills](/2018/mills/README.md) which is a PDP-7 emulator as well as a
PDP-11/40 emulator. 

Others are not so easy though we're working on this and over time have added
alternative code and/or fixed them. Most entries do now work and the others we
are working on (slowly as other things are also being done and this is on free
time).

In some cases we replaced the original code with code that works for modern
systems but one can view the original code in the `.orig.c` files (sometimes the
original code is also in the directory as a `winner.alt.c` or `prog.alt.c`).
Some entries should not have modern system versions replaced. See below.

## Q: I can't get some entries to work in 64-bit systems that don't support 32-bit!

Unfortunately some older entries are non-portable and require 32-bit support of
32-bit binaries. A problem system here is macOS Catalina (10.15) as as of that
version macOS no longer supports 32-bit binaries.

There are numerous example entries that require 32-bit binaries. We have tried
to note these in both the respective Makefiles and README.md files but it is
possible that some were missed. These entries are very likely in the
[bugs.md](/bugs.md) file and we welcome any help in making an alternate version
for 64-bit systems. Many were fixed to work with modern systems but some are
supposed to only work with 32-bit systems so any updated version of these
entries should be an alternate version.

## Q: Under macOS I can't compile some entries and/or they don't work right. Why?

If the entry requires gcc and you did not explicitly install gcc in macOS you
will not be able to run or use these entries. This is because macOS gcc is
actually clang, even `/usr/bin/gcc`.

## Q: I can't get XYZZY entry to compile with clang. What can I do?

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

## Q: After running a program my terminal is all messed up! How do I restore my terminal?

The simplest way to do this is to type `reset`. If echo was disabled you can get
usually away with `stty echo`. Sometimes you can also get away with `stty sane`.
`reset` does the most but note that it will clear the screen (obviously `clear`
will too but it won't reset the terminal).


## Q: How do I get X11 entries to work with macOS Mountain Lion and later?

In macOS Mountain Lion and beyond to run X11 applications one needs to install
[XQuartz](https://www.xquartz.org). This will let you compile, link and run X11
applications.

## Q: How do I compile and run entries that use SDL1/SDL2 ?

This depends on your operating system but below are instructions for linux and
macOS with alternative methods for macOS and different package managers with
linux.

### Red Hat based linux

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

### Debian based linux

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


### Other linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.

### macOS

If you're using macOS there are at least three ways to obtain it. You can
download it from the SDL website and install the package. That will not
work well for the IOCCC but these will:

#### MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


```sh
sudo port install libsdl libsdl2
```

#### Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SDL and SDL2, execute the following command:

```sh
brew install sdl2 sdl12-compat
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Q: How do I compile and run entries that use sound in macOS?

This might depend on the entry but in some cases like
[2001/coupard](2001/coupard/coupard.c) one needs to do more work in order to get
it to work. In this case you should be able to use the Swiss Army Knife of sound
processing programs, [SoX](https://sox.sourceforge.net). To install this easily
you can use either MacPorts or Homebrew. See below for instructions for each.

Usually the README.md file will explain how to use it in linux so we do not
include this here, at least for now.

### MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


```sh
sudo port install sox
```

### Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SoX, execute the following command:

```sh
brew install sox
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Q: How did entry XYZZY win? It breaks rule 2!

As entries have been fixed it is entirely possible that some of the entries no
longer fit within the year's size restrictions. Invariably the length of columns
and/or number of rows have also changed.

For the original version see the [/archive](/archive) directory where you can
find all the original winning entries. In some cases the `winner.alt.c` is the
original source code.

## Q: Since some entries have been modified over time, how can I view the original entry?

See either the `winner.orig.c` or `prog.orig.c`, depending on the year (earlier
years we did not rename the code to `prog.c` but had it as the winner handle),
in the winning directories.

## Q: I found a bug in a previous winner, what should I do?

We do not 'maintain' the contest winners as such. The code is made available on an 'AS
IS' basis. If you have a FIX for an entry, we suggest that you try and email it
to the authors and to submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) (with ONE PULL
REQUEST *PER* FIX, please!). 

Note that just because you have a fix does not mean it'll be accepted. This
might be because the author objects or it doesn't fit in some way or another. Of
course if the entry does not work we'll certainly be more inclined to accept the
fix. If it is accepted we'll be happy to credit you in the entry's _README.md_
file. If you're a previous winner we will happily link to your entries; if
you're not we can link to your website if you wish.

More generally please see the file [how-to-bugfix.md](/how-to-bugfix.md). Note
that this file is not a tutorial on how to fix X, Y and Z problems but rather
what to do to get the fix in.

## Q: Do you have a list of entries with known problems and/or features that might appear to be bugs but are not?

Yes! Please see [bugs.md](/bugs.md) for a list of known bugs and/or issues of a
variety of kinds.

Note that just because an entry is not in the bugs file does not mean there is
not an issue and note that some issues are simply missing files, dead URL(s) or
something like that.

## Q: Are there types of entries that are submitted so frequently that the judges get tired of them?

Yes, there are types of entries that show up over and over again.

The [guidelines](guidelines.html) say:

> _We tend to dislike programs that: are similar to previous winners_

We like variety. However too often we see (please look at the winning examples
given to be aware of the level of the competition):

### maze generator
- [1985/shapiro](years.html#1985_shapiro)

- [1991/buzzard](years.html#1991_buzzard)

- [1995/cdua](years.html#1995_cdua)

- [1995/dodsond2](years.html#1995_dodsond2)

- [1998/bas1](years.html#1998_bas1)

### tic-tac-toe game

- [1991/westley](years.html#1991_westley)

- [1996/jonth](years.html#1996_jonth)

- [2020/carlini](years.html#2020_carlini)

### solitaire/Othello game

- [1987/lievaart](years.html#1987_lievaart)

- [1994/dodsond1](years.html#1994_dodsond1)


### generating small primes (below is the list of all prime related winners)

- [1985/august](years.html#1985_august)

- [1988/applin](years.html#1988_applin)

- [1994/weisberg](years.html#1994_weisberg)

- [1995/makarios](years.html#1995_makarios)

- [1996/dalbec](years.html#1996_dalbec)

- [2000/bellard](years.html#2000_bellard)

_As you can see, just a list of primes (let alone small primes) does not cut it
anymore._

### self reproducing program

- [1990/scjones](years.html#1990_scjones)

- [1994/smr](years.html#1994_smr) - _do not claim your program is the smallest one without seeing this!

- [2000/dhyang](years.html#2000_dhyang) - _unless you beat this one, your chances are slim_

### entries that just print "Hello, world!"

- [1984/anonymous](years.html#1984_anonymous)

- [1985/applin](years.html#1985_applin)

- [1986/applin](years.html#1986_applin)

- [1986/holloway](years.html#1986_holloway)

- [1989/jar.1](years.html#1989_jar.1)

- [1992/lush](years.html#1992_lush)

- [2000/tomx](years.html#2000_tomx)

_**...it's so 20th century...**_

### entries that use some complex state machine/table to print something

- [1988/isaak](years.html#1988_isaak)

- [1988/phillipps](years.html#1988_phillipps)

- [2018/ciura](years.html#2018_ciura)

- [2018/giles](years.html#2018_giles)

### rot13

- [1985/sicherman](years.html#1985_sicherman)

- [1989/westley](years.html#1989_westley)

- [1990/dg](years.html#1990_dg)

- [1991/fine](years.html#1991_fine)

### **pi** or **e** computation

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

## Q: What should I write in the 'remarks' (remarks.md) section of my entry, if anything at all?

As much or as little as you wish.

### What helps:

- explaining what your entry does

- how to entice it to do what it is supposed to do

- what obfuscations are used

- what are the limitations of your entry in respect of portability and/or input data

- how it works (if you are really condescending)

### What does not help:

- admitting that your entry is not very obfuscated (you see, the contest is
called the **IOCCC**, not the **INVOCCC** :-) ); but even if you do not admit
it, not very obfuscated entries have a minuscule chance to win (although
[2000/tomx](years.html#2000_tomx) is a notable counterexample).

- mentioning your name or any identifying information in the remark section (or
in the C code for that matter) - we like to be unbiased during the judging
rounds; we look at the author name only if an entry wins. See the guidelines if
this is not clear!

- leaving the remark section empty.


## Q: I am confused: what should I put to the 'build' section?

The 'build' section must contain UNIX shell-style commands to compile your C
language entry **in a file named prog.c** and produce an executable file. More
than one command is allowed, as far as the size rule is followed.  Usually one
(or more) of these commands will be an invocation of a C compiler (use **cc** or
**gcc**), but there may be exceptions (or not anymore, see
[2000/tomx](years.html#2000_tomx)).

If your entry depends on a particular source file name during compilation or execution, you will have to put a line

	
	    cp prog.c desired_name.c


before the compiler invocation line.


If in doubt, put

	    cc -o prog prog.c

in the 'build' section.

Note however that with the [mkiocccentry
tool](https://github.com/ioccc-src/mkiocccentry) we have an example Makefile
which you should update and submit, using the instructions above if necessary.


## Q: What happened to the winners for 1997, 1999 2002, 2003, 2007 - 2010, 2016, 2017, 2021 and 2022 ?

There are none. There was no IOCCC in those years.

## Q: What are the .orig.c files in the directories in winning entries ?

Due to the fact that the original code has sometimes had to change these files
are the original winning entry or as close to as possible to the original that
we can find.

## Q: Why don't you publish non-winners?

Because the publication on the IOCCC site **_IS_**
the award! Anyone is free to put their IOCCC hopefuls, lookalikes and/or
non-winners on their web page for everyone to see.

## Q: How much time does it take to judge the contest?

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


## Q: What platform should I assume for my entry?

Your entry must compile with GCC and run under at least one flavor of UNIX (e.g.
Linux or Solaris). To improve chances to win, it should work under both BSD and
SysV style UNIX (think **stty cbreak**), and should not depend on endianness.
If it can compile and run on Windows and/or Mac  (see
[2000/thadgavin](/years.html#2000_thadgavin) for one example, amongst others),
even better. Being able to compile with other compilers like clang is also a
good thing.

## Q: I would like to mirror the IOCCC web site. May I do so?

We are not accepting mirror requests at this time, sorry.

## Q: I want to publish some parts of the IOCCC in an article, or book, or newsletter, or use then in class/instructional notes, or quote from the IOCCC. May I do so?

Please ask the [IOCCC judges](/judges.html) first. Please send your request using the
instructions on the [contacting the IOCCC Judges](/contact.html) page.

## Q: What are the grand prize / Best of Show winners?

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

## Q: I managed to get entry XYZZY from year 19xx to compile; now it fails to run!

switch(19xx/XYZZY) {

    case [1984/mullender](years.html#1984_mullender):

try the alternative code added by [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) like:

```sh
make alt
./mullender.alt [microseconds]
```

where microseconds is the number of microseconds to sleep between writes.
Default 10000. This is useful to see different speeds as well as if your CPU is
too slow or too fast for the entry. See the
[README.md](/1984/mullender/README.md) for more details.

Thank you Cody for your help!

BTW: in this case it's a slight fix and improvement to our original suggested
code:

```c
main(){int i=512;do write(1,"  :-)\b\b\b\b",9),usleep(i);while(--i);}
```

BTW: is there such a thing as too fast a CPU ? :-) actually yes for certain code
which is probably not as uncommon as you think :-) ).

break;

- case [1991/davidguy](years.html#1991_davidguy): disable access
control of your X server (**xhost +**). If it does not help (or if you
see black screen), restart the X server without access control and with visual
depth of 8 bits or less.

break;

- default: Try enabling `-fwritable-strings` for GCC or its equivalent for other
compilers.

}

## Q: How did the IOCCC get started?

One day (23 March 1984 to be exact), Larry Bassel and I (Landon Curt
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

BTW: The [1984 winner](/years.html#1984_mullender) remains one of my (Landon
Curt Noll) all time favorites.


The name used in the posting of the [1st IOCCC
winner](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
posting was **I**nternational **O**bfuscated **C** **C**ode **C**ontest or
**IOCCC** for short.

The posting said '_1st annual_', so in 1985 we held the [2nd IOCCC contest](/years.html#1985)
and the tradition continues as the longest running contest on the Internet.

P.S. Part of the inspiration for making the IOCCC a contest goes to the
[Bulwer-Lytton fiction contest](http://www.bulwer-lytton.com/).

<P>

P^2.S. See the
[overall README](/all/README)
for more details.

<TABLE><TR>
<TD><a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="/png/by-sa-3.0-88x31.png" /></a></TD>
<TD><P>&copy; Copyright 1984-2020,
[Leo Broukhis, Landon Curt Noll](/judges.html)
- All rights reserved<br>
This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.</P></TD>
<TD>&nbsp;<!--<a href="https://validator.w3.org/check?uri=referer"><img src="https://www.w3.org/Icons/valid-html401" alt="Valid HTML 4.01 Transitional" height="31" width="88"></a>--></TD>
</TR></TABLE>

## Q: Why do you sometimes use the first person plural?

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
