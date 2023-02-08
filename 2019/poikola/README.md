# Most calendrical

Timo Poikola  
<https://ig.fi/other/ioccc>  
Twitter: @timpoiko  


## Judges' comments:
### To use:

    make prog
    ./prog 512 ./prog

    sleep 86400; make clobber prog
    ./prog 512 ./prog

    sleep 86400; make clobber prog
    ./prog 512 ./prog

### Try:

    If you don't have a few days, try:

    TZ=UTC24 make clobber prog
    ./prog 512 ./prog

    TZ=UTC48 make clobber prog
    ./prog 512 ./prog

### Selected Judges Remarks:

Do you have the time to see what this program does?  Think again, come back and try again.

Note that 2 can be said to be the least odd prime because it is the greatest even prime.
Moreover 2 can be also said to be the greatest odd prime because it is the least even prime.

The source code layout and some of the variable names honors the ski jumping accomplishments of
[Matti Nyk&auml;nen](https://en.wikipedia.org/wiki/Matti_Nyk%C3%A4nen).

## Author's comments:
### How to build ###
    gcc -O0 -o prog prog.c

or

    clang -O[0123s] -o prog prog.c

### Poster

You can generate an A3 sized poster by _make docs_. This command creates a pdf file _poikola.pdf_.

### What this entry does ###
An old wise man mumbled to me:
>Implement a program, which can calculate SHA-3 checksum for a file

I think it is easy, but the wizard didn't stop yet:
>and primes and Fibonacci numbers.

Still easy. But the Gandalf the Grey impersonator is not ready:
>But use only _main()_, and do not use _math.h_ nor predefined stuff at all. But wait, there are some more rules: This
work should reflect the extraordinary mind of Matti Nyk&auml;nen,
the all-time best [ski jumper](https://en.wikipedia.org/wiki/Matti_Nyk%C3%A4nen) and
[amateur philosopher](http://telefinn.blogspot.com/2011/11/matti-nykanen-quotes.html), who passed away on fourth of
February 2019.

####Oh boys.
So, I followed the rules given by Gandalf the White and the Judges of IOCCC. Output of `iocccsize`,
using the [2019 version of iocccsize](https://www.ioccc.org/2019/iocccsize.c), is carefully selected.
For the sake of clarity, I used single letter variables in the code. I also avoided unnecessary use of functions.
Like a tripundra, this program has three levels. In order to reveal all of them, you have to compile this program
on three consecutive days.

As this is a contest for obfuscated code, the program does not perform unnecessary checks, but either fails or gets
stuck if invoked erroneously. The program is invoked in this way: ./prog `<integer>` `<file>` in where `<integer>` is
224, 256, 384, 512 or even 1024. Yes, I know 1024 is not a supported length of output, but as I said, the program does
not validate its input in any way. These same parameters should be given in calculating a Fibonacci sequence or prime
numbers. *Please note that maximum file size is one gigabyte.*

### Obfuscation ###
*Matti Nyk&auml;nen*: Every time I jump, and I get that feeling of _bon voyage_, the feeling that I&#8217;ve been here
before.

*Matti Nyk&auml;nen*: When you are about to jump, you are all alone and have to make your own decisions. Up there,
it's all _up yours_.

This code has some jumping too. I used some `goto`s instead of `longjmp()`. Some Finnish ski jumping sites are
used as labels, however, there is `lahti` instead of <tt style="font-family: Monaco, Courier New, monospace;font-size:
12px;">salpausselk&auml;</tt>.

### SHA-3-512 Compatibility chart ###
Tested against [test vectors](https://www.di-mgt.com.au/sha_testvectors.html).
Clang-4.0: For optimization levels [0123s], the program compiles and produces correct output for every tested vector using
c11, c89, c90, c99, gnu11, gnu1x, gnu89, gnu90, gnu99, iso9899:1990, iso9899:199409, iso9899:1999 and
iso9899:2011 as argument of `-std=`

Gcc-6: For optimization level 0, correct output using
c11, c99, gnu11, gnu1x, gnu89, gnu90, gnu99, iso9899:1999 and iso9899:2011

### Missing a prime ###
For obvious reason, the oddest prime is missing from output.

### Observations ###
Gcc and clang are very fragile compilers. I spent numerous hours trying to achieve exactly the same output from
different optimization levels and compilers. Small change in code can produce really unexpected results, i.e. the compiler
can skip a few expressions or statements without obvious reason.

### Major spoilers ###
Please scroll down if you want to see spoilers.
<div style="margin-bottom:61em;">&nbsp;</div>
It is commonly believed that [Mike Keith's algorithm](http://www.cadaeic.net/calendar.htm) published in _Journal of
Recreational Mathematics_, Vol. 22, No. 4, 1990, p. 280, is the shortest way to calculate weekday for given date.
Keith's algorithm:<br>
`(d+=m<3?y--:y-2,23*m/9+d+4+y/4-y/100+y/400)%7`<br>
My algorithm: I noticed that<br>
`(23*m/9+(m<3?y--:y-2)+d+4+y/4-y/100+y/400)%7`<br>
is one character shorter. In my solution, `m<3?y--:y-2` is used directly, instead of assign value for `d`.

Q is pronounced in Finnish exactly like "kuu", a word for month or the Moon. So, `Q = k` is intended.

Last term of outputted Fibonacci sequence is the last one smaller than 2<sup>64</sup>. It is plain coincidence (but a funny)
that value of '^' is 94 in ASCII table.

For prime calculations: I recycled code from my high school C-programming course. Originally, I wrote it over 20 years
ago. My teacher said that it is (too) complicated to use bits stored in arrays, so I did it.

### Other stuff ###
Cody: I really like that you enjoyed my previous entry. I hope that you will like this entry too.
Because I did not want to give too many clues to Judges, I tried to write this entry in a different way
than Most Stellar, but in this code there is at least one recycled thing from it. By the way,
answers to questions: 1. 255. 2. Try to compare binary representations of those floats and binary representation
of the string "25th IOCCC!". 3. I don't know. I used standard trigonometric functions from `math.h` for rotating the Big Dipper
and later replaced those functions with my own implementations. But there was a bug in my code and the effect was more
beautiful than intended. I did not even debug this bug and now it works as a feature. 4. It is not possible. If you
change a single bit, the Fletcher 16 checksum does not match anymore and `goto` jumps to end of the code.

I see that _Volker Diels-Grabsch_'s winner is awarded in category __Most self-aware__. In last year, my entry incorporates
the Fletcher 16 algorithm to ensure integrity of code. One of my first ideas for this year was to do the same thing,
but with SHA-3. Using Fletcher 16, calculating a checksum which matches with `sleeping time factor` took about one minute.
I realized that SHA-3 even with 224-bit output could take too much CPU time.

I would like to say _thanks_ to PSP, because there were not too much interrupts during the coding phase.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
