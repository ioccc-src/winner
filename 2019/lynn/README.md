# Most functional compiler

Ben Lynn  
<https://crypto.stanford.edu/~blynn/>  
Twitter: @bmxlynn  


## Judges' comments:
### To use:

    make

### Try:

    (./prog < fib.hs; cat prog.c) > fib.c
    cc fib.c -o fib
    ./fib

### Selected Judges Remarks:

A fully functional compiler. The example prints out the 30th Fibonacci number.

## Author's comments:
# Remarks #

A Haskell compiler. Supports a subset of Haskell more than large enough to
self-host. Like GHC with custom language extensions:

 * `WeDontServeYourType`: Compilation failing because of inscrutable type
 checking rules? Confused by the ever-growing mire of extensions to the type
 system? The solution is simple: no type checking. It also means no
 typeclasses. Just pass dictionaries explicitly.

 * `ZeroPauseGarbageCollection`: Instead of disruptive stop-the-world garbage
 collection, we only tidy up when the world stops of its own accord, that is,
 on program termination.

 * `OneHundredPercentPure`: Gone is the catch-all lawless IO monad. And no
 trace of those scary `unsafeThisAndThat` functions. All functions must be pure.

 * `SyntaxForTheMasses`: See below.

## Demos ##

Build the compiler:

    $ $(CC) -o prog prog.c

### Fibonacci numbers

Test the compiler on `fib.hs`:

    $ (./prog < fib.hs ; cat prog.c) > fib.c

Compiling the output produces a binary that prints the 30th Fibonacci number.

The file `ghcfib.hs` includes `fib.hs` with some glue code, and shows GHC
also accepts our subset of Haskell:

    $ ghc ghcfib.hs

### Self-hosting compiler

To avoid spoiling this entry by revealing the original Haskell source, we
instead provide `hint.hs`, the output of a certain stage of the compiler when
run on itself. This intermediate output is hopefully difficult to understand,
yet is accepted by our compiler:

    $ (./prog < hint.hs ; cat prog.c) > hint.c

The output program behaves like the compiler itself.

Unlike the original source from which it is derived, GHC fails to compile
`hint.hs`. This is because values have been replaced with their Scott encodings
by this stage, which messes up type-checks; we'd need equirecursive types for
it to work.

### Regexes

The file `lol.hs` contains an adaptation of [Doug McIlroy's elegant code from
"Enumerating the strings of regular
languages"](https://www.cs.dartmouth.edu/~doug/nfa.pdf). We exercise it by
showing the first entries of the length-ordered list of all strings consisting
of the characters a and b that contain an even number of a's.

    $ (./prog < lol.hs ; cat prog.c) > lol.c

A GHC wrapper is provided:

    $ ghc ghclol.hs

### Strongly-connected components

See `scc.hs` (and its GHC wrapper `ghcscc.hs`) for an elegant way to print the
strongly-connected components of a graph in reverse topological order.

    $ (./prog < scc.hs ; cat prog.c) > scc.c

It expects the input to be in a similar format as a previous entry
(2018 vokes). Indeed, obtain the 2018 winners, and run:

    $ ./scc < 2018/vokes/example-1.txt
    $ ./scc < 2018/vokes/example-2.txt

The output should agree, though our program omits line numbers and does not
sort entries within a line. (Also, our program only treats spaces as
whitespace, and supports any nonspace character in a vertex name.)

## Syntax ##

Some claim Haskell syntax is frightening because braces and semicolons are
optional. Some complain about a zoo of twisty little operators, all alike. Our
compiler addresses such concerns by making braces and semicolons compulsory,
disabling layout-based rules, making every operator left-associative with same
precedence, and only defining 6 primitive functions:

    : + - * / <=

The arithmetic operations behave as they do in C on unsigned ints, and `(:)` is
Haskell's cons function. Like Haskell and unlike C, `(<=)` returns a Bool
(which are Church booleans behind the scenes) and not an Int.

No ifs, ands, or buts. Define them yourself. No tuples. Who needs them when
algebraic data types delivers a better product? There is no do. No where. No
list comprehensions. No unary operators.

Let expressions and operator sections are supported.

Within global scope or a let expression, each definition can only refer to
itself or previous definitions. This implies we can only achieve mutual
recursion by having one function pass itself to others.

## Caveats ##

The only primitive type is `Int`. In particular, they represent characters. To
interoperate with GHC, our compiler treats any undefined functions as the
identity function, so that we may freely use `ord` and `chr` (or `fromEnum` and
`toEnum`) to make our code acceptable to both compilers.

The main function is the last function to successfully parse. It should have
type `[Int] -> [Int]`, and our compiler treats this like the function passed
into `Prelude.interact`, that is, the entire standard input is passed to this
function, and the result is printed to standard output.

Bool must be defined as:

    data Bool = True | False;

so that it matches the Scott-encoded booleans internally used by the primitive
function `(<=)`.

The alternatives in a case expressions must list every data constructor in
the order they are defined. For example, if we have:

    data Foo a b = Bar a | Baz | Qux Int [b]

then a case expression that examines a term of this type must have the form:

    case x of
      { Bar a    -> ...
      ; Baz      -> ...
      ; Qux n bs -> ...
      }

We stress braces and semicolons are required. Our fussy parser treats
semicolons as separators, not terminators.

The effect of erroneous input is undefined. It may be best to develop with GHC,
but even then, be mindful of changes needed because of issues caused by the
uniform operator precedence and the touchy format of case alternatives.

## Why? ##

One-letter variable names abound in IOCCC entries, and for good reason. These
tiny pieces of confetti are hard to read, and leave room for more code. Then
why not go further and use zero-letter variable names? That is, tacit
programming or point-free style.

I had been playing with an algorithm devised by Oleg Kiselyov that effortlessly
and efficiently eliminates those pesky variables, leaving behind terms composed
from a small set of combinators. No need for lambda lifting or supercombinators.

By adding a handful of lines of mostly parsing code, we get a Haskell compiler,
or rather, a compiler that accepts a subset of Haskell sufficiently large to
self-host. You might say I wrote a tool for this contest, then ran it on itself
to make an entry for it.

## Obfuscation techniques ##

Even with Kiselyov's algorithm and some term rewriting, the compiler only fit
after compression, which naturally obfuscates the code. More tricks were needed
to fit within the size limits.

 * One-letter variables, until enough is done to banish variables completely.
 * Ipse dixit. Near the end, the code declares itself to be an obfuscated
 program. (There is also an exhortation intended for the judges in a similar
 format earlier in the source.)
 * Typical C mischief: pre- and post-increment, commutative array indexing,
 ternary operators, and so on.
 * Huffman coding.
 * Base-85 because high bits are frowned upon.
 * Mixed radix encoding to game iocccsize. From a past winner (2018 bellard),
 it seems 9 11 12 32 are the only whitespace octets that may appear verbatim in
 string literals.
 * Choosing what to encode in Huffman/base-85 and what to encode in mixed radix
 was a delicate balancing act. In the end, I only had a few bytes to spare,
 which I spent on gratuitous confusion.
 * The effects of some functions depend on the order their arguments are
 evaluated, yet the program works either way. Why?
 * Ugly macros for the runtime system's jump table for lazy reduction. A
 previous winner (2013 endoh1) has a cuter solution, which I avoid because of
 originality concerns and also because my combinators are compressed.
 * Relies on the inability of C comments to nest.
 * Cheaper and more complicated to print comma-separated ints (and header and
 footer) in C.
 * Primitive functions use a trick described in depth by [Naylor and Runciman,
"The Reduceron reconfigured and
re-evaluated"](https://www.cs.york.ac.uk/fp/reduceron/jfp-reduceron.pdf). We
represent the integer n with a term equivalent to `Y(BT)n`; it works because
`Y(BT)ne = e(Y(BT)n)`.
 * A sentinel in the heap often confused me, so ought to confuse others.

Other obfuscation techniques are better appreciated after decoding the
compiler. See `hint.hs`.

 * Mercilessly point-free. Everything is a combinator.
 * Scott encoding. Everything is a combinator.
 * Sum types are oddly ordered and may even contain unused data constructors
 to reduce code duplication. (In C terms, unions may have extra fields, and
 they're ordered in such a way so we can reuse code to access certain fields.)
 * The `undefined` function compiles to the `(.)` function.
 * Replaced the only `(&&)` with `(||)` and `not` using De Morgan's law, which
 makes some comparisons less comprehensible.
 * [Kiselyov only published "&#955; to SKI, Semantically" last
year](http://okmij.org/ftp/tagless-final/ski.pdf).
 * Recursion via the fixpoint (Y) combinator, which is represented by the
 variable "" during one stage of compilation.
 * Involves theory that may be less familiar to C programmers: maps, folds,
 parser combinators, lambda calculus, bracket abstraction, denotational
 semantics, etc.

## Warnings ##

On my system, it compiles cleanly with `-Wall` with older standards, e.g.
`-std=c89`, but less cleanly if `-pedantic` is also supplied.

Compiling the compiler output with `-Wall` triggers a warning about a
strange-looking comment.

## Behind-the-scenes commentary ##

[My website reveals how this compiler
works.](https://crypto.stanford.edu/~blynn/compiler/ioccc.html)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
