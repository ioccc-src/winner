## [1984/anonymous](1984/anonymous/anonymous.c) ([README.md](1984/anonymous/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to work
under macOS. The fix was to not use implicit `int`s in the `read()` function as
it once did. Instead the second arg is a `void *`.  In the `read()` function
(which actually calls `write(2)`) the `i` (which is the `void *`) has to be cast
to an `int`. This solves the problem. Thank you Cody for your assistance!


## [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to not
require `-traditional-cpp` which not all compilers support (clang does not
support it for example). Clang is also more strict about the args' types in
`main()` and this was also a problem that Cody fixed, making it work with both
clang and gcc. For the original code with the gcc fix described below, see the
alternate code section below. Thank you Cody for your assistance!

Originally [Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch so that
this entry would compile with gcc - but not clang - or at least some versions.
Thank you Yusuke!


## [1984/mullender](1984/mullender/mullender.c) ([README.md](1984/mullender/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) provided an alternate
version which was an improved version from the judges so that everyone can enjoy
it in systems that are not VAX/PDP. We also refer you to the [faq](faq.md) as
there are some winning entries that also let one enjoy it - with more to them of
course!

## [1985/applin](1985/applin/applin.c) ([README.md](1985/applin/README.md]))

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided a patch to get this to
not issue crash and [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
fixed this to work with macOS (it printed the string `H????` in a seemingly
infinite loop of printing more and more `?`s).

The problem with the crash is that it destructively rewrites string literals but
with `strdup()` it's safe.

For macOS it's because there was no prototype for `execlp()` and macOS has
problems with missing prototypes for some functions (this was also seen when
Cody fixed [1984/anonymous](/1984/anonymous/anonymous.c) for macOS as well
though that fix was more complicated). Ironically this fix was discovered
through linux!

NOTE: originally this entry did not print a newline prior to returning to the
shell, after the output (despite having `\n` in the string - why?) but to make
it more friendly to users Cody made it print a `\n` prior to returning to the
shell.

Thank you Yusuke and Cody for your help!


## [1985/lycklama](1985/lycklama/lycklama.c) ([README.md](1985/lycklama/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
with modern compilers. In the past one could get away with defining some macro
to `#define` and then use `#foo` to have the same effect as using `#define` but
this does not work in modern systems so Cody changed the `#o` lines to
`#define`. The `lycklama.alt.c` is the original source code as it provides some
fun input for the entry. Thank you Cody!

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided some useful information that
amounts to an alternate version but which does not actually modify the code.
Perhaps it should be an alternate version but in any case see the README.md file
for details.


## [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this _very twisted
entry_ to not require `-traditional-cpp`. He'd like to refer you to the original
file in [sicherman.alt.c](1985/sicherman.alt.c) and he suggests that you then compare
it to [sicherman.c](1985/sicherman/sicherman.c) for some good old C-fashioned fun!


## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to
compile and work with clang (it already worked with gcc).  The problem was that
clang is more strict about the type of second arg to main(). However simply
changing it to a `char **` and updating the `*s` to `**s` caused a segfault. By
adding a new variable, `char *t`, initialising it to `s` and then using `t`
instead of `s` it compiles and runs successfully under clang and gcc.


## [1986/marshall](1986/marshall/marshall.c) ([README.md](1986/marshall/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) got this to
compile and work with clang. It did not work with clang because it is more
strict about the second and third args to main() and the third arg was an int.
He notes that he tried to keep the picture as close to the original. The line
lengths are the same but some spaces had to be changed to non-spaces.


## [1986/wall](1986/wall/wall.c) ([README.md](1986/wall/README.md]))

We used a patch provided by [Yusuke Endoh](/winners.html#Yusuke_Endoh) to make
this work with gcc (in particular the patch uses `strdup()` on two strings).
Thank you Yusuke! [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed
this so that it does not require `-traditional-cpp`. This took a fair bit of
tinkering as this entry *is* strange. The original code is provided to allow one
to easily see how different C was in those days. See below for details. Thank
you Cody for your assistance!


## [1987/wall](1987/wall/wall.c) ([README.md](1987/wall/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made this safer by
using `fgets()` instead of `gets()`. This prevents an annoying and potentially
alarming warning at compiling, linking or runtime.


## [1987/westley](1987/westley/westley.c) ([README.md](1987/westley/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. The problem was 'assignment to cast is illegal, lvalue casts are not
supported'. For the original file see below. Thank you Cody for your assistance!

## [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
compilers. There were two problems to address. One was that the entry required
`-traditional-cpp` (which <strike>not all compilers support</strike> `clang`
does not support) which Cody fixed. It needed that option because of two things
it did:

```c
#define a(x)get/***/x/***/id())

/* ... */

p Z=chroot("/");L(!a(u)execv((q(v="/ipu6ljov"),v),C);Z-=kill(l);

/* ... */

case_2:L(!--V){O/*/*/c*c+c);wait(A+c*c-c);L(!Z)f(A,"\n",c);return(A*getgid());};C++;
```

no longer works to create `getuid()` and `getgid()`. The second is that

```c
for/*/(;;);/*/k()){O/*/*/c);
```

cannot form `fork())` in modern C compilers. What is quite fun is that the cpp
can!

The other problem was that modern compilers do not allow directives like:

```c
#define _ define
+#_ P char
+#_ p int
+#_ O close(
...
```

so Cody changed the lines to be in the form of:

```c
#define foo bar
```

## [1988/isaak](1988/isaak/isaak.c) ([README.md](1988/isaak/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to work for
modern systems. The problem was that the important function, a redefinition of
exit(), was not being called in main(). See below notes for the original,
alternative version.

The original version is in [1988/isaak/isaak.alt.c](1988/isaak/isaak.alt.c).

## [1988/phillipps](1988/phillipps/phillipps.c) ([README.md](1988/phillipps/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. It did not compile with clang because it requires the second and third
args to main() to be `char **` but even before that with gcc it printed random
characters. After fixing it for clang by changing main() to call the new
function pain() (chosen because it's a pain that clang requires these args to
be `char **` :-) ) with the correct args it now works. Thank you Cody for your
assistance!


## [1988/spinellis](1988/spinellis/spinellis.c) ([README.md](1988/spinellis/README.md]))

An alternate version was provided by Cody for this so that it works for
compilers like clang.

## [1989/fubar](1989/fubar/fubar.c) ([README.md](1989/fubar/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) got this to work with
modern systems. The main issues were an `#include` had to be added and fixing the
path to files referred to in the code was also needed.


## [1989/jar.2](1989/jar.2/jar.2.c) ([README.md](1989/jar.2/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to work with
modern compilers. Modern compilers do not allow code like:

```c
#define D define
#define a include

#D foo bar
#a <stdio.h>
```

He notes that there _is_ a way to get it (or something close to it) to work. Do
you know how?

## [1989/ovdluhe](1989/ovdluhe/ovdluhe.c) ([README.md](1989/ovdluhe/README.md]))

Cody provided an alternate version based on the author's remarks. See the
README.md for details.

## [1989/paul](1989/paul/paul.c) ([README.md](1989/paul/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a segfault under
macOS. The problem was that the int (from `#define f`) should be a long. This
became apparent when he was using lldb and saw that the type of a pointer was
long. Thank you Cody for your assistance!

## [1989/robison](1989/robison/robison.c) ([README.md](1989/robison/README.md]))

Yusuke Endoh fixed this to compile under modern systems.


## [1989/tromp](1989/tromp/tromp.c) ([README.md](1989/tromp/README.md]))

We used a patch from [Yusuke Endoh](/winners.html#Yusuke_Endoh) 
to get this to compile under gcc. Thank you Yusuke for your assistance!

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) got this to work with
clang by further changing the variable `a` to be not the third argument to
`main()` and instead be a variable declared in `main()`.

Cody also bug fixed it so that the high score file would work (it was not even
being created) and after this making sure the terminal stayed sane (the letter
`u` could not be typed and echo was disabled outright after the segfault fix /
high score file was reinstated). We thank you for your assistance Cody (he
cynically notes that he did it because tetris just has to work)!


## [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md]))

Cody got this to partly work with clang. As there are some important notes on
this in the README.md file we have left the details in that file, at least for
now. Perhaps the [bugs.md](bugs.md) file is a better place but this can be
decided later.


## [1990/baruch](1990/baruch/baruch.c) ([README.md](1990/baruch/README.md]))

Cody added an alternate version which allows certain compilers to compile the
code, based on the author's remarks.

## [1990/cmills](1990/cmills/cmills.c) ([README.md](1990/cmills/README.md]))

Yusuke got this to work in modern systems (it resulted in a bus error).

To prevent alarming warnings at linking or runtime Cody made the entry use
`fgets()` rather than `gets()`. He notes that another option would have been to
redirect `stderr` to `/dev/null` but he did not think of that at the time.

For the original code see the [1992 archive](/archive/archive-1990.tar.bz2).


## [1990/dds](1990/dds/dds.c) ([README.md](1990/dds/README.md]))

[Yusuke Endoh](/winners.html#Yusuke_Endoh) fixed this for modern systems. Thank
you Yusuke!

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) removed the erroneous
prototype to `fopen()` and made this use `fgets()` instead of `gets()` to make
it safer and to prevent an annoying and potentially alarming warning at
compiling and/or linking and/or runtime. Thank you Cody for your assistance!


## [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md]))

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the script to
work properly in modern environments (to do with PATH not having '.' in it). He
notes that with an invocation in the try section will with macOS show
what appears to be an error message but is actually okay. He gives more
information in the [bugs.md](/bugs.md) file. Thank you Cody for the help and
notes!

NOTE: as `btoa` is not common we used a ruby script from [Yusuke
Endoh](/winners.html#Yusuke_Endoh). Thank you Yusuke for your implementation of
`btoa`!


## [1990/scjones](1990/scjones/scjones.c) ([README.md](1990/scjones/README.md]))

## [1990/tbr](1990/tbr/tbr.c) ([README.md](1990/tbr/README.md]))

## [1990/theorem](1990/theorem/theorem.c) ([README.md](1990/theorem/README.md]))

## [1990/westley](1990/westley/westley.c) ([README.md](1990/westley/README.md]))

## [1991/brnstnd](1991/brnstnd/brnstnd.c) ([README.md](1991/brnstnd/README.md]))

## [1991/dds](1991/dds/dds.c) ([README.md](1991/dds/README.md]))

## [1991/westley](1991/westley/westley.c) ([README.md](1991/westley/README.md]))

## [1992/adrian](1992/adrian/adrian.c) ([README.md](1992/adrian/README.md]))

## [1992/gson](1992/gson/gson.c) ([README.md](1992/gson/README.md]))

## [1992/kivinen](1992/kivinen/kivinen.c) ([README.md](1992/kivinen/README.md]))

## [1992/lush](1992/lush/lush.c) ([README.md](1992/lush/README.md]))

## [1992/westley](1992/westley/westley.c) ([README.md](1992/westley/README.md]))

## [1993/jonth](1993/jonth/jonth.c) ([README.md](1993/jonth/README.md]))

## [1993/leo](1993/leo/leo.c) ([README.md](1993/leo/README.md]))

## [1993/lmfjyh](1993/lmfjyh/lmfjyh.c) ([README.md](1993/lmfjyh/README.md]))

## [1993/plummer](1993/plummer/plummer.c) ([README.md](1993/plummer/README.md]))

## [1993/rince](1993/rince/rince.c) ([README.md](1993/rince/README.md]))

## [1993/schnitzi](1993/schnitzi/schnitzi.c) ([README.md](1993/schnitzi/README.md]))

## [1993/vanb](1993/vanb/vanb.c) ([README.md](1993/vanb/README.md]))

## [1994/ldb](1994/ldb/ldb.c) ([README.md](1994/ldb/README.md]))

## [1994/schnitzi](1994/schnitzi/schnitzi.c) ([README.md](1994/schnitzi/README.md]))

## [1994/shapiro](1994/shapiro/shapiro.c) ([README.md](1994/shapiro/README.md]))

## [1994/westley](1994/westley/westley.c) ([README.md](1994/westley/README.md]))

## [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md]))

## [1995/garry](1995/garry/garry.c) ([README.md](1995/garry/README.md]))

## [1996/august](1996/august/august.c) ([README.md](1996/august/README.md]))

## [1996/dalbec](1996/dalbec/dalbec.c) ([README.md](1996/dalbec/README.md]))

## [1996/eldby](1996/eldby/eldby.c) ([README.md](1996/eldby/README.md]))

## [1996/gandalf](1996/gandalf/gandalf.c) ([README.md](1996/gandalf/README.md]))

## [1996/westley](1996/westley/westley.c) ([README.md](1996/westley/README.md]))

## [1998/chaos](1998/chaos/chaos.c) ([README.md](1998/chaos/README.md]))

## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md]))

## [1998/schweikh1](1998/schweikh1/schweikh1.c) ([README.md](1998/schweikh1/README.md]))

## [2000/anderson](2000/anderson/anderson.c) ([README.md](2000/anderson/README.md]))

## [2000/briddlebane](2000/briddlebane/briddlebane.c) ([README.md](2000/briddlebane/README.md]))

## [2000/dlowe](2000/dlowe/dlowe.c) ([README.md](2000/dlowe/README.md]))

## [2000/jarijyrki](2000/jarijyrki/jarijyrki.c) ([README.md](2000/jarijyrki/README.md]))

## [2000/natori](2000/natori/natori.c) ([README.md](2000/natori/README.md]))

## [2000/thadgavin](2000/thadgavin/thadgavin.c) ([README.md](2000/thadgavin/README.md]))

## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md]))

## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md]))

## [2001/cheong](2001/cheong/cheong.c) ([README.md](2001/cheong/README.md]))

## [2001/coupard](2001/coupard/coupard.c) ([README.md](2001/coupard/README.md]))

## [2001/ctk](2001/ctk/ctk.c) ([README.md](2001/ctk/README.md]))

## [2001/dgbeards](2001/dgbeards/dgbeards.c) ([README.md](2001/dgbeards/README.md]))

## [2001/herrmann2](2001/herrmann2/herrmann2.c) ([README.md](2001/herrmann2/README.md]))

## [2001/kev](2001/kev/kev.c) ([README.md](2001/kev/README.md]))

## [2001/westley](2001/westley/westley.c) ([README.md](2001/westley/README.md]))

## [2004/arachnid](2004/arachnid/arachnid.c) ([README.md](2004/arachnid/README.md]))

## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md]))

## [2004/gavin](2004/gavin/gavin.c) ([README.md](2004/gavin/README.md]))

## [2004/kopczynski](2004/kopczynski/kopczynski.c) ([README.md](2004/kopczynski/README.md]))

## [2004/newbern](2004/newbern/newbern.c) ([README.md](2004/newbern/README.md]))

## [2005/aidan](2005/aidan/aidan.c) ([README.md](2005/aidan/README.md]))

## [2005/anon](2005/anon/anon.c) ([README.md](2005/anon/README.md]))

## [2005/giljade](2005/giljade/giljade.c) ([README.md](2005/giljade/README.md]))

## [2005/mynx](2005/mynx/mynx.c) ([README.md](2005/mynx/README.md]))

## [2006/birken](2006/birken/birken.c) ([README.md](2006/birken/README.md]))

## [2006/borsanyi](2006/borsanyi/borsanyi.c) ([README.md](2006/borsanyi/README.md]))

## [2006/monge](2006/monge/monge.c) ([README.md](2006/monge/README.md]))

## [2006/night](2006/night/night.c) ([README.md](2006/night/README.md]))

## [2006/sloane](2006/sloane/sloane.c) ([README.md](2006/sloane/README.md]))

## [2006/toledo2](2006/toledo2/toledo2.c) ([README.md](2006/toledo2/README.md]))

## [2006/toledo3](2006/toledo3/toledo3.c) ([README.md](2006/toledo3/README.md]))

## [2011/eastman](2011/eastman/eastman.c) ([README.md](2011/eastman/README.md]))

## [2011/goren](2011/goren/goren.c) ([README.md](2011/goren/README.md]))

## [2011/richards](2011/richards/richards.c) ([README.md](2011/richards/README.md]))

## [2011/vik](2011/vik/vik.c) ([README.md](2011/vik/README.md]))

## [2012/kang](2012/kang/kang.c) ([README.md](2012/kang/README.md]))

## [2012/tromp](2012/tromp/tromp.c) ([README.md](2012/tromp/README.md]))

## [2012/vik](2012/vik/vik.c) ([README.md](2012/vik/README.md]))

## [2013/birken](2013/birken/birken.c) ([README.md](2013/birken/README.md]))

## [2013/cable3](2013/cable3/cable3.c) ([README.md](2013/cable3/README.md]))

## [2014/maffiodo1](2014/maffiodo1/maffiodo1.c) ([README.md](2014/maffiodo1/README.md]))

## [2014/vik](2014/vik/vik.c) ([README.md](2014/vik/README.md]))

## [2015/endoh3](2015/endoh3/prog.c) ([README.md](2015/endoh3/README.md]))

## [2015/yang](2015/yang/prog.c) ([README.md](2015/yang/README.md]))

## [2018/poikola](2018/poikola/prog.c) ([README.md](2018/poikola/README.md]))

## [2019/ciura](2019/ciura/prog.c) ([README.md](2019/ciura/README.md]))

## [2019/diels-grabsch1](2019/diels-grabsch1/prog.c) ([README.md](2019/diels-grabsch1/README.md]))

## [2019/diels-grabsch2](2019/diels-grabsch2/prog.c) ([README.md](2019/diels-grabsch2/README.md]))

## [2019/karns](2019/karns/prog.c) ([README.md](2019/karns/README.md]))
