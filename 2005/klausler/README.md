# Abuse of the rules

Peter Klausler
Cray Inc.
2802 W 40th St
Minneapolis MN 55410
USA
pmk@cray.com

## Judges' comments

To reduce the size of the source, include other people's data.
That is what Peter suggests when he describes how to generate
a critical header file.

In other words: make use of other words!  :-)

Rules might have to be changed!

### To build

      #!/bin/sh
      dict=""
      for f in mydict /usr/share/dict/words /usr/dict/words /usr/lib/dict/words
      do if [ -r $f ]; then dict="$dict $f"; fi; done

      if [ ".$dict" = . ]; then echo no dictionary found; exit 1; fi

      cat $dict | \ 
         tr -cd 'A-Za-z\n' | \ 
         tr A-Z a-z | \ 
         egrep -v '^[^ais]$' | \ 
         sort | \ 
         uniq | \ 
         sed 's/^/"/;s/$/",/' >dict.h

      cc -o klausler klausler.c

### To run

           klausler peter klausler | head

## Author's comments

A useful tool to help one appear extra smart and witty when IRCing, or even
just highly annoying.

Finds best anagrams for word or phrase given as program arguments. Use only
lower-case letters in these arguments. Output is sorted firstly in ascending
order of word count (fewer words are better) and secondly in descending order
of word length. Pipe the output into more(1)/less(1)/head(1) and you're likely
to find the most amusing possibilities in the first few screenfuls of output.
For example, "ana fawlty towers | more" quickly prints "waterfowl sty". The
fewer obscure short words in your system's dictionary, the better the quality
of the output; indeed, all one-letter words apart from "a", "i", and "s" (for
plurals) are ignored when the dictionary is constructed by build.sh.

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
remarkable only for its complete lack of macros, sneaky naming, main()
recursion, or other tricks. Enjoy!
