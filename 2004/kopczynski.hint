Best one-liner:

    Eryk Kopczynski
    Faculty of Mathematics, Informatics and Mechanics
    ul. Banacha 2
    02-097 Warszawa
    Poland

    http://www.mimuw.edu.pl/~erykk/

Judges' Comments:

    To build:

	make kopczynski

    Try:

	./kopczynski < kopczynski-8a
	./kopczynski < kopczynski-8b
	./kopczynski < kopczynski-8c
	./kopczynski < kopczynski-9
	./kopczynski < kopczynski-10
	./kopczynski < kopczynski-11

    What is in a line?  A lot when you obfuscate the way Eryk Kopczynski
    did it.  This small one line program is an outstanding technical
    work of art as well as one of the better one-liner programs that
    we have seen in years!

    Compile and run without arguments.  As input, give it an ASCII graphics
    figure 8, 9, 10, or 11 made of pound signs and spaces, of any size,
    shape, or orientation (that's right, an upside down 9 is still 9 :-).
    There is one restriction: the only line not containing "#" characters
    must be the last.

    The program will print what it thinks you've entered. If you enter
    anything that does not resemble 8, 9, 10, or 11, the result is
    seemingly arbitrary.  Actually it is not pseudo-random; can you find
    a pattern when it does not resemble 8, 9, 10 or 11?

    Here is a related puzzle: how to continue the sequence:

    	1, 0, 0, 0, 0, 0, 1, 0, 2, 1, ...

    The judges modified the program to print its result.  The original
    program returned the result as an exit code:

    	make kopczynski.orig

	./kopczynski.orig < kopczynski-10
	echo $?

    With certain arguments, you can alter the exit value.  Can you figure
    out how and why?


Selected Author's Comments:

    The program proves it is not as hard to recognize numbers. The current
    one liner version should correctly recognize all numbers from 8 to 11.
    (Unless you give it some very hard cases. For example, it cannot
    recognize negatives, zeros which have dots or slashes inside them,
    digits should be separated, and numbers should be "complete".)

    This program returns the number as its exit status. (In most shells,
    you can see the exit status of the last command with 'echo $?' (or
    just '$?').)

    	[[NOTE: The judges altered the primary version to output a number.]]

    On the input, give numbers formed as a sequences of empty spaces and #
    signs (you can also use dots instead of spaces), ending with an empty
    line. (No number has an empty line in it.) The program should return
    the number from 8 to 11 that it thinks it is.

    * The line is 131 bytes long (in 1986 165 bytes was OK, and the size
      limit has grown from 1986...).

    * I have decided that it is better for this program to return the
      number, not to print it, but if you think otherwise, the change would
      cost 6 chars (plus a warning). Change 'return *' to 'printf("%d",*)'.
      ('$?' is shorter)

    * I achieved some additional tightness by '-Dif=while', saved 9 chars
      of source for cost of 11 chars of build file. If I used '-DB=while',
      I would save 12 for 10, but I think the current version is slightly
      more obfuscated.

    * A remark on portability:

	It only requires two's compliment arithmetics, as far as I
	know. The maximum length of an input line is N-9, where
	N is the size of int in bits (you can try to compile with
	an option '-Dint=long long' for longer lines).

       -- Algorithm & Obfuscation --

    1. This program works by calculating the Euler characteristics of input,
       plus 9. It is the number of digits (i.e. separated #-regions) minus the
       number of holes in them. It turns out that this algorithm works
       correctly for all numbers from 8 to 11.

    2. We know that Euler characteristics is the number of "vertexes"

       #

       minus the number of "edges"

       ## # #. .#
          # .# #.   ('.' must be empty)

       plus the number of "faces"

       ##
       ##

    3. If we fill all these patterns to 2x2 squares,

       #? ## #? #. .# ##
       ?? ?? #? .# #. ##
       +1 -1 -1 -1 -1 +1

       substitute all possible "values" of '?' and sum up, we get that it is
       enough to calculate:

       #. .# ##
       .. #. #.
       +1 -1 -1

       Note now it is simple and obfuscated enough to be used as
       a "magic trick".

    4. I make a 16-character array; when indexed by 4-bit value which
       represents the 2x2 squares, it will return a number to add/subtract
       {-1,0,+1}

    5. We convert lines of input to bitmaps (N-bit integers). Additionally,
       it is heavily obfuscated by using negative numbers (two's compliment).
       For example, it turns out that 6 in "z=6" in the only 1-digit number
       which works here (and it's not only because we have "z>5" in the
       following while). The conversion routine also sets n=8 in an obfuscated
       and concise way.

    5. Since we always return the number from 8 to 11, we can calculate
       modulo 4. Instead of 16 {-1,0,+1} values, we use a 15-character string
       which agrees modulo 4 to the array in (4). (NUL fits very well as the
       16th character, so we use 15-character string.)

    6. Since the rule found in (3) did not produce any funny messages, I
       changed it until it did. (The # character to find vertexes is in the
       top right corner, not the top left one.) The following messages will
       also work instead of "has dirtiest IF":

       HighlandYachter
       TestDirtiestTen
       has lintiest IF
       TighterLaughter
       HustlerDaughter
       TighterDemoThen

       They can be mixed, of course!

    7. [[NOTE: Item 7 was removed by the judges so as to not spoil the
	     challenge of figuring how arguments can be used to alter
	     the exit value.]]

    8. The variable names are confusing.

    9. Finally, the program tries to be as concise as possible. Some
       obfuscation comes from this. For additional obfuscation and
       conciseness, 'if' means 'while'.
