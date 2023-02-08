Best game:

    Arch D. Robison
    1406 Country Lake Drive
    Champaign IL 61821
    USA


Judges' Comments:

    To build:

	make robison

    To run:

	./robison

    The program plays almost always reasonably, but does not always detect
    illegal moves.  Try "9 1" as your first move, then "13 2". Also it
    tends to think for quite a while in the beginning of a game. It is
    also smart enough to give up by making a losing move at the end of
    a game when its position is hopeless.

    Unfortunately, due to the contest rules, we're unable to grant the
    author a patent he applied for.  :-)


Selected Author's Comments:

    TITLE OF INVENTION

    Highly Compressed Program for Playing Hygienic Checkers

    FIELD OF INVENTION

    The present invention generally relates to checkers.

    BACKGROUND OF THE INVENTION

    Within the field of checkers, the problem of finding a hygienic opponent
    is difficult, as good opponents are peculiar to the tavern habitat of
    cracker-barrels, pot-belly stoves, tobacco, and spittoons.

    BRIEF SUMMARY OF THE INVENTION

    The present invention plays checkers without spitting.

    BRIEF DESCRIPTION OF SEVERAL VIEWS OF THE INVENTION

    FIG. 1 shows a numbering of positions.

    FIG. 2 shows a numbering of directions.

    FIG. 3 shows a sample board.

    FIG. 4 shows a method in accordance with the present invention.

    DETAILED DESCRIPTION OF THE INVENTION

    Operator plays Black (x); the program plays White (o).  Said Black goes
    first.  On operators turn, said program requests a position and direction.
    FIG. 1 shows the numbering of the squares.  FIG. 2 shows the numbering of
    directions.  As per standard rules, if one or more jumps are possible, one
     of the jumps must be taken in preference to other moves.  Said operator
    enters the numbers for the position and direction.  If after jumping over a
    piece, another jump is possible, and said piece did not become a king after
    said jump, standard rules require that another jump be taken.  In said case,
    said program requests a direction only in which to continue jumping from the
    present position.  Kings are denoted by upper case.  FIG 3. shows a sample
    board.  There is a black king (X) on square 30 and a red king (O) on square
    2. The numbers on the right are the numbers of the rightmost square in each
    row.

    A player loses if they cannot make a legal move.  Said loss is trivially
    true if player loses all of his/her pieces.  The present invention announces
    said loser.

    FIG. 4 shows a C program in accordance with the present invention.  Control
    flow is straightforward: control enters routine ``main'', executes a
    plurality of statements, and exits via return statement.  FIG. 4 presumes
    that type int is 32 bits and short is 16 bits, which are essential to the
    preferred embodiment of the invention.  FIG. 4 also presumes that the host
    computer uses ASCII encoding for characters. It should be obvious that
    practitioners skilled in the art of C programming can remove said
    limitations.

    The disclosure here describes a particular embodiment of the present
    invention, and other embodiments within the spirit of this disclosure
    are possible, as well as consumption of spirits while playing.

    CLAIMS

    I claim, by letters patently absurd:

    1.  A method for playing checkers on a computer-based system, where said
        method's source code fits into 1536 countable bytes of source code,
        where a byte is countable if

            (a) it is not whitespace and
            (b) it is not a {, }, or ; immediately followed by whitespace.

    2.  The method of claim 1, further comprising a method of alpha-beta pruning
        that exploits the zero-sum nature of the game to unify alpha
        and beta cuts.

    3.  The method of claim 1, further comprising the step of formatting the
        source code with short lines, in order to impress manager with
        high productivity, when measured in lines of code.

    4.  The method of claim 3, further comprising the step for telling
        skeptical manager that this is the well-known technique of
        "linear programming".

    5.  The method of claim 1, where ~- and -~ replace the obvious arithmetic
        operations.

    6.  The method of claim 1, further comprising a method where

            (a) strings are encrypted in a manner suitable as C strings, and
            (b) 7-bit ASCII characters with uniform distribution are maximally
                packed subject to the restriction that
            (c) each byte is not countable.

    7.  A method for a computer-based system that uses a single shared code
        sequence to either sum a plurality of bits in an N-bit word or reverses
        them, in lg(N) time, depending upon a parameter.

    DRAWINGS

    FIG 1.

            +--+--+--+--+--+--+--+--+
            |32|  |31|  |30|  |29|  |
            +--+--+--+--+--+--+--+--+
            |  |28|  |27|  |26|  |25|
            +--+--+--+--+--+--+--+--+
            |24|  |23|  |22|  |21|  |
            +--+--+--+--+--+--+--+--+
            |  |20|  |19|  |18|  |17|
            +--+--+--+--+--+--+--+--+
            |16|  |15|  |14|  |13|  |
            +--+--+--+--+--+--+--+--+
            |  |12|  |11|  |10|  | 9|
            +--+--+--+--+--+--+--+--+
            | 8|  | 7|  | 6|  | 5|  |
            +--+--+--+--+--+--+--+--+
            |  | 4|  | 3|  | 2|  | 1|
            +--+--+--+--+--+--+--+--+

    FIG. 2.

            1   0
             \ /
              .
             / \
            3   2

    FIG. 3.

            o o X .  29
             o . . . 25
            o . . o  21
             . o . o 17
            x . . .  13
             . . x .  9
            x x . .   5
             x x O x  1

    FIG. 4

    [See attached listing.]
