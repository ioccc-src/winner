## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2013/endoh1 in bugs.html](../../bugs.html#2013_endoh1).


## To use:

``` <!---sh-->
    ./endoh1 [file.lazy]
```


## Try:

``` <!---sh-->
    ./try.sh
```

You might also enjoy running:

``` <!---sh-->
    cc -E endoh1.c | less
```


## Judges' remarks:

We liked this entry because it can serve as a standalone program as well as an
include file; and, as usual, because its input data is at least as obfuscated as
the program itself.

This entry can be considered an abuse of the GCC's optimizer; it takes GCC about
4x longer to compile it with -O3 than without, compared to clang's 2x.


## Author's remarks:

### Remarks

``` <!---sh-->
    less endoh1.c
    gcc -o endoh1 endoh1.c
    ./endoh1
```

... Isn't there any more to it?

Yes, of course.

This is a tool *for C programmers* to play the [SKI combinator calculus][1],
especially, [Lazy K][2].

This program will shine when it is used as a library.  For example,
[hello.lazy](%%REPO_URL%%/2013/endoh1/hello.lazy) is a "Hello world" program written in Lazy K.

``` <!---sh-->
    $ lazy hello.lazy
    Hello, world!
```

where `lazy` is [a reference implementation of Lazy K][3].  At the same time,
[hello.lazy](%%REPO_URL%%/2013/endoh1/hello.lazy) is *a valid C program* that uses [endoh1.c](%%REPO_URL%%/2013/endoh1/endoh1.c)
as a library.

``` <!---sh-->
    $ gcc -o hello -xc hello.lazy
    $ ./hello
    Hello, world!
```

In other words, this program is a kind of [polyglot][4].

The usage is simple: you just have to wrap Lazy K program with `#include
"endoh1.c"`.  Note that `#` is a comment in Lazy K.


[1]: http://en.wikipedia.org/wiki/SKI_combinator_calculus
[2]: https://tromp.github.io/cl/lazy-k.html
[3]: https://github.com/irori/lazyk
[4]: http://en.wikipedia.org/wiki/Polyglot_%28computing%29


### Obfuscation

... is inherent in SKI combinator calculus :-)

In addition, it uses various hacks to parse SKI code as C,
and to satisfy IOCCC's size rule.

* Abuse of function pointers.
* Code duplication by macros.
* Short coding.

These led to the good obfuscation.

See the [deobfuscation section](#Deobfuscation) in detail, if you need.


### Limitation

This program supports only "Combinator-calculus style notation" of Lazy K.
"Unlambda style" and "Iota and Jot" style are not supported.

Also, it requires a space between identifiers.  In short, use `(S K)` instead of
`(SK)`, "\`sk", `**i*i*i*ii*i*i*ii`, or `11111100011100`.

Huge memory may be required to compile the program (about 300 MB on my machine).

In addition, there are some limitations (and workarounds) mentioned in
the [deobfuscation section](#Deobfuscation).

But I think it would only matter when you run the attached programs.


### Portability

I confirmed that the program successfully worked with the following compilers:

* gcc 4.6.3 [Linux, Mac OS X]
* clang 3.0 [Linux, Mac OS X]
* tcc 0.9.26 [Linux]
    - N.B. tcc 0.9.25 seems to have a bug and fails to run it.

Recent compilers with `-Wall -W -Wextra -pedantic` say nothing.

``` <!---sh-->
    gcc -Wall -W -Wextra -pedantic prog.c
    clang -Wall -W -Wextra -pedantic prog.c
    tcc -Wall -W -Wextra -pedantic prog.c
```

I think it will work on almost all platforms.  I confirmed:

  * Ubuntu Linux
  * Mac OS X
  * Raspberry PI

To check whether the program is specified on the command line or included from
another source file, the program uses a predefined macro `__INCLUDE_LEVEL__`.
It is a gcc extension, and also supported by clang.  If your compiler does not
support it, you cannot use the program as a library.  But you can compile and
run it as a standalone program, at least.  In fact, tcc does not support the
macro, but does work.


### Deobfuscation

The whole program is interpreted by macro expansion.
For example, `S (K I)` is translated to a normal C code, `(s)((k)(i))`, or
simply `s(k(i))`.

This expression returns an abstract syntax tree, and [endoh1.c](%%REPO_URL%%/2013/endoh1/endoh1.c)
evaluates it.

This program uses a very simple "term rewriting" approach for evaluating SKI
combinator calculus.  The rewriting rules are shown in the shape of the code.


#### Abuse of function pointers

Consider a sequence of function applications in C:

``` <!---c-->
    s(x)(x)(x)(x)...
```

What type should `s` have?  Unfortunately, C does *not* provide a "recursive
type", such as `typedef f (*f)();`.

So, I used a heavily nested function pointer type:

``` <!---c-->
    typedef void *(*(*(*...(*(f))()...)())())
```

This limits how many arguments one function can be consecutively applied to.
But you can increase the number by tweaking the definition of macro `p`.


#### Code duplication by macros

Next, we need to encode "closures".  A closure is a function together with an
environment which is a reference to non-local variable.

In this case, we need something that meets all of the following criteria:

* Is callable itself.
* Internally possesses a reference to another closure as a non-local variable.
* Applies the internal closure to an argument when it is called.

However, no type in C is callable and has a reference at the same time.
(It is feasible by dynamic code generation, but it is far from portable.)

So, I addressed this issue by generating many function definitions
statically by (ab)using macros:

``` <!---c-->
    void *x1; void f1(void *y) { return apply(x1, y); }
    void *x2; void f2(void *y) { return apply(x2, y); }
    void *x3; void f3(void *y) { return apply(x3, y); }
    ...
    void *(h[]) = { f1, f2, f3, ... }
```

and by allotting each of them when a closure is needed.

This leads to another limitation: the number of pre-defined closures limits how
many identifiers (`S` `K` `I`) one program can use.

But you can increase this number by tweaking the definition of macro `A` `B` `C`
and `D`.  (Note that closures are allotted only when parsing; after the
evaluation starts, "out of closure" cannot occur.)


#### Short cording

This margin is too narrow to contain a detailed explanation.  Instead, I just
ask you one question.  Can you tell what `v
s[]={0,0,s+6,s+2,s+4,s,s+3,s+5,s+1};` is?  I found this by using an [SMT
solver](https://en.wikipedia.org/wiki/Satisfiability_modulo_theories).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
