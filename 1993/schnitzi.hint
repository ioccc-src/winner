Obfuscated Intelligence Award:

	Mark Schnitzius
	1700 Woodbury Rd. #1208
	Orlando, FL 32828
	USA


Judges' comments:

    To run:
	make schnitzi
	./schnitzi file
    
    where:
	file	a file containing some text

    After this program prints the contents of 'file', ask it
    some questions related to the text.
    
    The author suggests the following questions when using schnitzi.info:

	Who is Mark Schnitzius?
	What exactly does this program do?
	What language is it written in?
	Has the Loch Ness monster really been captured?
	Who was Hitler?
	Were the NASA moon landings faked?
	Is it true that Elvis is alive?
	Do colorless green ideas sleep furiously?

    NOTE: The author may also be contacted at: marks@aldrin.ksc.nasa.gov

    We suggest you try using the body (minus the header and signature line) 
    of a Usenet article.  You might want to try something from alt.flame.  :-)


Selected notes from the author:

    I wanted to write a program that would read in a text file in
    natural language (such as English) and answer questions about that
    text file.  I thought this might be a complicated task, and I was
    right -- it took me over 800 bytes.  Of course, it doesn't always
    work, but that's AI for you.

    This program accepts the name of a text file as the first
    parameter.  For example, to run it on the supplied data file called
    'info' you would type 'schnitzi info'.  It echoes the file, then
    gives you a prompt where you may type in questions about that text.
    The more words you use which are actually present in the text file,
    the better results you get.  You'll need to hit <ctrl-c> to break out
    of the program.  Just hitting <return> at the prompt will reprint the
    paragraph.

    If you're curious as to how it works, I guess you could feed in the
    source as the input file and ask "How does this work?" at the prompt,
    but I'm not guaranteeing any results...

    Compilation notes:

    o  The use of 'strcasecmp' may be non-standard.  'strcmp'
       can be substituted for it, with a slight performance penalty.

    o  This program depends on the first command-line parameter, typically
       called argv[0], to hold the name of the executable.  It is my under-
       standing that this property of argv[0] is not guaranteed on some
       systems.

    This program is obfuscated in the following ways:

    o  It uses a hidden string to test for punctuation;

    o  The layout, variable names, and expression format
       have been chosen in such a way as to cause visual confusion;

    o  It uses uses external 'system' calls to echo the text
       file and break up the question into individual words with a
       recursive call;

    o  It uses a clever hack to simulate artificial intelligence.

    The text for the info file, by the way, consists largely of headlines
    from the Weekly World News.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
