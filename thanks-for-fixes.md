# Thanks for all the fixes

.. and thanks for all the fish.  :-)


## Thank you honor roll

There are a number of people who have contributed to several thousand changes,
fixes and important improvements and one who has literally (or numerically :-) )
contributed thousands, that we wish to thank.

We call out the extensive contributions of [Cody Boone
Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson) who is
responsible for most of the improvements and fixes including many **EXTREMELY
HARD bug fixes** like
[1988/phillipps](/thanks-for-fixes.md#1988phillipps-readmemd),
[1992/vern](/thanks-for-fixes.md#1992vern-readmemd),
[2001/anonymous](/thanks-for-fixes.md#2001anonymous-readmemd),
[2004/burley](/thanks-for-fixes.md#2004burley-readmemd) and
[2005/giljade](/thanks-for-fixes.md#2005giljade-readmemd), making entries like
[1985/sicherman](/thanks-for-fixes.md#1985sicherman-readmemd) and
[1986/wall](/thanks-for-fixes.md#1986wall-readmemd) not need `-traditional-cpp`
(all **EXTREMELY HARD**), fixing entries to work with clang (some being
**EXTREMELY HARD** like
[1991/dds](/thanks-for-fixes.md#1991dds-readmemd)) or as much as possible (like
[1989/westley](/thanks-for-fixes.md#1989westley-readmemd), a true masterpiece
that is **INCREDIBLY HARD, _MUCH, MUCH MORE SO_ than any other fix!**), porting
entries to macOS (some being **EXTREMELY HARD** like
[1998/schweikh1](/thanks-for-fixes.md#1998schweikh1-readmemd)), fixing code like
[2001/herrmann2](/thanks-for-fixes.md#2001herrmann2-readmemd) to work in both
32-bit/64-bit which *can be* **EXTREMELY HARD**, providing alternate code
where useful/necessary, fixing possible/removing dead links,
typo/consistency fixes, improving **ALL _Makefiles_** and writing
[sgit](https://github.com/xexyl/sgit) that we installed locally to easily run
`sed` on files in the repo to help build the website. **THANK YOU VERY MUCH**
for your extensive efforts in helping improve the IOCCC presentation of past
IOCCC winners and fixing almost all past entries for modern systems!

[Yusuke Endoh](https://www.ioccc.org/winners.html#Yusuke_Endoh) supplied a
number of important bug fixes to a number of past IOCCC winners. Some of those
fixes were **EXTREMELY TECHNICALLY CHALLENGING** such as
[1989/robison](/thanks-for-fixes.md#1989robison-readmemd),
[1990/cmills](https://github.com/ioccc-src/temp-test-ioccc/blob/master/thanks-for-fixes.md#1990cmills-readmemd),
[1992/lush](/thanks-for-fixes.md#1992lush-readmemd) and
[2001/ctk](/thanks-for-fixes.md#2001ctk-readmemd). **THANK YOU VERY MUCH** for
your help!

A good number of the [past winners of the
IOCCC](https://www.ioccc.org/winners.html) tested, identified and helped correct
and/or improve the write-ups of fellow IOCCC winners for the year that they won.
The list of those past winners is too long to mention: nevertheless the [IOCCC
judges](https://www.ioccc.org/judges.html) **VERY MUCH APPRECIATE** those who
helped improve the presentation of their fellow IOCCC winners.


## Thank you list since 2021 Jan 01

To avoid having to change numerous "_README.md_" files to add thank you notes,
we centralize them below.

The [IOCCC judges](https://www.ioccc.org/judges.html) wish to recognize the many
important contributions to the IOCCC presentation of past IOCCC winners.
We are pleased to note the many contributions, **made since 2021 Jan 01**,
on a winner by winner basis.


## Note about fixes and inconsistencies with the original code and remarks

Invariably when an entry is fixed and it is not made an alt version (sometimes
it is worth an alt version and other times not - it all depends on what was
done) some inconsistencies will be introduced of the original code, the remarks
of the author(s) and the size restrictions of the contest for that year (and in
some cases it might end up being against other rules).

See [FAQ 4.3  - Why do author remarks sometimes not match the source / why are
there other inconsistencies with the original entry?](/faq.md#faq4_3) for this
specifically and also [FAQ 4.2: What was changed in an IOCCC winner source
code?](/faq.mdfaq4_2).


## Notes about changing `gets()` to `fgets()` in some entries:

Although the 'why' is discussed in the [FAQ 4.1: Why were some calls to the libc
function `gets(3)` changed to use `fgets(3)`?](/faq.md#faq4_1) we want to give
more details here as it pertains to the fixes and  updates made in numerous
entries below (note that some of the information in that FAQ entry are below).

The problem with `gets()` is that in some systems a warning can be interspersed
with the output which can be confusing, to say nothing of the annoyance of it
(which can be fixed via `2>/dev/null` - and this is done with some entries in
the to use/try sections - but which makes it more burdensome to run as there are
a lot of entries that use it still).

A good example was [1990/tbr](/thanks-for-fixes.md#1990tbr-readmemd) where one
would see:

```
$ warning: this program uses gets(), which is unsafe.
# cursor here, what to do?
```

whereas without the warning it's much easier to see that it's a prompt:

```
$
```

Another great example is:

```sh
$ cd 1990/cmills
$ ./cmills
Shuffle...
warning: this program uses gets(), which is unsafe.
Total $1000.  Wager?
```

In some entries this change is not possible, in one-liners it might make them
too long (though it's also been possible to do it in some cases) and in some
entries it's more complicated than others because of the annoying fact that for
'"compatibility" reasons' `fgets()` retains the newline and `gets()` does not.
As the v7 man page used to say:

```
BUGS

The fgets(3) function retains the newline while gets(3) does not, all in the
name of backward compatibility.
```

Some entries like [1992/adrian](1992/adrian/README.md) were more complicated in
other ways due to the code generating other output and because of how it works
it would generate code that could not be compiled, simply because of spaces
being added; nevertheless Cody did make this fix along with a number of other
fixes in that entry.

In any case some of the entries have been updated this way for the reasons
described above and in the [FAQ](/faq.md).

Where possible `gets(3)` has been redefined to be `fgets(3)` with the
appropriate arg.  This is not always possible but if often it is.

See also [bugs.md](/bugs.md) for a further discussion on the matter.


## A note about bugs versus (mis)features:

Over time, when working on making fixes for compilers, different platforms
and other such things, the definition of a feature versus a bug has changed,
sometimes even for just specific entries, and this has happened a number of
times as well, back and forth.

The main definition of a feature that is most common is that if the judges or
the author (or authors) note that it crashes without the right number of args,
then this is, although technically a bug, considered a feature for the contest.
In general if something is documented then it is a feature and not a bug.

A counterexample is [1990/theorem](#1990theorem-readmemd) which is considered
such a beautiful program that along with a change to `fgets(3)` it had arg
checks added. There are some other examples for reasons like this, a good one
being [1998/schnitzi](#1993schnitzi-readmemd), also because it's such a
beautiful program (other fixes were made as well which is shown below also).
Both of these entries were fixed by Cody.

But there are some others that are more questionable and border on tampering
with the entry especially as some of them were documented by the author. These
happened over time where sometimes we, the judges, changed the status to
bug/(mis)-feature and when verifying the consistency, Cody fixed them as they
only took a few seconds to fix; others he changed back to feature status and
they were not fixed as the problems were documented by the author or us.

Of course it can be argued that by fixing these things it makes it more user
friendly for modern enjoyment but even so it's very often the wrong way to go
about it. If the author does not mention it then it can be considered a bug
that can be fixed.

See the [bugs.md](/bugs.md) for more information regarding this situation and
for many entries with a variety types of bugs that you can look at fixing too,
if you wish to help! You will be thanked in this file should you do so. Fixing
does not have to be just code: it can be a Makefile fix or something else
entirely, even typos (in data files: usually not good idea in code even in
comments though it happened once). An example that has happened several times is
that if the optimiser is enabled the program might crash, sometimes in one
platform and not others but other times in multiple platforms. This counts as a
fix too, which you will see below should you look at the very long list of
fixes, including the next section!


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

There were some other fixes as well including mass typo fixes in the Makefiles
(though that usually does not mean it is worth a thank you note it might be
worth noting in this case). Other times it was enabling or disabling the
optimiser to fix an entry, sometimes causing other problems that also had to be
fixed, a good example being [1986/marshall](#1986marshall-readmemd) (see the
[compilers.md](1986/marshall/compilers.md) for the amusing details and all that
had to be done to fix it).

There was a 'problem' where `${MAKE}` was `$(MAKE)`: this doesn't break anything
but it is inconsistent with the rest of the `${foo}` tools.

A lot of the fixes with the Makefiles that Cody made were done with his [sgit
tool](https://github.com/xexyl/sgit).


## Typo fixes and consistency improvements

Cody, being the IOCCC's resident corrections officer :-) (and a fine one at
that, we think :-) ), made many, many typ0 (... :-) ) fixes throughout the
README.md files, scripts, other data files, Makefiles (see above) etc.

He also updated the formatting of the README.md files (after renaming the old
files to README.md) to proper markdown.

Where possible he made the presentation of the entries much more consistent
across the entries of all the years as well as other files. This is not possible
for everything (the remarks of authors, for instance, cannot be and should not
be made consistent but adding markdown where necessary in the remarks is).

A lot of these fixes were done with his [sgit
tool](https://github.com/xexyl/sgit) as well but many were done manually too.


## [1984/anonymous](1984/anonymous/anonymous.c) ([README.md](1984/anonymous/README.md))

Cody fixed this to work for macOS.

The problem was to do with the way that the `read(2)` function was redefined.
With macOS the second arg needs to be a `void *` and this also necessitated some
casts to `int` (on the second arg) in the call to `write(2)` (in `read()`).

Later Cody corrected the mistake where the `"hello, world!"` string was on one
line rather than two lines which the author told us (Landon) that they liked.
Thus now it is like the original where the first line ends with `"hell\` and
the second line starts with `o, world!\n"`.

By request, the original code is provided as
[anonymous.alt.c](1984/anonymous/anonymous.alt.c) so that one can look at it and
the famous tattoo which we also include here:

![1984-anonymous-tattoo.jpg](1984/anonymous/1984-anonymous-tattoo.jpg)

...which was done in 2005 by [Thomas
Scovell](https://web.archive.org/web/20070120220721/https://thomasscovell.com/tattoo.php).


## [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md]))

Cody fixed this to not require `-traditional-cpp` which some compilers like
clang do not support. Fixing `-traditional-cpp` is, as noted earlier, very
complicated, but we encourage you to look at the alternate code (which is the
original code with a minor modification made by the judges) and the fixed
code, to see what had to be done.

Clang is also more strict about the type of args in `main()` and this was also a
problem that Cody fixed, making it work with both clang and gcc.

These fixes worked fine in macOS but it turned out that in some cases with clang
in linux it did not work so this had to be further fixed which Cody also did. It
is no longer clear what the problem was as in fedora 38 with clang 16.0.6 the
only difference is it causes additional warnings but it seems to work just fine.
It seems unlikely that a fix was made just for warnings so it is presumed that
there was another problem so the change is kept in place.

A note about the fix is that the `#define`d macros that were used still exist
but most are not used; they are left in just to make it look more like the
original entry. Nevertheless those cannot be used.

Later on Cody improved the fix to make it look rather more like the original by
bringing back an extern declaration (slightly changing it to match the symbol
that it is i.e. `extern double floor(double);` instead of `extern int floor;`)
and `double (x1, y1) b;`, commenting out only the code:

```c
char x {sizeof(
     double(%s,%D)(*)())
```

and changing the type of `k` to be an `int`.

Additionally, because of the `#define union static struct` there is no need to
have in the code `static struct` as we can have it like the original code which
has it as `union`.

Originally Yusuke supplied a patch so that this entry would compile with gcc -
but not clang - or at least some versions.

To see the difference from start to fixed:

```sh
cd 1984/decot ; make diff_orig_prog
```


## [1984/laman](1984/laman/laman.c) ([README.md](1984/laman/README.md]))

Cody fixed this to not crash when no arg is specified. Note that if the arg is
not a positive number it will not do anything useful or anything at all.

This was fixed on 30 October 2023 after the bug status was changed from INABIAF
(it's not a bug it's a feature) to bug.


## [1984/mullender](1984/mullender/mullender.c) ([README.md](1984/mullender/README.md]))

Cody provided an [alternate version](1984/mullender/mullender.alt.c), an
improved version of the judges, so that everyone can enjoy it with systems that
are not VAX/PDP. We also refer you to the [FAQ](faq.md) as there are some
winning entries that also let one enjoy it - with more to them of course!

Cody further added the second alt version,
[mullender.alt2.c](1984/mullender/mullender.alt2.c) which is like the
[1984/mullender/mullender.alt.c](1984/mullender/mullender.alt.c) except that it
starts over after it times out.

Cody also added the [gentab.c](1984/mullender/gentab.c) file, fixed to compile
(and work, though see [bugs.md](#1984mullender-readmemd)) with modern systems
and so that it would create the proper array (it had unbalanced '}'s), which the
author noted in their remarks (which Cody also found). As this file uses the old
header file `a.out.h` that is not available in all modern systems, Cody found a
copy of it as to what it should have been at the time, in the fabulous [Unix
History
Repo](https://github.com/dspinellis/unix-history-repo/tree/Research-Release).


## [1985/applin](1985/applin/applin.c) ([README.md](1985/applin/README.md]))

Both Cody and Yusuke fixed this; Yusuke got this to not crash and Cody fixed it
to work with macOS.

The crash was because it destructively rewrites string literals. However with
`strdup()` it's safe.

The problem with macOS is that although it didn't crash, it printed `H????` in a
seemingly infinite loop, each time printing another `?`, and it probably would
have until it runs out of memory.

The fix for macOS is that there was no prototype for `execlp()` and macOS has
problems with missing prototypes for some functions (this was also seen when
Cody fixed [1984/anonymous](/1984/anonymous/anonymous.c) for macOS as well). As
this is a one-liner the include of `unistd.h` was done in the Makefile.
Ironically this fix was discovered through linux!

NOTE: originally this entry did not print a newline prior to returning to the
shell, after the output (despite having `\n` in the string - can you figure out
why?) but to make it more friendly to users Cody made it print a `\n` prior to
returning to the shell. The original version does not have this change.


## [1985/august](1985/august/august.c) ([README.md](1985/august/README.md))

Cody added the script [primes.sh](1985/august/primes.sh) which allows one to
check the output for the first N prime numbers of the output, where N is either
the default or user specified. The inspiration was the previous 'try' command he
gave to have fun with finding primes that might seem unusual in a way.


## [1985/lycklama](1985/lycklama/lycklama.c) ([README.md](1985/lycklama/README.md]))

Cody fixed this to compile with modern compilers. In the past one could get away
with defining some macro to `#define` and then use `#foo` to have the same
effect as using `#define` but this does not work in modern systems so Cody
changed the `#o` lines to `#define`. Also `unistd.h` had to be `#include`d.

Yusuke provided some useful information that amounts to an alternate version
that Cody added. See the README.md for details.


## [1985/shapiro](1985/shapiro/shapiro.c) ([README.md](1985/shapiro/README.md]))

Cody added the alt code which allows one to resize the maze and he also added
the [try.alt.sh](1985/shapiro/try.alt.sh) script that randomly selects sizes
(five times) and compiles and runs it. After the five runs it prompts you to
enter a number, in an infinite loop, exiting if any non-digits are in input
(this includes negative numbers which in the code actually sets it back to 39,
the default).


## [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md]))

Cody fixed this _very twisted entry_ to not require `-traditional-cpp`.  Fixing
`-traditional-cpp` is, as noted earlier, very complicated, but Cody would like
to refer you to the original file
[sicherman.orig.c](1985/sicherman/sicherman.orig.c) and he suggests that you
then compare it to [sicherman.c](1985/sicherman/sicherman.c) for some good old
C-fashioned fun (alternatively, see below explanation)!

Later on Cody improved the fix so that it looks much more like the [original
entry](1985/sicherman/sicherman.c). He did this several more times and it's
as close to the original as one can get without causing compiler errors.

To get this to all work the following changes were made. If you really want to
understand this Cody provides the following. First run the following command
from the directory:

```sh
make diff_orig_prog
```

and then read the following (you might also wish to look at the code in an
editor with syntax highlighting):

- Because of the macros `C` and `V` in the original code, the args to `main()`
were actually not what they appear: the only arg that existed in `main()` was
`Manual`. Thus it now looks like:

	```c
	main(
	/*	C program. (If you don't
	 *	understand it look it
	 *	up.) (In the C*/ Manual)
	{
	```

- The code:

	```c
	C="Lint says "argument Manual isn't used."  What's that
	mean?"; while (write((read(C_C('"'-'/*"'/*"*/))?__:__-_+
	'\b'b'\b'|((_-52)%('\b'b'\b'+C_C_('\t'b'\n'))+1),1),&_,1));
	```

    had to be changed to:

	```c
	c="Lint says \"argument Manual isn't used.\" What's that\
	mean?"; while (write((read(('"'-'/*"'))?__:__-_+
	'\b'b'\b'|((_-52)%('\b'b'\b'+C_C_('\t'b'\n'))+1),1),&_,1));
	```

    because of the missing `"` at the end of the line and because `_|_` is not a
    function call.

    The `\"` had to be done to keep the `"`s there though the string could be
    broken up into multiple `"` pairs instead; that seemed less authentic,
    however. Notice how the last line of code in that function is the same as
    before and actually that there aren't that many changes in the function at
    all!

    Notice also that the parameter `C` had to be changed to `c` due to the macro.

    The `char`s `_` and `__` were made file scope so the `subr()` could actually
    compile but this does not affect the ones in `main()`. Why is this? You tell
    us!

- The code in `main()` is where there are significant changes, changing from:

	    ```c
	    while (read(0,&__,1) & write((_=(_=C_C_(__),C)),
	    _C_,1)) _=C-V+subr(&V);
	    ```

	to:

	    ```c
	    while (read(0,&__,1) & write((_=(_=C_C_(__),
	    V))?__:__-_+'\b'b'\b'|((_-52)%('\b'b'\b'+~
	    ' '&'\t'b'\n')+1),1),&_,1))_=C-V+subr(&V));
	    ```

    Note how numerous of the macros can still be used but some cannot be. Can
    you figure out why? Why too is it that the `subr()` function is called but
    it appears that some of the code in that function is also in `main()` in the
    `while` condition? What happens if you remove it from `main()`? What happens
    if you remove it from `subr()` or don't even bother calling `subr()`?


## [1986/hague](1986/hague/hague.c) ([README.md](1986/hague/README.md]))

Cody made this use `fgets()`.


## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md]))

Cody fixed this to compile and work with clang (it already worked with gcc).
The problem was that clang is more strict about the type of second arg to
`main()`. However simply changing it to a `char **` and updating the `*s` to `**s`
caused a segfault. By adding a new variable, `char *t`, initialising it to `s`
and then using `t` instead of `s` it compiles and runs successfully under clang
and gcc.


## [1986/marshall](1986/marshall/marshall.c) ([README.md](1986/marshall/README.md]))

Cody got this to compile and work with clang and gcc. He noted that he tried to
keep the ASCII art as close to the original as possible. The line lengths are
the same but some spaces had to be changed to non-spaces.

This fix was very interesting and quite amusing, showing up problems with two
different compilers. This is a brief summary but much more is explained in the
[compilers.md](1986/marshall/compilers.md) file, giving which compilers had
which problems in which systems: the optimiser being enabled in one compiler let
it work but broke it in the other; and disabling it would let it work in the one
that didn't work but suddenly the one that worked wouldn't work. And by 'not
working' it did not work in more than one way and for different platforms it had
other problems as well.

This problem was only after getting clang to compile, of course. It did not
compile it because it is more strict about the second and third args to `main()`
and the third arg was an `int`.

We encourage you to read the [compilers.md](1986/marshall/compilers.md) file to
see how odd this problem was and what Cody did to fix it, if nothing else but
for entertainment!


## [1986/pawka](1986/pawka/pawka.c) ([README.md](1986/pawka/README.md))

Cody noticed and fixed a funny mistake in the Makefile where a
`-Wno-strict-prototypes` was in the wrong location, suggesting that there is a
`-D` needed to compile the entry.


## [1986/wall](1986/wall/wall.c) ([README.md](1986/wall/README.md]))

Cody fixed this so that it does not require `-traditional-cpp`. This took a fair
bit of tinkering as this entry *very twisted*; fixing `-traditional-cpp` is, as
noted earlier, very complicated, but we encourage you to look at [original
code](1986/wall/wall.orig.c) to see how different C was in 1986, as well as
below.

Yusuke originally patched this to use `strdup()` on two strings and this let it
work with gcc but it still required `-traditional-cpp`. The [alternate
code](1986/wall/wall.alt.c) is the version patched by Yusuke should you wish to
try it with a compiler that has the `-traditional-cpp`. See the README.md file
for details.

If you'd like to see the difference between the version that requires
`-traditional-cpp` and the fixed version, try:

```sh
cd 1986/wall ; make diff_alt_prog
```

Some of the changes required:

- Instead of using the `c_`, defined as `c_(cc)c cc=`, like:

	    c_(+)o

	    /* ... */

	    :c_(+)' '-1;
	    }}c_(&)'z'+5;

    use:

	    :c +=o[c&__LINE__-007];

	    /* ... */

	    :c+=' '-1;
	    }}c&='z'+5;

    Observe however that this macro is still used in the code like:

	   main(;c_(=(*cc);*cc++)c,for);

- Instead of code like:

	    main(0xb+(c>>5),C_(s))
	    _'\v'
	    :__ _'\f':
	    main(c,C_(s));

    use instead:

	    main(;c_(=(*cc);*cc++)c,for);
	    #define _O(s)s
	    switch(0xb+(c>>5)){
	    _'\v'
	    :__ _'\f':
	    switch(c){;

- The macro:

	    #define C_(sand)_O(sand)witch

    could not be used like:

	    C_(s));_

    to create:

	    switch);_

    and neither could the macro:

	    #define O_(O)_O(O)stem(ccc(

    be used like:

	    :O_(sy)";kkt -oa, dijszdijs QQ"))_C

    to create:

	    :system(ccc(";kkt -oa, dijszdijs QQ"));return



## [1987/heckbert](1987/heckbert/heckbert.c) ([README.md](1987/heckbert/README.md))

Cody made this look more like the original entry by restoring the `#define` of
`define`. It's not used but it now looks closer to the original.

Also because `index(3)` is deprecated and in some systems requires the inclusion
of `strings.h` and because it's identical in use to `strchr(3)` (and we noted
that for System V we had to do this) Cody added to the Makefile
`-Dindex=strchr`.


## [1987/lievaart](1987/lievaart/lievaart.c) ([README.md](1987/lievaart/README.md))

Cody added back the documented checks for invalid input which no longer worked
and instead resulted in either accepting the level, whether or not it was a
number or out of range (see below on range). For the move it entered an infinite
loop, prompting the player with `"You:"` but not letting the player input
anything so that the screen was flooded and the game could not be played.

For both the level and move it did a `scanf()` with a `%d` specifier but this
resulted in, if invalid input, either proceeding (for the level), presumably
incorrectly done as it might not even be a number (see below) or printing
`"You:"` in an infinite loop, expecting input again but not letting the player
input anything, both as noted above.

The fix is that now the specifier is a `%2s` for a `char A[100]` (yes 100 is
overkill; there's no good reason for it here: it was just arbitrarily selected).

For the level if `atoi(A)>10||<0` (see next part) or `!isdigit(*A)` it goes back
and prompts again. The level is checked for `>=0||<=10`, perhaps incorrectly or
perhaps not, because in the code that variable is checked for `<10` and if that
is the case it is incremented by 2. I do not know the rules of the game and
neither do I know what the author had in mind so I chosen 10 as the maximum.

As for the move the `do..while` loop works properly now that it does it in two
steps (`scanf("%2s", A); m=atoi(A);`) so there's no need to check the value
explicitly, again. Thus it will prompt until valid input is entered, but only
showing `"You:"` once per prompting.

In the case of the level prior to prompting for the level it does a `*A='\0';`
and in the case of the move it does it after the `m=atoi(A);`. This is done this
way because the check for the value of the level (`atoi(A)`) is done in the
`if()` that also checks for a digit (though it does `(u=atoi(A))>10||u<0` first,
thus checking the level, and `|| !isdigit(*A)`). Of course since `-` is not a
digit the `<0` is superfluous but it's done anyway. If that `if` is 1 then it
immediately goes back to the prompting of the level.

But for the move it can happen after due to the fact the condition of the
`do..while` loop will take care of things.

Cody also made this ever so slightly like the original code by adding back the
`#define D define` even though it's unused. This was done for both versions as
well (the one with the board and the one without, the entry itself with the
size constraints of the contest).


## [1987/wall](1987/wall/wall.c) ([README.md](1987/wall/README.md]))

Cody made this use `fgets(3)`.


## [1987/westley](1987/westley/westley.c) ([README.md](1987/westley/README.md]))

Cody fixed this for modern systems. The problem was `'assignment to cast is
illegal, lvalue casts are not supported'`. For the original file see the
README.md file. Unfortunately this ruins some symmetry. To try and resolve this
as much as possible at first code was commented out but later on the commented
out code was removed and another part changed so that, although it has some code
no longer there, it has a closer match in symmetry and since the code was
commented out it's probably not a big deal to have it removed instead as it does
look more symmetrical now.

Cody also added to the Makefile `-include stdio.h` in the nowadays very
unlikely(?) but nevertheless suggested case that `putchar()` is not available.


## [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md]))

Cody fixed this twisted entry (as we called it :-) ) for modern compilers,
including making it no longer require `-traditional-cpp`. Fixing
`-traditional-cpp` is, as noted earlier, very complicated, but we encourage you
to compare the fix from the original entry. There was another problem to resolve
as well, however.

First of all, as noted above, the entry required `-traditional-cpp` (which
<strike>not all compilers support</strike> `clang` does not support). It needed
that option in modern systems because of two things it did:

```c
#define a(x)get/***/x/***/id())

/* ... */

p Z=chroot("/");L(!a(u)execv((q(v="/ipu6ljov"),v),C);Z-=kill(l);

/* ... */

case_2:L(!--V){O/*/*/c*c+c);wait(A+c*c-c);L(!Z)f(A,"\n",c);return(A*getgid());};C++;
```

This macro, `a`, formed the functions (the names) `getuid()` and `getgid()`, but
this no longer works.  The code still uses the macro `a` to form the names but
it's done differently, using the C token paste operator `##`. It's done like
thus:

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

The second is that

```c
for/*/(;;);/*/k()){O/*/*/c);
```

cannot form `fork())` in modern C compilers. Since it was not done through a
macro it was simply changed to be `fork()`, rather than adding a new macro.

The other problem that could not be resolved by the `-traditional-cpp` was that
modern compilers do not allow directives like:

```c
#define _ define
#_ P char
#_ p int
#_ O close(
/* ... */
```

so Cody changed the lines to be in the form of:

```c
#define P char
#define p int
#define O close(
/* ... */
```

However, to keep the entry as close to as possible in look, Cody kept the `_`
macro in place it's just no longer used.

See the README.md file for details on the original code, provided as an alt
version in case you have an older compiler or wish to try `-traditional-cpp`.


## [1988/isaak](1988/isaak/isaak.c) ([README.md](1988/isaak/README.md]))

Cody fixed this to work for modern systems. The problem was that the important
function, a redefinition of `exit()`, was not being called in `main()`. The
original version is in [1988/isaak/isaak.alt.c](1988/isaak/isaak.alt.c). See the
README.md file for more details.


## [1988/litmaath](1988/litmaath/litmaath.c) ([README.md](1988/litmaath/README.md))

Cody added the alt code which is code that we suggested at the time of
publication, in the remarks, to help understand the entry, and for fun.


## [1988/phillipps](1988/phillipps/phillipps.c) ([README.md](1988/phillipps/README.md]))

Cody fixed this for modern systems. It did not compile with clang because it
requires the second and third args of `main()` to be `char **` but even before
that with gcc it printed garbage and then crashed.

After fixing it for clang by changing the very `main()` (in fact it called
itself up to 12 times!) to call the new function `pain()` (chosen because it's a
pain that clang requires these args to be `char **` :-), which is just as
recursive, with the correct args it now works with both gcc and clang.

Later Cody improved the fix to make it look a bit more like the original, using
K&R style functions, and trying to match the format as best as possible of what
`main()` used to look like but without the full body that cannot exist as it
once did. The format of `pain()` is exactly like how `main()` was as it's the
same code. Additionally, `main()` returns `!pain(...)` like `main()` used to do
to itself and `pain()` does now.


## [1988/reddy](1988/reddy/reddy.c) ([README.md](1988/reddy/README.md))

Cody made this use `fgets(3)`.


## [1988/spinellis](1988/spinellis/spinellis.c) ([README.md](1988/spinellis/README.md]))

Cody provided an [alternate version](1988/spinellis/spinellis.alt.c) so that
this will work with compilers like clang. An alternate version had to be
provided because not doing so would be tampering with the entry too much. It
would work but it would not show the same creativity and cleverness.

The original entry exploits a fun mis-feature that works with gcc but not clang.
This resulted in a change of rules which is another reason to not modify the
original. See the README.md file for details on the alternate code.

Meanwhile Cody was twisted enough to point out (though to be fair he felt sick
doing this) that with a slight modification this entry can be C++ instead. We don't
thank him for this ghastly point! :-)


## [1988/westley](1988/westley/westley.c) ([README.md](1988/westley/README.md]))

The [original version](1988/westley/westley.alt.c), provided as alternate code,
was fixed by Misha Dynin, based on the judges' remarks, so that this would work
with modern C compilers. We encourage you to try the alternate version to see
what happens with current compilers! See the README.md files for details.

Cody changed the `int`s to be `float` as that's what they are printed as: not
strictly necessary but nonetheless more correct, even if not warned against.

Cody added the [try.sh](1988/westley/try.sh) script to show the magic of the
entry as seeing the code with the result at once is far more beautiful.


## [1989/fubar](1989/fubar/fubar.c) ([README.md](1989/fubar/README.md]))

Cody got this to work with modern systems. The main issues were that an
`#include` had to be added along with fixing the path (due to `.` not being in
`$PATH`) to files referred to in the code.


## [1989/jar.1](1989/jar.1/jar.1.c) ([README.md](1989/jar.1/README.md]))

To prevent annoying output to `/dev/tty` we changed the code to simulate the
output via `strings(1)` but Cody removed the ill-famed `useless use of cat` to
shut ShellCheck up. Why is it ill-famed? Because there is no such thing as a
useless cat, that's why! For instance, the fact they even exist is proof that
the Earth is **NOT** flat: because if it was they would have pushed everything
off it by now! :-) They're also a great joy to all ailurophiles and yes they
most certainly do have a personality and they can be very sociable.

Whilst he was at it, Cody made it so that one need not run the alt script or alt
code directly, to match that of the main entry. As we simulate the functionality
anyway, and since one may still run the code or the script (for the original
entry and the alt code) anyway, it works out well.


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

Cody also provided the [try.sh](1989/jar.2/try.sh) script and the
supplementary files [try.txt](1989/jar.2/try.txt),
[fib.lisp](1989/jar.2/fib.lisp) and
[chocolate_cake.lisp](1989/jar.2/chocolate_cake.lisp). The `try.txt` comes
from the author and the `fib.lisp` comes from Yusuke. Cody wrote the script and
offered us some chocolate cake :-) See README.md for details on how to use the
script.


## [1989/ovdluhe](1989/ovdluhe/ovdluhe.c) ([README.md](1989/ovdluhe/README.md]))

Cody fixed an infinite loop where the program would print the same thing over
and over again, flooding the screen. The problem is that there was a `for` loop
that by necessity had to not have an increment stage but only in the `if` path
(in the loop itself) did the pointer get updated.

Cody also provided an [alternate version](1989/ovdluhe/ovdluhe.alt.c) based on the
author's remarks. See the README.md for details. The fix described above was
fixed in this version too, after it was discovered and fixed.


## [1989/paul](1989/paul/paul.c) ([README.md](1989/paul/README.md]))

Cody fixed a segfault under macOS that prevented it from working. The problem
was that the int (from `#define f`) should be a long. This became apparent when
he was using lldb and saw that the type of a pointer was too `long` :-)

Cody also provided the [alternate version](1989/paul/paul.alt.c)
which has the trace function that the author included but commented out. See the
README.md for details.


## [1989/robison](1989/robison/robison.c) ([README.md](1989/robison/README.md]))

Yusuke Endoh fixed this to compile under modern systems. To see the changes
made, try:


```sh
cd 1989/robison ; make diff_orig_prog
```

(It adds the C token pasting operator `##` instead of `/**/`.)


## [1989/tromp](1989/tromp/tromp.c) ([README.md](1989/tromp/README.md]))

Cody and Yusuke fixed this entry: Yusuke fixed this to compile with gcc and Cody
fixed it for clang and made some other fixes as well.

To get it to work with clang the variable `a` had to not be the third argument
to `main()` but instead be a variable in `main()`.

Cody also fixed a segfault and made it so the that the high score file would
work (it was not even being created but it was supposed to be). This was
happening due to a file pointer being declared as a `long` and more
significantly is the command in `popen(3)` was not correct.

Another problem Cody fixed was that the terminal was left in an insane state where you
could not type '`u`' and echo was completely disabled.

Cody later on fixed the alt version, provided by the author, so that it would
compile with clang, not abort (with an alarm), would have the tetriminos fall,
it would write to the high score file (the command to `popen(3)` was incorrect
here too but as can be seen it differs from the submitted version), could use
`stty` properly (and thus turn on echo again - it did not work because it was in
the `popen(3)` call rather than using `system(3)`), a couple compiler errors and
various other things, so that now the alt version, which is better, can be used.

Although we appreciate the help here, he cynically noted that he had to have an
IOCCC [Tetris](https://en.wikipedia.org/wiki/Tetris) working (this of course was
not his only reason :-) )


## [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md]))

Cody fixed this for clang, except that two versions generated by the program
cannot be compiled by clang due to inherent defects in the compiler and how the
entry works. This is an **incredibly hard** one to fix for clang whilst still
being compilable with gcc (and gcc can compile every generated version with the
fix) and even if one fixes it to compile with clang it does not mean that any
other version will compile! It is, however, possible to get clang to work with
two versions generated, `ver0` and `ver1`, though `ver0` is actually just the
main entry (but still generated by the program itself).

Unfortunately due to the way this entry works if it is even possible to get all
versions to compile with clang it will take heavy modifications to get all
versions to compile with clang. Cody almost got it and knows how it functions
but even getting it just about there caused compilation errors in gcc so it
might just not be possible.

The way it was fixed might be hard to see and describe but this is an attempt.
Because `main()`'s args were all `int`s, `main()` had to call a new function
which is allowed to have args as `int` (instead of `main()`'s args being int and
the rest being `char **`) but this is not as straight forward as it is for other
entries (if you look at the code you might see what is meant; the function called
is `pain()`).

The args of `main()` had to be set to the right type but only three args, **not
four**, even though the original program has four args. This is because not all
versions of clang support four args and that is one of the issues with version 2
and 3 as it generates `main()` to have four args and the wrong type, all `int`s.

In the call to the new function, `pain()`, from `main()`, one of the `char **`s
is used twice, once as `argc` with bitwise AND with 2, naturally first being
cast to an `int` (`(int)ABBA&2`), and once as a `char **`, the fourth arg to
`pain()` (yes even though `pain()` takes all `int`s).

The argc,, meanwhile, `tang`, is used once and the second arg, `char **gnat` is
used once (observe how `tang` is `gnat` spelt backwards as this is one of the
things that makes this a masterpiece and very hard if not impossible to fix
completely). Fortunately it is not actually necessary to use all four args (of
`main()`) in the call which might or might not be surprising, especially as it
uses one of the args, a `char **`, instead of an `int` (through casts), twice
rather than just passing in for the fourth arg (the fourth arg passed in is the
third arg to `main()`).

This program heavily uses recursion and depending on the number of args it will
print out output normally, ROT13 it, show it backwards or both. Along with the
ROT13 and reversed output of the code, it is the **comments that create the
names and the rest of the code!**: sometimes it is the word backwards, other
times it is the ROT13 of it and other times it is both, both for comments and
otherwise. Trying to change comments can be very difficult though it was done
when clang could almost compile every version if not actually compile all
versions. Unfortunately when this was done it caused other systems to have
additional compilation errors so it seems highly unlikely that version 2 and 3
can work for clang (versions 0 and 1 can).

Despite the risks of changing names this was done and indeed by necessity.
Comments might have been changed but it is no longer known if that happened only
in the working on version 2 and 3 or if in the fix for clang as well as version
0 and 1.

To make use of this several scripts were added by Cody.

The [compile.sh](1989/westley/compile.sh) script that removes the generated
code, rebuilds the program and regenerates the other code and then compiles it
will work for compilers like gcc and one can then use the
[try.sh](1989/westley/try.sh) script to see example input and output.

The `compile.sh` script allows one to specify the compiler with the `CC`
environmental variable; see the README.md for details.


## [1990/baruch](1990/baruch/baruch.c) ([README.md](1990/baruch/README.md]))

Cody added an [alternate version](1990/baruch/baruch.alt.c) which allows Turbo-C
and MSC to compile this code, based on the authors' remarks, except that Cody
did not change the `" #Q"` string as that showed worse looking output
instead of improved output though he has no way to test the compilers in
question. YMMV.

Although this is appreciated we agree with him that <strike>no one</strike>
[very few](https://en.wikipedia.org/wiki/0)
[users](https://en.wikipedia.org/wiki/Microsoft_Windows)
[here](https://www.ioccc.org) will need it! :-)

Cody also made the code look more like the original, removing the `int` from
the variables, adding instead `-Wno-implicit-int`. The newline added by the
judges was retained.


## [1990/cmills](1990/cmills/cmills.c) ([README.md](1990/cmills/README.md]))

Yusuke got this to work in modern systems (it previously resulted in a bus
error).

Cody made this use `fgets(3)`.


## [1990/dds](1990/dds/dds.c) ([README.md](1990/dds/README.md]))

Yusuke and Cody in conjunction fixed this for modern systems (both fixed a
different compiler error but more fixes were also made).

Yusuke added the comma operator for a binary expression with `free(3)` which is
is a compiler error because `free()` returns void. Cody then made it slightly
more like the original in this way by redefining `free` to have the comma
operator itself.

Cody fixed another compiler error by removing the erroneous prototype to
`fopen()`.  Cody also changed a `char *` used for file I/O to be a proper `FILE
*` and fixed a typo in [LANDER.BAS](1990/dds/LANDER.BAS).

Cody also made this use `fgets(3)`.


## [1990/dg](1990/dg/dg.c) ([README.md](1990/dg/README.md]))

Cody fixed this for modern systems. There were two problems to be resolved.

One can no longer do:

```c
#define d define

#d b12(x) 12 x

/* etc. */
```

so the use of `#d` is now instead `#define` (the macro was originally deleted
but later Cody added it back to make it more like the original).

The second problem was suggested by the judges at the time of judging, to do
with if the C preprocessor botches single quotes in cpp expansion.


## [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md]))

Cody fixed the script to work properly in modern environments including writing
to and extracting from `stdout` and relying on the exit code in the commands to
allow for `&& ...`.

He also changed the `perror(3)` call to `fprintf(3)` because in macOS when errno
is 0 it shows what looks like an error.

He added the [try.sh](1990/jaw/try.sh) to run the commands that we suggested at
the time.

NOTE: as `btoa` is not common we used a ruby script from Yusuke but with a minor
fix applied by Cody that made the program just show `oops` twice from invalid
input but which now works.


## [1990/pjr](1990/pjr/pjr.c) ([README.md](1990/pjr/README.md]))

Cody added the [alt code](1990/pjr/pjr.alt.c) which was suggested by the judges
in the case that your compiler cannot compile `X=g()...` but it actually does
something else and is recommended by the author as well.


## [1990/scjones](1990/scjones/scjones.c) ([README.md](1990/scjones/README.md]))

Yusuke suggested `-ansi` to get the entry to compile due to trigraphs and Cody
suggested `-trigraphs`. Both work but we used Yusuke's idea.


## [1990/tbr](1990/tbr/tbr.c) ([README.md](1990/tbr/README.md]))

Cody fixed this to work with modern compilers; `exit(3)` returns void but the
function was used in a binary expression so this wouldn't even compile.

Cody also changed the code to use `fgets()` instead of `gets()` so one would not get
a warning about the use of `gets(3)` at linking time or execution, the latter of
which was causing confusing output due to the warning being interspersed with
the program's interactive output.

Additionally, Cody fixed the shortened version provided by the author in the
same way as the original entry, first the compile fix and then later on making
it look more like the original by redefining `exit` and also redefining `gets()`
to be `fgets()` in the same way that the original entry is. This way the [alt
version](1990/tbr/README.md#alternate-code) is equivalent in function, like the
author intended, but more compact.


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

BTW: why can't the fix:

```c
if (a[1]==NULL||a[2]==NULL||a[3]==NULL||a[4]==NULL||a[5]==NULL) return 1;
```

be changed to just test the value of `A` when `a` is argv and `A` is argc?

Cody also changed the code to use `fgets(3)`.

Since this program is so incredible the extra fixes were deemed worth having and
this is why it was done.

Cody later disabled a warning in the Makefile that proved to be a problem only
with clang in linux but which was defaulting to an error. This way was the
simplest way to deal with the problem in question due to the way the entry
works.

Yusuke pointed out that `atof` nowadays needs `#include <stdlib.h>` which was
used in order to get this to work initially (prior to this output was there but
incomplete).


## [1990/stig](1990/stig/stig.c) ([README.md](1990/stig/README.md))

Cody fixed the paths in the Makefile so that this would build in linux (it
worked fine in macOS).

He also changed the Makefile to use `bash` not `zsh` as not all systems have
`zsh` and the Makefile actually sets `SHELL` to `bash`.


## [1990/westley](1990/westley/westley.c) ([README.md](1990/westley/README.md]))

Cody fixed this for modern systems. It had `1s` in places for a short int which
was changed to just `1`.  Since it's instructional to see the differences he has
provided an alternate version, [westley.alt.c](1990/westley/westley.alt.c), which
is the original code.

He also fixed the code to not enter an infinite loop if arg is a number not > 0
and to not crash if no arg is specified.

The alt code did NOT have arg checks added as it is actually a copy of the
original code.


## [1991/ant](1991/ant/ant.c) ([README.md](1991/ant/README.md]))

Cody added [alt code](1991/ant/ant.alt.c) that will be a bit easier to use for
those familiar with vim in the following ways:

- Use `0` to go to first column.
- Use `$` to go to last column.
- Hit ESC to go back to command mode (instead of form-feed, ctrl-L).
- Use `w` to go forwards one word.
- Use `b` to go backwards one word.
- Use `q` to exit.

The other keys were left unchanged.


## [1991/brnstnd](1991/brnstnd/brnstnd.c) ([README.md](1991/brnstnd/README.md]))

Cody fixed this for modern systems. There were two invalid operands to binary
expression (`char *` and `void` and `int` and `void`) to resolve and
additionally a mis-feature of the C pre-processor which no longer works had to
be changed as well in order to get this to compile. In particular the macro `C`,
defined as `C =G` to make `+=` and similar operators no longer works.  The
invalid operands to binary expressions were resolved with the comma operator.

Later on, Cody added back the macro `#define D define` to make it look ever so
slightly more like the original, even though it's unused.


## [1991/buzzard](1991/buzzard/buzzard.c) ([README.md](1991/buzzard/README.md]))

Cody fixed this so that the coordinates being specified would not crash the
program. This happened because the function that calls `atoi(3)` took an arg
without any type specified and as an implicit int it was not a `char *` which
crashed the program in modern systems.

Cody also made the file name in the code (which is the default maze file) not
hard-coded but instead be `__FILE__`.

Finally Cody added the [alternate
version](1991/buzzard/README.md#alternate-code) which will possibly feel more at
home with those familiar with vi(m) (it certainly does feel more at home with
him): `k` for forward, `h` for left and `l` for right. This version also has a
more useful way to exit, just entering `q` followed by enter.


## [1991/davidguy](1991/davidguy/davidguy.c) ([README.md](1991/davidguy/README.md]))

As some systems like macOS can be particular about not declaring functions Cody
added to the Makefile some `-include` options. These appear to not be strictly
necessary but it was done due to other syscalls being a problem not being
declared first.


## [1991/dds](1991/dds/dds.c) ([README.md](1991/dds/README.md]))

Cody fixed a segfault that prevented this entry from working in any condition
and he also made it work for clang. He also added checks for NULL `FILE *`s.
Furthermore he changed it so that the C from the BASIC uses `fgets()`, not
`gets()`. For the magic of clang and `fgets()` see below.

Clang (at least in some systems?) defaults to having `-Werror` and the code that
the entry generates had some warnings that were causing compilation to fail if
`cc` is clang as it just ran `cc a.c`. It ran it by what was once `system(q-6);`
but if `cc` is clang like in macOS this is not enough.

(Cody said he stupidly did the below manually until he thought to write a simple
program to do the conversions which he used for `gets()` to `fgets()` and for
making the generated code return a value from `main()` rather than just
`return;`).

The following had to be added to the string `s` (which to fix the segfault was
changed from `char*s` to `char s[]`):

```
!.Xop.fssps!.Xop.sfuvso.uzqf!.Xop.jnqmjdju.gvodujpo.efdmbsbujpo
```
and then the call to `system()` had to be changed to:

```c
system(q-69);
```

An important point is that the placement of this string in the `s` array does
matter. This is because of the code:

```c
*o=fopen(q-3,"w");
```

which means the file name that translates to `a.c` has to be at the end of the
string. Thus the end of the string actually looks like:

```
!.Xop.fssps!.Xop.sfuvso.uzqf!.Xop.jnqmjdju.gvodujpo.efdmbsbujpo!b/d
```

But then there is the matter of getting the C to use `fgets(3)`. As can be seen
above it's not as simple as changing `gets(3)` to `fgets(3)`. This was more magic
characters that had to be updated and some added. The C code:

```c
atoi(gets(b))
```

is in the string:

```
bupj)hfut)c**
```

which was changed to be (in C):

```c
atoi(fgets(b,99,stdin))
```

which in the program is:

```
bupj)ghfut)c-::-tuejo**
```

That's fine and well but since the code does not include `stdio.h` there
obviously would be a compilation error. Thus the compiler line had to updated to
have `-include stdio.h` which in this rotated string is:

```
.jodmvef!tuejp/i
```

which had to be added after:

```
efdmbsbujpo!
```

which is the end of the warning disabled for clang as described above.

But now the `system(q-69);` had to be changed to `system(q-86);`.

Then, later on, Cody discovered that in some systems, clang triggers even more
warnings so this had to be corrected too so the string was updated again and
the `system(q-86)` had to be changed to `system(q-104)`.

But then to prevent the need for disabling a warning and to be more correct
code, the generated code was changed to `return 1;` rather than just `return;`.
Thus in full the string became:

```c
char s[]="Qjou!s\\311^-g\\311^-n\\311^-c\\::^-q-ma%mO1JBHm%BQ-aP1J[O1HB%[Q<n\
bjo)*|gps)<<*txjudi)m*|aQdbtf!::::;sfuvso!2<aQefgbvmu;aQ<m,,a%CQ<csfbla%bQ<a\
N2!Q\ndbtf!aP2Q;m>aP2Q<a%!D12J!JGJHJOJQJFJSJJJMHS%HD12D12N3!N4\nJUJT%UQm>aP4\
HC%TQs\\q,,^>m,2<m>aP4HC%SD12N1\nJNQm>s\\..q^aHC%NHb%GN1!D32P3%RN1UP1D12JPQU\
aP1HR%PN4\nQ<g\\(aP3Q(^>aP2Q,2<n\\(aP3Q(^>aP4Hb%OD12D12N2!N3\nJVP3Q,,<jg)aP3\
Q=>n\\(aP3Q(^*m>g\\(aP3Q(^<fmtf!m,,aHC%QN1!N1\nJ#Qqsjoug)#&e]o#-aP1Q*aHb%#Qq\
vut)aP1Q*aHb%FN1\nQm>::::aHC%VP3Q>bupj)ghfut)c-::-tuejo**aHb%JD12JON1!Qjg)a%\
LN1UP1D12JIQUaP1HL%IQ*m>aN2!N2\nP2Q<fmtf!m,,aHC%MN1!N2>P2Q>aN2\nP2Hbdd!.Xop.\
fssps!.Xop.jnqmjdju.gvodujpo.efdmbsbujpo!.Xop.jnqmjdju.jou!.jodmvef!tuejp/i!\
b/d";
```

and it now is `system(q-87);`.

It is hoped that this is the last time the string has to be updated to work with
all versions of clang but if not the above is how it works.

With these changes in place it will compile and work with both gcc and clang and
the C code generated will use `fgets(3)`, not `gets(3)`, therefore removing the
annoying warnings. Note that the array passed to `fgets(3)` is an int but that
was the same for `gets()` and is not necessary to update to a `char[]`.

The key to the string is that it rotates the character by `+1`. This was not
immediately clear until reading the author's remarks so there was an alt version
that was something of a kludge, running `make a` instead but that was removed.

Cody also fixed a typo in LANDER.BAS and made it so that if a file could not be
opened for reading or a file could not be opened for writing it would not crash.
The definition of whether that should be a bug to fix or a feature to not fix
was pondered and changed numerous times and ultimately that problem with this
entry was fixed. It has not been done in all.


## [1991/fine](1991/fine/fine.c) ([README.md](1991/fine/README.md))

Cody made it look much more like the original entry even after the fix that
increased the count in characters from 80 to 106, getting it back down to just
85 (and later back down to 80, see below).

This was done by redefining `main` at the compiler line so that it looks like
the original where one didn't have to worry about the type of args of main() and
there were other fewer restrictions and also by removing a cast that was
not strictly necessary (this does create a new warning: `ordered comparison
between pointer and integer ('char **' and 'int')` but it works just `fine`).

That was `fine` as well but Cody decided to drop it back down to its original 80
which also resolved the warning described above. This was by more clever use of
the Makefile which now has a `-DB=(int)b` so that `B` can be used in place where
`(int)b` used to be necessary.

Cody also added the [try.sh](1991/fine/try.sh) script which feeds the program
some fun input for fun but mostly different output. He added a great string from
Brian Westley and Cody also added several of his own (can you figure out exactly
which ones? :-) )


## [1991/rince](1991/rince/rince.c) ([README.md](1991/rince/README.md))

Cody fixed it so that the messages that show if you won or lost will be seen
after the end of the game. The reason it did not work before is curses was ended
at the end of the program which clears the screen. To make it look most like the
original entry Cody left the message before ending curses in and printed another
message of the same kind after `endwin()` was called with the exception that he
added a newline at the end of the screen to be more user friendly.

Cody also added two alt versions, one to remove the maximum number of moves you
may make and another to let you configure the maximum number of moves, even if
that is making it harder to win. Naturally the above fix was applied to these
versions too.


## [1991/westley](1991/westley/westley.c) ([README.md](1991/westley/README.md]))

Cody fixed a segfault in this program which prevented it from working. The
problem was that the read-only char array `char *z[]` was being written to. The
fix was to change it to `char z[][100]` in two spots (see if you can determine
why two places, not one!). Why 100 when the longest string is < 100? Because a
shorter value caused strange output and it's easier to just choose a larger
value that works without having to find the correct value.

Cody also fixed the `ttt.sh` script that prevented the game from working and he
also improved it so that warnings/errors/about to compile messages are not shown
unless the `-e` option is used.  This is because the errors being shown kind of
ruins the experience. Finally he made it pass ShellCheck.

Cody also added the alt version which is based on the author's remarks, a
version that supposedly (:-) ) always wins.

Cody also fixed the make clobber rule where a file was left lying about when it
should have been removed.


## [1992/adrian](1992/adrian/adrian.c) ([README.md](1992/adrian/README.md]))

Cody fixed the code so that it will try opening the file the code was compiled
from (`__FILE__`), not	`adgrep.c`, as the latter does not exist: `adgrep` is
simply a link to `adrian` as `adgrep` is what the program was submitted as but
the winner is `adrian.c`.

Not fixing the above problem would have also cause the program to crash if no
arg was specified as the file doesn't exist. In making the above fix, at first
the change to check for a `NULL` file was added. Then it was noticed that the
problem is that `adgrep.c` was an incorrect reference that never existed and it
was never fixed in any of the files, not the code or the documentation, and thus
was entirely incorrect code. A fun fact is that one can do:

```c
W= fopen(wc>= 2 ? V[1] : __FILE__,"rt");if(!W)exit(1);
```

but one _CANNOT_ do:

```c
W= fopen(wc>= 2 ? V[1] : __FILE__,"rt");if(!W)exit(1);
if (W==NULL)exit(1);
```

because `adwc.c` will be empty! The difference is it is on a newline, the check.
This is an example of how a simple change in code can break it and this is also
true of another change as further below.

Cody also restored a slightly more obscure line of code that had been changed:

```diff
-   putc("}|uutsrq`_^bji`[Zkediml[PO]a_M__]ISOYIRGTNR"[i]+i-9,stderr);
+   putc(i["}|uutsrq`_^bji`[Zkediml[PO]a_M__]ISOYIRGTNR"]+i-9,stderr);
```

though it's questionable how much more (if at all) obscure that is :-)

Cody also changed the location that it used `gets()` to be `fgets(3)`.
This was complicated because of how the other source files are generated (as
above); simply changing the code could cause invalid output in the program which
made other files fail to compile (for this example specifically, see below).

One might think that simply changing the `gets(3)` to `fgets(3)` (with `stdin`)
would work but it did not because `fgets(3)` stores the newline and `gets(3)` does
not. That is well known but this code was relying on not having this newline in
a different way (see also above).

With `fgets(3)` the code `if(A(Y)) puts(Y);` ended up printing an extra line
which made the generation of some files (like `adhead.c`) fail to compile. Why?
There was a blank line after a `\` at the end of the first line of a _macro
definition_! Thus the code now first trims off the last character of the buffer
read to get the same correct functionality but in a safe and non obnoxious way.

In this case the macro for `gets` could not be changed to have the macro do the
removal of the extra line (as in with a comma operator or a `&&`) as this, as
might be expected from the above, caused compilation errors with another
generated file (`adwc.c`)! Thus after the `gets(3)` call in the line that looks
like:

```c
while( gets(Y) ){ Y[strlen(Y)-1]='\0'; if(A(Y)) puts(Y); }
```

one must keep the `Y[strlen(Y)-1]='\0';` part and keep it there.

These fixes are complex changes due to the way the program and Makefile generate
the additional tools.


## [1992/albert](1992/albert/albert.c) ([README.md](1992/albert/README.md]))

Cody fixed this to compile with modern systems. Note that in 1996 a bug fix was
applied to the code, provided as the alt code as that version is not obfuscated.
Thus Cody's fix applies to the original entry. The problems were that `malloc.h`
is not the correct header file now (at least in some systems?) and a non-void
(implicit int) function returning without a value. That function was changed to
return void.


## [1992/ant](1992/ant/ant.c) ([README.md](1992/ant/README.md]))

Cody fixed the Makefile so that the program will actually work with it (or at
least the rule to clobber files and link `am` to `ant`). The issue was that the
variables in the Makefile could not be evaluated in the same way as it's not as
feature-rich as other implementations of `make`. Thus the use of `${RM}` and
`${CP}` were in the respective rules changed to `rm` and `cp`, for two examples.
A new rule had to be added as well. The variable situation might be because they
are obtained from the root variable Makefile `var.mk` via `include` which the
program might not support (this has not been tested, however) and also because
it appears that the syntax for this program is to use `$()` rather than `${}`.

Cody also fixed another problem, unrelated, in the Makefile with the `.PHONY`
rule where a line was not ended with a `\` but should have been.

The author stated that in some systems like DOS with Turbo C, it might be
necessary to include `time.h` so Cody did this as well.


## [1992/buzzard.1](1992/buzzard.1/buzzard.1.c) ([README.md](1992/buzzard.1/README.md))

Cody added a check for the right number of args, exiting 1 if not enough (2)
used. This was not originally done but at a time it was changed to be considered
a bug so it was fixed at that point as it only took a few seconds and had to be
verified that it was consistent with the [bugs.md](/bugs.md) file.

He also added the [try.sh](1991/buzzard.1/try.sh) script to try out some
commands that we suggested and some additional ones that provide for some fun.


## [1992/gson](1992/gson/gson.c) ([README.md](1992/gson/README.md]))

Cody fixed a crash that prevented this entry from working in some cases in some
systems (like macOS) by disabling the optimiser in the Makefile.

Cody also changed the buffer size in such a way that `gets(3)` should be safe
(theoretically) as it comes from the command line (though it can also read input
from stdin after starting the program). Ideally `fgets(3)` would be used but this
is a more problematic.  Previously it had a buffer size of 256 which could
easily overflow. In this entry `gets(3)` is used in a more complicated way:
first `m` is set to `*++p` in a for loop where `p` is argv. Later `m` is set to
point to `h` which was of size 256. `gets(3)` is called as `m = gets(m)`) but
trying to change it to use `fgets(3)` proved more a problem. Since the input must
come from the command line Cody changed the buffer size to `ARG_MAX+1` which
should be enough (again theoretically) especially since the command expects
redirecting a dictionary file as part of the command line. This also makes it
possible for longer strings to be read (in case the `gets(3)` was not used in a
loop).

Cody also added the [mkdict.sh](1992/gson/mkdict.sh) script that the author
included in their remarks. See the README.md for its purpose. It was NOT fixed
for ShellCheck because the author deliberately obfuscated it so **PLEASE DO NOT
FIX THIS**.


## [1992/imc](1992/imc/imc.c) ([README.md](1992/imc/README.md]))

The original code, [imc.orig.c](1992/imc/imc.orig.c), assumed that `exit(3)`
returned a value but this will cause problems where `exit(3)` returns void. The
source code was modified to avoid this problem but like Cody did with other fixes
he made this more like the original by redefining `exit` to use the comma
operator so that it could be used in binary expressions.


## [1992/kivinen](1992/kivinen/kivinen.c) ([README.md](1992/kivinen/README.md]))

It was observed that on modern systems this goes much too quick. Yusuke created
a patch that calls `usleep(3)` but Cody thought the value was too slow so he
made it a macro in the Makefile `Z`, defaulting at 15000. This was made an [alt
version](1992/kivinen/kivinen.alt.c) and it is recommended one use the alt
version first. See the README.md file to see how to reconfigure it.

Cody also made the fixed version (the code relied on `exit(3)` returning to use
in binary expressions) (and alt code from it) more like the original by renaming
the `ext` macro to be `exit` which uses the comma operator. He made it so the
line lengths match the original code, at least as best as possible (if not
perfectly), including start and end columns, often (if not all) with the same
start and end character.

Yusuke also noted that there is a bug in the program where right after starting
it moves towards the right but if you click the mouse it goes back.


## [1992/lush](1992/lush/lush.c) ([README.md](1992/lush/README.md]))

Yusuke supplied a patch which makes this work with gcc. Due to how it works (see
Judges' remarks in the README.md file) this will not work with clang.

Cody also provided the `runme.sh` script to demonstrate it as using make was
problematic.

Cody made it use `fgets()` instead of `gets()`.

NOTE: this entry cannot work with clang due to different compiler messages. See
[bugs.md](/bugs.md) for details.


## [1992/nathan](1992/nathan/nathan.c) ([README.md](1992/nathan/README.md))

Cody added the original file back as it was deemed that the export restrictions
should no longer be a cause of concern for this entry. Doing this did require a
change to Cody's [2020/ferguson2](2020/ferguson2/README.md) entry as it's
referenced.

Cody cynically noted that if he goes quiet, for instance if he no longer
participates in the IOCCC, that it must be our fault! :-)

Cody also added the [try.sh](1992/nathan/try.sh) script that runs a few commands
that we suggested as well as one he provided.


## [1992/vern](1992/vern/vern.c) ([README.md](1992/vern/README.md]))

Cody fixed an infinite loop if one were to input numbers < `0` or > `077`. The
problem was that it tried to use `scanf(3)` with the format specifier `"%o %o"` in a
loop, reading again if `scanf(3)` did not return 2 (that was not a problem in
that `scanf(2)` will not return until the number of specifiers have been
processed or some error occurs) or a function it called returned non-zero.

Instead the fix involves the `scanf(3)` specifiers being `"%4s %4s" on two
new char arrays (always cleared in the beginning of the loop) and then using
`strtol(3)` with a base of `8` (as it's octal), checking for `< 0 || > 077` on
both numbers (using `"%o %o"` does not solve the problem).


## [1992/westley](1992/westley/westley.c) ([README.md](1992/westley/README.md]))

Cody fixed this to work for clang by changing the third and fourth arg of
`main()` to be `char **` inside `main()`; clang requires args 2 - 4 to be `char
**` and some versions do not even allow a fourth arg.

He also added the alternate version that the author gave in the remarks that is
specifically for the USA rather than the world. This had to be fixed for clang
as well to make the args of `main()` be the correct type and by moving the body
of main() to another function, `pain()`, which does the work since not all
versions of clang support four args to `main()`.

Cody also removed the restriction that one has to have a terminal that wraps at
80 columns so that as long as the terminal's columns (try `echo $COLUMNS`) is >=
80 it should work. As most people have wider terminals than back in 1992 this
should help make it much easier to use. Note that if the number of columns is <
80 it will not work right. The way this was done is that every 80 iterations in
the final loop it prints another newline. This fix has another bonus in that
resizing the terminal after running it should not mess up the display either,
unless of course it becomes too small.

Cody added the scripts [whereami.sh](1992/westley/whereami.sh) and
[whereami.alt.sh](1992/westley/whereami.alt.sh) which correspond to the entry and
the alt code but first check that the number of columns is at least 80 and if
not it is an error.

Cody added the [try.sh](1992/westley/try.sh) script that shows the different
cities that the author recommended one try as well as the one recommended by the
judges (approximate judging location), labelling each city and printing a
newline before the next city. The try.sh script uses the `whereami.sh` and
`whereami.alt.sh` scripts, as long as they're executable (if they're not it
first tries to make it executable and if it fails to do so it just uses
`westley` or `westley.alt`. The scripts can be deceived by `COLUMNS=80 ./try.sh`
(or `COLUMNS=80 ./whereami.sh` etc.) but this is a feature, not a bug.

Cody also added an arg check because the program and the
[alternate version](1992/westley/westley.alt.c) might have crashed or
[nuked](https://en.wikipedia.org/wiki/Nuclear_weapon) the [entire
world](https://en.wikipedia.org/wiki/Earth) or just the
[USA](https://en.wikipedia.org/wiki/United_States), respectively, without enough
args (2). And not that we need the help or anything for this :-) but we
encourage you to try the original without two args :-)


## [1993/cmills](1993/cmills/cmills.c) ([README.md](1993/cmills/README.md]))

Yusuke suggested that with modern systems this goes too fast so he added a call
to `usleep(3)` in a patch he made. Cody made it configurable at compilation by
using a macro. This is in the alt version which is the recommended one to try
first.


## [1993/dgibson](1993/dgibson/dgibson.c) ([README.md](1993/dgibson/README.md]))

Cody fixed the script to work which assumed that `.` is in the path.


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

Cody added check for two args.

Cody also added an [alternate version](1993/plummer/plummer.alt.c) which uses
`usleep()` so you can see what is happening with faster systems. This version
also checks for two args. See the README.md files for details.


## [1993/rince](1993/rince/rince.c) ([README.md](1993/rince/README.md]))

Yusuke supplied a patch to get this to work in modern systems. This fix also
applies the compatibility issue of `select(2)` described in the README.md file.

Cody added a call to `endwin()` to help with terminal sanity after the program
ends.

Cody provided two alternate versions to simplify slowing the game down and, for
the second one, to make movement keys (of the default game) more familiar to vi
users. The slowing down was based on our suggestion that it might be desired to
slow down but Cody did it in such a way that makes it easy to configure at
compile time. See the README.md for details.


## [1993/schnitzi](1993/schnitzi/schnitzi.c) ([README.md](1993/schnitzi/README.md]))

Cody made this use `fgets(3)` not `gets(3)`.


## [1993/vanb](1993/vanb/vanb.c) ([README.md](1993/vanb/README.md]))

Cody fixed this to work with clang. The problem was that the third arg to main()
was not a `char **`. Instead `O5()` (which was `main()` via `-DO5=main`) is now
its own function which main() calls with the right parameters.

Later Cody fixed it again to look much more like the original where only a
single line is added, that of `main()`, which calls `O5()`. This was done through
`-include stdio.h` at the compiler (in the Makefile) and by removing the `O3`
variable (an int) at the top of the file, instead making it a `char **` in
`main()` (`O5()` had three args) but then passing in `0` to `O5()` for the third
arg (as it was 0 at file scope already this is perfectly fine and it means
there's no need to cast it to an int in the function call though that would also
work).

Cody also added the alt code, provided by the author, which is:

```
... a version of the program before it got formatted into the VIII,
augmented with comments showing where each state begins. N1 and N2 are
notes.
```

but fixed to work with clang as well.

NOTE: the `N1` and `N2` are provided as notes in the README.md file describing
this code. Other code is also described there.


## [1994/dodsond2](1994/dodsond2/dodsond2.c) ([README.md](1994/dodsond2/README.md))

Cody fixed an infinite loop that could happen when you shoot an arrow and end up
having no arrows, thus making one force quit the game. The problem was in a
condition in the outer loop it would repeatedly get input (if `getchar()`
returned `'\n'`),  only if one has more than one arrow, returning after that.
But if there were 0 arrows left it did not return and so the loop started over,
doing nothing. This fix also seems to have fixed a problem where if you shoot
your last arrow it would not move you to the room you shoot into (whereas if you
had more arrows it would).

Cody added an alt version that allows one to cheat by specifying how many arrows
to start with (this was for fun but it turned out a good way to debug the above
infinite loop too).

As in some places it would properly say that you have '1 arrow' or else, if you
have any other number of arrows (including 0), it would say 'arrows', Cody fixed
a place where it always said 'arrows'. A minor fix and not that important.

Cody also fixed the problem where one could only get the arrows back from the
robber if the robber stole as many arrows as you ever found rather than that
minus how many you have shot. In other words if you had three arrows and shot
one and found no more you could never get the arrows back from the robber
because you could never lose all three since you spent one. This bug manifested
itself in another way too: once you got the arrows back the counter was not
reset so you could only get the arrows back once even if the robber stole more.
Now the counters are reset. The way this bug was fixed is that there is now a
counter for how many you have found and how many you shot in addition to the two
that already existed, how many you had and how many were stolen.


## [1994/horton](1994/horton/horton.c) ([README.md](1994/horton/README.md))

Cody fixed this to check that four args were specified. With the use of the C
pre-processor macro and inclusion of stdlib.h in the Makefile the layout of the
source is exactly the same column width and no additional lines were added. This
was done during one of the times where this was changed to bug status, for
better or worse.

Cody also fixed the Makefile which was causing alt code to be compiled when it
shouldn't be.


## [1994/ldb](1994/ldb/ldb.c) ([README.md](1994/ldb/README.md]))

Cody fixed this so it would compile and work with modern compilers. The problem
was that `srand()` returns void but it was used in a `||` expression. Thus the
comma operator was needed.

Cody also fixed it for clang under linux which objected to incompatible pointer
type (because `time(2)` takes a `time_t *` which in some systems is a `long *`
but what was being passed to it is an `int`).

Cody also changed the entry to use `fgets(3)` instead of `gets(3)`. This one has
a minor annoyance in that it now prints a newline after the output but this
seems like a worthy compromise for preventing the interspersed output in macOS
and at the same time it's safer (fixing it to not have the extra newline is more
problematic than it's worth and in macOS another line of output would be shown
without the change anyway and the difference is that now it's just a blank line
rather than an annoying warning).

A subtlety about this fix: if a line is greater than 231 in length if the
program chooses that line it might print the first 231 characters or it might
print (up to) the next 231 characters and so on.


## [1994/schnitzi](1994/schnitzi/schnitzi.c) ([README.md](1994/schnitzi/README.md]))

Cody added two alt versions, [one which uses
`fgets()`](1994/schnitzi/schnitzi.alt.c) but when fed its own source code cannot
generate code that compile and another [one with a bigger buffer
size](1994/schnitzi/schnitzi.alt2.c) which, when fed its own source code, will
generate compilable code but not with the same buffer size but rather the
original buffer size. Cody explains this in the at [1994/schnitzi in
bugs.md](/bugs.md#1994-schnitzi).

The purpose for these versions it both demonstrate how the magic works behind it
and to help others, should they wish, get the code to work with `fgets(3)`, with
or without an increase in buffer size. See [1994/schnitzi in
bugs.md](/bugs.md#1994-schnitzi) where Cody also explains the magic for more
details. Later on, if nobody takes up the task, Cody might resume it, but for
now there is more important work to do so that the next contest can run.


## [1994/shapiro](1994/shapiro/shapiro.c) ([README.md](1994/shapiro/README.md]))

Cody fixed a bug on systems where `EOF != -1`. The problem is that `getc()` and
the related functions do not return `-1` on EOF or error but rather `EOF`.
However `EOF` is not required to be `-1` but merely an int < 0 and this program
assumed that `getc()` will return `-1` on EOF or error, not `EOF`. On systems
where `EOF != -1` it could result in an infinite loop.

For an interesting problem that occurred here and what was done to solve it,
check the [bugs.md](bugs.md) file.


## [1994/tvr](1994/tvr/tvr.c) ([README.md](1994/tvr/README.md]))

Cody made this use `fgets(3)` instead of `gets(3)`. In this case the newline had
to be terminated but it was a pretty straightforward fix. `gets()` was defined
to use `fgets()` and the inclusion of `stdio.h` had to be added but to make it
more like the original entry this was done in the Makefile.

Note that the alt code does not use `fgets(3)` but rather `gets(3)`.


## [1994/westley](1994/westley/westley.c) ([README.md](1994/westley/README.md]))

Cody converted the spoiler compiler options (provided by the author) to be
compiler commands and added a script [spoiler.sh](1994/westley/spoiler.sh) to
automate the spoiler commands to make it easier to see the game in action from
start to finish.


## [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md]))

Cody fixed this so that it would work with macOS. Once it could compile it
additionally segfaulted under macOS which he also fixed.

Cody also provided the [Alternate code](1995/cdua/cdua.alt.c) for fun :-) ) (in
particular to make it easier to see the program do what it does in systems that
are too fast ... if there is such a thing anyway :-) ). See the README.md for
details on this.


## [1995/dodsond1](1995/dodsond1/dodsond1.c) ([README.md](1995/dodsond1/README.md]))

Cody added the [try.sh](1995/dodsond1/try.sh) script that uses the text file he
provided which is input we suggested one try with the entry.


## [1995/esde](1995/esde/esde.c) ([README.md](1995/esde/README.md]))

Cody added the [try.sh](1995/esde/try.sh) script.


## [1995/garry](1995/garry/garry.c) ([README.md](1995/garry/README.md]))

Cody fixed the alt code so that it will compile with modern compilers. The
problem was a missing `int` for the `f` variable. He felt it was even more
important that it works because the layout does indeed look to him like a rat is
dropping core :-), something that the judges suggested.

Cody also improved the script [garry.test.sh](1995/garry/garry.test.sh) to make
sure the program is compiled before trying to use it and he also added the
[garry.alt.test.sh](1995/garry/garry.alt.test.sh) script to use the alt version,
though the alt version is not as important as alt code in other entries.

The reason the alt script was added rather than using an environmental variable
to specify which one to use is to make it easier on the user as typing
`GARRY=garry.alt ./garry.test.sh` is not as simple (even though simple) as just
running `./garry.alt.test.sh`.


## [1995/leo](1995/leo/leo.c) ([README.md](1995/leo/README.md]))

At our change in how to deal with spoilers, Cody uudecoded the spoiler provided
by the author, putting it in [spoiler1.md](1995/leo/spoiler1.md).


## [1995/makarios](1995/makarios/makarios.c) ([README.md](1995/makarios/README.md))

Cody fixed this so that it will compile with versions of clang that has a defect
which only allows `main()` to have 0, 2 or 3 args. This is done by a new
function (`pain()` as it's annoying that clang is this way :-) ) that main()
calls which has the four args.


## [1995/vanschnitz](1995/vanschnitz/vanschnitz.c) ([README.md](1995/vanschnitz/README.md))

Cody added the authors' [spoiler as a C file](1995/vanschnitz/spoiler.c) as in
2023 we have decided that in most cases all the code should be available for the
wider audience, without having to extract it. The exception is when the files
are created by the entry or the entry decrypts the text or whatever else.


## [1996/august](1996/august/august.c) ([README.md](1996/august/README.md]))

Cody fixed a segfault in this program that prevented it from working right and
also fixed an infinite loop in the try commands. The problem with the infinite
loop is that the file `august.oc` had to have lines starting with `#` removed
and it was not being done. After this is done with say `sed(1)` (like `sed -i''
'/^#/d' august.oc` which has been added to both the remarks and the try.sh
script as described below) the code can proceed. This problem existed in macOS.

Cody also added the [try.sh](1996/august/try.sh) script that runs all the
commands given in the try section to simplify it as there are quite a lot of
commands.


## [1996/dalbec](1996/dalbec/dalbec.c) ([README.md](1996/dalbec/README.md]))

Cody proposed a fix for this to compile with clang and Landon implemented it
after some discussion (though Cody changed the function name). The reason Cody
did not do it is because he thought it was the wrong output but as it happens
the try section below was worded a bit confusingly. He looked at Yusuke's
analysis found
[here](https://mame-github-io.translate.goog/ioccc-ja-spoilers/1996/dalbec.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp)
but he missed that Yusuke added a '...' after the result which made him think
the fix was wrong.

Cody also made the recommended change of the author to make it so that each
number is printed on a line by itself rather than having a long string of
numbers on the same line. This was not put in an alternate version but perhaps
it should be.


## [1996/eldby](1996/eldby/eldby.c) ([README.md](1996/eldby/README.md]))

Cody provided an [alternate version](1996/eldby/eldby.alt.c) which uses
`usleep()` in between writing the output to make it easier to see what is going
on with faster systems and importantly also for those who are sensitive to text
flashing by rapidly (it affects him too but he also thinks it moves too fast
nowadays anyway). We recommend that you try the alternate version first due to
these reasons.


## [1996/gandalf](1996/gandalf/gandalf.c) ([README.md](1996/gandalf/README.md]))

Cody fixed this to compile and work with modern systems. As he loved the
references in the code that could not compile he just commented out as little as
possible to get this to compile.

Cody also added the rather useful [try.sh](1996/gandalf/try.sh) script to
really demonstrate the different ways of running the program ends up showing
either different output or the same output that we briefly pointed out.

BTW: it is perilous to try the patience of
[Gandalf](https://www.glyphweb.com/arda/g/gandalf.html). Go ahead, try it! :-)


## [1996/huffman](1996/huffman/huffman.c) ([README.md](1996/huffman/README.md]))

Cody added the [try.sh](1996/huffman/try.sh) script.


## [1996/jonth](1996/jonth/jonth.c) ([README.md](1996/jonth/README.md]))

Cody fixed this to not segfault under macOS. The problem was that the function
pointer `w`, which points to `XCreateWindow()`, did not specify the parameters of
the function in the pointer assignment.

NOTE: if there is no X server running this program will still crash.


## [1996/schweikh1](1996/schweikh1/schweikh1.c) ([README.md](1996/schweikh1/README.md]))

The author stated that `-I/usr/include` is needed by gcc in Solaris because
`errno.h` has two identical extern declarations of `errno`. That leads to an
error due to the redefinition of `main` but the `-I` option makes sure the
working `/usr/include/rrno.h` is found first, which shouldn't cause any problems
on other systems (the other file is
`gcc-lib/sparc-sun-solaris2.5/2.7.2/include/errno.h`). Thus Cody added this to
the Makefile despite the fact that very few probably use Solaris nowadays.



## [1996/schweikh2](1996/schweikh2/schweikh2.c) ([README.md](1996/schweikh2/README.md]))

Cody added the [try.sh](1996/schweikh2/try.sh) script with a few commands to try
along with a shorter version of something the author suggested one try (it is
suggested that one try the longer version too but it will run in an infinite
loop so having it in a script is less desired).


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

Cody also added the two scripts, [try.sh](1996/westley/try.sh) and
[try.alt.sh](1996/westley/try.alt.sh) to show automate showing the different
clocks, both with the fixed version and the original (alt) version.

Also, to fix any potential problem with displaying in GitHub the scripts
provided by the author, Cody added '.sh'.


## [1998/banks](1998/banks/banks.c) ([README.md](1998/banks/README.md]))

Cody set up the Makefile to have an alt build (using the same code) for those
who do not have a page up or page down key and added the
[keysym.h](1998/banks/keysym.h) header file as a reference for other keys one
can use if they wish to modify the controls. One can certainly do this even if
they do have page up and page down but this gives a default for those who don't
have them like with Macs.


## [1998/bas2](1998/bas2/bas2.c) ([README.md](1998/bas2/README.md]))

Cody added the [try.sh](1998/bas2/try.sh) script which runs some default actions
as well as allowing one to pass in different file names or strings.


## [1998/chaos](1998/chaos/chaos.c) ([README.md](1998/chaos/README.md]))

Cody added a call to `endwin()` to restore terminal sanity (echo etc.) when
exiting the program (in both versions).


## [1998/df](1998/df/df.c) ([README.md](1998/df/README.md]))

Cody changed a `int *` used for `fopen(3)` to be a `FILE *` to be more correct
and prevent any possible problems in some systems (which has happened).

Cody also made the fixed version look more like the original version by using
the old style of `main()` args so that it read `i,love_unix` more naturally, and
by changing the typedef `lint` (to `int` - see the code for why this has to be
done in modern systems) to be `_int`.


## [1998/dlowe](1998/dlowe/dlowe.c) ([README.md](1998/dlowe/README.md]))

Cody made the program more portable by changing the void return type of `main()`
to be `int` (in both versions).

Cody added the scripts [try.sh](1998/dlowe/try.sh),
[pootify.sh](1998/dlowe/pootify.sh) and
[pootify.cgi.sh](1998/dlowe/pootify.cgi.sh) for a fun example use of the
program, a local pootifier of web pages and a CGI pootifier. It should be noted
that the CGI version might have an issue with modern systems; see [historical
remarks](1998/dlowe/README.md#historical-remarks) for more details on the
pootify scripts.


## [1998/dloweneil](1998/dloweneil/dloweneil.c) ([README.md](1998/dloweneil/README.md]))

Cody added [alt code](1998/dloweneil/dloweneil.alt.c) which has vi(m) movement
(in addition to the other keys except for dropping it's not `d` but `j` or
space) keys as well as allowing one to quit the game.


## [1998/dorssel](1998/dorssel/dorssel.c) ([README.md](1998/dorssel/README.md]))

Cody added the [try.sh](1998/dorssel/try.sh) script.


## [1998/fanf](1998/fanf/fanf.c) ([README.md](1998/fanf/README.md))

Cody fixed this to compile. The problem was the intermediate steps to get to the
final code that is compiled. The code is now what it essentially becomes when
processed completely. The intermediate steps can now be performed to see how it
expands but it can still compile and be used.

Cody also added the [try.sh](1998/fanf/try.sh) script to show the output of some
of the expressions that we selected.


## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md]))

Cody fixed invalid data types which prevented this entry from working, causing a
segfault. This showed itself in two parts which required two fixes, one for
linux and further changes for macOS. He also fixed a segfault (after printing
garbage) when the arg specified evaluated to 0. It was decided by us, the
judges, that these segfault fixes should be made because the program is so
beautiful.

Later on Cody improved the fixes by checking that the arg is a number `>0 &&
<27` as that was noted by the author as a requirement and again since it's such
a beautiful program it is worth it, especially as the larger the number the
larger the resulting program becomes. It can be gigabytes in length if it
doesn't crash. At this point since the author stated it has no `while`,
`do...while`, `for`, `if/else`, `switch`, `?:` Cody removed the if statement by
doing:

```c
((V[1]&&((atoi(V[1])>0&&atoi(V[1])<27))||(exit(1),1)));
```

Cody also added the [try.sh](1998/schnitzi/try.sh) script to help users try the
commands that we recommended as well as some added by him.


## [1998/schweikh1](1998/schweikh1/schweikh1.c) ([README.md](1998/schweikh1/README.md]))

Cody fixed this for modern systems (it did not work at all) and added an
alternate version that works with macOS. Cody also made it ever so slightly more
portable by removing the hard-coding of `gcc`, instead hard-coding it `cc`. Doing
this not only lets it work with systems without `gcc` (though in macOS it does
exist but is actually `clang`) as `cc` always should.
Getting this entry to work was quite complicated but is also very interesting.

To see how the macOS fixes works, see the [macos.md](1998/schweikh1/macos.md)
file but do note that this includes spoilers for both versions! The fixes to get
it to work at all are described next.

So what was wrong with the original?

The call to `freopen(3)` was incorrect with the second arg (the mode) being
`5+__FILE__`; it is now `"r"`. (Observe that the mode to the `fopen(3)`
call is: `43+__FILE__`. This might seem incorrect and indeed it can be changed
to `"r"` as well but this was not actually necessary so once this was noticed it
was changed back to the original.)

Another important change is that the files are only closed if the `FILE *H` is
`!= NULL`. Without this check, because it's almost certain that some files will
not exist, it would dereference a NULL pointer and very likely crash or halt and
catch fire :-), preventing the entry from working. Notice how `H` is a funny
macro defined as:

```c
%:define H(x) <st%:%:x##.h>
```

and yet the `FILE *` can be called `H`! This might or might not make sense to
you but if it doesn't can you figure out why?

Another fix is that previously the program would `return 1` if a file failed to
open but for the same reason as above, it being very likely some files will not
exist, the return was removed so that if the statement of the `if` is true the
`while` loop run, rather than having the loop by itself. It was done this way to
make it as close to the original as possible and to maintain the obfuscation as
close as possible as well.

Also crucial, and the final fixes to make it work, is that the arrays `K` and
`L` had to be increased in size. They were originally (somewhat bewildering at
first glance) defined as `K[X(*)], L[X(<<)]` but they were changed to
`K[(X(*))*4], L[4*X(<<)]` though it is no longer clear just how necessary this
might be.

As noted, a limitation of `gcc` existing was removed by Cody to make it so that
`gcc` is not required as `cc` should exist in every system with a C compiler and
as the author stated: as long as the options `-E -dM` of the compiler prints out
the macros in the form of `gcc -dM` i.e. the lines are in the form `#define
MACRO value` it will work, assuming that compiler can run, of course.

Cody also added the perl script that the author provided that they used to
compute the character count in the code according to the contest rules of 1998
in the file [charcount.pl](1998/schweikh1/charcount.pl).


## [1998/schweikh2](1998/schweikh2/schweikh2.c) ([README.md](1998/schweikh2/README.md]))

Cody fixed the code to not trigger an internal compiler error in gcc:

```
:10:16: warning: type defaults to 'int' in declaration of 'zero' [-Wimplicit-int]
: In function 'main':
:12:1: warning: missing terminating " character
:12:19: internal compiler error: invalid built-in macro "__FILE__"
```

The string `"01\015"` had to be changed to `ONE(O(1,1,2,6,0,6))`. For an
interesting historical explanation and further details and fun, see the
[historical remarks](1998/schweikh2/README.md#historical-remarks) in the
README.md.


## [1998/schweikh3](1998/schweikh3/schweikh3.c) ([README.md](1998/schweikh3/README.md]))

Cody added the [alternate code](1998/schweikh3/README.md#alternate-code) which allows one
to reconfigure the size constant in the rare case that the author wrote about
occurs.

Cody added the [try.sh](1998/schweikh3/try.sh) script to make it easier to try
the commands that we suggested. One command was not added, that of the to use
command.

Cody also made the Makefile rule `all` symlink the entry to `samefile` as that
is the name of the program.

The author stated that:

```
In the remote event that the input has more than `8192` files with
the same size (on systems where `sizeof (char *) == 4`, or `4096` when
`sizeof (char *) == 8`), increase the manifest constant 32767 on line
31.
```

so Cody changed the constant to a macro in the Makefile called `SZ` so one can
more easily do this (though it indeed seems highly unlikely). See the README.md
for more details.

There actually is a web page for the tool and this was added to the author
information for the entry. It has not been added to any JSON file.


## [1998/tomtorfs](1998/tomtorfs/tomtorfs.c) ([README.md](1998/tomtorfs/README.md]))

Cody fixed the assumption that `EOF` is `-1` (the author noted that it assumes
it is `-1` and it's indeed a valid concern as the standard only guarantees that
it's a value `< 0`) and that `1` is a valid code to return failure (it seems
unlikely that it wouldn't be but since the author suggested it it was changed to
`EXIT_FAILURE`). To make it so the lines end at the same columns as the original
the `EXIT_FAILURE` change was done by redefining `exit(3)` to be `exit(a) return
EXIT_FAILURE` and `1` was passed to it (`return` was used because the original
program  had `return 1`).

Cody also added the [try.sh](1998/tomtorfs/try.sh) script to try out a few
commands that we recommended.


## [2000/anderson](2000/anderson/anderson.c) ([README.md](2000/anderson/README.md]))

Cody changed this entry to use `fgets(3)` instead of `gets(3)`. This involved
changing the `K` arg to `gets(3)` to `&K` in `fgets(3)`.

Cody also added the [try.sh](2000/anderson/try.sh) script.


## [2000/bmeyer](2000/bmeyer/bmeyer.c) ([README.md](2000/bmeyer/README.md]))

Cody added the [try.sh](2000/bmeyer/try.sh) script with some improvements to the
commands we recommended like not assuming the number of columns one has in their
terminal.


## [2000/briddlebane](2000/briddlebane/briddlebane.c) ([README.md](2000/briddlebane/README.md]))

Cody fixed this to compile in systems that require one to explicitly link in
`libm`.


## [2000/dhyang](2000/dhyang/dhyang.c) ([README.md](2000/dhyang/README.md]))

Cody made this more portable by changing the `void main` to `int main`.

He also added the [try.sh](2000/dhyang/try.sh) script.


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

Later on Cody restored the `#include`s in the source code which had been changed
by us to make it a one-liner again but this was an error as it was not a
one-liner but rather a small program. At the same point Cody made the code
itself a one-line like the code is in the original entry. Now it looks much more
like the original entry but with the two fixes.


## [2000/primenum](2000/primenum/primenum.c) ([README.md](2000/primenum/README.md]))

Cody made this more portable by changing the `void main` to `int main`.

Cody also added the [try.sh](2000/primenum/try.sh) script.


## [2000/rince](2000/rince/rince.c) ([README.md](2000/rince/README.md]))

Cody added the [try.sh](2000/rince/try.sh) script.


## [2000/robison](2000/robison/robison.c) ([README.md](2000/robison/README.md]))

Cody fixed an infinite loop that occurred if invalid input was entered, flooding
the screen with:

```
Black position and direction: illegal
```

This was fixed by having the `scanf(3)` read in a string and then use `atoi(3)`
on it to assign to the `int`s, much like with `1987/lievaart`. The strings are
`char[5]` and the `%` specifier is `%4s` which is enough for the game.


## [2000/thadgavin](2000/thadgavin/thadgavin.c) ([README.md](2000/thadgavin/README.md]))

Cody fixed the code and added an appropriate make rule so that the SDL version
works independent from the curses version (using the same code).

Cody also added alt code to allow one to slow down the code. This code also, at
least for the curses mode, allows one to quit at any time by pressing 'q'. See
below for more details.

Due to a terrible design choice of the SDL1 developers something had to be
changed. As was noted in the log:

```
The SDL version did not work for a number of reasons. First of all the
code requires that SDL is defined. Second the path[sic] wrong header file was
included. Third the SDL1 developers thought it would be a great idea
(but obviously it's a terrible idea) to redefine main() (!!) so that any
program that uses SDL1 has to have the same args as their definition.
This program had 'main()' so the error message was:

    thadgavin.c:60:1: error: conflicting types for 'SDL_main'
    main()
    ^
    /opt/local/include/SDL/SDL_main.h:34:14: note: expanded from macro 'main'
    #define main SDL_main
		 ^
    /opt/local/include/SDL/SDL_main.h:35:12: note: previous declaration is here
    extern int SDL_main(int argc, char *argv[]);
	       ^
    1 warning and 1 error generated.
    make: *** [thadgavin_sdl] Error 1

Thus main() was changed to 'int main(int argc, char **argv)'.
```

Cody also added an alternate version to help see what is going on in more modern
systems and in case you're sensitive to rapidly moving swirling. See the
README.md for details on that. Note that this alternate version only will impact
the curses and the SDL versions as Cody does not have a DOS system to test the
other version in.


## [2000/tomx](2000/tomx/tomx.c) ([README.md](2000/tomx/README.md]))

Cody added the [alt code](2000/tomx/README.md#alternate-code) based on the
author's remarks with a fix for modern systems and he also added the two
scripts, [try.sh](2000/tomx/try.sh) and [try.alt.sh](2000/tomx/try.alt.sh) for
the main code and the alt code respectively.

And although the scripts do `chmod +x` on the source code (see the README.md for
details) the source code is now executable by default.


## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md]))

Cody fixed both the supplementary program and the program itself (both of which
segfaulted and once that was fixed only the binary was modified; it was not run
but according to the author's remarks it should be executed). He managed to do
this with linux but it will not work with any system that does not allow one to
compile 32-bit ELF binaries. See [bugs.md](/bugs.md#2001anonymous-readmemd) for
why this is; _this is **not** a bug, it's a feature_ inherent in what it does!

The following had to be done to fix this:

- `#include <sys/mman.h>` for `mmap()` and `munmap()`.
- have `main()` call another function which is no longer a recursive function;
this prevented `main()` from entering an infinite recursive loop.

Without these it would crash and prevent modification of the 32-bit
[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) (not elf :-) )
binary. But again see [bugs.md](/bugs.md) here.

These also had to be done:

- when `open()`ing the file the file descriptor had to be saved so it could be
closed prior to executing the program. This is the `f` variable which an `int`.
- `munmap()` also had to be called prior to executing the program. This involved
a new `off_t N` which was added in the `mmap()` call which was then used in
the `munmap()` call.

Without those changes the program was not executed after modification which it
was supposed to do; instead it reported text file busy error.

Notice that the location of `munmap()` and `close()` followed by `execv()` _does
matter_!

To get this to compile with clang, `main()` had to change from:

```c
main (char *ck, char **k)
```

to:

```c
int main (int cka, char **k) { char *ck = (char *)cka; /* ... */ }
```

The following change was also made to be more portable, in case the constants
`PROT_READ` and/or `PROT_WRITE` are not standardised or some platform does not
follow it:

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

or to not use `git`:

```sh
make diff_orig_prog
```

Cody also added a [program](anonymous.bed.c) like [anonymous.ten.c](anonymous.ten.c)
[Ten Green Bottles](https://en.wikipedia.org/wiki/Ten_Green_Bottles) but which
sings [Ten in the Bed](https://allnurseryrhymes.com/ten-in-the-bed/) instead.

As well he added the [try.sh](2001/anonymous/try.sh) so that one can
attempt to use the program as it was designed but if compiling as 32-bit fails
it will at least run the supplementary program as a 64-bit program directly.


## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md]))

Cody fixed this to compile with clang but according to the author this will not
work without i386 linux. It generates i386 32-bit code (not bytecode) but
unfortunately it will not work without i386 linux. See [bugs.md](/bugs.md).

Cody fixed an earlier segfault so that it can at least now open the file should
you have an i386 linux machine (it can open it in other platforms too, of
course, but it won't work). This involved pointer updates and also changing an
`int` to a `FILE *`. Where possible he left the macros as the same but in the
case of `main()` this was not possible.

Yusuke added another change (see below) to make it even more portable across
compilers besides what Cody did.

Cody entirely fixed the [supplementary
bellard.otccex.c](2001/bellard/bellard.otccex.c) so it does not segfault and
works as well (it did not work at all). The main problem was that some ints were
being used as pointers.  This includes, for example, an int used as a `char *`,
an int used as a function pointer and an int to access `argv` as well as there
being invalid access to `argv`. He updated the Makefile so that this program
will compile by default.

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
have a third arg as an int, not a `char **`. He chose `pain()` because it's a four
letter word that would match the format and because it's pain that clang forces
this. :-) This fix makes a point of the author's notes on portability no longer
valid, btw.

Cody also added the [try.sh](2001/cheong/try.sh) script.

He also fixed it to check the number of args.


## [2001/coupard](2001/coupard/coupard.c) ([README.md](2001/coupard/README.md]))

Cody added a value to `return` in `main()` to make it more portable.

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

This was not really worth a thanks per se but it was originally done by adding
`int`. The better solution is to disable the warning which is what was done
later on to make it more like the original.

Yusuke provided a proper command line for macOS (to do with sound; see his
[/2013/endoh3/README.md](2013/endoh3/README.md) entry where he also refers to
sound devices in macOS).


## [2001/ctk](2001/ctk/ctk.c) ([README.md](2001/ctk/README.md]))

The ANSI escape codes were no longer valid but Yusuke provided a patch to fix
the ANSI escape codes. This works with both linux and macOS.

Cody fixed this so that it should always restore terminal sanity (echo enabled
etc.) after exiting even if you don't press 'q', if you crash or if you kill the
program prematurely. This was done by adding an explicit call to `e()` at the
end of `main()`.

Cody also added the [alt code](2001/ctk/README.md#alternate-code) that adds
vi(m) movement keys.


## [2001/dgbeards](2001/dgbeards/dgbeards.c) ([README.md](2001/dgbeards/README.md]))

The author provided two changes: one to speed it up and one to make it not crash
on losing. Cody provided an alternate version which does the former but he felt
that the idea of crashing on losing (see the README.md for details on why that
might be) too good to get rid of so he kept that in.

He also points out that there is a way to get the computer to automatically lose
very quickly. Do you know what it is?


## [2001/herrmann1](2001/herrmann1/herrmann1.c) ([README.md](2001/herrmann1/README.md]))

Cody fixed this so that the when compiling the code the program is not executed
itself by itself which just showed the usage string and exited. The [script
herrmann1.sh](2001/herrmann1/herrmann1.sh) is used to compile the program but
it's also how you invoke the program.

Cody provided the file [plus1.turing](2001/herrmann1/plus1.turing) based on the
author's remarks.

He also fixed the [script herrmann1.sh](2001/herrmann1/herrmann1.sh) for
shellcheck. In particular there were quite a few:


```
SC2086 (info): Double quote to prevent globbing and word splitting.
SC2248 (style): Prefer double quoting even when variables don't contain special characters.
```

errors/warnings.


## [2001/herrmann2](2001/herrmann2/herrmann2.c) ([README.md](2001/herrmann2/README.md]))

Cody fixed this to work with both 64-bit and 32-bit compilers by changing most
of the `int`s (all but that in `main(int ...)`) to `long`s. He also fixed it to
compile with clang by changing the args of main to be `int` and `char **`,
respectively, and changing specific references to the `argv` arg, casting to
`long` (was `int` but the 64-bit fix requires `long`) which was its old type.

Cody also added the [try.sh](2001/herrmann2/try.sh) script which might be more
useful than any other place as the command to try is quite long with C code.

For some reason the original code was missing (presumingly because it had been
added to `.gitignore` by accident) but Cody restored it from the archive.


## [2001/kev](2001/kev/kev.c) ([README.md](2001/kev/README.md]))

Cody slowed down the ball just a tad (it was already a `-D` macro that was used
in the code) as it went too fast for the speed at which the paddles move even
when holding down the movement keys (but see below).

Cody also provided an [alternate version](2001/kev/kev.alt.c) which lets you use
the arrow keys on your keyboard instead of the more awkward '`,`' and '`.`'.

He updated both versions to have `#ifndef..#endif` pairs for the macros so one
can more easily configure different settings without having to specify all of
them. The speed, `SPEED`, will be set to 50 if it's not defined at the compiler
line as 50 is what it used to be set to. This way it's more to the original but
without having to sacrifice playability by running `make`.


## [2001/ollinger](2001/ollinger/ollinger.c) ([README.md](2001/ollinger/README.md))

Cody fixed to not crash if not enough args, exiting 1 instead.


## [2001/schweikh](2001/schweikh/schweikh.c) ([README.md](2001/schweikh/README.md]))

Cody fixed this to not crash if not enough args as this was not documented by
the author. The other problems are documented so were not fixed. See
README.md for details.

Cody also added the [try.sh](2001/schweikh/try.sh) script.


## [2001/westley](2001/westley/westley.c) ([README.md](2001/westley/README.md]))

Cody added the script [try.sh](try.sh) to automate a heap of commands
that we, the IOCCC judges, suggested, as well as some additional ones that he
thought would be fun.  He also provided the sort and punch card versions,
described in the README.md, based on the author's remarks.


## [2004/arachnid](2004/arachnid/arachnid.c) ([README.md](2004/arachnid/README.md]))

Cody added an [alternate version](2004/arachnid/README.md#alternate-code) which
allows those like himself used to `h`, `j`, `k` and `l` movement keys to not get
lost. Non rogue players, vi users and Dvorak typists are invited to get lost (or
use the original version)! :-)


## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md]))

Cody fixed this to compile with clang and also fixed it to work.

For clang the problem was that `main()` had one arg, a `char *` and this is not
allowed in any version of clang. In some versions it is allowed if the arg is an
`int` but never if it's anything else. To get it to work took numerous changes.

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

Finally the optimiser cannot be enabled so the compiler flags were changed for
this.


## [2004/gavare](2004/gavare/gavare.c) ([README.md](2004/gavare/README.md]))

Cody added three different [alternate
versions](2004/gavare/README.md#alternate-code):

- [gavare.alt.c](2004/gavare/gavare.alt.c) allows you to change the image size
and anti-alias setting at compile time.
- [gavare.alt2.c](2004/gavare/gavare.alt2.c) is like
[gavare.alt.c](2004/gavare/gavare.alt.c) but it should work for Windows as well
(it sets binary mode on `stdout`).
- [gavare.r3.c](2004/gavare/gavare.r3.c) is the author's unobfuscated version
that was used during development, found on their [website about the
entry](https://gavare.se/ioccc/ioccc_gavare.c.html).


## [2004/gavin](2004/gavin/gavin.c) ([README.md](2004/gavin/README.md]))

Yusuke provided the `kernel` and `fs.tar` files which can be used if you cannot
normally use this entry. Instead of generating the files just use the files
provided, found under the [img/](2004/gavin/img/) directory. Note that the
`img/fs.tar` extracts into `fs/` so you will have to fix the tarball; this is
done this way to prevent extraction from the entry directory overwriting the
files and causing `make clobber` to wipe some of them out.

Cody provided the [alt code](2004/gavin/README.md#alternate-code) for those who
want to use QEMU. The most important part of this is the macro `K` has to be
defined as `1`, not `0`.


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

Cody also added [alt code](2004/jdalbec/README.md#alternate-code) which allows
one to control how many numbers after the `:` to print before printing a
newline, so that one can see the output a bit better (though for lines that have
a lot of numbers this will be harder to see).

Finally Cody added [try.sh](2004/jdalbec/try.sh) and
[try.alt.sh](2004/jdalbec/try.alt.sh) to demonstrate both versions.


## [2004/kopczynski](2004/kopczynski/kopczynski.c) ([README.md](2004/kopczynski/README.md]))

Cody reported that this entry cannot be optimised by the compiler as otherwise
it will not work.

Cody also added the [try.sh](2004/kopczynski/try.sh) script and various data
files: [kopczynski-a](kopczynski-a) to demonstrate what happens when art more
like a letter is fed to the program and the `kopczynski*-rev` files which are
the data files reversed with `rev(1)`. One had to be modified additionally to
get it to work, that being `kopczynski-10-rev`.


## [2004/newbern](2004/newbern/newbern.c) ([README.md](2004/newbern/README.md]))

Cody and Landon individually fixed this to work with clang.


## [2004/schnitzi](2004/schnitzi/schnitzi.c) ([README.md](2004/schnitzi/README.md]))

Cody made this use `fgets(3)`.

He also changed the time factor in the data files as the animations went too
fast in modern systems, especially the scrolling text of
[schnitzi.inp1](schnitzi.inp1).


## [2004/sds](2004/sds/sds.c) ([README.md](2004/sds/README.md))

Cody added the [try.sh](2004/sds/try.sh) script.


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
[Makefile](2004/vik2/Makefile) but now it at least works for both Linux and
macOS.

As for the fix itself it required changing the C pre-processor macros that
resulted in macros themselves like `#ifdef`, `#else` etc. to be `#ifdef`,
`#else` etc. and also the inclusion of the file [vik2_1.c](2004/vik2/vik2_1.c)
(which actually includes itself, once directly and now by `__FILE__`)
which used to be generated by the Makefile via `cc -E`.

Cody also made it so that the `FNAME` is (for the entry file itself and
`vik2_1.c`: it shouldn't be done for
[vik2.possible.cat.death.c](2004/vik2/vik2.possible.cat.death.c)!) `__FILE__`
just to make it a bit easier to compile.


## [2005/aidan](2005/aidan/aidan.c) ([README.md](2005/aidan/README.md]))

Cody fixed the test script, described by the author in their remarks, to refer
to the proper compiled program (it's hardcoded). This had never been done and it
broke the script.

He also added the [alt code](2005/aidan/README.md#alternate-code) based on the
author's remarks which is a different approach than the one used and which 'is
slower (particularly in worst-case or nearly so scenarios), inelegant, and not a
good starting place for sudoku generation.'

The [try.sh](2005/aidan/try.sh) and [try.alt.sh](2005/aidan/try.alt.sh)
correspond to the entry and alt code respectively.

Cody added the `make test` and `make test-n0` rules for easier use of the test
suite.


## [2005/anon](2005/anon/anon.c) ([README.md](2005/anon/README.md]))

Cody fixed a problem where in some systems (like macOS) the `stty sane` would
not work and end up causing a bus error. Instead of `stty sane` it uses `stty
echo` which is what it was trying to accomplish.

The author noted that one can define `NO_STTY` to not use `stty(1)` at all
(either to prevent having to hit enter or to turn echo off/on) which is
explained in the README.md.

Cody added the [alt code](2005/anon/README.md#alternate-code) with vi(m) like
movements.


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

The most complicated fix was for, as might be expected, `clang`: it (at least
some systems?) has `-Werror` by default so the program was changed to use `make`
and then `rm -f` on the output of the compiled binary instead. This change might
also not have been necessary if using different flags to `cc` but this is less
portable and caused other problems.  This was a complicated fix as it's in the
comments but in a funny way; the final result to get the test feature to work
is:

```c
;; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s/|sed*/
/*-e/'s,intZ,int/ Z,g'>c.c;make/c;/ rm/-f/c*/
;;
```

changed from:

```c
;; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s>*/
/*c.c;cc/c.c /-c*/;;
```

or as a diff:


```diff
-(t(m),(0));; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s>*/
-/*c.c;cc/c.c /-c*/;;char*A=0,*_,*R,*Q, D[9999],*r,l
-[9999],T=42, M,V=32;long*E,k[9999],B[1 <<+21],*N=B+
+(t(m),(0));; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s/|sed*/
+/*-e/'s,intZ,int/ Z,g'>c.c;make/c;/ rm/-f/c*/
+;;char*A=0,*_,*R,*Q, D[9999],*r,l[9999],T=42, M,V=32;int *E,k[9999],B[1 <<+21],*N=B+
```

Cody also added the [try.sh](2005/giljade/try.sh) script which also lets one see
the beauty of the entry without having to use vi(m), should they be afraid of
getting stuck in it (and for ease of use). :-)

Finally, to improve upon the test-suite provided by the program, Cody added the
`make test` rule which only shows lines matching `'^Line'` but writing to a
temporary file the compilation including the 'Line' lines. After that is done it
uses `grep -c` on the file to show that there are indeed as many versions the
program generates as the author states, 180.  If it does not find 180 it is an
error; otherwise it is success. It uses [test.sh](2005/giljade/test.sh).


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


## [2005/sykes](2005/sykes/sykes.c) ([README.md](2005/sykes/README.md]))

Cody added the saved (with the `SAVE` command) BASIC program `PET` which was:

```basic
10 PRINT "2005'S IOCCC BEST EMULATOR"
20 PRINT "BY STEPHEN SYKES!"
```

followed by the commands:

```
SAVE "PET"

READY.
NEW

READY.
LOAD "PET"

READY.
RUN
2005'S IOCCC BEST EMULATOR
BY STEPHEN SYKES!
```

to both save and test run it.

Cody added the [try.sh](2005/sykes/try.sh) script which runs in a loop with a
menu of things one might wish to try, asking if they wish to continue when done.

Cody added the script [test.sh](2005/sykes/test.sh) and the make rule `test` to
run the test suite. The program will enter an infinite loop after it runs so you
have to hit ctrl-c to end it which the script tells you.

The scripts note every time that one will have to send ctrl-c or whatever their
interrupt is set to in order to exit the program.


## [2005/timwi](2005/timwi/timwi.c) ([README.md](2005/timwi/README.md]))

Cody added [try.sh](2005/timwi/try.sh). It only has one command as he doesn't
want to knacker his brain any more than it might or might not already be :-) and
he doesn't want to damage anyone else's brain either. :-)


## [2005/toledo](2005/toledo/toledo.c) ([README.md](2005/toledo/README.md))

Cody fixed this to compile with some versions of clang which have an additional
defect where `main()` can only have 0, 2 or 3 args (it was 4). It now calls
another function that takes 4 args and which is what used to be `main()`.

The alternate versions were also fixed.


## [2005/vince](2005/vince/vince.c) ([README.md](2005/vince/README.md))

Cody fixed this in the case that the program is compiled or linked/copies to
another file name: the code constructed the source code file name in a clever
and more obscure way by copying to the buffer `*argv` and then using `strcat(3)`
to concatenate to it `.c`. But this assumes that the executable is the same name
as the source file which isn't always be true. The author even stated: 'as long
as the source is in the same directory as the executable it should be able to
find it' but the source code file name is not always the same as the executable
with the appropriate extension so this might be called a bug fix as well though
if one runs it from another directory, specifying the directory, it'll not catch
it.


## [2006/birken](2006/birken/birken.c) ([README.md](2006/birken/README.md]))

Cody fixed a segfault in macOS with this entry. The problem was a missing `+1`
for strlen() with malloc(). This prevented it from working.


## [2006/borsanyi](2006/borsanyi/borsanyi.c) ([README.md](2006/borsanyi/README.md]))

Cody fixed the Makefile under some systems where the `lpthread` was not
implicitly linked in.


## [2006/hamre](2006/hamre/hamre.c) ([README.md](2006/hamre/README.md))

Cody fixed this so that it will not crash without an arg after it was suggested
this should be fixed.


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

The [alternate version](2006/sloane/sloane.alt.c), which allows one to see what
is going on in modern systems, and which we recommend one use _first_, was
provided by Cody.

Curiously, although clang requires the types of args to be strictly correct,
some versions do allow only one arg. This was done at first because it's not
used but Cody discovered that later versions of clang have an additional defect
where it does not allow only one arg so the second arg to `main()` was added
back. This was an unfortunate problem for the alt code as he has been using Z
for alt code `usleep()` (for sleep) but
in this case unfortunately the original entry used `Z` in `main()` (though
unused) so to make it more like the original Cody renamed the macro `Z` for
`usleep()` to `S` instead which can stand for sleep and also it is kind of like
a backwards `Z`. That way `Z` could be in `main()`.

Cody also made sure that the Makefile links in `libm` as not all systems do this
by default.

Since the author suggested that the lack of certain `#include`s might break the
program in some systems he added `-include ...` to the Makefile as well.


## [2006/stewart](2006/stewart/stewart.c) ([README.md](2006/stewart/README.md]))

Cody fixed it so that if the file cannot be opened it exits rather than trying
to read from the file.


## [2006/toledo2](2006/toledo2/toledo2.c) ([README.md](2006/toledo2/README.md]))

Cody fixed a segfault in this program which was making it fail to work under
macOS - it did not seem to be a problem under linux, at least not fedora. The
problem was wrong variable types - implicit `int`s instead of `FILE *`s. It now
works with both macOS and linux.

Cody also added the (untested) alt code that is based on the author's remarks to
port this to systems that have the non-standard `kbhit()` and `getch()` (not the
one from curses) which is typically (always?) in `conio.h`.


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
however that as of this time this entry does not work properly with macOS at
least with the silicon chip (Intel has not been tested) and it is quite possibly
an inherent problem in macOS to do with executing code in in memory/JIT and in
particular with the silicon chip. See [bugs.md](/bugs.md) for more details and a
document from Apple about how it might be fixed if anyone is brave enough to
try.


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


## [2012/endoh2](2012/endoh2/endoh2.c) ([README.md](2012/endoh2/README.md))

Cody fixed a typo in the ruby script
[find-font-table.rb](2012/endoh2/find-font-table.rb).


## [2012/grothe](2012/grothe/grothe.c) ([README.md](2012/grothe/README.md))

Cody restored the original code from the archive.


## [2012/kang](2012/kang/kang.c) ([README.md](2012/kang/README.md]))

Cody added alt code that fixes a problem where in German 'v' sounds like 'f'
which the program has as 'f': with the original version it would translate
'fier' to '4' when the word is 'vier'. But see below.

Originally this was updated in the original code but it was noticed that this
caused _other_ German (and maybe other languages?) words to be incorrect so it
was set as an alt version since the code was already there. It might also be
considered a feature and not a bug so an alt version is the better way to go
about it. Using both, however, allows one to experience different capabilities
and also enjoy or appreciate the entry even more, given how simple the
difference is.

Cody also added five scripts: [en.sh](2012/kang/en.sh),
[de.sh](2012/kang/de.sh), [en.alt.sh](2012/kang/en.alt.sh) and
[de.alt.sh](2012/de.alt.sh) which count from 0 through 13 in English and German
using the original entry and the alt version respectively.

In the German scripts it uses the umlaut and also does it without the umlaut
(add an 'e'). Notice how the program picks up on this! All scripts can use
either version but the `.alt.sh` versions default to the `alt` version whereas
the other defaults to the submitted entry. See the README.md for details.

The fifth script, [try.sh](2012/kang/try.sh), runs a sequence of commands to
show different languages and numbers.


## [2012/vik](2012/vik/vik.c) ([README.md](2012/vik/README.md]))

Based on the author's description it should be able to get this entry to work
for Windows. With his instructions Cody added the alternate version that does
this for the few who might use Windows.

We're not sure whether we want to thank Cody or not for this :-) and he's not
sure if he wants to be thanked either :-) but we appreciate it nonetheless.


## [2013/birken](2013/birken/birken.c) ([README.md](2013/birken/README.md]))

Cody changed the `return 0;` at the end of the program to be `return
system("reset");` (via redefining `exit(3)` so that the column ending would be
the same) so that as long as it runs to completion the terminal will be sane and
the cursor will be visible. Using `atexit(3)` will not work if the program is
killed and signals are ugly so this was not done.

Cody also added the [try.sh](2013/birken/try.sh) script and the
alternate version (that has the above fix) which allows one to control how fast the painting is done,
based on the author's recommendations, except that Cody made it configurable at
compile time just like he did with other entries that use `usleep(3)`. The
alternate version and the original version were swapped in the `To build`, `To
run` and `Try` sections, with what is normally `Alternate code` being `Original
code`.


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
failed to compile again also due to `localtime()` so he removed the prototype
entirely to solve the problem.

Cody also slightly improved the `runme` script to not assume that the program has
been compiled by running `make clobber all || exit 1` and he also made it pass
`shellcheck` (using `[[ .. ]]` over `[ .. ]`).

As well, based on the author's remarks, Cody added the [alternate
code](2013/cable3/cable3.alt.c) which should be compilable for Windows/MS Visual
Studio. This is done by in the compile line undefining `KB` (`-UKB`) and then in
the source code defining `KB` to what the author suggested,
`(kb=H(8),kbhit())&&(r[1190]=getch(),H(7))`. It need hardly be mentioned that
this will not link in Unix systems (including macOS).

Finally Cody provided the [bios.asm](2013/cable3/bios.asm) that the author
referred to, found at the [GitHub repo for the
entry](https://github.com/adriancable/8086tiny/tree/master).


## [2013/dlowe](2013/dlowe/dlowe.c) ([README.md](2013/dlowe/README.md))

Cody added the source code that we suggested one should compile and run with
different compilers as [fun.c](2013/dlowe/fun.c). He modified the Makefile so
that running `make all` will compile it, saving you the effort.

He also provided the script [sflen.sh](2013/dlowe/sflen.sh), fixing it for
shellcheck,  which is based on the author's remarks, giving a script that shows
the spark line of the file lengths (as in `wc -c`). These fixes were applied in
the author's remarks as well.

Since the author called the program `sparkl` Cody modified the Makefile so that
running `make all` will create a symlink to `dlowe` as `sparkl`. Running `make
clobber` will delete both and running `make clobber all` will ensure that the
symlink is created. The `sflen.sh` script also explicitly makes sure to create
the symlink as it uses it, even though it runs `make clobber all`.

Cody also added the [try.sh](2013/dlowe/try.sh) script to more easily try the
program.


## [2013/endoh2](2013/endoh2/endoh2.c) ([README.md](2013/endoh2/README.md))

Cody fixed the Makefile `check` rule so that it `checks` :-) that both
[Ruby](https://www.ruby-lang.org) and [ImageMagick](https://imagemagick.org) are
installed before trying to run the ruby script. To be more technically correct:
it checks that the `convert` tool of ImageMagick is available (via `type -P`)
because `convert` is part of the ImageMagick suite.

This is useful because the Ruby script tries to run (via `IO.popen()`) the
`convert` tool but without ImageMagick being installed, if one is unaware of
where it comes from it will appear to be an error in the Ruby script (it might
also appear to be an issue with the script even if you know of `convert`: it was
another day that Cody remembered it and why it wasn't installed on his MacBook
Pro even though in the past it had been and is indeed now).

The rule will report the tools not installed and where to find them, if they are
not installed, and after checking these requirements it will exit if either is
not found.

The entry can still be enjoyed if you do not have these tools, however.


## [2013/endoh4](2013/endoh4/endoh4.c) ([README.md](2013/endoh4/README.md))

Cody added the [run.sh](2013/endoh4/run.sh) script which temporarily turns off
the cursor as suggested by the author, with the addition that if no file is
specified it will feed the source code [endoh4.c](2013/endoh4/endoh4.c) to the
program rather than the file specified. It does not try and detect if the file
exists or can be read as that will be handled by the shell/program.


## [2013/endoh4](2013/endoh4/endoh4.c) ([README.md](2013/endoh4/README.md))

Cody added the [run.sh](2013/endoh4/run.sh) script which temporarily turns off
the cursor as suggested by the author, with the addition that if no file is
specified it will feed the source code [endoh4.c](2013/endoh4/endoh4.c) to the
program rather than the file specified. It does not try and detect if the file
exists or can be read as that will be handled by the shell/program.


## [2013/hou](2013/hou/hou.c) ([README.md](2013/hou/README.md))

Cody fixed the Makefile so that this would work properly. Before this the use of
the program just did what the judges' remarks said as far as how it might
violate rule 2: the program is really just a decompressor to generate the
real source of the program. So the source of the entry has to be compiled and
then run, and the output has to be compiled to be `hou`. This allows the real
program to be used. Thus the Makefile rule looks like:

```makefile
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}
	./${PROG} | ${CC} ${CFLAGS} -xc - -o $@ ${LDFLAGS}
```



which then compiles like:

```sh
cc -std=gnu11 -Wall -Wextra -pedantic -Wno-sign-compare -Wno-strict-prototypes    -O3 hou.c -o hou -lm
./hou | cc -std=gnu11 -Wall -Wextra -pedantic -Wno-sign-compare -Wno-strict-prototypes    -O3 -xc - -o hou -lm
```

The `LDFLAGS` were updated to have `-lm` as the author suggested it uses the
`math.h` library which not all systems link in by default (linux for instance
does not).

Further, after the file 2013/hou/doc/example.markdown was moved to
[2013/hou/doc/example.md](2013/hou/doc/example.md) to match the rest of the repo
this broke `make` which Cody also fixed.


## [2013/misaka](2013/misaka/misaka.c) ([README.md)[2013/misaka/README.md))

As there are a lot of commands to try, Cody added the
[try.sh](2013/misaka/try.sh) script to do this, sleeping for approximately 1
second between commands.


## [2013/morgan1](2013/morgan1/morgan1.c) ([README.md](2013/morgan1/README.md))

Cody added explicit linking of libm (`-lm`) as not all systems do this
implicitly (linux doesn't seem to but macOS does).


## [2014/deak](2014/deak/prog.c) ([README.md](2014/deak/README.md))

Cody fixed the code that the author provided which would be what the program
would look like if, as the author put it:

> The usage of recognizable elements from the C programming language in the
application source code is intentionally kept to a bare minimum. If this phrase
would not be true, the application would be the following:

It did not compile because a value was left off the `return` statement.

Cody added this as alternate code just for fun and so one can more easily see
the difference to really appreciate the obfuscation.


## [2014/endoh1](2014/endoh1/prog.c) ([README.md](2014/endoh1/README.md]))

Cody added the [rake.sh](2014/endoh1/rake.sh) script and `make rake` rule that
runs the script. This script will check that `rake` is installed and if it is
not it will report this and then check that `gem` is installed. It checks that
`gem` is installed in this case because `gem` is how you install `rake`. If
`gem` is not installed it tells you to get it along with how to install `gem`.
Then it tells you how to install `rake`. If `rake` fails to run then it tells
you to install a specific gem and then to try again. Finally if `rake` succeeds
it will verify that `prog` is executable and if it is it will run it.

**_Barely_** worth noting but done nonetheless, Cody renamed the `read_me.md`
file to [spoilers.md](2014/endoh1/spoilers.md) to be clearer in its purpose as
it is a file with spoilers.


## [2014/maffiodo1](2014/maffiodo1/prog.c) ([README.md](2014/maffiodo1/README.md]))

Cody fixed the build for this entry: it does not require SDL2 but SDL1 so there
were linking errors.


## [2014/skeggs](2014/skeggs/prog.c) ([README.md](2014/skeggs/README.md))

Cody fixed the Makefile to compile this entry in modern systems. The problem was
that the `CDEFINE` variable in the Makefile was missing `'`s: the `#define CC`
is an actual string that is, in the Makefile, is `"${CC} -fPIC"`, which
translates to whatever the compiler is followed by a space followed by `-fPIC`
but without the `'`s it was incomplete and so would not compile. Cody didn't
have a chance to really look at the compiler error.

Yusuke suggested that one should use `-ldl` in the Makefile. This was not
originally done because it seemed to work but since it uses `dlsym()` it was
added later to make it more portable.

The program creates files in the working directory as part of how it works (see
the README.md file for details) so Cody made sure that `make clobber` (via `make
clean`) removes those files and so that they are ignored by `.gitignore`.


## [2014/vik](2014/vik/prog.c) ([README.md](2014/vik/README.md))

Cody added an alternate version that is based on the author's remarks that will
theoretically work for Microsoft Windows compilers (if anything works in Windows
:-) ). We have no way of testing this and if anything has changed since 2014
that would break it we do not know.


## [2015/endoh3](2015/endoh3/prog.c) ([README.md](2015/endoh3/README.md]))

Cody fixed this to compile with linux which was having a problem with duplicate
symbols of `main()`. The fix is through the compiler option `-fcommon` which
will let it compile like it does with macOS.

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

He also added the script [try.sh](2019/karns/try.sh) to showcase the entry a
bit more easily.


## [2020/endoh2](2020/endoh2/prog.c) ([README.md](2020/endoh2/README.md))

Cody copied the files from the spoiler.zip file that was password protected with
a password that was no longer known from his preview of 2020.


## [2020/endoh3](2020/endoh3/prog.c) ([README.md](2020/endoh3/README.md))

Cody fixed the script [run_clock.sh](2020/endoh3/run_clock.sh) which gave a
funny error when running it:

```sh
$ ./run_clock.sh
-bash: ./run_clock.sh: cannot execute: required file not found
```

If run from within vim a different error message occurred:

```
/bin/bash: ./run_clock.sh: /usr/bin/end: bad interpreter: No such file or directory
```

though this was only noticed later on after it was fixed.

What was wrong? A typo in the shebang which had `/usr/bin/end` instead of
`/usr/bin/env`. Anyone who knows Cody would know that he'd zoom in on that quite
quick.

Cody also reported (during the preview period of 2020) for some systems (at some
point?) like macOS the use of `make clock` would not work due possibly to a
timing issue so Yusuke changed it to compile the [clock.c](2020/endoh3/clock.c)
file directly (this might have been fixed in the Makefile later on but it
doesn't hurt to keep it in and this way it isn't a problem in any system). How
Cody remembers this minor detail more than three years ago is something that
many people might wonder but he also once told us that if someone moves
something of his even a millimetre from where it was he knows it so he might be
called unusual (and he argues, with pride, eccentric :-) ) :-)


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


## [2020/tsoj](2020/tsoj/prog.c) ([README.md](2020/tsoj/README.md))

Cody added [alternate code](2020/tsoj/README.md#alternate-code) that will feel
more at home for vi users. One might still end up cursing (see the README.md
file) but probably a lot less :-)
