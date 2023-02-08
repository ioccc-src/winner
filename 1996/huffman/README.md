Best Obfuscated Character Set Utility:

    Ken Huffman
    Applied Innovation Inc
    5800 Innovation Dr.
    Dublin, OH 43016
    USA
    <http://www.huffmancoding.com>
    huffmancoding@gmail.com


Judges' comments:

    To use:
	make huffman
	echo 'Huffman Decoding' | ./huffman

    Try: 
	echo 'seeing or feeling is believing' | ./huffman
	echo 'CC OR NOT CC' | ./huffman | ./huffman

    If you are still confused and want to read a spoiler, check out
    the source and it will be clear as mud!

    And for a misleading hint, consider who won!  :-)

    And if you really can't see what is going on, here is an extra spoiler:

	./huffman < huffman.c

    This entry was very well received at the IOCCC BOF.


Selected notes from the author:

    This filter program is really not obfuscated code.  It compiles cleanly
    with an ANSI C compiler and comes with user documentation that even a
    blind person could read.

    The program is a bi-directional filter with the output of the program 
    suitable for its input.  The output of this program, when used as input,
    undoes the original program filtering.

    This program accepts any alphanumeric text that has lines less than 100
    characters.  The user is encouraged to use the program's source as input
    to the executable.

    This program is best appreciated on a tactile monitor.
