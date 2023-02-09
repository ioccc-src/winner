Best one liner:

	David Van Brackle
	Department of Computer Science
	University of Central Florida
	Orlando, Florida 
	32816
	USA 

Judges notes:

	This program computes all proper subsets of the set of
	arguments passed to it.  Each subset is printed with one 
	element on each line, followed by a line of ten dashes.

	Try:

		vanb the rug gary lent	
		vanb unix is better than os/2

Selected notes from the author:

	The program has the following charming and possibly 
	non-portable features:

	    * It has no local or global variables, 
	      only the command-line parameters.

	    * It calls main recursively.

            * It alters the command-line parameters.

            * It uses the fact that if the high bit is set in a character
              variable, the value is negative.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
