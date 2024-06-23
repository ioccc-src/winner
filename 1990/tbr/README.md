## To build:

``` <!---sh-->
    make all
```

The authors provided another version of this program. See the [alternate
version](#alternate-code) section below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [1990/tbr in bugs.html](../../bugs.html#1990_tbr).


### A note about the fixes of this entry in 2023:

In 2023 it was noticed that in some systems like macOS there was confusing
output due to a warning at runtime that was interspersed with the output of the
program. For instance it would show:

``` <!---sh-->
    ./tbr
    $ warning: this program uses gets(), which is unsafe.
```

which kind of hid the prompt. Thus the entry was changed to use `fgets(3)` which
is referred to later in this file.

Also `exit(3)` returns `void` but the entry was using it in a binary expression so
this entry would not compile in modern systems. This fix is also referred to
below, in the [alternate version](#alternate-code) section.


## To use:

``` <!---sh-->
    ./tbr
    $ enter some shell commands
```

NOTE: globs do not work with this entry. Why?

NOTE: `exit` does not work and neither does `logout`. To exit try sending ctrl-d
or ctrl-c (or kill it from another terminal :-) ). But why does it not work with
just `exit` or `logout`? Hint: see the authors' remarks.


## Try:

``` <!---sh-->
    ./tbr
    $ ls -l tbr tbr.c

    # notice how the following does not work:
    ls tbr*

    # try figuring out how this entry works in an editor:
    vi tbr.c

    # then figure out how to exit vi :-)
```

What happens if you try using `cd -` to return to previous directory? What about
`cd` with no args?

The authors include a section called [BUGS](#bugs) that, because they were
documented, are not considered bugs as such in the context of the contest.


## Alternate code:

The authors supplied us with a slightly smaller unformatted version
of the program:

``` <!---c-->
    #define D ,close(
    char*c,q[512],m[256],*v[99],**u,*i[3];int f[2],p;main(){for(m[m[60]=m[62]=
    32]=m[*m=124[m]=9]=6;e(-8),gets(1+(c=q))||(exit(0),0);r(0,0))for(;*++c;);}
    r(t,o){*i=i[2]=0;for(u=v+98;m[*--c]^9;m[*c]&32?i[*c&2]=
    *u,u-v^98&&++u:3)if(!m[*c]){for(*++c=0;!m[*--c];);*--u=
    ++c;}u-v^98?strcmp(*u,"cd")?*c?pipe(f),o=f[1]:1,(p=fork())?e(p),o?
    r(o,0)D o)D*f):4,wait(0):(o?dup2(*f,0)D*f)D o):*i?1 D
    0),e(open(*i,0)):5,t?dup2(t,1)D t):i[2]?9 D
    1),e(creat(i[2],438)):2,e(execvp(*u,u))):e(chdir(u[1])*2):6;}
    e(x){x<0?write(2,"?\n$ "-x/4,2),x+1||(exit(1),0):5;}
```

This is the [alternate source](%%REPO_URL%%/1990/tbr/tbr.alt.c) except that it
has the `exit()` returns `void` fix as well as the `gets(3)` to `fgets(3)` fix
applied to it to make it functionally equivalent like the authors intended. The
above code is their original alternate code.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./tbr.alt
```


## Judges' remarks:

This program touches on a well known Unix utility, the 6th edition Bourne Shell
(`/bin/sh`), whose original source was considered to be extremely obfuscated by
many people (although Steve Bourne might disagree). Did you know that the Bourne
Shell source was a major inspiration for the formation of the IOCCC back in
1984?


## Authors' remarks:

This program is a rudimentary shell. It does I/O redirection, pipes
and cd. It flags errors on failed `chdir()`, `open()`, `creat()`,
`execvp()`, `fork()` and a few syntax errors.

This program is obfuscated in a few notable ways: apart from the layout (an
unformatted (but crunched) version is included for people who want to put this
through `cb`) it makes clever use of a `write()` statement, so that the same statement
can be used to print errors and the prompt. By calling the error function with
the value `-8`, the pointer offset in the expression `"?\n$ "-x/4` goes from 0
to 2.  Presto!  A prompt. For errors with numbers smaller than `-4` (i.e., UNIX
system calls) a question mark is printed.

The error value of `chdir()` is doubled so that we don't exit from the parent
shell on a `chdir()` error (since `e()` exits on `-1` errors only).  All other
system call failures exit since they are from sub-shells.

Recursion is sneakily employed to avoid a second call to `fork()`,
and the line is parsed in a fairly bizarre fashion:  backwards. The
heart of the program, that is, the part which performs all `fork()`s,
`exec()`s, `open()`s, etc. is ONE C STATEMENT.

The meta-values array is initialized in a bizarre fashion, and the
subsequent checks for the `'<'` and `'>'` are performed in a single
statement using a mask, since you know that `'>'&2` is 0, whereas
`'<'&2` is 2. Other such micro-obfuscations abound.

Finally, it is notable that the code was hacked for minimality. If
you look at the compressed version, you will be hard-pressed to
eliminate more than a few characters (we can't see how to make it
any smaller!).  550 characters is pretty lean for a shell that does
this much.


### BUGS

The syntax of the shell has not been fully explored, but if you try
to redirect in the same direction more than once, only one
redirection is performed. This is a "feature" of the way the line
is parsed; a pointer to the stack of arguments is assigned and an
argument is stolen every time a `>` or `<` is encountered.  The
shell flags an error if no arguments are on the stack. Thus, for
example:

``` <!---sh-->
    cat > foo > bar
```

cats to `foo`, since it was pushed last, but

``` <!---sh-->
    cat > > foo bar
```

cats to `bar`, since `bar` was pushed under `foo` (remember we're
parsing right-left).

Depending on your flavor of Unix, `cd` without an argument will
either produce an error or just do nothing.

There is just one error message, the question mark, but hey, that's
all `ed(1)` does too.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
