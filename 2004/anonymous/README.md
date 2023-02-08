Best use of "Precious" Lines:

    The author wishes to remain anonymous
    Singapore

    http://bicoherent.topcities.com/


Judges' Comments:

    To build:

	make anonymous

    Try:

	./anonymous "ash nazg durhbatuluhk, ash nazg gimbatul, \
            ash nazg thrakatuluhk, agh burzhumh-ishi krimpatul." >anonymous.pgm

	Then view the output using your favourite "pgm" viewer.  If you
	don't have a "pgm" viewer then we suggest the "netpbm" toolkit
	(http://netpbm.sourceforge.net/) to convert the image to a
	graphics format that you can view - most graphical Web browsers
	can display PNG or JPEG images.

    p.s. Frodo lives!


Selected Author's Comments:

    This program takes a single command line argument, transcribes the
    argument text into Tolkien's Elvish letters, and writes the
    transcription to standard output as a portable graymap (PGM) file.

    The specific transcription mode is the Black Speech Tengwar mode, as
    used in the inscription on the One Ring. The program handles the
    following diagraphs:

    	- "gh", "sh", "th": the corresponding tengwar are output for these
    	  specific sounds
    	- "mh" denotes the full tengwa for [m]; "m" by itself means a
    	  horizontal bar above the next letter
    	- "rh" denotes the [r\] tengwa
    	- "uh" denotes the tehta for long vowel [u:]
    	- "zh" selects the up-reaching tengwa for [z], while "z" selects the
    	  down-reaching one

    Punctuation marks other than commas and periods are ignored, as are
    whitespace characters. In addition, the argument text must be entirely
    in lower case.

    The following command thus writes a rendering of the Ring inscription to
    the file out.pgm:

    	./anonymous "ash nazg durhbatuluhk, ash nazg gimbatul, \
    	    ash nazg thrakatuluhk, agh burzhumh-ishi krimpatul." >anonymous.pgm

    The source code assumes the ASCII character set; also, due to space
    constraints, the program uses rather inefficient algorithms, so it may
    waste a lot of time and space even when rendering moderately long
    strings.

    The code contains a vector font which was derived by toying with Harri
    Pera:la:'s Tengwar Cursive font. Currently, only the glyphs used in the
    Ring inscription are included in the font.
