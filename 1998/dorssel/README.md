Obsolescent Feature:

    Frans van Dorsselaer
    Bakker Industrial Automation
    Kaiserstraat 35
    NL-2311 GP   Leiden
    The Netherlands


Judges' comments:

    To build:

	make dorssel

    To use:

	echo Simple as 123 | ./dorssel
	echo '.... --- .--  -.. --- . ...  .. -  -.. ---  - .... .- -'|./dorssel

    How does the program decide which way to convert?

    What obsolescent feature are we talking about?  (No, it's not a
    C language feature.)

    The author suggests that you try to answer the following questions:

	- Which character in the initializing string is totally irrelevant?
	- Which two relevant characters in the initializing string may be
	  exchanged without altering the behavior?
	- Which characters in the initializing string are somewhat irrelevant,
	  and to what values may they be changed without altering the behavior?
	- Which characters may be used to enlarge the initializing string by
	  one without altering the behavior ?

    Extra credit: Change the program so that it does not SHOUT IN ALL CAPS.

    You might also want to read the dorssel.hint2 file.


Selected author's notes:

    Usage
    =====

    This program converts ASCII to Morse code, and vice versa.

    The program reads in lines from standard input and writes its result to
    standard output.  The direction of conversion is determined on a per
    line basis.  Each line must consist of a maximum of 952 characters
    followed by a new line character, they must not contain any NUL
    characters.  Otherwise, some characters may be lost in the conversion.

    - Encoding to Morse code:
      The program knows the Morse codes for all Latin letters (a-z, case
      insensitive) and decimal digits (0-9).  Any other characters are
      replaced by an ASCII space ' '.  Morse code per converted character is
      written as a sequence of '.' and '-' characters, each sequence
      followed by a space.

    - Decoding from Morse code:
      Morse code should be typed as sequences of '.' and '-' characters,
      separated by a space.  Extra spaces will be echoed back (to separate
      words).  Unknown sequences will be converted to a '?' character.

    Notes
    =====

    The program assumes both source and execution character sets to be
    ASCII.  As far as I can tell, the program is conforming and does not
    invoke undefined behavior.

    Hints
    =====

    - Try

          ./dorssel < dorssel.c | ./dorssel

      to see what variables, numbers, and functions are used.  (Does a
      better job than most C beautifiers).

    - Filter your text twice (as in the previous sample) to obtain a version
      of your text that can be reversibly morsified, i.e.

          ./dorssel | ./dorssel | ./dorssel | ./dorssel

      is the same as

          ./dorssel | ./dorssel

    - The file "dorssel.hint2" contains all the information needed to
      understand this program.  For an obfuscated spoiler, try

          ./dorssel < dorssel.hint2
