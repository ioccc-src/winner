Most Irregular Expression:

	David Van Brackle
	ISX Corporation
	1165 Northchase Parkway, Suite 120
	Marietta, GA  30067
	USA


Judges' comments:

    To run:
	make vanb
	./vanb 'exp'
    
    where:
	'exp'	an octal expression
    
    The octal expression may contain:

	unary operators:	+, -
	binary operators	+, -, *, /, %
	hex numbers:		x or X follow by hex digits
	decimal numbers:	d or D follow by decimal digits
	octal numbers:		octal digits
	grouping:		()
    
    No spaces are allowed in the expression.  To avoid shell expansion,
    one should surround the expression in single quotes.

    It is a good thing that this program consists of only one
    expression, otherwise it might become hard to understand.  :-)


Selected notes from the author:

    The program does no error checking - erroneous expressions will
    produce spurious results. Note that unary '-' is an operator. Thus,
    decimal -46 would be entered as -d46 and not d-46.

    What Makes This Program Special:

    0) Of course, the fact that the program takes input and produces output
       in octal, rather than a more useful system like decimal, makes
       it "special".

    1) The entire program consists of a single expression, returned from main.

    2) There are no global or local variables other than the parameters
       to main

    3) All of the constants in the program are expressed in octal - including
       the printf string.

    4) The variables are given names which cause visual confusion with the
       octal constants.

    5) The program is formatted like a roman numeral 8. The significance of
       8 is obvious. I chose roman numerals because it is a numbering
       system even more arcane than octal. It's not very 'deceptive',
       but it's difficult to deceptively format a program which has no
       explicit control structures (other than ?:'s).

    6) Many simple tasks are done many times. I tried to do these differently
       each time, to make the program harder to understand.

    How It Works:

    It's a recursive descent parser, calling main
    for all of its recursion. O2 is a state variable, telling main
    what grammar non-terminal to parse. **O7 is the next character.
    O3 is an intermediate result. Whenever you see a construct like:

      !(expression with O2)?

    it's decrementing & testing O2 to see what state it's in. Comparisons
    involving **O7 and octal constants are looking for certain characters.

    Here's the grammar ('e' denotes the empty string) :

    <E>  ::=  <T><E'>
    <E'> ::=  +<T><E'> | -<T><E'> | e
    <T>  ::=  <F><T'>
    <T'> ::=  *<F><T'> | /<F><T'> | %<F><T'> | e
    <F>  ::=  +<F> | -<F> | (<E><C> | d<D> | D<D> |  x<X> | X<X> | <O>
    <C>  ::=  )
    <D>  ::=  [0-9]<D> | e
    <X>  ::=  [0-9]<X> | [A-F]<X> | [a-f]<X> | e
    <O>  ::=  [0-7]<O> | e

    Here's how the grammar nonterminals map to octal state numbers:

    <E>  is  012
    <E'> is  011
    <T>  is  010
    <T'> is   07
    <F>  is   06
    <C>  is  013
    <D>  is   04
    <X>  is   05
    <O>  is   03

    Here's a version of the program before it got formatted into the VIII,
    augmented with comments showing where each state begins. N1 and N2 are
    notes:

    #define O5 main
    O5(O2,O7,O3)char**O7;
    {
             return
    /* N1 */ !(O2+=~01+01) ? 
	          00:
    /* N2 */ !(O2-=02>01) ? 
	          printf("\045\157\012",O5(012,O7+01,00)):
    /* O  */ !(O2-=02>>01) ? 
                  (**O7<=067 && **O7>057 ? O5(03,O7,*(*O7)++-060+010*O3):O3):
    /* D  */ !(O2-=-O3-~O3) ? 
                  (072>**O7 && 060<=**O7 ? O5(04,O7,012*O3-060+*(*O7)++):O3):
    /* X  */ !(O2-=!O3+!!O3) ? 
                  (**O7>057 && **O7<=071 ? O5(05,O7,*(*O7)+++O3*020-060):
                  **O7<=0106 && 0101<=**O7 ? O5(05,O7,020*O3+*(*O7)++-067):
                  0140<**O7 && **O7<0147 ? O5(05,O7,-0127+*(*O7)+++020*O3):O3):
    /* F  */ !(O2-=02-01) ? 
                  (**O7==050 ? 050**++*O7,O5(013,O7,O5(012,O7,00)):
                  **O7<056 && 054<**O7 ? 055**++*O7,-O5(06,O7,00):
                  054>**O7 && 052<**O7 ? 050**(*O7)++,O5(06,O7,00):
                  !(**O7^0170)||!(0130^**O7) ? *++*O7,O5(05,O7,00):
                  **O7==0144||**O7==0104 ? ++*O7,O5(04,O7,00):O5(03,O7,00)):
    /* T' */ !--O2 ? 
	          (**O7==052 ? O5(07,O7,O3*(*++*O7,O5(06,O7,00))):
                  !(045-**O7) ? O5(07,O7,O3%(03+(*O7)++,O5(06,O7,00))):
                  !(**O7^057) ? O5(07,O7,O3/(03-*++*O7,O5(06,O7,00))):O3):
    /* T  */ !(O2+=01-02) ? 
	          O5(07,O7,O5(06,O7,00)):
    /* E' */ !(O2+=-02/02) ? 
	          (!(**O7-053)?O5(011,O7,O3+(++*O7,O5(010,O7,00))):
                  !(055^**O7) ? O5(011,O7,O3-(03+*(*O7)++,O5(010,O7,00))):O3):
    /* E  */ !(O2-=0563&0215) ? 
	          O5(011,O7,O5(010,O7,00)):
    /* C  */ (++*O7,O3);
    }

    Note N1: It should never enter this state, unless the user invokes the
	     program with no parameters, in which case it just returns 0.

    Note N2: Since the program is properly invoked with 1 parameter, this is
	     the first state it will go into. This state just invokes
	     printf, and sends the parser to state 012 (which is <E>).

    The E and T states work like this:

    int e(){ return eprime( t() ); }

    The E' and T' states work like this:

    int eprime( int intermediate )
    {
	if( ch == '+' )
	{
	    ch = nextchar();
	    return eprime( intermediate + t() );
	}
	else return intermediate;
    }

    The D, X and O states work like this (they assume that they're initially
    called with 0):

    int octal( int intermediate )
    {
	if( ch>='0' && ch<='7' )
	{
	    intermediate = intermediate * 8 + ch - '0';
	    ch = nextchar();
	    return octal( intermediate );
	}
	else return intermediate;
    }

    F and C work similarly.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
