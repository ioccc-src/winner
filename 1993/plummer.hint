Best One Liner:

	Mark Plummer
	2901 Reckord Road
	Fallston, MD, 21047
	USA


Judges' comments:

    To run:
	make plummer
	./plummer number arg

    where:
	number	a number 	(try 21701)
	arg	any argument
    
    For extra credit: What happens when 'number' contains non-numeric
    characters, and why?


Selected notes from the author:

    This program prints out all numbers up to a given number of digits
    on a single line.  When the largest number is reached, the program
    starts again with 0.  It takes two arguments: the first argument
    specifies the number to start counting from and uses leading 0's to
    indicate the number of digits, the second argument can be anything
    but must be present.

    Variable names are single characters chosen for their similarity to
    other characters (O for 0, l for 1, S for 5 (in some fonts), and _
    for ...  well nothing really, but it is easy to miss).  To prevent
    the need for strlen(), the fact that argv is laid out sequentially
    is exploited (ie.  argv[i + 1] == argv[i] + strlen(argv[i]) + 1).
    This is not portable (by the books), but it seems to work
    everywhere I try (actually, for vms, that only holds for i > 1).
    Also, I depend on the fact that a carriage return causes the line
    just written to be overwritten.  lint (and most compilers) complain
    that there is no control path leading to a return from main().  At
    125 characters, it still fits on a single line (for those of us who
    don't mind ruining our eyes with 132 column screens).

    The first statement points the base of l (the argument vector) to
    be the first argument by incrementing it.  It then assigns O to
    point to the character before the first character of the second
    argument which also happens to be the null termination of the first
    argument.  *O gets a \r assigned to it.  Finally 0 is assigned to
    the first character of the second argument which has the effect of
    null terminating the first argument after the carriage return had
    removed its null termination.  I really tried to make the last part
    of that statement part of the original expression, but the best I
    could do was attach it with a comma (against the advice of K&R).
    The for loop runs the next for loop continuously (actually until
    the machine crashes or the user gets tired of seeing the
    counting).  The next for loop is the meat of the program.  In the
    initialization statement, the string pointed to by l (the first
    argument containing the digits used for counting followed by a \r)
    is printed, and _ is started at the least significant digit in the
    string.  In the test portion, _ is insured not to be past the
    beginning of the string (the most significant digit), and the digit
    pointed to by _ is incremented and checked to be sure that it _is_
    greater than '9' (written here as (S+*O+S)*S).  If the test fails,
    either the string has been incremented or each digit in the string
    has been reset to '0'.  If the test succeeded, the iteration
    statement assigns '0' (written here as (S+*O)*S (which has the
    added bonus of having the code be a cry for help)) to *_ and
    decrements _ to point to the next more significant digit to be
    incremented; it is done only when a carry situation results (*_ has
    been incremented past '9').

    The inspiration for this program came from actual code which dealt
    with scanning for a unique temporary filename by appending a
    successively larger number to the end of a string.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
