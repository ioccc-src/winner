# Most Useful

Dave Burton <ioccc@snox.net>  
<http://snox.net/ioccc>  


## Judges' comments:
### To use:

    make
    
    ./prog "expression"

or

    ./prog
    (input expressions)
       
### Try:

    ./prog '?0x3343<<2'

    echo '?0x3343<<2' | ./prog

    ./prog

    Enter:

	a=0xfeedface
	b=0xcafe
	a << 16 + b

    grep '[0-9]' prog.c

    ./prog < test.in

    less calc.man

### Selected Judges Remarks:

"Look, Ma, no ~~hands~~ digits!"

The place where some arithmetic operations are done, for example,
division or modulo, are easy to find. Where are addition and subtraction?

We were impressed with the level of detail the author "blogged" the obfuscation process.



## Author's comments:
calc - an integer expression calculator that outputs in both hex and decimal
----------------------------------------------------------------------------

All useful tools should include sufficient documentation.
See the included man page. ;-)

Notes
-----

This program is named calc.  Onomatopoeia of sorts, in the visual realm.
The formatting was easier: Form Follows Function (although [Hou][1] did this better).
It was tempting to call it iCalc, with i for integer (and it was written on an iDevice),
but sanity prevailed.

Printed in 8 pt Courier, it makes aesthetically pleasing 8.5 x 11 wall art.

[1]: http://www.ioccc.org/2011/hou/hint.html "Hou Qiming"

prog.c vs prog.orig.c
---------------------

Dominik Muth observed a syntax error on `1+1`, `1-1`, `1|1`, and `1^1` when using an
ARM based computer, although `1*1` and others worked correctly.
This occurs because some platforms by default treat `char` as `unsigned char`.
The original code has this weakness, which can be corrected by adding `-fsigned-char`
to the compile line.
The modified code is agnostic to `char` signed-ness.

Why is this entry obfuscated/interesting?
-----------------------------------------

Yes, this is another calculator program.

However, unlike any other calculator source code the author is aware of,
this one contains no digits.  At all.  Anywhere.  As in

	grep '[0-9]' prog.c || echo no digits!

Nor are the digits simply obfuscated.  There are no character constants.
There is only one single, short string, and it does not contain any obfuscated digits.
And yet the output is in decimal and hexadecimal, and it accepts octal, decimal, and hex input.

Flow control is by `for` and `return`.  It is If-less.  Switch-less.  While-less.  Hope-less.   
Literally, if not figuratively. ;-)

The code size is intentionally 2015, as stated by iocccsize -i,
and can be reformatted without changes (as in rule2.c) to exactly 4096 octets.

Finally, calc is interesting, if for no other reason than it is practically useful:
Hex/decimal conversion, arithmetic, byte-swapping, bit-shifting, and logical operations with memory,
on the command line, or interactively.

But the question is why is the entry obfuscated?
------------------------------------------------

The code follows many industry best-practices:

- You know what it does just by looking at it.

- Numbers and digits have often been used for obfuscation,
  so in a bid for better clarity, this code has no digits at all.

- In the spirit of clarity, most of the variables are declared before use, so they
  are readily visible, with single letter names that don't clutter the screen,
  in a tautological arrangement.

- More helpful is the use of `typedef`s instead of `#define`, so the types remain useful
  even in the debugger, and source code beautifiers will not undo careful presentation.

- `#defines` are used here in the best spirit of the preprocessor: to shorten
  repetitive constructs, not for obscurity.

- All functions are short (and therefore easy to understand?) and do only one thing, well, ....

- Curly braces invite endless holy wars over readability.  This code only uses them
  for function definitions, thereby greatly improving readability, and reducing arguments
  about said readability.

- One of C's many blessings (until recently) is a modicum of keywords,
  of which only 8 are used:
  `for`, `return`, `typedef`, `void`, `char`, `short`, `unsigned` and `long`;
  10 if `#include` and `#define` are counted.

- The code helpfully declares "syntax_error!" right up front, filling the reader with confidence.

- In spite of its inherent clarity, the code was presented to both *indent*(1) and
  *clang-format*(1), after running it through the preprocessor, sustaining its better qualities.

- That the code is obfuscated is spelled out two different ways in the source; it helps
  to reformat the code to see the second spelling.

- The author is overly fond of the code that handles input.
  There is no memory allocation, nor pre-allocation of arrays, so where does the
  memory come from?  The multi-base strtol() code is pretty trick.
  No special attempt was made to replace operations with obscure mathematical relations,
  as the (lack of) beauty is in the parsing -- ask not where is the modulus operation,
  but how does it know when to mod -- okay, but where is add and subtract?
  And really, who doesn't enjoy a setjmp() in the argument list?

- Finally, documentation of the source code structure is helpfully provided in rot13 format.
  But isn't it unsportsmanlike to rely upon it?  However, even with this helpful guide,
  things like reading input lines remain as tricky to read as they are to write.

Compiler warnings
-----------------

Calc is C99 compliant, and is ANSI/C90 compliant except for wanting 64-bit `long long`.
Changing the two `long long` typedefs to `long`, and compiling with `gcc -m32`
yields a program that operates on 32-bit values, with wrap-around of shifts mod 32:

	1<<48
	65536	0x00010000

gcc 4.2.1 without arguments compiles cleanly (e.g. cc prog.c -o prog).
This is my workaday compiler.  gcc is also clean with -ansi, and -std=c99.

clang 3.6.0 lives up to its namesake, resounding on non-problems.
To stifle these complaints:
	-Wno-return-type -Wno-parentheses -Wno-empty-body

When invoked with -ansi -pedantic, there are two warnings, which can be ignored:

  * `ISO C90 does not support 'long long'`   

With -Wall -std=c99, both are quite noisy, and all can be ignored:

  * `array subscript has type 'char' [-Wchar-subscripts]`   
  * `value computed is not used [-Wunused-value]`   
  * `operation on 'j' may be undefined [-Wsequence-point]`   

Test Suite
----------

If the program name begins with an "e", it echoes stdin to stdout.
This allows for a convenient test suite:

	ln -s prog eprog
	PATH=. eprog < test.in | diff - test.out

Spoilers
--------

If you do not want to puzzle out how it works, see spoilers.markdown.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
