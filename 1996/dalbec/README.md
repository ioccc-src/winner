Best Numerical Obfuscation:

    John Dalbec
    20 Squire's Ct.	(home address)
    Canfield, OH 44406
    USA

    http://www.math.yale.edu/pub/users/dalbec/


Judges' comments:

    To use:
	make dalbec
	./dalbec

    The output is mis-leading ... why does it also print 2047?

    Also try:

	./dalbec 3

    why does it output 121?

    For a hint see:

	http://www.utm.edu/research/primes/prove2.html#sprp

    and then try to understand the source!  :-)

    We (the judges) recommend that you take the time needed to understand
    how this program works.  The source is small enough to make the effort
    reasonable, and complex enough to make it interesting.


Selected notes from the author:

    This program assumes that your terminal wraps lines automatically.
    If this is not the case, you may need to change the space in the
    "printf" format string to a newline character.

    An extra feature of this program is that it allows you (in most
    cases) to estimate the stack space available to programs on your
    system.  Simply allow the program to run to completion.  The stack
    space is roughly proportional to the last number printed.

	 (On SunOS/cc, the proportionality constant is about 48 bytes.)

    On completion, the program produces a core file that may be used to
    refine this estimate.  (Or you could try typing "limit" if you're
    running csh.) In rare cases the stack space may exceed 24*MAXINT
    bytes, in which case the program will produce an inaccurate estimate.

    This program is obfuscated:

    (1) by the use of easily-confused variable names

    (2) by using the implicit !=0 in conditional expressions

    (3) by substituting expressions such as !a for 0 where a!=0
                                        and !a for 1 where a==0

    (4) by the fact that main() is a single expression and so beautifies poorly

    (5) by the fact that main() is used
        (a) to compute powers in modular arithmetic
        (b) to recursively call itself in the main loop
