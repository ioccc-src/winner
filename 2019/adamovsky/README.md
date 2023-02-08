# Most functional interpreter

Ondřej Adamovský <oa@cmail.cz>  


## Judges' comments:
### To use:

    make prog
    ./prog file.unl

### Try:

    ./prog spam.unl

    ./prog sierpinski.unl | less

    ./prog advent.unl

### Selected Judges Remarks:

Even after pre-processing and indenting, the C code of this entry
is about as understandable as the Unlambda code.

Pretending that we don't know a bit of functional programming :) and lacking a better way
to understand the entry but to fuzz it,
we stumbled on a string of bytes which crashed it:

    ````.0`.0`.0`c.0``sssss

Functional programming is not a panacea against core dumps, after all.

## Author's comments:
**&#187;A highly structured state state machine&#171;**

### Purpose ###

The purpose of this program is to allow you to play Colossal Cave Adventure as
implemented by [Kunihiko Sakamoto][1]. As that was written in [Unlambda programming
language][2] designed by David Alexander Madore it has to be an Unlambda interpreter.

### Aesthetics ###

The program grew a bit too long so I had to use several macros to downsize it.
That unfortunately reduced my options for program layout. I decided to separate
it into two portions. The initial macro section where I had limited resources and
you should disregard its shape, unless you like it, and the rest is a separator in the
form of a single line followed by a section signifying the function of the program,
a block with removed shape of lambda character. Even the official IOCCC size tool
acknowledges this: When you call `./iocccsize -i <prog.c`, using the
[2019 version of iocccsize](https://www.ioccc.org/2019/iocccsize.c),
iocccsize returns **955**, which is the Unicode codepoint of the **&#955;** character.

It might be a surprise for you that according to the IOCCC size tool the program is
actually a *oneliner*. It certainly was for me. I like to think the tool is overwhelmed
by the sheer length of the dividing line and totally overlooks the rest of the program.

### Usage ###

When built directly

    make

the program (*prog*) accepts a single parameter with the name of an Unlambda program. You can
download the [Colossal Cave Adventure][1] (the *advent.unl* file) and run it like this

    ./prog advent.unl

You can also try other programs from the Web. Many example programs are in the official
[Unlambda distribution][3] on the Unlambda homepage. The most complex programs there are
entries from [quine contest][4].

There is an alternative build path that requires IOCCC size tool to complete. Put the tool
source *iocccsize.c* in the project directory and call

    make identify

It will build the tool and use it to build an alternative program *prog2*, which in turn will
produce an Unlambda program *identify.unl*. `make identify` runs this program to identify
itself.

The base program (*prog*) implements an interpreter of Unlambda 2.0. It recognises all its
builtins (k, s, i, v, c, d, .*x*, e, @, ?*x* and |) including the syntactic sugar function
(&#8203;r&#8203;) and formating properties in the form of ignoring whitespace and comments
to the end of line introduced by the *#* character.

In case of wrong usage (missing Unlambda program file or missing parameter) or use of an unseekable
Unlambda program source if it uses the *c* function, the program returns message *fail*. It
also informs you about syntactic errors in the Unlambda program should there be any (but only
when the execution reaches them).

The Unlambda source file may contain several Unlambda programs. The interpreter will run
them all in sequence.

### Unlambda ###

If you want to familiarise yourself with the language, visit its [Wikipedia page][5] for
a brief introduction or its [homepage][2] for an indepth discussion. For further reading you
can visit Wikipedia pages on [Lambda Calculus][6] and [Combinatory Logic][7].

You can also play with an [online interpreter][8] by Github user inazz. There you can
debug one of example programs provided or try your wits in writing your own.

### Hints ###

Here are some pointers where to start when trying to understand the interpreter:

-	Where is syntax error detected?
-	How is the memory managed?
-	How does a program character turn into a function?
-	How does exit function *e* work?
-	Can fD0 function be called?
-	Are the function names familiar? (warning: some are misleading)

### Obfuscation sources ###

-	The elephant in the room is the Unlambda language. As we all know, functional
	programming defies sanity. Furthermore, Unlambda was specifically designed
	to be unintelligible and hard to code in. Most of its functions are quite
	simple and straightforward to implement, but two make it a mess: the promise
	operator *d* and the call with current continuation *c*.
-	Most of the additional obfuscation is derived from basic design choices. That
	is, how the state of the program is stored and how are the Unlambda functions
	implemented.

More on this in the Spoilers section.

### Build notes ###

The program does not require any special treatment by compilers. Some warnings
had to be suppressed when compiling with `-Wall -Wextra -pedantic`. Those were
produced because of the formatting of the source code, not any programming
technique. Compilation with `-Weverything` produced many more warnings, but those
are only relevant for multi-source-file projects and some are really questionable
(e.g. `-Wdisabled-macro-expansion`).

### Portability ###

Development was done on Debian 9 on x86-64 architecture using mainly Clang 3.8.1-24
and GCC 6.3.0. The source is C11 compliant and does not use any special properties
except the following:

-	The interpreter sort of relies on tail call optimization. It works well even
	without it, but the stack runs out quickly with some Unlambda programs (e.g. *trivial.unl*
	example from the [reference Unlambda distribution][3] produces segfault).
	Clang with `-O3` option does this optimization well and said example does
	not segfault with it. I was not able to force GCC to optimize it out (probably
	an operator fault).
-	The only data structure of the program (the union structure) had much more
	members originally. I joined all integers to a single long long member in the name
	of obfuscation. It is used for reference counting (only 1 for every reference) among
	other uses. size_t should be used for that, but practically, I think the memory
	would run out sooner than the reference counter in any real world situation
	even when size_t is bigger than long long. It is also used for storing chars
	for later printing. This might produce some warnings, but since it was developed
	using chars it should be always used safely.

### Spoilers ###

-	You can examine the *progSpoiler.c* file. It is the original final version of
	the interpreter, before I started the downsizing. It accepts one more optional
	parameter that specifies filename for the output Unlambda function (it's the
	Unlambda function, that remains after all function applications are done).
	When no filename is provided, *stderr* is used.

	The function *output* is used for this additional functionality. You can use
	it while debugging to visualise current variables.

-	The Unlambda functions are represented by a record consisting of an array of five
	multipurpose arguments. The first one refers to the function implementing its
	application, the second and the third ones are for arguments of the function,
	the fourth one is for stack building, and the fifth one is the reference counter.

	The function argument is used not only for evaluation of the functions, but also
	as a state variable to decide whether we want to call it, or do something else.

-	The interpreter reads the Unlambda source as it interprets it, translating
	the incoming character to a function using a constructor stored in translation array *T*.

	This means the interpreter must reposition in the source file whenever current
	continuation is called.

-	The state of the interpreter is represented by trees representing evaluated
	Unlambda functions stored on the C stack as local variables, plus the source file
	position. When a current continuation is created, the stack is unwound using the
	fourth argument of the nodes, stored in the continuation, and rebuilt back resuming
	the evaluation. When its called, the stack is unwound and thrown away, and the
	stack stored in the continuation is restored.

 	This makes implementation of a complete debugger a bit more challenging.

	For this to work, the functions that do the work (i.e. make series of applications
	and/or evaluations each of which may be a call to current continuation), the *s*
	combinator and the *`* application operation had to be broken down to pieces, one
	for each application/evaluation and corresponding helper functions for stack
	rebuilding. (the helper functions are named beginning with *r* instead of *f*)

-	The *`* application operation does the reading of the Unlambda source when needed. It
	also implements the promise function. Whenever it would apply it, it overwrites
	the Apply constructor in translation array *T*, changing its function to build
	unevaluated subtree that is later evaluated whenever the promise is applied.

-	To further the obfuscation, I shortened the function names while downsizing,
	but preserved their meaning (with the exception of Apply functions, which I
	renamed to Y to possibly confuse with Y combinator). Simple functions retained
	their names to misguide the reader to believe to know what is what. The names
	of continuation and exit functions were swapped. The names of S and Apply
	functions were shuffled both for S functions and Apply functions in the same way
	to hide the meaning of *f* and *r* prefixes.

### Identification spoiler ###

The alternative build path `make identify` output commemorates a [previous IOCCC winner][9] which uses
similar methods to mess with the size tool.

### Judges remarks spoilers ###

It is not a bug, it is a feature. :)

The crash is caused by a stack overflow. Conventional Unlabmda interpreters implement
the Unlambda execution stack using data structures on the heap. This interpreter uses
the C call stack for this purpose. In a conventional interpreter, the judges program would
consume memory until the user (or the operating system) would lose patience. The C call stack
is usually of a limited size and protected, so this interpreter crashes, when the judges
program depletes the stack. You can always increase the maximal stack size through
the system settings (on Linux) or compiler options (on Windows) if your Unlambda program
needs it. Nevertheless, it will not help the judges program which quickly depletes any limit
you define.

The judges, pretending not to know what they are doing, created a program that grows
Unlambda execution stack indefinitely. You may consider it an Unlambda antipattern.
Normally, infinite cycles in Unlambda work by creating two functions and applying one
to the other which creates further functions to apply. The application of the function
frees its position on the stack. This program builds one ever growing function that will
never be complete and able to be applied.

[1]: https://github.com/irori/advent-unlambda                "Adventure"
[2]: http://www.madore.org/~david/programs/unlambda/         "Unlambda programming language"
[3]: http://www.madore.org/~david/programs/unlambda/#distrib "Reference Unlambda distribution"
[4]: http://www.madore.org/~david/programs/unlambda/#quine   "Unlambda quine contest"
[5]: https://en.wikipedia.org/wiki/Unlambda                  "Unlambda on Wikipedia"
[6]: https://en.wikipedia.org/wiki/Lambda_calculus           "Lambda Calculus on Wikipedia"
[7]: https://en.wikipedia.org/wiki/Combinatory_logic         "Combinatory Logic on Wikipedia"
[8]: https://inazz.jp/unlambda/                              "Online Unlambda interpreter"
[9]: http://ioccc.org/2014/birken/hint.html                  "Best use of port 1701"

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
