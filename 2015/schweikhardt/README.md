# Best Documented

Jens Schweikhardt  
<http://www.schweikhardt.net>  


## Judges' comments:
### To use:

    make

    ./prog n

    where n is a base 16 number of any size

### Try:

    ./prog 19


### Selected Judges Remarks:

This code is clean.  When you compile with all warnings enabled,
such as with clang:

   cc -Weverything -pedantic -std=c11 -Dtyp=uint64\_t -O3 prog.c -o prog

The code compiles without warnings on the systems that we tested!

Even more, the code was 100% clean when we ran it against various
static source checkers.

This tool references a problem that David I. Bell once described
as having one of the largest "yummo quotients" in number theory:

                         complexity of the solution
    yummo quotient = -----------------------------------
                     complexity of the problem statement

Erdős privately told one of the IOCCC judges:

"Solving the [Generalized Riemann hypothesis](https://en.wikipedia.org/wiki/Generalized_Riemann_hypothesis#Extended_Riemann_hypothesis_.28ERH.29)
would be a good warmup exercise for someone to get ready
to begin to work on the [Collatz conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture)."

You may explore this famous conjecture using this entry:

    ./prog 2410
    ./prog abfff
    ./prog 27f8cebf
    ./prog 246f8fddf
    ./prog 2e95ab51ffea9de
    ./prog e6a5c22fd7bde9f
    ./prog 1b7dd73a937485bf
    ./prog 7d3237680d190a77e53751b
    ./prog 302ab3d052fb87c06228d249581be0e4

When you first look at the source, the code looks fairly straightforward.
But look again.  Like the Collatz conjecture, simplicity is deceptive!
Oh, and the variable names?  They are not simple single letter variables,
they are names of various [Proteinogenic amino
acid](https://en.wikipedia.org/wiki/Proteinogenic_amino_acid):
which is yet another simple building block that can be used to
build some very complex structures.  :-)

p.s. We appreciated that apart from a few powers of 2, the source
code is magic number free.

## Author's comments:
The TL;DR version
-----------------

This is the cleanest program ever submitted. If for some input it enters
a non-terminating loop or runs out of memory you will be insta-famous.
It's a bit like a lottery without the need to buy a ticket and you can
play as often as you like. One notable historic person has even offered
some prize money.

The program illustrates the bloat caused by adherence to too many rules,
each of which may sound sane in isolation, but in their entirety lead to
an obfuscated, hard to read and understand monster.

What this program does.
-----------------------

The program tests whether a given natural number satisfies the
[Collatz Conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture):

Take any natural number *n*. If *n* is even, divide it by 2 to get *n*/2.
If *n* is odd, multiply it by 3 and add 1 to obtain 3*n* + 1.
Repeat the process indefinitely.
The conjecture is that no matter what number you start with,
you eventually reach 1.

Paul Erdős said about the Collatz conjecture:
"Mathematics may not be ready for such problems."
He also offered $500 for its solution.

For example, the sequence of numbers for *n* = 6 is

>    6, 3, 10, 5, 16, 8, 4, 2, 1.

Continuing past one leads to the *cycle* 1, 4, 2, 1, 4, 2, 1, ...
Interesting factoid: if you allow *negative* start values, there are
a few more cycles, each of different length:

>   −1, −2, −1
>
>   −5, −14, −7, −20, −10, −5
>
>   −17, −50, −25, −74, −37, −110, −55, −164, −82, −41, −122, −61, −182, −91, −272, −136, −68, −34, −17

The program computes the sequence for a given positive natural number
and stops at 1. The number *n* is specified in hexadecimal (without 0x
prefix) as the first argument. The program prints the given number in
zero-padded hex and each iteration along with a line count in decimal.
The example above looks like this (compiled with 64 bit word size):

    $ ./prog 6
    0000000000000006
    0000000000000003 1
    000000000000000A 2
    0000000000000005 3
    0000000000000010 4
    0000000000000008 5
    0000000000000004 6
    0000000000000002 7
    0000000000000001 8

The size of *n* is only limited by the argument size limit of your
shell/OS (the program implements arbitrary size bignums).
To query this on your POSIX system, run

    $ getconf ARG_MAX
    262144

which reports the limit in bytes, here 256KB. This allows to test
whether a [Googol](https://en.wikipedia.org/wiki/Googol), which is
10<sup>100</sup>, satisfies the conjecture. But what is a googol in hex?
Fear not,
[bc(1)](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/bc.html)
to the rescue:

    $ printf 'obase=16;10^100\n' | bc
    1249AD2594C37CEB0B2784C4CE0BF38ACE408E211A7CAAB24308A82E8F1000000000\
    0000000000000000
    $ ./prog 1249AD2594C37CEB0B2784C4CE0BF38ACE408E211A7CAAB24308A82E8F10000000000000000000000000 \
    | less
    [...]

Observe how the first 100 iterations melt the zeros to the right. Can you explain
why?

For a given *n* the program behavior is one of the following 3:

1. The sequence stops at 1. No fame. No money. Thanks for playing. Computational
   mathematicians have tested all *n* < 4FFDD776055A0000 (~10<sup>18</sup>)
   so don't try anything less than that.
2. The chosen *n* leads to a sequence with ever bigger numbers,
   so that eventually the bignum cannot be stored in memory. If this happens,
   the program outputs `laugh` (more likely) or `throw up` (less likely) and
   stops. You *might* have found
   a number for which the sequence *diverges*. If confirmed, this disproves the
   conjecture.
3. The chosen *n* leads to a cycle not including 1 (i.e. runs forever,
   repeating the same sequence over and over). You have disproved the
   conjecture and should certainly submit a paper to the nearest
   mathematical journal.


Design objectives
-----------------

I gave myself the following objectives. Like in real world programming,
not all of them can be met 100%. Think of them as a multidimensional
continuum, where trade-offs have to be made.

1. No arbitrary limits on the input number. 64 bits might be enough
   for everybody, but is not enough for exploring new Collatz-territory.
   Thus bignums are required.
2. Ultra-portable. Must run on C89 systems and self-adapt to C99 and C11
   features like exact width types.
3. Super-efficient. Must be able to run with the widest type as the
   base of the bignums. Make the user select the widest type supported
   by the implementation and then crunch away. If a non-standard
   128bit type is available, it should be usable.
4. Pentagon level lint cleanliness and MISRA compliance.
5. Easy to understand, self-documenting clear code. A joy for maintenance
   programmers. The epitome of best practice demonstration for all
   future textbooks on C.

Program Obfuscation
===================

In the following I address all the *tests* as specified by your honors in the
*guidelines*.

 * look at the original source
 * convert ANSI tri-graphs to ASCII
 * C pre-process the source ignoring `#include` lines
 * C pre-process the source ignoring `#define` and `#include` lines
 * run it through a C beautifier
 * examine the algorithm
 * compile it (with flags to enable all warnings)
 * execute it

Look at the original source
---------------------------

Using one letter identifiers is quite old. I decided to use TLI (three
letter identifiers). Not the random kind, rather with a connection to
the meaning of life, the universe and the rest. Enter amino acids! Among
the myriad of possible amino acids there are 23 from which proteins are
built. In biochemistry, each is assigned a TLI (see [Proteinogenic amino
acid](https://en.wikipedia.org/wiki/Proteinogenic_amino_acid)):

	ala	Alanine
	cys	Cysteine
	asp	Aspartic acid
	glu	Glutamic acid
	phe	Phenylalanine
	gly	Glycine
	his	Histidine
	ile	Isoleucine
	lys	Lysine
	leu	Leucine
	met	Methionine
	asn	Asparagine
	pyl	Pyrrolysine
	pro	Proline
	gln	Glutamine
	arg	Arginine
	ser	Serine
	thr	Threonine
	sec	Selenocysteine
	val	Valine
	trp	Tryptophan
	tyr	Tyrosine
	asx	Asparagine or Aspartic acid
	glx	Glutamic acid or Glutamine
	xle	Leucine or Isoleucine
    unk Unknown

My own research results complete this list (not yet in Wikipedia due to
the rule "[No original
research](https://en.wikipedia.org/wiki/Wikipedia:No_original_research)"):

	and	Androgynine
	xor	Xenoricine
	not	Notanamine
	tla	Triletramine

Interestingly, the TLI are the perfect mnemonics for C language source.
For example, `met` is "Main's Exit Type" (`int`), `ala` is "A Large
Algebraic" (bignum), `ile` an "Incremented Local Entity" (index
counter), `gly` means "Grow Larger memorY", `gln` is "Grown Larger Now"
(after realloc), `not` is a "Not Overflowing Type" (recursive!), `unk`
is the "UNit (Known as 1)", `trp` is the "Tabula Rasa Product" (zero),
`phe` is "Print HEx" and so on.

Convert ANSI tri-graphs to ASCII
--------------------------------

Huh??!

C pre-process the source ignoring '#include' lines
--------------------------------------------------

Wow, an identity operation (except for the `<stdint.h>` and `EOF + __STDC__`
trivialities). Did you gain any insight through this?

C pre-process the source ignoring '#define' and '#include' lines
----------------------------------------------------------------

`#define`? Which `#define` directives? How many 4K source files do you
see that neither use a single `#define` directive *nor* abuse the build
file? Even though the "no `#define`" rule I submitted myself to made it
hard, I could use `__LINE__` and stdio macros `EOF`, `L_tmpnam`,
`BUFSIZ`, `FILENAME_MAX`, `TMP_MAX` to obfuscate at least something.

Run it through a C beautifier
-----------------------------

Another identity operation. I've done it for you already. Use this
`.indent.pro` with FreeBSD indent:

	$ cat .indent.pro
    -bad   /* blank line after decls */
    -bap   /* blank line after functions */
    -br    /* braces on if line */
    -i8    /* indent */
    -l999  /* line length */
    -npcs  /* no space after function call names */
    -npsl  /* don't break procedure type */
    -ut    /* use tabs */
    -ce    /* cuddle else */
    -nip   /* no parameter indentation */
    -di1   /* declaration indent */
    -Tand
    -Tmet
    -Tthr
    -Tpro
    -Tser
    -Tala

It looks like a perfect program should:

  *  two and a half `#includes` of unsuspicious standard headers
  *  followed by self protection against goofy implementations
  *  followed by a handful of `typedef`s
  *  and a pair of file scope objects by necessity
  *  prototypes! With parameter names! `static` for internal linkage even! This __must__ be a first in IOCCC history.
  *  function definitions, `main` last
  *  everything is fully const-poisoned: automatics, statics, arguments, even `main`
  *  everything is fully curly braced, even single statements
  *  plenty of meaningful TLC (Three Letter Comments)

The program contains not a single *magic number* (only 0 and powers of
2, each power from 1 to 512) which are obvious to competent software
engineers). How many programs have *that* property? The check for
`__STDC_VERSION__` was a bit tough to arrive at, since 199901L has too
many bits set. But I realized that I only needed a number larger than
199409 and less than 199901. 199680 has only 4 bits set and writing it
as (256 + 128 + 4 + 2) * 512 minimizes the character count. That's what
judges get when they don't like programs that are longer than they need
to be.

Examine the algorithm
---------------------

Spoilers ahead. Duh!

Pseudocode, with comments matching those in the C source:

    /* run */
    if (non-NULL and nonempty argv[1]) {
       n = convert(argv[1])
       print n                       /* 2hx */
       while (n != 1) {              /* one */
          if (n is odd) {            /* odd */
             m = deep copy of n      /* cpy */
             n <<= 1                 /* shl */
             n += m                  /* add */
             increment n             /* inc */
          } else {                   /* eve */
             n >>= 1                 /* shr */
          }
          print n                    /* 2hx */
      }
    }

Bignums are represented as the two member structs

    typedef struct {
         size_t places;   /* number of places in base 2<sup>8*sizeof(type)</sup> */
         type  *number;   /* dynamically allocated memory for number */
    } bignum

Compile it (with flags to enable all warnings)
----------------------------------------------

Here's where the program shines brighter than a [gamma-ray
burst](https://en.wikipedia.org/wiki/Gamma-ray_burst)!

I challenge you to throw all kinds of compilers, lints, checkers and
analyzers at my program and make it find the slightest of issues.

Is `clang -Wall -Wextra -Weverything -Dtyp=uint32_t prog.c` all you can
do? Clang has implemented a new warning? Bring it on!


Execute it
----------

May you win the jackpot!

For least surprising results, the execution character set should be
ASCII. The program computes four bits from every character in `argv[1]` and
interprets them as a hex digit. On ASCII the characters a-f, A-F and 0-9
are converted as expected.

This means however, that the program accepts __any string__, turns it
into a starting number (which is output as the first line), and starts
crunching. Nothing stops you from executing

    $ ./prog "$(cat prog.c)"            # Kind of quine?
    $ ./prog "$(cat rules guidelines)"  # A jackpot? Maybe next year...
    $ ./prog "$(cat /bin/ls)"           # Number cut short at first NUL byte.

In a certain way, the program is character set and encoding agnostic.

Assumptions made
----------------

* The `EOF` macro from `<stdio.h>` must expand to negative one since it is used
  to decrement a pointer and do some other math.
  None of the tools catches this one. The program self-protects against unusual
  systems with `#if EOF + __STDC__` followed by `#error goofy!`. In the rare event
  your system is goofy, replace all `EOF` tokens with `(-1)` and remove the
  `#error` directive.


While the program works best when bytes/characters are octets and the
number of bits in a type is `sizeof(typ) << 3`, it will work correctly
on 24bit or 36bit systems with 9 bits/byte, or systems where
`sizeof(typ)` is 1 even for `int` and so on. On such systems, it will only
use 8 * `sizeof(typ)` bits per place. It does not work when `CHAR_BIT <= 7`.


Results of various checkers
---------------------------

### cppcheck

The open source static checker [cppcheck](http://cppcheck.sourceforge.net/)
checks various problems with respect to style, performance, portability
and general fishiness. To enable all checks, run

    $ cppcheck --enable=all --force -I/usr/include -Dtyp=uint32_t prog.c

No issues found.

### flawfinder

The open source static checker [flawfinder](http://www.dwheeler.com/flawfinder/)
checks various problems with respect to security like buffer overflows,
function arguments to known troublemaker functions and more. It doesn't need to
pre-process code, so can be run without the `typ` macro being defined:

    $ flawfinder prog.c
    Flawfinder version 1.31, (C) 2001-2014 David A. Wheeler.
    Number of rules (primarily dangerous function names) in C/C++ ruleset: 169
    Examining prog.c
    FINAL RESULTS:
    ANALYSIS SUMMARY:
    No hits found.
    $

### valgrind

The open source dynamic checker [valgrind](http://valgrind.org/)
runs an executable and verifies all memory accesses and (de)allocations for
proper bounds and memory leaks.
Since the program frees all memory in all possible execution paths, even when
it must bail out,
valgrind should be happy. An early version of my program however reported this:

    $ valgrind --leak-check=full --show-leak-kinds=all ./prog 6
    [...]
    ==14615== HEAP SUMMARY:
    ==14615==     in use at exit: 4,096 bytes in 1 blocks
    ==14615==   total heap usage: 4 allocs, 3 frees, 4,108 bytes allocated
    ==14615==
    ==14615== 4,096 bytes in 1 blocks are still reachable in loss record 1 of 1
    ==14615==    at 0x4C236C0: malloc (in /usr/local/lib/valgrind/vgpreload_memcheck-amd64-freebsd.so)
    ==14615==    by 0x4F62175: ??? (in /lib/libc.so.7)
    ==14615==    by 0x4F62073: ??? (in /lib/libc.so.7)
    ==14615==    by 0x4F514EE: ??? (in /lib/libc.so.7)
    ==14615==    by 0x4F51265: vfprintf_l (in /lib/libc.so.7)
    ==14615==    by 0x4F3E001: printf (in /lib/libc.so.7)
    ==14615==    by 0x40101E: phe (in ./prog)
    ==14615==    by 0x400A9F: main (in ./prog)
    ==14615==
    ==14615== LEAK SUMMARY:
    ==14615==    definitely lost: 0 bytes in 0 blocks
    ==14615==    indirectly lost: 0 bytes in 0 blocks
    ==14615==      possibly lost: 0 bytes in 0 blocks
    ==14615==    still reachable: 4,096 bytes in 1 blocks
    ==14615==         suppressed: 0 bytes in 0 blocks
    ==14615==
    ==14615== For counts of detected and suppressed errors, rerun with: -v
    ==14615== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

From which I concluded that `printf` allocated a single 4K block for
which no matching free existed. But how to free memory allocated deep
down in the guts of the Standard I/O library? After some serious head
scratching it hit me. The only chance I have is telling the system I no
longer want to do I/O, maybe then it would free that buffer. A reading
of C99 7.19.5.1, "The fclose function", was encouraging:

>  Whether or not the call succeeds, the stream is disassociated from the file
>  and any buffer set by the `setbuf` or `setvbuf` function is disassociated from the stream
>  (and deallocated if it was automatically allocated).

So I `fclose(stdout)` before returning and now:

    $ valgrind --leak-check=full --show-leak-kinds=all ./prog 6
    ==14571== Memcheck, a memory error detector
    ==14571== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
    ==14571== Using Valgrind-3.10.0 and LibVEX; rerun with -h for copyright info
    ==14571== Command: ./prog 6
    ==14571==
    0000000000000006
    0000000000000003 1
    000000000000000A 2
    0000000000000005 3
    0000000000000010 4
    0000000000000008 5
    0000000000000004 6
    0000000000000002 7
    0000000000000001 8
    ==14571==
    ==14571== HEAP SUMMARY:
    ==14571==     in use at exit: 0 bytes in 0 blocks
    ==14571==   total heap usage: 4 allocs, 4 frees, 4,120 bytes allocated
    ==14571==
    ==14571== All heap blocks were freed -- no leaks are possible
    ==14571==
    ==14571== For counts of detected and suppressed errors, rerun with: -v
    ==14571== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

A squeaky clean valgrind result!

### FlexeLint

FlexeLint is a commercial lint tool by [Gimpel
Software](http://www.gimpel.com/html/index.htm). It supports nearly a
thousand checks, broadly categorized into 4 levels,

  1.  Syntax errors only (messages 1 to 399)
  2.  Warnings (messages 400 to 699)
  3.  Informational messages (700 to 899)
  4.  Elective notes (900 to 1000 and > 9000)

There is an [on-line
demonstrator](http://www.gimpel-online.com/OnlineTesting.html) you can
use for checking your C programs and I highly recommend trying it. For a start,
paste the well know first program in the form and press "Analyze Code". Note
the FlexeLint configuration options in comments (no space between `/*` and `lint`).

    /*lint -w4            turn on everything */
    /*lint +esym(534,*)   no demonstrator defaults */
    /*lint -e966          indirectly included header file not used */
    /*lint -esym(9058,_*) tag not used outside typedef */
    /*lint -misra(2)      */

    #include <stdio.h>
    int main(void)
    {
        printf("hello, world\n");
        return 0;
    }


Possible checks include those for MISRA 2004 compliance verification.
The [Motor Industry Software Reliability
Association](https://en.wikipedia.org/wiki/Motor_Industry_Software_Reliability_Association)
has produced a [list of 121 required and 20 advisory
rules](http://doc.hcc-embedded.com/display/CODING/MISRA+Rules) for C
programming. I am proud to report that my program fulfills *almost all*
rules. To assess the few exceptions, one has to understand that MISRA
rules are geared towards embedded systems used in the automotive
industry. That's why features like `malloc` and `printf` are right out.
But that's too restrictive for an IOCCC hosted application, so I ignored
these:

 * 17.1 Pointer arithmetic shall only be applied to pointers that address an array or array element.
 * 17.4 Array indexing shall be the only allowed form of pointer arithmetic.
 * 20.4 Dynamic heap memory allocation shall not be used.
 * 20.9 The input/output library stdio.h shall not be used in production code.
 * 20.11 The functions abort, exit, getenv, and system from the library stdlib.h shall not be used.

I started out with enabling *all* messages using FlexeLint's `-w4`
option and disabling all noise from system headers. Then I dealt with
the remaining messages by addressing them or suppressing them in such a way
that the set of suppressions was minimal. At the end of the day, this is
what remained:


    //  === Tested with FlexeLint 9.00L on FreeBSD 11 ===
    //  Compiler:
    //  "4.2.1 Compatible FreeBSD Clang 3.6.1 (tags/RELEASE_361/final 237755)"

    -w4                          // Enable maximum pickiness
    -passes(6)                   // Recommended in FlexeLint manual for torture testing
    +fsc                         // Make string literals have type const char*
    +fnr                         // ptr-returning functions may return NULL
    -strong(AJX,and,pro,ser,ala) // strong types
    -strong(AcJcm,thr)           // thr is strong, but most arithmetic is okay
    -strong(AarJemorX,met)       // met is strong, but some use is okay
    +libclass(angle)             // All <headers> are system headers
    -wlib(1)                     // Only errors for system headers
    -i/usr/include               // System headers
    -i/usr/local/lib/supp/ansi   // Comes with FlexeLint
    -d__GNUC__=4                 // Pretend...
    -d__GNUC_MINOR__=2           // I'm...
    -d__GNUC_PATCHLEVEL__=1      // someone else.
    -d__builtin_va_list=char*    // Fake this compiler extension
    -d__inline=                  // Delete this compiler extension
    -d__attribute__(x)=          // Delete this compiler extension
    +e900                        // Announce number of messages produced

    //                   MISRA 2004 checking

    /usr/local/lib/supp/lnt/au-misra2.lnt    // Enable all MISRA checking
    -elib(960)       // Don't check FreeBSD system headers for required rules
    -elib(961)       // Don't check FreeBSD system headers for advisory rules
    -e829            // stdio.h used
    -e522            // MISRA 14.2 Highest operation, lacks side-effects
    -esym(960,17.4)  // pointer arithmetic other than array indexing used
    -e971            // char without signed/unsigned
    -e974            // stack usage report
    // Use verboten functions, Req. Rules 20.4 malloc() et al., 20.11, exit()
    -esym(586,malloc,realloc,calloc,free,exit)

    -e911            // implicit promotion of smaller than int to int
    -e921            // cast from integral to integral
    -e925            // cast from pointer to pointer
    -e958            // padding required in struct

    +e9???           // Enable all 9xxx informational messages, except:
    -e9079           // conversion from pointer to void to pointer to other type
    -e9087           // cast performed between a pointer to object type and a
                     // pointer to a different object type
    -e9141           // global declaration of symbol

    //    Messages due to code in FreeBSD headers.
    //
    -dlint           // The "lint" macro is tested in x86/_types.h
    -elib(537)       // Repeated include file
    -e793            // external identifiers > 6 chars
    -e935            // (unsigned) int within struct (actually the size_t)
    -estring(960,_*) // Could be defined at block scope
    -e964            // Header file not directly used
    -e966            // Indirectly included header file not used
    -elib(970)       // int outside typedef
    -esym(9003,_*)   // could be defined at block scope
    -elib(9047)      // FILE pointer dereferenced
    -esym(9058,__*)  // tag not used outside typedef
    -e9092           // NULL does not expand to a pointer (but plain 0)


Compulsory obfuscations
-----------------------

Which of the rules cause which obfuscation?

MISRA 6.1, "The plain char type shall be used only for the storage and
use of character values." This forbids using character constants in
expressions other than assignments to `char` objects. A consequence is
that printing digits with `'0' + digit` is not allowed (even though
`'0'` is technically an `int`!) so I am forced to output hex digits with

    printf("%c", (met)tyr + 32 + 16 + ((8 + EOF) * ((met)tyr / (8 + 2))));

because of the "no magic numbers other than powers of two" rule. How is this
an improvement over `printf("%c", '0' + tyr + 7 * (tyr / 10)`, MISRA?


MISRA 6.3 "typedefs that indicate size and signedness should be used in
place of the basic types." Well, if you can't infer the size and
signedness from `typedef int met`, you're not a real C programmer.


MISRA 10.5, "If the bitwise operators `~` and `<<` are applied to an
operand of underlying type `unsigned char` or `unsigned short`, the
result shall be immediately cast to the underlying type of the operand."
Because the program must work for any unsigned type chosen for the `typ`
macro, including the narrow types enumerated in the rule, a lot of
redundant casting ensues. It gets worse with the next rule...

MISRA 12.1, "Limited dependence should be placed on the C operator
precedence rules in expressions." This requires parentheses for almost
all expressions involving more than one operator, especially those for which
a cast is required, leading to hard to understand expressions such as

    const ser glx = (ser)((asx > (ser)64u) ? (ser)((ser)asx + (ser)8u + (ser)1u) : (ser)asx);
    not.not[leu] = (and)((and)not.not[leu] | (and)(((and)glx % (and)16u) << (and)lys));


MISRA 14.7, "A function shall have a single point of exit at the end of
the function." Sigh. Since I must use eloquent prototypes (8.1, 16.3,
16.4) and static functions (8.10, 8.11), I can only use a few functions.
Everything usually written with an early `return` now cause *another
useless indent level*. The first three `if` statements in `main` cause a
silly 24 character indent. The maximum indent is forced to 8, which is way
too high for a sane function.


MISRA 16.10, "If a function returns error information, then that error
information shall be tested." A cast to void would draw a lint warning, so
I use the `printf` result in expressions,

	lys -= 4 * printf("%c", (met)tyr + 32 + 16 + ((8 + EOF) * ((met)tyr / (8 + 2))));
	val += printf("\n") / ((__LINE__ * L_tmpnam) + TMP_MAX);
	val -= (printf(" %d\n", val) > BUFSIZ) ? FILENAME_MAX : EOF;

which are, in the absence of errors, equivalent to

    lys -= 4;
    /*nop*/
    ++val;


MISRA 13.1, "Assignment operators shall not be used in expressions that
yield a Boolean value." Forbids the idiomatic `if ((p = malloc(n)) ==
NULL)` and requires separate statements, in other words, bloat.


MISRA 16.7, "A pointer parameter in a function prototype should be
declared as pointer to const if the pointer is not used to modify the
addressed object." in conjunction with lint's "Note 952: Parameter could
be declared const" causes const-poisoning for all functions,

    static void phe(const ala not);
    static void gly(ala *const not, const and his);
    met main(met val, const pro *const his[]);

and quite a number of automatic variables.

### Why the "laugh" and "throw up" messages?

The guidelines state "We like programs that: make us laugh and/or throw
up :-) (humor really helps!)"

### If you have a 128 bit type

If your compiler supports a 128 bit wide type (e.g. clang, gcc) then
you can use it via the `typ` macro:

    clang -Dtyp=__uint128_t -o prog prog.c

Indeed, the program can use (and lints clean for) all of

    clang -Dtyp=uint8_t  -o prog8  prog.c
    clang -Dtyp=uint16_t -o prog16 prog.c
    clang -Dtyp=uint32_t -o prog32 prog.c
    clang -Dtyp=uint64_t -o prog64 prog.c
    clang -std=c89 -Dtyp="unsigned long" -o prog89 prog.c

This works because the program has no need for corresponding `SCN` or
`PRI` macros to do the scanning and printing of variables of these
types. With a 128 bit type the program can represent numbers up to
340282366920938463463374607431768211457 (3.4 * 10<sup>39</sup>) as a
single "place", enough to explore yet untested numbers for the rest of
your life.

### How big a number can I test with 4 GB of RAM?

The number of hex digits in the start number is limited by `ARG_MAX`,
probably minus some overhead for the environment variables (use
[`env`(1)](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/env.html)
to trim your environment). In bits this leaves you with 2<sup>4 *
ARG_MAX</sup>.

The algorithm requires two bignums in memory for addition.
If you hit a divergent number, this will cause out-of-memory ("laugh")
somewhere near 2<sup>16,000,000,000</sup> (4GB/2 * 8bits/byte).
Sadly, I don't have a test case :-)

How long would it take to overflow the *Not Overflowing Type*? Lets
assume we're processing 2GB numbers. The program copies, shifts by one,
adds and increments 2GB long bit strings, each time completely thrashing
the data cache -- at *all* levels. We have a fast machine that can do an
iteration in one second, on average. To make things easy, we round up
3*n* + 1 to 4*n*, and assume we never need to divide by two (which is
quite optimistic). Then each iteration shifts left by 2. This would take
8 billion seconds, or about 250 years. If you want to get famous, you
better *remove* some of the RAM, use an ancient box, or reduce available
memory resources with the ulimit(1) built-in of your shell.

For all intents and purposes, the *Not Overflowing Type* keeps the promise!

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
