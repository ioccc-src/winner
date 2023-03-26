# Best Utility:

	Anthony C Howe
	Mortice Kern Systems Inc.	#CL-23
	35 King St. N			268 Phillip St.
	Waterloo, On			Waterloo, On		
	Canada, N2J 2W9			Canada, N2L 6G9

## To build:

        make all

## To run:

	./ant some_file

NOTE: the file must already exist and not specifying any arg will make the
program exit without doing anything.

## Try:

	cp README.md hill
	./ant hill

## Judges' comments:

The author was kind enough to supply a list of references below,
in case you are still confused after read the source!  :-)

BTW: you've most likely heard the joke that if you want a pseudo-random string
of characters you can put a user unfamiliar with vi(m) in a vi(m) session (in
insert mode) and ask them to exit. Well in this case you're likely to have this
problem if you ARE a vi(m) user! :-) ... especially if you don't read the
information below. This means if you're reading this in vi(m) you'll have to
exit this like in normal vi(m) and then exit `./ant` differently.

NOTE: to enter form feed you should be able to hit `ctrl-L`. This will allow you
to exit insert mode rather than ESC like in normal vi(m). See the author's
commands section for other commands.

## Author's comments:

Ant's Editor vIOCCC91

Text files consists of lines of printable text or tab characters.
A line can be of arbitrary length and is delimited by either a
newline or the end of file.  Carriage return is mapped to newline
on input and ignored on output.  Tab stops are every eight columns.
Non-printable characters may have unpredictable results depending
on the implementation of CURSES.

### COMMANDS:

    h j k l	    left, down, up, right cursor movement
    H J K L	    word left, page down, page up, word right
    [ ]		    beginning and end of line
    t b		    top and bottom of file
    i		    enter insert mode, formfeed to quit
    x		    delete character under the cursor
    W		    write buffer to file
    R		    refresh the screen
    Q		    quit
    
### EXIT STATUS:

    0		    success
    2		    missing edit filename


### ABOUT THIS ENTRY:

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

### REFERENCES:

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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
