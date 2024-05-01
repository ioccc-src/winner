## To build:

``` <!---sh-->
    make all		# On a 64-bit machine (default)

    make tromp32		# On a 32-bit machine
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2012 tromp bugs](../../bugs.html#2012_tromp).


## To use:

``` <!---sh-->
    ./tromp [-b]
```

Use `./tromp32` as you would `./tromp` if on a 32-bit machine.


## To use:

``` <!---sh-->
    cat ascii-prog.blc data | ./tromp -b
    cat binary-prog.Blc data | ./tromp
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

The judges dare to say that the data files this entry is processing
are more obfuscated than the entry itself.


## Author's remarks:

This program celebrates the close connection between obfuscation and conciseness,
by implementing the most concise language known, BLC:
[Binary Lambda Calculus](https://tromp.github.io/cl/Binary_lambda_calculus.html).

[BLC](https://tromp.github.io/cl/Binary_lambda_calculus.html) was developed to
make [Algorithmic Information
Theory](https://en.wikipedia.org/wiki/Algorithmic_information_theory), the
theory of smallest programs, more concrete. It starts with the simplest model of
computation, the [lambda
calculus](https://en.wikipedia.org/wiki/Lambda_calculus), and adds the minimum
amount of machinery to enable binary input and output.

More specifically, it defines a universal machine, which, from an input stream
of bits, parses the binary encoding of a [lambda
calculus](https://en.wikipedia.org/wiki/Lambda_calculus) term, applies that to
the remainder of input (translated to a lazy list of
[booleans](https://en.wikipedia.org/wiki/Boolean_algebra), which have a standard
representation in lambda calculus), and translates the evaluated result back
into a stream of bits to be output.

Lambda is encoded as 00, application as 01, and the variable bound by the `n`th
enclosing lambda (denoted `n` in so-called [De Bruijn](https://en.wikipedia.org/wiki/De_Bruijn_notation)
notation) as `1^{n}0`.
That's all there is to
[BLC](https://tromp.github.io/cl/Binary_lambda_calculus.html)!

For example the encoding of lambda term `S = \x \y \z  (x z) (y z)`,
with [De Bruijn notation](https://en.wikipedia.org/wiki/De_Bruijn_notation):

```
    \ \ \ (3 1) (2 1)`, is `00 00 00 01 01 1110 10 01 110 10
```

In the closely related
[BLC8](https://tromp.github.io/cl/Binary_lambda_calculus.html#BLC8:_byte_sized_I.2FO)
language, I/O is byte oriented, translating between a stream of bytes and a list
of length-8 lists of [booleans](https://en.wikipedia.org/wiki/Boolean_algebra).

The submission implements the universal machine in the most concise manner conceivable.
It lacks `#define`s and `#include`s, and compiles to a (stripped) executable of
under 6K in size.

Without arguments, it runs in byte mode, using standard input and output.
With one (arbitrary) argument, it runs in bit mode, using only the least significant
bit of input, and using characters `0` and `1` for output.

The program uses the following exit codes:

```
    0: OK; result is a finite list
    5: Out of term space
    6: Out of memory
    1,2,3,4,8,9: result not in list form
```

The size of the term space is fixed at compile time with `-DA`.


### A half byte `cat`

The shortest (closed) lambda calculus term is `\x x (\ 1` in
[De Bruijn](https://en.wikipedia.org/wiki/De_Bruijn_notation) notation which is the
identity function. When its encoding `0010` is fed into the universal machine,
it will simply copy the input to the output (well, not that simply, since each
byte is smashed to bits and rebuilt from scratch). Voila: a half byte cat:

``` <!---sh-->
    $ echo " Hello, world" | ./tromp
    Hello, world
```

Since the least significant 4 bits of the first byte are just arbitrary padding
that is ignored by the program, any character from ASCII 32 (space) through 47
(`/`) will do, e.g.:

``` <!---sh-->
    $ echo "*Hello, world" | ./tromp
    Hello, world
```


### Bad programs

If the input doesn't start with a valid program, that is,
if the interpreter reaches end-of-file during program parsing,
it will crash in some way. E.g. the following might dump core:

``` <!---sh-->
    echo -n "U" | ./tromp
```

Furthermore, the interpreter requires the initial encoded lambda term to be
closed, that is, variable `n` can only appear within at least `n` enclosing
lambdas.  For instance, here the term `\ 5` is not closed, causing the
interpreter to crash when looking into a null-pointer environment:

``` <!---sh-->
    echo ">Hello, world" | ./tromp
```

will likely dump core.

Since these properties can be checked when creating
[BLC](https://tromp.github.io/cl/Binary_lambda_calculus.html) programs,
the interpreter doesn't bother checking for it.

### A Self Interpreter

The [BLC](https://tromp.github.io/cl/Binary_lambda_calculus.html) universal
machine may be small at 650 bytes of C (952 bytes including layout), but written
as a self interpreter in BLC it is downright minuscule at 232 bits (29 bytes):

```
      01010001
       10100000
        00010101
         10000000
          00011110
           00010111
            11100111
             10000101
              11001111
              000000111
             10000101101
            1011100111110
           000111110000101
          11101001 11010010
         11001110   00011011
        00001011     11100001
       11110000       11100110
      11110111         11001111
     01110110           00011001
    00011010             00011010
```

The byte oriented BLC8 version weighs in at 43 bytes (shown in hexadecimal).

```
     19468
      05580
       05f00
        bfe5f
         85f3f
          03c2d
         b9fc3f8
        5e9d65e5f
       0decb f0fc3
      9befe   185f7
     0b7fb     00cf6
    7bb03       91a1a

```

``` <!---sh-->
    $ (cat uni8.Blc; echo " Ni hao") | ./tromp
    Ni hao
```

### A prime number sieve

Even shorter than the self-interpreter is this prime number sieve in 167 bits
(under 21 bytes):

```
    000100011001100101000110100
     000000101100000100100010101
     11110111          101001000
     11010000          111001101
     000000000010110111001110011
     11111011110000000011111001
     10111000
     00010110
    0000110110

```

The `n`th bit in the output indicates whether n is prime:

``` <!---sh-->
    $ cat primes.blc | ./tromp -b | head -c 70
    0011010100010100010100010000010100000100010100010000010000010100000100
```

For those who prefer to digest their primes in decimal, there is `oddindices.Blc`,
which will print the indices of all odd characters (with
[LSB](https://en.wikipedia.org/wiki/Bit_numbering) = 1)
separated by a given character:

```
    $ (cat oddindices.Blc; echo -n " "; cat primes.blc | ./tromp -b) | ./tromp | head -c 70
    2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
```

### A Space filling program

The program `hilbert.Blc`, at 143 bytes, is a very twisty "one-liner" (shown in hexadecimal):

```
    1818181   8111154   6806041   55ff041
    9d   f9   de   16   ff   fe   5f   3f
    ef   f615ff9   46   84   058117e   05
    cb             fe   bc             bf
    ee86cb9   4681600   5c0bfac   bfbf71a
         85   e0             5c   f4
    14d5fe0   8180b048d0800e078   016445f
    fe                                 5f
    f7   ffffe5fff2fc   02f7ad97f5bf   ff
    ff   bf        ff   ca        af   ff
    7817ffa   df76695   4680601   57f7e16
              05             c1
    3fe80b2   2c18581   bfe5c10   42ff805
    de   ec        06   c2        c0   c0
    60   8191a00167fb   cbcfdf65f7c0  a20
```

It expects `n` arbitrary characters of input, and draws a space filling [Hilbert
curve](https://en.wikipedia.org/wiki/Hilbert_curve) of order `n`:

``` <!---sh-->
    $  (cat hilbert.Blc; echo -n "1") | ./tromp
     _
    | |

    $ (cat hilbert.Blc; echo -n "12") | ./tromp
     _   _
    | |_| |
    |_   _|
     _| |_

    $ (cat hilbert.Blc; echo -n "123") | ./tromp
     _   _   _   _
    | |_| | | |_| |
    |_   _| |_   _|
     _| |_____| |_
    |  ___   ___  |
    |_|  _| |_  |_|
     _  |_   _|  _
    | |___| |___| |

    $ (cat hilbert.Blc; echo -n "1234") | ./tromp
     _   _   _   _   _   _   _   _
    | |_| | | |_| | | |_| | | |_| |
    |_   _| |_   _| |_   _| |_   _|
     _| |_____| |_   _| |_____| |_
    |  ___   ___  | |  ___   ___  |
    |_|  _| |_  |_| |_|  _| |_  |_|
     _  |_   _|  _   _  |_   _|  _
    | |___| |___| |_| |___| |___| |
    |_   ___   ___   ___   ___   _|
     _| |_  |_|  _| |_  |_|  _| |_
    |  _  |  _  |_   _|  _  |  _  |
    |_| |_| | |___| |___| | |_| |_|
     _   _  |  ___   ___  |  _   _
    | |_| | |_|  _| |_  |_| | |_| |
    |_   _|  _  |_   _|  _  |_   _|
     _| |___| |___| |___| |___| |_
```

### A [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter

The smallest known BF interpreter is written in... you guessed it,
[BLC](https://tromp.github.io/cl/Binary_lambda_calculus.html),
coming in at 112 bytes (including 3 bits of padding):

```
    $ od -t x4 bf.Blc
    0000000          01a15144 02d55584               223070b7        00f032ff
    0000020          7f85f9bf        956fe15e        c0ee7d7f 006854e5
    0000040          fbfd5558        fd5745e0        b6f0fbeb 07d62ff0
    0000060          d7736fe1 c0bc14f1               1f2eff0b        17666fa1
    0000100          2fef5be8        ff13ffcf        2034cae1 0bd0c80a
    0000120          e51fee99        6a5a7fff        ff0fff1f d0049d87
    0000140          db0500ab 3bb74023               b0c0cc28 10740e6c
    0000160
```

It expects its input to consist of a
[Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) program
(looking only at bits `0`, `1` and `4` to distinguish among `,-.+<>][ `)
followed by a `]`, followed by the input for the Brainfuck program.

```
    $ more hw.bf
    ++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.]
    $ cat bf.Blc hw.bf | ./tromp
    Hello World!
```

Curiously, the interpreter `bf.Blc` is the exact same size as `hw.bf`.


### A BLC assembler

Writing BLC programs can be made slightly less painful with this parser that
translates single-letter-variable lambda calculus into BLC:


``` <!---sh-->
    $ echo "\f\x f (f (f x))" > three
    $ cat parse.Blc three | ./tromp
    000001110011100111010
```

### Converting between bits and bytes

The program `inflate.Blc` and its inverse `deflate.Blc` allow us to translate between
BLC and BLC8. If you assemble a byte oriented program, you'll need to compact it
into BLC8:

So we could assemble an input reversing program as

``` <!---sh-->
    echo "\a a ((\b b b) (\b \c \d \e d (b b) (\f f c e))) (\b \c c)" > reverse
    cat parse.Blc reverse | ./tromp > reverse.blc
```

and change it to BLC8 with

``` <!---sh-->
    $ cat deflate.Blc reverse.blc | ./tromp > rev.Blc
    $ wc rev.Blc
	0 1 9 rev.Blc
```

and then try it out with:

``` <!---sh-->
    $ cat rev.Blc - | ./tromp
    Hello, world!
    ^D
    !dlrow ,olleH
```

### Symbolic Lambda Calculus reduction

BLC8 program `symbolic.Blc` shows individual reduction steps on symbolic lambda terms.
Here it is used to show the calculation of 2^3 in Church numerals:

``` <!---sh-->
    $ echo "(\f\x f (f (f x))) (\f\x f (f x))" > threetwo
    $ cat parse.Blc threetwo | ./tromp > threetwo.blc
    $ cat symbolic.Blc threetwo.blc | ./tromp
    (\a \b a (a (a b))) (\a \b a (a b))
    \a (\b \c b (b c)) ((\b \c b (b c)) ((\b \c b (b c)) a))
    \a \b (\c \d c (c d)) ((\c \d c (c d)) a) ((\c \d c (c d)) ((\c \d c (c d)) a) b)
    \a \b (\c (\d \e d (d e)) a ((\d \e d (d e)) a c)) ((\c \d c (c d)) ((\c \d c (c d)) a) b)
    \a \b (\c \d c (c d)) a ((\c \d c (c d)) a ((\c \d c (c d)) ((\c \d c (c d)) a) b))
    \a \b (\c a (a c)) ((\c \d c (c d)) a ((\c \d c (c d)) ((\c \d c (c d)) a) b))
    \a \b a (a ((\c \d c (c d)) a ((\c \d c (c d)) ((\c \d c (c d)) a) b)))
    \a \b a (a ((\c a (a c)) ((\c \d c (c d)) ((\c \d c (c d)) a) b)))
    \a \b a (a (a (a ((\c \d c (c d)) ((\c \d c (c d)) a) b))))
    \a \b a (a (a (a ((\c (\d \e d (d e)) a ((\d \e d (d e)) a c)) b))))
    \a \b a (a (a (a ((\c \d c (c d)) a ((\c \d c (c d)) a b)))))
    \a \b a (a (a (a ((\c a (a c)) ((\c \d c (c d)) a b)))))
    \a \b a (a (a (a (a (a ((\c \d c (c d)) a b))))))
    \a \b a (a (a (a (a (a ((\c a (a c)) b))))))
    \a \b a (a (a (a (a (a (a (a b)))))))
```

As expected, the resulting normal form is [Church
numeral](https://en.wikipedia.org/wiki/Church_encoding) 8.

Taking only the first line of output gives us a sort of BLC disassembler, an
exact inverse of the above assembler. The prime number sieve disassembles as
follows:

``` <!---sh-->
    $ cat symbolic.Blc primes.blc | ./tromp | head -1
    \a (\b b (b ((\c c c) (\c \d \e e (\f \g g) ((\f c c f ((\g g g) (\g f (g g)))) (\f \g \h \i i g (h (d f))))) (\c \d \e b (e c))))) (\b \c c (\d \e d) b)
```

Hardly any less obfuscated...

The last line of

``` <!---sh-->
    cat symbolic.Blc primes.blc | ./tromp | head -16
```

starts out as

```
    \a \b b (\c \d c) (\c c (\d \e d) (\d d (\e \f f) (\e e (\f \g g) ((\f (\g \h \i
```

The `\a` is for ignoring the rest of the input (to which the universal machine
applies the decoded lambda term). The `\b b (..) (...)` is the list constructor,
usually called `cons`, applied to a head (a list element) and a tail (another list).
In this case the element is `(\c \d c)`, which represents the boolean true, and
which we use to represent a 0 bit. This is the bit that says 0 is not prime.
The next list element (following another `cons`) is `(\d \e d)`. Another 0 bit,
this time saying that 1 is not prime. The third list element is `(\e \f f)`,
a 1 bit, confirming our suspicion that 2 is prime. As is the next number,
according to `(\f \g g)`. We can see that the tail after the first 4 elements
is still subject to further reduction. The bit for number 4 will show up
for the first time in line 30, as `(\g \h g)`, or 0, as the result of zeroing
out all multiples of the first prime, 2.

Since my computer reaches swap hell before line 40, we can't see the next bit arriving,
at least not in this symbolic reduction.


### Performance

Performance is quite decent, and amazingly good for such a tiny implementation,
being roughly 50% slower than a Haskell implementation of the universal machine
using so-called [Higher Order Abstract
Syntax](https://en.wikipedia.org/wiki/Higher-order_abstract_syntax) which relies on the highly optimized
Haskell runtime system for evaluation. Of course individual BLC programs running
under the interpreter perform much worse than that same program written in Haskell.

Our interpreter copes well with extra levels of interpretation:

``` <!---sh-->
    $ time cat primes.blc | ./tromp -b | head -c 210 > /dev/null
    real    0m0.043s
    $ time cat uni.blc primes.blc | ./tromp -b | head -c 210 > /dev/null
    real    0m0.191s
    $ time cat uni.blc uni.blc primes.blc | ./tromp -b | head -c 210 > /dev/null
    real    0m1.919s
    $ time cat uni.blc uni.blc uni.blc primes.blc | ./tromp -b | head -c 210 > /dev/null
    real    0m23.514s
    $ time cat uni.blc uni.blc uni.blc uni.blc primes.blc | ./tromp -b | head -c 210 > /dev/null
    real    4m52.700s
```

### Obfuscation

Obfuscation is due entirely to conciseness. Some questions to ponder:

Which of the term space codes `0`, `1`, `2`, `3` serve multiple purposes?

Why is the environment pointer pointing into the term space?

What does the test `u+m&1?` do?

How does the program reach exit code 0?

And how do any of those BLC programs work?


### Portability

The program freely (without casting) converts between `int` and `int *`, causing
many warnings;

```
    note: expected 'int *' but argument is of type 'int'
    warning: assignment from incompatible pointer type
    warning: assignment makes integer from pointer without a cast
    warning: assignment makes pointer from integer without a cast
    warning: incompatible implicit declaration of built-in function 'calloc'
    warning: incompatible implicit declaration of built-in function 'exit'
    warning: passing argument 1 of 'd' makes pointer from integer without a cast
    warning: passing argument 1 of 'p' makes pointer from integer without a cast
    warning: pointer/integer type mismatch in conditional expression
```

Avoiding these would make the program substantially longer,
and detract from its single minded focus on conciseness.

It implicitly declares functions `read(2)`, `write(2)`, `exit(3)` and
`calloc(3)`, the latter two incompatibly.  32 bit and 64 bit executables are
separate [Makefile](%%REPO_URL%%/2012/tromp/Makefile) targets, involving a change from `int` to `long`
and from a hardcoded sizeof of 4 to 8.

The program has been tested to work correctly on Linux/Solaris/MacOSX both in 32
and 64 bits.


### How the program works

See the file [how.html](how.html).


### Acknowledgements

Christopher Hendrie, Bertram Felgenhauer, Alex Stangl, Seong-hoon Kang,
and [Yusuke Endoh](../../authors.html#Yusuke_Endoh) have contributed ideas and
suggestions for improvement.


### References

Binary Lambda Calculus -
<https://tromp.github.io/cl/Binary_lambda_calculus.html>

G J Chaitin, Algorithmic information theory, Volume I,
Cambridge Tracts in Theoretical Computer Science, Cambridge University Press, October 1987.
<https://web.archive.org/web/20121125233450/https://www.cs.auckland.ac.nz/~chaitin/cup.html>

Jean-Louis Krivine. 2007.
A call-by-name lambda-calculus machine
Higher Order Symbol. Comput. 20, 3 (September 2007), 199-207.
<http://www.pps.univ-paris-diderot.fr/~krivine/articles/lazymach.pdf>


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
