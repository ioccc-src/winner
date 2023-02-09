Best short program:

    Raymond Cheong
    Johns Hopkins University
    USA

    http://www.bme.jhu.edu/~rcheong/


Judges' Comments:

    To build:

    	make cheong

     Try:

	./cheong 1024
	./cheong 12345678901234567890
	./cheong 05305265226926441255040573044986873789

     Be sure to give an even number of digits in the argument.  Add a
     leading 0 if needed.

     The source code is nice, compact, and self documenting
     as all good programs should be!  :-)


Selected Author's Comments:

    Operation
    =========
    Compile normally and run with one argument, an integer with 2n digits.
    Program will return the integer part of its square root (n-digits).
    For example,

       > gcc -o cheong cheong.c
       > cheong 1234567890
       35136
       > cheong 0200000000000000000000000000
       14142135623730
       >

    Deviation from these instructions will cause undefined results. :-)


    Portability
    ===========
    This program runs normally on any ANSI C compiler and is ASCII dependent.

    Strict compiling gives just one unavoidable warning
       > gcc -ansi -Wall cheong.c
       cheong.c:3: warning: third argument of `main' should probably be `char **'


    Obfuscation
    ===========
    The main obfuscation is the algorithm used to calculate square roots,
    sometimes known as the longhand method.  The basic algorithm is itself
    obfuscated in that it only uses subtraction to calculate square roots.
    (For a detailed explanation, check Google or see Jack Crenshaw's article
    at http://www.embedded.com/98/9802fe2.htm)  This program uses an even
    more obscured version which includes the following:
       - A single string is used to store two numbers of different lengths
       - Operations are done in a weird hybrid of base 10 and base 20
       - Subtraction is done addition style, i.e. 4 minus 8 equals 6 carry a -1
       - Recursive calls to main()

    Minor obfuscations:
       - Self documenting whitespace in rectangular code block, for fun and
         glory (view with fixed-width font)
       - Integer constants adjusted to less meaningful values, just for added
         confusion
       - Hard-to-read, meaningless variable names to spite the reader

    Challenges for the masses:
       - What are the meanings [sic, plural] of the variable o?
       - Why is (c+999)%10-(D[I]+92)%10 not equivalent to (c-D[I]+7)%10?
       - How does the program terminate?
       - Is the programmer sane? ;-)


    Appreciation
    ============
    Thanks goes out to Bobby Rohde for numerous suggestions on how to shorten
    the program.
