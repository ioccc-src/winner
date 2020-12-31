# Most lazy SKIer

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make 

This builds endoh1, echo, hello, and tac.
### To run:

    ./endoh1 [file.lazy]

### Try:

    ./endoh1 hello.lazy
    ./hello
    echo Hello | ./echo 
    ./tac < endoh1.c

Be patient with the last one.

### Selected Judges Remarks:

We liked this entry because it can serve as a standalone program as well as an include file; and, as usual,
because its input data is at least as obfuscated as the program itself.

This entry can be considered an abuse of the GCC's optimizer; it takes GCC about 4x longer to compile it
with -O3 than without, compared to clang's 2x.



## Author's comments:
### Remarks

    $ less prog.c
    $ gcc -o prog prog.c
    $ ./prog

... Isn't there any more to it?

Yes, of course.

This is a tool *for C programmers* to play the [SKI combinator calculus][1],
especially, [Lazy K][2].

This program will shine when it is used as a library.
For example, `hello.lazy` is a "Hello world" program written in Lazy K.

    $ lazy hello.lazy
    Hello, world!

where `lazy` is [a reference implementation of Lazy K][3].
At the same time, `hello.lazy` is *a valid C program* that uses `prog.c` as a library.

    $ gcc -o hello -xc hello.lazy
    $ ./hello
    Hello, world!

In other words, this program is a kind of [polyglot][4].

The usage is simple:
you just have to wrap Lazy K program with `#include "prog.c"`.
Note that `#` is a comment in Lazy K.

[1]: http://en.wikipedia.org/wiki/SKI_combinator_calculus
[2]: redacted
[3]: redacted
[4]: http://en.wikipedia.org/wiki/Polyglot_%28computing%29


### Obfuscation

... is inherent in SKI combinator calculus :-)

In addition, it uses various hacks to parse SKI code as C,
and to satisfy IOCCC's size rule.

* Abuse of function pointers
* Code duplication by macros
* Short coding

These led to the good obfuscation.
See Spoiler section in detail, if you need.


### Limitation

This program supports only "Combinator-calculus style notation" of Lazy K.
"Unlambda style" and "Iota and Jot" style are not supported.
Also, it requires a space between identifiers.
In short, use `(S K)` instead of `(SK)`, "\`sk", `**i*i*i*ii*i*i*ii`,
or `11111100011100`.

Huge memory may be required to compile the program
(about 300 MB on my machine).

In addition, there are some limitations (and workarounds)
mentioned in Spoiler section.
But I think it wouldn't matter only when you run the attached programs.


### Portability

I confirmed that the program successfully worked
with the following compilers.

  * gcc 4.6.3 [Linux, Mac OS X]
  * clang 3.0 [Linux, Mac OS X]
  * tcc 0.9.26 [Linux]
    * N.B. tcc 0.9.25 seems to have a bug and fails to run it.

Recent compilers with `-Wall -W -Wextra -pedantic` say nothing.

    gcc -Wall -W -Wextra -pedantic prog.c
    clang -Wall -W -Wextra -pedantic prog.c
    tcc -Wall -W -Wextra -pedantic prog.c

I think it will work on almost all platforms.  I confirmed:

  * Ubuntu Linux
  * Mac OS X
  * Raspberry PI

To check whether the program is specified on the command line
or included from another source file,
the program uses a predefined macro `__INCLUDE_LEVEL__`.
It is a gcc extention, and also supported by clang.
If your compiler does not support it,
you cannot use the program as a library.
But you can compile and run it as a standalone program, at least.
In fact, tcc does not support the macro, but does work.


### Spoiler (rot13)

Gur jubyr cebtenz vf vagrecergrq ol znpeb rkcnafvba.
Sbe rknzcyr, `F (X V)` vf genafyngrq gb n abezny P pbqr, `(f)((x)(v))`,
be fvzcyl `f(x(v))`.
Guvf rkcerffvba ergheaf na nofgenpg flagnk gerr,
naq `cebt.p` rinyhngrf vg.
Guvf cebtenz hfrf irel fvzcyr "grez erjevgvat" nccebnpu
sbe rinyhngvat FXV pbzovangbe pnyphyhf.
Gur erjevgvat ehyrf ner fubja va gur funcr bs gur pbqr.

#### Nohfr bs shapgvba cbvagref

Pbafvqre n frdhrapr bs shapgvba nccyvpngvbaf va P:

    f(k)(k)(k)(k)...

Jung glcr fubhyq `f` unir?
Hasbeghangryl, P qbrf *abg* cebivqr n "erphefvir glcr",
fhpu nf `glcrqrs s (*s)();`.
Fb, V hfrq n urniyl arfgrq shapgvba cbvagre glcr:

    glcrqrs ibvq *(*(*(*...(*(s))()...)())())

Guvf yvzvgf ubj znal nethzragf bar shapgvba pna or pbafrphgviryl nccyvrq gb.
Ohg lbh pna vapernfr gur ahzore ol gjrnxvat gur qrsvavgvba bs znpeb `c`.


#### Pbqr qhcyvpngvba ol znpebf

Arkg, jr arrq gb rapbqr "pybfherf".
N pybfher vf n shapgvba gbtrgure jvgu na raivebazrag
juvpu vf n ersrerapr gb aba-ybpny inevnoyr.

Va guvf pnfr, jr arrq fbzrguvat gung:

  * vf pnyynoyr vgfrys,
  * vagreanyyl cbffrffrf n ersrerapr gb nabgure pybfher nf n aba-ybpny inevnoyr, naq
  * nccyvrf gur vagreany pybfher gb na nethzrag jura vg vf pnyyrq.

Ubjrire, ab glcr va P vf pnyynoyr naq unf n ersrerapr ng gur fnzr gvzr.
(Vg vf srnfvoyr ol qlanzvp pbqr trarengvba, ohg vg vf sne sebz cbegnoyr.)

Fb, V nqqerffrq guvf vffhr ol trarengvat znal shapgvba qrsvavgvbaf
fgngvpnyyl ol (no)hfvat znpebf:

    ibvq *k1; ibvq s1(ibvq *l) { erghea nccyl(k1, l); }
    ibvq *k2; ibvq s2(ibvq *l) { erghea nccyl(k2, l); }
    ibvq *k3; ibvq s3(ibvq *l) { erghea nccyl(k3, l); }
    ...
    ibvq *(u[]) = { s1, s2, s3, ... }

naq ol nyybgvat rnpu bs gurz jura n pybfher vf arrqrq.

Guvf yrnqf gb nabgure yvzvgngvba:
gur ahzore bs cer-qrsvarq pybfherf yvzvgf
ubj znal vaqragvsvref (`F` `X` `V`) bar cebtenz pna hfr.
Ohg lbh pna vapernfr guvf ahzore
ol gjrnxvat gur qrsvavgvba bs znpeb `N` `O` `P` naq `Q`.
(Abgr gung pybfherf ner nyybggrq bayl jura cnefvat;
nsgre gur rinyhngvba fgnegf, "bhg bs pybfher" pnaabg bpphe.)


#### Fubeg pbeqvat

Guvf znetva vf gbb aneebj gb pbagnva n qrgnvyrq rkcynangvba.
Vafgrnq, V whfg nfx lbh bar dhrfgvba.
Pna lbh gryy jung `i f[]={0,0,f+6,f+2,f+4,f,f+3,f+5,f+1};` vf?
V sbhaq guvf ol hfvat FZG fbyire.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
