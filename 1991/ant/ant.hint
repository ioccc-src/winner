Best Utility:

	Anthony C Howe
	Mortice Kern Systems Inc.	#CL-23
	35 King St. N			268 Phillip St.
	Waterloo, On			Waterloo, On		
	Canada, N2J 2W9			Canada, N2L 6G9


Judges' comments:

    Make and run with a filename (writable or to be created) as an argument.
    For example, try:

	make ant
	cp ant.hint hill
	ant hill

    Note that some old BSD systems may have trouble compiling this entry.
    They may complain about 'idlok' being undefined.  You can fix this
    by changing line 26 from:

	2;initscr();d=LINES;raw();noecho();idlok(stdscr,1);if(0<(i= ...
    to:
	2;initscr();d=LINES;raw();noecho();if(0<(i= ...
     
    ***or*** update to a modern version of Un*x.  :-)  If you have source,
    you can use this entry to help in your upgrade.

    You may need to change the makefile depending on what type of system
    you are running.  See the notes in ansi.mk or common.mk.

    The author was kind enough to supply a list of references below,
    in case you are still confused after read the source!  :-)


Selected notes from the author:

    Ant's Editor vIOCCC91

    Text files consists of lines of printable text or tab characters.  
    A line can be of arbitrary length and is delimited by either a 
    newline or the end of file.  Carriage return is mapped to newline 
    on input and ignored on output.  Tab stops are every eight columns.
    Non-printable characters may have unpredictable results depending
    on the implementation of CURSES.
    
    COMMANDS
    h j k l		left, down, up, right cursor movement
    H J K L		word left, page down, page up, word right
    [ ]		beginning and end of line
    t b		top and bottom of file
    i		enter insert mode, formfeed to quit
    x		delete character under the cursor
    W		write buffer to file
    R		refresh the screen
    Q		quit
    
    EXIT STATUS
    0	success
    2	missing edit filename
    
    The BUF size should be set at compile time to 32767.  This value
    was used because the Sozobon C compiler for the Atari ST has 16 
    bit ints and a limit on the size of arrays & structures of 32k.  
    Also the WatCom C compiler for the PC also has 16 bits ints.  On 
    machines that have 32 bit ints (most unix boxes), a larger value 
    for BUF could be used.
    
    It is recommend that compact memory model be used on PC class
    machines.  Small memory model may work too provided BUF is not
    too large.
    
    The character constants '\b', '\f', '\n', '\r', '\t' are used 
    in order to provide more portable code, since the compiler should
    handle the translation of them into the native character set.
    Note that '\f' (formfeed) was used to exit insert mode because
    K&R C had no escape constant for the escape-key.
    
    My goals for this project were to learn and experiment with the 
    Buffer Gap Scheme [Fin80][net90], write a useful and *portable* 
    programme, and meet the requirements of the IOCCC.  I initially 
    planned to have a mini CURSES built-in like the IOCCC Tetris entry 
    from a previous year, however this was not as portable as using a
    CURSES library with TERMINFO/TERMCAP support.  

    I plan to post followups such as unobfuscated versions and bugs
    fixes to comp.editors.  Reposts of the editor.101, gap.doc, and
    editor.102 can be found in the same group every so often.

    This entry will display a file with long lines, but has trouble
    scrolling the screen with long lines.  Paging up and down should
    work correctly, however.

    REFERENCES
    [Fin80]	Craig A. Finseth, "Theory and Practice of Text Editors or 
		A Cookbook For An EMACS", TM-165, MIT Lab. for Computer 
		Science
    
    [KeP81]	Kernighan & Plauger, "Software Tools in Pascal", 
		Addison-Wesley, 81, chapter 6
    
    [Mil86]	Eugene W. Myers & Webb Miller, "Row-replacement Algorithms
		for Screen Editors", TR 86-19, Dept. of Computer Science, 
		U. of Arizona
    
    [MyM86]	Eugene W. Myers & Webb Miller, "A simple row-replacement 
		method", TR 86-28, Dept. of Computer Science, U. of Arizona
    
    [Mil87]	Webb Miller, "A Software Tools Sampler", Prentice Hall, 87
		ISBN 0-13-822305-X, chapter 5
    
    [net90]	"Editor 101/102" articles from comp.editors

Copyright (c) 1991, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
