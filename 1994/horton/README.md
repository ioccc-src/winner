Best Utility:

	Mark Horton
	AT&T Bell Labs
	Rm 1H-117
	6200 E Broad St.
	Columbus OH 43213
	USA


Judges' comments:

    To use:
	make horton
	./horton A B C D

	A, B, C, D are numeric arguments (try 3 2 1 0).

    Try to figure out how this program prints, for a given slope, the
    right character.  And for extra credit, try to figure out which
    character is at the bottom on this hint file.  :-)

    This confuses cb greatly. See gtplot.c for an unobfuscated/enhanced 
    version.  To compile it:

	make horton.alt
	./horton.alt A B C D

	A, B, C, D are numeric arguments (try 3 2 1 0).
    

Selected notes from the author:

    Run it with any 4 numeric arguments, e.g. prog 3 2 1 0.  Play with the
    numbers to get a pleasing result, or use it for your high school algebra
    class.

    SPOILER:

    As should be obvious from 20 feet away, the program is a cubic plotter.
    It plots against certain artists, splattering their cubes with graphs
    of their cubic equations.  Those dastardly arguments are mere coefficients,
    cogs in the wheels of the grand plot to overthrow the cubics!

    Oh, by the way, it uses a self-contained graphtab and frame buffer.
    It's easily modified to graph *any* 96x160 bitmap on a dumb terminal.

    See the gtface program for another example.  Try:
    
	make gtface
	./gtface < gtface.data

    For more information, see
    Using GraphTab; USENIX ;login:
    Sept/Oct 1992; Pages 28-31

              MMMM,M,MM"MM,,,
           ,,MMMMMMMMM"""""""",
          ,MMMMM"""            ",
         ,MMM"                   "   
         MMM                      M  
         MM
         MM" "                     M 
          M " , ,,,,,     ,,,,,,,,,MM
          "MMMM"M,MMMMM MMMM M M"MMM,
         ,M"MMMM"MM"MMM""M""MMMM""M"M
          , MM M M,M M"  "M",, M "M "
          M ,M,"    ,M    "M, ,,,", M
           M , M"MMM",,M,M,,""" , ,
          ",," , " "MMMMMMMM "   , "
           ,M , ""M,MMMMMMMM,M " ,,
           ,MM, MMMMMMMMMMMMMM,", M,
            M,M,MM"M"M" """M"MM,M M
           ,MMMMMM M,MMMMM"M MM""M
          M MMMMMM,M M"M"" M MMMM", ,
           "M"MMMMMMMMMM"M ,MMMMM M  ,,
         "" MMMMMMM,M,MM,M,,,MMM"M    ,
       ," , "MMMMMMM"MM"M,,,,MMMMM ,   ,,
       M  ," MMMMMM"MM""M ,MMMMM,M,    M
      ,      MMMM,MMMM"M"M"M,MM,M,",    "

Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
