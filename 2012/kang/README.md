## To build:

``` <!---sh-->
    make
```

There is alternate code which fixes some German at the expense of other German.
See [Alternate code](#alternate-code) below for the (fun) rationale here.


## To use:

``` <!---sh-->
    echo "full spelling of an English cardinal numeral less than a quadrillion" | ./kang
```


## Try:

``` <!---sh-->
    ./try.sh # try various languages

    ./en.sh # English 0 through 13

    ./de.sh # German 0 through 13 with both umlauts and without (additional 'e')
```

How does it have no `u` or `o` in a string in the source code and yet it gets
`uno` right?


## Alternate code:

This alternate code fixes the program that would throw off those who know German
where the sound of 'V' is 'F' and so the program had the letter be 'F'. A
problem, however, with changing it is that it breaks other words including in
German. Thus there is the alternate version instead which fixes a problem for
Germans that causes problems for Germans so if you're German you'll just have to
deal with it :-) It also breaks other words too and this happens only for one
letter change. With this one should hopefully be able to really appreciate the
subtlety of this entry even more.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    echo "full spelling of an English cardinal numeral less than a quadrillion" | ./kang.alt

    echo vier | ./kang.alt

    echo uno | ./kang.alt
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh # try various languages

    ./en.alt.sh # English 0 through 13

    ./de.alt.sh # German 0 through 13 with both umlauts and without (additional 'e')
```

What does it get right? What does it get wrong? How does it compare to the
original entry without the change of `f` to `v`?

Finally why does it get wrong what it gets wrong?


## Judges' remarks:

The judges were able to appreciate the Indo-European language family
relation by making this entry successfully recognize *some* French,
German, Italian, Russian, and Spanish numerals.

Also worth mentioning is this entry's ability to understand the
colloquial year numbers of the last millennium.

We've added a linefeed to the print format for convenience.

Can you explain why:

``` <!---sh-->
    echo f hundr|./kang
```

correctly reports 500 but:

``` <!---sh-->
    echo hundr|./kang
```

does not report 100, instead printing 0?


## Author's remarks:

### Synopsis

This short program reads a spelt number (e.g. `forty-two`) and writes a
corresponding decimal number (e.g. `42`). Too long for one-liners, alas,
but it still qualifies as a *short* program as it has less than 0x100 bytes.

It accepts a variety of spelt numbers:

* It correctly handles `zero`.
* Hyphen does not make a difference: `forty-two` and `forty two` are same.
  So does period or comma.
* Cases do not make a difference either: `TWO`, `Two`, `two` are the same.
* `one` and `a` are interchangeable: `one hundred` and `a hundred` are the same.
* `and` is optional: `one hundred twenty-three` and `one hundred and twenty-three`
  are the same.
* It supports every non-negative integer less than 10<sup>15</sup>-1. It uses
  the small scale (i.e. American): `billion` is 10<sup>9</sup> and `trillion` is
  10<sup>12</sup>.
* Sometimes, it can magically correct typos.

It does *not* accept some spelt numbers, which I found mostly irrelevant:

* A bare `hundred`, `thousand` etc. do not work.
* `one million million` does not work. Get used to `one trillion`!


### Requirements

This program is quite portable, only requiring the following:

* The signature `int main(int, int)` should be accepted by the linker. (Original
  version only).
* `char` should be at least 1 byte long (as dictated by the standard), `int`
  should be at least 32 bits long, `long long` should be at least 64 bits long.
* Both the compiler and execution environment should use an ASCII-compatible
  character set and two's complement representation.
* Overflow and underflow on `char` should wrap around, if your `char` is unsigned.
* [A trustworthy compiler][trustingtrust].

[trustingtrust]: http://cm.bell-labs.com/who/ken/trust.html

The design of the program explicitly allows for `EOF` even if it does not equal
`-1` (it has to be negative per the standard but not necessarily `-1`) and both
`signed char` and `unsigned char`, for example. Furthermore it is
endian-independent.


### Debfuscation

Many obfuscations used are typical for standard IOCCC entries:

* Two arguments from `main()` function are reused as normal variables.
* Every conditional has been replaced with the `?:` ternary operator and `||`
  short-circuiting operator.
* It has exactly three nested `for` loops and nothing else.
* Common two's complement tricks: `~-a` instead of `a-1`,
  `~a?...:...` instead of `a!=-1?...:...`, etc.
* Comma operators (`,`) for multiple statements. The number of them is
  minimized, however, as it is too easy to (ab)use them.
* It lacks most parentheses around bitwise and arithmetic operators. It was
  originally written for shortness so parentheses were **EVIL**.
* `n["string"]` instead of `"string"[n]`. Both are fine for this program but
  I went to the former just for fun.
* Utter lack of any kind of layouts. (Oh, except for the first column.)

Other obfuscations are more subtle:

* The string `"1+DIY/.K430x9G(kC["` is 18 bytes long, but actually 19 bytes
  including the final NUL character are used.
* It internally represents numbers as hexadecimal. When the input is `two
  hundred and three`, it actually writes `0x203` as hexadecimal.
* Some variables (notably, `n`) have dual uses.
* The magic number [42][hhgg] makes an appearance.
* It has a long long numb-`main`-er within it!

[hhgg]: http://en.wikipedia.org/wiki/Answer_to_The_Ultimate_Question_of_Life,_the_Universe,_and_Everything

But the most important obfuscation is the clever construction of lookup table.
The program uses 11 different characters required for recognizing 22 lexemes:

```
    zero        one         tw-         th(i)r-     fo(u)r-     fi-         six-
    seven-      eigh-       nin-        ten         eleven      twelve
    hundred(s)  thousand(s) million(s)  billion(s)  trillion(s)
    a           and         -teen       -ty
```

So that they are internally represented as like:

```
    r        n        tw-      tr-      fr-      f-       s-
    sn-      g-       nn-      tn       ln       twl
    nr(s)    tsan(s)  lln(s)   blln(s)  trlln(s)
    a        an       -tn      -ty
```

The stemmer recognizes the longest matching prefix, so every lexeme can be
recognized by at most three characters (e.g. `trl` instead of `trlln`). This is
also handy for ignoring plurals. But that would make it so that the table does not fit
in the printable byte---11<sup>2</sup> is already almost 2<sup>7</sup>!

The trick is to use octal; three characters (`a`, `b` and `g`) are interpreted
as sequences of two characters (`ny`, `nn` and `nw` respectively). Asides from
a smaller lookup table, it has many good consequences:

* Both `a` and `and` share the common prefix, `ny`, and can be discarded
  altogether. Note that `ny` itself does not appear from other entries.
* `thousand` is interpreted as `tsan`, which is equivalent to `tfyn` in the
  octal scheme. As it is the only entry with `tf` prefix, it can be shorten by
  one character.

Having said this important trick, other details should be relatively easier to
follow. The order of lookup table, for example, is very important,
and the biggest constant 6177 is not arbitrarily chosen.

Even [more deobfuscation information](https://gist.github.com/lifthrasiir/3909337) is available.


### Acknowledgement

The cleaner (size-optimized) version of this program was originally published
in my website in July 2011. Sun Park and others have reviewed it and made me
aware of possible improvements. I'd also like to thank Seo Sanghyeon for
proof-reading remarks.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
