## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./klausler arg1 arg2 | head
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

To reduce the size of the source, include other people's data.
That is what Peter suggests when he describes how to generate
a critical header file.

In other words: make use of other words!  :-)

Rules might have to be changed!


## Author's remarks:

A useful tool to help one appear extra smart and witty when
[IRCing](https://en.wikipedia.org/wiki/Internet_Relay_Chat), or even to
just be highly annoying.

Finds best anagrams for word or phrase given as program arguments. Use only
lower-case letters in these arguments. Output is sorted firstly in ascending
order of word count (fewer words are better) and secondly in descending order
of word length. Pipe the output into `more(1)`/`less(1)`/`head(1)` and you're likely
to find the most amusing possibilities in the first few screenfuls of output.
For example, `./klausler fawlty towers | more` quickly prints "waterfowl sty". The
fewer obscure short words in your system's dictionary, the better the quality
of the output; indeed, all one-letter words apart from `a`, `i`, and `s` (for
plurals) are ignored when the dictionary is constructed by `make dict.h`.

Some history and explanation: When I noticed the call for entries in this
year's IOCCC, I submitted two of them. I worked on the first one very hard to
obfuscate it beautifully, using a goofy algorithm, wonderful two's-complement
arithmetic tricks, and cute formatting. It was a glorious work so lovely as to
make even strong men weep in admiration... but it didn't win anything. On the
other hand, this crappy little other program, which was only mildly obfuscated
from its original hacked form, took home an award!

I'm embarrassed to admit that I don't even know which specific rule this entry
has abused. It's just yet another anagram generator and it was written very
late one night. And now I honestly do not know how it works, so please don't
ask. Upon reviewing the program after its unexpected honor, I guess that it's
remarkable only for its complete lack of macros, sneaky naming, `main()`
recursion, or other tricks. Enjoy!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
