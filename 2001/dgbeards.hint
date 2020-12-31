Best AI:

    Doug Beardsley
    Southern Adventist University
    359 Davis Rd. NW
    Cleveland, TN 37312
    USA


Judge's Remarks:

    To build:

	make dgbeards

    Try:

	./dgbeards

    This is probably the worst AI we've ever seen.  So, then, why did
    the entry win?  Because it's *trying* to lose.

    This is also one of the first chess games we've seen.

    Of particular interest is the author's decision that the program should
    crash if it loses.  I've played chess with a lot of people like that, and
    I appreciate the realism.


Selected Author's Comments:

    FAQ:

    Q: What does this program do?

    A: It lets the user play two player or single player games of suicide
    chess.  Suicide Chess (also known as Losing Chess) is a variant of normal
    chess.  It is played on the same board and uses the same pieces.  Here is
    a list of the differences:

    1. The object of the game is to get to a position where you have no legal
    moves.  This is usually accomplished by losing all of your pieces.
    Sometimes, the game can end when you still have some pawns on the board,
    but they are blocked and cannot move.  The general rule is if a player
    has no legal moves, the game is over.  The winner is the player with fewer
    pieces on the board.  This is almost always the same player that had no
    moves, but not always.

    2. In suicide chess, piece captures are compulsory.  If a player can
    capture an opponent's piece, he is required to do so.  If he can capture
    more than one of the opponent's pieces or can capture one piece with more
    than one of his own pieces, he can choose which capture to play.

    3. The king is not significant.  There is no concept of check and the king
    can be captured.

    4. Because of rule 3, pawns are allowed to promote to a king.

    5. Castling is not allowed.

    Q: How do you use this program?

    A: The program is fairly straightforward.  When you start the program,
    it displays the opening position for a game of suicide chess and waits
    for user input.  Commands are as follows:

    quit - Quits the program
    g - Causes the computer to make a move

    Moves are represented by the long algebraic notation for the move.  For
    those not familiar with long algebraic notation, a move consists of a
    square to move from followed by a square to move to.  Squares are denoted
    by a letter and a number.  The letter specifies the column or file of the
    square and the number specifies the row rank.  Files are named from left
    to right by the letters a-h.  Rows are numbered from bottom to top with
    the numbers 1-8.  A sample move from the opening position is e2e3.  This
    means to move a piece from square e2 to e3.  From the opening position,
    this corresponds to moving the king pawn forward one square.  This is
    generally to be considered one of the best opening moves in suicide
    chess.  All moves, captures and otherwise, are represented with this
    notation.  A special case is pawn promotion moves.  They use the same
    notation followed by an '=' and a letter representing the piece to
    promote to.  The letters are R,N,B,Q,K representing rook, knight, bishop,
    queen, and king respectively.  The letters must be upper case.

    You can also specify a command line argument of a single digit to change
    the search depth of the program.  If no argument is specified, it
    defaults to a depth of 3.

    Q: Are there any limitations in your program?

    A: Yes.  The first of the limitations is that you can only play legal
    moves according to the rules of suicide chess.  En passant captures are
    not recognized.  They are rarely encountered in suicide chess and when
    they do happen, they usually do not change the outcome of the game.  As
    mentioned above, castling is not allowed either.

    It also does not detect the end of the game.  It can see sure wins or
    losses several moves ahead, but does not announce the end of a game or
    the winner.  Given the existing code it is easy to do this, but it was
    deemed unnecessary fluff.

    Q: What is the playing strength of this program?

    A: Playing strength is a relative term.  Relative to other computer
    programs that play suicide chess, it is about the bottom.  There is one
    freeware program in existence called kenny that this program can beat,
    but that is about it.

    Suicide chess is a very tactical game.  Most humans who do not have any
    experience in suicide chess will lose to this program.  The Free Internet
    Chess Server (http://www.freechess.org) is a free online chess server
    that supports suicide chess.  This server keeps track of ratings.  The
    human ratings for suicide chess range from 1000 to about 2400.  This
    program would probably be rated somewhere around 1700-1900.  It is better
    than most players, but will get destroyed by experienced human opponents.

    This program searches to a fixed depth of 3 ply.  Because it does not
    search very deep, it performs very poorly in quiet strategic positions.
    In such positions, it will often just shuffle pieces around aimlessly
    until a tactical exchange presents itself.

    A small amount of randomness has been added to make the program a more
    interesting opponent.  The to avoid a call to srand(), rand() and the
    extra code for the required include files, the time() function is used as
    the source of random data.  It is a slow function, and since it is
    executed inside the search loop, there is a significant performance
    decrease.  To make it faster, replace the time() call with rand() and add
    the line srand(time(0)); to the beginning of main().  I used the more
    inefficient time() function to illustrate a different (and somewhat
    obfuscated?) way of generating random numbers.

    Q: Why is this program obfuscated?

    A: Here are several reasons:

    First, without preprocessing, the code is not easy to read.  The
    preprocessor is used to compress the code and obfuscate it.  The main
    obstacle to entering this program is the source code size limit.  This is
    the reason that the preprocessor was used so liberally.  It is one of the
    best ways to compress C source code.

    Second, when possible, variables in the program were made global.  Their
    names are not descriptive and they are used for a variety of purposes
    throughout the program.  Because of this, it is difficult to determine
    exactly what the code does even after preprocessing and beautifying the
    code.

    Third, all function names are a single character and are obviously not
    descriptive of they're actual purpose.  Again this serves the dual
    purpose of compression and obfuscation.

    Fourth, most string variables have been encoded.  This encoding serves
    to obfuscate the program as well as reduce the number of countable
    characters and get the program under the size limit of this year's IOCCC.
    There are some places where other simple encoding methods are used to
    hide the real purpose of strings.  These layers of obscurity cannot be
    penetrated by just preprocessing and beautifying the program.

    Fifth, various small obfuscations have been used in places all over the
    program.  Short circuit evaluation is used as a substitute for if()
    statements in some places.  The ternary operator is used.  In the
    author's opinion, use of the ternary operator is almost always a  strong
    argument for employee turnover.

    Last, if you have succeeded in wading through the previous layers of
    obfuscation, you are confronted by the fact that the game that it
    implements is an obscure game.  Casual inspection of the program might
    lead one to believe that it is an implementation of classic chess, but
    this is not so.

    Q: What about the compiler warnings?

    A: When compiled with gcc -Wall, the compiler generated the following
    warnings:

    suggest parentheses around + or - in operand of &
    array subscript has type 'char'
    return type defaults to 'int'
    control reaches end of non-void function
    value computed is not used

    The "value computed is not used" warning happens because I use the &&
    operator and take advantage of short circuit evaluation instead of using
    an if() statement.

    The "suggest parentheses..." warnings are given because of expressions
    that depend on operator precedence details in the C language.
    Eliminating these warnings would reduce obfuscation.

    The other warnings are there because it would require more code to
    eliminate them and that can't be done given the size limit.

    Q: Why does this program crash when it loses?

    A: What better way to admit defeat?  The author thought this was
    appropriate sportsmanship for a program of this genre and can think of
    no worse job than trying to find an elusive bug in an intentionally
    obfuscated program.

    [judge's note:  This was followed by a description of the bug, and
    the comment:]

    (Note, if this program wins, the author thinks it would be good to leave
    this information out of the remarks and encourage others to try and
    figure it out for themselves)

    [should you be too lazy to figure it out yourself, here's the author's
    fix.  I would have rot13'd it, but the punctuation would have survived.]

begin 644 fix.txt
M5&AI<R!B=6<@8V%N(&)E(&9I>&5D(&EN(&$@;G5M8F5R(&]F('=A>7,L(&)U
M="!T:&5R90II<R!A('=A>2!T:&%T(&%D9',@;VYL>2!O;F4@8GET92!T;R!T
M:&4@<V]U<F-E(&-O9&4N("!);B!T:&4@<W1A=&5M96YT"G,]*&4]+58H;BTQ
M+&\I*3YS/UD]1RQE.G,[(&-H86YG92!T:&4@/B!T;R!A(#X](&%N9"!T:&4@
38G5G('=I;&P@8F4@9V]N92X*"FYG
`
end
