# Thanks for all the fixes

.. and thanks for all the fish.  :-)


## Thank you honor roll

There are several people who have contributed to the above mentioned
several thousand changes and important improvements.

We call out the extensive contributions of [Cody Boone
Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson) who is
responsible for many of the improvements including many, many **very complicated
bug fixes** such as [2001/anonymous](2001/anonymous/anonymous.c) and
[2004/burley](2004/burley/burley.c), making entries not require
`-traditional-cpp` (which are **very complicated fixes**), fixing entries to
compile with clang, fixing entries to work with macOS (some of which are **very
complicated** such as [1998/schweikh1](1998/schweikh1/schweikh1.c)), providing
alternate code where useful or necessary, fixing where possible dead links and
otherwise removing them, typo and consistency fixes, improving **ALL
_Makefiles_** and writing the [sgit tool](https://github.com/xexyl/sgit) that we
installed locally and have used to easily run `sed` on files in the repository
to help build the website.  Thank you **very much** for your extensive efforts
in helping improve the IOCCC presentation of past IOCCC winners and making many
many past entries work with modern systems!

[Yusuke Endoh](https://www.ioccc.org/winners.html#Yusuke_Endoh) supplied a
number of important bug fixes to a number of past IOCCC winners. Some of those
fixes were **very technically challenging** such as
[1989/robison](1989/robison/robison.c), [1990/cmills](1990/cmills/cmills.c),
[1992/lush](1992/lush/lush.c) and [2001/ctk](2001/ctk/ctk.c). Thank you **very
much** for your help!

A good number of the [past winners of the
IOCCC](https://www.ioccc.org/winners.html) tested, identified and helped correct
and/or improve the write-ups of fellow IOCCC winners for the year that they won.
The list of those past winners is too long to mention: nevertheless the [IOCCC
judges](https://www.ioccc.org/judges.html) **very much appreciate** those who
helped improve the presentation of their fellow IOCCC winners.


## Thank you list since 2021 Jan 01

To avoid having to change numerous "_README.md_" files to add thank you notes,
we centralize them below.

The [IOCCC judges](https://www.ioccc.org/judges.html) wish to recognize the many
important contributions to the IOCCC presentation of past IOCCC winners.
We are pleased to note the many contributions, **made since 2021 Jan 01**,
on a winner by winner basis.

## Makefile fixes and improvements

Cody made a variety of changes in all Makefiles, sometimes to get an entry to
work, all noted below, but he also **improved them all** in at least one or two
ways.

For instance he changed the `LIBS` variable to `LDFLAGS` as that is the standard
variable. This simplifies compiling without having to modify the Makefile which
can be useful if something changes or if someone is trying to fix an entry but
forgets to change the Makefile or even if they don't want to make a change due
to a temporary test. These would of course depend on the compiler invocation but
since `LDFLAGS` is standard it is more likely to be used by default so no need
to check the Makefiles.

Sometimes there were bad characters or rules that caused the entry to fail to
compile or not work in some way.

Where useful he added some notes to the Makefiles during compilation to let one
know of certain problems or features that matter.

There were some other fixes as well including typos in the Makefiles.

## [1984/anonymous](1984/anonymous/anonymous.c) ([README.md](1984/anonymous/README.md))

Cody fixed this to work for macOS.

The problem was to do with the way that the `read(2)` function was redefined.
With macOS the second arg needs to be a `void *` and this also necessitated some
casts to `int` (on the second arg) in the call to `write(2)` (in `read()`).

By request, the original code is provided as
[anonymous.alt.c](1984/anonymous/anonymous.alt.c) so that one can look at it and
the famous tattoo:

![1984-anonymous-tattoo.jpg](1984/anonymous/1984-anonymous-tattoo.jpg)

which was done in 2005 by [Thomas
Scovell](https://web.archive.org/web/20070120220721/https://thomasscovell.com/tattoo.php).


## [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md]))

Cody fixed this to not require `-traditional-cpp` which not all compilers
support (clang does not support it for example). Clang is also more strict about
the args' types in `main()` and this was also a problem that Cody fixed, making
it work with both clang and gcc - in macOS. It was then noticed that with clang
in linux it did not work so this had to be further fixed which Cody also did.
For the original code with the gcc fix (noted below), see the alternate code
section in the README.md file.

Originally Yusuke supplied a patch so that this entry would compile with gcc -
but not clang - or at least some versions.


## [1984/mullender](1984/mullender/mullender.c) ([README.md](1984/mullender/README.md]))

Cody provided an alternate version which was an improved version from the judges
so that everyone can enjoy it with systems that are not VAX/PDP. We also refer you
to the [FAQ](faq.md) as there are some winning entries that also let one enjoy
it - with more to them of course!

Cody also added the [gentab.c](1984/mullender/gentab.c) file, modified to
compile with modern systems, which the author noted in their remarks which Cody
also found.


## [1985/applin](1985/applin/applin.c) ([README.md](1985/applin/README.md]))

Yusuke provided a patch to get this to not crash and Cody fixed this to
work with macOS (it printed the string `H????` in a seemingly infinite loop,
each time printing another `?`).

The problem with the crash is that it destructively rewrites string literals but
with `strdup()` it's safe.

For macOS it's because there was no prototype for `execlp()` and macOS has
problems with missing prototypes for some functions (this was also seen when
Cody fixed [1984/anonymous](/1984/anonymous/anonymous.c) for macOS as well).
Ironically this fix was discovered through linux!

NOTE: originally this entry did not print a newline prior to returning to the
shell, after the output (despite having `\n` in the string - can you figure out
why?) but to make it more friendly to users Cody made it print a `\n` prior to
returning to the shell. The original version does not have this change.


## [1985/lycklama](1985/lycklama/lycklama.c) ([README.md](1985/lycklama/README.md]))

Cody fixed this to compile with modern compilers. In the past one could get away
with defining some macro to `#define` and then use `#foo` to have the same
effect as using `#define` but this does not work in modern systems so Cody
changed the `#o` lines to `#define`. The
[lycklama.alt.c](1985/lycklama/lycklama.alt.c) is the original source
code as it provides some fun input for the entry.

Yusuke provided some useful information that amounts to an alternate version
that Cody added. See the README.md for details.


## [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md]))

Cody fixed this _very twisted entry_ to not require `-traditional-cpp`. He'd
like to refer you to the original file in
[sicherman.alt.c](1985/sicherman/sicherman.alt.c) and he suggests that you then compare it
to [sicherman.c](1985/sicherman/sicherman.c) for some good old C-fashioned fun!

Later on Cody improved the fix so that it looks much more like the original
entry which can be found in
[1985/sicherman/sicherman.orig.c](1985/sicherman/sicherman.orig.c).


## [1986/hague](1986/hague/hague.c) ([README.md](1986/hague/README.md]))

Cody added alt code that uses `fgets()` to avoid alarming and annoying warnings
about `gets()` being unsafe. The reason this is alt code, at least for now, is
that although it will print the results in both forms of invocation, after the
output in one invocation form it will segfault. This might be addressed later on
or it might be decided that it is worth it, with a caveat in the Makefile or at
least the README.md file, since it still prints out the correct output, though
that seems like it might not be so ideal unless it can be fixed (which might be
done). See the [bugs.md](/bugs.md) file for details.

## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md]))

Cody fixed this to compile and work with clang (it already worked with gcc).
The problem was that clang is more strict about the type of second arg to
main(). However simply changing it to a `char **` and updating the `*s` to `**s`
caused a segfault. By adding a new variable, `char *t`, initialising it to `s`
and then using `t` instead of `s` it compiles and runs successfully under clang
and gcc.


## [1986/marshall](1986/marshall/marshall.c) ([README.md](1986/marshall/README.md]))

Cody got this to compile and work with clang. It did not work with clang because
it is more strict about the second and third args to `main()` and the third arg
was an `int`.  He notes that he tried to keep the ASCII art as close to the
original as possible. The line lengths are the same but some spaces had to be
changed to non-spaces.

A very funny problem occurred depending on the compiler and whether or not the
optimiser is enabled that had to be fixed: one compiler would work fine but
another might enter an infinite loop or segfault but then once the optimiser
state was changed the compiler that worked no longer worked (in the same was as
the other one not working) and the one that didn't work did! We encourage you to
see the README.md file to see how odd this problem was and what Cody did to fix
it!


## [1986/wall](1986/wall/wall.c) ([README.md](1986/wall/README.md]))

We used a patch provided by Yusuke to make this work with gcc (in particular the
patch uses `strdup()` on two strings).

Cody fixed this so that it does not require `-traditional-cpp`. This took a fair
bit of tinkering as this entry *is* strange. The original code is provided to
allow one to easily see how different C was in those days. See the README.md
file for details.


## [1987/wall](1987/wall/wall.c) ([README.md](1987/wall/README.md]))

Cody made this safer by using `fgets()` instead of `gets()`. This prevents an
annoying and potentially alarming warning at compiling, linking or runtime.
Though this could be partly remedied through redirecting `stderr` to `/dev/null`
this would not truly resolve the problem either and in order to avoid the
warning one would have to always redirect `stderr` to `/dev/null`.

Later Cody improved upon the `gets()`/`fgets()` change to make it more like the
original by redefining `gets()` to use `fgets()` (with the correct args) so that
the code can refer to `gets()` instead.


## [1987/westley](1987/westley/westley.c) ([README.md](1987/westley/README.md]))

Cody fixed this for modern systems. The problem was `'assignment to cast is
illegal, lvalue casts are not supported'`. For the original file see the
README.md file.


## [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md]))

Cody fixed this twisted entry (as we called it :-) ) for modern compilers. There
were two problems to address. One was that the entry required `-traditional-cpp`
(which <strike>not all compilers support</strike> `clang` does not support)
which Cody fixed. It needed that option because of two things it did:

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

cannot form `fork())` in modern C compilers. One can put those in directly but
using the C paste token operator `##` also solves the problem of the `#define
a` like this diff shows:

```diff
--- i/1988/dale/dale.c
+++ w/1988/dale/dale.c
@@ -9,18 +9,18 @@
 #define L if
 #define I goto
 #define l 1
 #define f write
 #define J else
-#define a(x)get/***/x/***/id())
+#define a(x)get##x##id())
```

What is quite fun is that at least some C pre-processors can form these
constructs!

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

See the README.md file for details on the original code.


## [1988/isaak](1988/isaak/isaak.c) ([README.md](1988/isaak/README.md]))

Cody fixed this to work for modern systems. The problem was that the important
function, a redefinition of `exit()`, was not being called in main(). The
original version is in [1988/isaak/isaak.alt.c](1988/isaak/isaak.alt.c). See the
README.md file for more details.


## [1988/phillipps](1988/phillipps/phillipps.c) ([README.md](1988/phillipps/README.md]))

Cody fixed this for modern systems. It did not compile with clang because it
requires the second and third args to `main()` to be `char **` but even before
that with gcc it printed random characters. After fixing it for clang by
changing `main()` to call the new function `pain()` (chosen because it's a pain
that clang requires these args to be `char **` :-) ) with the correct args it
now works.

## [1988/reddy](1988/reddy/reddy.c) ([README.md](1988/reddy/README.md))

Cody made this use `fgets()` to prevent annoying warnings during compiling,
linking and runtime, the latter of which being the most annoying.


## [1988/spinellis](1988/spinellis/spinellis.c) ([README.md](1988/spinellis/README.md]))

Cody provided an [alternate version](1988/spinellis/spinellis.alt.c) so that
this will work with compilers like clang. An alternate version had to be
provided because not doing so would be tampering with the file too much. It
would work but it would not show the same creativity. The original file exploits
a fun mis-feature that works with gcc but not clang. This resulted in a change
of rules which is another reason to not modify the original. See the README.md
file for details on the alternate code.

Meanwhile Cody was twisted enough to point out (though to be fair he felt sick
doing this) that with a slight modification this entry can be C++ instead. We don't
thank him for this ghastly point! :-)


## [1988/westley](1988/westley/westley.c) ([README.md](1988/westley/README.md]))

The [original version](1988/westley/westley.alt.c), provided as alternate code,
was fixed by Misha Dynin, based on the judges' remarks so that this would work
with modern C compilers. We encourage you to try the alternate version to see
what happens with current compilers! See the README.md files for details.


## [1989/fubar](1989/fubar/fubar.c) ([README.md](1989/fubar/README.md]))

Cody got this to work with modern systems. The `main()` issues were an
`#include` had to be added along with fixing the path (due to `.` not being in
`$PATH`) to files referred to in the code.


## [1989/jar.2](1989/jar.2/jar.2.c) ([README.md](1989/jar.2/README.md]))

Cody fixed this to work with modern compilers. Modern compilers do not allow
code like:

```c
#define D define
#define a include

#D foo bar
#a <stdio.h>
```

He notes that there _is_ a way to get it (or something close to it) to work. Do
you know how?


## [1989/ovdluhe](1989/ovdluhe/ovdluhe.c) ([README.md](1989/ovdluhe/README.md]))

Cody provided an [alternate version](1989/ovdluhe/ovdluhe.alt.c) based on the
author's remarks. See the README.md for details.


## [1989/paul](1989/paul/paul.c) ([README.md](1989/paul/README.md]))

Cody fixed a segfault under macOS. The problem was that the int (from `#define
f`) should be a long. This became apparent when he was using lldb and saw that
the type of a pointer was too `long` :-)


## [1989/robison](1989/robison/robison.c) ([README.md](1989/robison/README.md]))

Yusuke Endoh fixed this to compile under modern systems. To see the changes
made, try:


```sh
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..9d63c37f490da333fbb1ed7db9571902570d4bad 1989/robison/robison.c
```

(It adds the C token pasting operator `##` instead of `/**/`.)


## [1989/tromp](1989/tromp/tromp.c) ([README.md](1989/tromp/README.md]))

We used a patch from Yusuke to get this to compile under gcc.

Cody fixed this to work with clang by further changing the variable `a` to be
not the third argument to `main()` but instead be a variable declared in
`main()`.

Cody also bug fixed it so that the high score file would work (it was not even
being created) and after this making sure the terminal stayed sane (the letter
'`u`' could not be typed and echo was disabled outright after the segfault fix /
high score file was reinstated). Although we appreciate the help here, he
cynically noted that he had to have an IOCCC
[Tetris](https://en.wikipedia.org/wiki/Tetris) working (this of course was not
his only reason :-) )


## [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md]))

Cody got some of the versions (the original and `ver0`) to work with some
versions of `clang`. Unfortunately there are some defects in `clang` that break
this entry either in full or in part.

Cody provided the compile.sh script to generate the files and then try and
compile them (which ones succeed depend on whether or not clang is the
compiler). The script allows one to change the path of the compiler if they have
another one. See the README.md for details.

As there are some important notes on this in the README.md file we have left the
details in that file and further details are in the [bugs.md](bugs.md) file.


## [1990/baruch](1990/baruch/baruch.c) ([README.md](1990/baruch/README.md]))

Cody added an [alternate version](1990/baruch/baruch.alt.c) which allows certain
compilers to compile the code, based on the author's remarks.


## [1990/cmills](1990/cmills/cmills.c) ([README.md](1990/cmills/README.md]))

Yusuke got this to work in modern systems (it previously resulted in a bus
error).

To prevent alarming warnings at linking or runtime Cody made the entry use
`fgets()` rather than `gets()`. He notes that another option would have been to
redirect `stderr` to `/dev/null` but he did not think of that at the time.

Cody later improved upon the `gets()`/`fgets()` fix to make it more like the
original where the code can refer to `gets()` in the way it originally did. This
was done through a macro to redefine `gets`.

BTW: Cody asks the following question: if the compiler compiles, the linker
links and the user executes does that make the compiler the jury, the linker the
judge and user the executioner? :-)


## [1990/dds](1990/dds/dds.c) ([README.md](1990/dds/README.md]))

Yusuke and Cody in conjunction fixed this for modern systems (both fixed a
different compiler error but more fixes were also made).

Yusuke added the comma operator for a binary expression with `free(3)` which is
is a compiler error because `free()` returns void. Cody then made it slightly more like the
original in this way by redefining `free` to have the comma operator itself.

Cody fixed another compiler error by removing the erroneous prototype to
`fopen()`.  Cody also changed a file to be a proper `FILE *` and fixed a typo in
[LANDER.BAS](1990/dds/LANDER.BAS).

Cody also made this use `fgets()` instead of `gets()` to make it safer and to
prevent an annoying and potentially alarming warning at compiling and/or linking
and/or runtime, the latter of which is unfortunately interspersed with the
output of the program.

Later Cody improved the `gets()`/`fgets()` fix by redefining `gets()` to use
`fgets()`. Notice that the original entry used `fgets()` in one case as it has
to read from another file and in this place nothing was changed.

With these improvements the entry looks much more like the original!

## [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md]))

Cody fixed the script to work properly in modern environments (to do with `$PATH`
not having `.` in it). He notes that with an invocation in the try section will
with macOS show what appears to be an error message but is actually okay. He
gives more information in the [bugs.md](/bugs.md) file.

NOTE: as `btoa` is not common we used a ruby script from Yusuke.


## [1990/tbr](1990/tbr/tbr.c) ([README.md](1990/tbr/README.md]))

Cody fixed this to work with modern compilers; `exit(3)` returns void but the
function was used in a binary expression so this wouldn't even compile. Cody
also changed the code to use `fgets()` instead of `gets()` so one would not get
a warning about the use of `gets()` at linking time or execution, the latter of
which was causing confusing output due to the warning being interspersed with
the program's interactive output.

Cody later improved his fix so that it looks more like the original. A problem
that usually occurs with `gets()` to `fgets()` is for 'backwards compatibility'
(so the man page once said) `fgets()` retains the newline and `gets()` does not.
In this program if one does not remove the newline it breaks the program. This
usually requires that one check that `fgets()` does not return NULL but with
some experimenting this proved to seem to not be a problem here so by adding a
couple macros that redefine `exit()` and `gets()` a whole binary expression
could be removed (thus removing an extra `exit()` call) and it now almost looks
like the same as the original.

## [1990/theorem](1990/theorem/theorem.c) ([README.md](1990/theorem/README.md]))

Cody fixed this to compile with modern systems.

He also fixed some bugs that impacted the usability of this program including some
segfaults under modern systems (and possibly in some cases earlier systems) with
this entry.  Originally we noted that the 4 trailing args '0 0 0 0' were
required on systems that dump core when NULL is dereferenced but this problem
showed itself in modern systems even with the 4 '0 0 0 0'. He also fixed a
segfault if not enough args are specified and fixed the code so that the
generated `fibonacci.c` actually works; before it just printed `0` over and over
again (since it did not work anyway a segfault prevention was added here). He
also fixed some array addressing (some of which might not be strictly necessary
but as he was testing the `fibonacci.c` bug he ended up changing it anyway).

Finally he changed this program to use `fgets()` not `gets()` to make it safer
and to prevent a warning about `gets()` at linking or runtime. Since this
program is so incredible the extra fixes were deemed worth having and this is why
it was done.

Cody disabled a warning in the Makefile that proved to be a problem only with
clang in linux but which was defaulting to an error. This way was the simplest
way to deal with the problem in question due to the way the entry works.

Yusuke pointed out that `atof` nowadays needs `#include <stdlib.h>` which was
used in order to get this to work initially (prior to this output was there but
incomplete).

## [1990/stig](1990/stig/stig.c) ([README.md](1990/stig/README.md))

Cody fixed the paths in the Makefile so that this would build in linux (it
worked fine in macOS).


## [1990/westley](1990/westley/westley.c) ([README.md](1990/westley/README.md]))

Cody fixed this for modern systems. It had `1s` in places for a short int which
was changed to just `1`.  Since it's instructional to see the differences he has
provided an alternate version, [westley.alt.c](1990/westley/westley.alt.c) which
is the original code.


## [1991/brnstnd](1991/brnstnd/brnstnd.c) ([README.md](1991/brnstnd/README.md]))

Cody fixed this for modern systems. There were two invalid operands to binary
expression (`char *` and `void` and `int` and `void`) to resolve and
additionally a mis-feature of the C pre-processor which no longer works had to
be changed as well in order to get this to compile. In particular the macro `C`,
defined as `C =G` to make `+=` and similar operators no longer works.  The
invalid operands to binary expressions were resolved with the comma operator.


## [1991/dds](1991/dds/dds.c) ([README.md](1991/dds/README.md]))

Cody fixed a segfault that prevented this entry from working in any condition
and he also made an [alternate version](1991/dds/dds.alt.c) that works with
`clang`. The alternate code, described in the README.md file, is what is needed
for clang.  Reading it might be instructive even if you have gcc.


## [1991/westley](1991/westley/westley.c) ([README.md](1991/westley/README.md]))

Cody fixed a segfault in this program which prevented it from working. The
problem was that the read-only char array `char *z[]` was being written to. The
fix was to change it to `char z[][100]` in two spots (see if you can determine
why two places, not one!). Why 100 when the longest string is < 100? Because a
shorter value caused strange output and it's easier to just choose a larger
value that works without having to find the correct value.


## [1992/adrian](1992/adrian/adrian.c) ([README.md](1992/adrian/README.md]))

Cody changed the location that it used `gets()` to be `fgets()` instead to make
it safer and to prevent annoying warnings during compiling, linking or runtime
(interspersed with the program's output).

Later Cody improved the change to `fgets()` to make it slightly more like the
original. This still requires the additional stripping of the newline inside the
loop but now it uses what looks like before, just a call to `gets()`.

One might think that simply changing the gets() to fgets() (with stdin) would
work but it did not because `fgets()` stores the newline and `gets()` does not.
The code was relying on not having this newline. With `fgets()` the code
`if(A(Y)) puts(Y);` ended up printing an extra line which made the generation of
some files (like `adhead.c`) fail to compile. Why? There was a blank line after
a `\` at the end of the first line of a macro definition!  Thus the code now
first trims off the last character of the buffer read to get the same correct
functionality but in a safe way and non obnoxious way.

But the improvement so that it uses `gets()` could not be changed to have the
macro do the removal of the extra line (as in with a comma operator or a `&&`)
as this caused compilation errors with another generated file (`adwc.c`). Thus
after the `gets()` call in the line that looks like:

```c
while( gets(Y) ){ Y[strlen(Y)-1]='\0'; if(A(Y)) puts(Y); }
```

one must keep the `Y[strlen(Y)-1]='\0';` part and keep it there.

This is a complex change due to the way the program and Makefile generate
additional tools.


## [1992/gson](1992/gson/gson.c) ([README.md](1992/gson/README.md]))

Cody changed the buffer size in such a way that `gets()` should be safe
(theoretically) as it comes from the command line (though it can also read input
from stdin after starting the program). Ideally `fgets()` would be used but this
is a more problematic.  Previously it had a buffer size of 256 which could
easily overflow. In this entry `gets()` is used in a more complicated way:
first `m` is set to `*++p` in a for loop where `p` is argv. Later `m` is set to
point to `h` which was of size \256. `gets()` is called as `m = gets(m)`) but
trying to change it to use `fgets()` proved more a problem. Since the input must
come from the command line Cody changed the buffer size to `ARG_MAX+1` which
should be enough (again theoretically) especially since the command expects
redirecting a dictionary file as part of the command line. This also makes it
possible for longer strings to be read (in case the `gets()` was not used in a
loop).


## [1992/kivinen](1992/kivinen/kivinen.c) ([README.md](1992/kivinen/README.md]))

It was observed that on modern systems this goes much too quick. Yusuke created
a patch that calls `usleep()` but Cody thought the value was too slow so he made
it a macro in the Makefile `Z`, defaulting at 15000. You can reconfigure it
like:

```sh
make clobber Z=1000 all
```

This was not made an alternate version because it moves so fast that it's nigh
impossible to use otherwise.

Yusuke also noted that there is a bug in the program where right after starting
it moves towards the right but if you click the mouse it goes back.


## [1992/lush](1992/lush/lush.c) ([README.md](1992/lush/README.md]))

Yusuke supplied a patch which makes this work with gcc. Due to how it works (see
Judges' remarks in the README.md file) this will not work with clang.

Cody also provided the `runme.sh` script to demonstrate it as using make was
problematic.

Cody made it use `fgets()` instead of `gets()` to prevent annoying warnings
getting in the way (in linux linking in a binary with `gets()` produces a
warning that might get in the way with this entry and in macOS at runtime it
prints a warning which often is interspersed with the output of the program
which can be confusing) and also added the `runme.sh` script to demonstrate it
(using make was problematic). Cody notes that unfortunately this does not work
with clang due to different compiler messages.

Cody later improved the `fgets()` change to look more like the original i.e. it
now uses a redefined `gets()`. This did require modifying the line number with
`#line 1` under the macro `gets()`.

Still this cannot work with clang due to different compiler messages. See
[bugs.md](/bugs.md) for details.

## [1992/nathan](1992/nathan/nathan.c) ([README.md](1992/nathan/README.md))

Cody added the original file back as it was deemed that the export restrictions
should no longer be a cause of concern for this entry. Doing this did require a
change to Cody's [2020/ferguson2](2020/ferguson2/README.md) entry as it's
referenced.

Cody cynically noted that if he goes quiet, for instance if he no longer
participates in the IOCCC, that it must be our fault! :-)


## [1992/westley](1992/westley/westley.c) ([README.md](1992/westley/README.md]))

Cody fixed this to work for clang by changing the third and fourth arg of
`main()` to be `char **` inside `main()`; clang requires args 2 - 4 to be `char
**` and some versions do not even allow a fourth arg.

He also added the alternate version that the author gave in the remarks that is
specifically for the USA rather than the world.

NOTE: as noted in the README.md file and the [bugs.md](/bugs.md), this program and the
[alternate version](1992/westley/westley.alt.c) will very likely crash or
[nuke](https://en.wikipedia.org/wiki/Nuclear_weapon) the [entire
world](https://en.wikipedia.org/wiki/Earth) or just the
[USA](https://en.wikipedia.org/wiki/United_States), respectively, without enough
args (2). And not that we need the help or anything for this :-) but we do
encourage you to test this :-) This should NOT be fixed.


## [1993/jonth](1993/jonth/jonth.c) ([README.md](1993/jonth/README.md]))

Both Cody and Yusuke fixed this so that it will work with modern systems. Yusuke
provided some fixes of the X code and Cody fixed the C pre-processor directives
so that it would compile. It used to be that you could get away with code like:

```c
G        int i,j
K        case
```

and expect `G;` to equate to `int i, j;` (though it's now a long) and `K` to mean
`case` but that's no longer the case so the offending lines had `#define`
prepended to them.


## [1993/leo](1993/leo/leo.c) ([README.md](1993/leo/README.md]))

Cody fixed this to work with modern compilers. This involved different header
files for functions.


## [1993/lmfjyh](1993/lmfjyh/lmfjyh.c) ([README.md](1993/lmfjyh/README.md]))

Cody added an [alternate version](1993/lmfjyh/lmfjyh.alt.c) which does what the
program did with gcc < 2.3.3. See the README.md file for details and for why
this was made the alternate version, not the actual entry.


## [1993/plummer](1993/plummer/plummer.c) ([README.md](1993/plummer/README.md]))

Cody added an [alternate version](1993/plummer/plummer.alt.c) which uses
`usleep()` so you can see what is happening with faster systems. See the
README.md files for details.


## [1993/rince](1993/rince/rince.c) ([README.md](1993/rince/README.md]))

Yusuke supplied a patch to get this to work in modern systems.

Cody provided an alternate version to simplify slowing the game down. This was
based on our suggestion that it might be desired to slow down but done in a way
that makes it easy to configure at compile time. See the README.md for details.


## [1993/schnitzi](1993/schnitzi/schnitzi.c) ([README.md](1993/schnitzi/README.md]))

Cody made this use `fgets()` not `gets()` to make it safer and to prevent an
annoying warning with compiling and/or linking and/or runtime, the latter of
which is unfortunately interspersed with the output of the program itself.

Cody later improved the fix to use `gets()` via a macro so that it looks like
the original code.

## [1993/vanb](1993/vanb/vanb.c) ([README.md](1993/vanb/README.md]))

Cody fixed this to work with clang. The problem was that the third arg to main()
was not a `char **`. Instead `O5()` (which was `main()`) is now its own function
which main() calls with the right parameters.


## [1994/ldb](1994/ldb/ldb.c) ([README.md](1994/ldb/README.md]))

Cody fixed this so it would compile and work with modern compilers. The problem
was that `srand()` returns void but it was used in a `||` expression. Thus the
comma operator was needed.

Cody also fixed it for clang under linux which objected to incompatible pointer
type (because `time(2)` takes a `time_t *` which in some systems is a `long *`
but what was being passed to it is an `int`).

Cody also changed the entry to use `fgets()` instead of `gets()` to make it safe
for lines greater than 231 in length and to prevent a warning at linking or at
runtime, the latter of which can be interspersed with output of the program.
Note that this now prints a newline after the output but this seems like a
worthy compromise for preventing the interspersed output in macOS and at the
same time it's safer (fixing it to not have the extra newline is more
problematic than it's worth and in macOS another line of output would be shown
without the change anyway and the difference is that now it's just a blank line
rather than an annoying warning).

A subtlety about this fix: if a line is greater than 231 in length if the
program chooses that line it might print the first 231 characters or it might
print (up to) the next 231 characters and so on.


## [1994/shapiro](1994/shapiro/shapiro.c) ([README.md](1994/shapiro/README.md]))

Cody fixed a bug on systems where `EOF != -1`. The problem is that `getc()` and
the related functions do not return `-1` on EOF or error but rather `EOF`.
However `EOF` is not required to be `-1` but merely an int < 0 and this program
assumed that `getc()` will return `-1` on EOF or error, not `EOF`. On systems
where `EOF != -1` it could result in an infinite loop.

For an interesting problem that occurred here and what was done to solve it,
check the [bugs.md](bugs.md) file.


## [1994/westley](1994/westley/westley.c) ([README.md](1994/westley/README.md]))

Cody converted the spoiler compiler options (provided by the author) to be
compiler commands and added a script [spoiler.sh](1994/westley/spoiler.sh) to
automate the spoiler commands to make it easier to see the game in action.


## [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md]))

Cody fixed this so that it would work with macOS. Once it could compile it
additionally segfaulted under macOS which he also fixed.  Cody also provided the
[Alternate code](1995/cdua/cdua.alt.c) for fun :-) ) (in particular to make it
easier to see the program do what it does in systems that are too fast ... if
there is such a thing anyway :-) ). See the README.md for details on this.




## [1995/garry](1995/garry/garry.c) ([README.md](1995/garry/README.md]))

Cody fixed this so that it will compile with modern compilers. The problem was a
missing `int` for the `f` variable. He felt it was even more important that it
works because the layout does indeed look to him like a rat is dropping core :-),
something that the judges suggested.

## [1995/makarios](1995/makarios/makarios.c) ([README.md](1995/makarios/README.md))

Cody fixed this so that it will compile with versions of clang that has a defect
which only allows `main()` to have 0, 2 or 3 args. This is done by a new
function (`pain()` as it's annoying that clang is this way :-) ) that main()
calls which has the four args.

## [1996/august](1996/august/august.c) ([README.md](1996/august/README.md]))

Cody fixed a segfault in this program that prevented it from working right but
he notes it hangs in macOS. This is because some compilers compile it into an
infinite loop and this was documented by the judges. It works fine in linux if
using gcc but macOS, having only clang by default (even the gcc binary
`/usr/bin/gcc`) will not work.


## [1996/dalbec](1996/dalbec/dalbec.c) ([README.md](1996/dalbec/README.md]))

Cody proposed a fix for this to compile with clang and Landon implemented it
after some discussion. The reason Cody did not do it is because he thought it
was the wrong output but as it happens the try section below was worded a bit
confusingly. He looked at Yusuke's] analysis found
[here](https://mame-github-io.translate.goog/ioccc-ja-spoilers/1996/dalbec.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp)
but he missed that Yusuke added a '...' after the result which made him think
the fix was wrong. Cody also made the recommended change of the author to make
it so that each number is printed on a line by itself rather than having a long
string of numbers on the same line. This was not put in an alternate version but
perhaps it should be.


## [1996/eldby](1996/eldby/eldby.c) ([README.md](1996/eldby/README.md]))

Cody provided an [alternate version](1996/eldby/eldby.alt.c) which uses
`usleep()` in between writing the output to make it easier to see what is going
on with faster systems and importantly also for those who are sensitive to text
flashing by rapidly (it affects him too but he also thinks it moves too fast
nowadays anyway).


## [1996/gandalf](1996/gandalf/gandalf.c) ([README.md](1996/gandalf/README.md]))

Cody fixed this to compile and work with modern systems. As he loved the
references in the code that could not compile he just commented out as little as
possible to get this to compile.

## [1996/jonth](1996/jonth/jonth.c) ([README.md](1996/jonth/README.md]))

Cody fixed this to not segfault under macOS. The problem was that the function
pointer `w`, which points to `XCreateWindow()`, did not specify the parameters of
the function in the pointer assignment.


## [1996/westley](1996/westley/westley.c) ([README.md](1996/westley/README.md]))

Cody fixed a segfault in this entry as well as it displaying environmental
variables.  Although the scripts showed correct output, it somewhat lessened the
usability because they segfaulted and showed (an) environmental variable,
interspersed with the output of the program. With the fix they no longer have
this problem. If `argc < 5` (`argv[4]` is referenced) it will not do anything
and it will not segfault either - this was caused by the body of the for() loop
which is now empty (it doesn't appear to be needed at all at least modernly).
Note that you should check the [westley.alt.c](1996/westley/westley.alt.c) file
when reading the author's comments. To see how to use the original, see the
README.md file.


## [1998/chaos](1998/chaos/chaos.c) ([README.md](1998/chaos/README.md]))

Cody added a call to `endwin()` to restore terminal sanity (echo etc.) when
exiting the program.

## [1998/fanf](1998/fanf/fanf.c) ([README.md](1998/fanf/README.md))

Cody fixed this for Linux. The problem was the intermediate steps to get to the
final code that is compiled. The entry itself is what was essentially what used
to be compiled. Now it works with both Linux and macOS (and BSD?).


## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md]))

Cody fixed invalid data types which prevented this entry from working, causing a
segfault. This showed itself in two parts which required two fixes, one for
linux and further changes for macOS. He also fixed a segfault (after printing
garbage) when the arg specified evaluated to 0. It was decided that these
segfault fixes should be made because the program is so beautiful.

## [1998/schweikh1](1998/schweikh1/schweikh1.c) ([README.md](1998/schweikh1/README.md]))

Cody fixed this for modern systems (it did not work at all). He also made it so
that if a file fails to open it does not return but rather skips the reading of
the file. Without this fix the entry did not work.

What was wrong? The call to `freopen()` was incorrect with the second arg (the
mode) being instead `5+__FILE__`. It now is `"r"`. There was also a call to
`fopen()` that was wrong where the mode was instead `44+__FILE__`. Interestingly
enough though this did not seem to be an issue though I cannot explain why. He
notes that it works fine with `clang` as well as `gcc` (which is what is used
but in macOS - see below for alternate code - `gcc` is clang).

Additionally Cody provided an alternate version for macOS. The fix is
rather complicated but very interesting. See the README.md file for details on
how it works and how to use it.


## [1998/schweikh2](1998/schweikh2/schweikh2.c) ([README.md](1998/schweikh2/README.md]))

Cody fixed the code to not trigger an internal compiler error in gcc:

```
:10:16: warning: type defaults to 'int' in declaration of 'zero' [-Wimplicit-int]
: In function 'main':
:12:1: warning: missing terminating " character
:12:19: internal compiler error: invalid built-in macro "__FILE__"
```

The string `"01\015"` had to be changed to `ONE(O(1,1,2,6,0,6))`.


## [2000/anderson](2000/anderson/anderson.c) ([README.md](2000/anderson/README.md]))

Cody changed this entry to use `fgets()` instead of `gets()` to make it safer
and to prevent annoying warnings from showing up at compiling, linking and/or
runtime, the latter interspersed with the output of the program.

Cody later improved the fix to use `gets()` by redefining `gets()` so that the
code looks like before.

## [2000/briddlebane](2000/briddlebane/briddlebane.c) ([README.md](2000/briddlebane/README.md]))

Cody fixed this to compile in systems that require one to explicitly link in
`libm`.


## [2000/dlowe](2000/dlowe/dlowe.c) ([README.md](2000/dlowe/README.md]))

Cody fixed this to compile with more recent perl versions; the symbol that's now
`PL_na` was once `na`. He notes that this entry crashes under macOS but it works
under linux after this change.


## [2000/jarijyrki](2000/jarijyrki/jarijyrki.c) ([README.md](2000/jarijyrki/README.md]))

Cody made it easier to compile this in some cases by adding `X11/` to the
includes of `Xlib.h` and `keysym.h`.


## [2000/natori](2000/natori/natori.c) ([README.md](2000/natori/README.md]))

Cody fixed this for modern compilers. Depending on the compiler it would either
segfault when run or not compile at all (gcc and clang respectively).

Cody also provided alternate code that supports the southern hemisphere.


## [2000/thadgavin](2000/thadgavin/thadgavin.c) ([README.md](2000/thadgavin/README.md]))

Cody fixed the code and added an appropriate make rule so that the SDL version
works independent from the curses version (using the same code).

To see the craziness of the SDL fix (because of a terrible design choice of the
SDL1 developers) see the log for commit
dd0b26b5d6325e8b6fdef1232156c8bb8c66613f. Be prepared for a surprise!

Cody also added an alternate version to help see what is going on in more modern
systems and in case you're sensitive to rapidly moving swirling. See the
README.md for details on that. Note that this alternate version only will impact
the curses and the SDL versions as Cody does not have a DOS system to test the
other version in.


## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md]))

Cody fixed both the supplementary program and the program itself (both of which
segfaulted and once that was fixed only the binary was modified; it was not run
but according to the author's remarks it should be executed). He managed to do
this with linux but it will not work with macOS Catalina (10.15). See
[bugs.md](/bugs.md) for why this is); _this is **not** a bug, it's a feature_
inherent in what it does!

Below is what it took to fix.

- `#include <sys/mman.h>` for `mmap()` and `munmap()`.
- have `main()` call another function which is no longer a recursive function;
this prevented `main()` from entering an infinite recursive loop.

Without these it would crash and prevent modification of the 32-bit
[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) (not elf :-) )
binary. But again see [bugs.md](/bugs.md) here.

These also had to be done:

- when `open()`ing the file the file descriptor had to be saved so it could be
closed prior to executing the program.
- `munmap()` also had to be called prior to executing the program.

Without those changes the program was not executed after modification which it
was supposed to do, instead reporting text file busy error.

Notice that the location of the calls to `munmap()` and `close()` followed by
`execv()` _does matter_!

To get this to compile with clang, `main()` had to change from:

```c
main (char *ck, char **k)
```

to:

```c
int main (int cka, char **k) { char *ck = (char *)cka; /* ... */ }
```

The following change was also made to be more portable, in case the constants
`PROT_READ` and/or `PROT_WRITE` are not standardised:

Change `3` in the call to `mmap()` to be `PROT_READ|PROT_WRITE`: just in case
`PROT_READ|PROT_WRITE` does not equal 3 (though it seems to be equal in both
macOS and linux).

NOTE: there might be educational value to see the progress of this fix; if you
wish to see, try the following commands from the `2001/anonymous` directory:

```sh
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..93aa8d79f208dcccc3c5a2370a727b5cf64e9c53 anonymous.c
git diff 93aa8d79f208dcccc3c5a2370a727b5cf64e9c53..c48629017117379a52b1a512ef8f2593ca9569c8 anonymous.c
git diff c48629017117379a52b1a512ef8f2593ca9569c8..efdee208a2bc650256637b9357ddfd0de82d2f41 anonymous.c
git diff efdee208a2bc650256637b9357ddfd0de82d2f41..e9a3f77ea3b209e63ac3f9c06bb84ad86e5ea706 anonymous.c
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..2159caec4677e0f25ad704a74e04c8196fd6c343 anonymous.c
git diff 2159caec4677e0f25ad704a74e04c8196fd6c343..4bc03de321612869aebf855850c6500df95cb6ef anonymous.c
```

Finally to see from start to finish:

```sh
git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..4bc03de321612869aebf855850c6500df95cb6ef anonymous.c
```

Cody also added a [program](anonymous.bed.c) like [anonymous.ten.c](anonymous.ten.c)
[Ten Green Bottles](https://en.wikipedia.org/wiki/Ten_Green_Bottles) but which
sings [Ten in the Bed](https://allnurseryrhymes.com/ten-in-the-bed/).


## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md]))

Cody fixed this to compile with clang but according to the author this will not
work without i386 linux. It generates i386 32-bit code (not bytecode) but
unfortunately it will not work without i386 linux. Cody fixed an earlier
segfault so that it can at least now open the file and he also changed some of
the macros used to what they translate to but mostly it was kept the same.
Yusuke added another change (see below) to make it even more portable across
compilers besides what Cody did.


Cody also fixed the [supplementary
bellard.otccex.c](2001/bellard/bellard.otccex.c) so it does not segfault and
works as well. The main problem was that some ints were being used as pointers.
This includes, for example, an int used as a `char *`, an int used as a function
pointer and an int to access `argv` as well as there being invalid access to
`argv`. He updated the Makefile so that this program will compile by default.

Also the Fibonacci sequence (`fib()`) will overflow at `n > 48` so this is
checked prior to running the function just like the author did for the factorial
(overflowing at `>12`). Either way unfortunately this entry seems to not work in
64-bit linux or macOS. See below portability notes as well as another fix in
this entry by Yusuke.

## Portability notes:

With a tip from Yusuke we rediscovered the author's [web page for this
program](https://bellard.org/otcc/) where it is stated that this will only work
in i386 linux.  The author also stated in the remarks in this document that they
used [gcc
2.95.2](https://ftp.gnu.org/gnu/gcc/gcc-2.95.2/gcc-everything-2.95.2.tar.gz) but
we don't know if that's relevant or not.

Yusuke offered a modification which is not needed with gcc but with some
versions of `clang` it is. With `gcc` we can get away with `-rdynamic -fno-pie
-Wl,-z,execstack` which solves the problem of execution in memory but any
compiler that does not support this would not work. Thus we use the modification
by Yusuke.


## [2001/cheong](2001/cheong/cheong.c) ([README.md](2001/cheong/README.md]))

Cody fixed this to work with clang by adding another function that is allowed to
have a third arg as an int, not a `char **`. He chose pain() because it's a four
letter word that would match the format and because it's pain that clang forces
this. :-) This fix makes a point of the author's notes on portability no longer
valid, btw.


## [2001/coupard](2001/coupard/coupard.c) ([README.md](2001/coupard/README.md]))

Cody fixed this to compile with clang in linux. The problem was C99 does not
support implicit int:

```c
coupard.c:31:10: error: parameter 'h' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
void e(n,h){
         ^
coupard.c:31:8: error: parameter 'n' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
void e(n,h){
       ^

```

One fix would be to disable that warning. Another one might be to change the C
standard. The one that was done, to make it more portable, was to just add 'int'
to the function parameters.

Thanks go to Yusuke for providing a proper command line for macOS (to do with
sound; see his [/2013/endoh3/README.md](2013/endoh3/README.md) entry where he
also refers to sound devices in macOS).


## [2001/ctk](2001/ctk/ctk.c) ([README.md](2001/ctk/README.md]))

The ANSI escape codes were no longer valid but Yusuke provided a patch to fix
the ANSI escape codes. This works with macOS as well.


## [2001/dgbeards](2001/dgbeards/dgbeards.c) ([README.md](2001/dgbeards/README.md]))

The author provided two changes: one to speed it up and one to make it not crash
on losing. Cody provided an alternate version which does the former but he felt
that the idea of crashing on losing (see the README.md for details on why that
might be) he kept that in.

He also points out that there is a way to get the computer to automatically lose
very quickly and he also points out that there is a flaw in the alternate
version that the author did not note. Do you know what these are?

## [2001/herrmann1](2001/herrmann1/herrmann1.c) ([README.md](2001/herrmann1/README.md]))

Cody fixed this so that the when compiling the code the program is not executed
itself by itself which just showed the usage string and exited. The [script
herrmann1.sh](2001/herrmann1/herrmann1.sh) is used to compile the program but
it's also how you invoke the program. 

He also fixed the [script herrmann1.sh](2001/herrmann1/herrmann1.sh) for
shellcheck. In particular there were quite a few:


```
SC2086 (info): Double quote to prevent globbing and word splitting.
SC2248 (style): Prefer double quoting even when variables don't contain special characters.
```

errors/warnings.

## [2001/herrmann2](2001/herrmann2/herrmann2.c) ([README.md](2001/herrmann2/README.md]))

Cody fixed this to work with both 64-bit and 32-bit compiles by changing most of
the `int`s (all but that in `main`) to `long`s. He also fixed it to compile with
clang by changing the args of main to be `int` and `char **` respectively and
changing specific references to the `argv` arg, casting to `long` (was `int` but
the 64-bit fix requires `long`) which was its old type. The original file, used
for demonstration purposes, as well as if you want to see if your system works
with the original code, is the alternate version. See the README.md for details.


## [2001/kev](2001/kev/kev.c) ([README.md](2001/kev/README.md]))

Cody slowed down the ball just a tad as it went too fast for the speed at which
the paddles move even when holding down the movement keys.

Cody also provided an alternate version which lets you use the arrow keys on
your keyboard instead of the more awkward '`,`' and '`.`'.


## [2001/westley](2001/westley/westley.c) ([README.md](2001/westley/README.md]))

Cody added the script [westley.sh](westley.sh) to automate a heap of commands
that we, the IOCCC judges, suggested, as well as some additional ones that he
thought would be fun.  He also provided the sort and punch card versions that he
added, described in the README.md, based on the author's remarks.

## [2004/arachnid](2004/arachnid/arachnid.c) ([README.md](2004/arachnid/README.md]))

Cody added an alternate version which allows those like himself used to `h`,
`j`, `k` and `l` movement keys to not get lost. Non rogue players, vi users and
Dvorak typists are invited to get lost (or use the original version)! :-)


## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md]))

Cody fixed this to compile with clang and also fixed it to work.

For clang the problem was that `main()` had one arg, a `char *` and this is not
allowed in any version of clang. To get it to work took numerous changes.

First the inclusion of `setjmp.h` was necessary. Without this `longjmp()`
implicitly returned int which was used for the purpose of binary expression but
this no longer worked.

But by including `setjmp.h` it naturally made the binary expressions invalid (as
it returns void which no longer is allowed in binary expressions) so the comma
operator with `0` (`,0`) had to be used (`,1` was tried first but this did not
work right).

`longjmp()` was being called with one arg which was an element
of an `int[4][1000]` which had to be changed to a `jmp_buf p[4]` (this due to
the prototype being included).

`main()` also called itself but this was a problem so it now calls another
function `poke()` which calls itself instead (this is sometimes necessary
nowadays).

Finally the optimiser cannot be disabled so the compiler flags were changed for
this.


## [2004/gavin](2004/gavin/gavin.c) ([README.md](2004/gavin/README.md]))

Yusuke provided the `kernel` and `fs.tar` files which can be used if you cannot
normally use this entry. Instead of generating the files just use the files
provided, found under the [img/](2004/gavin/img/) directory. Note that the
`img/fs.tar` extracts into `fs/` so you will have to fix the tarball; this is
done this way to prevent extraction from the entry directory overwriting the
files and causing `make clobber` to wipe some of them out.

## [2004/jdalbec](2004/jdalbec/jdalbec.c) ([README.md](2004/jdalbec/README.md))

Cody fixed this to compile with gcc (it worked with clang). The problem was the
cpp being unable to parse the generated code (see the README.md for details) and
this ended up with a number of errors like:


```c
jdalbec.c:64:5: error: stray '##' in program
   64 | B N##B (I) ; \
      |     ^~


..

jdalbec.c:65:5: error: stray '##' in program
   65 | V F##B (B) ; \
      |     ^~
jdalbec.c:65:5: error: expected ';' before 'B'
   65 | V F##B (B) ; \
      |     ^ ~
      |     ;
```

and various other problems.


## [2004/kopczynski](2004/kopczynski/kopczynski.c) ([README.md](2004/kopczynski/README.md]))

Cody reported that this entry cannot be optimised by the compiler if it's to
work. He also added the file [kopczynski-a](kopczynski-a) to demonstrate what
happens when art more like a letter is fed to the program.


## [2004/newbern](2004/newbern/newbern.c) ([README.md](2004/newbern/README.md]))

Cody and Landon individually fixed this to work with clang. Cody then turned the
second arg to main, which clang requires to be a `char **`, to be not the same
name as a function defined earlier in the code and to use that variable which
`main()` used.

## [2004/vik2](2004/vik2/vik2.c) ([README.md](2004/vik2/README.md))

Cody fixed this to compile in Linux. Although it compiled cleanly in macOS (and
BSD?) the code failed to compile at all in Linux due to:

```c
cc -E vik2_1.c > vik2_2.c
In file included from vik2.c:945,
                 from vik2.c:959,
                 from vik2.c:972,
                 from vik2.c:1025:
vik2.c:383:8: error: no macro name given in #ifdef directive
  383 | O  \
      |        ^
In file included from vik2.c:946:
vik2.c:383:8: error: no macro name given in #ifdef directive
  383 | O  \
      |        ^
In file included from vik2.c:947:
vik2.c:383:8: error: no macro name given in #ifdef directive
  383 | O  \
      |        ^
In file included from vik2.c:948:
vik2.c:383:8: error: no macro name given in #ifdef directive
  383 | O  \
      |        ^

...

In file included from vik2.c:182:

vik2.c:992:85: error: #include nested depth 201 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
  992 | I
      |                                                                                     ^
vik2.c:1497:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
vik2.c:1498:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
vik2.c:1499:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
vik2.c:1500:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
vik2.c:1501:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
vik2.c:1504:21: error: #include nested depth 200 exceeds maximum of 200 (use -fmax-include-depth=DEPTH to increase the maximum)
make: *** [Makefile:133: vik2] Error 1

```

Unfortunately the fix required heavy modification to the original file (see
below) and also inclusion of what used to be generated by the
[Makefile](2004/vik2/Makefile) and will, in Linux, give many warnings like:

```c
cc -std=gnu99 -Wall -Wextra -pedantic -Wno-strict-prototypes -Wno-implicit-function-declaration    -O3 -DFNAME='"vik2.c"' '-DSTOP=_5' vik2.c -o vik2
In file included from vik2.c:1002:
vik2_1.c: In function 'main':
vik2_1.c:1:3: warning: style of line directive is a GCC extension
    1 | # 1 "vik2.c"
      |   ^

...

```

(which does not show up in macOS) but now it at least works for both Linux and
macOS.

As for the fix itself it required changing the C pre-processor macros that
resulted in macros themselves like `#ifdef`, `#else` etc. to be `#ifdef`,
`#else` etc. and also the inclusion of the file [vik2_1.c](2004/vik2/vik2_1.c)
which used to be generated by the Makefile via `cc -E`. As one can see that file
has references to macOS things but this is not harmful in Linux. It might be
that those lines can be removed but there is no harm and since there are a lot
of it this has not been done (`vik2.c` has 1009 lines and `vik2_1.c` has 1555
lines!).


## [2005/aidan](2005/aidan/aidan.c) ([README.md](2005/aidan/README.md]))

Cody fixed the test script, described by the author in their remarks, to refer
to the proper compiled program (it's hardcoded). This had never been done and it
broke the script.


## [2005/anon](2005/anon/anon.c) ([README.md](2005/anon/README.md]))

The author stated that if `stty` does not work right on your system you can
compile it differently so that the program does not use `stty`.  Cody set this
up so that one need not update the [Makefile](Makefile). There's a fun command
that Cody provided, to try, to see a feature that the author implemented. See
the README.md for details.


## [2005/giljade](2005/giljade/giljade.c) ([README.md](2005/giljade/README.md]))

After Landon fixed the entry to compile with clang Cody noticed this does not
work at all in modern systems (see below). He fixed this to work and then he
later fixed the self-test feature.

The problem that was showing up is that with either optimising or if anything
but 32-bit (as in `-m32`) was used it would not work (at least in 64-bit
systems?). The optimising cannot be used still but it now works with both 32-bit
and 64-bit. The solution has to do with the size difference between `int` and
`long` so that the `long*E` is now `int*E`. This solves a specific problem for
linux (32-bit, 64-bit) and macOS (arm64).

To get the self-test feature to work it was required to remove from the code:

```c
O-b-f-u -s-c-a-t-e;
```

as it caused a compilation error in some of the generated code but served no
purpose, didn't affect the output of the puzzle and since the 'string' is
already in the code there is no problem omitting it.

`main()` was also changed to be in the old format:

```diff
-(B[h]=N-B,N= N+6);}main(int Z,char**Y ){char*U=Z ;
+(B[h]=N-B,N= N+6);}main(Z,Y )char**Y;{char*U=Z ;
```

Finally because clang has `-Werror` by default the program was changed to use
`make` and then `rm -f` on the output of the compiler instead. This change might
also not have been necessary if using different flags to `cc` but this felt
cleaner, somehow.



## [2005/jetro](2005/jetro/jetro.c) ([README.md](2005/jetro/README.md))

Cody added explicit linking of libm (`-lm`) for systems like linux that seem to
not do it implicitly (like macOS does).

## [2005/mikeash](2005/mikeash/mikeash.c) ([README.md](2005/mikeash/README.md))

Cody fixed this to work in linux. The problem was an unknown escape sequence,
`\N`, which caused a funny compiler error:

```c
};n b[2048];int i
mikeash.c: In function 'R':
mikeash.c:7:1: error: '\N' not followed by '{'
    7 | ;C!='\n';A()
      | ^
mikeash.c:7:1: error: incomplete universal character name \Ne
```

The problem was that in the string above there was a `\Newline` but this is
invalid C. This was changed to be `\nNewline` and then, because the code is
supposed to output itself when fed itself, the reference to `'N'` had to be
updated in both the string and the code to be `'n'`.

The array size of `c` was updated by 1 out of caution just in case as the array
is used to store at least part of the string.



## [2005/mynx](2005/mynx/mynx.c) ([README.md](2005/mynx/README.md]))

Cody fixed this so that the [configure](source/configure) script (which is not
needed but part of the entry) would work with compilers that have by default
`-Werror` like clang in macOS.

Cody also added the alt code which does scan for https. Futile, maybe, based on
how https is set up, in which case just enjoy it for what it was. But there
might be some command line that will let it work that way.

## [2005/toledo](2005/toledo/toledo.c) ([README.md](2005/toledo/README.md))

Cody fixed this to compile with some versions of clang which have an additional
defect where `main()` can only have 0, 2 or 3 args (it was 4). It now calls
another function that takes 4 args and which is what used to be `main()`.

The alternate versions were also fixed.


## [2006/birken](2006/birken/birken.c) ([README.md](2006/birken/README.md]))

Cody fixed a segfault in macOS with this entry. The problem was a missing `+1`
for strlen() with malloc(). This prevented it from working.


## [2006/borsanyi](2006/borsanyi/borsanyi.c) ([README.md](2006/borsanyi/README.md]))

Cody fixed the Makefile under some systems where the `lpthread` was not
implicitly linked in.


## [2006/monge](2006/monge/monge.c) ([README.md](2006/monge/README.md]))

Cody pointed out that without SDL1 (**not** SDL2) this will not link because two
functions that are used were removed from SDL2. Since SDL1 is still available
and since changing the code to use SDL2 would be more complicated he decided to
change the Makefile to use `sdl-config` not `sdl2-config`. Nevertheless he
points out that the entry requires x86/x86_64 CPUs. Without it it might very
well segfault (for instance it segfaulted on his MacBook Pro with the M1 chip).


## [2006/night](2006/night/night.c) ([README.md](2006/night/README.md]))

As Cody is a lost :-) `vim` user he took the author's remarks to add support
back for arrow keys in the [alternate version](2006/night/night.alt.c).


## [2006/sloane](2006/sloane/sloane.c) ([README.md](2006/sloane/README.md]))

Cody fixed this entry to work with clang which has a defect with the args to
`main()`: it requires specific types: `int` and `char **` for the first and
latter args. 

Curiously, although clang requires the types of args to be strictly
correct it allows for only one arg which Cody made it as the second arg was not
used and this allows for a closer match to the original format of the entry.

He also made sure that the Makefile links in `libm` as not all systems do this by default.

Since the author suggested that the lack of certain `#include`s might break the
program in some systems he added `-include ...` to the Makefile as well.

The [alternate version](2006/sloane/sloane.alt.c), which allows one to see what
is going on in modern systems, and which we recommend one use _first_, was
provided by Cody.


## [2006/toledo2](2006/toledo2/toledo2.c) ([README.md](2006/toledo2/README.md]))

Cody fixed a segfault in this program which was making it fail to work under
macOS - it did not seem to be a problem under linux, at least not fedora. The
problem was wrong variable types - implicit `int`s instead of `FILE *`s. It now
works with both macOS and linux.


## [2006/toledo3](2006/toledo3/toledo3.c) ([README.md](2006/toledo3/README.md]))

Cody fixed a crash and a display problem in this entry so that it now works in
modern (64-bit) systems.  The crash appears to only occur in macOS but the fix
lets it work in both linux and macOS. The problem was that it relied on 32-bits
so some `int`s were changed to `long`s. The display problem might or might not
have been a problem in linux with the old `int`s but this is no longer known.

## [2011/goren](2011/goren/goren.c) ([README.md](2011/goren/README.md]))

Cody fixed this for macOS.  Before the fix it segfaulted. It worked fine under
linux. After fixing it it was noticed that the author stated it does not work
for 64-bit so it was then tested as a 32-bit binary (linux) and 64-bit binary
(linux, macOS) and both work. It was fixed by changing some `int`s to `long`s
and now it does work with 64-bit systems as well as 32-bit systems.

Cody added the following words of wisdom: 'this is not a pipe'.


## [2011/richards](2011/richards/richards.c) ([README.md](2011/richards/README.md]))

Cody fixed a minor problem that showed up in both linux and macOS. He notes
however that as of this time this entry does not work properly with macOS. See
[bugs.md](/bugs.md) for more details.


## [2011/vik](2011/vik/vik.c) ([README.md](2011/vik/README.md]))

Cody, though he feels slightly sick :-), added a version for Windows based on
the author's comments (along with looking up the function for the right header
file). To build try the alt rule of the Makefile.

## [2012/blakely](2012/blakely/blakely.c) ([README.md](2012/blakely/README.md))

Cody added explicit linking of libm (`-lm`) as not all systems do this
implicitly (linux doesn't seem to but macOS does).

## [2012/endoh1](2012/endoh1/endoh1.c) ([README.md](2012/endoh1/README.md))

Cody added explicit linking of libm (`-lm`) as not all systems do this
implicitly (linux doesn't seem to but macOS does).


## [2012/kang](2012/kang/kang.c) ([README.md](2012/kang/README.md]))

Cody changed the code to accept the proper German for four 'vier' where before
it was spelt with the sound of V (fier not vier). But was this a bug or a
feature? He's on the fence here but he went ahead and did it anyway as it seems
useful and not having it fixed somewhat lessens the usability, especially for
those who know German and expect it to be 'vier' :-)


## [2012/vik](2012/vik/vik.c) ([README.md](2012/vik/README.md]))

Based on the author's description it should be able to get this entry to work
for Windows. With his instructions Cody added the alternate version that does
this for the few who might use Windows.

We're not sure whether we want to thank Cody or not for this :-) and he's not
sure if he wants to be thanked either :-) but we appreciate it nonetheless.


## [2013/birken](2013/birken/birken.c) ([README.md](2013/birken/README.md]))

Along with the [demo.sh](2013/birken/demo.sh) that he added, Cody also added an
alternate version which allows one to control how fast the painting is done,
based on the author's recommendations, except that Cody made it configurable at
compile time just like he did with other entries (in all but one it was
alternate code) that use `usleep()`. The alternate version and the original
version were swapped in the `To build`, `To run` and `Try` sections, with what
is normally `Alternate code` being `Original code`.


## [2013/cable3](2013/cable3/cable3.c) ([README.md](2013/cable3/README.md]))

Cody fixed this to compile with modern systems. The problems were that
`localtime()` is used differently and `time.h` being included (with SDL2 in
macOS - but see below) there was a conflicting function type. This appeared to
be a problem with macOS and only when SDL2 was included (but which as noted next
it cannot be).

The other problem is that this entry uses SDL functions that were
removed from SDL2 so the Makefile has to use `sdl-config` and not `sdl2-config`.
This meant that at one point to be strictly technical, the removal of
`localtime()` wasn't necessary but this change was left in place anyway.

Later on in an updated macOS (problem discovered in macOS Sonoma) the entry
failed to compile again also due to `localtime()` so the prototype was
completely removed to solve the problem.

He also slightly improved the `runme` script to not assume that the program has
been compiled by running `make clobber all || exit 1`.


## [2013/hou](2013/hou/hou.c) ([README.md](2013/hou/README.md))

After the file 2013/hou/doc/example.markdown was moved to
[2013/hou/doc/example.md](2013/hou/doc/example.md) to match the rest of the repo
this broke `make` which Cody fixed.

## [2013/morgan1](2013/morgan1/morgan1.c) ([README.md](2013/morgan1/README.md))

Cody added explicit linking of libm (`-lm`) as not all systems do this
implicitly (linux doesn't seem to but macOS does).


## [2014/maffiodo1](2014/maffiodo1/maffiodo1.c) ([README.md](2014/maffiodo1/README.md]))

Cody fixed the build for this entry: it does not require SDL2 but SDL1 so there
were linking errors.


## [2015/endoh3](2015/endoh3/prog.c) ([README.md](2015/endoh3/README.md]))

Cody fixed this to compile with linux which was having a problem with duplicate
symbols of `main()`. The fix is through the option `-fcommon` which will let it
compile like it does with macOS.

Cody also made it easier to enjoy the theme of [Back to the
Future](https://en.wikipedia.org/wiki/Back_to_the_Future) using this entry by
simply typing `make back_to` or `make mullender`.


## [2015/hou](2015/hou/prog.c) ([README.md](2015/hou/README.md))

Cody added explicit linking of libm (`-lm`) for systems that do not do this
(linux doesn't seem to but macOS does).


## [2015/yang](2015/yang/prog.c) ([README.md](2015/yang/README.md]))

Cody fixed an unfortunate typo in the Makefile that was preventing some of the
files from compiling properly, trying instead to compile already compiled code.

He also added explicit linking of libm (`-lm`) for systems that do not do this
(linux seems to not but macOS does).

## [2018/bellard](2018/bellard/prog.c) ([README.md](2018/bellard/README.md))

Cody added explicit linking of libm (`-lm`) for systems that do not do this
(linux doesn't seem to but macOS does).

## [2018/ferguson](2018/ferguson/prog.c) ([README.md](2018/ferguson/README.md))

Cody, with irony well intended :-), fixed the [test.sh
script](2018/ferguson/test.sh) for portability, shellcheck, making it executable
and other things, fixed dead links in the man page, updated the test-strings.txt
file and other things as well.

Landon notes that Cody will probably never finish changes in his entries and
that's probably true: let's just say that for the IOCCC I'm (Cody) a weasel! :-)
(but isn't that kind of the point ? :-) )

## [2018/hou](2018/hou/prog.c) ([README.md](2018/hou/README.md))

Cody added explicit linking of libm (`-lm`) for systems that do not do this
(linux doesn't seem to but macOS does).


## [2019/burton](2019/burton/prog.c) ([README.md](2019/burton/README.md]))

Cody fixed the Makefile which had a bad character, a '%' instead of a '$' which
caused a rule to fail.


## [2019/ciura](2019/ciura/prog.c) ([README.md](2019/ciura/README.md]))

Cody fixed invalid bytes error in `tr` in the scripts. He notes that at least on
his systems (macOS and fedora linux) the alternative languages do not work.
Perhaps that is the wrong locale or it's unable to come up with perfect pangrams
but one will not get errors now (it did not work before the fixes either).


## [2019/diels-grabsch1](2019/diels-grabsch1/prog.c) ([README.md](2019/diels-grabsch1/README.md]))

Cody made the author's statement that the entry compiles cleanly true by fixing
`warning: a function declaration without a prototype is deprecated in all
versions of C ` (in main()). Not strictly necessary but if he's making fixes he
might as well.


## [2019/diels-grabsch2](2019/diels-grabsch2/prog.c) ([README.md](2019/diels-grabsch2/README.md]))

Cody made the author's statement that the entry compiles cleanly true by fixing
`warning: a function declaration without a prototype is deprecated in all
versions of C` (in main()). Not strictly necessary but if he's making fixes he
might as well.

## [2019/dogon](2019/dogon/prog.c) ([README.md](2019/dogon/README.md))

Cody added explicit linking of libm (`-lm`) for systems that do not do this
(linux does not seem to but macOS does).

He also fixed the Makefile so that it compiles with clang in linux.

## [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md]))

As this is a backtrace quine having the optimiser enabled is not a good idea so
Cody disabled it. For this same reason he also added the `-g` flag to the
compilation as debugging symbols might just be useful for an entry that's
supposed to segfault :-)

## [2019/poikola](2019/poikola/prog.c) ([README.md[(2019/poikola/README.md))

Cody added a missing rule to the Makefile.

## [2019/karns](2019/karns/prog.c) ([README.md](2019/karns/README.md]))

Cody reported that with `-O` level > 0 this program segfaults (sometimes?). He's
not sure why as it worked fine before on the same systems tested but `-O0`
appears to fix the problem in both macOS and linux. Perhaps this is the problem
that the author reported where it sometimes segfaults but Cody did not try
debugging it since it works with `-O0`.

He also added the script [demo.sh](2019/karns/demo.sh) to showcase the entry a
bit more easily.

## [2020/ferguson2](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))

Cody, with intentional irony here :-), fixed formatting, links and typos in
various files.

He improved the [termcaps.c test utility](2020/ferguson1/termcaps.c), bug fixed
[play.sh](2020/ferguson1/play.sh), fixed other scripts and the Makefile, changed
some files to be markdown (and fixed problems that he caused in doing so :-) ),
fixed typos and formatting and he also fixed some issues that occurred when
files were renamed to `.md` from `.markdown`.

Most importantly he also added some corrections to the vital [Double
layered chocolate fudge cake recipe](2020/ferguson1/chocolate-cake.md) :-)

Yes the irony here is as rich as the chocolate cake: the question is do you know
how rich it is? If not and you like chocolate I (that is Cody :-) ) highly
recommend you give it a go! :-)

## [2020/ferguson2](2020/ferguson2/prog.c) ([README.md](2020/ferguson2/README.md))

Cody, with intentional irony here :-), fixed formatting, links and typos in
various files.

He also fixed some issues that occurred when files were renamed to `.md` from
`.markdown`.

Most importantly he also added some corrections to the vital [Double
layered chocolate fudge cake recipe](2020/ferguson2/chocolate-cake.md),
enciphered though it is :-)


## [2020/kurdyukov2](2020/kurdyukov2/prog.c) ([README.md](2020/kurdyukov2/README.md))

Cody added `-L`/`-I` paths to the Makefile to let this compile more easily if
the user has installed the appropriate library with
[MacPorts](https://www.macports.org) (with the default MacPorts prefix
`/opt/local`).
