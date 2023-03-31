<HTML>
<BODY TEXT="#000000">

<center><img alt="IOCCC" SRC="png/ioccc.png"></center><br>
<center><font size="6"><I>The International Obfuscated C Code Contest </I></font></center><br>
<center><P>[ <A HREF="judges.html">The judges</A> |
<A HREF="main.html">IOCCC home page</A> |
<A HREF="main.html#enter">How to enter</A> |
<B>FAQ</B> |
<A HREF="contact.html">Contacting the IOCCC</A>
<br>
<A HREF="main.html#new">IOCCC news</A> |
<A HREF="winners.html">People who have won</A> |
<A HREF="years.html">Winning entries</A> ]</P></center>
<br>

<HR>

# The IOCCC FAQ

## Q:</font> How many entries do you receive each year?

By tradition, we do not say.

## Q: How many judging rounds do you have?
Are you trying to trick us? We will not say that either.

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
./mullender.alt
```

See also [Yusuke Endoh](/winners.html#Yusuke_Endoh)'s entry
[2015/endoh3](/2015/endoh3/README.md) entry which lets one compile it and run
it.

Others are not so easy though we're working on this and over time have added
alternative code and in some cases replaced the original code with code that
works for modern systems.


## Q: How do I get X11 entries to work with macOS Mountain Lion and later?

In macOS Mountain Lion and beyond to run X11 applications one needs to install
[XQuartz](https://www.xquartz.org). This will let you compile, link and run X11
applications.

## Q: I found a bug in a previous winner, what should I do?

We do not 'maintain' the contest winners. The code is made available on an 'AS
IS' basis. If you have a FIX for a entry, we suggest that you try and email it
to the authors and to CC: us using the instructions on the [contacting the IOCCC
Judges](contact.hml) page.

IF you have a FIX, and IF the author does not object, and IF your fix
looks reasonable, we will add a web link to a copy of your email
for others to see.

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

- [1994/smr](years.html#1994_smr) - _do not claim your program is the smallest one without seeing it!

- [2000/dhyang](years.html#2000_dhyang) - _unless you beat this one, your chances are slim_

### entries that just print "Hello, world!"

- [1984/anonymous](years.html#1984_anonymous)

- [1985/applin](years.html#1985_applin)

- [1986/applin](years.html#1986_applin)

- [1986/holloway](years.html#1986_holloway)

- [1989/jar.1](years.html#1989_jar.1)

- [1992/lush](years.html#1992_lush)

- [2000/tomx](years.html#2000_tomx)

_**it's so 20th century...**_

### entries that use some complex state machine/table to print something

- [1988/isaak](years.html#1988_isaak)

- [1988/phillipps](years.html#1988_phillipps)

### rot13

- [1985/sicherman](years.html#1985_sicherman)

- [1989/westley](years.html#1989_westley)

- [1990/dg](years.html#1990_dg)

- [1991/fine](years.html#1991_fine)

### **pi** or **e** computation</font>

- [1986/august](years.html#1986_august)

- [1988/robison](years.html#1988_robison)

- [1988/westley](years.html#1988_westley)

- [1989/roemer](years.html#1989_roemer)

HINT: It is not fatal to send in those types of entries, it is just MUCH
HARDER to win. Such an entry would have to do something really unique and
interesting to even make it into the final judging rounds. Entries that
re-use these 'worn out' themes frequently lose to other entries that do
something different.

HINT: If you really MUST send in an entry based on an 'over-used theme',
be sure that it is obfuscated in several new and novel ways. Be sure to clearly
explain near the beginning of your remarks why you are submitting a entry
based on an 'over-used theme' and why the judges should not simply toss
it out as being boring.

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
called <B>IOCCC</B>, not <B>INVOCCC</B>); but even if you do not admit it, not
very obfuscated entries have a minuscule chance to win (although
[2000/tomx](years.html#2000_tomx) is a notable counterexample)

- mentioning your name or any identifying information in the remark section (or
in the C code for that matter) - we like to be unbiased during the judging
rounds; we look at the author name only if an entry wins

- leaving the remark section empty

## Q: I am confused: what should I put to the 'build' section?

The 'build' section must contain UNIX shell-style commands to compile your C
language entry **in a file named prog.c** and produce an executable file. More than one command is allowed,
as far as the size rule is followed.
Usually one (or more) of these commands will be an invocation of
a C compiler (use **cc** or <B>gcc</B>), but there may be exceptions
(or not anymore, see [2000/tomx](years.html#2000_tomx)).

If your entry depends on a particular source file name during compilation or execution, you will have to put a line

	cp prog.c desired_name.c

before the compiler invocation line.

If in doubt, put

	cc -o prog prog.c

in the 'build' section.

Note however that with the [mkiocccentry
tool](https://github.com/ioccc-src/mkiocccentry) we have an example Makefile
which you should update, using the instructions above if necessary.


## Q: What happened to the winners for 1997, 1999 2002, 2003, 2007 - 2010, 2016, 2017, 2021 and 2022 ?

There are none. There was no IOCCC in those years.

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
SysV style UNIX (think <B>stty cbreak</B>), and should not depend on endianness.
If it can compile and run on Windows and/or Mac  (see
[2000/thadgavin](/years.html#2000_thadgavin) for one example, amongst others), even better.

## Q: I would like to mirror the IOCCC web site. May I do so?

We are not accepting mirror requests at this time, sorry.

## Q: I want to publish some parts of the IOCCC in an article, or book, or newsletter, or use then in class/instructional notes, or quote from the IOCCC. May I do so?

Please ask the IOCCC judges first. Please send your request using the
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
./mullender.alt
```

Thank you Cody for your help!

It's a slight adjustment to our original suggested code:

	main(){int i=512;do write(1,"  :-)\b\b\b\b",9),usleep(i);while(--i);}

break;

- case [1991/davidguy](years.html#1991_davidguy): disable access
control of your X server (**xhost +**). If it does not help (or if you
see black screen), restart the X server without access control and with visual
depth of 8 bits or less.

break;

- default: Try enabling <TT>-fwritable-strings</TT> for GCC
or its equivalent for other compilers.

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
[flame to to
net.lang.c](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=789%40nsc.UUCP&rnum=3&filter=0")
inviting people to try and out obfuscate the UN\*X source code we had just been working on.

BTW: I (Landon Curt Noll) had to post this [typo
correction](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=795%40nsc.UUCP&rnum=10&filter=0).
Thus began the tradition of putting typos in the contest rules and guidelines
... to make them more obfuscated of course! :-)

BTW: This posting was made back in the days when AT&amp;T was the evil giant.
Now, Microsoft makes AT&amp;T look mild and kind in comparison. :-( (IMHO) ).

BTW: See the story about the '[Bill Gates](/1993/mills/mills.hint)' award. :-)


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
They said: '_Yes, I want to keep my anonymity.  But you can tell them that I am a well known for my connection to the
C language"_'. It was not until 2001 that another [anonymous
entry](/years.html#2001_anonymous) received an award.

BTW: The [1984 winner](/years.html#1984_mullender) remains one of my (Landon
Curt Noll) all time favorites.


The name used in the posting of the [1st IOCCC
winner](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
posting was **I**nternational **O**bfuscated **C** **C**ode <B>C</B>ontest or
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
