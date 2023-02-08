Most Obfuscated Translator:

    Tony Finch
    Demon Internet
    322 Regent's Park Road
    Finchley
    London N3 2QQ
    United Kingdom

    http://www.inch.demon.co.uk/


Judges' comments:

    To build:
	make fanf

	Some systems may have problems building this entry because
	of the system resources can require.

    To use:
	Enter an expression on standard input.  Here are some
	sample expressions that you can use:

	    ((\a(\b(\c(d)))) e)


	    (\f\g\x
	      (
		(g x) (f x)
	      ) K K z
	    )


	    (\f(\f\g\x( (f((\a(g(b))) e)) (g x) ) K K z))


	    (Y\f\n
	      ((= n 0)
	       1
	       (* n (f (- n 1)))
	      )
	    )

    This program translares lambda expressions into combinator
    expressions.  But you do not need to know Lambda Calculus to be
    impressed by this program!

    See the file:

	fanf.lambda

    for more examples of lambda calculus source.

    Notice how large the code grows from the fanf.c into the final
    fanftmp2.c C program.  Take a look at that final C program again,
    can you begin to understand what it is doing?

    Look at the first stage of the C pre-processing:

	gcc -ansi fanf.c -E > fanftmp1.c

    Skip to the bottom of fanftmp1.c (after all of the #include header
    stuff ... look for a line of the form:  # 2 "fanf.c"  near the bottom)
    and look at the resulting code.  This code, when C pre-processed
    will expand into over 342 times the original code (ignoring #include
    headers) to produce fanftmp2.c.  That program in turn, when compiled
    translates a single lambda expression on standard input into
    combinator expressions on standard output.

    Extra credit question:

	What do you have to do to make this program work with an
	old non-ANSI C preprocessor?


Selected Author's comments:

    My program is a demonstration of some practical applications of
    theoretical computer science. The application it implements is a program
    for translating lambda expressions into combinator expressions.


    What the program does
    =====================

    The syntax of lambda expressions recognised by the program is as
    follows: The basic atoms are variables which are single characters other
    than backslash or parentheses, e.g. `a' or `b' or `@'. Variables are
    combined by function application which is written e.g. `(f a)' which is
    the function `f' applied to the argument `a'. Application groups to the
    left, so `(f a b c)' is equivalent to `(((f a) b) c)'. Functions are
    created from lambda terms which are written in the form `\a(expr)' which
    is the function taking argument `a' and having value `expr'. Lambda is
    spelt `\' because ASCII isn't good enough. Lambda binds tightly, so
    `\a\bcd' is equivalent to `((\a(\b(c))) d)'. Whitespace is ignored.

    For example, the identity function, called `I', is written `\x(x)'. A
    simple expression is `(I a)' which is equivalent to `(\x(x) a)', which
    has the value `a'. Another function called `K' is defined as `\x\y(x)'
    and it evaluates as follows:

    	K p q
    ->	\x\y(x) p q
    ->	\y(p) q
    ->	p

    Another function of interest is `S', defined as `\f\g\x((f x) (g x))'.
    My program demonstrates the fact that any lambda expression can be
    translated into an equivalent "combinator expression" which involves
    only `S', `K', `I' (the combinators), and application, with no
    variables or lambda abstractions. In fact, even `I' is unnecessary,
    since it is equivalent to `S K K':

    	I z
    ->	\a(a) z
    ->	z

    	S K K z
    ->	\f\g\x((f x) (g x)) K K z
    ->	(K z) (K z)
    ->	\x\y(x) z (K z)
    ->	z

    The algorithm for translating lambda expressions into combinator
    expressions works as follows. There are three forms of lambda expression
    to consider: variables, applications, and abstractions.

    	trans `v'	-> `v'				(variable)
    	trans `a b'	-> (trans `a') (trans `b')	(application)
    	trans `\ab'	-> abs a (trans `b')		(abstraction)

    There are a further three cases to consider for the body of lambda
    expressions, where we need to do the magic that transforms away the
    variables.

    	abs a `f x'	-> `S' (abs a `f') (abs a `x')
    	abs a `b'	-> `K b'			(b != a)
    	abs a `a'	-> `I'

    E.g. suppose we had combinator expressions for `+' and `3' and we wanted
    to see what the combinator expression for doubling 3 looked like:

    	trans `\x(+ x x) 3'
    ->	(trans `\x(+ x x)') (trans `3')
    ->	(abs x (trans `+ x x')) `3'
    ->	(abs x `+ x x') `3'
    ->	`S' (abs x `+ x') (abs x `x') `3'
    ->	`S' (`S' (abs x `+') (abs x `x')) `I' `3'
    ->	`S' (`S' (`K +') `I') `I' `3'
    ->	`S (S (K +) I) I 3'

    We can then check that this evaluates to the expected result:

    	S (S (K +) I) I 3
    ->	S (K +) I 3 (I 3)
    ->	K + 3 (I 3) (I 3)
    ->	+ (I 3) (I 3)
    ->	+ 3 3

    It is possible to perform a slightly more compact translation with a
    couple of simple optimisations. For example, note that `K (a b)' is the
    same as `S (K a) (K b)', because

    	K (a b) x
    ->	a b

    and

    	S (K a) (K b) x
    ->	K a x (K b x)
    ->	a b

    Also, `S (K a) I' is the same as just `a' because

    	S (K a) I x
    ->	K a x (I x)
    ->	a x

    The program simply reads a lambda expression from the standard input,
    translates it into a combinator expression using the transformation and
    optimisations described above, and prints out the result.


    Why this is a practical application
    ===================================

    Combinator expressions are easier to evaluate than lambda expressions
    because there are no problems with variables. For example, if I naively
    evaluated the expression `\x\y(x y) y' I might get `\y(y y)' which is
    not the same as the correct result because the first `y' in the body
    should refer to a global `y' rather than the local one. David Turner was
    the first person to realise that because of this fact, SK combinators
    provide a simple way to implement non-strict functional programming
    languages, either in software or directly in hardware.

    My program demonstrates this by being based on a combinator evaluation
    engine which is used to implement a language called "OFL" (pronounced
    like "offal" and short for "Obfuscated Functional Language"). I then
    used OFL to implement all the high-level functionality described above.
    This contributes a lot to the obfuscation because even small amounts of
    OFL are quite unpalatable, and large expressions are completely
    incomprehensible.

    It is fairly well known that the lambda calculus (and hence SK
    combinators) can compute anything, but mere computation is no use if you
    cannot communicate with the world. This is why OFL includes a few
    concessions to reality: a combinator `E' for representing characters and
    testing them for equality, two IO combinators, `G' and `P', for reading
    and writing characters respectively, and a combinator `J' for
    representing "false". I also implemented the `Y' combinator directly
    rather than in terms of the primitive combinators, since it only
    required five characters to do so (viz. `Y W q Q g'). However this code
    is not enabled because the definition of Y in terms of other combinators
    is more cute.

    The `E' combinator comes in a large number of forms, one for each
    character and one for end of file. It is written `E(c)' for the variant
    of `E' corresponding to the character `c'. An expression of the form
    `E(c) x' is evaluated by first evaluating `x'. If `x' doesn't evaluate
    to some form of `E', then evaluation of the expression terminates. If
    `x' evaluates to `E(c)', then the expression evaluates to `K'. If `x'
    evaluates to `E(d)' (where `d' is a different character to `c'), then
    the expression evaluates to `J'.

    `K' and `J' are used to represent "true" and "false" respectively; they
    correspond exactly to the standard lambda calculus representations of
    true and false, viz. `\t\f(t)' and `\t\f(f)' respectively. In this way a
    conditional expression can just be written `cond then else', which is
    even more terse than C's `cond ? then : else'. An expression that
    compares a character with `a', say, can be written in the rather
    obfuscated form `E('a') char then else'.

    The `P' combinator, like the `E' combinator, starts off by evaluating
    its first argument and checking that it is some form of `E'. It then
    writes that character on stdout, and finally it calls its second
    argument as a function with the argument `I', i.e.
    	P x f  ->  f I
    with a side-effect.

    The `G' combinator just reads a character from stdin then calls its
    argument as a function with the appropriate `E' combinator as an
    argument, i.e.
    	G f  ->  f E(c)
    with a side-effect.

    One of the problems with non-strict languages is that it is hard to
    predict in advance in which order side-effects will occur. In my program
    I used a monadic IO structure like that used by the programming language
    Haskell; this allows one to write programs that manipulate external
    state in a manner remarkably similar to imperative programming languages
    like C. An examination of my program should provide an illustration of
    how well this technique works in practice. (In particular, I used the
    CPS form of the IO monad from page 6 of "Imperative Functional
    Programming".)

    The `Y' combinator is used for implementing recursive functions. It has
    the evaluation rule
    	Y f  ->  f (Y f)
    so that it can be used to call a function with itself as an argument.
    For example, if I had the appropriate arithmetic operators defined, I
    could write a factorial function in the lambda calculus like this:
    	Y \f\n((= n 0) 1 (* n (f (- n 1))))

    OFL provides a facility for naming expressions so that they can be used
    more than once without writing them in full. A definition must be written
    on one line in the form `l name b expression' where `l' is short for
    "let" and `b' is short for "be". Names must be more than one character
    long. A complete OFL program starts off by defining the primitives it
    will use with likes of the form `p (S)' etc., then goes on to define the
    names it will use, and finishes off with the main expression followed by
    a single `e' short for "end". OFL expressions must use the minimum
    number of brackets needed to be unambiguous, except that the whole
    expression must be surrounded by brackets.

    OFL has a standard library which adds another five combinators to the
    basic eight. These combinators provide greater scope for optimisation
    when translating an expression from the lambda calculus to combinators,
    and therefore more compact programs. Their evaluation rules are:

    	B    f g x   ->      f    (g x)
    	C    f g x   ->     (f x)  g
    	BB c f g x   ->   c (f    (g x))
    	CC c f g x   ->   c (f x)  g
    	SS c f g x   ->   c (f x) (g x)

    I used them to help fit my program into the required space; unfortunately
    I couldn't fit the version that fully optimises the lambda expressions
    it reads into the required space. The complete optimisation rules
    including the ones it doesn't use are:

    	S  (K p)       I      ->       p
    	S  (K p)    (K r)     ->   K ( p   r )
    	S  (K p)    (B r s)   ->   BB  p   r s
    	S  (K p)       r      ->   B   p   r
    	S  (B p q)  (K r)     ->   CC  p q r
    	S     p     (K r)     ->   C   p   r
    	S  (B p q)     r      ->   SS  p q r
    	S     p        r      ->   S   p   r


    The implementation of OFL
    =========================

    Although OFL has completely different syntax and semantics to C, all you
    need to compile OFL programs is a C compiler and a header file (which in
    my entry to the competition has been included in-line). The header file
    implements a two-pass optimising compiler which produces a representation
    of the program that is then interpreted.

    The first pass of the compiler is implemented via the C preprocessor. It
    implements one optimisation, namely function in-lining. Unfortunately,
    this optimisation always increases object code size and execution time.
    The opposite optimisation, common sub-expression elimination, (which
    would offer improvements in code size and execution time) has not been
    implemented. The output of this pass is a C program that may be compiled
    by a normal C compiler.

    The second pass is performed by the initialisation phase of the C
    program. It builds a data structure representing the abstract syntax
    tree of the program.

    The program is then executed by an interpreter. This operates by
    performing manipulations on the AST that correspond to the evaluation
    rules of the combinators that I described above.

    The first 54 lines of the program are mostly the interpreter; the next 8
    lines are pass one of the compiler; the next nine declare the OFL
    primitives; the next five define the OFL standard library; and the rest
    implement the application described in the first part of this document.
    This part of the program is transformed into the second pass of the
    compiler by the first pass of the compiler.

    The first pass of the compiler relies on some magic macros that expand
    in a mutually-overlapping and almost recursive way in order to
    perpetrate a complete change of syntax. Interestingly enough, if I
    hadn't used the same identifier for more than one thing in various
    places in the program this transformation would work with old-style cpp
    as well and ANSI cpp. It expands the program from about 2.2KB to about
    740KB. The resulting code does some tricky stuff to build a data
    structure of the same form as the code itself.

    The interpreter is written in fairly straightforward C, although it is
    highly compressed. The C itself is written in a fairly functional style,
    in that every function consists of a single expression. In the tradition
    of functional programming languages it assumes that memory is infinite
    and so never frees anything. It also assumes that the C compiler
    implements the tail recursion optimisation, which is probably not true.


    References
    ==========

    I used these references in the course of writing this program and they
    explain some of the ideas behind it in more detail. Arthur Norman (one
    of the authors of the first paper) did a lot to enthuse me about this
    topic.

    Clarke, T. J. W., et al., 1980. SKIM - the S, K, I Reduction Machine.
    Proceedings of the 1980 ACM LISP Conference, pp. 128-135.

    Curry, H. B. and Feys, R., 1958. Combinatory Logic, Vol. 1.
    North-Holland.

    Gordon, M. J. C., 1988. Programming Language Theory and its
    Implementation. Prentice-Hall.

    Peterson, J, et al., 1997. Report on the Programming Language Haskell,
    version 1.4.

    Peyton Jones, S. L., 1987. The implementation of Functional
    Programming Languages, Chapters 2, 11, 12, 16. Prentice-Hall.

    Peyton Jones, S. L., and Wadler, P., 1992. Imperative Functional
    Programming. Proceedings of the ACM Symposium on the Principles of
    Programming Languages 1993, pp. 71-84.

    Turner, D. A., 1979. A new implementation technique for applicative
    languages. Software- Practice and Experience. Vol. 9, pp. 31-49.

    Turner, D. A., 1979. Another algorithm for bracket abstraction. Journal
    of Symbolic Logic. Vol. 44, no. 2, pp. 67-270.

    Wadler, P., 1990. Comprehending Monads. Proceedings of the ACM
    conference on Lisp and Functional Programming, 1990.

    Wadler, P., 1995. How to Declare an Imperative. Proceedings of the ACM
    International Logic Programming Symposium, 1995.
