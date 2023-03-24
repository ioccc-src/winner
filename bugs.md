# BUGS and (mis)FEATURES


There are a number of known problems with IOCCC winners: many of
which have to do with differences between today's compiler environments
and those of today. In some cases the original code has a bug, some
of which were recently discovered. In some cases attempt to port
older code to more modern environments introduced bugs.

The following is a known list of **BUGS and (mis)FEATURES** in IOCCC winners.

Can you fix/improve them? You are **VERY WELCOME** to try.
Please submit your fixes fix in a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) with one pull
request per fix, please!

We will be happy to credit those who submit successful [GitHub pull
requests](https://github.com/ioccc-src/temp-test-ioccc/pulls) in the entry's
_README.md_ file. If you're a previous winner we will add a link to your winning
entries in the file (if you're not we can add a link to your personal website if
you have one if you like).

# List of Statuses - Please read before fixing (you may skip if you're only interested in entries with known issues)

Entries below have one of the following _Status_ values.

Please see the text below for more information.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has been working on
resolving these issues and has fixed many but you're welcome to have a go at it
too (though he'll be very sad if he doesn't have a chance at it first :-( so you
might want to hold off for now :-) .. or not :-) ). He hopes to have most of the
remaining entries resolved in the near future but nevertheless if you're okay
making people very sad you may have a go at the entries :-) He'll remove this
part later on.

### Status: known bug - please help us fix

This entry has a bug that needs fixing. Are you able to fix it?

We welcome your help! Please submit a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls)
and we will be happy to credit you in the entry's _README.md_ file.

### Status: main() function args not allowed - please help us fix

This entry has a problem in that the args to main() are not of a specific type
due this being allowed in earlier C. This shows itself in some compilers like
clang. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) looked at the
source code of clang and reported that there is no way to override this
requirement so these entries will fail to compile with clang. That's why he in
some entries he fixed he did it by adding a function called `pain()`. :-)

Note for macOS users: please be aware that gcc under macOS is clang despite the
fact it might appear to be gcc: no symlink and both gcc and clang exist but the
gcc is clang which you'll see if you run `gcc --version`.

A tip and some fix methods from Cody: in the older days args to main() not given
a type were implicit ints but when they're required to be char ** this can cause
a problem. In some cases Cody was able to use a char * inside main() (see
[1989/tromp/tromp.c](1989/tromp/tromp.c) and
[1986/holloway/holloway.c](1986/holloway) for two examples though done slightly
differently). In other cases he was able to dereference the pointers to be used
like an int. He used other various techniques to get them to compile. In some
cases this introduced a problem but typically if not always that problem exists
with compilers that are less strict.

Request: For one-liners please keep the file one line if at all possible! If it
needs an include you can update the Makefile `CINCLUDE` variable. For instance
if it needs `stdio.h` you could do `-include stdio.h`. Please leave a space
after the `=` in the Makefile!

We welcome your help! Please submit a [GitHub pull
request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we will be
happy to credit you in the entry's _README.md_ file.

### Status: Compiled executable crashes - please help us fix

While the entry can compile, the resulting executable sometimes or always crashes.

We welcome your help! Please submit a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls)
and we will be happy to credit you in the entry's _README.md_ file.

### Status: Requires a compiler supporting -traditional-cpp - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc` supports this
but `clang` does not.

Please be advised that, as noted above, gcc under macOS is actually gcc even if it
looks like it's gcc (the programs are the same, they're not symlinks but both
are clang).

If you do wish to provide an alternate version of the program that does not need
compiler supporting -traditional-cpp you are welcome to summit such code via a
[GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we
will be happy to credit you in the entry's _README.md_ file.

### Status: INABIAF - please do not fix

INABIAF: It's not a bug it's a feature :-)

The following entries should NOT be touched: they are system specific by design
but are noteworthy nonetheless.

# 1984


## [1984/decot](1984/decot/decot.c) ([README.md](1984/decot/README.md))

### Status: Requires a compiler supporting -traditional-cpp - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need compiler supporting -traditional-cpp
you are summit such code via a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls)
and we will be happy to credit you in the entry's _README.md_ file.


## [1984/mullender](1984/mullender/mullender.c) ([README.md](1984/mullender/README.md))

### Status: Compiled executable crashes - please help us fix


This entry is likely to fail and/or dump core on any computer other than a
Vax-11 or pdp-11. In 1984 machine dependent code was allowed.

To see this entry in action check out [Yusuke
Endoh](/winners.html#Yusuke_Endoh)'s [2015/endoh3](2015/endoh3) entry. Otherwise
a Vax-11 or pdp-11 emulator would be necessary.

NOTE: if you do change this please make sure to put it in `mullender.alt.c`!


# 1985


## [1985/sicherman](1985/sicherman/sicherman.c) ([README.md](1985/sicherman/README.md))

### Status: Requires a compiler supporting -traditional-cpp - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need
compiler supporting -traditional-cpp we welcome you to summit such code via a
[GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls) and we
will be happy to credit you in the entry's _README.md_ file.


# 1986


## [1986/august](1986/august/august.c) ([README.md](1986/august/README.md))

### Status: INABIAF - please do not fix

This entry is known to segfault after printing its output. It was documented by
the judges and needn't be fixed.


## [1986/holloway](1986/holloway/holloway.c) ([README.md](1986/holloway/README.md))

### Status: INABIAF - please do not fix

When compiling this entry you might get an incompatible pointer type warning but
this should be ignored. When [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this he experimented with the
alternatives and it did not work. Thus if you see something like:

```c
[holloway.c:15:11: warning: incompatible pointer types initializing 'char *' with an expression of type 'char **'; dereference with * [-Wincompatible-pointer-types]
    char *t = s;
          ^   ~
              *
```

it is NOT a problem and should not be changed. Changing it will either crash it
or make it not work.


## [1986/wall/wall.c](1986/wall/wall.c) ([README.md](1986/wall/README.md))

### Status: Requires a compiler supporting -traditional-cpp - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need compiler supporting -traditional-cpp
you are summit such code via a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls)
and we will be happy to credit you in the entry's _README.md_ file.



# 1987


# 1988


## [1988/dale](1988/dale/dale.c) ([README.md](1988/dale/README.md))

### Status: Requires a compiler supporting -traditional-cpp - alternate code requested

This entry needs a compiler that support `-traditional-cpp`. `gcc`
supports this but `clang` does not. Please be advised that `gcc` under macOS is
actually gcc if it looks like it's gcc (two different binaries).

If you do wish to provide an alternate version of the program that does not need compiler supporting -traditional-cpp
you are summit such code via a [GitHub pull request](https://github.com/ioccc-src/temp-test-ioccc/pulls)
and we will be happy to credit you in the entry's _README.md_ file.


# 1989


## [1989/westley](1989/westley/westley.c) ([README.md](1989/westley/README.md))

### Status: main() function args not allowed - please help us fix

Although [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for
some of the versions that are generated (see below tip) it will not work for
all. He noted that trying to fix it in some cases causes a segfault and in other
cases it fails to generate some of the files (others are okay) at all (empty
files).

He gives a tip on the problem: main() requires the second, third and fourth arg
to be a `char **`. This didn't use to be the case and some compilers like gcc
don't complain. He was able to get `main()` to be correct BUT a feature is that
it uses ROT13 to decrypt the function `znva` to be main in generated files.
Since that function does not have the correct types when converted to main() it
fails to compile. But as he said changing the type causes either a segfault or
files not generated at all. `ver1`, `ver2` and `ver3` are the problematic ones.
The segfault happens when running the main program.


# 1990


## [1990/jaw](1990/jaw/jaw.c) ([README.md](1990/jaw/README.md))

### Status: INABIAF - please do not fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed the scripts to
work in modern systems. He notes however that the command in the try section,
the one to test the official C entry, appears to not work with macOS, giving:


```sh
$ echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
oops: Undefined error: 0
oops: Undefined error: 0
```

However this is because the entry uses `perror()` and it just so happens that
the default `errno` gives that result. For instance if you run the following C
program under macOS you will get undefined error but if you do it under linux
you'll likely get success.


```c
#include <stdio.h>
#include <errno.h>
#include <string.h>
int main()
{
    errno = 0;
    printf("%d, %s\n", errno, strerror(errno));
}
```

In fact the condition which is in the `a()` function on line 18 of the entry
namely:

	I k>16)

is true on both linux and macOS, with `k` being equal to 22.

Should the entry use `perror()`? Perhaps not but we're not sure of its purpose
so it can stay for now with this note.


# 1991


# 1992


# 1993


# 1994


# 1995


## [1995/cdua](1995/cdua/cdua.c) ([README.md](1995/cdua/README.md))

### Status: known bug - please help us fix

This did not originally compile under macOS and after it did compile under macOS, it crashed.
[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this but he
observed that sometimes the program asks the user to hit return a second time to
resume solving the maze. It does not always happen. It doesn't seem to be
related to making it work under macOS as all that did was removing some invalid
prototypes and use `printf()` instead of the invalid pointer to it (incompatible
type).


# 1996


# 1998

## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md))

### Status: INABIAF - please do not fix

If you get the compiler warning:

	warning: incompatible implicit declaration of built-in function 'printf' [-Wbuiltin-declaration-mismatch]
	   11 | void  g(){ O=j; printf(_); }
	      |                 ^~~~~~


please do NOT change it! Doing so will break the generated output.

It does not currently work under macOS. This will be investigated in the near
future.

# 2000


# 2001


## [2001/anonymous](2001/anonymous/anonymous.c) ([README.md](2001/anonymous/README.md))

### Status: known bug - please help us fix

This entry seems to no longer work and we would appreciate any help from anyone
who can fix this. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) has
the following hints that might help but he has no system where he could test
it. [Yusuke Endoh](/winners.html#Yusuke_Endoh) [wrote a little bit about
it](https://mame-github-io.translate.goog/ioccc-ja-spoilers/2001/anonymous.html?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp) that
might or might not help but he too could not get it to work.

Tips from Cody:

- Try a beautifier on the original C code.
- Use cpp to make the functions easier to parse. For instance if you're in the
directory try `cpp -E anonymous.cp > anonymous.cpp` and look at that file to see
the functions. It might or might not be helpful to use cpp on the beautified
source.
- After beautifying it try changing references of the macros (where not too
complicated) to their definitions. For instance in vim you might do:
`:%s/\<l\>/int */g` and then delete the line that was changed to `#define int *
int*` (or else do a range substitute so it's not changed). You might not need
this if you use the cpp. This might be useful anyway to more easily test things.
- If your system has a `setarch` tool that might or might not be of help (I'm
not too familiar with its internals).
- The code appears to do everything from one call to `exit(3)` but it makes use
of the ternary operator and possibly the comma operator.
- Check the Makefile for the defines but also observe that those are in the
source file. It appears that the entry might try compiling as well but that's
from a quick glance.
- The original main() started like: `main (char *ck, char **k)` but we made it
compilable for clang by changing it to be: `main (int cka, char **k) { char *ck
= (char *)cka;` which might or might not be good.
- The author warns that only simple source (once compiled) would work so make
use of the provided source file
[2001/anonymous/anonymous.ten.c](2001/anonymous/anonymous.ten.c). To compile try
`make anonymous.ten` from the entry directory which you can then run the entry
on. Note that it needs to be compiled as a x86 program.
- The program will to an extent destroy files it is used on. See the author's
warning in their comments on that.


# 2004


## [2004/burley](2004/burley/burley.c) ([README.md](2004/burley/README.md))

### Status: known bug - please help us fix

This entry did not compile with clang but [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this problem. He notes however that
prior to (with gcc) and after the fix (gcc, clang) it does not work: it allows
input of the bet and then it prints the hand but it does not do anything with
your next move. He provides the following notes:

0. Originally the `jmp_buf` was just an `int p[4][1000]`.
1. The `setjmp.h` header file was not included so the calls to `longjmp()` had
not only the wrong number of arguments but also implicitly returned int when it
actually returns void. This means that the comma operator had to be used to get
the binary expressions to work. It might be this is part of the problem.
2. Another possible problem is the abuse of `setjmp()` and `longjmp()` which is
known to be a problem, at least as he interprets it in his tired head (and less
experience with `longjmp`). In particular:
> The longjmp() routines may not be called after the routine which called the
> setjmp() routines returns.
3. The main() originally returned a call to main() which appeared to be an
infinite recursion at least as it was; now it returns a call to poke() which has
the same number and type of args (1, `char *`) that main() had. This appears to
not be an infinite recursion but I might be reading it wrong. Changing it to not
return itself and the same problem occurs so perhaps this is not the problem.
4. As well main() had only one arg, a `char *`, and there was a (seemingly)
needless cast to `char *` from gets(). This cast remains in the code however.
5. The code no longer uses `gets()` but `fgets()`; this is not the problem
however.


## [2004/gavin](2004/gavin/gavin.c) ([README.md](2004/gavin//README.md))

### Status: Compiled executable crashes - please help us fix


Segmentation fault will occur in some systems. For instance on macOS with the
arm64 chip:

```sh
./gavin > kernel
```

When trying to link `gavin.o` to produce `sh`, the linker generates:

```
Undefined symbols for architecture arm64:
  "start", referenced from:
     -u command line option
     (maybe you meant: __start)
ld: symbol(s) not found for architecture arm64
```


#### Recent 2004/gavin mods:

Although not related some recent changes were made to 2004/gavin to let it
compile under clang. The following patch was applied:

```patch
diff --git a/2004/gavin/gavin.c b/2004/gavin/gavin.c
index c967b7e..2082b49 100644
--- a/2004/gavin/gavin.c
+++ b/2004/gavin/gavin.c
@@ -1,8 +1,9 @@
+int main(int t, char **q, char **d) { return cain(t, (int)q, (int)d); }
 #define G(n) int n(int t, int q, int d)
 #define X(p,t,s) (p>=t&&p<(t+s)&&(p-(t)&1023)<(s&1023))
 #define U(m) *((signed char *)(m))
 #define F if(!--q){
-#define I(s) (int)main-(int)s
+#define I(s) (int)cain-(int)s
 #define P(s,c,k) for(h=0; h>>14==0; h+=129)Y(16*c+h/1024+Y(V+36))&128>>(h&7)?U(s+(h&15367))=k:k

 G (B)
@@ -52,7 +53,7 @@ else

 G (_);
 G (o);
-G (main)
+G (cain)
 {
   Z, k = K;
   if (!t)
``

The original Makefile from 2004 had the following to say about this entry:

```make
# Special flags for the gavin entry
#
# FYI: Older versions of GCC have a bug in -O2 optimization, hence -O1
#
GAVIN_OPT= -O1
GAVIN_FLAGS=\
        '-DY(m)=*((int*)(m))'\
        '-DE(f,a,b,c)=((G((*)))(f))(a,b,c)'\
        '-DM=for(D=0;D<786432;D++)'\
        '-DZ=int i=0,j=0,h,n,p=393728,s=26739,C,D'\
        '-DV=0x90200'\
        '-DK=0'\
        '-DR=while((C=E(V-8,100,0,0))&3&&(D=E(V-8,96,0,0))|3){'\
        '-DL(c,d)=E(V+8,100,c,0);R}E(V+8,96,d,0);R}'

# ...

# Best of Show
#
gavin: gavin.c
        ${CC} ${GAVIN_OPT} -o gavin ${GAVIN_FLAGS} gavin.c
        ${RM} -f kernel
        ./gavin > kernel
        ${CC} ${GAVIN_OPT} -c ${GAVIN_FLAGS} -DB=_start '-Dputchar(a)=' gavin.c
        ${RM} -f sh
        ${LD} -s -o sh gavin.o
        ${RM} -f vi
        ${CP} sh vi
        ${RM} -f fs.tar
        ${TAR} -cvf fs.tar sh vi gavin.c gavin.hint prim

gavin_clean:
        ${RM} -f sh vi kernel gavin.o

gavin_clobber: gavin_clean
        ${RM} -f gavin fs.tar

gavin_files: boot.b lilo.conf prim gavin_install.txt
```

The current ([Makefile](2004/gavin/Makefile) was modified to try and
fit into the current IOCCC build environment.


# 2005


## [2005/giljade](2005/giljade/giljade.c) ([README.md](2005/giljade/README.md))

### Status: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) noted that this
requires both 32-bit CPUs (data size?) and also cannot have optimiser enabled.
It might be that it can be fixed, perhaps by changing the int sizes and bitwise
operations, but if not this will not work with some systems like modern Macs as
Apple has made it hard to compile 32-bit applications.


## [2005/mynx](2005/mynx/mynx.c) ([README.md](2005/mynx/README.md))

### Status: INABIAF - please do not fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) notes that, though
probably obvious, this entry will not work with https. He changed the code to
scan for https too (it exited before) in case someone comes up with a clever
command line to make it work but the problem is a secure connection has to first
be set up in order to give http commands. This is not a bug but it's worth
pointing out as it won't work on as many websites as it used to including the
[IOCCC website](https://www.ioccc.org) itself.


# 2006


# 2011


# 2012


# 2013


# 2014


## [2014/vik](2014/vik/prog.c) ([README.md](2014/vik/README.md))

### Status: known bug - please help us fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) discovered a bug that
shows itself in some cases (it works in others) when working on his [2020 Enigma
machine](2020/ferguson2/prog.c) entry. See his
[README.md](2020/ferguson2/README.md) for details (search for `vik` in the
file).

He provides a tip in testing the problem: it might help to use the Enigma
machine to find problems as it will allow you to verify what is correct and what
is not. Again see his README.md for details.


# 2015


# 2018


# 2019


## [2019/endoh](2019/endoh/prog.c) ([README.md](2019/endoh/README.md))

### Status: INABIAF - please do not fix

As a backtrace quine this entry is SUPPOSED to segfault so this should not be
touched either.


# 2020


## [2020/ferguson1](2020/ferguson1/prog.c) ([README.md](2020/ferguson1/README.md))

### Status: INABIAF - please do not fix

There are some things that might appear to be bugs but are actually features or
things that are misinterpreted as bugs. See his
[bugs.md](2020/ferguson1/bugs.md) and
[troubleshooting.md](2020/ferguson1/troubleshooting.md) files for details.



