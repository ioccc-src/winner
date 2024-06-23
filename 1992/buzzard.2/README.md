## To build:

``` <!---sh-->
    make all
```

There is an alternate version of this program. See [Alternate
code](#alternate-code) below for details.


## To use:

**First**, you must make sure that `first` is made **first** (even though `make all`
should make **first _first_** :-) ):

``` <!---sh-->
    make first
```

**Second**:

``` <!---sh-->
    # get help:
    echo help | cat third help.th - | ./first

    # try out a demo:
    cat third demo5.th | ./first
```

**Third**:

``` <!---sh-->
    cat third help.th - | ./first
```

**NOTE**: Wait until `Ok` is printed and the type:

```
    2 3 + . cr
```

Yes you should really type the 2 letters: `cr`.

**Fourth**:

```
    Sorry, this is third!
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This alternate version, [buzzard.2.alt.c](%%REPO_URL%%/1992/buzzard.2/buzzard.2.alt.c), does not contain a
fix that the author notes in their remarks.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `buzzard.2.alt` as you would `buzzard.2` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Have fun!


## Author's remarks:

### What it does

`first` implements a relatively primitive stack machine.  How
primitive?  It supplies 13 visible primitives: 3 arithmetic,
1 comparison, 2 memory-access, 2 character I/O, 3 primitives
for defining new words, 1 tokenizing, and 1 special stack
operation.  (There are also three internal operations for
the stack machine: 'push this integer', 'call this code',
and 'compile a call to this code'.)

It is very difficult to accomplish anything with this set
of primitives, but they do have an interesting property.

This--what this interesting property is, or in other words
what first is good for--is the major obfuscation; there are
also minor source obfuscations, as well as some design tricks
that are effectively obfuscations.  Details on the obfuscations
are below, and the interesting property is discussed much
further down.


### How to run it

`first` expects you to first enter the names of the 13 primitives,
separated by whitespace--it doesn't care what you name them, but
if all the names aren't unique, you won't be able to use some of
them.  After this you may type any sequence of valid `first` input.
Valid `first` input is defined as any sequence of whitespace-delimited
tokens which consist of primitives, new words you've defined, and
integers (as parsed by `"%d"`).  Invalid input behaves unpredictably,
but gives no warning messages.  A sample program, `demo1.1st`, is
included, but it only works on ASCII systems.

Do not expect to be able to do anything interesting with `first`.

To do something interesting, you need to feed `first` the file
[third](%%REPO_URL%%/1992/buzzard.2/third) first.  In unix, you can do

``` <!---sh-->
    cat third help.th - | ./first
```

to do this.  Hopefully most operating systems will provide a way to do this.  It
may take some time for this to complete (I seem to remember it taking several
minutes on an 8086 PC); `THIRD` will prompt you when it is finished.  The file
[third](%%REPO_URL%%/1992/buzzard.2/third) has not been obfuscated, due to sheer kindness on the author's
part.

For more information on what you can do once you've piped [third](%%REPO_URL%%/1992/buzzard.2/third) into
first, type `help` and consult
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) manuals for
further reference.  Six sample THIRD programs are included in the files
`demo1.th` through `demo6.th`.  See [buzzard.2.README.html](buzzard.2.README.html)
for more information.

Keep in mind that you are still running `first`, and are for the most part
limited by `first`'s tokenizer (notably, unknown words will attempt to be parsed
as integers.)  It is possible to build a new parser that parses by hand, reading
a single character at a time; however, such a parser cannot easily use the
existing dictionary, and so would have to implement its own, thus requiring
reimplementing all of `first` and `third` a second time--I did not care to
tackle this project.


### Compiling

`first` is reasonably portable.  You may need to adjust the size of the buffers
on smaller machines; `m[]` needs to be at least 2000 long, though.

I say `first` is portable mainly because it uses native types.  Unlike
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;), which
traditionally allows byte and multi-byte operations, all operations are
performed on C `int`s.  That means `first` code is only as portable as the same
code would be in C.  As in C, the result of dividing `-1` by `2` is machine (or
rather compiler) dependent.

### How is first obfuscated?

`first` is obfuscated in several ways.  Some minor obfuscations like
`&w[&m[1]][s]` for `s+m[w+1]` were in the original source but are no longer
because, apparently, ANSI doesn't allow it (`gcc -ansi -pedantic` doesn't mind
it, though.)

Other related obfuscations are still present.  The top of the stack is cached in
a variable, which increases performance massively if the compiler can figure out
to keep it in a register; it also obfuscates the code.  (Unfortunately, the top
of stack is a global variable and neither gcc nor most bundled compilers seem to
`register` allocate it.)

More significant are the design obfuscations.  `m[0]` is the "dictionary
pointer", used when compiling words, and `m[1]` is the return stack index.  Both
are used as integer offsets into `m`.  Both are kept in `m`, instead of as
separate pointers, because they are then accessible to `first` programs, which
is a crucial property of `first`.  Similarly the way words are stored in the
dictionary is not obvious, so it can be difficult to follow exactly what the
compiler words are doing.

Assuming you've waded through all that, you still have to penetrate the most
significant obfuscation.  Traditionally, the question is whether a reader can
answer the question "what will this do when I run it".  A reader who has
deciphered `first` to this point may think they know the answer to this
question, but they may not know the answer to the more important question, "what
will this program do when given the right input?"
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) aficionados,
and especially FORTH implementers, may recognize the similarity of the internal
compiler format to many FORTH internal representations, and, being aware that
FORTH interpreters can often be self-compiling, may be suspicious that this
program can compile FORTH, or a significant subset of it, or at least be capable
of doing so if fed the right input.  Of course, the name "THIRD" should be a
dead giveaway, if the name "first" wasn't.  (These numbers were largely chosen
because they were five letters long, like "FORTH", and would not require
truncation to five letters, which would be a dead giveaway.  Besides, THIRD
represents a step backwards, in more ways than one.)


### What exactly is `first`, then?

`first` is a tiny interpreter which implements a sufficient pseudo-subset of
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) to allow it
to bootstrap a relatively complete version of FORTH (based loosely on forth79),
which I call THIRD.  Complete relative to what, I'm not sure.

I believe `first` is close to the smallest amount of code possible to get this
effect *using forth-style primitives*, and still have some efficiency (it is
possible to get by without multiplication if you have addition, obviously).  In
the design file, design, I give a justification for why each primitive in
`first` was included.

THIRD is sorta slow, because `first` has so few primitives that many things that
are primitives in
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) (like swap)
take a significant amount of time in THIRD.

When you get the `Ok.` message from `third`, try out some sample
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) code
(`first` has no way of knowing if keyboard input is waiting, so it can't actually prompt
you in a normal way.  It only prints `'Ok.'` after you define a word).


``` <!---sh-->
    2 3 + . cr
```

(which adds 2 and 3, and print the result and a newline.)

THIRD responds:

```
    5
```

Now try:

```
    : test 11 1 do i . loop cr ;
    test
```

and THIRD responds

```
    1 2 3 4 5 6 7 8 9 10
```


When in `THIRD`, you can see how much space you're currently
using by typing:

```
    here .
```

The number THIRD replies with is the number of machine words (`int`s) that the
dictionary (the first code) takes up, plus the 512 `int`s for the return stack.
If you compile the basic THIRD system without the help word (strings take up one
`int` per character in the string!), you should find that you're using around
1000 `int`s (plus the return stack).

Thus THIRD gives you a relatively complete
[FORTH](https://en.wikipedia.org/wiki/Forth_&#x28;programming_language&#x29;) system in
less than 700 chars of C source + about 1000 `int`s of memory--and it's portable
too (you could copy over the THIRD memory dump to another machine, in theory).
If the above numbers seem to you to be mixing apples and oranges (C source and
compiled THIRD code), note that you should in theory be able to stick the
compiled THIRD code into the C source.

Software Construction Company gets credit for rekindling my interest in FORTH
and thus indirectly inspiring me to write this program.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
