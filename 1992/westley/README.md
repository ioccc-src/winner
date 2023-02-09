Best Small Program:

	Brian Westley (aka Merlyn LeRoy)
	Digi International
	1026 Blair Ave.
	St. Paul, MN  55104
	USA


Judges' comments:

    If lost:
	make whereami
    
    Then run:
	whereami lat long
    
    Where lat and long correspond to your latitude and longitude.

    To find the approximate place where this entry was judged, type:

	whereami 37 -122	(- means west of meridian)
    

Selected notes from the author:

    Run the program with your latitude & longitude as integer
    arguments; it will produce a map made up of '!' with the given
    position marked with either a '"' (if the position is over a '!')
    or a '#' (if the position is over a space).  Southern latitudes
    and western longitudes are entered as negative numbers.  For
    example, to find San Francisco, run with "prog 38 -122".  The
    resolution of the map is five degrees horizontally, ten degrees
    vertically.  The map is a Mercator projection with equal spacing
    of the latitudes, so the areas near the poles are very distorted.
    Latitudes near the poles and Antarctica are not shown.

    The program requires the ASCII character set, putchar(), atoi(),
    and a display that auto-wraps at 80 characters(!).  If your display
    does not work this way, you will have to massage the output;
    for example, you can pipe it to a file and edit it with vi,
    which will do autowrap for you.

    Lint complains that main() returns a random value and I'm not
    checking the value that putchar() returns.  Scandalous!

    If you run it with fewer than 2 arguments, it will likely
    give you an exception, as it will access arguments that
    don't exist and characters before a string constant.

    How it works:

    The map is printed as one long string of ' ' and '!' characters,
    with the autowrap used to stack up slices of 80.  The map data is
    a string; the first character is how many '!'s are printed
    ('A'=1, 'B'=2, etc), the second character is how many ' 's, the
    third is how many '!'s, etc.  ASCII characters less than 'A'
    print no characters but still change the polarity, so any map
    of ' 's and '!'s is possible.  This is done in the putchar()
    argument as "33^l&1", where l is the character position+4; if
    l is odd, ' ' is printed, if l is even, '!' is printed.

    The position of latitude & longitude is changed into a single
    character position within the one long string via the first
    expression "d = latitude/10*80 - longitude/5 - offset"  The
    latitude is divided by ten because the vertical resolution is
    ten degrees, then multiplied by 80 because of the 80 character
    wrap (i.e. each ten degrees moves the position up or down one
    entire row).  The longitude is divided by five and added, because
    five degrees of change moves the location one character.  The signs
    are opposite because latitude is decreasing and longitude is
    increasing as you go from upper left to lower right.  The offset
    is where the origin (latitude=0, longitude=0) is found.

    The position counting down to zero changes the putchar() from
    printing ('!' or ' ') to printing ('"' or '#').

    The "H E L L O,   W O R L D!" string inside the data string
    prints the line of blanks past Tierra del Fuego and the last
    blank line.  It's just for show, really.

    Since the resolution is coarse, a few costal cities are shown to
    be just off the map; this is an unavoidable artifact.  The map
    is reasonably accurate.

    Here are some cities you might like to try:

         New York  41  -74       Los Angeles  34 -118
           London  52    0             Paris  45    2
           Moscow  56   38           Beijing  40  116
        New Delhi  29   77    Rio de Janeiro -23  -43
           Sydney -34  151             Tokyo  36  140

For a domestic (USA) version with higher resolution, try:
---cut---
main(l,a,n,d)char**a;{for(d=atoi(a[1])/2*80-atoi(a[2])-2043;
n="bnaBCOCXdBBHGYdAP[A M E R I C A].AqandkmavX|ELC}BOCd"
[l++-3];)for(;n-->64;)putchar(!d+++33^l&1);}
---cut---
The code will test the 80-column wrap and document itself if it is
joined together as one 160-character line and listed.  You should see:

main(l,a,n,d)...
[A M E R I C A]...

...going down the left edge if your terminal autowraps at 80 characters.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
