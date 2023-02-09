Best Calculated Risk:

    Brent Burley
    500 S. Buena Vista St.
    Burbank, CA 91521
    USA


Judges' Comments:

    To build:

	make burley

    Try:

    	./burley

    This is a draw poker program.  You start with $100.  Input alternates
    between your bet and which cards to keep.  Example:

	5		<== you enter a bet of $5 (defaults to $1)
	J Q J 9 5	<== your hand is Jack of Clubs, Queen of Hearts,
	C H D S C	    Jack of Diamonds, 9 of Spades, 5 of Clubs
	123		<== you enter which cards you want to keep
			    (enter 0 to 5 digits between 1 and 5)
	J Q J J Q	<== your new hand is Jack of Clubs, Queen of Hearts,
	C H D S C	    Jack of Diamonds, Jack of Spaces, Queen of clubs
	$145 (45)	<== Your new balance is now $145.  You had a Full House
	    		    so your payoff is 9 times your bet == 45

    The payout is according to "Vegas rules":

	Straight Flush     50 times your bet
	Four of a Kind     25 times your bet
	Full House          9 times your bet
	Flush               6 times your bet
	Straight            4 times your bet
	3 of a Kind         3 times your bet
	2 Pair              2 times your bet
	Jacks or Better     1 times your bet

    The program allows you to go into debt.  However I'm sure you would
    never control-C kill the program just because you got behind, right?
    On the other hand the program never willingly exits, so you have
    to leave even when you are ahead.  :-)

    Can you figure out a winning betting "strategy"?  Then can you modify
    the program so this "strategy" no longer works?

    Notice the clever use of setjmp() and longjmp() calls.  Can you keep
    track of what state is being saved and restored?


Selected Author's Comments:

     This program plays draw poker.  What is unusual about it is that it
     is written as a single statement -- count the semicolons!  (OK, there
     are really three statements if you count the variable declarations.)  To
     keep things simple, I have avoided the C preprocessor and tricky
     statements such as "if", "for", "do", "while", "switch", and "goto".
