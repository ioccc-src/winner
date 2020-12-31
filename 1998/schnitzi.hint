Best Flow Control:

    Mark Schnitzius
    ISX Corporation
    1280 West Peachtree St. Apt. 1507
    Atlanta, GA 30309
    USA

    http://east.isx.com/~schnitzi/


Judge's Comments:

    To build:

	make schnitzi

    To use:

	./schnitzi 5 > sort.c
	cc sort.c -o sort
	echo 123 > data
	echo 234 >> data
	echo 413 >> data
	echo 134 >> data
	echo 324 >> data
	./sort < data

    This is a beautiful program.  How can a program with no conditional
    behavior at all have output which depends on anything?

    For hints on deciphering this, see below past the Author's Comments;
    they're a nice summary, but they leave the mystery intact.


Selected Author's Comments:

    In literary circles, there is a poetic form called a "lipogram",
    which is a poem in which a specific letter has been distinctly
    avoided.  This principle can be applied in other ways.  For
    instance, in this paragraph, the vowel which immediately follows
    't' in the alphabet is nowhere to be seen.  There is even an
    entire novel (E. V. Wright's "Gadsby") in which no word contains
    the letter 'e'.

    The IOCCC has been no stranger to this concept.  Several winning
    entries from years past have accomplished interesting feats while
    completely avoiding the use of certain C constructs thought to
    be essential (e.g. 1988's robison.c).  If you have to ask why they
    would do it this way, then this contest just isn't for you.

    In continuing with this fine tradition, this program suggests to
    the ANSI committee some new practical simplifications for the C
    language.  For instance, it appears that CONDITIONAL BRANCHING isn't
    really necessary.  So, we can do away with while, do...while, for,
    if/else, switch, ?:, or anything else that might cause any kind of
    nondeterministic jump in the code.  There's too much uncertainty
    in the world anyway.

    Function parameters and return types just confuse people anyway, so
    get rid of them.  Same with local variables.  In fact, all you really
    need are assignment statements, and maybe one printf() and one goto.

    This style of programming is also ideal for systems with limited
    memory capacity, since the function call stack never goes beyond
    a depth of one.

    So what does it do?  Give it an integer (1 < n < 27) on the command
    line, such as

    	schnitzi 5

    The output will itself be a lipographic program, one which inputs
    (in this case) five numbers and prints them out sorted.  It sorts
    them, however, using only "if/else" statements, without arrays or
    looping.  To see the resulting program run, redirect the output from
    "schnitzi" into another file, like this

    	schnitzi 4 > sort.c

    and then compile it.

Spoilers And Hints:

    The big key to this program is figuring out what the names of the
    functions ought to be; a bit of research may allow you to guess at
    a few crucial ones.

    The only function ever called is "O", but "O" is just set to point to
    other functions all the time.  Or, almost all the time.

    So how does 'h' get set, and what to?
