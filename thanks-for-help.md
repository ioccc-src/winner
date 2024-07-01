# Thanks for all the help


## .. and [thanks for all the fish](https://hitchhikers.fandom.com/wiki/So_Long,_and_Thanks_for_All_the_Fish). :-)

To avoid having to change numerous "_index.html_" files to add thank you notes,
we centralize them below.

The [IOCCC judges](judges.html) wish to recognize the many
important contributions to the IOCCC presentation of past IOCCC entries.
We are pleased to note the many contributions, **made since 2021 Jan 01**,
on an IOCCC entry by entry basis.


## IOCCC thank you table of contents

- [1984 entries](#1984) |       [1985 entries](#1985)   |       [1986 entries](#1986)   |       [1987 entries](#1987)
- [1988 entries](#1988) |       [1989 entries](#1989)   |       [1990 entries](#1990)   |       [1991 entries](#1991)
- [1992 entries](#1992) |       [1993 entries](#1993)   |       [1994 entries](#1994)   |       [1995 entries](#1995)
- [1996 entries](#1996) |       [1998 entries](#1998)   |       [2000 entries](#2000)   |       [2001 entries](#2001)
- [2004 entries](#2004) |       [2005 entries](#2005)   |       [2006 entries](#2006)   |       [2011 entries](#2011)
- [2012 entries](#2012) |       [2013 entries](#2013)   |       [2014 entries](#2014)   |       [2015 entries](#2015)
- [2018 entries](#2018) |       [2019 entries](#2019)   |       [2020 entries](#2020)
- [General thanks](#general_thanks)
- [Makefiles fixes and improvements](#makefiles_fixes_improvements)
- [Consistency improvements](#consistency_improvements)
- [Manifest improvements](#manifest_improvements)
- [Thank you honor roll](#thank_you_honor_roll)
- [Did we neglect to credit you?](#neglect)


<div id="1984">
# [1984 - The 1st IOCCC](1984/index.html)
</div>


<div id="1984_anonymous">
## Winning entry: [1984/anonymous](1984/anonymous/index.html)
### Winning entry source code: [anonymous.c](%%REPO_URL%%/1984/anonymous/anonymous.c)
</div>

[Cody](#cody) fixed this to work for macOS.

The problem was to do with the way that the `read(2)` function was redefined.
With macOS the second arg needs to be a `void *` and this also necessitated some
casts to `int` (on the second arg) in the call to `write(2)` (in `read()`).

Later Cody corrected the mistake where the `"hello, world!"` string was on one
line rather than two lines which the author told us (Landon) that they liked.
Thus now it is like the original where the first line ends with `"hell\` and
the second line starts with `o, world!\n"`.

By request, the original code is provided as
[anonymous.alt.c](%%REPO_URL%%/1984/anonymous/anonymous.alt.c) so that one can
look at it and the famous tattoo which we also include here, together as a
single image that Cody added (locating the missing tattoo image and putting the
source code and the tattoo together as an image):

<img src="1984/anonymous/1984-anonymous-tattoo.jpg"
 alt="image of a tattoo of the 1984 anonymous C code"
 width=600 height=401>

The tattoo was done in 2005 by [Thomas
Scovell](https://web.archive.org/web/20070120220721/https://thomasscovell.com/tattoo.php).


<div id="1984_decot">
## Winning entry: [1984/decot](1984/decot/index.html)
### Winning entry source code: [decot.c](%%REPO_URL%%/1984/decot/decot.c)
</div>

[Cody](#cody) fixed this to not require `-traditional-cpp` which some compilers like
`clang` do not support. Fixing `-traditional-cpp` is, as noted later on, very
complicated, but we encourage you to look at the alternate code (which is the
original code with a minor modification made by the judges) and the fixed
code, to see what had to be done.

`Clang` is also more strict about the type of args in `main()` and this was also a
problem that Cody fixed, making it work with both `clang` and `gcc`.

These fixes worked fine in macOS but it turned out that in some cases with
`clang` in Linux it did not work so this had to be further fixed which Cody also
did. It is no longer clear what the problem was as in fedora 38 with `clang`
16.0.6; the only difference is it causes additional warnings but it seems to
work just fine.  It seems unlikely that a fix was made just for warnings so it
is presumed that there was another problem and thus the change is kept in place.

A note about the fix is that the `#define`d macros that were used still exist
but most are not used; they are left in just to make it look more like the
original entry. Nevertheless those cannot be used.

Later on Cody improved the fix to make it look rather more like the original by
bringing back an extern declaration (slightly changing it to match the symbol
that it is i.e. `extern double floor(double);` instead of `extern int floor;`)
and also bringing back `double (x1, y1) b;` and even this funny code that could
be kept in:

``` <!---c-->
    #define char k['a']
    char x {sizeof(
         double(%s,%D)(*)())
```

This does mean that there cannot be a second arg to `main()`
as `clang` requires that to be a `char **` and the `char` redefined would not
allow this. Some versions of `clang` say that `main()` must have either 0, 2 or 3
args but these versions do not object to 1 arg. However as the `char` macro
seems more obscure and it is possible that a new version of `clang` will be even
more strict the `int i` parameter in `main()` was moved to be inside `main()`,
set to non-zero (setting `i` to 0 will not work). This is why `main()` has zero
args.

Observe how on line 29 there is a call to `main()` which does pass in a
parameter. It has never been observed to be an error to pass in too many
parameters to a function (`main()` or otherwise - it warns with other functions
but does not appear to with `main()`) but only that `main()` itself has a
certain number of args (in some versions) and that the first arg is an `int` and
the others are `char **`s. This is why the arg was removed and the call to
`main()` was not updated beyond what had to be done to fix it for compilers that
do not support `-traditional-cpp`.

If the ANSI C committee or a new version of `clang` messes this up (both of which
seem possible) it is easy to fix but it is hoped that this won't happen.

Originally [Yusuke](#yusuke) supplied a patch so that this entry would compile
with `gcc` - but not `clang` - or at least some versions.

To see the difference from start to fixed:

``` <!---sh-->
    cd 1984/decot ; make diff_orig_prog
```

Cody later discovered that the `make alt` rule does not work as the
`-traditional-cpp` option conflicts with some of the other options. Thus the
`make alt` rule only uses `-traditional-cpp`.

To see the diff between the original and the alternate code, try:

``` <!--sh-->
        cd 1984/decot ; make diff_orig_alt
```


<div id="1984_laman">
## Winning entry: [1984/laman](1984/laman/index.html)
### Winning entry source code: [laman.c](%%REPO_URL%%/1984/laman/laman.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1984/laman/try.sh) script.


<div id="1984_mullender">
## Winning entry: [1984/mullender](1984/mullender/index.html)
### Winning entry source code: [mullender.c](%%REPO_URL%%/1984/mullender/mullender.c)
</div>

[Cody](#cody) provided an [alternate version](%%REPO_URL%%/1984/mullender/mullender.alt.c),
an improved version of the judges, so that everyone can enjoy it with systems
that are not VAX/PDP. It moves at approximately the same speed as the original
did. By using one or more of the other entries that actually let one enjoy this entry as
originally written, Cody was able to find, with trial and error, approximately
the correct speed.

The difference between the original is that it will start over after it times
out but that might not happen with the original (might need you to press a key
though this is not known for sure).

Cody also added the [gentab.c](%%REPO_URL%%/1984/mullender/gentab.c) file, fixed to compile
(and work, though see [1984/mullender in bugs.html](bugs.html#1984_mullender)) with modern systems
and so that it would create the proper array (it had unbalanced `}`s), which the
author noted in their remarks (which Cody also found). As this file uses the old
header file `a.out.h` that is not available in all modern systems, Cody found a
copy of it as to what it should have been at the time, in the fabulous [Unix
History
Repo](https://github.com/dspinellis/unix-history-repo/tree/Research-Release).


<div id="1985">
# [1985 - The 2nd IOCCC](1985/index.html)
</div>


<div id="1985_applin">
## Winning entry: [1984/applin](1985/applin/index.html)
### Winning entry source code: [applin.c](%%REPO_URL%%/1985/applin/applin.c)
</div>

Both [Cody](#cody) and [Yusuke](#yusuke) fixed this; Yusuke got this to not crash and Cody fixed it
to work with macOS.

The crash was because it destructively rewrites string literals. However with
`strdup(3)` it's safe.

The problem with macOS is that although it didn't crash, it printed `H????` in a
seemingly infinite loop, each time printing another `?`, and it probably would
have until it ran out of memory.

The fix for macOS is that there was no prototype for `execlp(3)` and macOS has
problems with missing prototypes for some functions (this was also seen when
Cody fixed [1984/anonymous](1984/anonymous/index.html) for macOS as well). As
this is a one-liner the include of `unistd.h` was done in the Makefile.
Ironically this fix was discovered through Linux!

NOTE: originally this entry did not print a newline prior to returning to the
shell, after the output (despite having `\n` in the string - can you figure out
why?) but to make it more friendly to users Cody made it print a `\n` prior to
returning to the shell. The original code does not have this change.


<div id="1985_august">
## Winning entry: [1985/august](1985/august/index.html)
### Winning entry source code: [august.c](%%REPO_URL%%/1985/august/august.c)
</div>

[Cody](#cody), out of abundance of caution, added a second arg to `main()` because some
versions of `clang` object to the number of args of `main()`, saying that it must
be 0, 2 or 3. The version this has been observed in does not actually object to
1 arg but it is entirely possible that this changes so a second arg (that's not
needed and is unused) has been added just in case. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.

Cody also added the script [primes.sh](%%REPO_URL%%/1985/august/primes.sh) which allows one
to check the output for the first `N` prime numbers of the output, where `N` is
either the default or user specified. The inspiration was the previous `try`
command he gave to have fun with finding primes that might seem unusual in a
way.

Cody also added the [try.sh](%%REPO_URL%%/1985/august/try.sh) script (which runs `primes.sh`
whether `primes(6)` is installed or not, but it only does it once with the
default value).


<div id="1985_lycklama">
## Winning entry: [1985/lycklama](1985/lycklama/index.html)
### Winning entry source code: [lycklama.c](%%REPO_URL%%/1985/lycklama/lycklama.c)
</div>

[Cody](#cody) fixed this to compile with modern compilers. In the past one could get away
with defining some macro to `#define` and then use `#foo` to have the same
effect as using `#define` but this does not work in modern systems so Cody
changed the `#o` lines to `#define`. Also `unistd.h` had to be `#include`d.

[Yusuke](#yusuke) provided some useful information that amounts to an alternate version
that Cody added. See the [index.html](1985/lycklama/index.html) for details.

Cody also provided the [try.alt.sh](%%REPO_URL%%/1985/lycklama/try.alt.sh) script.


<div id="1985_shapiro">
## Winning entry: [1985/shapiro](1985/shapiro/index.html)
### Winning entry source code: [shapiro.c](%%REPO_URL%%/1985/shapiro/shapiro.c)
</div>

[Cody](#cody) added the [alternate code](%%REPO_URL%%/1985/shapiro/shapiro.alt.c)
which allows one to resize the maze and he also added the
[try.alt.sh](%%REPO_URL%%/1985/shapiro/try.alt.sh) script that randomly selects
sizes (five times) and then compiles and runs it. After the five runs it prompts
you to enter a number, in an infinite loop, exiting if any non-digits are in
input (this includes negative numbers which in the code actually sets it back to
39, the default).


<div id="1985_sicherman">
## Winning entry: [1985/sicherman](1985/sicherman/index.html)
### Winning entry source code: [1985/sicherman](%%REPO_URL%%/1985/sicherman/sicherman.c)
</div>

[Cody](#cody) fixed this _very twisted entry_ to not require `-traditional-cpp`.  Fixing
`-traditional-cpp` is, as noted later on, very complicated, but Cody would like
to refer you to the original file
[sicherman.orig.c](%%REPO_URL%%/1985/sicherman/sicherman.orig.c) and he suggests that you
then compare it to [sicherman.c](%%REPO_URL%%/1985/sicherman/sicherman.c) for some good old
C-fashioned fun (alternatively, see below explanation)!

Later on Cody improved the fix so that it looks much more like the [original
entry](%%REPO_URL%%/1985/sicherman/sicherman.c). He did this several more times and it's
as close to the original as one can get without causing compiler errors.

To get this to all work the following changes were made. If you really want to
understand this Cody provides the following. First run the following command
from the directory:

``` <!---sh-->
    make diff_orig_prog
```

and then read the following (you might also wish to look at the code in an
editor with syntax highlighting):

- Because of the macros `C` and `V` in the original code, the args to `main()`
were actually not what they appear: the only arg that existed in `main()` was
`Manual`. Thus it now looks like:

``` <!---c-->
    main(
    /*  C program. (If you don't
     *  understand it look it
     *  up.) (In the C*/ Manual)
    {
```

- The macros `C` and `V` were changed to lower case. This is because it felt
like the `C=" ..`' part in `subr()` would be better to be upper case as it talks
about the language. Also in the [alternate
version](%%REPO_URL%%/1985/sicherman/sicherman.alt.c) which is in case a new
version of `clang` ever objects to only one arg in `main()` (which is not out of
the realm of possibility), `main()`, `argc` of `main()` is `C` so it
would read like it once did: `C manual` albeit with a `,` separating the two.
The [alternate version](%%REPO_URL%%/1985/sicherman/sicherman.alt.c) can be
compiled in case the first does not. Originally the macros were kept the same
and the `C` in `subr()` was `c`. It feels better (in some ways) to make it so
that the `C` for the language is upper case though, and since it actually
translated to `/**/` it can just be `c`, not `C`. The `V` was changed to `v` to
be the same case as `c`.

- The code:

``` <!---c-->
    C="Lint says "argument Manual isn't used."  What's that
    mean?"; while (write((read(C_C('"'-'/*"'/*"*/))?__:__-_+
    '\b'b'\b'|((_-52)%('\b'b'\b'+C_C_('\t'b'\n'))+1),1),&_,1));
```

    had to be changed to:

``` <!---c-->
    C="Lint says \"argument Manual isn't used.\" What's that\
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

    Notice also that the parameter `C` remained the same due to the macro `C`
    rename to `c`.

    The `char`s `_` and `__` in `main()` were copied to file scope so that
    `subr()` could actually compile but this does not affect the ones in
    `main()`. Why is this? You tell us!

- The code in `main()` is where there are significant changes, changing from:

``` <!---c-->
    while (read(0,&__,1) & write((_=(_=C_C_(__),C)),
    _C_,1)) _=C-V+subr(&V);
```

    to:

``` <!---c-->
    while (read(0,&__,1) & write((_=(_=C_C_(__),
    V))?__:__-_+'\b'b'\b'|((_-52)%('\b'b'\b'+~
    ' '&'\t'b'\n')+1),1),&_,1))_=c-v+subr(&v));
```

    Note how several of the macros (though two changed in case) can still be
    used but some cannot be. Can you figure out why? Why too is it that the
    `subr()` function is called but it appears that some of the code in that
    function is also in `main()` in the `while` condition? What happens if you
    remove it from `main()`? What happens if you remove it from `subr()` or
    don't even bother calling `subr()`?

[Additional code](%%REPO_URL%%/1985/sicherman/sicherman.alt.c) was added in case the fix cannot be compiled by some compilers
should they object to `main()` having only one arg.

Cody also added the [try.sh](%%REPO_URL%%/1985/sicherman/try.sh) and
[try.alt.sh](%%REPO_URL%%/1985/sicherman/try.alt.sh) scripts.


<div id="1986">
# [1986 - The 3rd IOCCC](1986/index.html)
</div>


<div id="1986_applin">
## Winning entry: [1986/applin](1986/applin/index.html)
### Winning entry source code: [applin.c](%%REPO_URL%%/1986/applin/applin.c)
</div>

[Cody](#cody) made the C file executable so one does not have to do `sh
./applin.c` or `./applin`; they can do either `./applin.c` or `./applin`.


<div id="1986_bright">
## Winning entry: [1986/bright](1986/bright/index.html)
### Winning entry source code: [bright.c](%%REPO_URL%%/1986/bright/bright.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1986/bright/try.sh) script.


<div id="1986_hague">
## Winning entry: [1986/hague](1986/hague/index.html)
### Winning entry source code: [hague.c](%%REPO_URL%%/1986/hague/hague.c)
</div>

[Cody](#cody) made this use `fgets()`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.

Cody also added the [try.sh](%%REPO_URL%%/1986/hague/try.sh) script which also feeds to the
program the `input.txt` text file that Cody added.


<div id="1986_holloway">
## Winning entry: [1986/holloway](1986/holloway/index.html)
### Winning entry source code: [holloway.c](%%REPO_URL%%/1986/holloway/holloway.c)
</div>

[Cody](#cody) fixed this to compile and work with `clang` (it already worked with `gcc`).
The problem was that `clang` is more strict about the types of args to
`main()`. However simply changing the second arg (that `clang` insists on being
a `char **`) to a `char **` and updating the `*s` to `**s`
caused a segfault. By adding a new variable, `char *t`, initialising it to `s`
and then using `t` instead of `s` it compiles and runs successfully under
`clang` and `gcc`.


<div id="1986_marshall">
## Winning entry: [1986/marshall](1986/marshall/index.html)
### Winning entry source code: [marshall.c](%%REPO_URL%%/1986/marshall/marshall.c)
</div>

[Cody](#cody) got this to compile and work with `clang` and `gcc`. He noted that he tried to
keep the ASCII art as close to the original as possible. The line lengths are
the same but some spaces had to be changed to non-spaces.

This fix was very interesting and quite amusing, showing up problems with two
different compilers (different problems with different compilers in different
systems and also depending on optimisation with those compilers in those
systems).

Cody gives more details in the [compilers.html](1986/marshall/compilers.html)
file: which compilers had which problems in which systems: the optimiser being
enabled in one compiler let it work but broke it in the other; and disabling it
would let it work in the one that didn't work but suddenly the one that worked
wouldn't work. And by 'not working' it did not work in more than one way and for
different platforms it had other problems as well.

This problem was only after getting `clang` to compile, of course. It did not
compile it because it is more strict about the arg types of `main()` and in this case
particularly the second and third args to `main()`, which must be a `char **`.
As the third arg was an `int` the code had to be modified.

We encourage you to read the [compilers.html](1986/marshall/compilers.html) file to
see how odd this problem was and what Cody did to fix it, if nothing else but
for entertainment!

Also, after all warnings but one that could not be silenced were disabled, Cody
changed the [alternate code](%%REPO_URL%%/1986/marshall/marshall.alt.c) (which was not
the same as the original - see above for details or try `make diff_orig_alt` in
the directory) slightly so that it was possible to silence it. In particular:

``` <!---c-->
      P  (    a  )   char a   ;  {    a  ;   while(    a  >      "  B   "
```

which gave:

```
    marshall.alt.c:13:55: warning: ordered comparison between pointer and integer ('char' and 'char *')
      P  (    a  )   char a   ;  {    a  ;   while(    a  >      "  B   "
                                                       ~  ^      ~~~~~~~~
    1 warning generated.
```

This was changed to:

``` <!---c-->
      P  (    a  )   char a   ;  {    a  ;   while((char *)a  >   "  B   "
```

which gave:

```
    marshall.alt.c:13:48: warning: cast to 'char *' from smaller integer type 'char' [-Wint-to-pointer-cast]
      P  (    a  )   char a   ;  {    a  ;   while((char *)a  >   "  B   "
                                                   ^~~~~~~~~
    1 warning generated.
```

which can be disabled. It results in the same behaviour but this way no warnings
are produced.


<div id="1986_pawka">
## Winning entry: [1986/pawka](1986/pawka/index.html)
### Winning entry source code: [pawka.c](%%REPO_URL%%/1986/pawka/pawka.c)
</div>

[Cody](#cody) noticed and fixed a funny mistake in the `Makefile` where a
`-Wno-strict-prototypes` was in the wrong location, suggesting that there is a
`-D` needed to compile the entry but this is not actually so.


<div id="1986_stein">
## Winning entry: [1986/stein](1986/stein/index.html)
### Winning entry source code: [stein.c](%%REPO_URL%%/1986/stein/stein.c)
</div>

[Cody](#cody) restored the [original
entry](%%REPO_URL%%/1986/stein/stein.orig.c) which was a single line. The code
being longer (in 1986 a one liner could be longer) had been split to three lines to
avoid problems with news and mail but as it is the **Best one liner** the original
code is now one line.

Cody also added the [stein.sh](%%REPO_URL%%/1986/stein/stein.sh) script which runs the two
commands that we suggest in order to get it to show clean output.


<div id="1986_wall">
## Winning entry: [1986/wall](1986/wall/index.html)
### Winning entry source code: [wall.c](%%REPO_URL%%/1986/wall/wall.c)
</div>

[Cody](#cody) fixed this so that it does not require `-traditional-cpp`. This took a fair
bit of tinkering as this entry *very twisted*; fixing `-traditional-cpp` is, as
noted later on, very complicated, but we encourage you to look at [original
code](%%REPO_URL%%/1986/wall/wall.orig.c), as well as below, to see how
different C was in 1986.

[Yusuke](#yusuke) originally patched this to use `strdup(3)` on two strings and this let it
work with `gcc` - but it still required `-traditional-cpp`.

If you'd like to see the difference between the version that requires
`-traditional-cpp` and the fixed version, try:

``` <!---sh-->
    cd 1986/wall ; make diff_orig_prog
```

Some of the changes required:

- Instead of using the `c_`, defined as `c_(cc)c cc=`, like:

``` <!---c-->
    c_(+)o

    /* ... */

    :c_(+)' '-1;
    }}c_(&)'z'+5;
```

    use:

``` <!---c-->
    :c +=o[c&__LINE__-007];

    /* ... */

    :c+=' '-1;
    }}c&='z'+5;
```

    Observe however that this macro is still used in the code like:

``` <!---c-->
    main(;c_(=(*cc);*cc++)c,for);
```

- Instead of code like:

``` <!---c-->
    main(0xb+(c>>5),C_(s))
    _'\v'
    :__ _'\f':
    main(c,C_(s));
```

    use instead:

``` <!---c-->
    main(;c_(=(*cc);*cc++)c,for);
    #define _O(s)s
    switch(0xb+(c>>5)){
    _'\v'
    :__ _'\f':
    switch(c){;
```

- The macro:

``` <!---c-->
    #define C_(sand)_O(sand)witch
```

    could not be used like:

``` <!---c-->
    C_(s));_
```

    to create:

``` <!---c-->
    switch);_
```

    and neither could the macro:

``` <!---c-->
    #define O_(O)_O(O)stem(ccc(
```

    be used like:

``` <!---c-->
    :O_(sy)";kkt -oa, dijszdijs QQ"))_C
```

    to create:

``` <!---c-->
    :system(ccc(";kkt -oa, dijszdijs QQ"));return
```

- And of course as noted two strings had to be `strdup()`d.

There might have been other changes as well.


<div id="1987">
# [1987 - The 4th IOCCC](1987/index.html)
</div>


<div id="1987_biggar">
## Winning entry: [1987/biggar](1987/biggar/index.html)
### Winning entry source code: [biggar.c](%%REPO_URL%%/1987/biggar/biggar.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1987/biggar/try.sh) script.


<div id="1987_heckbert">
## Winning entry: [1987/heckbert](1987/heckbert/index.html)
### Winning entry source code: [heckbert.c](%%REPO_URL%%/1987/heckbert/heckbert.c)
</div>

[Cody](#cody) made this look more like the [original
entry](%%REPO_URL%%/1987/heckbert/heckbert.orig.c) by restoring the `#define _
define`. It's not used but it now looks closer to the original.

Cody also added the [try.sh](%%REPO_URL%%/1987/heckbert/try.sh) script which shows how the
program works but also how the folded code can recreate the original.

Also because `index(3)` is deprecated and in some systems requires the inclusion
of `strings.h` and because it's identical in use to `strchr(3)` (and we noted
that for System V we had to do this) Cody added to the Makefile
`-Dindex=strchr`.


<div id="1987_hines">
## Winning entry: [1987/hines](1987/hines/index.html)
### Winning entry source code: [hines.c](%%REPO_URL%%/1987/hines/hines.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1987/hines/try.sh) script, the C file
[goto.c](%%REPO_URL%%/1987/hines/goto.c) and the text file [goto.txt](1987/hines/goto.txt)
for demonstration purposes. Notice that the program is case sensitive which
running the program on the text file demonstrates.


<div id="1987_lievaart">
## Winning entry: [1987/lievaart](1987/lievaart/index.html)
### Winning entry source code: [lievaart.c](%%REPO_URL%%/1987/lievaart/lievaart.c)
</div>

[Cody](#cody) added back the documented checks for invalid input which no longer worked
and instead resulted in accepting the level, whether or not it was a
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
is the case it is incremented by 2. Cody does not know the rules of the game and
neither does he know what the author had in mind so he chosen 10 as the maximum.

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


<div id="1987_wall">
## Winning entry: [1987/wall](1987/wall/index.html)
### Winning entry source code: [wall.c](%%REPO_URL%%/1987/wall/wall.c)
</div>

[Cody](#cody) made this use `fgets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.


Cody also added the [try.sh](%%REPO_URL%%/1987/wall/try.sh) script.


<div id="1987_westley">
## Winning entry: [1987/westley](1987/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1987/westley/westley.c)
</div>

[Cody](#cody) fixed this for modern systems. The problem was `'assignment to cast is
illegal, lvalue casts are not supported'`. For details on the [original
code](%%REPO_URL%%/1987/westley/westley.orig.c) see the
[index.html](1987/westley/index.html) file. Unfortunately this fix ruins some symmetry.

To try and resolve this as much as possible at first code was commented out but
later on the commented out code was removed and another part changed so that,
although it has some code no longer there, it has a closer match in symmetry and
since the code was commented out it's probably not a big deal to have it removed
instead as it does look more symmetrical now.

Cody also added to the `Makefile` `-include stdio.h` in the nowadays very
unlikely(?) but nevertheless suggested case that `putchar(3)` is not available.


<div id="1988">
# [1988 - The 5th IOCCC](1988/index.html)
</div>


<div id="1988_dale">
## Winning entry: [1988/dale](1988/dale/index.html)
### Winning entry source code: [dale.c](%%REPO_URL%%/1988/dale/dale.c)
</div>

[Cody](#cody) fixed this twisted entry (as we called it :-) ) for modern compilers,
including making it no longer require `-traditional-cpp`. Fixing
`-traditional-cpp` is, as noted later on, very complicated, but we encourage you
to compare the fix from the original entry. There was another problem to resolve
as well, however.

First of all, as noted above, the entry required `-traditional-cpp` (which
`clang` does not support). It needed that option in modern systems because of
two things it did:

``` <!---c-->
    #define a(x)get/***/x/***/id())

    /* ... */

    p Z=chroot("/");L(!a(u)execv((q(v="/ipu6ljov"),v),C);Z-=kill(l);

    /* ... */

    case_2:L(!--V){O/*/*/c*c+c);wait(A+c*c-c);L(!Z)f(A,"\n",c);return(A*getgid());};C++;
```

This macro, `a`, formed the function names `getuid()` and `getgid()`, but
this no longer works.  The code still uses the macro `a` to form the names but
it's done differently, using the C token paste operator `##`. It's done like
this:

``` <!---diff-->
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

``` <!---c-->
    for/*/(;;);/*/k()){O/*/*/c);
```

cannot form `fork())` in modern C compilers. Since it was not done through a
macro it was simply changed to be `fork()`, rather than adding a new macro.

The other problem that could not be resolved by the `-traditional-cpp` was that
modern compilers do not allow directives like:

``` <!---c-->
    #define _ define
    #_ P char
    #_ p int
    #_ O close(
    /* ... */
```

so Cody changed the lines to be in the form of:

``` <!---c-->
    #define P char
    #define p int
    #define O close(
    /* ... */
```

However, to keep the entry as close to as possible in look, Cody kept the `_`
macro in place but it's no longer used.

Cody also provided the [try.sh](%%REPO_URL%%/1988/dale/try.sh) script.


<div id="1988_isaak">
## Winning entry: [1988/isaak](1988/isaak/index.html)
### Winning entry source code: [isaak.c](%%REPO_URL%%/1988/isaak/isaak.c)
</div>

[Cody](#cody) fixed this to work for modern systems. The problem was that the important
function, a redefinition of `exit(3)`, was not being called in `main()`. Earlier
fixes that let it compile, but not work with modern systems, can be found in
[isaak.alt.c](%%REPO_URL%%/1988/isaak/isaak.alt.c). See the
index.html file for more details.

Cody also uudecoded and removed the file `isaak.encode`, putting the output in
`isaak.output.txt`. This was done strictly for historical remarks that can be
found in the index.html file.


<div id="1988_litmaath">
## Winning entry: [1988/litmaath](1988/litmaath/index.html)
### Winning entry source code: [litmaath.c](%%REPO_URL%%/1988/litmaath/litmaath.c)
</div>

[Cody](#cody) added the [alternate code](%%REPO_URL%%/1988/litmaath/litmaath.alt.c)
which is code that we suggested at the time of publication, in the remarks, to
help understand the entry, and for fun.


<div id="1988_phillipps">
## Winning entry: [1988/phillipps](1988/phillipps/index.html)
### Winning entry source code: [phillipps.c](%%REPO_URL%%/1988/phillipps/phillipps.c)
</div>

[Cody](#cody) fixed this for modern systems. It did not compile with `clang` because it
requires the second and third args of `main()` to be `char **` but even before
that with `gcc` it printed garbage and then crashed.

After fixing it for `clang` by changing the **very recursive** `main()` (**it called
itself up to *12* times!**) to call the new function `pain()` (named such because it's a
pain that `clang` requires these args to be `char **` :-) ), which is just as
recursive, with the correct args, it now works with both `gcc` and `clang`.

To make it look as close to the original as possible, Cody made it K&R style
functions and tried to match the format as best as possible of what
`main()` used to look like but without the full body as that cannot exist as it
once did; instead, the format of `pain()` is exactly like how `main()` was as it's the
same code, just a `p` instead of an `m` in the name. Additionally, `main()` returns
`!pain(...)` like `main()` used to do to itself (`pain()` does as well).


<div id="1988_reddy">
## Winning entry: [1988/reddy](1988/reddy/index.html)
### Winning entry source code: [reddy.c](%%REPO_URL%%/1988/reddy/reddy.c)
</div>

[Cody](#cody) made this use `fgets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.



<div id="1988_spinellis">
## Winning entry: [1988/spinellis](1988/spinellis/index.html)
### Winning entry source code: [spinellis.c](%%REPO_URL%%/1988/spinellis/spinellis.c)
</div>

[Cody](#cody) provided an [alternate version](%%REPO_URL%%/1988/spinellis/spinellis.alt.c) so that
this will work with compilers like `clang`. An alternate version had to be
provided because not doing so would be tampering with the entry too much. It
would work but it would not show the same creativity and cleverness.

The original entry exploits a fun mis-feature that works with `gcc` but not `clang`.
This resulted in a change of rules which is another reason to not modify the
original. See the index.html file for details on the alternate code.

Meanwhile Cody was twisted enough to point out (though to be fair he felt sick
doing this) that with a slight modification this entry can be C++ instead. We don't
thank him for this ghastly point! :-)


<div id="1988_westley">
## Winning entry: [1988/westley](1988/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1988/westley/westley.c)
</div>

The [original version](%%REPO_URL%%/1988/westley/westley.alt.c), provided as alternate code,
was fixed by Misha Dynin, based on the judges' remarks, so that this would work
with modern C compilers. We encourage you to try the alternate version to see
what happens with current compilers! See the index.html files for details.

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1988/westley/try.sh) script to show the magic of the
entry as seeing the code with the result at once is far more beautiful.

Cody also changed the `int`s to be `float` as that's what they are printed as:
not strictly necessary but nonetheless more correct, even if not warned against.




<div id="1989">
# [1989 - The 6th IOCCC](1989/index.html)
</div>


<div id="1989_fubar">
## Winning entry: [1989/fubar](1989/fubar/index.html)
### Winning entry source code: [fubar.c](%%REPO_URL%%/1989/fubar/fubar.c)
</div>

[Cody](#cody) got this to work with modern systems. The main issues were that an
`#include` had to be added along with fixing the path (due to `.` not being in
`$PATH`) to files referred to in the code. The path problem was also fixed in
[fubar.sh](%%REPO_URL%%/1989/fubar/fubar.sh). Another problem that showed up
later is that there was no `int` for `main` and implicit `int`s are not
supported in ISO C99 and later but since it does not use `make` the warning was
not being disabled. To fix this the `main` was set to return `int` explicitly.

A strange problem occurred where if one made modifications to the C file it
might end up failing to work even after changing it back. This was resolved by:

``` <!---diff-->
    --- i/1989/fubar/fubar.sh
    +++ w/1989/fubar/fubar.sh
    @@ -7,13 +7,12 @@ if [[ $# -ne 1 ]]; then
         exit 1
     fi

     # run/compile it
     rm -f ouroboros.c x1 x
    -ex - <<EOF
    -r fubar.c
    +ex fubar.c <<EOF
     8,9j
     w ouroboros.c
     EOF
     chmod +x ouroboros.c
```

Cody also 'modernised' the script to use `bash` and fixed for ShellCheck. The
`if [ .. ]` was changed in the C code as well as the script.

Cody also added the [try.sh](%%REPO_URL%%/1989/fubar/try.sh) script.


<div id="1989_jar.1">
## Winning entry: [1989/jar.1](1989/jar.1/index.html)
### Winning entry source code: [jar.1.c](%%REPO_URL%%/1989/jar.1/jar.1.c)
</div>

To prevent annoying output to `/dev/tty` we changed the code to simulate the
output via `strings(1)` but [Cody](#cody) removed the ill-famed `useless use of cat` to
shut [ShellCheck](https://github.com/koalaman/shellcheck) up.
Why is it ill-famed? Because there is no such thing as a
useless cat, that's why! For instance, the fact they even exist is proof that
the Earth is **NOT** flat: because if it was they would have pushed everything
off it by now! :-) They're also a great joy to all ailurophiles and yes they
most certainly do have a personality and they can be very sociable.

Whilst he was at it, Cody made it so that one need not run the alt script or
alternate code directly, to match that of the main entry. As we simulate the
functionality anyway, and since one may still run the code or the script (for
the original entry and the alternate code) anyway, it works out well.


<div id="1989_jar.2">
## Winning entry: [1989/jar.2](1989/jar.2/index.html)
### Winning entry source code: [jar.2.c](%%REPO_URL%%/1989/jar.2/jar.2.c)
</div>

[Cody](#cody) fixed this to work with modern compilers. Modern compilers do not allow
code like:

``` <!---c-->
    #define d define
    #define a include

    #d foo bar
    #a <stdio.h>
```

Cody notes that there _is_ a way to get it (or something close to it) to work. Do
you know how?

The old `#define`s are left in to make it look like the original as much as
possible but they are not used.

Cody also provided the [try.sh](%%REPO_URL%%/1989/jar.2/try.sh) script and the
supplementary files [try.lisp](%%REPO_URL%%/1989/jar.2/try.lisp),
[fib.lisp](%%REPO_URL%%/1989/jar.2/fib.lisp) and
[chocolate_cake.lisp](%%REPO_URL%%/1989/jar.2/chocolate_cake.lisp). The
`try.lisp` comes from the author and the `fib.lisp` comes from
[Yusuke](#yusuke). Cody wrote the script and offered us some chocolate cake :-)
See index.html for details on how to use the script.

Cody also fixed the `Makefile` where typing `make everything` or `make alt` would
result in:

```
    `clang`: error: no such file or directory: 'data'
    `clang`: error: no input files
    make: *** [Makefile:143: alt] Error 1

    shell returned 2
```

because the `alt` rule had what normally is in the `${PROG}.alt` rule.



<div id="1989_ovdluhe">
## Winning entry: [1989/ovdluhe](1989/ovdluhe/index.html)
### Winning entry source code: [ovdluhe.c](%%REPO_URL%%/1989/ovdluhe/ovdluhe.c)
</div>

[Cody](#cody) fixed an infinite loop where the program would print the same thing over
and over again, flooding the screen. The problem is that there was a `for` loop
that by necessity had to not have an increment stage but the pointer only got
updated in the `if` path (in the loop itself).

Cody also provided the [try.sh](%%REPO_URL%%/1989/ovdluhe/try.sh) script which runs the
program four times on three files to show the different output. It doesn't run
the program on each file four times in a row but rather does it on each file
and starts over, doing it four times, to help with hopefully allowing different
output.

Cody also provided an [alternate version](%%REPO_URL%%/1989/ovdluhe/ovdluhe.alt.c) based on
the author's remarks and the [try.alt.sh](%%REPO_URL%%/1989/ovdluhe/try.alt.sh) script that
uses the alternate code, allowing one to configure the alt build. See the index.html
for details. The fix described above was fixed in this version too, after it was
discovered and fixed.


<div id="1989_paul">
## Winning entry: [1989/paul](1989/paul/index.html)
### Winning entry source code: [paul.c](%%REPO_URL%%/1989/paul/paul.c)
</div>

[Cody](#cody) fixed a segfault under macOS that prevented it from working. The problem
was that the int (from `#define f`) should be a `long`. This became apparent when
he was using lldb and saw that the type of a pointer was too `long` :-)

Cody also provided the [alternate version](%%REPO_URL%%/1989/paul/paul.alt.c)
which has the trace function that the author included but commented out. See the
index.html for details.


<div id="1989_robison">
## Winning entry: [1989/robison](1989/robison/index.html)
### Winning entry source code: [robison.c](%%REPO_URL%%/1989/robison/robison.c)
</div>

[Yusuke Endoh](#yusuke) fixed this to compile under modern systems. To see the changes
made, try:


``` <!---sh-->
    cd 1989/robison ; make diff_orig_prog
```

(It adds the C token pasting operator `##` instead of `/**/`.)

Cody added the [try.sh](%%REPO_URL%%/1989/robison/try.sh) script.


<div id="1989_tromp">
## Winning entry: [1989/tromp](1989/tromp/index.html)
### Winning entry source code: [tromp.c](%%REPO_URL%%/1989/tromp/tromp.c)
</div>

[Cody](#cody) and [Yusuke](#yusuke) fixed this entry: Yusuke fixed this to compile with `gcc` and Cody
fixed it for `clang` and made some other fixes as well.

To get it to work with `clang` the variable `a` had to not be the third argument
to `main()` but instead be a variable in `main()`.

Cody also fixed a segfault and made it so the that the high score file would
work (it was not even being created but it was supposed to be). This was
happening due to a file pointer being declared as a `long` and more
significantly the command in `popen(3)` was not correct.

Another problem Cody fixed was that the terminal was left in an insane state where you
could not type '`u`' and echo was completely disabled.

Cody later on fixed the [alt version](%%REPO_URL%%/1989/tromp/tromp.alt.c), provided by the author, so that it would
compile with `clang`, not abort (with an alarm), would have the tetriminos fall,
it would write to the high score file (the command to `popen(3)` was incorrect
here too but as can be seen it differs from the submitted version), could use
`stty` properly (and thus turn on echo again - it did not work because it was in
the `popen(3)` call rather than using `system(3)`), a couple compiler errors and
various other things, so that now the alt version, which is better, can be used.

Although we appreciate the help here, he cynically noted that he had to have an
IOCCC [Tetris](https://en.wikipedia.org/wiki/Tetris) working (this of course was
not his only reason :-) )


<div id="1989_vanb">
## Winning entry: [1989/vanb](1989/vanb/index.html)
### Winning entry source code: [vanb.c](%%REPO_URL%%/1989/vanb/vanb.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1989/vanb/try.sh) script.


<div id="1989_westley">
## Winning entry: [1989/westley](1989/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1989/westley/westley.c)
</div>

[Cody](#cody) fixed this for `clang`, except that two versions generated by the
program cannot be compiled by `clang` due to inherent defects in the compiler
and how the entry works. This is an **incredibly hard** one to fix for `clang`
whilst still being compilable with `gcc` (`gcc` can compile every generated
version with the fix but if one fixes all to compile with `clang`, which was
attempted, it introduced compile errors for `gcc`) and even if one fixes it to
compile with `clang` it does not, depending on how it's done, mean that any
other version will compile!

It is, however, possible to get `clang` to work with
two versions generated, `ver0` and `ver1`, though `ver0` is actually just the
main entry (but still generated by the program itself).

Unfortunately due to the way this entry works if it is even possible to get all
versions to compile with `clang` it will take heavy modifications to get all
versions to compile with `clang`. Cody almost got it and knows how it functions
but even getting it just about there caused compilation errors in `gcc` so it
might just not be possible.

The way it was fixed might be hard to see and describe but this is an attempt.
Because `main()`'s args were all `int`s, `main()` had to call a new function
which is allowed to have args as `int` (instead of `main()`'s args being `int` and
the rest being `char **`) but this is not as straight forward as it is for other
entries (if you look at the code you might see what is meant; the function called
is `pain()`).

The args of `main()` had to be set to the right type but only three args, **not
four**, even though the original program has four args. This is because not all
versions of `clang` support four args and that is one of the issues with version 2
and 3 as it generates `main()` to have four args and the wrong type, all `int`s.

In the call to the new function, `pain()`, from `main()`, one of the `char **`s
is used twice, once as `argc` with bitwise AND with 2, naturally first being
cast to an `int` (`(int)ABBA&2`), and once as a `char **`, the fourth arg to
`pain()` (yes even though `pain()` takes all `int`s).

The argc, meanwhile, `tang`, is used once and the second arg, `char **gnat` is
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
when `clang` could almost compile every version if not actually compile all
versions. Unfortunately when this was done it caused other systems to have
additional compilation errors so it seems highly unlikely that version 2 and 3
can work for `clang` (versions 0 and 1 can).

Despite the risks of changing names this was done and indeed by necessity.
Comments might have been changed but it is no longer known if that happened only
in the working on version 2 and 3 or if in the fix for `clang` as well as version
0 and 1.

To make use of this several scripts were added by Cody. The
[compile.sh](%%REPO_URL%%/1989/westley/compile.sh) script that removes the
generated code, rebuilds the program and regenerates the other code and then
compiles it will work for compilers like `gcc` and one can then use the
[try.sh](%%REPO_URL%%/1989/westley/try.sh) script to see example input and
output.

The `compile.sh` script allows one to specify the compiler with the `CC`
environmental variable; see the index.html for details.


<div id="1990">
# [1990 - The 7th IOCCC](1990/index.html)
</div>


<div id="1990_baruch">
## Winning entry: [1990/baruch](1990/baruch/index.html)
### Winning entry source code: [baruch.c](%%REPO_URL%%/1990/baruch/baruch.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1990/baruch/try.sh) script.

Cody also added an [alternate version](%%REPO_URL%%/1990/baruch/baruch.alt.c), which allows Turbo-C
and MSC to compile this code, based on the authors' remarks, except that Cody
did not change the `" #Q"` string as that appeared to show worse looking output
instead of improved output though he has no way to test the compilers in
question (i.e. it was only tested in the original entry). YMMV.

Cody also made the code look more like the original, removing the `int` from
the variables, adding instead `-Wno-implicit-int`. The newline added by the
judges was retained.


<div id="1990_cmills">
## Winning entry: [1990/cmills](1990/cmills/index.html)
### Winning entry source code: [cmills.c](%%REPO_URL%%/1990/cmills/cmills.c)
</div>

[Yusuke](#yusuke) got this to work in modern systems (it previously resulted in a bus
error).

[Cody](#cody) made this use `fgets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.



<div id="1990_dds">
## Winning entry: [1990/dds](1990/dds/index.html)
### Winning entry source code: [dds.c](%%REPO_URL%%/1990/dds/dds.c)
</div>

[Yusuke](#yusuke) and [Cody](#cody) in conjunction fixed this for modern systems (both fixed a
different compiler error but more fixes were also made).

Yusuke added the comma operator for a binary expression with `free(3)` which is
a compiler error because `free(3)` returns `void`. Cody then made it slightly
more like the original in this way by redefining `free` to have the comma
operator itself.

Cody fixed another compiler error by removing the erroneous prototype to
`fopen(3)`.  Cody also changed a `char *` used for file I/O to be a proper `FILE
*` and fixed a typo in [LANDER.BAS](%%REPO_URL%%/1990/dds/LANDER.BAS).

Cody also made this use `fgets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.



<div id="1990_dg">
## Winning entry: [1990/dg](1990/dg/index.html)
### Winning entry source code: [dg.c](%%REPO_URL%%/1990/dg/dg.c)
</div>

[Cody](#cody) fixed this for modern systems. There were two problems to be resolved.

One can no longer do:

``` <!---c-->
    #define d define

    #d b12(x) 12 x

    /* etc. */
```

so the use of `#d` is now instead `#define` (the macro was originally deleted
but later Cody added it back to make it more like the original).

The second problem was suggested by the judges at the time of judging, to do
with if the C preprocessor botches single quotes in `cpp` expansion.

Cody also added the [try.sh](%%REPO_URL%%/1990/dg/try.sh) script.


<div id="1990_jaw">
## Winning entry: [1990/jaw](1990/jaw/index.html)
### Winning entry source code: [jaw.c](%%REPO_URL%%/1990/jaw/jaw.c)
</div>

[Cody](#cody) fixed the script to work properly in modern environments including writing
to and extracting from `stdout` and relying on the exit code in the commands to
allow for `&& ...`.

Cody also changed the `perror(3)` call to `fprintf(3)` because in macOS when errno
is 0 it shows what looks like an error. However, see [1990/jaw in
bugs.html](bugs.html#1990_jaw).

Cody also added the [try.sh](%%REPO_URL%%/1990/jaw/try.sh) to run the commands that we suggested at
the time of releasing the winning entries of 1990.

NOTE: as `btoa` is not common we used a ruby script from [Yusuke](#yusuke) but with a minor
fix applied by Cody that made the program just show `oops` twice (twice is not
a typo here) from invalid input but which now works.


<div id="1990_pjr">
## Winning entry: [1990/pjr](1990/pjr/index.html)
### Winning entry source code: [pjr.c](%%REPO_URL%%/1990/pjr/pjr.c)
</div>

[Cody](#cody) added the [alternate code](%%REPO_URL%%/1990/pjr/pjr.alt.c) which was suggested by the judges
in the case that your compiler cannot compile `X=g()...` but it actually does
something else and is recommended by the author as well.


<div id="1990_scjones">
## Winning entry: [1990/scjones](1990/scjones/index.html)
### Winning entry source code: [scjones.c](%%REPO_URL%%/1990/scjones/scjones.c)
</div>

[Yusuke](#yusuke) suggested `-ansi` to get the entry to compile due to trigraphs and [Cody](#cody)
suggested `-trigraphs`. Both work but we used Yusuke's idea as this was seen
first.

Cody added the [try.sh](%%REPO_URL%%/1990/scjones/try.sh) script to show exactly what the
entry does.


<div id="1990_tbr">
## Winning entry: [1990/tbr](1990/tbr/index.html)
### Winning entry source code: [tbr.c](%%REPO_URL%%/1990/tbr/tbr.c)
</div>

[Cody](#cody) fixed this to work with modern compilers; `exit(3)` returns `void` but the
function was used in a binary expression so this wouldn't even compile.

Cody fixed (as above) and added the shortened version as [alternate
code](%%REPO_URL%%/1990/tbr/tbr.alt.c) which originally comes from the
author.

Cody also changed the code (in both versions) to use `fgets(3)` instead of
`gets(3)` so one would not get a warning about the use of `gets(3)` at linking
time or execution, the latter of which was causing confusing output due to the
warning being interspersed with the program's interactive output. See [FAQ 4.1
- Why were some calls to the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for more details on why this change was
done more generally.


<div id="1990_theorem">
## Winning entry: [1990/theorem](1990/theorem/index.html)
### Winning entry source code: [theorem.c](%%REPO_URL%%/1990/theorem/theorem.c)
</div>

[Cody](#cody) fixed this to compile with modern systems.

He also fixed some bugs that impacted the usability of this program including some
segfaults under modern systems (and possibly in some cases earlier systems) with
this entry.  Originally we noted that 4 trailing args, `0 0 0 0`, were
required on systems that dump core when `NULL` is dereferenced but the problem
this was meant to fix showed itself in modern systems even with the 4 `0`s. He also fixed a
segfault if not enough args are specified and fixed the code so that the
generated `fibonacci.c` actually works; before it just printed `0` over and over
again (since it did not work anyway a segfault prevention was added here). He
also fixed some array addressing (some of which might not be strictly necessary
but as he was testing the `fibonacci.c` bug he ended up changing it anyway).

BTW: why can't the fix:

``` <!---c-->
    if (a[1]==NULL||a[2]==NULL||a[3]==NULL||a[4]==NULL||a[5]==NULL) return 1;
```

be changed to just test the value of `A` when `a` is argv and `A` is argc? You
tell us!

Cody also changed the code to use `fgets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.


Since this program is so incredible the extra fixes were deemed worth having and
this is why they were done.

Cody later disabled a warning in the `Makefile` that proved to be a problem only
with `clang` in Linux but which was defaulting to an error. This way was the
simplest way to deal with the problem in question due to the way the entry
works.

Cody also added the [try.sh](%%REPO_URL%%/1990/theorem/try.sh) script which shows the
original program and some of the programs it generates.

[Yusuke](#yusuke) pointed out that `atof(3)` nowadays needs `#include <stdlib.h>` which was
used in order to get this to work initially (prior to this output was there but
incomplete).


<div id="1990_stig">
## Winning entry: [1990/stig](1990/stig/index.html)
### Winning entry source code: [stig.c](%%REPO_URL%%/1990/stig/stig.c)
</div>

[Cody](#cody) fixed the paths in the `Makefile` so that this would build in Linux (it
worked fine in macOS).

He also changed the `Makefile` to use `bash` not `zsh` as not all systems have
`zsh` and the `Makefile` actually sets `SHELL` to `bash`.


<div id="1990_westley">
## Winning entry: [1990/westley](1990/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1990/westley/westley.c)
</div>

[Cody](#cody) fixed this for modern systems. It had `1s` (digit one, letter s)
in places for a `short int` which was changed to just `1`.  Since it's
instructional to see the differences he has provided an alternate version,
[westley.alt.c](%%REPO_URL%%/1990/westley/westley.alt.c), which is the original
code.

He also changed the `argc` to be an `int`, not a `char`, even though it might
often be the same (this in particular was done for `clang`).

He also fixed the code to not enter an infinite loop if arg is a number not > 0.
To be more like the original the number of args passed to the program has not
been fixed so that if one passes no arg it will still likely crash.

Cody also added the [try.sh](%%REPO_URL%%/1990/westley/try.sh) script.



<div id="1991">
# [1991 - The 8th IOCCC](1991/index.html)
</div>


<div id="1991_ant">
## Winning entry: [1991/ant](1991/ant/index.html)
### Winning entry source code: [ant.c](%%REPO_URL%%/1991/ant/ant.c)
</div>

[Cody](#cody) added [alternate code](%%REPO_URL%%/1991/ant/ant.alt.c) that will be a bit easier to use for
those familiar with vim in the following ways (we don't want vi users to also
not be able to use it or exit it, now do we ? :-) ):

- Use `0` to go to first column.
- Use `$` to go to last column.
- Hit ESC to go back to command mode (instead of form-feed, ctrl-L).
- Use `w` to go forwards one word.
- Use `b` to go backwards one word.
- Use `q` to exit.

The other keys were left unchanged.


<div id="1991_brnstnd">
## Winning entry: [1991/brnstnd](1991/brnstnd/index.html)
### Winning entry source code: [brnstnd.c](%%REPO_URL%%/1991/brnstnd/brnstnd.c)
</div>

[Cody](#cody) fixed this for modern systems. There were two invalid operands to binary
expression (`char *`, `void` and `int`, `void`) to resolve and
additionally a mis-feature of the C pre-processor which no longer works had to
be changed as well in order to get this to compile. In particular the macro `C`,
defined as `C =G` to make `+=` and similar operators no longer works.  The
invalid operands to binary expressions were resolved with the comma operator.

Later on, Cody added back the macro `#define D define` to make it look ever so
slightly more like the original, even though it's unused.

Cody also added the [try.sh](%%REPO_URL%%/1991/brnstnd/try.sh) script and
[try.txt](1991/brnstnd/try.txt) which the script uses.

Cody also fixed the make clobber rule which left a symbolic link in the
directory even after the target file was deleted (from make clobber).

<div id="1991_buzzard">
## Winning entry: [1991/buzzard](1991/buzzard/index.html)
### Winning entry source code: [buzzard.c](%%REPO_URL%%/1991/buzzard/buzzard.c)
</div>

[Cody](#cody) fixed this so that the coordinates being specified, a documented
feature, would not crash the program. This happened because the function that
calls `atoi(3)` took an arg without any type specified and as an implicit `int`
it was not a `char *` which crashed the program in modern systems.

Cody also made the file name in the code (which is the default maze file) not
hard-coded but instead be `__FILE__`.

Finally Cody added the [alternate
version](%%REPO_URL%%/1991/buzzard/buzzard.alt.c) which will possibly feel more
at home with those familiar with vi(m): `k` for forward, `h` for left and `l`
for right. This version also has a more useful way to exit, just entering `q`
followed by enter, rather than completing (and it's a maze) or killing the
program. We still recommend you try the original version first, of course.


<div id="1991_davidguy">
## Winning entry: [1991/davidguy](1991/davidguy/index.html)
### Winning entry source code: [davidguy.c](%%REPO_URL%%/1991/davidguy/davidguy.c)
</div>

As some systems like macOS can be particular about not declaring functions
[Cody](#cody) added to the `Makefile` some `-include` options. These appear to
not be strictly necessary (currently) but it was done due to other syscalls
being a problem not being declared first, to hopefully future-proof it.


<div id="1991_dds">
## Winning entry: [1991/dds](1991/dds/index.html)
### Winning entry source code: [dds.c](%%REPO_URL%%/1991/dds/dds.c)
</div>

[Cody](#cody) fixed a segfault that prevented this entry from working in any
condition (the `char *s` had to be changed to `char s[]`) and he also made it
and the generated code work for `clang`.

Furthermore Cody changed it so that the C from the BASIC uses `fgets()`, not
`gets()`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.

For the magic of `clang` (which was done manually except the returning a value
in `main()` in the generated code and possibly `fgets(3)`) and `fgets(3)`, see
below. The problem with `clang` can be described simply as: `clang` (at least in
some systems?) defaults to having `-Werror` and the code that the entry
generates had some warnings that were causing compilation to fail if `cc` is
`clang` (the entry runs `cc a.c`).  An example problem that had to be fixed is
that the generated code returned from `main()` no value but rather just had
`return;`.

The code used to run `cc a.c` by what was once `system(q-6);` but if `cc` is `clang`
like in macOS this is not enough.

If you have the time and interest and you wish to follow the below a bit better,
see the author's remarks for the way the string works. The following had to be
added to the string `s`:

```
    !.Xop.fssps!.Xop.sfuvso.uzqf!.Xop.jnqmjdju.gvodujpo.efdmbsbujpo
```

and then the call to `system(3)` had to be changed to:

``` <!---c-->
    system(q-69);
```

An important point is that the placement of this string in the `s` array
**_does_ matter**. This is because of the code:

``` <!---c-->
    *o=fopen(q-3,"w");
```

which means the file name that translates to `a.c` has to be at the end of the
string. Thus the end of the string actually looks like:

```
    !.Xop.fssps!.Xop.sfuvso.uzqf!.Xop.jnqmjdju.gvodujpo.efdmbsbujpo!b/d
```

But then there is the matter of getting the C to use `fgets(3)`. As can be seen
above it's not as simple as changing `gets(3)` to `fgets(3)`. This involved more magic
characters that had to be updated and some added. The C code:

``` <!---c-->
    atoi(gets(b))
```

is in the string:

```
    bupj)hfut)c**
```

which was changed to be (in C):

``` <!---c-->
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

which is the end of the warning disabled for `clang` (as described above).

But now the `system(q-69);` had to be changed to `system(q-86);`.

Then, later on, Cody discovered that in some systems, `clang` triggers even more
warnings so this had to be corrected too so the string was updated again and
the `system(q-86)` had to be changed to `system(q-104)`.

But then to prevent the need for disabling a warning and to be more correct
code, the generated code was changed to `return 1;` rather than just `return;`.
Thus in full the string became:

``` <!---c-->
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
all versions of `clang`, but if not the above is how it works.

With these changes in place it will compile and work with both `gcc` and `clang` and
the C code generated will use `fgets(3)`, not `gets(3)`, therefore removing the
annoying warnings. Note that the array passed to `fgets(3)` is an `int` but that
was the same for `gets()` and is not necessary to update to a `char[]`. Thus you
might still get some warnings there.

The key to the string is that it rotates the character by `+1`. This was not
immediately clear until reading the author's remarks so there was an alt version
that was something of a kludge, running `make a` instead, but after the proper
fix was implemented the alternate code was removed.

Cody also fixed a typo in `LANDER.BAS` and made it so that if a file could not be
opened for reading or a file could not be opened for writing it would not crash.
The definition of whether that should be a bug to fix or a feature to not fix
was pondered and changed numerous times and ultimately that problem with this
entry was fixed. It has not been done in all.


<div id="1991_fine">
## Winning entry: [1991/fine](1991/fine/index.html)
### Winning entry source code: [fine.c](%%REPO_URL%%/1991/fine/fine.c)
</div>

[Cody](#cody) made it look much more like the original entry even after the fix
for `clang` (made by the judges) that increased the count in characters from 80 to
106, getting it back down to just 85 (and later back down to the original 80,
see below).

This was done by redefining `main` at the compiler line so that it looks like
the original where one didn't have to worry about the type of args of `main()`
(when there were fewer restrictions), and also by removing a cast that was
not strictly necessary (this created a new warning: `ordered comparison
between pointer and integer ('char **' and 'int')` but it's no longer there, as
described below).

That was `fine` as well but Cody decided to drop it back down to its original 80
characters which also resolved the warning described above. This was by more clever use of
the `Makefile` which now has a `-DB=(int)b` so that `B` can be used in place where
`(int)b` used to be necessary.

Cody also added the [try.sh](%%REPO_URL%%/1991/fine/try.sh) script which feeds the program
some fun input for fun but mostly different output. He added a great string from
Brian Westley and Cody also added several of his own (can you figure out exactly
which ones? :-) )


<div id="1991_rince">
## Winning entry: [1991/rince](1991/rince/index.html)
### Winning entry source code: [rince.c](%%REPO_URL%%/1991/rince/rince.c)
</div>

[Cody](#cody) fixed it so that the messages that show if you won or lost will be seen
after the end of the game. The reason it did not work before is curses was ended
at the end of the program which clears the screen. To make it look most like the
original entry Cody left the message before ending curses in and printed another
message of the same kind after `endwin()` was called with the exception that he
added a newline at the end of the screen to be more user friendly.

Cody also added [two alt versions](1991/rince/index.html#alternate-code), one to
remove the maximum number of moves you may make and another to let you configure
the maximum number of moves, even if that is making it harder to win. Naturally
the above fix was applied to these versions too.

The file `map-key.jpg` was added to help those with smaller screens as
unfortunately the formatting of the key to the map was not easy to change in a
way without ruining how it looks (beyond making it one column only).


<div id="1991_westley">
## Winning entry: [1991/westley](1991/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1991/westley/westley.c)
</div>

[Cody](#cody) fixed a segfault in this program which prevented it from working. The
problem was that the read-only `char` array `char *z[]` was being written to. The
fix was to change it to `char z[][100]` in two spots (see if you can determine
why two places, not one!). Why 100 when the longest string is < 100? Because a
shorter value caused strange output and it's easier to just choose a larger
value that works without having to find the correct value.

Cody also fixed the `ttt.sh` script that prevented the game from working and he
also improved it so that warnings/errors/about to compile messages are not shown
unless the `-e` option is used.  This is because the errors being shown kind of
ruins the experience. Finally he made it pass
[ShellCheck](https://www.shellcheck.net).

Cody also added the [alt version](%%REPO_URL%%/1991/westley/westley.alt.c) which
is based on the author's remarks, a version that supposedly (:-) ) always wins.

Cody also fixed the make clobber rule where a file was left lying about when it
should have been removed.


<div id="1992">
# [1992 - The 9th IOCCC](1992/index.html)
</div>


<div id="1992_adrian">
## Winning entry: [1992/adrian](1992/adrian/index.html)
### Winning entry source code: [adrian.c](%%REPO_URL%%/1992/adrian/adrian.c)
</div>

[Cody](#cody) fixed the code so that it will try opening the file the code was compiled
from (`__FILE__`), not  `adgrep.c`, as the latter does not exist: `adgrep` is
simply a link to `adrian` as `adgrep` is what the program was submitted as but
the entry's winning source file is `adrian.c`.

Not fixing the above problem would have also caused the program to crash if no
arg was specified as the file doesn't exist. In making the above fix, at first
the change to check for a `NULL` file was added. Then it was noticed that the
problem is that `adgrep.c` was an incorrect reference that never existed and it
was never fixed in any of the files, not the code or the documentation, and thus
was entirely incorrect code. A fun fact is that one can do:

``` <!---c-->
    W= fopen(wc>= 2 ? V[1] : __FILE__,"rt");if(!W)exit(1);
```

but one _CANNOT_ do:

``` <!---c-->
    W= fopen(wc>= 2 ? V[1] : __FILE__,"rt");if(!W)exit(1);
    if (W==NULL)exit(1);
```

because `adwc.c` will be empty! The difference is it is on a newline, the check.
This is an example of how a simple change in code can break it and this is also
true of another change as further below.

Cody also restored a slightly more obscure line of code that had been changed:

``` <!---diff-->
    -   putc("}|uutsrq`_^bji`[Zkediml[PO]a_M__]ISOYIRGTNR"[i]+i-9,stderr);
    +   putc(i["}|uutsrq`_^bji`[Zkediml[PO]a_M__]ISOYIRGTNR"]+i-9,stderr);
```

though it's questionable how much more (if at all) obscure that is :-)

Cody also changed the location that it used `gets()` to be `fgets(3)`.
See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.
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

``` <!---c-->
    while( gets(Y) ){ Y[strlen(Y)-1]='\0'; if(A(Y)) puts(Y); }
```

one must keep the `Y[strlen(Y)-1]='\0';` part and keep it there.

These fixes are complex changes due to the way the program and `Makefile` generate
the additional tools.

Cody finally added the [try.sh](%%REPO_URL%%/1992/adrian/try.sh) script that shows the entry
and some of the tools this entry generates. Unlike other scripts, it does not
clear the screen after compilation so that one can see how the other files are
generated.


<div id="1992_albert">
## Winning entry: [1992/albert](1992/albert/index.html)
### Winning entry source code: [albert.c](%%REPO_URL%%/1992/albert/albert.c)
</div>

[Cody](#cody) fixed this to compile with modern systems. Note that in 1996 a bug fix was
applied to the code, provided as the alternate code as that version is not obfuscated.
Thus Cody's fix applies to the original entry. The problems were that `malloc.h`
is not the correct header file now (at least in some systems) and a non-void
(implicit `int`) function returning without a value. That function was changed to
return `void`.

Cody also added the [try.sh](%%REPO_URL%%/1992/albert/try.sh) and
[try.alt.sh](%%REPO_URL%%/1992/albert/try.alt.sh) scripts that correspond to the entry and
the alternate code.

Even so, check [1992/albert in bugs.html](bugs.html#1992_albert).


<div id="1992_ant">
## Winning entry: [1992/ant](1992/ant/index.html)
### Winning entry source code: [ant.c](%%REPO_URL%%/1992/ant/ant.c)
</div>

[Cody](#cody) fixed the `Makefile` so that the program will actually work with it (or at
least the rule to clobber files and link `am` to `ant`). The issue was that the
variables in the `Makefile` could not be evaluated in the same way as it's not as
feature-rich as other implementations of `make(1)`. Thus the use of `${RM}` and
`${CP}` were in the respective rules changed to `rm` and `cp`, for two examples.
A new rule had to be added as well. The variable situation might be because they
are obtained from the root variable `Makefile` `var.mk` via `include` which the
program might not support (this has not been tested, however) and also because
it appears that the syntax for this program is to use `$()` rather than `${}`.

Cody also fixed another problem, unrelated, in the `Makefile` with the `.PHONY`
rule where a line was not ended with a `\` but should have been.

The author stated that in some systems like DOS with Turbo C, it might be
necessary to include `time.h` so Cody did this as well as this exists in other
systems too.

Cody also added the [try.sh](%%REPO_URL%%/1992/ant/try.sh) script.


<div id="1992_buzzard.1">
## Winning entry: [1992/buzzard.1](1992/buzzard.1/index.html)
### Winning entry source code: [buzzard.1.c](%%REPO_URL%%/1992/buzzard.1/buzzard.1.c)
</div>

[Cody](#cody) added a check for the right number of args, exiting 1 if not enough (2)
used. This was not originally done but at a time it was changed to be considered
a bug so it was fixed at that point as it only took a few seconds and had to be
verified that it was consistent with the [bugs.html](bugs.html) file.

He also added the [try.sh](%%REPO_URL%%/1992/buzzard.1/try.sh) script to try out some
commands that we suggested and some additional ones that he provide for some fun.


<div id="1992_buzzard.2">
## Winning entry: [1992/buzzard.2](1992/buzzard.2/index.html)
### Winning entry source code: [buzzard.2.c](%%REPO_URL%%/1992/buzzard.2/buzzard.2.c)
</div>

[Cody](#cody) fixed the alternate code to compile. The problem was it assumed that
`exit(3)` returns a value, not `void`. This was fixed with a `,0`.

Cody also added the [try.sh](%%REPO_URL%%/1992/buzzard.2/try.sh) and
[try.alt.sh](%%REPO_URL%%/1992/buzzard.2/try.alt.sh) scripts that correspond to the entry
and its alternate code.


<div id="1992_gson">
## Winning entry: [1992/gson](1992/gson/index.html)
### Winning entry source code: [gson.c](%%REPO_URL%%/1992/gson/gson.c)
</div>

[Cody](#cody) fixed a crash that prevented this entry from working in some cases in some
systems (like macOS) by disabling the optimiser in the Makefile.

Cody also added the [try.sh](%%REPO_URL%%/1992/gson/try.sh) script.

Cody also added the [mkdict.sh](%%REPO_URL%%/1992/gson/mkdict.sh) script that the author
included in their remarks. See the index.html for its purpose. It was NOT fixed
for [ShellCheck](https://www.shellcheck.net)
because the author deliberately obfuscated it so **PLEASE *DO NOT* FIX THIS OR
MODERNISE IT**.

Cody also changed the buffer size in such a way that `gets(3)` should be safe
(well, theoretically) as it comes from the command line (though it can also read input
from `stdin` after starting the program). Ideally `fgets(3)` would be used but this
is a more problematic. See [1992/gson in bugs.html](bugs.html#1992_gson) for more
details if you're interested in trying to understand it (or fix?).


<div id="1992_imc">
## Winning entry: [1992/imc](1992/imc/index.html)
### Winning entry source code: [imc.c](%%REPO_URL%%/1992/imc/imc.c)
</div>

[Cody](#cody) provided the [try.sh](%%REPO_URL%%/1992/imc/try.sh) script.

The original code, [imc.orig.c](%%REPO_URL%%/1992/imc/imc.orig.c), assumed that `exit(3)`
returned a value but this will cause problems where `exit(3)` returns `void`. The
source code was modified to avoid this problem but like Cody did with other fixes
he made this more like the original by redefining `exit` to use the comma
operator so that it could be used in binary expressions.


<div id="1992_kivinen">
## Winning entry: [1992/kivinen](1992/kivinen/index.html)
### Winning entry source code: [kivinen.c](%%REPO_URL%%/1992/kivinen/kivinen.c)
</div>

It was observed that on modern systems this goes much too quick. [Yusuke](#yusuke) created
a patch that calls `usleep(3)` but [Cody](#cody) thought the value was too slow so he
made it a macro in the `Makefile` `Z` (which can be redefined with `make
SLEEP=...`), defaulting at 15000. This was made an [alternate
version](%%REPO_URL%%/1992/kivinen/kivinen.alt.c) and it is recommended one use
the alternate version first. See the index.html file to see how to reconfigure it.

Cody also made the fixed version (the code relied on `exit(3)` returning to use
in binary expressions) (and alternate code from it) more like the original by renaming
the `ext` macro to be `exit` which uses the comma operator. He made it so the
line lengths match the original code, at least as best as possible (if not
perfectly), including start and end columns, often (if not all) with the same
start and end character.

Cody made `main()` have two args, not one, as some versions of `clang` have a
defect with the number of args to `main()` though when it comes to 1 arg it is
only in an error message if say 4 args are used. This is out of an abundance of
caution as it's quite possible that `clang` or the ANSI C committee end up further
changing this.  See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Yusuke also noted that there is a bug in the program where right after starting
it moves towards the right but if you click the mouse it goes back. See
[1992/kivinen in bugs.html](bugs.html#1992_kivinen) for more details.


<div id="1992_lush">
## Winning entry: [1992/lush](1992/lush/index.html)
### Winning entry source code: [lush.c](%%REPO_URL%%/1992/lush/lush.c)
</div>

[Yusuke](#yusuke) supplied a patch which makes this work with `gcc`. Due to how
it works (see [Judges' remarks in the index.html
file](1992/lush/index.html#judges-remarks)) this will not work with `clang`.

[Cody](#cody) also provided the [lush.sh](%%REPO_URL%%/1992/lush/lush.sh) script to
demonstrate it as using make was problematic.

Cody made it use `fgets()` instead of `gets()`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x29;3&#x28; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.

NOTE: this entry cannot work with `clang` due to different compiler messages (it
will compile fine but it won't work). See [1992/lush in
bugs.html](bugs.html#1992_lush) for details.


<div id="1992_marangon">
## Winning entry: [1992/marangon](1992/marangon/index.html)
### Winning entry source code: [marangon.c](%%REPO_URL%%/1992/marangon/marangon.c)
</div>

[Cody](#cody) made this more portable by changing the `void main()` to be `int main()`.


<div id="1992_nathan">
## Winning entry: [1992/nathan](1992/nathan/index.html)
### Winning entry source code: [nathan.c](%%REPO_URL%%/1992/nathan/nathan.c)
</div>

[Cody](#cody) added the original file back as it was deemed that the export restrictions
should no longer be a cause of concern for this entry. Doing this did require a
change to Cody's [2020/ferguson2](2020/ferguson2/index.html) entry as it's
referenced.

Cody cynically noted that if he goes quiet, for instance if he no longer
participates in the IOCCC, that it must be our fault! :-)

Cody also added the [try.sh](%%REPO_URL%%/1992/nathan/try.sh) script that runs a few commands
that we suggested as well as one he provided.


<div id="1992_vern">
## Winning entry: [1992/vern](1992/vern/index.html)
### Winning entry source code: [vern.c](%%REPO_URL%%/1992/vern/vern.c)
</div>

[Cody](#cody) fixed an infinite loop if one were to input numbers < `0` or > `077`. The
problem was that it tried to use `scanf(3)` with the format specifier `"%o %o"` in a
loop, reading again if `scanf(3)` did not return 2 (that was not a problem in
that `scanf(2)` will not return until the number of specifiers have been
processed or some error occurs) or a function it called returned non-zero.

Instead the fix involves the `scanf(3)` specifiers being `"%4s %4s"` on two
new char arrays (always cleared in the beginning of the loop) and then using
`strtol(3)` with a base of `8` (as it's octal), checking for `< 0 || > 077` on
both numbers (using `"%o %o"` does not solve the problem).

This was deemed a problem to fix as the Judges' remarks hinted that this was how
it used to be.


<div id="1992_westley">
## Winning entry: [1992/westley](1992/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1992/westley/westley.c)
</div>

[Cody](#cody) fixed this to work for `clang` by changing the third and fourth arg of
`main()` to be `char **` inside `main()`; `clang` requires args 2 - 4 to be `char
**` and some versions do not even allow a fourth arg.

He also added the alternate version that the author gave in the remarks that is
specifically for the USA rather than the world. This had to be fixed for `clang`
as well to make the args of `main()` be the correct type and by moving the body
of main() to another function, `pain()`, which does the work since not all
versions of `clang` support four args to `main()`.

Cody also removed the restriction that one has to have a terminal that wraps at
80 columns so that as long as the terminal's columns (try `echo $COLUMNS`) is >=
80 it should work. As most people have wider terminals than back in 1992 this
should help make it much easier to use. Note that if the number of columns is <
80 it will not work right. The way this was done is that every 80 iterations in
the final loop it prints another newline. This fix has another bonus in that
resizing the terminal after running it should not mess up the display either,
unless of course it becomes too small.

Cody added the scripts [whereami.sh](%%REPO_URL%%/1992/westley/whereami.sh) and
[whereami.alt.sh](%%REPO_URL%%/1992/westley/whereami.alt.sh) which correspond to the entry and
the alternate code but first check that the number of columns is at least 80 and if
not it is an error.

Cody added the [try.sh](%%REPO_URL%%/1992/westley/try.sh) script that shows the different
cities that the author recommended one try as well as the one recommended by the
judges (approximate judging location), labelling each city and printing a
newline before the next city. The try.sh script uses the `whereami.sh` and
`whereami.alt.sh` scripts, as long as they're executable (if they're not it
first tries to make it executable and if it fails to do so it just uses
`westley` or `westley.alt`. The scripts can be deceived by `COLUMNS=80 ./try.sh`
(or `COLUMNS=80 ./whereami.sh` etc.) but this is a feature, not a bug.

Cody also added an arg check because the program and the
[alternate version](%%REPO_URL%%/1992/westley/westley.alt.c) might have crashed or
[nuked](https://en.wikipedia.org/wiki/Nuclear_weapon) the [entire
world](https://en.wikipedia.org/wiki/Earth) or just the
[USA](https://en.wikipedia.org/wiki/United_States), respectively, without enough
args (2). And not that we need the help or anything for this :-) but we
encourage you to try the original without two args :-)


<div id="1993">
# [1993 - The 10th IOCCC](1993/index.html)
</div>


<div id="1993_ant">
## Winning entry: [1993/ant](1993/ant/index.html)
### Winning entry source code: [ant.c](%%REPO_URL%%/1993/ant/ant.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1993/ant/try.sh) script and a data file,
[ants.txt](1993/ant/ants.txt), full of ants for the script.


<div id="1993_cmills">
## Winning entry: [1993/cmills](1993/cmills/index.html)
### Winning entry source code: [cmills.c](%%REPO_URL%%/1993/cmills/cmills.c)
</div>

[Yusuke](#yusuke) suggested that with modern systems this goes too fast so he added a call
to `usleep(3)` in a patch he made. [Cody](#cody) made it configurable at compilation by
using a macro. This is in the [alternate
version](%%REPO_URL%%/1993/cmills/cmills.alt.c) which is the recommended one to try
first.


<div id="1993_dgibson">
## Winning entry: [1993/dgibson](1993/dgibson/index.html)
### Winning entry source code: [dgibson.c](%%REPO_URL%%/1993/dgibson/dgibson.c)
</div>

[Cody](#cody) fixed the [dgibson.sh](%%REPO_URL%%/1993/dgibson/dgibson.sh) script to work
which assumed that `.` is in the path.

Cody also added the [try.sh](%%REPO_URL%%/1993/dgibson/try.sh) script which runs the above
mentioned script on all the data files.


<div id="1993_ejb">
## Winning entry: [1993/ejb](1993/ejb/index.html)
### Winning entry source code: [ejb.c](%%REPO_URL%%/1993/ejb/ejb.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1993/ejb/try.sh) script.


<div id="1993_jonth">
## Winning entry: [1993/jonth](1993/jonth/index.html)
### Winning entry source code: [jonth.c](%%REPO_URL%%/1993/jonth/jonth.c)
</div>

Both [Cody](#cody) and [Yusuke](#yusuke) fixed this so that it will work with modern systems. Yusuke
provided some fixes of the X code (it is not known at the time of writing this
what changed) and Cody fixed the C pre-processor directives
so that it would compile. It used to be that you could get away with code like:

``` <!---c-->
    G        int i,j
    K        case
```

and expect `G;` to equate to `int i, j;` (though it's now a long) and `K` to mean
`case` but that's no longer the case so the offending lines had `#define`
prepended to them.


<div id="1993_leo">
## Winning entry: [1993/leo](1993/leo/index.html)
### Winning entry source code: [leo.c](%%REPO_URL%%/1993/leo/leo.c)
</div>

[Cody](#cody) fixed this to work with modern compilers. This involved different header
files for functions.


<div id="1993_lmfjyh">
## Winning entry: [1993/lmfjyh](1993/lmfjyh/index.html)
### Winning entry source code: [lmfjyh.c](%%REPO_URL%%/1993/lmfjyh/lmfjyh.c)
</div>

[Cody](#cody) added an [alternate
version](%%REPO_URL%%/1993/lmfjyh/lmfjyh.alt.c) which does what the program did
with `gcc` < 2.3.3. See the index.html file for details and for why this was made
the alternate version, not the actual entry.

Cody also made the `Makefile` delete the very unsafe filename that is compiled (or
would be compiled if `gcc` < 2.3.3) whether or not compilation succeeds (which is
highly unlikely).


<div id="1993_plummer">
## Winning entry: [1993/plummer](1993/plummer/index.html)
### Winning entry source code: [plummer.c](%%REPO_URL%%/1993/plummer/plummer.c)
</div>

[Cody](#cody) added check for two args during a time that this was considered a
bug to fix.

Cody also added an [alternate version](%%REPO_URL%%/1993/plummer/plummer.alt.c)
which uses `usleep(3)` so you can see how this entry used to look, if you're
using a more modern system. This version also checks for two args and it is the
one we recommend one try first. See the index.html files for details.

Cody also added the [try.sh](%%REPO_URL%%/1993/plummer/try.sh) and
[try.alt.sh](%%REPO_URL%%/1993/plummer/try.alt.sh) scripts that correspond to the original
entry and the alt version, both allowing one to change the args (and in the case
of the alt one allowing one to change the amount to sleep).


<div id="1993_rince">
## Winning entry: [1993/rince](1993/rince/index.html)
### Winning entry source code: [rince.c](%%REPO_URL%%/1993/rince/rince.c)
</div>

[Yusuke](#yusuke) supplied a patch to get this to work in modern systems. This fix also
applies the compatibility issue of `select(2)` described in the index.html file.

[Cody](#cody) added a call to `endwin()` to help with terminal sanity after the program
ends.

Cody provided two alternate versions to simplify slowing the game down and, for
the second one, to make movement keys (of the default game) more familiar to vi
users. The slowing down was based on our suggestion that it might be desired to
slow down but Cody did it in such a way that makes it easy to configure at
compile time. See the index.html for details.


<div id="1993_schnitzi">
## Winning entry: [1993/schnitzi](1993/schnitzi/index.html)
### Winning entry source code: [schnitzi.c](%%REPO_URL%%/1993/schnitzi/schnitzi.c)
</div>

[Cody](#cody) made this use `fgets(3)` not `gets(3)`. See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.



<div id="1993_vanb">
## Winning entry: [1993/vanb](1993/vanb/index.html)
### Winning entry source code: [vanb.c](%%REPO_URL%%/1993/vanb/vanb.c)
</div>

[Cody](#cody) fixed this to work with `clang`. The problem was that the third arg to main()
was not a `char **. Instead `O5()` (which was `main()` via `-DO5=main`) is now
its own function which main() calls with the right parameters.

Later Cody fixed it again to look much more like the original where only a
single line is added, that of `main()`, which calls `O5()`. This was done through
`-include stdio.h` at the compiler (in the `Makefile`) and by removing the `O3`
variable (an int) at the top of the file, instead making it a `char ** in
`main()` (`O5()` had three args) but then passing in `0` to `O5()` for the third
arg (as it was 0 at file scope already this is perfectly fine and it means
there's no need to cast it to an int in the function call though that would also
work).

Cody also added the alternate code, provided by the author, which is:

```
    ... a version of the program before it got formatted into the VIII,
    augmented with comments showing where each state begins. N1 and N2 are
    notes.
```

but fixed to work with `clang` as well.

NOTE: the `N1` and `N2` are provided as notes in the index.html file describing
this code. Other code is also described there.

Cody also added the [try.sh](%%REPO_URL%%/1993/vanb/try.sh) script.


<div id="1994">
# [1994 - The 11th IOCCC](1994/index.html)
</div>


<div id="1994_dodsond2">
## Winning entry: [1994/dodsond2](1994/dodsond2/index.html)
### Winning entry source code: [1994/dodsond2](%%REPO_URL%%/1994/dodsond2/dodsond2.c)
</div>

[Cody](#cody) fixed an infinite loop that could happen when you shoot an arrow
and end up having no arrows, thus making one force quit the game. The problem
was in a condition in the outer loop it would repeatedly get input (if
`getchar()` returned `'\n'`),  only if one has more than one arrow, returning
after that.  But if there were 0 arrows left it did not return and so the loop
started over, doing nothing. This fix also seems to have fixed a problem where
if you shoot your last arrow it would not move you to the room you shoot into
(whereas if you had more arrows it would).

Cody added an alt version that allows one to cheat by specifying how many arrows
to start with (this does make for fun but it allowed to easily debug the above
mentioned infinite loop which hanged the program).

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


<div id="1994_horton">
## Winning entry: [1994/horton](1994/horton/index.html)
### Winning entry source code: [1994/horton](%%REPO_URL%%/1994/horton/horton.c)
</div>

[Cody](#cody) fixed this to check that four args were specified (at a time it
was considered a bug to fix). With the use of the C pre-processor macro and
inclusion of `stdlib.h` in the `Makefile` the layout of the source is exactly the
same column width and no additional lines were added. This was done during one
of the times where this was changed to bug to fix status, for better or worse.

Cody also fixed the `Makefile` which was causing alternate code to be compiled when it
shouldn't be.

Cody also added the scripts [try.sh](%%REPO_URL%%/1994/horton/try.sh) and
[try.alt.sh](%%REPO_URL%%/1994/horton/try.alt.sh).

Finally he added the article (written by the entry's author) cited in
[login_sept92-pp28-31.pdf](1994/horton/login_sept92-pp28-31.pdf).


<div id="1994_imc">
## Winning entry: [1994/imc](1994/imc/index.html)
### Winning entry source code: [imc.c](%%REPO_URL%%/1994/imc/imc.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1994/imc/try.sh) script.

Cody also added inclusion of `unistd.h` for `getpid(2)`. While strictly speaking
this was not necessary (in multiple systems) it can sometimes be a problem and
as it was noticed it was changed (the only case this was done except in the
entries that actually did not work because of missing or incorrect prototypes).


<div id="1994_ldb">
## Winning entry: [1994/ldb](1994/ldb/index.html)
### Winning entry source code: [ldb.c](%%REPO_URL%%/1994/ldb/ldb.c)
</div>

[Cody](#cody) fixed this so it would compile and work with modern compilers. The problem
was that `srand()` returns `void` but it was used in a `||` expression. Thus the
comma operator was needed.

Cody also fixed it for `clang` under Linux which objected to incompatible pointer
type (because `time(2)` takes a `time_t *` which in some systems is a `long *`
but what was being passed to it is an `int`).

Cody also changed the entry to use `fgets(3)` instead of `gets(3)`.
(See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.)

This one has
a minor annoyance in that it now prints a newline after the output but this
seems like a worthy compromise for preventing the interspersed output in macOS
and at the same time it's safer and allows for parsing file with longer lines.
Fixing it it to not have the extra newline is more problematic than it's worth,
in macOS another line of output would be shown without the change anyway -
unless `2>/dev/null` - and the difference is that now it's just a blank line
rather than an annoying warning. A subtlety about this fix: if a line is greater
than 231 in length if the program chooses that line it might print the first 231
characters or it might print (up to) the next 231 characters and so on.

Cody also added the [try.sh](%%REPO_URL%%/1994/ldb/try.sh) script.


<div id="1994_schnitzi">
## Winning entry: [1994/schnitzi](1994/schnitzi/index.html)
### Winning entry source code: [schnitzi.c](%%REPO_URL%%/1994/schnitzi/schnitzi.c)
</div>

[Cody](#cody) added two alt versions, [one which uses
fgets_&#x28;&#x29;](%%REPO_URL%%/1994/schnitzi/schnitzi.alt.c) but when fed its own source code cannot
generate code that compile and another [one with a bigger buffer
size](%%REPO_URL%%/1994/schnitzi/schnitzi.alt2.c) which, when fed its own source code, will
generate compilable code but not with the same buffer size but rather the
original buffer size. Cody explains this at [1994/schnitzi in
bugs.html](bugs.html#1994-schnitzi).

The purpose for these versions it both demonstrate how the magic works behind it
and to help others, should they wish, get the code to work with `fgets(3)`, with
or without an increase in buffer size. Note that without this feeding longer
files, say the index.html file, will crash the program. See [1994/schnitzi in
bugs.html](bugs.html#1994_schnitzi) where Cody also explains the magic for more
details. Later on, if nobody takes up the task, Cody might resume it, but for
now there is more important work to do so that the next contest can run.

Cody also added the [try.sh](%%REPO_URL%%/1994/schnitzi/try.sh) and
[try.alt.sh](%%REPO_URL%%/1994/schnitzi/try.alt.sh) scripts.


<div id="1994_shapiro">
## Winning entry: [1994/shapiro](1994/shapiro/index.html)
### Winning entry source code: [shapiro.c](%%REPO_URL%%/1994/shapiro/shapiro.c)
</div>

[Cody](#cody) fixed a bug on systems where `EOF != -1`. The problem is that `getc()` and
the related functions do not return `-1` on EOF or error but rather `EOF`.
However `EOF` is not required to be `-1` but merely an int < 0 and this program
assumed that `getc()` will return `-1` on EOF or error, not `EOF`. On systems
where `EOF != -1` it could result in an infinite loop.

For an interesting problem that occurred here and what was done to solve it,
check [1994/shapiro in bugs.html](bugs.html#1994_shapiro).


<div id="1994_smr">
## Winning entry: [1994/smr](1994/smr/index.html)
### Winning entry source code: [smr.c](%%REPO_URL%%/1994/smr/smr.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1994/smr/try.sh) script.


<div id="1994_tvr">
## Winning entry: [1994/tvr](1994/tvr/index.html)
### Winning entry source code: [1994/tvr](%%REPO_URL%%/1994/tvr/tvr.c)
</div>

[Cody](#cody) added the try scripts, four total, colour and black and white
pairs for the original entry and the alternate code. These scripts are
[try.color.sh](%%REPO_URL%%/1994/tvr/try.color.sh) (color to match the author's
remarks), [try.bw.sh](%%REPO_URL%%/1994/tvr/try.bw.sh),
[try.alt.color.sh](%%REPO_URL%%/1994/tvr/try.alt.color.sh) and
[try.alt.bw.sh](%%REPO_URL%%/1994/tvr/try.alt.bw.sh), respectively. The scripts go through
each mode allowed with two sizes, 128 and 256, allowing one to quit or skip each
(given that there are a lot of invocations this seemed like a good idea).

Cody also made this use `fgets(3)` instead of `gets(3)`.
See [FAQ 4.1  - Why were some calls to
the libc function gets&#x29;3&#x28; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.
In this case the newline had
to be terminated but it was a pretty straightforward fix. `gets()` was defined
to use `fgets()` and the inclusion of `stdio.h` had to be added but to make it
more like the original entry this was done in the Makefile. The alternate code was
also changed to use `fgets(3)`.


<div id="1994_weisberg">
## Winning entry: [1994/weisberg](1994/weisberg/index.html)
### Winning entry source code: [weisberg.c](%%REPO_URL%%/1994/weisberg/weisberg.c)
</div>

[Cody](#cody) changed the `Makefile` to make this program more user friendly and easier to
use with other tools as well by making the program output not a space after each
number but rather a newline.

Cody also added the scripts [try.sh](%%REPO_URL%%/1994/weisberg/try.sh) and
[primes.sh](%%REPO_URL%%/1994/weisberg/primes.sh). The `primes.sh` script is used by
`try.sh` and if both `primes(1)` and `rev(1)` are installed it will reverse the
lines of the `weisberg`, feeding it to `primes(1)`, showing those that are
primes. It only does the reversed output because the program actually prints
primes.


<div id="1994_westley">
## Winning entry: [1994/westley](1994/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1994/westley/westley.c)
</div>

[Cody](#cody) converted the deobfuscation compiler options (provided by the author) to be
compiler commands and added a script [try.sh](%%REPO_URL%%/1994/westley/try.sh) to
automate the deobfuscation commands to make it easier to see the game in action from
start to finish.

Cody also added the [alternate version](%%REPO_URL%%/1994/westley/westley.alt.c)
that will look fine on terminals not set to 80 columns and the
[try.alt.sh](%%REPO_URL%%/1994/westley/try.alt.sh) script to automate the play
along the lines of the [try.sh](%%REPO_URL%%/1994/westley/try.sh) script.


<div id="1995">
# [1995 - The 12th IOCCC](1995/index.html)
</div>


<div id="1995_cdua">
## Winning entry: [1995/cdua](1995/cdua/index.html)
### Winning entry source code: [cdua.c](%%REPO_URL%%/1995/cdua/cdua.c)
</div>

[Cody](#cody) fixed this so that it would work with macOS. Once it could compile it
additionally segfaulted under macOS which he also fixed.

Cody also provided the [alternate code](%%REPO_URL%%/1995/cdua/cdua.alt.c) for fun :-) ) (in
particular to make it easier to see the program do what it does in systems that
are too fast ... if there is such a thing anyway :-) ). See the index.html for
details on this.

Out of an abundance of caution with `clang`, Cody also added a second arg to
`main()` as some versions of `clang` whine about the number of args on top of the
type of args. In particular some versions supposedly only allow 0, 2 or 3 args.
It actually appears to allow 1 but if you specify 4 it says 0, 2 or 3 and it is
an error but it's entirely possible that they will eventually make the defect
function as the error message claims.  See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.



<div id="1995_dodsond1">
## Winning entry: [1995/dodsond1](1995/dodsond1/index.html)
### Winning entry source code: [dodsond1.c](%%REPO_URL%%/1995/dodsond1/dodsond1.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/dodsond1/try.sh) script that uses the text file he
provided which is input we suggested one try with the entry.


<div id="1995_esde">
## Winning entry: [1995/esde](1995/esde/index.html)
### Winning entry source code: [esde.c](%%REPO_URL%%/1995/esde/esde.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/esde/try.sh) script.


<div id="1995_garry">
## Winning entry: [1995/garry](1995/garry/index.html)
### Winning entry source code: [garry.c](%%REPO_URL%%/1995/garry/garry.c)
</div>

[Cody](#cody) fixed the alternate code so that it will compile with modern compilers. The
problem was a missing `int` for the `f` variable. He felt it was even more
important that it works because the layout does indeed look to him like a rat is
dropping core :-), something that the judges suggested.

Cody also renamed `garry.test.sh` to [try.sh](%%REPO_URL%%/1995/garry/try.sh) and improved it
to to make sure the program is compiled before trying to use it as well as
adding a few enhancements. For the alt version he also added the
[try.alt.sh](%%REPO_URL%%/1995/garry/try.alt.sh) script to use the alt version, though the
alt version is not as important as alternate code in other entries. In order to get
the paging to work right for the `garry.data` file leading blank lines had to be
added.


<div id="1995_heathbar">
## Winning entry: [1995/heathbar](1995/heathbar/index.html)
### Winning entry source code: [1995/heathbar](%%REPO_URL%%/1995/heathbar/heathbar.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/heathbar/try.sh) script.


<div id="1995_leo">
## Winning entry: [1995/leo](1995/leo/index.html)
### Winning entry source code: [leo.c](%%REPO_URL%%/1995/leo/leo.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/leo/try.sh) script.

At our change in how to deal with deobfuscation, Cody also uudecoded the deobfuscation inforation provided
by the author, putting it in [spoiler.html](1995/leo/spoiler.html).


<div id="1995_makarios">
## Winning entry: [1995/makarios](1995/makarios/index.html)
### Winning entry source code: [makarios.c](%%REPO_URL%%/1995/makarios/makarios.c)
</div>

[Cody](#cody) fixed this so that it will compile with versions of `clang` that has a defect
which only allows `main()` to have 0, 2 or 3 args. This is done by a new
function (`pain()` as it's annoying that `clang` is this way :-) ) that `main()`
calls which has the four args.


<div id="1995_savastio">
## Winning entry: [1995/savastio](1995/savastio/index.html)
### Winning entry source code: [savastio.c](%%REPO_URL%%/1995/savastio/savastio.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/savastio/try.sh) script.


<div id="1995_schnitzi">
## Winning entry: [1995/schnitzi](1995/schnitzi/index.html)
### Winning entry source code: [schnitzi.c](%%REPO_URL%%/1995/schnitzi/schnitzi.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1995/schnitzi/try.sh) script.


<div id="1995_vanschnitz">
## Winning entry: [1995/vanschnitz](1995/vanschnitz/index.html)
### Winning entry source code: [vanschnitz.c](%%REPO_URL%%/1995/vanschnitz/vanschnitz.c)
</div>

[Cody](#cody) added the authors' [deobfuscation source code](%%REPO_URL%%/1995/vanschnitz/vanschnitz.alt.c)
as in 2023 we have decided that in most
cases all the code should be available for the wider audience, without having to
extract it. The exception is when the files are created by the entry or the
entry decrypts the text or something like that.

Cody also added the [try.sh](%%REPO_URL%%/1995/vanschnitz/try.sh) script.


<div id="1996">
# [1996 - The 13th IOCCC](1996/index.html)
</div>


<div id="1996_august">
## Winning entry: [1996/august](1996/august/index.html)
### Winning entry source code: [august.c](%%REPO_URL%%/1996/august/august.c)
</div>

[Cody](#cody) fixed a segfault in this program that prevented it from working right and
also fixed an infinite loop in the try commands. This infinite loop prevented it
from working with some systems or compilers which we noted a long time ago.

The problem with the infinite loop is that the file `august.oc` had to have
lines starting with `#` removed and it was not being done. After this is done
with say `sed(1)` (like `sed -i'' '/^#/d' august.oc` which has been added to
both the remarks and the `try.sh` script noted below) the code can proceed. This
problem existed in macOS.

Cody also added the [try.sh](%%REPO_URL%%/1996/august/try.sh) script that runs all the
commands that were given by the judges in the try section, with the fix above
applied.


<div id="1996_dalbec">
## Winning entry: [1996/dalbec](1996/dalbec/index.html)
### Winning entry source code: [dalbec.c](%%REPO_URL%%/1996/dalbec/dalbec.c)
</div>

[Cody](#cody) proposed a fix for this to compile with `clang` and Landon implemented it
after some discussion (though Cody changed the function name). The reason Cody
did not do it is because he thought it was the wrong output but as it happens
the try section below was worded a bit confusingly. He looked at [Yusuke](#yusuke)'s
analysis found
[here](https://mame-github-io.translate.goog/ioccc-ja-spoilers/1996/dalbec.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp)
but he missed that Yusuke added a '...' after the result which made him think
the fix was wrong.

Cody also made the recommended change of the author to make it so that each
number is printed on a line by itself rather than having a long string of
numbers on the same line.

Cody also added the [try.sh](%%REPO_URL%%/1996/dalbec/try.sh) script.


<div id="1996_eldby">
## Winning entry: [1996/eldby](1996/eldby/index.html)
### Winning entry source code: [eldby.c](%%REPO_URL%%/1996/eldby/eldby.c)
</div>

[Cody](#cody) provided an [alternate version](%%REPO_URL%%/1996/eldby/eldby.alt.c) which uses
`usleep()` in between writing the output to make it easier to see what it looked
like back in 1996 with modern systems and importantly also for those who are sensitive to text
flashing by rapidly. We recommend that you try the alternate version first due to
these reasons.


<div id="1996_gandalf">
## Winning entry: [1996/gandalf](1996/gandalf/index.html)
### Winning entry source code: [gandalf.c](%%REPO_URL%%/1996/gandalf/gandalf.c)
</div>

[Cody](#cody) fixed this to compile and work with modern systems. As he loved the
references in the code that could not compile he just commented out as little as
possible to get this to compile.

Cody also added the rather useful [try.sh](%%REPO_URL%%/1996/gandalf/try.sh) script to
really demonstrate the different ways of running the program ends up showing
either different output or the same output that we briefly pointed out.

BTW: it is perilous to try the patience of
[Gandalf](https://www.glyphweb.com/arda/g/gandalf.html). Go ahead, try it! :-)


<div id="1996_huffman">
## Winning entry: [1996/huffman](1996/huffman/index.html)
### Winning entry source code: [huffman.c](%%REPO_URL%%/1996/huffman/huffman.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1996/huffman/try.sh) script.


<div id="1996_jonth">
## Winning entry: [1996/jonth](1996/jonth/index.html)
### Winning entry source code: [jonth.c](%%REPO_URL%%/1996/jonth/jonth.c)
</div>

[Cody](#cody) fixed this to not segfault under macOS. The problem was that the function
pointer `w`, which points to `XCreateWindow()`, did not specify the parameters of
the function in the pointer assignment.

NOTE: if there is no X server running this program will still crash.


<div id="1996_rcm">
## Winning entry: [1996/rcm](1996/rcm/index.html)
### Winning entry source code: [rcm.c](%%REPO_URL%%/1996/rcm/rcm.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1996/rcm/try.sh) script.


<div id="1996_schweikh1">
## Winning entry: [1996/schweikh1](1996/schweikh1/index.html)
### Winning entry source code: [schweikh1.c](%%REPO_URL%%/1996/schweikh1/schweikh1.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1996/schweikh1/try.sh) script.

The author stated that `-I/usr/include` is needed by `gcc` in Solaris because
`errno.h` has two identical extern declarations of `errno`. That leads to an
error due to the redefinition of `main` but the `-I` option makes sure the
working `/usr/include/rrno.h` is found first, which shouldn't cause any problems
on other systems (the other file is
`gcc-lib/sparc-sun-solaris2.5/2.7.2/include/errno.h`). Thus Cody also added this to
the `Makefile` for the (likely?) few who still use Solaris.


<div id="1996_schweikh2">
## Winning entry: [1996/schweikh2](1996/schweikh2/index.html)
### Winning entry source code: [schweikh2.c](%%REPO_URL%%/1996/schweikh2/schweikh2.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1996/schweikh2/try.sh) script with
a few commands to try along with a shorter version of something the author
suggested one try (at the end of the script it prompts if you wish to run the
author's idea, with a `sleep` and `echo` in between to help one distinguish the
output better, with the warning that it is an infinite loop).


<div id="1996_schweikh3">
## Winning entry: [1996/schweikh3](1996/schweikh3/index.html)
## Source code: [schweikh3.c](%%REPO_URL%%/1996/schweikh3/schweikh3.c)
</div>

[Cody](#cody) updated the `Makefile` so that if it fails to compile it will try the
method suggested for SunOS rather than having to update the `Makefile` manually or
running a more complicated command: now one can just run `make`.


<div id="1996_westley">
## Winning entry: [1996/westley](1996/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/1996/westley/westley.c)
</div>

[Cody](#cody) fixed a segfault in this entry as well as it displaying environmental
variables.  Although the scripts showed correct output, it somewhat lessened the
usability because they segfaulted and showed (an) environmental variable,
interspersed with the output of the program. With the fix they no longer have
this problem. If `argc < 5` (`argv[4]` is referenced) it will not do anything
and it will not segfault either - this was caused by the body of the `for()` loop
which is now empty (it doesn't appear to be needed at all at least modernly).
Note that you should check the [westley.alt.c](%%REPO_URL%%/1996/westley/westley.alt.c) file
when reading the author's comments. To see how to use the original, see the
index.html file.

Cody also added the [try.sh](%%REPO_URL%%/1996/westley/try.sh) and
[try.alt.sh](%%REPO_URL%%/1996/westley/try.alt.sh) scripts to automate showing the different
clocks, both with the fixed version and the original (alt) version.

Also, to fix any potential problem with displaying in GitHub the scripts
provided by the author, Cody added '.sh' to the `clock[1-3].sh` scripts.


<div id="1998">
# [1998 - The 14th IOCCC](1998/index.html)
</div>


<div id="1998_banks">
## Winning entry: [1998/banks](1998/banks/index.html)
### Winning entry source code: [banks.c](%%REPO_URL%%/1998/banks/banks.c)
</div>

[Cody](#cody) improved the `Makefile` to allow for easier redefining the control
keys and time step that the author set up.

Cody also set up the `Makefile` to have an alt build (using the same code) for those
who do not have a page up or page down key and added the
[keysym.h](%%REPO_URL%%/1998/banks/keysym.h) header file as a reference for other keys one
can use if they wish to modify the controls. One can certainly do this even if
they do have page up and page down but this gives a default for those who don't
have them like with Macs. The alt build hard codes the page up and page down
alternatives because not doing so would overly complicate both builds and since
you can configure them all in both builds it shouldn't matter.


<div id="1998_bas1">
## Winning entry: [1998/bas1](1998/bas1/index.html)
### Winning entry source code: [bas1.c](%%REPO_URL%%/1998/bas1/bas1.c)
</div>

[Cody](#cody), out of an abundance of caution, added a second arg to `main()` as some
versions of `clang` whine about the number of args on top of what type they are
In particular some versions claim that they only allow 0, 2 or 3 args. It
appears that they do allow 1 but for instance 4 is not allowed. However as it's
quite possible they will 'fix' this defect it would be better to have this not
be a problem at such a time. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody also added the [bas1.sh](%%REPO_URL%%/1998/bas1/bas1.sh) script to simplify running the
program.


<div id="1998_bas2">
## Winning entry: [1998/bas2](1998/bas2/index.html)
### Winning entry source code: [bas2.c](%%REPO_URL%%/1998/bas2/bas2.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1998/bas2/try.sh) script which runs some default actions
as well as allowing one to pass in different file names or strings.


<div id="1998_chaos">
## Winning entry: [1998/chaos](1998/chaos/index.html)
### Winning entry source code: [chaos.c](%%REPO_URL%%/1998/chaos/chaos.c)
</div>

[Cody](#cody) added a call to `endwin()` to restore terminal sanity (echo etc.) when
exiting the program (in both versions).

Cody also added the [try.sh](%%REPO_URL%%/1998/chaos/try.sh) script that runs the program on
all the data files, giving instructions on how to rotate and zoom in and out,
prior to each run.


<div id="1998_df">
## Winning entry: [1998/df](1998/df/index.html)
### Winning entry source code: [df.c](%%REPO_URL%%/1998/df/df.c)
</div>

[Cody](#cody) changed a `int *` used for `fopen(3)` to be a `FILE *` to be more correct
and prevent any possible problems in some systems (which has happened).

Cody also made the fixed version to look more like the original version by using
the old style of `main()` args so that it reads `i,love_unix` more naturally,
and by changing the `typedef int lint` to be `typedef int _int`. See the code
for why this has to be done this way.

Cody also added the [try.sh](%%REPO_URL%%/1998/df/try.sh) script which runs the program in a
loop until one hits `q` (or `Q`) or sends intr/ctrl-c. He also proposed there's
a way to cheat very easily. Can you figure out how?


<div id="1998_dlowe">
## Winning entry: [1998/dlowe](1998/dlowe/index.html)
### Winning entry source code: [dlowe.c](%%REPO_URL%%/1998/dlowe/dlowe.c)
</div>

[Cody](#cody) made the program more portable by changing the void return type of `main()`
to be `int` (in both versions).

Cody added the scripts [try.sh](%%REPO_URL%%/1998/dlowe/try.sh),
[try.alt.sh](%%REPO_URL%%/1998/dlowe/try.alt.sh), [pootify.sh](%%REPO_URL%%/1998/dlowe/pootify.sh) and
[pootify.cgi.sh](%%REPO_URL%%/1998/dlowe/pootify.cgi.sh) for a fun example use of the
program, a local pootifier of web pages and a CGI pootifier. See [historical
remarks](1998/dlowe/index.html#historical-remarks) for more details on the
pootify scripts.


<div id="1998_dloweneil">
## Winning entry: [1998/dloweneil](1998/dloweneil/index.html)
### Winning entry source code: [dloweneil.c](%%REPO_URL%%/1998/dloweneil/dloweneil.c)
</div>

[Cody](#cody) added [alternate code](%%REPO_URL%%/1998/dloweneil/dloweneil.alt.c) which has vi(m) movement
(in addition to the other keys except for dropping it's not `d` but `j` or
space) keys as well as allowing one to quit the game.


<div id="1998_dorssel">
## Winning entry: [1998/dorssel](1998/dorssel/index.html)
### Winning entry source code: [dorssel.c](%%REPO_URL%%/1998/dorssel/dorssel.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/1998/dorssel/try.sh) script.


<div id="1998_fanf">
## Winning entry: [1998/fanf](1998/fanf/index.html)
### Winning entry source code: [fanf.c](%%REPO_URL%%/1998/fanf/fanf.c)
</div>

[Cody](#cody) fixed this to compile. The problem was the intermediate steps to get to the
final code that is compiled. The code is now what it essentially becomes when
processed completely. The intermediate steps can now be performed to see how it
expands but it can still compile and be used.

Cody also added a second arg to `main()` out of an abundance of caution as some
versions of `clang` complain about the number of args to `main()`. These versions
claim that only 0, 2 or 3 are allowed but it does allow 1 anyway. It is quite
possible though that this will change so it is fixed in case this happens. As it
is mostly just through the C pre-processor Cody added a new macro to make the
code look like the original with just an extra arg. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


In some versions of `clang` `-Wno-int-conversion` had to be added to the
`CSILENCE` variable of the Makefile.

Cody also added the [try.sh](%%REPO_URL%%/1998/fanf/try.sh) script to show the output of some
of the expressions that we selected.


<div id="1998_schnitzi">
## Winning entry: [1998/schnitzi](1998/schnitzi/index.html)
### Winning entry source code: [schnitzi.c](%%REPO_URL%%/1998/schnitzi/schnitzi.c)
</div>

[Cody](#cody) fixed invalid data types which prevented this entry from working, causing a
segfault. This showed itself in two parts which required two fixes, one for
Linux and further changes for macOS. He also fixed a segfault (after printing
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

``` <!---c-->
    ((V[1]&&((atoi(V[1])>0&&atoi(V[1])<27))||(exit(1),1)));
```

Cody also added the [try.sh](%%REPO_URL%%/1998/schnitzi/try.sh) script to help users try the
commands that we recommended as well as some added by him.


<div id="1998_schweikh1">
## Winning entry: [1998/schweikh1](1998/schweikh1/index.html)
### Winning entry source code: [1998/schweikh1](%%REPO_URL%%/1998/schweikh1/schweikh1.c)
</div>

[Cody](#cody) fixed this for modern systems (it did not work at all) and added an
alternate version that works with macOS. Cody also made it ever so slightly more
portable by removing the hard-coding of `gcc`, instead hard-coding it `cc`. Doing
this not only lets it work with systems without `gcc` (though in macOS it does
exist but is actually `clang`) as `cc` always should.
Getting this entry to work was quite complicated but is also very interesting.

To see how the macOS fixes works, see the [macos.html](1998/schweikh1/macos.html)
file but do note that this includes deobfuscation information for both versions! The fixes to get
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

``` <!---c-->
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
the macros in the form of `gcc -dM` i.e., the lines are in the form `#define
MACRO value` it will work, assuming that compiler can run, of course.

Cody also added the perl script that the author provided that they used to
compute the character count in the code according to the contest rules of 1998
in the file [charcount.pl](%%REPO_URL%%/1998/schweikh1/charcount.pl).


<div id="1998_schweikh2">
## Winning entry: [1998/schweikh2](1998/schweikh2/index.html)
### Winning entry source code: [schweikh2.c](%%REPO_URL%%/1998/schweikh2/schweikh2.c)
</div>

[Cody](#cody) fixed the code to not trigger an internal compiler error in `gcc`:

```
    :10:16: warning: type defaults to 'int' in declaration of 'zero' [-Wimplicit-int]
    : In function 'main':
    :12:1: warning: missing terminating " character
    :12:19: internal compiler error: invalid built-in macro "__FILE__"
```

The string `"01\015"` had to be changed to `ONE(O(1,1,2,6,0,6))`. For an
interesting historical explanation and further details and fun, see the
[historical remarks](1998/schweikh2/index.html#historical-remarks) in the
index.html.

Cody also added an `int` after `register` in `main()` in case `clang` decides to
have a problem with that in the future which is not entirely out of the
question.

Cody also added the [try.sh](%%REPO_URL%%/1998/schweikh2/try.sh) script.


<div id="1998_schweikh3">
## Winning entry: [1998/schweikh3](1998/schweikh3/index.html)
### Winning entry source code: [schweikh3.c](%%REPO_URL%%/1998/schweikh3/schweikh3.c)
</div>

[Cody](#cody) added the [alternate
code](%%REPO_URL%%/1998/schweikh3/schweikh3.alt.c) which allows one
to reconfigure the size constant in the rare case that the author wrote about
occurs.

Cody made `main()` have two args out of an abundance of caution as some versions
of `clang` say that `main()` can only have 0, 2 or 3 args. These versions accept 1
arg but it is entirely possible that they fix this so this should prevent it
from breaking if that happens. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody added the [try.sh](%%REPO_URL%%/1998/schweikh3/try.sh) script to make it easier to try
the commands that we suggested. One command was not added, that of the to use
command.

Cody also made the `Makefile` rule `all` symlink the entry to `samefile` as that
is the name of the program.

The author stated that:

```
    In the remote event that the input has more than `8192` files with
    the same size (on systems where `sizeof (char *) == 4`, or `4096` when
    `sizeof (char *) == 8`), increase the manifest constant 32767 on line
    31.
```

so Cody changed the constant to a macro in the `Makefile` called `SZ` so one can
more easily do this (though it indeed seems highly unlikely). See the index.html
for more details.

There actually is a web page for the tool and this was added to the author
information for the entry. It has not been added to any JSON file.


<div id="1998_tomtorfs">
## Winning entry: [1998/tomtorfs](1998/tomtorfs/index.html)
### Winning entry source code: [tomtorfs.c](%%REPO_URL%%/1998/tomtorfs/tomtorfs.c)
</div>

[Cody](#cody) fixed the assumption that `EOF` is `-1` (the author noted that it assumes
it is `-1` and it's indeed a valid concern as the standard only guarantees that
it's a value `< 0`) and that `1` is a valid code to return failure (it seems
unlikely that it wouldn't be but since the author suggested it it was changed to
`EXIT_FAILURE`). To make it so the lines end at the same columns as the original
the `EXIT_FAILURE` change was done by redefining `exit(3)` to be `exit(a) return
EXIT_FAILURE` and `1` was passed to it (`return` was used because the original
program  had `return 1`).

Cody also added the [try.sh](%%REPO_URL%%/1998/tomtorfs/try.sh) script to try out a few
commands that we recommended.


<div id="2000">
# [2000 - The 15th IOCCC](2000/index.html)
</div>


<div id="2000_anderson">
## Winning entry: [2000/anderson](2000/anderson/index.html)
### Winning entry source code: [anderson.c](%%REPO_URL%%/2000/anderson//anderson.c)
</div>

[Cody](#cody) changed this entry to use `fgets(3)` instead of `gets(3)`.
See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.
This involved changing the `K` arg to `gets(3)` to `&K` in `fgets(3)`.

Cody also added the [try.sh](%%REPO_URL%%/2000/anderson/try.sh) script.


<div id="2000_bmeyer">
## Winning entry: [2000/bmeyer](2000/bmeyer/index.html)
### Winning entry source code: [bmeyer.c](%%REPO_URL%%/2000/bmeyer//bmeyer.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2000/bmeyer/try.sh) script with some improvements to the
commands we recommended like not assuming the number of columns one has in their
terminal.


<div id="2000_briddlebane">
## Winning entry: [2000/briddlebane](2000/briddlebane/index.html)
### Winning entry source code: [briddlebane.c](%%REPO_URL%%/2000/briddlebane//briddlebane.c)
</div>

[Cody](#cody) fixed this to compile in systems that require one to explicitly link in
`libm`.

Cody also added the [try.sh](%%REPO_URL%%/2000/briddlebane/try.sh) script for those who are
feeling a bit too confident, cocky or even happy :-)


<div id="2000_dhyang">
## Winning entry: [2000/dhyang](2000/dhyang/index.html)
### Winning entry source code: [dhyang.c](%%REPO_URL%%/2000/dhyang//dhyang.c)
</div>

[Cody](#cody) made this more portable by changing the `void main` to `int main`.

He also added the [try.sh](%%REPO_URL%%/2000/dhyang/try.sh) script.


<div id="2000_dlowe">
## Winning entry: [2000/dlowe](2000/dlowe/index.html)
### Winning entry source code: [dlowe.c](%%REPO_URL%%/2000/dlowe//dlowe.c)
</div>

[Cody](#cody) fixed this to compile with more recent perl versions; the symbol that's now
`PL_na` was once `na`.

Cody also added the [try.sh](%%REPO_URL%%/2000/dlowe/try.sh) script.


<div id="2000_jarijyrki">
## Winning entry: [2000/jarijyrki](2000/jarijyrki/index.html)
### Winning entry source code: [jarijyrki.c](%%REPO_URL%%/2000/jarijyrki//jarijyrki.c)
</div>

[Cody](#cody) made it easier to compile this in some cases by adding `X11/` to the
includes of `Xlib.h` and `keysym.h`.


<div id="2000_natori">
## Winning entry: [2000/natori](2000/natori/index.html)
### Winning entry source code: [natori.c](%%REPO_URL%%/2000/natori//natori.c)
</div>

[Cody](#cody) fixed this for modern compilers. Depending on the compiler it would either
segfault when run or not compile at all (`gcc` and `clang` respectively). The
compiler fix is due to `clang` being more strict about arg types to `main()`.

Cody also provided [alternate code](%%REPO_URL%%/2000/natori/natori.alt.c) that
supports the southern hemisphere, based on the author's remarks.

Cody also provided the [try.sh](%%REPO_URL%%/2000/natori/try.sh) and
[try.alt.sh](%%REPO_URL%%/2000/natori/try.alt.sh) scripts that show the Moon phase in
artistic ways. It is recommended one try both a number of times in a row on
different days (that is run `./try.sh` several times in a row a few days apart,
until you see all the Moon phases, and run `./try.alt.sh` a few times in a row a
few days apart, until you see all the Moon phases).

Later on Cody restored the `#include`s in the source code which had been changed
by us to make it a one-liner again but this was an error as it was not a
one-liner but rather a small program. At the same point Cody made the code
itself a one-line like the code is in the original entry. Now it looks much more
like the original entry but with the two fixes.

Finally Cody fixed the `Makefile` that had the `-Wno-foo` options in the `CDEFINE`
variable which although works it is incongruent with the other Makefiles and is
more confusing (though not really).


<div id="2000_primenum">
## Winning entry: [2000/primenum](2000/primenum/index.html)
### Winning entry source code: [primenum.c](%%REPO_URL%%/2000/primenum//primenum.c)
</div>

[Cody](#cody) made this more portable by changing the `void main` to `int main`.

Cody also added the [try.sh](%%REPO_URL%%/2000/primenum/try.sh) script.


<div id="2000_rince">
## Winning entry: [2000/rince](2000/rince/index.html)
### Winning entry source code: [rince.c](%%REPO_URL%%/2000/rince//rince.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2000/rince/try.sh) script.


<div id="2000_robison">
## Winning entry: [2000/robison](2000/robison/index.html)
### Winning entry source code: [robison.c](%%REPO_URL%%/2000/robison//robison.c)
</div>

[Cody](#cody) fixed an infinite loop that occurred if invalid input was entered, flooding
the screen with:

```
    Black position and direction: illegal
```

This was fixed by having the `scanf(3)` read in a string and then use `atoi(3)`
on it to assign to the `int`s, much like with [1987/lievaart](#1987_lievaart).
The strings are `char[5]` and the `%` specifier is `%4s` which is enough for the
game.


<div id="2000_schneiderwent">
## Winning entry: [2000/schneiderwent](2000/schneiderwent/index.html)
### Winning entry source code: [schneiderwent.c](%%REPO_URL%%/2000/schneiderwent//schneiderwent.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2000/schneiderwent/try.sh) script.


<div id="2000_thadgavin">
## Winning entry: [2000/thadgavin](2000/thadgavin/index.html)
### Winning entry source code: [thadgavin.c](%%REPO_URL%%/2000/thadgavin//thadgavin.c)
</div>

[Cody](#cody) fixed the code and added an appropriate make rule so that the
[SDL](https://www.libsdl.org) version works independent from the curses version
(using the same code).  See below for an interesting problem that occurred that
had to be resolved for SDL1.

Cody also added [alternate code](%%REPO_URL%%/2000/thadgavin/thadgavin.alt.c) to allow
one to slow down the code to get a better idea of what the program looked like
back in 2000, with modern systems. This code also, at least for the curses mode, allows
one to quit at any time by pressing 'q'. Note that this alternate version only
will impact the curses and the SDL versions as Cody does not have a DOS system
to test the other version in.

Due to a terrible design choice of the SDL1 developers something had to be
changed. As was noted in the log at the time:

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


<div id="2000_tomx">
## Winning entry: [2000/tomx](2000/tomx/index.html)
### Winning entry source code: [tomx.c](%%REPO_URL%%/2000/tomx//tomx.c)
</div>

[Cody](#cody) added the [alternate code](%%REPO_URL%%/2000/tomx/tomx.alt.c) based on the
author's remarks with a fix for modern systems and he also added the two
scripts, [try.sh](%%REPO_URL%%/2000/tomx/try.sh) and [try.alt.sh](%%REPO_URL%%/2000/tomx/try.alt.sh) for
the main code and the alternate code respectively.

And although the scripts do `chmod +x` on the source code (see the index.html for
details) the source code is now executable by default.


<div id="2001">
# [2001 - The 16th IOCCC](2001/index.html)
</div>


<div id="2001_anonymous">
## Winning entry: [2001/anonymous](2001/anonymous/index.html)
### Winning entry source code: [anonymous.c](%%REPO_URL%%/2001/anonymous//anonymous.c)
</div>

[Cody](#cody) fixed both the supplementary program and the program itself (both of which
segfaulted and once that was fixed only the binary was modified; it was not run
but according to the author's remarks it should be executed). He managed to do
this with Linux but it will not work with any system that does not allow one to
compile 32-bit ELF binaries. See [2001/anonymous in bugs.html](bugs.html#2001_anonymous) for
why this is; _this is **not** a bug, it's a feature_ inherent in what it does!

The following had to be done to fix this:

- `#include <sys/mman.h>` for `mmap()` and `munmap()`.
- have `main()` call another function which is no longer a recursive function;
this prevented `main()` from entering an infinite recursive loop.

Without these it would crash and prevent modification of the 32-bit
[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) (not elf :-) )
binary. But again see [2001/anonymous in bugs.html](bugs.html#2001_anonymous)
for this.

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

To get this to compile with `clang`, `main()` had to change from:

``` <!---c-->
    main (char *ck, char **k)
```

to:

``` <!---c-->
    main (int cka, char **k) { char *ck = (char *)cka; /* ... */ }
```

The following was also done to be more portable, in case the constants
`PROT_READ` and/or `PROT_WRITE` are not standardised or some platform does not
follow it: change `3` in the call to `mmap()` to be `PROT_READ|PROT_WRITE`: just in case
`PROT_READ|PROT_WRITE` does not equal `3` (though it seems to be equal in both
macOS and Linux).

NOTE: there might be educational value to see the progress of this fix; if you
wish to see, try the following commands from the `2001/anonymous` directory:

``` <!---sh-->
    git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..93aa8d79f208dcccc3c5a2370a727b5cf64e9c53 anonymous.c
    git diff 93aa8d79f208dcccc3c5a2370a727b5cf64e9c53..c48629017117379a52b1a512ef8f2593ca9569c8 anonymous.c
    git diff c48629017117379a52b1a512ef8f2593ca9569c8..efdee208a2bc650256637b9357ddfd0de82d2f41 anonymous.c
    git diff efdee208a2bc650256637b9357ddfd0de82d2f41..e9a3f77ea3b209e63ac3f9c06bb84ad86e5ea706 anonymous.c
    git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..2159caec4677e0f25ad704a74e04c8196fd6c343 anonymous.c
    git diff 2159caec4677e0f25ad704a74e04c8196fd6c343..4bc03de321612869aebf855850c6500df95cb6ef anonymous.c
```

Finally to see from start to finish:

``` <!---sh-->
    git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..4bc03de321612869aebf855850c6500df95cb6ef anonymous.c
```

or to not use `git`:

``` <!---sh-->
    make diff_orig_prog
```

Cody also added a [supplementary program](%%REPO_URL%%/2001/anonymous/anonymous.bed.c) like
[anonymous.ten.c](%%REPO_URL%%/2001/anonymous/anonymous.ten.c) (which 'sings' the
lyrics to [Ten Green Bottles](https://en.wikipedia.org/wiki/Ten_Green_Bottles))
but which sings [Ten in the Bed](https://allnurseryrhymes.com/ten-in-the-bed/)
instead (the way it's implemented is different and this allows showing more of
what the entry supports).

As well he added the [try.sh](%%REPO_URL%%/2001/anonymous/try.sh) script so that one can
attempt to use the program as it was designed but if compiling as 32-bit fails
it will at least run the supplementary program as a 64-bit program directly.


<div id="2001_bellard">
## Winning entry: [2001/bellard](2001/bellard/index.html)
### Winning entry source code: [bellard.c](%%REPO_URL%%/2001/bellard//bellard.c)
</div>

[Cody](#cody) fixed this to compile with `clang` but according to the author this will not
work without i386 Linux. It generates i386 32-bit code (not bytecode) but
unfortunately it will not work without i386 Linux. See [2001/bellard in
bugs.html](bugs.html#2001_bellard).

Cody fixed an earlier segfault so that it can at least now open the file should
you have an i386 Linux machine (it can open it in other platforms too, of
course, but it won't work). This involved pointer updates and also changing an
`int` to a `FILE *`. Where possible he left the macros as the same but in the
case of `main()` this was not possible.

[Yusuke](#yusuke) added another change (see below) to make it even more portable across
compilers besides what Cody did.

Cody entirely fixed the [supplementary
bellard.otccex.c](%%REPO_URL%%/2001/bellard/bellard.otccex.c) so it does not segfault and
works as well (it did not work at all though it is possible it would work in
older systems). The main problem was that some `int`s were
being used as pointers.  This includes, for example, an `int` used as a `char *`,
an `int` used as a function pointer and an `int` to access `argv` as well as there
being invalid access to `argv`. He updated the `Makefile` so that this program
will compile by default.

Also the Fibonacci sequence (`fib()`) will overflow at `n > 48` so this is
checked prior to running the function just like the author did for the factorial
(overflowing at `>12`). Either way unfortunately this entry seems to not work in
64-bit Linux or macOS. See below portability notes as well as another fix in
this entry by Yusuke.


## Portability notes:

With a tip from Yusuke we rediscovered the author's [web page for this
program](https://bellard.org/otcc/) where it is stated that this will only work
in i386 Linux.  The author also stated in the remarks in this document that they
used `gcc 2.95.2` but we do not know if that's relevant or not.

Yusuke offered a modification which is not needed with `gcc` but with some
versions of `clang` it is. With `gcc` we can get away with `-rdynamic -fno-pie
-Wl,-z,execstack` which solves the problem of execution in memory but any
compiler that does not support this would not work. Thus we use the modification
by Yusuke.


<div id="2001_cheong">
## Winning entry: [2001/cheong](2001/cheong/index.html)
### Winning entry source code: [cheong.c](%%REPO_URL%%/2001/cheong//cheong.c)
</div>

[Cody](#cody) fixed this to compile with `clang` by adding another function that is allowed to
have a third arg as an `int`, not a `char **`. He chose `pain()` because it's a four
letter word that would match the format and because it's pain that `clang` forces
this. :-) This fix makes a point of the author's notes on portability no longer
valid, BTW.

Cody also added the [try.sh](%%REPO_URL%%/2001/cheong/try.sh) script.


<div id="2001_coupard">
## Winning entry: [2001/coupard](2001/coupard/index.html)
### Winning entry source code: [coupard.c](%%REPO_URL%%/2001/coupard//coupard.c)
</div>

[Cody](#cody) added a value to `return` in `main()` to make it more portable.

Cody fixed this to compile with `clang` in Linux. The problem was C99 does not
support implicit int:

``` <!---c-->
    coupard.c:31:10: error: parameter 'h' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    void e(n,h){
             ^
    coupard.c:31:8: error: parameter 'n' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    void e(n,h){
           ^
```

and for some reason it was being reported as an error.

Cody also added the [try.sh](%%REPO_URL%%/2001/coupard/try.sh) script.

[Yusuke](#yusuke) provided a proper command line for those without `/dev/audio`
or `/dev/sound/dsp` (which is most everyone nowadays, it seems, and especially
those with macOS) (to do with sound; see his
[2013/endoh3/index.html](2013/endoh3/index.html) entry where he also refers to
sound devices in macOS).



<div id="2001_ctk">
## Winning entry: [2001/ctk](2001/ctk/index.html)
### Winning entry source code: [ctk.c](%%REPO_URL%%/2001/ctk//ctk.c)
</div>

The ANSI escape codes were no longer valid but [Yusuke](#yusuke) provided a patch to fix
the ANSI escape codes. This works with both Linux and macOS.

[Cody](#cody) fixed this so that it should always restore terminal sanity (echo enabled
etc.) after exiting even if you don't press 'q', if you crash or if you kill the
program prematurely. This was done by adding an explicit call to `e()` at the
end of `main()`.

Cody also added the [alternate code](%%REPO_URL%%/2001/ctk/ctk.alt.c) that adds
vi(m) movement keys.


<div id="2001_dgbeards">
## Winning entry: [2001/dgbeards](2001/dgbeards/index.html)
### Winning entry source code: [dgbeards.c](%%REPO_URL%%/2001/dgbeards//dgbeards.c)
</div>

The author provided two changes: one to speed it up and one to make it not crash
on losing. [Cody](#cody) provided an [alternate
version](%%REPO_URL%%/2001/dgbeards/dgbeards.alt.c) which does the former but
not the latter as he he felt that the idea of crashing on losing (see the
index.html for details on why that might be) too good to get rid. The author
explains how to make this change, however.

Cody also points out that there is a way to get the computer to automatically lose
very quickly. Do you know what it is?


<div id="2001_herrmann1">
## Winning entry: [2001/herrmann1](2001/herrmann1/index.html)
### Winning entry source code: [herrmann1.c](%%REPO_URL%%/2001/herrmann1//herrmann1.c)
</div>

[Cody](#cody) fixed this so that the when compiling the code the program is not executed
itself by itself which just showed the usage string and exited. The [script
herrmann1.sh](%%REPO_URL%%/2001/herrmann1/herrmann1.sh) is how one should compile the program but
it's also how you invoke the program.

Cody provided the file [plus1.turing](%%REPO_URL%%/2001/herrmann1/plus1.turing) based on the
author's remarks.

He also fixed the [script herrmann1.sh](%%REPO_URL%%/2001/herrmann1/herrmann1.sh) for
shellcheck. In particular there were quite a few:


```
    SC2086 (info): Double quote to prevent globbing and word splitting.
    SC2248 (style): Prefer double quoting even when variables don't contain special characters.
```

errors/warnings.

Cody also added the [try.sh](%%REPO_URL%%/2001/herrmann1/try.sh) script.


<div id="2001_herrmann2">
## Winning entry: [2001/herrmann2](2001/herrmann2/index.html)
### Winning entry source code: [herrmann2.c](%%REPO_URL%%/2001/herrmann2//herrmann2.c)
</div>

[Cody](#cody) fixed this to work with both 64-bit and 32-bit compilers by changing most
of the `int`s (all but that in `main(int ...)`) to `long`s. He also fixed it to
compile with `clang` by changing the args of `main` to be `int` and `char **`,
respectively, and changing specific references to the `argv` arg, casting to
`long` (was `int` but the 64-bit fix requires `long`) which was its old type.

Cody also added the [try.sh](%%REPO_URL%%/2001/herrmann2/try.sh) script which might be more
useful than any other place as the command to try is quite long with C code.

For some reason the original code was missing (presumingly because it had been
added to `.gitignore` by accident) but Cody restored it from the archive.


<div id="2001_kev">
## Winning entry: [2001/kev](2001/kev/index.html)
### Winning entry source code: [kev.c](%%REPO_URL%%/2001/kev//kev.c)
</div>

[Cody](#cody) improved the `Makefile` to allow one to more easily set up the port,
speed and `socket(2)` call that the author had set up.

Cody also slowed down the ball just a tad (it was already a `-D` macro that was used
in the code) as it went too fast for the speed at which the paddles move even
when holding down the movement keys (but see below).

Cody also provided an [alternate version](%%REPO_URL%%/2001/kev/kev.alt.c) which lets you use
the arrow keys on your keyboard instead of the more awkward '`,`' and '`.`'.

Cody updated both versions to have `#ifndef..#endif` pairs for the macros so one
can more easily configure different settings without having to specify all of
them (though this change became unnecessary with an improvement on how it was
done). The speed, `SPEED`, will be set to `50` if it's not defined at the compiler
line as `50` is what it used to be set to. This way it's more to the original but
without having to sacrifice playability by running `make`.


<div id="2001_ollinger">
## Winning entry: [2001/ollinger](2001/ollinger/index.html)
### Winning entry source code: [ollinger.c](%%REPO_URL%%/2001/ollinger//ollinger.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2001/ollinger/try.sh) script.



<div id="2001_schweikh">
## Winning entry: [2001/schweikh](2001/schweikh/index.html)
### Winning entry source code: [schweikh.c](%%REPO_URL%%/2001/schweikh//schweikh.c)
</div>

[Cody](#cody) fixed this to not crash if not enough args as this was not documented by
the author. The other problems are documented so were not fixed. See
index.html for details.

Cody also added the [try.sh](%%REPO_URL%%/2001/schweikh/try.sh) script.


<div id="2001_westley">
## Winning entry: [2001/westley](2001/westley/index.html)
### Winning entry source code: [westley.c](%%REPO_URL%%/2001/westley//westley.c)
</div>

[Cody](#cody) added the script [try.sh](%%REPO_URL%%/2001/westley/try.sh) to
automate a heap of commands that we, the IOCCC judges, suggested, as well as
some additional ones that he thought would be fun.  He also provided the sort
and punch card versions, described in the index.html, based on the author's
remarks, through `Makefile` rules that generate the files by default with `make
all`.


<div id="2004">
# [2004 - The 17th IOCCC](2004/index.html)
</div>


<div id="2004_anonymous">
## Winning entry: [2004/anonymous](2004/anonymous/index.html)
### Winning entry source code: [anonymous.c](%%REPO_URL%%/2004/anonymous//anonymous.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2004/anonymous/try.sh) script.


<div id="2004_arachnid">
## Winning entry: [2004/arachnid](2004/arachnid/index.html)
### Winning entry source code: [arachnid.c](%%REPO_URL%%/2004/arachnid//arachnid.c)
</div>

[Cody](#cody) added an [alternate
version](%%REPO_URL%%/2004/arachnid/arachnid.alt.c) which
allows those like himself used to `h`, `j`, `k` and `l` movement keys to not get
lost. Non rogue players, vi users and Dvorak typists are invited to get lost (or
use the original version)! :-)

Cody also renamed the `arachnid.info` file to
[arachnid.txt](2004/arachnid/arachnid.txt) as it's not really an informative
file but a maze file. The extension `.maz` was not chosen to help with (some?)
browsers knowing what to do with it.


<div id="2004_burley">
## Winning entry: [2004/burley](2004/burley/index.html)
### Winning entry source code: [burley.c](%%REPO_URL%%/2004/burley//burley.c)
</div>

[Cody](#cody) fixed this to compile with `clang` and to work with both `gcc` and
`clang` (even after fixing it to compile with `clang` it did not work properly).

For `clang` the problem was that `main()` had one arg, a `char *` and this is not
allowed in any version of `clang`. In some versions it is allowed if the arg is an
`int` but never if it's anything else. To get it to work took numerous changes.

First the inclusion of `setjmp.h` was necessary. Without this `longjmp(3)`
implicitly returned `int` which was used for the purpose of binary expression but
this no longer appeared to work (though it might be that if the extra function
was added earlier on it would but this is unknown and the way it was changed is
safer for the future).

But by including `setjmp.h` it naturally made the binary expressions invalid (as
it returns `void` which is not allowed in binary expressions) so the comma
operator with `0` (`,0`) had to be used (`,1` was tried first but this did not
work right so you can see that it had to be false in those places, though it is
unknown by Cody if this is because it used to be allowed to have binary
expression with `void` or if it is for some other reason).

`longjmp(3)` was being called with one arg which was an element
of an `int[4][1000]` which had to be changed to a `jmp_buf p[4]` (this due to
the prototype being included).

`main()` also called itself but this was a problem so it now calls another
function `poke()` which calls itself instead (this is sometimes necessary
nowadays and other entries had to have this same kind of change,
[2001/anonymous](2001/anonymous/index.html) being a good example).

Finally the optimiser cannot be enabled so the compiler flags were changed for
this, forcing `-O0`.


<div id="2004_gavare">
## Winning entry: [2004/gavare](2004/gavare/index.html)
### Winning entry source code: [gavare.c](%%REPO_URL%%/2004/gavare//gavare.c)
</div>

[Cody](#cody) added three different [alternate
versions](2004/gavare/index.html#alternate-code):

- [gavare.alt.c](%%REPO_URL%%/2004/gavare/gavare.alt.c) allows you to change the image size
and anti-alias setting at compile time. This is based on the author's remarks.
- [gavare.alt2.c](%%REPO_URL%%/2004/gavare/gavare.alt2.c) is like
[gavare.alt.c](%%REPO_URL%%/2004/gavare/gavare.alt.c) but it should work for Windows as well
(it sets binary mode on `stdout`). This is also based on the author's remarks.
- [gavare.r3.c](%%REPO_URL%%/2004/gavare/gavare.r3.c) is the author's unobfuscated version
that was used during development, found on their [website about the
entry](https://gavare.se/ioccc/ioccc_gavare.c.html).


<div id="2004_gavin">
## Winning entry: [2004/gavin](2004/gavin/index.html)
### Winning entry source code: [gavin.c](%%REPO_URL%%/2004/gavin//gavin.c)
</div>

[Cody](#cody) provided the [alternate code](%%REPO_URL%%/2004/gavin/gavin.alt.c) for
those who want to use QEMU. The most important part of this is the macro `K` has
to be defined as `1`, not `0`.

[Yusuke](#yusuke) provided the `kernel` and `fs.tar` files which can be used if
you cannot normally use this entry. Instead of generating the files just use the
files provided, found under the [img/](%%REPO_URL%%/2004/gavin/img/) directory. Note that
the `img/fs.tar` extracts into `fs/` so you will have to fix the tarball; this
is done this way to prevent extraction from the entry directory overwriting the
files and causing `make clobber` to wipe some of them out.


<div id="2004_hibachi">
## Winning entry: [2004/hibachi](2004/hibachi/index.html)
### Winning entry source code: [hibachi.c](%%REPO_URL%%/2004/hibachi//hibachi.c)
</div>

[Cody](#cody) fixed a bunch of links in the index.html provided with the entry
(the web server's index.html) that no longer exist or have changed in some other way (`https`
instead of `http` for instance). In most cases a new link or change to https was
all that was necessary but at least one or two URLs required the Internet
Wayback Machine.


<div id="2004_hoyle">
## Winning entry: [2004/hoyle](2004/hoyle/index.html)
### Winning entry source code: [hoyle.c](%%REPO_URL%%/2004/hoyle//hoyle.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2004/hoyle/try.sh) script.


<div id="2004_jdalbec">
## Winning entry: [2004/jdalbec](2004/jdalbec/index.html)
### Winning entry source code: [jdalbec.c](%%REPO_URL%%/2004/jdalbec//jdalbec.c)
</div>

[Cody](#cody) fixed this to compile with `gcc` (it worked with `clang`). The problem was the
cpp being unable to parse the generated code (see the index.html for details) and
this ended up with a number of errors like:


``` <!---c-->
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

and various other problems. However there does seem to be a problem at least
with some `gcc` versions in macOS but this appears to be due to errors in
`/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/usr/include/sys/cdefs.h`.

Cody also added [alternate code](%%REPO_URL%%/2004/jdalbec/jdalbec.alt.c) which allows
one to control how many numbers after the `:` to print before printing a
newline, so that one can see the output a bit better (though for lines that have
a lot of numbers this will be harder to see).

Finally Cody added [try.sh](%%REPO_URL%%/2004/jdalbec/try.sh) and
[try.alt.sh](%%REPO_URL%%/2004/jdalbec/try.alt.sh) to demonstrate both versions.


<div id="2004_kopczynski">
## Winning entry: [2004/kopczynski](2004/kopczynski/index.html)
### Winning entry source code: [kopczynski.c](%%REPO_URL%%/2004/kopczynski//kopczynski.c)
</div>

[Cody](#cody) force disabled the optimiser in the `Makefile` with `-O0` as he
discovered it will not work otherwise.

Cody, out of an abundance of caution for `clang`, added a second arg to `main()`
as some versions complain about the number of args and although they accept 1 it
is entirely possible it will eventually be that they don't. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.

Cody also added the [try.sh](%%REPO_URL%%/2004/kopczynski/try.sh) script and various data
files: [kopczynski-a](%%REPO_URL%%/2004/kopczynski/kopczynski-a) to demonstrate what happens when art more
like a letter is fed to the program and the `kopczynski*-rev` files which are
the data files reversed with `rev(1)`. One had to be modified additionally to
get it to work, that being `kopczynski-10-rev`.


<div id="2004_newbern">
## Winning entry: [2004/newbern](2004/newbern/index.html)
### Winning entry source code: [newbern.c](%%REPO_URL%%/2004/newbern//newbern.c)
</div>

[Cody](#cody) and Landon individually fixed this to work with `clang`.

Cody also added the [try.sh](%%REPO_URL%%/2004/newbern/try.sh) script (with a hidden feature
that the author referred to and was documented by [Yusuke](#yusuke) though Cody
chose the word `IOCCC` instead of `AAA`).


<div id="2004_omoikane">
## Winning entry: [2004/omoikane](2004/omoikane/index.html)
### Winning entry source code: [omoikane.c](%%REPO_URL%%/2004/omoikane//omoikane.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2004/omoikane/try.sh) script.


<div id="2004_schnitzi">
## Winning entry: [2004/schnitzi](2004/schnitzi/index.html)
### Winning entry source code: [schnitzi.c](%%REPO_URL%%/2004/schnitzi//schnitzi.c)
</div>

[Cody](#cody) made this use `fgets(3)`.  See [FAQ 4.1  - Why were some calls to
the libc function gets&#x28;3&#x29; changed to use
fgets&#x28;3&#x29;?](faq.html#faq4_1) for why this was done.


He also changed the time factor in the data files as the animations went too
fast in modern systems, especially the scrolling text of
[schnitzi.inp1](%%REPO_URL%%/2004/schnitzi/schnitzi.inp1).

Cody also added the [try.sh](%%REPO_URL%%/2004/schnitzi/try.sh) script.


<div id="2004_sds">
## Winning entry: [2004/sds](2004/sds/index.html)
### Winning entry source code: [sds.c](%%REPO_URL%%/2004/sds//sds.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2004/sds/try.sh) script.

Also, after the `README.md` file had copyright changes, it broke the script so
Cody made a copy of the older `README.md` file into `README_sds.txt` and added that
to the repo for the script instead.


<div id="2004_vik2">
## Winning entry: [2004/vik2](2004/vik2/index.html)
### Winning entry source code: [vik2.c](%%REPO_URL%%/2004/vik2//vik2.c)
</div>

[Cody](#cody) fixed this to compile in Linux. Although it compiled cleanly in macOS (and
BSD?) the code failed to compile at all in Linux due to:

``` <!---c-->
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
[Makefile](%%REPO_URL%%/2004/vik2/Makefile) but now it at least works for both Linux and
macOS.

As for the fix itself it required changing the C pre-processor macros that
resulted in macros themselves like `#ifdef`, `#else` etc. to be `#ifdef`,
`#else` etc. and also the inclusion of the file [vik2_1.c](%%REPO_URL%%/2004/vik2/vik2_1.c)
(which actually includes itself, once directly and now by `__FILE__`)
which used to be generated by the `Makefile` via `cc -E`.

Cody also made it so that the `FNAME` is (for the entry file itself and
`vik2_1.c` - there are other places it should not be done) `__FILE__`
just to make it a bit easier to compile.


<div id="2005">
# [2005 - The 18th IOCCC](2005/index.html)
</div>


<div id="2005_aidan">
## Winning entry: [2005/aidan](2005/aidan/index.html)
### Winning entry source code: [aidan.c](%%REPO_URL%%/2005/aidan//aidan.c)
</div>

[Cody](#cody) fixed the test script, described by the author in their remarks, to refer
to the proper compiled program (it's hardcoded). This had never been done and so
the script did not even work (at least modernly?).

He also added the [alternate code](%%REPO_URL%%/2005/aidan/aidan.alt.c) based on the
author's remarks which is a different approach than the one used and which
(according to the author) '`is slower (particularly in worst-case or nearly so
scenarios), inelegant, and not a good starting place for sudoku generation.`'

Cody added the [try.sh](%%REPO_URL%%/2005/aidan/try.sh) and
[try.alt.sh](%%REPO_URL%%/2005/aidan/try.alt.sh) scripts that correspond to the entry and
alternate code respectively.

Cody added the `make test` and `make test-n0` rules for easier use of the test
suite.


<div id="2005_anon">
## Winning entry: [2005/anon](2005/anon/index.html)
### Winning entry source code: [anon.c](%%REPO_URL%%/2005/anon//anon.c)
</div>

[Cody](#cody) fixed a problem where in some systems (like macOS) the `stty sane` would
not work and end up causing a bus error. Instead of `stty sane` it uses `stty
echo` which is what it was trying to accomplish.

The author noted that one can define `NO_STTY` to not use `stty(1)` at all
(either to prevent having to hit enter or to turn echo off/on) and this is
explained in the index.html.

Cody added the [alternate code](%%REPO_URL%%/2005/anon/anon.alt.c) with vi(m) like
movements.


<div id="2005_boutines">
## Winning entry: [2005/boutines](2005/boutines/index.html)
### Winning entry source code: [boutines.c](%%REPO_URL%%/2005/boutines//boutines.c)
</div>

[Cody](#cody) added the [input.txt](2005/boutines/input.txt) data file based on suggested
input from the author, adapting it to a command to try out.

Cody also added the [try.sh](%%REPO_URL%%/2005/boutines/try.sh) script.


<div id="2005_giljade">
## Winning entry: [2005/giljade](2005/giljade/index.html)
### Winning entry source code: [giljade.c](%%REPO_URL%%/2005/giljade//giljade.c)
</div>

After Landon fixed the entry to compile with `clang` [Cody](#cody) noticed this
does not work at all in modern systems (see below). He fixed this to work and
then he later fixed the self-test feature.

The problem that was showing up is that with either optimising or if anything
but 32-bit (as in `-m32`) was used it would not work (at least in 64-bit
systems?). The optimising cannot be used still but it now works with both 32-bit
and 64-bit. The solution has to do with the size difference between `int` and
`long` so that the `long*E` is now `int*E`. This solves a specific problem for
Linux (32-bit, 64-bit) and macOS (arm64).

To get the self-test feature to work it was required to remove from the code:

``` <!---c-->
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

``` <!---c-->
    ;; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s/|sed*/
    /*-e/'s,intZ,int/ Z,g'>c.c;make/c;/ rm/-f/c*/
    ;;
```

changed from:

``` <!---c-->
    ;; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s>*/
    /*c.c;cc/c.c /-c*/;;
```

or as a diff:


``` <!---diff-->
    -(t(m),(0));; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s>*/
    -/*c.c;cc/c.c /-c*/;;char*A=0,*_,*R,*Q, D[9999],*r,l
    -[9999],T=42, M,V=32;long*E,k[9999],B[1 <<+21],*N=B+
    +(t(m),(0));; /*echo/Line/%d;sed/-n/-e/ %d,%dp/%s/|sed*/
    +/*-e/'s,intZ,int/ Z,g'>c.c;make/c;/ rm/-f/c*/
    +;;char*A=0,*_,*R,*Q, D[9999],*r,l[9999],T=42, M,V=32;int *E,k[9999],B[1 <<+21],*N=B+
```

Cody also added the [try.sh](%%REPO_URL%%/2005/giljade/try.sh) script which also lets one see
the beauty of the entry without having to use vi(m), should they be afraid of
getting stuck in it (and for ease of use). :-)

Finally, to improve upon the test-suite provided by the program, Cody added the
`make test` rule which only shows lines matching `'^Line'` but writing to a
temporary file the compilation including the 'Line' lines. After that is done it
uses `grep -c` on the file to show that there are indeed as many versions the
program generates as the author states, 180.  If it does not find 180 it is an
error; otherwise it is success. See [test.sh](%%REPO_URL%%/2005/giljade/test.sh).


<div id="2005_jetro">
## Winning entry: [2005/jetro](2005/jetro/index.html)
### Winning entry source code: [jetro.c](%%REPO_URL%%/2005/jetro//jetro.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) for systems like Linux that seem to
not do it implicitly (like macOS does).



<div id="2005_klausler">
## Winning entry: [2005/klausler](2005/klausler/index.html)
### Winning entry source code: [klausler.c](%%REPO_URL%%/2005/klausler//klausler.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2005/klausler/try.sh) script.


<div id="2005_mikeash">
## Winning entry: [2005/mikeash](2005/mikeash/index.html)
### Winning entry source code: [mikeash.c](%%REPO_URL%%/2005/mikeash//mikeash.c)
</div>

[Cody](#cody) fixed this to work in some versions of linux. The problem was an
unknown escape sequence, `\N`, which caused a funny compiler error:

``` <!---c-->
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

It might be worth noting that the author stated that the reason for the `\N` is
due to LISP having different escape sequences. The code was modified so that
feeding the program itself will print itself, showing no difference, which is
what is supposed to happen. It is not known, however, if having to change the
`\N` to `\n` ended up breaking any LISP. The other examples given by the author
also show correct output though.

Cody also added the [try.sh](%%REPO_URL%%/2005/mikeash/try.sh) script.


<div id="2005_mynx">
## Winning entry: [2005/mynx](2005/mynx/index.html)
### Winning entry source code: [mynx.c](%%REPO_URL%%/2005/mynx//mynx.c)
</div>

[Cody](#cody) fixed this so that the [configure](%%REPO_URL%%/2005/mynx/source/configure) script (which is not
needed but part of the entry) would work with compilers that have by default
`-Werror` like `clang` in macOS.

Cody also added the [alternate code](%%REPO_URL%%/2005/mynx/mynx.alt.c) which
does scan for `https`. Futile, maybe, based on how `https` is set up, in which
case just enjoy it for what it was, without it working with websites that do not
support `http`. But there might be some command line that will let it work that
way or perhaps someone wants to add the necessary code.


<div id="2005_persano">
## Winning entry: [2005/persano](2005/persano/index.html)
### Winning entry source code: [persano.c](%%REPO_URL%%/2005/persano//persano.c)
</div>

[Cody](#cody) added the (untested) [alternate
code](%%REPO_URL%%/2005/persano/persano.alt.c) which should work for Windows as
it sets binary mode on `stdout`. This was based on the author's remarks but it
is untested as Cody has no Windows system to test it on.

Cody also added the [try.sh](%%REPO_URL%%/2005/persano/try.sh) script.


<div id="2005_sykes">
## Winning entry: [2005/sykes](2005/sykes/index.html)
### Winning entry source code: [sykes.c](%%REPO_URL%%/2005/sykes//sykes.c)
</div>

[Cody](#cody) added the saved (with the `SAVE` command) BASIC program `PET` which was:

``` <!---basic-->
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

Cody added the [try.sh](%%REPO_URL%%/2005/sykes/try.sh) script which runs in a loop with a
menu of things one might wish to try, asking if they wish to continue when done.

Cody added the script [test.sh](%%REPO_URL%%/2005/sykes/test.sh) and the make rule `test` to
run the test suite. The program will enter an infinite loop after it runs so you
have to hit ctrl-c to end it which the script tells you.

The scripts note every time that one will have to send ctrl-c or whatever their
interrupt is set to in order to exit the program.


<div id="2005_timwi">
## Winning entry: [2005/timwi](2005/timwi/index.html)
### Winning entry source code: [timwi.c](%%REPO_URL%%/2005/timwi//timwi.c)
</div>

[Cody](#cody) added [try.sh](%%REPO_URL%%/2005/timwi/try.sh). It only has one command as he doesn't
want to knacker his brain any more than it might or might not already be :-) and
he doesn't want to damage anyone else's brain either. :-)


<div id="2005_toledo">
## Winning entry: [2005/toledo](2005/toledo/index.html)
### Winning entry source code: [toledo.c](%%REPO_URL%%/2005/toledo//toledo.c)
</div>

[Cody](#cody) fixed this to compile with some versions of `clang` which have an additional
defect where `main()` can only have 0, 2 or 3 args (it was 4). It now calls
another function that takes 4 args and which is what used to be `main()`.

The [alternate versions](2005/toledo/index.html#alternate-code) that the author
provided were also fixed.


<div id="2005_vince">
## Winning entry: [2005/vince](2005/vince/index.html)
### Winning entry source code: [vince.c](%%REPO_URL%%/2005/vince//vince.c)
</div>

[Cody](#cody) fixed this in the case that the program is compiled or linked/copied to
another file name: the code constructed the source code file name in a clever
and more obscure way by copying to the buffer `*argv` and then using `strcat(3)`
to concatenate to it `.c`. But this assumes that the executable is the same name
as the source file which isn't always true. The author even stated: '`as long
as the source is in the same directory as the executable it should be able to
find it`' but the source code file name is not always the same as the executable
with the appropriate extension so this might be called a bug fix as well though
if one runs it from another directory, specifying the directory, it'll not catch it.


<div id="2006">
# [2006 - The 19th IOCCC](2006/index.html)
</div>


<div id="2006_birken">
## Winning entry: [2006/birken](2006/birken/index.html)
### Winning entry source code: [birken.c](%%REPO_URL%%/2006/birken//birken.c)
</div>

[Cody](#cody) fixed a segfault that prevented this entry from working in macOS.
The problem was a missing `+1` for `strlen(3)` with `malloc(3)`. This prevented
it from working.

Cody also added the [try.sh](%%REPO_URL%%/2006/birken/try.sh) script.


<div id="2006_borsanyi">
## Winning entry: [2006/borsanyi](2006/borsanyi/index.html)
### Winning entry source code: [borsanyi.c](%%REPO_URL%%/2006/borsanyi//borsanyi.c)
</div>

[Cody](#cody) fixed the `Makefile` to work in systems where the `lpthread` is not
implicitly linked in.

Cody also added the [try.sh](%%REPO_URL%%/2006/borsanyi/try.sh) script.


<div id="2006_grothe">
## Winning entry: [2006/grothe](2006/grothe/index.html)
### Winning entry source code: [grothe.c](%%REPO_URL%%/2006/grothe//grothe.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2006/grothe/try.sh) script.


<div id="2006_hamre">
## Winning entry: [2006/hamre](2006/hamre/index.html)
### Winning entry source code: [hamre.c](%%REPO_URL%%/2006/hamre//hamre.c)
</div>

Cody also added the [try.sh](%%REPO_URL%%/2006/hamre/try.sh) script.


<div id="2006_monge">
## Winning entry: [2006/monge](2006/monge/index.html)
### Winning entry source code: [monge.c](%%REPO_URL%%/2006/monge//monge.c)
</div>

[Cody](#cody) added the [alternate code](%%REPO_URL%%/2006/monge/monge.alt.c) that lets
one resize the image and redefine the number of iterations.

Cody also added the [try.sh](%%REPO_URL%%/2006/monge/try.sh) and
[try.alt.sh](%%REPO_URL%%/2006/monge/try.alt.sh) scripts.

Cody also fixed the `Makefile` to use `sdl-config` (which is what the author
stated too though that was noticed later), not `sdl2-config` as two functions
that are used were removed from [SDL2](https://www.libsdl.org),
thus making it not link. Since SDL2 is still available and since changing the
code to use SDL2 is much more complicated and also makes the entry less like
the original it was simply made to link in SDL1.

Nevertheless this entry does require x86/x86_64 CPUS. This is a documented
feature but one which we will accept fixes to. See [2006/monge in
bugs.html](bugs.html#2006_monge).


<div id="2006_night">
## Winning entry: [2006/night](2006/night/index.html)
### Winning entry source code: [night.c](%%REPO_URL%%/2006/night//night.c)
</div>

As [Cody](#cody) is a lost :-) `vim` user he took the author's remarks to add support
back for arrow keys in the [alternate version](%%REPO_URL%%/2006/night/night.alt.c).


<div id="2006_sloane">
## Winning entry: [2006/sloane](2006/sloane/index.html)
### Winning entry source code: [sloane.c](%%REPO_URL%%/2006/sloane//sloane.c)
</div>

[Cody](#cody) fixed this entry to work with `clang` which has a defect with the args to
`main()`: it requires specific types: `int` and `char **` for the first and
latter args.

Cody also provided the [alternate version](%%REPO_URL%%/2006/sloane/sloane.alt.c), which
allows one to see what is going on in modern systems, and which we recommend one
use _first_.

Curiously, although `clang` requires the types of args to be strictly correct,
some versions do allow only one arg. This was done at first because it's not
used but Cody discovered that later versions of `clang` have an additional defect
where it does not allow only one arg so the second arg to `main()` was added
back.

This was an unfortunate problem for the alternate code as he has been using `Z`
for alternate code `usleep()` (for sleep) but in this case unfortunately the
original entry used `Z` in `main()` (though unused) so to make it more like the
original Cody renamed the macro `Z` for `usleep()` to `S` instead which can
stand for sleep and also it is kind of like a backwards `Z`. That way `Z` could
be in `main()`.

Cody also made sure that the `Makefile` links in `libm` as not all systems do this
by default.

Since the author suggested that the lack of certain `#include`s might break the
program in some systems he also added `-include ...` to the `Makefile` as well.


<div id="2006_stewart">
## Winning entry: [2006/stewart](2006/stewart/index.html)
### Winning entry source code: [stewart.c](%%REPO_URL%%/2006/stewart//stewart.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2006/stewart/try.sh) script.


<div id="2006_sykes1">
## Winning entry: [2006/sykes1](2006/sykes1/index.html)
### Winning entry source code: [sykes1.c](%%REPO_URL%%/2006/sykes1//sykes1.c)
</div>

[Cody](#cody) provided the [alternate
code](%%REPO_URL%%/2006/sykes1/sykes1.alt.c) based on the
author's remarks.

Cody also added the [try.sh](%%REPO_URL%%/2006/sykes1/try.sh) script.

Cody also provided the [bedlam-cubes.pdf](2006/sykes1/bedlam-cubes.pdf) file,
obtained from the Internet Wayback Machine, as the file was no longer available.
The video was also no longer available but Cody found an alternative and added
it to the repo as well.


<div id="2006_sykes2">
## Winning entry: [2006/sykes2](2006/sykes2/index.html)
### Winning entry source code: [sykes2.c](%%REPO_URL%%/2006/sykes2//sykes2.c)
</div>

[Cody](#cody), out of an abundance of caution for `clang`'s defects, made `main()` have
2 args instead of 1 as some versions report that `main()` must have 0, 2 or 3
args, even though at least one of those versions allows 1 arg only.  See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody also added the [try.sh](%%REPO_URL%%/2006/sykes2/try.sh) script for easier use of the
entry to show the clock update in real time.


<div id="2006_toledo1">
## Winning entry: [2006/toledo1](2006/toledo1/index.html)
### Winning entry source code: [toledo1.c](%%REPO_URL%%/2006/toledo1//toledo1.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2006/toledo1/try.sh) script.


<div id="2006_toledo2">
## Winning entry: [2006/toledo2](2006/toledo2/index.html)
### Winning entry source code: [toledo2.c](%%REPO_URL%%/2006/toledo2//toledo2.c)
</div>

[Cody](#cody) fixed a segfault in this program which was making it fail to work under
macOS - it did not seem to be a problem under Linux, at least not fedora. The
problem was wrong variable types - implicit `int`s instead of `FILE *`s. It now
works with both macOS and Linux.

Cody also added the (untested) [alternate
code](%%REPO_URL%%/2006/toledo2/toledo2.alt.c) that is based on the author's remarks to
port this to systems that have the non-standard `kbhit()` and `getch()` (not the
one from curses) which is typically (always?) in `conio.h`.

The author, [Oscar Toledo G.](authors.html#Oscar_Toledo), later went back over
the program and modified the `fread(3)`/`fwrite(3)` section to use the variable
`FILE *e` (that Cody changed) instead of `int y`, making it to work on x86_64
(perhaps Cody's fix was for arm64 only?). Also, he added a note to clarify from
where appears the `IMPORT.COM` and `HALT.COM` files.



<div id="2006_toledo3">
## Winning entry: [2006/toledo3](2006/toledo3/index.html)
### Winning entry source code: [toledo3.c](%%REPO_URL%%/2006/toledo3//toledo3.c)
</div>

[Cody](#cody) fixed a crash and a display problem in this entry so that it now works in
modern (64-bit) systems.  The crash appears to only occur in macOS but the fix
lets it work in both Linux and macOS. The problem was that it relied on 32-bits
so some `int`s were changed to `long`s. The display problem might or might not
have been a problem in Linux with the old `int`s but this is no longer known.

Cody also added the code that _should_ work for Windows,
[toledo3.alt.c](%%REPO_URL%%/2006/toledo3/toledo3.alt.c), based on the author's remarks.
We're not able to test this.


<div id="2011">
# [2011 - The 20th IOCCC](2011/index.html)
</div>


<div id="2011_akari">
## Winning entry: [2011/akari](2011/akari/index.html)
### Winning entry source code: [akari.c](%%REPO_URL%%/2011/akari//akari.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/akari/try.sh) script.


<div id="2011_blakely">
## Winning entry: [2011/blakely](2011/blakely/index.html)
### Winning entry source code: [blakely.c](%%REPO_URL%%/2011/blakely//blakely.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/blakely/try.sh) script.


<div id="2011_borsanyi">
## Winning entry: [2011/borsanyi](2011/borsanyi/index.html)
### Winning entry source code: [borsanyi.c](%%REPO_URL%%/2011/borsanyi//borsanyi.c)
</div>

[Cody](#cody), out of an abundance of caution, added a second arg to `main()` as some
versions of `clang` complain about not only the type of each arg to `main()` but
the number of args as well. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody also added the [try.sh](%%REPO_URL%%/2011/borsanyi/try.sh) script.


<div id="2011_dlowe">
## Winning entry: [2011/dlowe](2011/dlowe/index.html)
### Winning entry source code: [dlowe.c](%%REPO_URL%%/2011/dlowe//dlowe.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/dlowe/try.sh) script.

Cody also fixed a problem in the manifest, caused by a file name that would be
interpreted as something else in web servers and would thus be a 404 error even
though the file appears to exist on disk. In particular the file
`2011/dlowe/dlowe-aux-data/english-0/CIR_APE_08_doc%5B1%5D.txt` had to be
renamed to `CIR_APE_08_doc.txt` because web servers would parse it as
`CIR_APE_08_doc[1].txt` which obviously does not exist as on disk the file name had
the html encoding literally for the characters, not the characters they
translate to themselves (which was in the manifest).
The file could have been named to that but it is not POSIX safe so the `[]`s
were removed.  At the same time, for the same reason (though the link worked),
the file `2011/dlowe/dlowe-aux-data/png-1/image_thumb[40].png` was renamed to
`image_thumb.png`.


<div id="2011_eastman">
## Winning entry: [2011/eastman](2011/eastman/index.html)
### Winning entry source code: [eastman.c](%%REPO_URL%%/2011/eastman//eastman.c)
</div>

[Cody](#cody) added the video file
[boing-ball.mp4](2011/eastman/boing-ball.mp4) which is the demo the
author referred to.


<div id="2011_fredriksson">
## Winning entry: [2011/fredriksson](2011/fredriksson/index.html)
### Winning entry source code: [fredriksson.c](%%REPO_URL%%/2011/fredriksson//fredriksson.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/fredriksson/try.sh) script.


<div id="2011_goren">
## Winning entry: [2011/goren](2011/goren/index.html)
### Winning entry source code: [goren.c](%%REPO_URL%%/2011/goren//goren.c)
</div>

[Cody](#cody) fixed this for macOS.  Before the fix it segfaulted. It worked fine under
Linux. After fixing it it was noticed that the author stated it does not work
for 64-bit so it was then tested as a 32-bit binary (Linux) and 64-bit binary
(Linux, macOS) and both work. It was fixed by changing some `int`s to `long`s
and now it does work with 64-bit systems as well as 32-bit systems.

Cody also added the [try.sh](%%REPO_URL%%/2011/goren/try.sh) script.

Cody added the following words of wisdom: `'"this" is not a pipe but "|" is'`.


<div id="2011_hamaji">
## Winning entry: [2011/hamaji](2011/hamaji/index.html)
### Winning entry source code: [hamaji.c](%%REPO_URL%%/2011/hamaji//hamaji.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/hamaji/try.sh) script and the `.nono` files
[conway-game-of-life.nono](%%REPO_URL%%/2011/hamaji/conway-game-of-life.nono),
[multi-solutions.nono](%%REPO_URL%%/2011/hamaji/multi-solutions.nono),
[no-solution.nono](%%REPO_URL%%/2011/hamaji/no-solution.nono),
[plus.nono](%%REPO_URL%%/2011/hamaji/plus.nono) and [smiley.nono](%%REPO_URL%%/2011/hamaji/smiley.nono).
The latter two `.nono` files were taken from
<https://web.archive.org/web/20130218055139/http://codegolf.com/paint-by-numbers>
and the others were from the authors' remarks.


<div id="2011_hou">
## Winning entry: [2011/hou](2011/hou/index.html)
### Winning entry source code: [hou.c](%%REPO_URL%%/2011/hou//hou.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/hou/try.sh) script.


<div id="2011_konno">
## Winning entry: [2011/konno](2011/konno/index.html)
### Winning entry source code: [konno.c](%%REPO_URL%%/2011/konno//konno.c)
</div>

Cody added the [try.sh](%%REPO_URL%%/2011/konno/try.sh) script.


<div id="2011_richards">
## Winning entry: [2011/richards](2011/richards/index.html)
### Winning entry source code: [richards.c](%%REPO_URL%%/2011/richards//richards.c)
</div>

[Cody](#cody) fixed a minor problem that showed up in both Linux and macOS. He notes
however that as of this time this entry does not work properly with macOS at
least with the silicon chip (Intel has not been tested) and it is quite possibly
an inherent problem in macOS to do with executing code in in memory/JIT and in
particular with the silicon chip. See [2011/richards in
bugs.html](bugs.html#2011_richards) for more details and a
document from Apple about how it might be fixed if anyone is brave enough to
try. If they do they might want to look also at
[richards.alt.c](%%REPO_URL%%/2011/richards/richards.alt.c), for whatever it might or might
not be worth, as it is a possible starting point that Cody added.

Cody also added the [try.sh](%%REPO_URL%%/2011/richards/try.sh) and the
[try.alt.sh](%%REPO_URL%%/2011/richards/try.alt.sh) scripts. The `try.alt.sh` script will be
helpful to test any fixes for Apple silicon chips (see [2011/richards in
bugs.html](bugs.html#2011_richards) for more details).


<div id="2011_toledo">
## Winning entry: [2011/toledo](2011/toledo/index.html)
### Winning entry source code: [toledo.c](%%REPO_URL%%/2011/toledo//toledo.c)
</div>

[Cody](#cody) added two [alternate versions](2011/toledo/index.html#alternate-code): one that
lets one reconfigure the controls and also the size of the game and another
version that should work in Windows, based on the author's remarks and support
file, `layer.c`.

The `Makefile` was also modified by Cody to make it simpler to redefine the
controls, width and height.


<div id="2011_vik">
## Winning entry: [2011/vik](2011/vik/index.html)
### Winning entry source code: [vik.c](%%REPO_URL%%/2011/vik//vik.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/vik/try.sh) script.

Cody also added an [alternate version](%%REPO_URL%%/2011/vik/vik.alt.c) for Windows
based on the author's comments (along with looking up the function for the right
header files). To build try the `alt` rule of the `Makefile`.


<div id="2011_zucker">
## Winning entry: [2011/zucker](2011/zucker/index.html)
### Winning entry source code: [zucker.c](%%REPO_URL%%/2011/zucker//zucker.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2011/zucker/try.sh) script.

Cody also added [alternate code](%%REPO_URL%%/2011/zucker/zucker.alt.c) that should work on
Windows, based on the author's remarks that if the system distinguishes binary
and text then `stdout` needs to be set to binary mode.

Cody also added the PDF file
[sphere-tracing.pdf](2011/zucker/sphere-tracing.pdf) in case the link
eventually dies.


<div id="2012">
# [2012 - The 21st IOCCC](2012/index.html)
</div>


<div id="2012_blakely">
## Winning entry: [2012/blakely](2012/blakely/index.html)
### Winning entry source code: [blakely.c](%%REPO_URL%%/2012/blakely//blakely.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) as not all systems do this
implicitly (Linux doesn't seem to but macOS does).

Cody also added the [try.sh](%%REPO_URL%%/2012/blakely/try.sh) script.


<div id="2012_deckmyn">
## Winning entry: [2012/deckmyn](2012/deckmyn/index.html)
### Winning entry source code: [deckmyn.c](%%REPO_URL%%/2012/deckmyn//deckmyn.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/deckmyn/try.sh) script.


<div id="2012_endoh1">
## Winning entry: [2012/endoh1](2012/endoh1/index.html)
### Winning entry source code: [endoh1.c](%%REPO_URL%%/2012/endoh1//endoh1.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) as not all systems do this
implicitly (Linux doesn't seem to but macOS does).

Cody also added two [alt versions](2012/endoh1/index.html#alternate-code) that
let one control how fast the fluid moves (how long to sleep in between writes)
and also the gravity factor, the pressure factor and the viscosity factor as
well as an alarm that lets one run it in a loop without having to hit
ctrl-c/intr in between (the alarm can be disabled, however). The `Makefile` allows
one to easily do this with variable names rather than redefining `CDEFINE`.

The two different alt versions is because there are two versions: the original
and the colour version added by the author, [Yusuke](#yusuke), at the request of
the judges.

Cody also added the [try.alt.sh](%%REPO_URL%%/2012/endoh1/try.alt.sh) script that compiles
the alternate code in two ways, one with setting the gravity factor to `I` and another
with the default, and which is run on the source file and each of the text files
supplied by the author. This code has an alarm set at 10 seconds so that one
need not hit ctrl-c/intr in between .. say to make it more fluid :-)

Cody also added the [try.alt.bw.sh](%%REPO_URL%%/2012/endoh1/try.alt.bw.sh) which is the
same as the `try.alt.sh` except it does not use the coloured version.

Finally Cody added the [try.sh](%%REPO_URL%%/2012/endoh1/try.sh) and
[try.bw.sh](%%REPO_URL%%/2012/endoh1/try.bw.sh) which correspond to the coloured version
[endoh1_color.c](%%REPO_URL%%/2012/endoh1/endoh1_color.c) and the original submitted
version without colour, [endoh1.c](%%REPO_URL%%/2012/endoh1/endoh1.c).

The [endoh1.alt2.c](%%REPO_URL%%/2012/endoh1/endoh1.alt2.c) was provided by the author,
[Yusuke](#yusuke), at the time of the contest as a de-obfuscated version.


<div id="2012_endoh2">
## Winning entry: [2012/endoh2](2012/endoh2/index.html)
### Winning entry source code: [endoh2.c](%%REPO_URL%%/2012/endoh2//endoh2.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/endoh2/try.sh) script that runs
everything, filtered through less.

Cody also fixed a typo in the ruby script
[find-font-table.rb](%%REPO_URL%%/2012/endoh2/find-font-table.rb).


<div id="2012_grothe">
## Winning entry: [2012/grothe](2012/grothe/index.html)
### Winning entry source code: [grothe.c](%%REPO_URL%%/2012/grothe//grothe.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/grothe/try.sh) script.

Cody also changed `argv` to be not `const char **` but `char **`, mostly out of an
abundance of caution in case `clang`, which already imposes restrictions on the
types of args to `main()` including to do with `char **`, decides to further
restrict them. See [FAQ 4.6  - Why was arg
count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody also restored the original code from the archive.

And although the URL works for now (via redirect), Cody changed the website
linked to in the recipe file to the domain that the old one currently redirects
to, in case the other domain ends up expiring or stops redirecting to the more
recent domain. For historical purposes the old link was
`http://recipes.stevex.net/` but it redirects to `https://www.mealsteps.com`
which the recipe file now links to.


<div id="2012_hamano">
## Winning entry: [2012/hamano](2012/hamano/index.html)
### Winning entry source code: [hamano.c](%%REPO_URL%%/2012/hamano//hamano.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/hamano/try.sh) script and the helper
Makefile rules `hint.pdf`, `hint`, `hello.pdf` and `hello` to simplify the
procedure for both `hint.pdf` and `hello.pdf` as well as compiling them as C.


<div id="2012_hou">
## Winning entry: [2012/hou](2012/hou/index.html)
### Winning entry source code: [hou.c](%%REPO_URL%%/2012/hou//hou.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/hou/try.sh) script and restored the original [hint
markdown file](%%REPO_URL%%/2012/hou/hint.md) as the changes made when converting to a GitHub
index.html made the generated html not look correct; it did not have a title, a
stylesheet etc. due to the fact that there is no `#` header (which specified
title and stylesheet) and other formatting changes.


<div id="2012_kang">
## Winning entry: [2012/kang](2012/kang/index.html)
### Winning entry source code: [kang.c](%%REPO_URL%%/2012/kang//kang.c)
</div>

[Cody](#cody) added alternate code that fixes a problem where in German 'v'
sounds like 'f' which the program has as 'f': with the original version it would
translate 'fier' to '4' when the word is 'vier'. This was during a time that a
lot of entries that no longer worked were fixed and it was done without much
thought but having this alternate version allows one to appreciate the entry
even more so it was kept in.

This change will actually break other translations. It also was a feature, not a
bug, even if it might seem like a bug. But having both versions allows one to
appreciate the entry even more, given how simple the difference is: as has been
seen in many entries over the years, a single character can drastically change
what happens, sometimes in surprising and delightful ways!

Cody also added six scripts, starting with
[en.sh](%%REPO_URL%%/2012/kang/en.sh), [de.sh](%%REPO_URL%%/2012/kang/de.sh),
[en.alt.sh](%%REPO_URL%%/2012/kang/en.alt.sh) and
[de.alt.sh](%%REPO_URL%%/2012/kang/de.alt.sh) which count from 0 through 13 in
English and German using the original entry and the alt version respectively.

In the German scripts it uses the umlaut and also does it without the umlaut
(add an 'e'). Notice how the program picks up on this! All scripts can use
either version but the `.alt.sh` versions default to the `alt` version whereas
the other defaults to the submitted entry. See the index.html for details.

The fifth and sixth scripts, [try.sh](%%REPO_URL%%/2012/kang/try.sh) and
[try.alt.sh](%%REPO_URL%%/2012/kang/try.alt.sh), run a sequence of commands to
show different languages and numbers with the submitted and alternate version
respectively. Notice how a single letter changes so much!


<div id="2012_konno">
## Winning entry: [2012/konno](2012/konno/index.html)
### Winning entry source code: [konno.c](%%REPO_URL%%/2012/konno//konno.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/konno/try.sh) script.


<div id="2012_omoikane">
## Winning entry: [2012/omoikane](2012/omoikane/index.html)
### Winning entry source code: [omoikane.c](%%REPO_URL%%/2012/omoikane//omoikane.c)
</div>

[Cody](#cody) added the [alternate
versions](2012/omoikane/index.html#alternate-code) which will, if no arg is
specified, read in the program itself, rather than `/dev/urandom`. This is
mostly useful for those without a `/dev/urandom` device file, which the author
pointed out as being a problem, but which is the default for the entry . The
second alternate version is like the first except that it also sets binary mode
on `stdin` and `stdout` which should theoretically make it work in Windows. This
comes from the author's remarks.

Cody also added the [try.sh](%%REPO_URL%%/2012/omoikane/try.sh) and
[try.alt.sh](%%REPO_URL%%/2012/omoikane/try.alt.sh) scripts.


<div id="2012_tromp">
## Winning entry: [2012/tromp](2012/tromp/index.html)
### Winning entry source code: [tromp.c](%%REPO_URL%%/2012/tromp//tromp.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/tromp/try.sh) script.


<div id="2012_vik">
## Winning entry: [2012/vik](2012/vik/index.html)
### Winning entry source code: [vik.c](%%REPO_URL%%/2012/vik//vik.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/vik/try.sh) script.

Based on the author's description it should be possible to get this entry to work
for Windows. With his instructions Cody also added the [alternate
version](%%REPO_URL%%/2012/vik/vik.alt.c) that does this.


<div id="2012_zeitak">
## Winning entry: [2012/zeitak](2012/zeitak/index.html)
### Winning entry source code: [zeitak.c](%%REPO_URL%%/2012/zeitak//zeitak.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2012/zeitak/try.sh) script and the
`make test` rule that uses the script along with a number of files that will
correctly be flagged as incorrect (including a text file and a Java file, with a
joke, to show that it's not that it parses C but rather just matching pairs
though that's probably obvious) and some correctly nested files were also added
including [1984/anonymous](%%REPO_URL%%/1984/anonymous/index.html) (as the
author explicitly mentioned it), both the [original
version](%%REPO_URL%%/2012/zeitak/anonymous.alt.c) (.alt.c) and the
[modified version](%%REPO_URL%%/2012/zeitak/anonymous.c) that works with macOS
as well, and a Java file as well with another joke. Those C files had to be
added because each entry has its own tarball and without the files it would
break the script.

A problem was later fixed in the `Makefile` by Cody, a typo in the `CSILENCE`
variable that prevented compilation.

A minor point is that the author noted that one should
look at the program source with tab space of 4 characters so Cody added the
command to do this in vim for those who use it, in the judges' remarks, to make
it easier for those who do not know how, and to make it more obvious to try it.


<div id="2013">
# [2013 - The 22nd IOCCC](2013/index.html)
</div>

<div id="2013_birken">
## Winning entry: [2013/birken](2013/birken/index.html)
### Winning entry source code: [birken.c](%%REPO_URL%%/2013/birken//birken.c)
</div>

[Cody](#cody) changed the `return 0;` at the end of the program to be `return
system("reset");` (via redefining `exit(3)` so that the column ending would be
the same) so that as long as it runs to completion the terminal will be sane and
the cursor will be visible. Using `atexit(3)` will not work if the program is
killed, signals are ugly and these would be messing with the entry too much so
these were not done.

Cody also added the [alternate version](%%REPO_URL%%/2013/birken/birken.alt.c)
that lets one control how fast the painting is done, based on the author's
recommendations, except that Cody made it configurable at compile time. The
`Makefile` was modified in such a way as to make it very easy to redefine it at
compile time.

Cody also added the [try.sh](%%REPO_URL%%/2013/birken/try.sh) script for the entry and the
[try.alt.sh](%%REPO_URL%%/2013/birken/try.alt.sh) script for the alternate code.


<div id="2013_cable1">
## Winning entry: [2013/cable1](2013/cable1/index.html)
### Winning entry source code: [cable1.c](%%REPO_URL%%/2013/cable1//cable1.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/cable1/try.sh) script.


<div id="2013_cable2">
## Winning entry: [2013/cable2](2013/cable2/index.html)
### Winning entry source code: [cable2.c](%%REPO_URL%%/2013/cable2//cable2.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/cable2/try.sh) script.


<div id="2013_cable3">
## Winning entry: [2013/cable3](2013/cable3/index.html)
### Winning entry source code: [cable3.c](%%REPO_URL%%/2013/cable3//cable3.c)
</div>

[Cody](#cody) fixed this to compile with modern systems. The problems were that
`localtime()` is used differently and with `time.h` being included (with
[SDL2](https://www.libsdl.org) in macOS - but see below) there was a conflicting
function type. This appeared to be a problem with macOS and only when SDL2 was
included (but which as noted next it cannot be).

The other problem is that this entry uses SDL functions that were
removed from SDL2 so the `Makefile` has to use `sdl-config` and not `sdl2-config`.
This meant that at one point to be strictly technical, the removal of
`localtime()` wasn't necessary but this change was left in place anyway (but see
below again).

Later on in an updated macOS (problem discovered in macOS Sonoma) the entry
failed to compile again also due to `localtime()` so he removed the prototype
entirely to solve the problem.

Cody also slightly improved the `runme` script (renamed to
[cable3.sh](%%REPO_URL%%/2013/cable3/cable3.sh) for consistency with other entries that have
wrapper scripts) to not assume that the program has been compiled by running
`make clobber all || exit 1` and he also made it pass `shellcheck` (using `[[ ..
]]` over `[ .. ]`).

As well, based on the author's remarks, Cody added the [alternate
code](%%REPO_URL%%/2013/cable3/cable3.alt.c) which should be compilable for Windows/MS Visual
Studio. This is done by in the compile line undefining `KB` (`-UKB`) and then in
the source code defining `KB` to what the author suggested,
`(kb=H(8),kbhit())&&(r[1190]=getch(),H(7))`. It need hardly be mentioned that
this will not link in Unix systems (including macOS).


Finally Cody provided the [bios.asm](%%REPO_URL%%/2013/cable3/bios.asm) that the author
referred to, found at the [GitHub repo for the
entry](https://github.com/adriancable/8086tiny/tree/master), and the `ready-made
40MB hard disk image containing a whole bunch of software` in `hd.img` that the
author linked to at `https://bitly.com/1bU8URK`.


<div id="2013_dlowe">
## Winning entry: [2013/dlowe](2013/dlowe/index.html)
### Winning entry source code: [dlowe.c](%%REPO_URL%%/2013/dlowe//dlowe.c)
</div>

[Cody](#cody) added the source code that we suggested one should compile and run with
different compilers as [fun.c](%%REPO_URL%%/2013/dlowe/fun.c). He modified the `Makefile` so
that running `make all` will compile it, saving you the effort.

He also provided the script [slflen.sh](%%REPO_URL%%/2013/dlowe/slflen.sh) which is based on
the author's remarks, fixing it for shellcheck and improving upon it (show what
files will be processed). This script shows the sparkline of the file lengths
(as in `wc -c`). The fixes (but not the improvements) were added to the author's
remarks.

Since the author called the program `sparkl` Cody modified the `Makefile` so that
running `make all` will create a symlink to `dlowe` as `sparkl`. Running `make
clobber` will delete both and running `make clobber all` will ensure that the
symlink is created. The `slflen.sh` script also explicitly makes sure to create
the symlink as it uses it, even though it runs `make clobber all`.

Cody also added the [try.sh](%%REPO_URL%%/2013/dlowe/try.sh) script to more easily try the
program.

He also added the [diff.sh](%%REPO_URL%%/2013/dlowe/diff.sh) script which is based on some
commands to try that he suggested to see how different lengths look.


<div id="2013_endoh1">
## Winning entry: [2013/endoh1](2013/endoh1/index.html)
### Winning entry source code: [endoh1.c](%%REPO_URL%%/2013/endoh1//endoh1.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/endoh1/try.sh) script.


<div id="2013_endoh2">
## Winning entry: [2013/endoh2](2013/endoh2/index.html)
### Winning entry source code: [endoh2.c](%%REPO_URL%%/2013/endoh2//endoh2.c)
</div>

[Cody](#cody) fixed the `Makefile` `check` rule so that it `checks` :-) that both
[Ruby](https://www.ruby-lang.org) and [ImageMagick](https://imagemagick.org) are
installed before trying to run the ruby script. To be more technically correct:
it checks that the `convert` tool of ImageMagick is available (via `type -P`)
because `convert` is part of the ImageMagick suite. The rule will report the
tools not installed and where to find them, if they are not installed, and after
checking these requirements it will exit if either is not found.

The checks are useful because the Ruby script tries to run (via `IO.popen()`) the
`convert` tool but without ImageMagick being installed, if one is unaware of
where it comes from it will appear to be an error in the Ruby script (it might
also appear to be an issue with the script even if you know of `convert`).

The entry can still be enjoyed if you do not have these tools, however.


<div id="2013_endoh3">
## Winning entry: [2013/endoh3](2013/endoh3/index.html)
### Winning entry source code: [endoh3.c](%%REPO_URL%%/2013/endoh3//endoh3.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/endoh3/try.sh) script.

Cody also (out of an abundance of caution for `clang(1)` which is strict with
arg type and count to `main()`) added a second (unused) arg to `main()`. See
[FAQ 4.6  - Why was arg count and/or type changed in main&#x28;&#x29; in some
older entries?](faq.html#faq4_6) for more details.




<div id="2013_endoh4">
## Winning entry: [2013/endoh4](2013/endoh4/index.html)
### Winning entry source code: [endoh4.c](%%REPO_URL%%/2013/endoh4//endoh4.c)
</div>

[Cody](#cody) added the [endoh4.sh](%%REPO_URL%%/2013/endoh4/endoh4.sh) script which temporarily
turns off the cursor as suggested by the author, with the addition that if no
file is specified it will feed the source code [endoh4.c](%%REPO_URL%%/2013/endoh4/endoh4.c)
to the program rather than the file specified. It does not try and detect if the
file exists or can be read as that will be handled by the shell/program. One may
pass more than one file to the script.

Cody also made it easier to redefine the size at compilation time (see the
author's remarks for more details on what this means). The `endoh4.sh` script
allows one to redefine it as well.


<div id="2013_hou">
## Winning entry: [2013/hou](2013/hou/index.html)
### Winning entry source code: [hou.c](%%REPO_URL%%/2013/hou//hou.c)
</div>

[Cody](#cody) fixed the `Makefile` so that this would work properly. Before this
the use of the program just did what the judges' remarks said as far as how it
might violate rule 2: the program is really just a decompressor to generate the
real source of the program. So the source of the entry has to be compiled and
then run, and the output has to be compiled to be `hou`. This allows the real
program to be used. Thus the `Makefile` rule looks like:

``` <!---makefile-->
    ${PROG}: ${PROG}.c
            ${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}
        ./${PROG} | ${CC} ${CFLAGS} -xc - -o $@ ${LDFLAGS}
```



which then compiles like:

``` <!---sh-->
    cc -std=gnu11 -Wall -Wextra -pedantic -Wno-sign-compare -Wno-strict-prototypes    -O3 hou.c -o hou -lm
    ./hou | cc -std=gnu11 -Wall -Wextra -pedantic -Wno-sign-compare -Wno-strict-prototypes    -O3 -xc - -o hou -lm
```

The `LDFLAGS` were updated to have `-lm` as the author suggested it uses the
`math.h` library which not all systems link in by default (Linux for instance
does not).

The author noted that one can build `a.c` and refers to it in documentation. The
rule in the `Makefile` was originally removed as part of the above but it was
restored so that one can see what the author is talking about.

Further, after the file `2013/hou/doc/example.markdown` was moved to
[2013/hou/doc/example.md](%%REPO_URL%%/2013/hou/doc/example.md) to match the rest of the repo
this broke `make` which Cody also fixed.

Cody also added the [try.sh](%%REPO_URL%%/2013/hou/try.sh) script.


<div id="2013_mills">
## Winning entry: [2013/mills](2013/mills/index.html)
## Source code: [mills.c](%%REPO_URL%%/2013/mills/mills.c)
</div>

[Cody](#cody) fixed this so that the server would not refuse the connection
after the first call to `close(2)`. The problem was that because the backlog to
`listen(2)` was `1`, once the connection closed the server was essentially 'dead'.
The backlog was changed to `10` and this solves the problem. It is not known if
this was specific to macOS but it was not specific to a browser as Safari and
Firefox both had the problem.


<div id="2013_misaka">
## Winning entry: [2013/misaka](2013/misaka/index.html)
### Winning entry source code: [misaka.c](%%REPO_URL%%/2013/misaka//misaka.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/misaka/try.sh) script.


<div id="2013_morgan1">
## Winning entry: [2013/morgan1](2013/morgan1/index.html)
### Winning entry source code: [morgan1.c](%%REPO_URL%%/2013/morgan1//morgan1.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) as not all systems do this
implicitly (Linux doesn't seem to but macOS does).

Cody also added the [try.sh](%%REPO_URL%%/2013/morgan1/try.sh) script.


<div id="2013_robison">
## Winning entry: [2013/robison](2013/robison/index.html)
### Winning entry source code: [robison.c](%%REPO_URL%%/2013/robison//robison.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2013/robison/try.sh) script.


<div id="2014">
# [2014 - The 23rd IOCCC](2014/index.html)
</div>

[Yusuke](#yusuke) added the missing `rules.txt`, `iocccsize.c` and `
iocccsize.mk` files.


<div id="2014_birken">
## Winning entry: [2014/birken](2014/birken/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/birken//prog.c)
</div>

[Cody](#cody) provided the [alternate
code](%%REPO_URL%%/2014/birken/prog.alt.c) that lets one redefine the port to
bind to in case there is a firewall issue or there is some other reason to not
have the default port. Remember that ports < 1024 are privileged. It also lets
you redefine the timing constant `STARDATE` (see the author's remarks for more
details on this macro). The `Makefile` was made to use variables so it's easier to
redefine the port and timing constant.


<div id="2014_deak">
## Winning entry: [2014/deak](2014/deak/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/deak//prog.c)
</div>

[Cody](#cody) added [alternate code](2014/deak/index.html#alternate-code) that lets
one (via the `Makefile`) reconfigure the coordinates but instead of being a
modified version of the entry it is the version the author provided which would
be what the program would look like if, as the author put it:

> The usage of recognizable elements from the C programming language in the
application source code is intentionally kept to a bare minimum.

.. was not true.

This alternate version did not originally compile because a value was left off the
`return` statement (this might have been fixed in the index.html file too) so
that was fixed and it also has `#include <stdio.h>` for `putchar(3)`. The
`#ifndef..#define..#endif` was not part of the original alternate code, of course.

Cody also added the [try.alt.sh](%%REPO_URL%%/2014/deak/try.alt.sh) script.


<div id="2014_endoh1">
## Winning entry: [2014/endoh1](2014/endoh1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/endoh1//prog.c)
</div>

[Cody](#cody) added the [rake.sh](%%REPO_URL%%/2014/endoh1/rake.sh) script and `make rake`
rule that runs the script. This script will check that `rake` is installed and
if it is not it will report this and then check that `gem` is installed. It
checks that `gem` is installed in this case because `gem` is how you install
`rake`. If `gem` is not installed it tells you to get it along with how to
install `gem`.  Then it tells you how to install `rake`. If `rake` fails to run
then it tells you to install a specific gem and then to try again. Finally if
`rake` succeeds it will verify that `prog` is executable and if it is it will
run it.

After more work on the manifest was done Cody had to update the `clobber` rule
to remove some text files so as to not cause problems with an invalid manifest.

Cody also added the [try.sh](%%REPO_URL%%/2014/endoh1/try.sh) script.

To silence the annoying misleading indentation warning and to prevent debug
symbols from being built with `rake` Cody also updated the
[Rakefile](%%REPO_URL%%/2014/endoh1/Rakefile) slightly.

**_Barely_** worth noting but done nonetheless, Cody renamed the `read_me.html`
file to [spoilers.html](2014/endoh1/spoilers.html) to be clearer in its purpose as
it is a file with deobfuscation information.


<div id="2014_endoh2">
## Winning entry: [2014/endoh2](2014/endoh2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/endoh2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2014/endoh2/try.sh) script.


<div id="2014_maffiodo1">
## Winning entry: [2014/maffiodo1](2014/maffiodo1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/maffiodo1//prog.c)
</div>

[Cody](#cody) fixed the `Makefile` for this entry: it does not require
`SDL2` but `SDL1` so there were linking errors.

Cody also added the [mario.sh](%%REPO_URL%%/2014/maffiodo1/mario.sh) and
[giana.sh](%%REPO_URL%%/2014/maffiodo1/giana.sh) scripts which play, respectively, [Super
Mario Bros](http://en.wikipedia.org/wiki/Super_Mario_Bros.) and one of [The
Great Giana Sisters](http://en.wikipedia.org/wiki/The_Great_Giana_Sisters), but
which let one configure the width and height of the game.


<div id="2014_maffiodo2">
## Winning entry: [2014/maffiodo2](2014/maffiodo2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/maffiodo2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2014/maffiodo2/try.sh) script.

Cody also added the [alternate code](%%REPO_URL%%/2014/maffiodo2/prog.alt.c)
provided by the author.


<div id="2014_morgan">
## Winning entry: [2014/morgan](2014/morgan/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/morgan//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2014/morgan/try.sh) script.


<div id="2014_sinon">
## Winning entry: [2014/sinon](2014/sinon/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/sinon//prog.c)
</div>

[Cody](#cody) fixed the code so that the game can play automatically like it
once did. The problem is that it expects a certain file name which was
`sinon.c`. The code now refers to `prog.c` (it cannot as easily use `__FILE__`).

Cody also fixed the scripts [glock.sh](%%REPO_URL%%/2014/sinon/glock.sh) and
[hecate.sh](%%REPO_URL%%/2014/sinon/hecate.sh) which did not work after running
either of them once as they compile `run.c` and then do `./run | tee run.c`
which overwrites it with output that is not code.

Cody also added the [try.sh](%%REPO_URL%%/2014/sinon/try.sh) script that will first (if perl
is installed) run the demo mode and then after that it will run the above noted
scripts in a loop until the user says they do not want to try again (or they
kill it). This is done this way in case it jams (see index.html for details).


<div id="2014_skeggs">
## Winning entry: [2014/skeggs](2014/skeggs/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/skeggs//prog.c)
</div>

[Cody](#cody) fixed the `Makefile` to compile this entry in modern systems. The problem was
that the `CDEFINE` variable in the `Makefile` was missing `'`s: the `#define CC`
is an actual string that is, in the Makefile, `"${CC} -fPIC"`, which
translates to whatever the compiler is followed by a space followed by `-fPIC`
but without the `'`s it was incomplete and so would not compile. Cody didn't
have a chance to really look at the compiler error.

[Yusuke](#yusuke) suggested that one should use `-ldl` in the Makefile. This was not
originally done because it seemed to work but since it uses `dlsym()` it was
added later to make it more portable.

The program creates files in the working directory as part of how it works (see
the index.html file for details) so Cody made sure that `make clobber` (via `make
clean`) removes those files and so that they are ignored by `.gitignore`.


<div id="2014_vik">
## Winning entry: [2014/vik](2014/vik/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/vik//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2014/vik/try.sh) script. Cody notes that there
is a bug that will show itself as one of the features does not work right. The
translation of the raw audio to text is buggy in some cases.

Cody also added an alternate version that is based on the author's remarks that will
theoretically work for Microsoft Windows compilers (if anything works in Windows
:-) ). We have no way of testing this and if anything has changed since 2014
that would break it we do not know.


<div id="2014_wiedijk">
## Winning entry: [2014/wiedijk](2014/wiedijk/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2014/wiedijk//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2014/wiedijk/try.sh) script which is based on
the command to try in the 'try' section but improved so one can more easily
specify what `indent` tool they want to use and also change which `sed(1)` to use,
should they want to. It also checks that both of these two tools exist and are
executable and it pipes it through `less(1)` as it's longer than a page worth of
output.


<div id="2015">
# [2015 - The 24th IOCCC](2015/index.html)
</div>


<div id="2015_burton">
## Winning entry: [2015/burton](2015/burton/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/burton//prog.c)
</div>


[Cody](#cody) fixed the code so one can make use of the echo feature, where the
first character of the filename starts with `e`. The only way it would work
before that is if one did something like:

``` <!---sh-->
    ln -sf prog eprog
    PATH=$PATH:. ; eprog '...'
```

since otherwise the first character would not be `e` but rather a dot
(`./eprog`). This was done by adding to the `Makefile` `-include libgen.h` and
adding to `main()` after the variable declaration (`V*A;`) the code:

``` <!---c-->
    *K=basename(*K);
```

This was done for both the [prog.c](%%REPO_URL%%/2015/burton/prog.c) and
[prog.alt.c](%%REPO_URL%%/2015/burton/prog.alt.c). The `Makefile` was also updated to build
`eprog` and `eprog.alt` to make use of the feature more easily. Each is a new
target (first in `TARGET` and second in `ALT_TARGET`) which have a prerequisite
of `${PROG}` and `${PROG}.alt` respectively both of which also copy the `prog`
(`prog` or `eprog`) to the respective `eprog` (`eprog` or `eprog.alt`).  With
these changes now one can easily use the echo feature the author implemented.

Cody also added the [try.sh](%%REPO_URL%%/2015/burton/try.sh) script. This involved
adding a text file, [try.this.txt](2015/burton/try.this.txt).

Cody also added [calc.1](%%REPO_URL%%/2015/burton/calc.1) in place of `calc.man` to have
proper formatting (in the style of `man(1)`). The `calc.man` was removed so as
to not have to maintain two copies of the same text.

Cody updated the `Makefile` to copy the `prog` to `calc` and `prog.alt` to
`calc.alt`. `ecalc` and `ecalc.alt` also work. This is because the program is
called `calc` and is in documentation including the man page. Thus one only need
add a `./` to the commands in the man page/index.html.


<div id="2015_dogon">
## Winning entry: [2015/dogon](2015/dogon/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/dogon//prog.c)
</div>

[Cody](#cody) improved the `Makefile` so that one can easily change the dimensions
at compilation time via `make(1)`.

Cody also added [alternate code](%%REPO_URL%%/2015/dogon/prog.alt.c) that is
based on the author's remarks, suggesting that one change the value of `q` to a
different number, in order to see a bug that they avoided.


<div id="2015_duble">
## Winning entry: [2015/duble](2015/duble/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/duble//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/duble/try.sh) script.


<div id="2015_endoh2">
## Winning entry: [2015/endoh2](2015/endoh2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/endoh2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/endoh2/try.sh) script.


<div id="2015_endoh3">
## Winning entry: [2015/endoh3](2015/endoh3/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/endoh3//prog.c)
</div>

[Cody](#cody) fixed this to compile with Linux which was having a problem with duplicate
symbols of `main()`. The fix is through the compiler option `-fcommon` which
will let it compile like it does with macOS.

Cody also added the [try.sh](%%REPO_URL%%/2015/endoh3/try.sh) script which makes
use of the make rule he added (to enjoy the theme of the entry, [Back to the
Future](https://en.wikipedia.org/wiki/Back_to_the_Future) using this entry by
simply typing `make back_to`, `make future` or `make mullender`) and then runs
the famous [1984/mullender.c](%%REPO_URL%%/1984/mullender/mullender.c).


<div id="2015_endoh4">
## Winning entry: [2015/endoh4](2015/endoh4/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/endoh4//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/endoh4/try.sh) script.


<div id="2015_hou">
## Winning entry: [2015/hou](2015/hou/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/hou//prog.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) for systems that do not do this
(Linux doesn't seem to but macOS does).

Cody also added the [try.sh](%%REPO_URL%%/2015/hou/try.sh) script and the large file `large`
which the `try.sh` script uses.

Cody also added the RFC 1321 text file, [rfc1321.txt](2015/hou/rfc1321.txt) to
the directory, to make it so one need not download it, and which the index.html
file now links to.


<div id="2015_howe">
## Winning entry: [2015/howe](2015/howe/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/howe//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/howe/try.sh) script, downloaded the War
and Peace text file, fixed the [avgtime.sh](%%REPO_URL%%/2015/howe/avgtime.sh) script (it
resulted in standard input errors in piping to `bc(1)`) and added the
[cc.1](%%REPO_URL%%/2015/howe/cc.1) man page as not all systems have it (in fact it's
`gcc(1)` from Rocky Linux).


<div id="2015_mills1">
## Winning entry: [2015/mills1](2015/mills1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/mills1//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/mills1/try.sh) script which changes the
parameters to what we had in the judges' remarks to make it easier.


<div id="2015_mills2">
## Winning entry: [2015/mills2](2015/mills2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/mills2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/mills2/try.sh) script.


<div id="2015_muth">
## Winning entry: [2015/muth](2015/muth/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/muth//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2015/muth/try.sh) script.


<div id="2015_schweikhardt">
## Winning entry: [2015/schweikhardt](2015/schweikhardt/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/schweikhardt//prog.c)
</div>

[Cody](#cody) fixed the build so that `EOF` will be `-1` as the program assumes
this. It was decided by Cody to do `-UEOF -DEOF=-1` so as to not have to modify
the code any with C preprocessor directives (the preferred way) or changing
`EOF` to `-1`.

Cody also added the [try.sh](%%REPO_URL%%/2015/schweikhardt/try.sh) script.


<div id="2015_yang">
## Winning entry: [2015/yang](2015/yang/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2015/yang//prog.c)
</div>

[Cody](#cody) fixed an unfortunate typo in the `Makefile` that was preventing some of the
files from compiling properly, trying instead to compile already compiled code.

He also added explicit linking of libm (`-lm`) for systems that do not do this
(Linux seems to not but macOS does).

He also added the [try.sh](%%REPO_URL%%/2015/yang/try.sh) script.


<div id="2018">
# [2018 - The 25th IOCCC](2018/index.html)
</div>

[Cody](#cody) added the missing `README.md` file from the winner archive back to
the repo.


<div id="2018_anderson">
## Winning entry: [2018/anderson](2018/anderson/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/anderson//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/anderson/try.sh) and
[try.alt.sh](%%REPO_URL%%/2018/anderson/try.alt.sh) scripts.


<div id="2018_algmyr">
## Winning entry: [2018/algmyr](2018/algmyr/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/algmyr//prog.c)
</div>


[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/algmyr/try.sh) script.


<div id="2018_bellard">
## Winning entry: [2018/bellard](2018/bellard/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/bellard//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/bellard/try.sh) script.

Cody also, out of abundance of caution, added a second arg to `main()` because
some versions of `clang` object to the number of args of `main()`, saying that it
must be 0, 2 or 3. The version this has been observed in does not actually
object to 1 arg but it is entirely possible that this changes so a second arg
(that's not needed and is unused) has been added just in case. See [FAQ 4.6  -
Why was arg count and/or type changed in main&#x28;&#x29; in some older
entries?](faq.html#faq4_6) for more details.


Cody also added explicit linking of libm (`-lm`) for systems that do not do this
(Linux doesn't seem to but macOS does).

Cody also added [alternate code](%%REPO_URL%%/2018/bellard/prog.alt.c) that should
work for Windows, based on the author's remarks. The same thing with the number
of args to `main()` that was done in the original entry was done with this
version as well.


<div id="2018_burton1">
## Winning entry: [2018/burton1](2018/burton1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/burton1//prog.c)
</div>

[Cody](#cody) fixed the `scripthd` script (referred to `prog` not `./prog`) and
renamed it to [scripthd.sh](%%REPO_URL%%/2018/burton1/scripthd.sh) to help browsers and
GitHub as far as downloading/displaying goes.

Cody also added the [try.sh](%%REPO_URL%%/2018/burton1/try.sh) script which also uses
`scripthd.sh` to show how it differs from `prog` itself.


<div id="2018_burton2">
## Winning entry: [2018/burton2](2018/burton2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/burton2//prog.c)
</div>

[Cody](#cody) fixed the `make test` rule: it tried to run `tac(1)` (in systems
that have that command) rather than the entry itself which is called `tac`. Also
the `runtest` script (which he renamed to `runtest.sh` for download/browser
display purposes) was not executable.

Cody also renamed `manpage` to `manpage.sh` for download/browser purposes and he
did the same with `tokenfix` to `tokenfix.sh` as well as `spotcheck` to
`spotcheck.sh`, `spotdiff` to `spotdiff.sh`, `freqcount` to `freqcount.sh` and
`mkkeywords` to `mkkeywords.sh`.

Cody also made the man page properly formatted for `man(1)` and renamed it the
file `tac.1`.

Cody also renamed `discrepancies` to `discrepancies.html` and made it markdown
format.

Cody also added the [tokcount.sh](%%REPO_URL%%/2018/burton2/tokcount.sh) script which was
included in the remarks of the author but not an included file.

Finally Cody added the [try.sh](%%REPO_URL%%/2018/burton2/try.sh) script.


<div id="2018_ciura">
## Winning entry: [2018/ciura](2018/ciura/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/ciura//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/ciura/try.sh) and
[try.alt.sh](%%REPO_URL%%/2018/ciura/try.alt.sh) scripts and the PDF file,
[lexicon.pdf](2018/ciura/lexicon.pdf), that was a dead link, restored from the
Internet Wayback Machine.


<div id="2018_endoh1">
## Winning entry: [2018/endoh1](2018/endoh1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/endoh1//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/endoh1/try.sh) script which shows the
input files one at a time and after each one is shown, it feeds it to the
program, redirecting the output to the respective GIF file. It then will inform
the user they should open it in a GIF viewer that can show animation in animated
GIF files. It offers an example command for macOS like the judges did in their
remarks. The input files offered includes the `prog.c` as the author,
[Yusuke](#yusuke), suggested that it too has a secret.


<div id="2018_endoh2">
## Winning entry: [2018/endoh2](2018/endoh2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/endoh2//prog.c)
</div>

[Cody](#cody) fixed the [run.sh](%%REPO_URL%%/2018/endoh2/run.sh) script (had commands that didn't
exist and also didn't work even after that was addressed) and added the
[try.sh](%%REPO_URL%%/2018/endoh2/try.sh), [python.sh](%%REPO_URL%%/2018/endoh2/python.sh) and
[python3.sh](%%REPO_URL%%/2018/endoh2/python3.sh) scripts. The `try.sh` script runs all
three of the other scripts but each allows one to send an interrupt in the loops
and still continue to the next script (if one does it when not in a loop it will
exit the script). The `make python` and `make python3` rules in the `Makefile` now
run the respective scripts.


<div id="2018_hou">
## Winning entry: [2018/hou](2018/hou/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/hou//prog.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) for systems that do not do this
(Linux doesn't seem to but macOS does).

Cody also added the [try.sh](%%REPO_URL%%/2018/hou/try.sh) script.


<div id="2018_mills">
## Winning entry: [2018/mills](2018/mills/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/mills//prog.c)
</div>

[Cody](#cody), based on the author's remarks, made it possible to save state
between runs of the program so that one can resume where they left off. It
should be noted that there is a bug in the entry (irrespective of save state
option) where running `./prog` twice in a row involves having to hit (the second
run) enter and then exit and then start the program again. Also if you do add a
file you should run `sync` prior to exiting or else the file might not exist or
it might be corrupt. See [2018/mills in bugs.html](bugs.html#2018_mills) for more
details on the bug.


<div id="2018_poikola">
## Winning entry: [2018/poikola](2018/poikola/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/poikola//prog.c)
</div>

[Cody](#cody) added the missing `docs` rule to the `Makefile` that forms a PDF
file. The rule requires the tool `pdflatex`.

Cody also added the [try.sh](%%REPO_URL%%/2018/poikola/try.sh) script.

[Dave Burton](authors.html#Dave_Burton), during the preview period, noticed a
problem where the macOS `Terminal.app` does not work properly for this program.
We added some additional notes on what might happen (it varies depending on
configuration).


<div id="2018_vokes">
## Winning entry: [2018/vokes](2018/vokes/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/vokes//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/vokes/try.sh) script.


<div id="2018_yang">
## Winning entry: [2018/yang](2018/yang/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2018/yang//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2018/yang/try.sh) script. This script will ask
if the user wants to see some of the deobfuscation information and only show them if they type
`y` or `Y`.



<div id="2019">
# [2019 - The 26th IOCCC](2019/index.html)
</div>


<div id="2019_adamovsky">
## Winning entry: [2019/adamovsky](2019/adamovsky/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/adamovsky//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/adamovsky/try.sh) script and the Unlambda
file [crash.unl](%%REPO_URL%%/2019/adamovsky/crash.unl) which is in the judges' remarks as
to what can crash it - but it's not a bug, it's a feature.


<div id="2019_burton">
## Winning entry: [2019/burton](2019/burton/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/burton//prog.c)
</div>

[Cody](#cody) fixed the `Makefile` which had a bad character, a '%' instead of a '$' which
caused a rule to fail.

Cody also added the [try.sh](%%REPO_URL%%/2019/burton/try.sh) script which shows a
side-by-side comparison on several files of the entry and `wc(1)` as well as
running `make test`.

Cody also fixed the script [check.sh](%%REPO_URL%%/2019/burton/check.sh) (renamed from
`check`) in case `x` is specified and is not executable and also made it satisfy
ShellCheck. He also made ShellCheck not be a cow and/or (to use Bart Simpson's
advice :-) ) `'not have a cow` about certain things (including one thing it was
wrong about) in [cow.sh](%%REPO_URL%%/2019/burton/cow.sh) (which was renamed from `cow`)
<del>moo</del>too.

Cody also renamed the file `on.one.liners` to
[on.one.liners.txt](2019/burton/on.one.liners.txt) to help with
browsers/GitHub.


<div id="2019_ciura">
## Winning entry: [2019/ciura](2019/ciura/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/ciura//prog.c)
</div>

[Cody](#cody) fixed an invalid bytes error in `tr` in the scripts. This does not
mean that they will produce any output, though, as they expect all
letters and that makes it harder to form perfect pangrams. On the subject of
German umlauts and Eszett (ß) see the [2019/ciura in bugs.html](bugs.html#2019_ciura).

Cody also fixed the `Makefile` so that the alternate code would be built when running
`make alt`.

Cody converted the PS file linked to by the author to a PDF,
[fasc5c.pdf](2019/ciura/fasc5c.pdf), and added it to the
website.

Cody also added the [try.sh](%%REPO_URL%%/2019/ciura/try.sh) and
[try.alt.sh](%%REPO_URL%%/2019/ciura/try.alt.sh) scripts.

Finally he added the scripts for the different languages that use the alternate
version but with the caveat that only English appears to work. Again, see [2019/ciura in
bugs.html](bugs.html#2019_ciura) for more details.



<div id="2019_diels-grabsch1">
## Winning entry: [2019/diels-grabsch1](2019/diels-grabsch1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/diels-grabsch1//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/diels-grabsch1/try.sh) script.

Cody also added the file [Shakespeare.txt](2019/diels-grabsch1/Shakespeare.txt)
from [2019/mills](2019/mills/index.html) (after running `make`) so that one can
not worry about having the entire IOCCC winning entry tree (or at least the 2019 tree each
entry in a subdirectory). This was important as we now have tarballs for each
entry by themselves.


<div id="2019_diels-grabsch2">
## Winning entry: [2019/diels-grabsch2](2019/diels-grabsch2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/diels-grabsch2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/diels-grabsch2/try.sh) script. This
script will try and show the difference (i.e. the same output) between the
program and the result of `sha512sum` or `shasum -a 512` if either of those
tools can be found but otherwise it'll just run the program itself, showing its
own sha512sum value.


<div id="2019_dogon">
## Winning entry: [2019/dogon](2019/dogon/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/dogon//prog.c)
</div>

[Cody](#cody) added explicit linking of libm (`-lm`) for systems that do not do this
(Linux does not seem to but macOS does).

He also fixed the `Makefile` so that it compiles with `clang` in Linux.

He also added the [try.sh](%%REPO_URL%%/2019/dogon/try.sh) script.

He also made it possible to easily redefine the memory macro `Z` at compilation
time by improving the `Makefile`.

He fixed a link in the deobfuscation source code. It felt more important
that this was done (some typos were fixed as well but only some - the purpose
was to only correct spelling and only some, not to change wording or anything
else).


<div id="2019_duble">
## Winning entry: [2019/duble](2019/duble/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/duble//prog.c)
</div>

[Cody](#cody) made the `make fullscreen` more portable by not relying on
`stty(1)` and `sed(1)` but rather it just uses `tput(1)`. He also made it so
that if `tput(1)` is not found it tells the user an easier way to compile the full
screen size rather than having to modify the `Makefile`. This is done with a script,
[fullscreen.sh](%%REPO_URL%%/2019/duble/fullscreen.sh), to simplify the `Makefile` and provide
an easy way to tell the user how to compile it, assuming that the environmental
variables `LINES` and `COLUMNS` are set. But even if they're not set it explains
how to easily compile the program to a specific size. Note that `LINES` and
`COLUMNS` is not available to scripts so it can't make use of them that way.


<div id="2019_endoh">
## Winning entry: [2019/endoh](2019/endoh/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/endoh//prog.c)
</div>

As this is a backtrace quine having the optimiser enabled is not a good idea so
[Cody](#cody) disabled it. For this same reason he also added the `-g` flag to the
compilation as debugging symbols might just be useful for an entry that's
supposed to segfault (and which you're supposed to inspect the core file) :-)

Cody also added the simple [ascii.c](%%REPO_URL%%/2019/endoh/ascii.c) that (while it has an
arg) prints out the character of the ASCII value (uses `isascii(3)` first). This
combined with the [try.sh](%%REPO_URL%%/2019/endoh/try.sh) script that he added allows one
to easily reconstruct the source code through GDB by the fact it's a backtrace
quine.


<div id="2019_giles">
## Winning entry: [2019/giles](2019/giles/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/giles//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/giles/try.sh) script.


<div id="2019_karns">
## Winning entry: [2019/karns](2019/karns/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/karns//prog.c)
</div>

[Cody](#cody) forced the `Makefile` to use `-O0` as he discovered that an
optimiser level > 0 causes a segfault (sometimes?). (Perhaps this is the problem
that the author reported where it sometimes segfaults but Cody did not try
debugging it since it works with `-O0`.)

He also added the script [try.sh](%%REPO_URL%%/2019/karns/try.sh) to showcase the entry a
bit more easily.


<div id="2019_lynn">
## Winning entry: [2019/lynn](2019/lynn/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/lynn//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/lynn/try.sh) script.

Cody also added the [example-1.txt](2019/lynn/example-1.txt) and
[example-2.txt](2019/lynn/example-2.txt) text files from
[2018/vokes](2018/vokes/index.html) so that the entry does not rely on any other
entry existing.


<div id="2019_mills">
## Winning entry: [2019/mills](2019/mills/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/mills//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/mills/try.sh) script.


<div id="2019_poikola">
## Winning entry: [2019/poikola](2019/poikola/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/poikola//prog.c)
</div>

[Cody](#cody) added the missing `docs` rule to the `Makefile` that forms a PDF
file. The rule requires the tool
[pdflatex](https://tug.org/applications/pdftex/index.html).

Cody also added the [alternate code](%%REPO_URL%%/2019/poikola/prog.alt.c) which
adds a newline after each number for parsing in additional ways.

Cody also added the [try.sh](%%REPO_URL%%/2019/poikola/try.sh) and
[try.alt.sh](%%REPO_URL%%/2019/poikola/try.alt.sh) scripts.

Cody also disabled the optimiser because the author stated that for `clang` the
levels `[0123s]` work okay but with `GCC` version 6 they only said level 0 works,
suggesting that with some versions of `GCC` it might not be correct with levels !=
0 and since 0 works with `clang` that's okay. Similarly, the same for C standards
tested: `gnu17` was not tested but `gnu11` was so the standard was set to
`gnu11`.


<div id="2019_yang">
## Winning entry: [2019/yang](2019/yang/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2019/yang//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2019/yang/try.sh) script which also involved
slightly updating the [sample_input.txt](2019/yang/sample_input.txt) file
(removed trailing newlines as it resulted in `diff` showing differences when it
shouldn't) and adding the [ioccc.txt](2019/yang/ioccc.txt) file.


<div id="2020">
# [2020 - The 27th IOCCC](2020/index.html)
</div>


<div id="2020_burton">
## Winning entry: [2020/burton](2020/burton/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/burton//prog.c)
</div>

[Cody](#cody) fixed the script [check_be.sh](%%REPO_URL%%/2020/burton/check_be.sh): it
assumed that `prog_be` was in `PATH` which is unlikely so it was changed to
`./prog_be`.

Cody also improved the `make test` rule (which uses `check_be.sh` and the Little
Endian counterpart) so that it shows that the files are identical rather than
showing nothing at all.

Cody also added the [try.sh](%%REPO_URL%%/2020/burton/try.sh) script.


<div id="2020_carlini">
## Winning entry: [2020/carlini](2020/carlini/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/carlini//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/carlini/try.sh) script which although at
first glance might not appear to have a point, it actually does, namely showing
how you can automate play and then reminding you to actually play for real, with
a friend, whether that's real or imagined.


<div id="2020_endoh2">
## Winning entry: [2020/endoh2](2020/endoh2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/endoh2//prog.c)
</div>

[Cody](#cody) copied the files from the `spoiler.zip` file (from his copy during
the preview period) that was password protected with a password that was no
longer known (but fortunately was already extracted).

He also added the [try.sh](%%REPO_URL%%/2020/endoh2/try.sh) script.


<div id="2020_endoh3">
## Winning entry: [2020/endoh3](2020/endoh3/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/endoh3//prog.c)
</div>

[Cody](#cody) fixed the script [run_clock.sh](%%REPO_URL%%/2020/endoh3/run_clock.sh) which gave a
funny error when running it:

``` <!---sh-->
    $ ./run_clock.sh
    -bash: ./run_clock.sh: cannot execute: required file not found
```

If run from within vim a different error message occurred:

```
    /bin/bash: ./run_clock.sh: /usr/bin/end: bad interpreter: No such file or directory
```

though this was only noticed later on after it was fixed.

What was wrong? A typo in the shebang which had `/usr/bin/end` instead of
`/usr/bin/env`.

Also if `clock` did not exist and one tried to run the script it would make an
invalid `clock.c` which meant it could not compile so it now runs `make clock`
first.

Cody also reported (during the preview period of 2020) for some systems (at some
point?) like macOS the use of `make clock` would not work due possibly to a
timing issue so [Yusuke](#yusuke) changed it to compile `clock.c`
file directly (this might have been fixed in the
`Makefile` later on but it doesn't hurt to keep it in and this way it isn't a
problem in any system).

Cody also added the [run_clock.alt.sh](%%REPO_URL%%/2020/endoh3/run_clock.alt.sh) script
which is analogous to the [run_clock.sh](%%REPO_URL%%/2020/endoh3/run_clock.sh) but for the
alternate code provided by the author, Yusuke.


<div id="2020_ferguson1">
## Winning entry: [2020/ferguson1](2020/ferguson1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/ferguson1//prog.c)
</div>

Just for awareness, here: [Cody](#cody) made some corrections to the vital [Double
layered chocolate fudge cake recipe](2020/ferguson1/chocolate-cake.html) :-)
Other fixes were made but as it's his entry it's not worth noting.


<div id="2020_giles">
## Winning entry: [2020/giles](2020/giles/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/giles//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/giles/try.sh) script. This script does
the conversion of `pi.wav` (showing the digits) and also converts the number for
`jenny.wav` and a number Cody 'came up with': one that resembles `IOCCC 28`:
`10666-28`. The `6` is the closest to `C` in his head even though it's not
perfect.

If `play(1)` from SoX is not installed the script checks for `aplay(1)`. If
neither are installed it warns the user about this, linking to the FAQ about it,
and tells them they will have to play the WAV files manually. Otherwise it'll
use the program to play the WAV files (and in one case `stdout`).


<div id="2020_kurdyukov1">
## Winning entry: [2020/kurdyukov1](2020/kurdyukov1/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/kurdyukov1//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/kurdyukov1/try.sh) script.


<div id="2020_kurdyukov2">
## Winning entry: [2020/kurdyukov2](2020/kurdyukov2/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/kurdyukov2//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/kurdyukov2/try.sh) script.

Cody also added `-L`/`-I` paths to the `Makefile` to let this compile more easily if
the user has installed the appropriate library with
[MacPorts](https://www.macports.org) (with the default MacPorts prefix
`/opt/local`).

Cody also fixed the script [makegif.sh](%%REPO_URL%%/2020/kurdyukov2/makegif.sh) in a variety
of ways: `shellcheck(1)`, make sure the program is compiled first (allowing one to
specify which compiler to use with `CC=foo ./makegif.sh ...`), checking that
`convert(1)` is found and that it worked properly (linking to the proper FAQ
entry if not installed or it fails).


<div id="2020_kurdyukov3">
## Winning entry: [2020/kurdyukov3](2020/kurdyukov3/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/kurdyukov3//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/kurdyukov3/try.sh) script.

He also added a link that has much more details about this phenomenon to the
index.html. Naturally he's one of the ones who can read text even if it's even
more jumbled but we know of others too.


<div id="2020_kurdyukov4">
## Winning entry: [2020/kurdyukov4](2020/kurdyukov4/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/kurdyukov4//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/kurdyukov4/try.sh) script.

Cody also added from [2019/mills](2019/mills/index.html) the text file
[Shakespeare.txt](2020/kurdyukov4/Shakespeare.txt) as we now provide a tarball
of each entry by itself.

Also, as a fellow Tolkienist, to explain the confusing (to most people) award
title, Cody gave a quick translation of `lámatyávë`, which comes from [Morgoth's
Ring](https://en.wikipedia.org/wiki/Morgoth%27s_Ring), volume X of the 12
volume [History of
Middle-earth](https://en.wikipedia.org/wiki/The_History_of_Middle-earth) (known
to us Tolkienists as `HoMe`), which he naturally :-) has, by the late and great
[Christopher Tolkien](https://en.wikipedia.org/wiki/Christopher_Tolkien), son
and literary executor and heir to [J.R.R.
Tolkien](https://www.tolkienestate.com/life/biography/).


<div id="2020_otterness">
## Winning entry: [2020/otterness](2020/otterness/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/otterness//prog.c)
</div>


[Cody](#cody) added the MIDI files [cvikl.mid](2020/otterness/cvikl.mid) and
[entertainer.mid](2020/otterness/entertainer.mid) from the URLs we suggested so
that one need not download them and to make sure they can always be obtained
even if the domain or link goes dead.

Cody also added the [try.sh](%%REPO_URL%%/2020/otterness/try.sh) script.


<div id="2020_tsoj">
## Winning entry: [2020/tsoj](2020/tsoj/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/tsoj//prog.c)
</div>

[Cody](#cody) added [alternate code](2020/tsoj/index.html#alternate-code) that will feel
more at home for vi users. One might still end up cursing (see the index.html
file) but probably a lot less :-)


<div id="2020_yang">
## Winning entry: [2020/yang](2020/yang/index.html)
### Winning entry source code: [prog.c](%%REPO_URL%%/2020/yang//prog.c)
</div>

[Cody](#cody) added the [try.sh](%%REPO_URL%%/2020/yang/try.sh) script.

Cody also added a make rule (`make cppp`) for the author's provided C++ code
that can preprocess the generated output to make them more acceptable to typical
compilers. See the index.html for more details.



<div id="general_thanks">
# General thanks
</div>


<div id="makefiles_fixes_improvements">
## Makefiles fixes and improvements
</div>

[Cody](#cody) fixed the top level `Makefile` `all` rule which had a stray `fi;`
without an `if` so the rule failed entirely.

Cody also made a variety of other changes in all the Makefiles, sometimes to get
an entry to work, all noted above, but he also **improved them all** in at least
one or two ways. Some of the changes made are below.

Cody changed the `LIBS` variable to `LDFLAGS` as that is the standard
variable. This simplifies compiling without having to modify the `Makefile` which
can be useful if something changes or if someone is trying to fix an entry but
forgets to change the `Makefile` or even if they don't want to make a change due
to a temporary test. These would of course depend on the compiler invocation but
since `LDFLAGS` is standard it is more likely to be used by default so no need
to check the Makefiles.

Sometimes there were bad characters or rules that caused the entry to fail to
compile or not work in some way. These are noted above as well.

Where useful he added some notes to the Makefiles during compilation to let one
know of certain problems or features that matter for instance having to disable
the optimiser or in one case enabling `-g`.

Also, rather than check `$(CC)` for exact matches of `gcc` or `clang` it now is
that if `$(CC)` contains `gcc` or contains `clang` then the specific actions
related to the specific compiler will be done (priority is `gcc` then `clang`). This
is useful because it's not guaranteed that the compiler names for `gcc` or
`clang` will be exactly that; in macOS for instance it can happen that they are
in fact different names especially if one installs them from something like
[MacPorts](https://www.macports.org) or possibly [Homebrew](https://brew.sh).

There were some other fixes as well including mass typo fixes in the Makefiles
(though that usually does not mean it is worth a thank you note it might be
worth noting in this case). Other times it was enabling or disabling the
optimiser to fix an entry, sometimes causing other problems that also had to be
fixed, a good example being [1986/marshall](#1986_marshall) (see the
[compilers.html](1986/marshall/compilers.html) for the amusing details and all that
had to be done to fix it).

There was a 'problem' where `${MAKE}` was `$(MAKE)`: this doesn't break anything
but it is inconsistent with the rest of the `${foo}` tools even if by tradition
it is `$(MAKE)`.

Cody also added missing variables like `BASH` and `PDFLATEX` to the
[var.mk](%%REPO_URL%%/var.mk) file and removed another that was deemed problematic or
undesired. Other variable names had typos in them.

In at least one case, like the [top level Makefile](%%REPO_URL%%/Makefile), where raw
commands that are in [var.mk](%%REPO_URL%%/var.mk) were used, Cody updated them to use the
variables.

A comment was missing for the `diff_alt_orig` rule in all the Makefiles and
this, along with many other fixes and changes to the Makefiles were made by
Cody's [sgit tool](https://github.com/xexyl/sgit) but many other changes he did
manually.


<div id="consistency_improvements">
## Consistency improvements
</div>

[Cody](#cody), being the IOCCC's resident corrections officer :-) (and a fine one at
that, we think :-) ), made many, many typ0 (... :-) ) fixes throughout the
README.md files, scripts, other data files, Makefiles (see above) etc.

He also updated the formatting of the README.md files, used to generate the
index.html files, after renaming the old files to README.md, as well as changing
some other files to markdown as well as format fixing them.

Where possible he made the presentation of the entries much more consistent
across the entries of all the years as well as other files. This is not possible
for everything (the remarks of authors, for instance, cannot be and should not
be made consistent but adding markdown where necessary in the remarks is).

Some of these fixes were done with his [sgit
tool](https://github.com/xexyl/sgit) as well but the vast majority were done
manually.


<div id="manifest_improvements">
## Manifest improvements
</div>

[Cody](#cody) greatly improved the manifest of the winning entries so that the
links to the files in the index.html files make sense and are consistent,
although some might not make as much sense unless one looks into the entry.


<div id="thank_you_honor_roll">
## Thank you honor roll
</div>

There are a number of people who have contributed to **many many
changes**, fixes and **many important improvements** that we
wish to **especially thank**.


<div id="authors">
### Authors
</div>

A good number of the [winning entries of the
IOCCC](authors.html) tested, identified and helped correct
and/or improve the write-ups of fellow IOCCC entries for the year that they won.
The list of those entries is too long to mention: nevertheless the [IOCCC
judges](judges.html) **VERY MUCH APPRECIATE** those who
helped improve the presentation of their fellow IOCCC entries.


<div id="cody">
### Cody Boone Ferguson
</div>

We call out the extensive contributions of [Cody Boone
Ferguson](authors.html#Cody_Boone_Ferguson) who is responsible for most of the
improvements and fixes including many **EXTREMELY HARD bug fixes** (for certain
definitions of **_HARD_** :-) ) like
[1988/phillipps](thanks-for-help.html#1988_phillipps),
[1992/vern](thanks-for-help.html#1992_vern),
[2001/anonymous](thanks-for-help.html#2001_anonymous),
[2004/burley](thanks-for-help.html#2004_burley) and
[2005/giljade](thanks-for-help.html#2005_giljade), making all entries such as
[1985/sicherman](thanks-for-help.html#1985_sicherman) and
[1986/wall](thanks-for-help.html#1986_wall) not need `-traditional-cpp` (all
**EXTREMELY HARD**), fixing entries to work with `clang`, some **EXTREMELY
HARD** like [1991/dds](thanks-for-help.html#1991_dds), or as much as possible
([1989/westley](thanks-for-help.html#1989_westley), a true masterpiece that is
**INCREDIBLY HARD, *MUCH MORE SO* than any other fix!**), porting entries to
macOS (some **EXTREMELY HARD** like
[1998/schweikh1](thanks-for-help.html#1998_schweikh1), fixing code like
[2001/herrmann2](thanks-for-help.html#2001_herrmann2) to work in both
32-bit/64-bit which *can be* **EXTREMELY HARD**, providing alternate code where
useful/necessary, improving **ALL _Makefiles_** and writing scripts to greatly
simplify running many of the entries.

He also wrote [sgit](https://github.com/xexyl/sgit) to easily run
`sed(1)` on files in the repo which we used to help build the website.

Cody Boone Ferguson also used one of his own tools to detect many dead links.
While the tool was not perfect it went a long way to uncover a good number of
bad, broken or otherwise invalid links. It was a very laborious task to copy
and paste problematic links into the [Internet Wayback
Machine](https://web.archive.org) in an effort to try and find otherwise lost
content. A good number of links that now refer to something in the [Internet
Wayback Machine](https://web.archive.org) replace bad, broken, or otherwise
invalid links are thanks to Cody's efforts! Another tool he wrote detected
inconsistent award titles in the README files and CSV file (that he generated
from the SQL file).

Additionally Cody greatly improved the manifest of the winning entries and
checked that the generated html files, index.html and otherwise, look well and
presentable and suggested some CSS rules for image responsiveness on smaller
screens and other improvements.

**THANK YOU VERY MUCH** for your extensive efforts in helping improve the IOCCC
presentation of past IOCCC entries and fixing almost all past entries for modern
systems!


<div id="yusuke">
### Yusuke Endoh
</div>

[Yusuke Endoh](authors.html#Yusuke_Endoh) supplied a
number of important bug fixes to a number of past IOCCC entries. Some of those
fixes were **EXTREMELY TECHNICALLY CHALLENGING** such as
[1989/robison](thanks-for-help.html#1989_robison),
[1990/cmills](thanks-for-help.html#1990_cmills),
[1992/lush](thanks-for-help.html#1992_lush) and
[2001/ctk](thanks-for-help.html#2001_ctk). **THANK YOU VERY MUCH** for
your help!


<div id="neglect">
## Did we neglect to credit you?
</div>

If you submitted a fix to an entry for which you are not the author,
and your fix is accepted (in part or as a whole), we would be happy
to add you to this [thanks for the help](thanks-for-help.html) file.

If you believe we incorporated one of your fixes to an IOCCC winning entry (that you
are not the author of) for which we neglected to mention in this file, please
[contact the IOCCC](contact.html) so that we may correct the record.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
