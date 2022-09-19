Most Useful Program:

	Albert van der Horst
	S P&A R&C
	Oranjestraat 8
	3511 RA   UTRECHT
	The Netherlands


Judges' comments:

    For a canned example:
	make albert
	albert 1234567890123456789
    
    We were impressed with the speed at which it was able to factor
    arbitrarily large numbers consisting of factors that fit into
    a long.


Selected notes from the author:

    The Obfuscated version of the Horst algorithm.

    This program will factor unlimited length numbers and print the 
    factors in ascending order. Numbers of one digit (e.g. 8) 
    are rejected without notice.
    It quits as soon as there is at most one
    factor left, but that factor will not be shown. 
    It accomplishes this efficiently, without resorting to division
    or multiplication, until the candidate factor no longer fits in 
    a signed long. 

    The nicest way is to rename the program into e.g. 4294967297
    if you want to factor Fermat's 4th number. Then just run it.
    Or you may type "prog <some-number>"
    A nice one is also (30 ones)
    albert 111111111111111111111111111111

    Apart from the foregoing there are no special execution instructions.

    To customize the program into a factorizer of a fixed number, use
    cc albert.c -o 4294967297
    or some such.

    There are no data files used, and it is not possible to feed input
    via stdin.

    I think this program is a nice example of algorithmic obfuscation.
    Several times two similar algorithms are merged into one. Then you 
    need quite some tricks to get it running, such as long jumps 
    through recursive subroutines. I felt like a sword smith, 
    welding the sword very long, folding it again to the proper 
    length, keep on hammering till it is tight, then fold again.
    Always keeping it at the proper red hot temperature, but not too
    hot lest the hardness fades.
    The strict naming conventions for subroutines did not make things 
    much clearer after all, but it was not supposed to.

    I would like to draw attention to the robustness of the program
    with respect to error handling and the nice stopping criterion.
    The esthetic appeal of some lines is at the expense of clearness, 
    I apologize.
    Running the program through the c-beautifier reveals nothing,
    it will only destroy some of the lay out.
    Running the program through lint shows the usual remarks for a
    K&R program. Defeating this through casts does not make a program 
    cleaner in my opinion.

    Here are some hints, but they may not be too helpful.
    1. The Horst algorithm is described in the Hobby Computer Club 
	Newsletter, year 82, part 4, a real Dutch treat.
       Assembler, c and Forth version have been around for some years.
    2. Does fractal programming exist after all?
    3. You remember the ToomCook algorithm in Knuth?
       It uses iteration instead of recursion and is quite jumpy.
       This program shares these disadvantages in a modified form.
    4. The Conversion is to be found in Knuth, not so the Observation.
       The Observation: "if it ends in a zero, it is divisible by ten"

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
