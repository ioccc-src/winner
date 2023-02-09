# Most surprisingly portable

Gregor Richards  
<Richards@codu.org>  


## Judges' comments:
### To build:

    make richards

### To run:

    ./richards

### Try:

    echo '10 9 8 7 6 5 4 3 2 1*p*p*p*p*p*p*p*p*p' | ./richards

### Selected Judges Remarks:

Oh no, yet another dc-style calculator? (see 2000/dlowe using an embedded Perl
interpreter and deemed Worst Abuse of the Rules). 
Well, this one does it (expression calculation, that is, not the rule abuse) in a different way. 
The author claims that his calculator does just-in-time compilation.
What would you do to prove or disprove his claim without attempting to unravel the source?

## Author's comments:
This is an implementation of the classic UNIX dc command, the reverse-polish
calculator. Actually it's a pretty bad implementation, since it only implements
32-bit integers (well, sizeof(int)-sized integers). It only implements the
commands +, -, *, /, p (only for numbers), register stacks, macros and
comparisons. Wow, you'd think I could've done better in 2K of code.

OH! I forgot to mention! It's a JIT.

Wait, don't stop reading! I know what you're thinking, platform-specific code
is discouraged in IOCCC. But do you see any platform-specific code? There's no
assembler here! This JIT works on a dozen platforms, and the only
platform-specific assumptions it makes are that the stack grows down and
integers are at least 32-bit.

You will probably get warnings while compiling the code. In particular:

 * If your system requires the inclusion of alloca.h to use alloca, use the
   compile flag -DAH
 * If your system cannot use mmap, use the compile flag -DNM
 * I don't include any headers I don't strictly need to, so you'll get warnings
   about (at least) memcpy, isdigit, atoi, calloc, malloc and alloca if you
   didn't use -DAH.
 * GCC likes to complain about while (a = b) (assignments as a condition).
 * I don't return from main, even though it's declared to return int.

Platforms on which all known/tested optimization levels work with no additional
flags:

 * gcc 4.6.2 + x86[_64] + GNU/Linux, Mac OS X or Windows
 * clang 2.9-16 + x86[_64] + GNU/Linux or Mac OS X
 * tcc 0.9.25
 * gcc 4.4.5 + alpha, arm, mips[el], powerpc[64], s390x (IBM zSeries)
 * gcc 4.1.3 + vax + NetBSD

Platforms which work but not at all optimization levels or needing special
flags:

 * owcc 1.9 + x86 + Windows: Needs -DNM -DAH -fno-stack-check
 * gcc 4.4.5 + sh4: -O0 works, higher optimization levels don't work for unknown reasons.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
