Best Of Show:

	Daniel J. Bernstein
	New York University


Judges' comments:

    Make and run.  Try:

	make brnstnd
	brnstnd < sorta.i2+2

    For info on more examples, read the sorta.README file.

    The author wished to win the "most useful program" award and
    documented this in the source code.  The judges were unmoved
    by this blatant attempt to influence the contest and rejected
    this idea...  so we gave it the Best of Show award instead!!

    NOTE: Due to minor problems with some ANSI C compilers, we have
	  supplied a more portable ANSI version.  See the top level
	  README file for details.

    NOTE: One should remove the final trailing newline to obtain the
	  original source file.  This step is not needed to compile
	  this entry.

    
Selected notes from the author:

    This is an interpreter for the programming language SORTA, a systems
    and numerical programming language with features sorta from C, sorta
    from FORTH, and sorta from Ada.

    SORTA lets you manipulate files and spawn programs easily, has bitwise
    operators, and gives you absolutely brilliant error messages like '?'
    (that's the C bit). SORTA programs work with a stack (that's the FORTH
    bit)---actually two stacks, one for integers and one for strings. And
    all SORTA operations are strongly typed, detect practically any failure,
    and garbage-collect (that's the Ada bit).

    SORTA also contains features you might not expect from such a small
    interpreter: arbitrary-length string input and concatenation, for
    instance, not to mention infinite-depth tail recursion.

    SORTA ignores its arguments (though it makes them available to the
    script); it takes all commands, character by character, from its
    standard input. Unrecognized commands are repeated with a ?.

    SORTA maintains an ``i stack'' for integers and an ``s stack'' for
    strings. It also keeps track of ``programs,'' one for each character.
    Operations are silently ignored if the relevant stacks are too low,
    except as noted for s, S, and !. If the i stack or s stack (or the stack
    of buffered macro commands) grows too high, SORTA will exit silently
    with exit code 2. (Compile parameter -Do=250 controls what ``too high''
    means; you should not make o larger than 250.) I don't think it's
    possible to crash the interpreter.

    Here, then, is the SORTA programming language. All non-digits delimit
    numeric constants. Spaces and newlines are ignored except as numeric
    delimiters.

    Basic operations:

     q: quit
     number: push that number on top of the i stack
     "string": push that string on top of the s stack, no length limit
     [string]: push that string on top of the s stack, no length limit
     #: make top of i stack non-destructively in ASCII, push result onto s stack
     `: print top of s stack non-destructively
     $: print top of s stack non-destructively without newline
     d: drop (pop) top of i stack
     D: dup (duplicate) top of i stack
     ': dup top of s stack
     s: pop top of i stack. If it is n, swap (n+1)th-top of i stack with top.
        1s, for example, swaps the top two elements; 2s swaps the top with
        the third down; etc. This always pops the top of the i stack, even
	upon failure.
     S: pop top of i stack, then act just like s but upon s stack
     l: pop top of s stack, push its length onto i stack
     a: push argc onto i stack
     A: pop top of i stack, push argv[i] on top of s stack
     T: concatenate top two elements of s stack
     _: negate top of i stack
     +: pop top two elements of i stack, add, push back sum
     *: pop top two elements of i stack, multiply, push back product
     /: pop top two elements of i stack, divide, push back quotient
     >: pop top two elements of i stack, compare, push back 1 or 0 as in C
     &: pop top two elements of i stack, nand, push back bitwise result
	Note that nand is sufficient to construct all bitwise operations,
	as demonstrated by icalc below.

   System operations:

     o: pop top of s stack and top two of i stack; open(s1,i2,i1); leave
	result on i stack
     O: pop top of i stack, close() it
     u: pop top of i stack, dup() it, push result back on
     F: fork(), push result on i stack. This is not always safe while SORTA
	is reading keyboard input or a script, as the forked programs share
	file descriptors. It is always safe inside a program (see below).
     P: pipe(), push two ends <p0> <p1> onto i stack. In case of trouble,
	push <?> <-1> onto i stack.
     w: wait(), push successful result (or -1 if no children) on i stack
     !: execvp() top of the s stack. Arguments are the next things down on
	the s stack, in reverse order from popping; the first character of
	each string is lopped off. There must be an empty string somewhere
	in the s stack to terminate the argument list. If the execve()
	fails, any operation involving current members of the s stack has
	undefined effects, and -1 is pushed onto the i stack.

   High-level language operations:

     :x: copy the top of the s stack into a program labeled by character x
     =x: pop the top of the i stack. If it was nonzero, execute the program
	 labeled by character x. Note that a digit at the end of a program
	 will merge with any digits after =x; in that case you usually want
	 to add a space at the end of the program.

    Common idioms: To drop the top of the s stack, ld. To do a <, 1s>. To
    unconditionally execute the program labeled by character x, 1=x (or any
    nonzero number followed by =x). To print the top of the i stack
    non-destructively, #` (or #$ if you don't want the newline). To
    subtract, _+. To do mod or and or any of the other missing operations,
    combine the available operations as illustrated below. To introduce a
    comment, [ this is a comment string which is promptly eliminated ]ld.

    SORTA's requirements: it wants fork(), execvp(), open(),
    close(), dup(), pipe(), and wait(), so it obviously won't even compile
    on a non-UNIX machine. It also assumes that you have a size-256
    character set and that the characters between '0' and '9' are exactly
    the digits in order. It does *not* depend on ASCII, despite the code
    appearance. Also note that SORTA does not attempt to declare malloc(),
    so you will get some warnings about illegal pointer combinations. Also
    note that there are unreached statements in SORTA.

    While the program source of course depends highly on #defines for
    obfuscation, I like to think that this code has those little touches,
    those professionally sharpened edges that mark true software
    engineering. Observe, for instance, how i and s are the string and
    integer stacks respectively. It's these little things that make you
    feel at home in an otherwise utterly useless piece of code. They're
    what make an obfuscation work.

    The character pool (``I'' after cpp) makes it rather painful to
    see the effect of commands at a glance. I can just imagine people
    spending hours bouncing between the pool and the rest of the code,
    or accidentally changing the pool without realizing its importance.
    Without documentation and example scripts, someone would find it
    a challenge to figure out what the arrays are used for, let alone
    that SORTA is a scripting language.

    Another nice feature is that the SORTA language itself encourages
    you to write not merely obfuscated but plain incomprehensible
    scripts (like the examples below---after working with the language
    for a while, I guess I can read it pretty easily, but I also think
    FORTH is a beautiful language). The numbers running around
    everywhere will make people think of ASCII, even though the code is
    not ASCII-dependent.  What's your first thought when you see
    several arrays[256]? This is pretty standard obfuscation otherwise.
    I like the way that unbalanced macro braces can throw off the
    reader in ``if(c>0){y+1]=z[c];'', and I had fun covering the
    alphabet with #defines, but that's nothing special.

    Possible future extensions to SORTA include string extraction and
    matching, reading from files into strings, and encrypting the string
    pool to further confuse the judges. I don't think I can fit this into
    the size limit, unfortunately.

Copyright (c) 1991, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
