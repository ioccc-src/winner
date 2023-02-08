# Most useful obfuscation

Qiming Hou  
<hqm03ster@gmail.com>  
<http://www.houqiming.net>  


## Judges' comments:

### To build:

    make hou

### To run:

    ./hou syntax-file file-to-process

### Try (Unix):

The results are best viewed in a 80x25 console with ANSI colors.

    less hou.c

    ./hou ansi.txt hou.c | less -r

    ./hou chk.txt hou.c | wc

    ./hou markdown.txt remarks.markdown > remarks.htm
    your-browser remarks.htm

### Try (Windows):

    copy header.htm hou.htm /y
    hou html.txt hou.c >> hou.htm
    start hou.htm

### Selected Judges Remarks:

What a versatile entry! It can be used to check the size of IOCCC entries *and* to publish them as HTML.

For extra credit: what is the meaning of the number 2321237?


## Author's comments:

### Disclaimer

The reviewer may have already noticed that the 2nd page of this program is a dense blob, which is discouraged by the contest rules. We wish to point out that a majority of state-of-art programming editors support syntax highlighting, which should be enabled when reading this entry. Anticipating that the reviewer's preferred color setting may produce a suboptimal visual effect, a few syntax files are provided to highlight the source code under an author-provided setting, using the submitted program itself. Syntax highlighting would also visually improve the 3rd page.

The code may throw a few warnings due to formating constraints. The author did try to remove warnings under gcc and Visual Studio, though.

The author does not own the original anime series where the embedded ASCII arts come from. For comparison, original non-ASCII art depictions of the relevant characters and objects can be found by googling the embedded text messages.

### Syntax files

The syntax file consists of a number of rewriting rules. Each rule consists of a regular expression, a space, a format string, and a newline. All text matching the regular expression would be replaced by the format string. In case of a conflict, rules appearing earlier would take precedence. One can refer to the original text in the format string using "%s". Other "%" characters in the format string must be escaped with another "%". The space character can be used in the regular expression by escaping it with [] or "". 

The following regular expression operators are supported:

    () [] * + ? | ""

For example, one can use the following expression to match a certain declaration statement in hou.c:

    "char"[ *]*[a-zA-Z_][0-9a-zA-Z_]*[ ]*((=[0-9a-zA-Z_ ]+)|(\[[0-9a-zA-Z_ ]*\]))?[ ]*(,[ *]*[a-zA-Z_][0-9a-zA-Z_]*[ ]*((=[0-9a-zA-Z_ ]+)|(\[[0-9a-zA-Z_ ]*\]))?[ ]*)*;

The regex engine is also algorithmically efficient. To illustrate the point, ansi.txt contains a pathological expression [2] that guarantees a hang for the competing Perl engine while matching itself. Try to compare these two engines:

    ./hou ansi.txt ansi.txt
    perl patho.pl < ansi.txt

Finally, there are a few limitations...


- The only escape sequence supported is \n and it doesn't work in [].
- The maximum file/rule size is a linear function of the hard-coded constant M.
- Single-character matches at the end of file may be missed.
- The operator | doesn't obey precedence rules and some extra ()s may be required.
- Incorrect syntax files are not tolerated.
- The program relies on ASCII.

### Why obfuscated

The first layer of obfuscation comes from the challenge of embedding a large ASCII art in a dense blob. The entire art is composed using only keywords, strings and character constants. That results in a number of otherwise useless defines and quite a number of unconventionally written constants. While the preprocessor may remove the former, the later would remain regardless of beautification and preprocessing.

The second layer of obfuscation comes from the need to squeeze a reasonably powerful regex engine into the remaining area that isn't occupied by excessive keywords and useless constants. To achieve this, the regex compiler is written using the same threaded virtual machine [1] that parses the regex. Due to compiler limitations, the generated VM code also ends up obscured by a large amount of spaghetti branches and virtual thread creations. Finally, the VM in [1] is extended to track multiple expression matches for the actual formating.

As an extra tweak, the text message actually does something useful. Remove the "Make a contract with me" catch line and the program would cease to function.

### References

[1] [Russ Cox, Regular Expression Matching: the Virtual Machine Approach](http://swtch.com/~rsc/regexp/regexp2.html)

[2] [Regular Expression Matching Can Be Simple And Fast (but is slow in Java, Perl, PHP, Python, Ruby, ...)](http://swtch.com/~rsc/regexp/regexp1.html)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
