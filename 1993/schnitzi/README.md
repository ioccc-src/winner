# Obfuscated Intelligence Award:

	Mark Schnitzius
	1700 Woodbury Rd. #1208
	Orlando, FL 32828
	USA

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to not
segfault when no file is specified or the file cannot be opened for reading. he
also made this use `fgets()` not `gets()` to make it safer. Thank you Cody for
your assistance!

## To run:

	    ./schnitzi file
	
where:
	    
	    file	a file containing some text

## Try:

	    ./schnitzi schnitzi.info
	    # ask some questions suggested by the author, noted below

We also suggest you ask the program:

	    Who is Mark Schnitzus?

Notice how it still manages to answer the question despite there being an
intentional spelling error there.

Try feeding the program source to the program and ask both:

	What is cat ?
	What is cat?


## Judges' comments:

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

We suggest you try using the body (minus the header and signature line) 
of a Usenet article.  You might want to try something from alt.flame.  :-)

NOTE: If you have a ' in the question this entry may fail.

NOTE: The author may also be contacted at: marks@aldrin.ksc.nasa.gov.

## Author's comments:

I wanted to write a program that would read in a text file in
natural language (such as English) and answer questions about that
text file.  I thought this might be a complicated task, and I was
right -- it took me over 800 bytes.  Of course, it doesn't always
work, but that's AI for you.

This program accepts the name of a text file as the first
parameter.  For example, to run it on the supplied data file called
'info' you would type `./schnitzi info`.  It echoes the file, then
gives you a prompt where you may type in questions about that text.
The more words you use which are actually present in the text file,
the better results you get.  You'll need to hit `ctrl-c` to break out
of the program.  Just hitting `return` at the prompt will reprint the
paragraph.

If you're curious as to how it works, I guess you could feed in the
source as the input file and ask "How does this work?" at the prompt,
but I'm not guaranteeing any results...

### Compilation notes:

-  The use of 'strcasecmp' may be non-standard.  'strcmp' can be substituted for
it, with a slight performance penalty.

-  This program depends on the first command-line parameter, typically called
argv[0], to hold the name of the executable.  It is my understanding that this
property of argv[0] is not guaranteed on some systems.

### Obfuscation:

-  It uses a hidden string to test for punctuation.

-  The layout, variable names, and expression format have been chosen in such a
way as to cause visual confusion.

-  It uses uses external 'system' calls to echo the text file and break up the
question into individual words with a recursive call.

-  It uses a clever hack to simulate artificial intelligence.

The text for the info file, by the way, consists largely of headlines
from the Weekly World News.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
