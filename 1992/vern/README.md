Best of Show:

	Vern Paxson
	Lawrence Berkeley Laboratory
	Computer Systems Engineering
	Bldg. 46A, Room 1123
	Lawrence Berkeley Laboratory
	1 Cyclotron Rd.
	Berkeley, CA 94720  USA


Judges' comments:

     Try: 
	make vern
	vern 3		<-- default is 2

     You might start off by giving the following input:
	63 43
	76 55
	71 52
	67 57		(this may take a while)
    
    The judges assume no responsibility for the obfuscated opening
    suggested above.  :-)

    For a real quick game try:
	vern

	65 55
	66 46

    NOTE: Move values must be restricted to the range 00 to 77.

    NOTE: Because some mailers have problems with the original winning source,
	  a slightly modified version with shorter lines has been provided.


Selected notes from the author:

    This program plays chess.  You play the white pieces and the program
    the black pieces.  Moves are entered as a two-digit number specifying
    the coordinates of the piece to be moved followed by another two-digit
    number specifying the coordinates of where to move it.  Rows and
    columns are numbered starting with (0,0) for the upper-lefthand corner
    (black's queen's rook) and going to (7,7) for the lower-righthand
    corner (white's king's rook).  For example, the PK4 opening for white
    is indicated as "64 44".  Moves are read using scanf() so care should
    be taken to not enter the wrong number of fields.

    If the move you enter is illegal then you are just prompted again to
    move.  If the move is legal then the new position is displayed and the
    program starts computing its response.  For every 64 board positions it
    examines a "." is printed.  Once it has chosen its move it simply
    displays the board updated to reflect the move.

    Your move is prompted for using a string like "1351 9 2 >".  The first
    number is how many board positions the program examined when computing
    its previous response.  The second number is its anticipated value for
    the move it just made (with larger numbers meaning an ultimately better
    board position for it), and the third number is the evaluation it
    assigns to the your current position (larger numbers meaning better
    positions for you).  A ">" indicates that you are not in check; for
    check it is changed to "!".

    There are a few limitations on play:

    o	    castling can only be done on the king's side;
    o	    prohibitions against castling out of or through check are
     		not enforced;
    o	    prohibitions against castling if the king or rook have moved
     		are not enforced;
    o	    pawns are always promoted to queens;
    o	    en passant is not allowed;
    o	    the board-position-repeated-three-times and fifty-moves
     		stalemates are not recognized;

    If you checkmate the computer it prints "Rats!" and exits.  If your own
    checkmate is imminent it prints "Har har." but doesn't exit so it can
    rub your nose in defeat (which may be a move or two away if you're
    playing at a high "ply" - see the next paragraph).  Stalemates are not
    recognized per se, but when selecting its move the program assigns a
    stalemate position a value of 0 so it will try for a stalemate if its
    other options are worse.

    The program takes one optional argument indicating the ply (lookahead)
    it should use.  The default is 2, which is enough to keep it from
    making flaming blunders.  The higher the ply, the better the play, and
    the longer you have to wait.  For example, at a ply of 2, a response to
    the PK4 opening takes about 1.8 CPU seconds on a SPARC ELC when
    compiled -O with Sun cc.  A ply of 3 takes 13 CPU seconds (and results
    in a different response to PK4) and a ply of 4 takes a little under 4
    CPU minutes (and for PK4 comes up with the same response as a ply of
    3).  A ply of 3 is in general good enough to avoid not only flaming
    blunders but also immediately stupid moves altogether.  A ply of 4
    will find all mate-in-two's.



    This program is obfuscated in a number of ways.  First, it abuses the
    contest rule regarding ';', '{', and '}' in the source not counting
    against the non-whitespace character limit if followed by whitespace.
    As can be seen from the build file, certain combinations of these
    characters followed by a particular whitespace character are expanded
    at build time into much-needed text.  Without this hack the program
    wouldn't pass the character limit.  A nice side effect is that the
    initial source is gloriously difficult to peruse.

    Second, the rather ho-hum step has been taking of naming each variable
    with a one or two letter identifier to render it meaningless (and save
    space).  This tactic is rather effective in a complex program.

    Third, the board is represented not as an array of pieces but rather as
    an array of function pointers (with a separate array representing
    whether a piece is white or black).  This obfuscates the program's
    central data structure.  There is one function per type of piece; when
    called they return 1 if the current move is illegal for that piece and
    0 if it is legal.  The functions also as a side effect set a global
    indicating the type of the piece (though the type can also be determined
    by comparing the function pointer with the function itself).

    Fourth, there are no independent routines for generating potential
    moves.  Instead, the program generates its moves by brute force: for
    every piece it controls on the board, it attempts to move it to every
    square on the board.  Those moves that are legal it then explores to
    see their effects (using alpha-beta search).  This tactic somewhat
    obfuscates the algorithm used by the program.

    Finally, there are three key constants that occur throughout the
    program:  64, 8, and 3 (lg 8).  Rather than making these available at
    compile-time, which provides a hint as to what the program is up to,
    they are computed probabilistically at run-time.  An instance of the
    "Inspection Paradox" is used which happens to produce a value that on
    average is close to .64.  10000 instances of this value are computed,
    added up, and then divided by 100.  Sometimes the value produced will
    be 63 or 65 instead of 64 (but I've never observed any other values),
    so the result is then rounded to the nearest multiple of 4, and then
    the other constants are derived from it.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
