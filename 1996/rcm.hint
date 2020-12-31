Best RFC Obfuscation:

    Ron McFarland
    7941 Fawncreek Drive
    Cincinnati, Ohio 45249
    USA


Judges' comments:

    To use:
	make rcm
	./rcm < rfc1951.gz

    Also try:

	./rcm < rfc1952.gz

    And for more information try:

	./rcm < rfc1951.gz
	./rcm < rfc1952.gz

    For a good noop try:

	gzip -c < rcm.c | ./rcm


Selected notes from the author:

    Except for some silly requirements regarding input validation, CRC
    checking, and similar unimportant fluff, this program is a fully
    compliant RFC1951/RFC1952 (GNU Gzip) file uncompressor.  Feed it a
    "gzip" compressed file on standard input, and it will write the fully
    uncompressed original file to standard output.

    ObJustifications for this entry:

    The Design Trade-off Argument

        "The 184 characters worth of defines in the build file have been
        carefully offset by 184 redundant and unecessary '{', '}', and ';'
        characters in the source file."

    The Design Review Argument

        "Using only 216 characters out of a maximum of 256, the build file
        meets and actually exceeds specification."

    The Program Metrics Argument

        "The program source is less than 3,100 characters in length and
        uncompresses file `emacs-19.34b.tar.gz' in about 130 seconds on
        my HP 9000/735.  The now obsolete source file `inflate.c' from
        the GNU gzip source tree is 31,613 characters in length and
        uncompresses the emacs distribution file in slightly under 25
        seconds.  Thus:

            3100 / 130 = 23.85       -vs-      31613 / 25 = 1264.52

        which represents a better than 530% improvement in the ratio of
        source file size to execution time."

    The Whining Programmer's Argument

        "The inflate algorithm requires that over 400 characters worth
        of constants and tables be defined.  Which means the program
        itself had to be squeezed down to about 1,100 IOCCC countable
        bytes."
