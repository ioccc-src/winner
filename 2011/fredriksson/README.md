# Most useful

Kimmo Fredriksson  
<kimmo.k.k.fredriksson@gmail.com>  


## Judges' comments:
### To build:

    make fredriksson

### To run:
    
    ./fredriksson [-icvtnk#] regexp < file

### Try:

    ./fredriksson -k1 -i POOT < /etc/group
    ulimit -s unlimited
    ./fredriksson -k2 -t -n bofuskate < /usr/share/dict/words

### Selected Judges Remarks:

The author of this entry was making sure that it does not win the
"Best Short Program" award.  On the outside, the program behaves
as an approximate grep.  On the inside, it is a Burrows-Wheeler
transform decompressor that produces the source code of the actual
obfuscated approximate grep program and calls it. As an exercise,
try writing the compressor.



## Author's comments:
# Approximate grep

Implements a variant of grep.

## Usage

To search regexp from file, do:

	./fredriksson [-icvtnk#] regexp < file

Pipes may not work, see the section Limitations.
The options `-i -c -v` and `-n` are the classic ones:

* `-i`	Ignore case.

* `-c`	Count only, prints the number of matches, but not the matching lines.

* `-v`	Invert match.

* `-n`	Prefixes each printed line by its line number (only if
	`-c` was not given).

This version of grep recognizes two more options, not present in normal
grep implementations:

* `-kN`	Permit `N` insertions, deletions or mismatches of characters in the
	matches (aka edit-distance). E.g. "obfuscated" matches "obfuscation"
	with one deletion and two mismatches. Likewise, "obfuscate" and
	"oversimplify" match with 7 edit operations. The default is `-k0`
	(i.e. exact match).

* `-t`	Add local transpositions to the set of allowed edit-operations.
	That is, "ab" matches "ba" with one transposition (swap), and
	"obfuscated" matches "bofsuact" with three swaps and two insertions,
	i.e. use `-tk5` to find this.

Of course, one could construct a standard regexp that matches the same
patterns, but the problem is that such a regexp grows exponentially in
size when the number of allowed edit operations is increased.

This version does not recognize all regular expressions, but the
following are allowed:

* Wild card: `.` (dot) matches any character.

* Bracket expression: list of charactres enclosed by `[` and `]`,
  matches any single character in the list.

* Range expression: two characters separated by hyphen and enclosed in
  brackets, matches any character that is lexicographically between the
  two characters (inclusive). E.g. `[a-d]` is the same as `[abcd]`.

The special characters must be escaped, if they are to be taken
literally (i.e. use e.g. `\.` to match period). You might want to protect
these with `'`, i.e. use `'foo\[bar'` instead of `foo\[bar`. If you want to
use the literal `-` in bracket expression, protect that too (`\-`),
otherwise this is not needed. Note that the syntax differs from standard
(?) grep a bit, i.e. in plain grep you can use `]` and `-` in bracket
expressions by putting `]` as the first character, and putting `-` last.

### Other uses

* You can use this in place of cat. Just say

		./fredriksson -k3 cat < file

* Like with cat, you can append line numbers too:

		./fredriksson -nk3 cat < file

### Other features

* It is assumed that the user knows how to feed correct input to the
  program. If undefined options are given, the result is also undefined.
  This is a feature.

* It may consume huge amounts of memory, and a stack overflow may occur.
  This results in Segmentation fault (or the equivalent of your favorite
  system, such as Bus error). This is a feature, that can be used to detect
  overly long lines in the input file, such as checking the lenght of one
  liners in IOCCC entries, just adjust your stack size to a suitable
  threshold, and search for "ioccc", with option `-vk5`.

## Limitations and remarks

* Using warning options (such as -Wall) when building gives a lot of warning,
  such as `suggest parentheses around '&&' within '||'`, `value computed is
  not used`, `implicit declaration of function 'putchar'`, `implicit
  declaration of function 'getchar'`, `control reaches end of non-void
  function` and `format not a string literal and no format arguments`.
  Please ignore them all, since they just try to tell you that the source
  is obfuscated.

* Only standard input is handled. And _only_ if stdin comes from a file,
  i.e. pipes may or may not work. If you want to count only (`-c` option),
  then this shouldn't be an issue.

* The total lenght of the (preprocessed) pattern is at most
  `sizeof(long)*CHAR_BIT`. That does not count things like bracket expressions
  or escape chars, that is, the pattern `'a[bcd]e\.f'` is 5 chars long, not
  10 chars. That does not mean that the matched substring in the standard
  input has this limit, as using the edit operations can make the string
  longer. However, no assumptions are made for `sizeof(long)`. In fact,
  you can easily use `long long` instead,

* Depending on the file, may require a lot of stack space. If the
  program segfaults (because of this), say

		ulimit -s unlimited

  cross your fingers, hope it is enough, and try again.

* Assumes C99 standard, because of the one very long line. Most C compilers
  handle this just fine even in C89 mode, though.

* The code should be reasonably portable, it assumes standard ASCII codes
  for each char, and that a C compiler is on $PATH; the latter is hard coded
  to be 'gcc', but any compiler would work, provided that it supports
  C99, or long lines as an extension. This code has been tested on:

	- GNU/Linux FC4, i386, gcc
	- GNU/Linux FC7, x86_64, gcc 4.1.2, tcc 0.9.24 and icc 10.0
	- GNU/Linux FC9, x86_64, gcc 4.?.?
	- GNU/Linux CentOS 5, gcc 4.1.2
	- GNU/Linux Ubuntu 11.04, gcc 4.5.2
	- SunOS 5.8, UltraSPARC IIIi, gcc 4.1.2
	- SunOS 5.9, UltraSPARC IIIi, gcc 4.1.1 and Sun ONE Studio 8 CC
	- AIX 5.3, IBM eServer p5-550, gcc 3.3.3 and AIX CC Version 6

  (Btw, tcc has its roots in IOCCC...)

## Obfuscations (a.k.a. spoilers...)

* The initialized char array includes the source code of the real program,
  as well as its name and commands to build and run it, all Burrows-Wheeler
  -transformed, then run-length-encoded with unary coding. The main program
  extracts and builds that, and then calls it. More precicely, the command
  to build is

		gcc -O3 ag.c -o ag

  To change that you need to edit the char array `p[]` and (possibly) two
  specially encoded constants, `-~('('*'(')` and `'C'*' '-'-'`.
  The extracted source (`ag.c`) is obfuscated as well.

  (The original version also deleted the generated source and the
  corresponding binary after running it, but this feature was removed
  from the submitted entry.)

* The code demonstrates several useful programming paradigms, such as

	- recursion to remove all loops
	- sub routines (`main()` contains several logical sub routines,
	  selected by the first argument)
	- function pointers

* Algorithmically, it incorporates the following

	- (inverse) Burrows-Wheeler transform (used also e.g. in bzip2)
	- data compression (really expansion :-), run-lenght-encoding,
	  unary coding (this is why it is expansion rather than compression)
	- approximate string matching
	- dynamic programming to compute the edit distance
	- parallel computation in sequential computers (by packing
	  several objects into a single long, to speed up the dynamic
	  programming)
	- self extracting, compiling and running code

* As a C program, it demonstrates that

	- a C subset without reserved words is complete enough,
	  (excluding data type specific things (`int`, `char`, `void` ...))
	- only letters are needed (i.e. the digits 0-9 are not)
	- only one statement is enough to code any program (plus
	  variable definitions)
	- white space has other uses than just indenting the code

* It also shows the power of boolean logic and bitwise arithmetic.

* This is the first (?) entry in the history of IOCCC, that cannot be
  totally un-obfuscated by the author. This is due to the clever choice of
  the actual algorithm, that is obfucated by nature, and it is an open
  research problem whether a simpler algorithm exists, with the same time
  complexity.

* The main obfuscation comes from using only arithmetic and boolean
  (short-circuit) logic combined with recursion to remove all loops and
  if-then-else constructs (also, no ternary `?:` constructs are present).
  Two's complement representation of integers is also abused. E.g. instead
  of writing `x++` or `x-1`, it is much better to write `x=-~x` and `~-x`.

* No numerical values, other than in the initialized char array, try

		./fredriksson -ck0 [0-9] < fredriksson.c

  This should print 1, as there is a numer '3' in the char array (only).
  You can also try

		./fredriksson -ck0 [0-9] < ag.c

  after running fredriksson at least once (since this generates that
  `ag.c` file), and this should print 0.

* The source code is best viewed with cat (or using the program itself),
  instead of some editor. (This is a somewhat system dependent thing.)

  One reason for this is that the code builds (some of the) constant
  values from string literal `"\b"`, except that the backspace `\b` is not
  escaped like that, the source uses the raw ascii value (010 octal) instead.
  Thus when viewing with cat or something, that backspace erases the leading
  quotation mark. Makes it appear uncompilable, and it is: if you copy-paste
  the cat output from terminal to some editor, save it, the result would not
  compile.

  Some other constants are built from ASCII values of chars.

  Besides of making the code hard to read, all this makes it also quite large.

* Running it through GNU indent or bcpp (C beautifiers) does not beautify
  it a bit. In fact, indent makes it only worse (at least with the default
  options). Running it through the preprocessor does basically nothing,
  since no `#define`s are used.

* Some _abuse of the rules_. The number of non-whitespace and `;`, `{`
  and `}` chars is below the limit, but most of the whitespace chars are
  in an _initialized character array_. That is, the number of chars in the
  program exceeds the 2048 limit. However, whitespace is whitespace and
  the rules did not specify that these must be in between the statements.
  A character is a whitespace if `isspace()` returns non-zero value. Even
  if deleting even one of those chars breaks the program! (This does not
  apply to the generated source `ag.c`.)


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
