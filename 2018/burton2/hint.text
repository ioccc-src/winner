# Best abuse of the rules

Dave Burton  
<http://ioccc.snox.net>  


## Judges' comments:
### To use:

    make

    ./prog [-tcksri] < file.c

### Try:

    ./prog -i < prog.c
    ./prog -s < prog.c
    ./prog -sk < prog.c

If you get stuck, try:

    make test

If you get really stuck, try:

    man ./tac.man

### Selected Judges Remarks:

They say size isn't everything, and in the case of IOCCC [iocccsize.c](http://www.ioccc.org/2018/iocccsize.c)
that is saying something!  What is this program weighing and how much does it weigh?


## Author's comments:
tac - tokenize and count C and derivative languages
---------------------------------------------------

<blockquote><pre style="font-style:italic">
tac computes C program size  
(obfuscated / otherwise)  
by splitting code as tokens small,  
ignoring space, then counting all.  

It tries quite hard to act the same  
as counting tool of I-OCCC fame.  
Some bugs were fixed, it's faster too,
and does more things, just add some glue!  

It does far more than print the size:  
the token part's a better prize!  
With each upon on a single line,  
how many things can you design?  

Included is a keyword sorter,  
de-obfuscator, freq reporter.  
With code produced as little parts,  
just add your own creative arts.  

But first you have to figure out  
the braces part, without a doubt!  
And then the code - it isn't easy:  
for as else?  That's rather cheesy!  

The rest of it is standard fare:  
expressions strange, the globals bare,  
confusing symbols one and oh,  
and precedence you have to know.  

The keyword list was made external,  
because of standards change eternal.
Thus other languages can now,  
be counted just like C, somehow!  

I hope you find this code obscure  
enough to win, and thus procure  
a public place for all to see  
how badly I can butcher C!  
</pre></blockquote>

Said another way....
--------------------

`tac` is the inverse of `cat`(1): it un-concatenates its input into C tokens,
writing the token stream to stdout.  There are options to suppress the token ids,
summarize the token counts, and several options to allow it to be compatible
with `iocccsize`.

The token-based output is quite useful in analyzing source code (see below),
and the counter is more accurate than `iocccsize` (see below); but this can be
fixed by using the -c compatibility flag, restoring the following problems as
in the official tool:

* whitespace **within** a string is **not** counted;
  this seems wrong, as these chars **are** significant
* "`{;}`" is not counted within a double-quoted string
* whitespace preceding a comment is char-counted, unless the comment starts a line
* -k processes the reserved words within `//` comments(!), but not `/*`, changing the counts

The following bugs are always corrected:

* treats `/*/` as a complete comment (`/*/int if for/*/` has three keywords)
* -k enables `//*` or within a line comment `/*` to initiate a comment block until following `*/`
* -k processes double quote characters in `//` comments -
  thus a solitary quote consumes everything until the next quote
* single quotes are not handled correctly (`'"'` starts a dquote in `iocccsize`)
* `#ifndef` is omitted as a keyword (but `#ifdef` is allowed?)
* I is not a reserved word.
* `tac` correctly penetrates [23rd century cloaking technology][1]. ;-)

There is one (known) remaining problem with detection:

* comments between preprocessor hash and keyword are not replaced with whitespace;
the following counts #include as two tokens, `#` and `include` (not as a reserved word):

		#/*this will not be counted*/include/*correctly*/<stdio.h>

Fixing this properly hampers backwards compatibility in counting.  This requires
eliding comments during readsource (ISO 5.1.1.2, phase 3), and yet still
counting words correctly absent -k.

[1]: http://ioccc.org/2014/birken/hint.html "Best use of port 1701"

Backwards Compatibility
-----------------------

`tac` was run over all 366 previous IOCCC winning entries:

	find ~/src/obc -type f -name \*.c | wc

The discrepancies found are documented and explained in the file "discrepancies".

	find ~/src/obc -type f -a -name "*.c" | xargs ./spotcheck ./prog | ./spotdiff |
		grep -v keep | diff -bw - discrep* | grep "[<>] cl "

In summary, there are only 6 unique entries out of 366 that have any variation
in Rule 2 counts; in all cases, the differences are due to bugs within
`iocccsize`, described in detail in the file `discrepancies`.  There are only 40
files (40/366, ~11%, including originals and variations) that differ at all, 31
only in word count; most word count differences appear related to comment block
detection, weighted more towards recent entries (2011 and onward = 20/40 ~50%).

This (minor) variation in word count values has not been addressed since
it is not a qualifying metric, nor is it very useful in a programming context:
whitespace surrounds English words, not necessarily C tokens, as in `a+=1;`.

Accuracy (versus compatibility) is demonstrated through a series of small test cases
designed to allow exhaustive, hand-counted values for comparison with the tool values.
These test cases were vital in debugging and regression testing, and provided a way to
determine which tool was correct when there were differences.

> A version of this tool in more clearly written C (tac.c)
> is presented for the Judge's consideration as a more accurate replacement for `iocccsize`.
> This obfuscated entry is derived from (and compatible with) that code,
> but due to obfuscation, has had some significant, deep changes for the contest.
> Nevertheless, the more clearly written code remains a spoiler for this entry.

NB: `iocccsize` gets a different answer from `tac` on its own (iocccsize.c) source code;
`tac` gets the correct answer.  This is due to the aforementioned bugs within `iocccsize`,
proved by fixing iocccsize.c with the included patch, so `iocccsize` reports
the correct answer for itself.

But wait... There's More!
-------------------------

There is no limit on line length, file length, comment length, or identifier length.

`tac` features an accurate tokenizer; which presents each C token on a line by itself.
This feature enables interesting analyses of C (and C++) code, hard to get any other way.

For instance, here is a simple token counter, useful in finding repeated long tokens, or operator
frequency, or counting the references to identifiers, constants, or breadth of use of the
language:

	!/bin/sh
	cat $* | ./prog -t | sort | uniq -c | sort -k1nr

And here is a C keyword frequency counter:

	#!/bin/sh
	function iskeyword {
	   awk 'BEGIN{f="c11";while(getline<f)k[$1]=0}
		{if($1 in k)k[$1]++}END{for(i in k)print k[i],i}'
	}
	cat $* | ./prog -t | iskeyword | sort -k1nr

This script was used to "optimize" the reserved word order so the most frequent IOCCC
winning entry keywords are checked first.

> An interesting aside: as might be expected, obfuscation has changed the frequency of
> keyword distribution over time.  The top five for the decades:
> 
>       1980s       1990s       2000s       2010s
>         -----       -----       -----       -----
>         94 if       532 char    375 if      254 int
>         69 for      524 if      372 char    217 for
>         59 while    417 int     332 int     198 if
>         48 char     223 for     184 for     121 return
>         43 int      223 void    165 return  104 char

The keyword list is external to the program, and is easily changed, sorted, checked, verified.
This allows such additional programs in concert with the tool's primary operation.

A poor-man's de-obfuscator can be based upon the output of `tac -t` and a handful of
simple rules (and another use of the external keyword file).
A more refined version of this is included in the file `unob.sh`,
but the simple code below is a serviceable obfuscated C de-obfuscator in a _scripting language_.
It really is this easy with `tac`:

	#!/bin/sh
	script='
	BEGIN {
		last=nl="\n";
		f="c11"; while(getline <f > 0) kw[$0]++; close(f);
	}

	function iskw(a)   { return a in kw }
	function indent(a) { return sprintf("%*s", n*3, " ") }
	function newline() { if (!infor && last != nl) printf last=nl; }
	function show(a) {
		if (last==nl) printf "%s", indent()
		printf "%s%s", space(), a
		last=a
	}
	function space() {
		return iskw(last) ||
		  (last ~ /[A-Za-z0-9_+-\/%^[&\]\)=:<>;]$/ && $0 !~ /[:;()\[\],]/) ? " " : ""
	}

	/^\(/	{ ++paren }
	/^\)/	{ --paren }

	/^for/		    { newline(); infor=1 }
	infor && /^;/	    { ++infor; show($0 " "); next }
	infor==1 && /^:/    { ++infor }
	infor>1 && paren==0 { infor=0 }

	/^\?/		{ tern++; n++; newline(); show($0 " "); next }
	tern && /^:/	{ newline(); show($0); --tern; --n; next }

	/^#/	{ newline(); show($0); newline(); next }
	/^;/	{ show($0); newline(); next }
	/^{/	{ show($0); ++n; newline(); next }
	/^}/	{ n--; newline(); show($0); newline(); next }

	{ show($0) }
	'
	cat $* | sed 's/#include/##include/' | cpp -E -trigraphs |
	sed 's/^# .*$//' | sed 's/^#//' |
	./prog -t | awk "$script"

On the question of obfuscation
------------------------------

* I assume you noticed the [braces][2]?

  _Every brace is sacred,  
  Every brace is great.  
  If a brace is wasted,  
  Clang gets quite irate_.

* Keywords follow the 2010s top five, without the `if`, for interesting flow control.
* Sometimes a `for` can be an `else` - [inconceivable][3]!
* I see the `getopt`.  But "[where's the beef?][4]"
* No character constants, several int constants, and one string
  (hint: which does not encode letters) -- how does this code parse code?
> Interesting aside: how many is "several int constants"?
>
>        ./prog < prog.c 2>/dev/null | awk '$1~/260/{a[$2]++}END{for(i in a)print i,a[i]}'
>        ... | wc
>
> Which numbers are most often used?
>
>        ... | sort -k2nr | sed 5q

* The code describes its function by careful arrangement of variables up front...
* ...coupled with a description of the typical IOCCC contestant, or at least the author
* Why shouldn't trigraph parsing be written in trigraph?
* Where iocccsize.c mocks, this code flaunts:
  "_no matter how well you may think you understand this code, you don't, so don't mess with it. :-)_"
* `O,0,l,1` are used to confusing effect, local names obscure global names.
* Globals are used to pass information between routines: don't reorder "unrelated" statements....
* How does the compatibility mode account for the fundamentally different manner of computation?
* The algorithm is quite efficient; reserved word detection and trigraph parsing particularly so.
* This may be the first obfuscated submission that provides the means for its own de-obfuscation.

[2]: https://www.youtube.com/watch?v=fUspLVStPbk&start=53 "Meaning of Life"
[3]: https://www.youtube.com/watch?v=OHVjs4aobqs "Inconceivable"
[4]: https://www.youtube.com/watch?v=Ug75diEyiA0 "Where's the beef?"

Rule 2
------

The keyword list is externalized as an include file.  This presents a useful
feature for the source code: not only can the reserved word script above be
produced, but the tool can be rebuilt with any set of reserved words, just by
using a different list.  For instance: removing all the secondary keywords;
removing all the C11 keywords; trying just K&R C.  Since C++ and Java share the
same operators as C, just change the keyword list and `tac` will correctly
tokenize both of these; the tokens >>> and :: can be handled with a short
post-filter (tokenfix, included).

I believe this entry may also satisfy the request for gratuitous use of all the C11 keywords?
Whether this context satisfies "intended C language context" is a matter of interpretation. ;-)
And `tac` is ready for the IOCCC++ contest.  And the IOJCC trashcan.

The following reserved word files are included:
	
	kandr   from my venerable 1978 18th printing "The C Programming Language"
	v7unix  7th edition Unix source code, extracted from c00.c
	kandr2  from my 1988 1st printing "The C Programming Language", 2e
	ansi    ANS X3.159-1989
	c99     ISO/IEC 9899:1999(E)
	c11     ISO/IEC 9899:201x(E) N1570
	c++98   http://en.cppreference.com/w/cpp/keyword
	c++11   ISO/IEC 14882:2011(E) N3337 2012-01-16
	c++14   ISO/IEC 14882:2014(E) N4296 2014-11-09
	java8   http://docs.oracle.com/javase/specs/index.html
	ioccc.kw.freq   c11 + additional words, sorted on frequency of occurrence in ioccc winners

NB: The keyword file used in this code is derived from the list in iocccsize.c,
which is neither complete (`#define`, `#ifndef`, `#undef` are missing
-- yes, Virginia knows about `#define` omitted on purpose),
nor correct (many more are added: `I`, `true`, `bool`, `compl`, ...):

	(sed -n '1p' c11; sed -n '2,$p' ioccc.kw.freq | sort) | comm -3 - c11

That is an obfuscated way to say "diff".  But it also more clearly shows the, um, diffs.

The usage string is similarly externalized, providing a better usability string than
the limits would otherwise allow.  If this is considered bending the rules too far,
just -DU=O to get a passible, if cryptic, usage message using no additional octets
than without the define.
This also allows the builder to configure the amount of help a utility should provide
([you want a manpage? Because that's how you get a manpage.][5])
-- a rather significant point of contention made moot.

There is definitely abuse of the Rule2 counter, exploiting a "feature" of `iocccsize`:
`iocccsize` does not Rule2 count {, } and ; when followed by whitespace -- even within a string!
Thus: Freecode, a simple, uncounted, highly obfuscated encoding of a central part
of this program.  (The reserved word list is not Freecoded, both because it is useful
apart from the program, and because Freecode is not entirely free.*)

* Some restrictions apply.  Not approved for all uses.  Some assembly required.

[5]: https://www.youtube.com/watch?v=VU0GYSA1POs "Ants"

Compilation
-----------

The code is ANSI compliant, but it does have a string longer than 509 characters.
It has been tested on OSX and Linux, Clang and GCC.

The code uses trigraphs, ironically: it parses trigraphs with trigraph code.
Because that's funny.  And it remains obscure after, so trigraphs are not used for obfuscation.
Thus -trigraphs -Wno-trigraphs (which is also humorous).

It's obfuscated C.  Thus -Wno-parentheses -Wno-empty-body -Wno-char-subscripts.

The code uses unsigned chars, but C strings are signed.  Thus -Wno-pointer-sign.
NB: This is *not* a portability concern, the one string holds only printable ASCII characters.

Thus:

	clang -ansi -Wall -trigraphs -Wno-trigraphs -Wno-parentheses -Wno-empty-body -Wno-char-subscripts -Wno-pointer-sign -DU=O -DW=\"keywords\" -o prog prog.c

Coda
----

Cody Ferguson was relentless in his pursuit of bugs.
Thanks to his reports, the version of `unob.sh` is stronger,
`tac` groks digraphs, `tokenfix` corrects for missing digraphs in `prog.c`,
and the program `manpage` was added to the corpus.

`manpage` is a useful program that turns ASCII versions of man pages (e.g. `tac.man`) into real
man pages.  It works for C and C-like languages, command lines,
and was designed to handle man page sections 1-8.
It works well on most inputs, but tends to need some raw nroff for more fancy constructions,
such as combined arguments
(e.g. the -r and -s arguments to tac are not recognised when written as -rs in prose).

Try:

	manpage tac

	manpage -h
	manpage -h | manpage
	manpage -h | manpage -R | less
	manpage -h | manpage -P | lpr

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
