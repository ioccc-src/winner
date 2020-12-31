Worst Abuse of the C Preprocessor:

    Jens Schweikhardt
    DFN Network Operation Center
    Schlartaeckerweg 3 (home address)
    D-71384 Weinstadt
    Germany

    http://www.uni-stuttgart.de/People/schweikhardt/home.html


Judges' comments:

    To use:
	make schweikh1
	./schweikh1

    Look at the source.  There is something very odd going on here.  
    Where does the real code come from if everything is a C pre-processor 
    statement?

    Clearly this is either the Best Use or the Worst Abuse of the
    C Preprocessor that the judges have seen this year!


Selected notes from the author:

    What this program does
    ----------------------

    This program is an implementation of an algorithm that calculates
    the date of the Sunday following the first full moon after the
    spring equinoxe. (Also known as "Easter", defined this way by the
    Nicaean Concilium in 325 Anno Domini.) The algorithm is attributed
    to the famous mathematician Carl Friedrich Gauss ["Meyers Handbuch
    ueber das Weltall", Meyer, 5th Edition, 1973, p149] and is suitable
    for anni domini within the Gregorian Calendar, that is, from 1582 AD
    to 2199 AD: 

    Let J be the year.
    If J is from 1582 to 1699, let M be 22, let N be 2
    If J is from 1700 to 1799, let M be 23, let N be 3
    If J is from 1800 to 1899, let M be 23, let N be 4
    If J is from 1900 to 2099, let M be 24, let N be 5
    If J is from 2100 to 2199, let M be 24, let N be 6
    Let a be the modulus of J divided by 19
    Let b be the modulus of J divided by 4
    Let c be the modulus of J divided by 7
    Let d be the modulus of (19a + M) divided by 30
    Let e be the modulus of (2b + 4c + 6d + N) divided by 7
    The interesting Sunday is either
        March 22 + d + e   or
        April d + e - 9    (only one of them is a valid date)
    with the following exceptions:
        April 26 must always be changed to April 19
        April 25 must be changed to April 18 if d is 28 and a greater than 10

    Example:  J = 1962, M = 24, N = 5
        a = J % 19 = 5
        b = J %  4 = 2
        c = J %  7 = 2
        d = 119 % 30 = 29
        e = 191 % 7 = 2
    March 53 is invalid, so the result is April 22 1962

    Why I think this is obfuscated
    ------------------------------

    Apart from the calculation of the Easter date, the definition *and*
    calculation of which are obfuscations in their own right,
    obfuscation lurks in many places. Look at those macro identifiers.
    What can be more obvious than a program that explicitly mentions the
    grammatical constructs it is composed of? If you look at K&RII A.9.3
    you will find that a compound statement consists of an opening brace
    followed by a declaration list followed by a semicolon followed by a
    statement list followed by another semicolon and a closing brace.
    Nobody can learn that by heart so I gently remind the reader by
    defining a macro that expresses this clearly (line 25). This goes up
    to the definition of a translation unit. Unfortunately, due to the
    IOCCC's size restrictions, I had to abbreviate some syntactic
    elements. "ae" actually reads "assignment expression". I had to stop
    at some arbitrary point, so don't waste your time trying to find out
    how preprocessing tokens form type qualifier lists, cast expressions
    or direct abstract declarators. Assuming the reader knows about
    these easy to remember language elements is justified in my opinion.


    The moral:
      Try to be as precise as can be and no one will comprehend what you mean.

    The formula:
      comprehension = 1/(2**precision)

    The interpretation:
      "Say nothing and everybody will understand."

    The -I/usr/include in the build file is needed by gcc on Solaris because
    gcc's "fixed" header in gcc-lib/sparc-sun-solaris2.5/2.7.2/include/errno.h
    is broken (sort of) because it has *two* identical extern
    declarations of errno. This leads to an error due to the
    redefinition of main. The -I option makes sure the working
    /usr/include/errno.h is found first, which shouldn't harm on other
    systems. 

    Usage
    -----

    The program is run without arguments. It prints all dates in order.
