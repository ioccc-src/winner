Best Use of Obfuscation:

    Leonid A. Broukhis
    46728 Crawford St., apt. 20
    Fremont, CA 94539 
    USA


Judges' comments:

    To use:
	make leo

    Try: 
	leo 1 | cat - /dev/tty | gs -
   	leo 37 80 | cat - /dev/tty | gs -

    Press return after each image is drawn.

    The variable names are element-ary.  If you find this confusing,
    remember that it is nu-clear.  :-)

    Some Ghostscripts/Postscript programs cleared the screen right after
    the image is drawn, so we added element 106 which acts as an input
    buffer.  The original version may be found in leo.orig.c.


    If you don't have gs or an equivalent postscript viewer, try:

	echo "" | leo 1 > foo.ps

    and send foo.ps to your local postscript printer.

    
    To qualify for a category specially for yourself in  the Geek code, 
    find out the all the secret switches that the author doesn't divulge !
    (All  switches are single characters on the command line - anything that's
     not a number is a candidate)


Selected notes from the author:

    The usage is:

    prog.sh [ deep ] [ right ] [ Variable ] [ cycle [ freq ] ]

    where the first three are literal words, `cycle' is a positive
    integer (0 is ignored), and `freq' is an integer (default = 0)
    supposed to be in range 0..100 (bigger values are allowed, however).
    Invalid parameters and options usually stop the command line
    parsing (but not always, why?). The actual position of the word
    options does not matter, so "prog.sh right Variable 1 70"
    is equivalent to "prog.sh 0 0 0 1 Variable 70 right", etc.

    If `Variable' is used, `cycle' is almost ignored (see below) but has
    to be present if you want to enter `freq' (and you usually do).

    Some options to try (besides the obvious):

	leo 1 | cat - /dev/tty | gs -

    This draws the basic pattern I invented in high school:

    You take a big sheet of "arithmetic" paper and draw a line
    of length 1 (between 2 crossings) it the center of the sheet:

				|

    This makes 2 open ends (I think the notion of an "open end" doesn't
    require explanations) in step 1. Now, until there are open ends in step N,
    repeat: for each open end pretend it points north and draw 2 lines going
    northwest and northeast from it to the nearest crossings. This needs to be
    done "simultaneously" for all ends that are open at the moment.


    Step 2:
                               \./
                                |
                               / \

    Step 3:
                            __|   |__
                               \./
                                |
                            __ / \ __
                              |   |

                                .
    Step 4:                  \./ \./
                           \__|   |__/
                           /   \./   \
                                |
                           \__./ \.__/
                           /  |   |  \
                             / \./ \


    Step 5:
			  ._|   .   |_.
			__|  \./ \./  |__
			   \__|   |__/
			__./   \./   \.__
			__I     |     I__
			   \__./ \.__/
			__./  |   |  \.__
			  |_./ \./ \._|
			    |       |

The lines marked by I show the places where "simultaneity" is significant.

	Note that so far all the drawings represent valid
	structural formulas of some organic substances.

		step 1: ethane
		step 2: 2,3-dimethylbutane
		step 3: (2,5-dimethyl;3,4-isopropyl)-hexane
		step 4 and 5: I don't know. Do you?
		etc.

    Step 6:
               \./     \./                 \./     \./
              ._|   .   |_.               ._|   .   |_.
           \__|  \./ \./  |__/         \__|  \./ \./  |__/
           /   \__|   |__/   \         /   \__|   |__/   \
           \__./   \./   \.__/         \__./   \./   \.__/
           X__|     |     |__X   or    <__|     |     |__>
           /   \__./ \.__/   \         /   \__./ \.__/   \
           \__./  |   |  \.__/         \__./  |   |  \.__/
           /  |_./ \./ \._|            /  |_./ \./ \._|
                |       |                   |       |
               / \     / \                 / \     / \
    
    depending on the desired "hairiness". The original (paper-based)
    algorithm was "hairy", but it didn't look as good on the screen.
    
    The program cannot handle non-hairy mode 100% correctly - step 6 happens
    to be
    
                                      |__
        ...__/                  ...__/
        ...  \                  ...  \.
        ...__/                  ...__/|__
        ...__Y  and step 7:     ...__Y
        ...  \                  ...  \
        ...__/                  ...__/
             \                       \.__
                                      |
    
    and so on: the horisontal symmetry has been lost. That's why
    the opening for step 1 is not a single line but a cross:
    
                                \./
                                / \
    

    To watch it repeatedly (as a screen saver), use:
    
	leo 2 | cat - /dev/tty | gs -

    The command line:

	leo Variable 1 | cat - /dev/tty | gs -

    This draws the same as above. Try:
    
	leo Variable 1 1 | cat - /dev/tty | gs -

    what happened to the picture? Increase `freq' and watch the changes.

    If `cycle' is more than 1, the program loops, allowing the user to
    enjoy randomly changing patterns (the delay is 3 sec),
    but there is a secret switch to suppress looping : useful
    if you want to pipe the output to a printer.

    uudecode the spoiler below if you really want to know.
begin 664 spoiler1
M*%1H92!C;VQO;B J:7,J('1H92!S96-R970@<W=I=&-H("T@=&AE('-P86-E
=(&)E9F]R92!I="!I<R!N;W0@82!M:7-T86ME*0II
 
end

    If `Variable' is used, the actual value of `cycle' doesn't matter,
    as far as it is > 1. To figure out what difference
    `cycle' makes when `Variable' is not used, try

	leo Variable 37 80 | cat - /dev/tty | gs -

    and other values of `cycle'; smaller values usually require
    smaller values of `freq' for the patterns to be non-trivial

    The options `deep' and `right' make the patterns to be drawn in different
    manners. Try all the examples above with `deep' and with `right'.
    What is the difference between them?

    ...There is a little flaw in the implementation of the algorithm,
    and sometimes the patterns are not symmetrical when they ought to be
    (the program needs to be slightly changed to expose the flaw,
    otherwise it is hardly noticeable, if ever).

    A quick and dirty fix (turned on by another secret switch)
    makes the patterns symmetrical, but a little too HAIRY.


    There is one more secret switch (it shall remain nameless), and I don't
    even want to explain what it does. You've been warned!


	*               *               *

    Special thanks:

    - to PostScript syntax designers for the curly braces;
    - to Dmitry Mendeleyev for his periodic table of elements;
    - to Hydrogen for having 2 more isotopes.


