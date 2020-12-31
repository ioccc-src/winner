# Most elementary use of C - Silver award

Tsukasa Hamano  
<hamano@cuspy.org>  


## Judges' comments:
### To build:

    make hamano

### To run:

    ./hamano < textfile > output.pdf

### Try:

    ./hamano < hint.text > hint.pdf

    # You can read output.pdf with PDF reader
    acroread hint.pdf
    # or
    evince hint.pdf

    # deobfuscate
    gcc -xc hint.pdf -o hint
    ./hint

    # Of course, You can obfuscate c code
    echo 'void main(){puts("Hello World!");}' | ./hamano > hello.pdf
    gcc -xc hello.pdf -o hello2
    ./hello2 | gcc -xc - -o ./hello3
    ./hello3

### Selected Judges Remarks:

This entry treads into a new territory for IOCCC - generating PDF files.

The originally submitted entry could have been thought of as a "Best abuse of
Ghostscript" winner.  :-)

The source code and rendered pages are obfuscated for humans (where
is the font?), and the submitted entry created PDF files that left Ghostscript
confused.

The results can be viewed with Acrobat Reader,
[evince](http://en.wikipedia.org/wiki/Evince) and Apple's Preview.

The updated version can also be viewed using Ghostscript.

There is something strange about the little flags in the output.
A search of English literature will provide a hint.  The conclusion
you might draw is too elementary.  :-)

So what do those flags really mean?

The [Dancing men algorithm][1] might be useful.

Don't forget to take a look at the generated PDF, perhaps you might even want
to compile the output with a C compiler.  When you run it, what does it
output?


## Author's comments:
This program obfuscate text file into PDF file with Dancing men
algorithm.

<http://en.wikipedia.org/wiki/The_Adventure_of_the_Dancing_Men>

Probably, the output PDF file is compliant with PDF 1.3. And also
available to compile as C code.

I've been tested with GCC 4.7 and Clang 3.0 on Linux, and following
PDF Reader:

 * Adobe Acrobat Reader
 * Evince
 * Ghostscript
 * Xpdf

### Obfuscations
This program is obfuscated by using classical methods.
But can you find out the embedded font from fragmented glyph?

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
