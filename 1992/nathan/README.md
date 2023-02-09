Worst Abuse of the Rules:

	Nathan Sidwell
	Inmos UK
	1000 Aztec West
	Almondsbury
	Bristol
	UK BS12 4SQ


Judges' comments:

    The US International Traffic in Arms Regulations controls certain
    exportations going out of the United States.  The U.S.  Munitions
    List gives the specific categories of restricted exports.  Because
    this entry appears to fall under this restricted catagory, the
    judges may not be able to distribute winners outside of the USA.

    Nathan Sidwell has stated that he is willing to distribute the
    winning source.  To read HIS instructions of how to obtain his
    winning program:

	make nathan
	nathan

    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    =-=-= The text below assumes that you have the winning source =-=-=
    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    To use:
	make nathan

    Try:
	nathan obfuscate < nathan.c > foobarf.c
	nathan - obfuscate < foobarf.c > barfoof.c
	diff nathan.c barfoof.c

    WARNING:
	The judges' make no claim as to the strength or security
	of this program.  It is likely to be nil, or the next
	best thing to it.  Still, you might consider installing
	it in /usr/games/nathan.  :-)

    NOTE: 
	The 'winning' catagory is also open to question.  One could say
	that it is a 'file obfuscator'.  One could also say that it
	unintentionally adbused the intent of rule #7 (that programs
	should be freely redistributable).  We suspect that the author
	may not have intended to do this, but that is the way things go
	sometimes.

	BTW, 'abuse of the rules' entries do not violate the rules.
	Entries that violate the rules are disqualified.  Abuse of the
	rules entries are ones that tend to 'streach' the limits and
	take the contest into unexpected territory.


Personal note from chongo:

    I think this situation shows just how ridiculous US crypto
    regulations really are.  Certain US federal officials can get away
    with shipping arms to certain nations in apparent violation of US
    laws, but I personally can't re-distribute a program contest winner
    to the network!


Selected notes from the author:

    PROGRAM USE

    This program is a hello world text encrypter/decrypter. It uses an
    enigma (I think) style encryption algorithm, where the encryption
    key character is modified by a value, determined from the previous
    character.  Non-printable characters (those with ASCII values < ' '
    or > 0x7e) are passed unaltered, thus any kind of file may be
    successfully procesed, but if the original is printable, the
    processed file will be too. The input is read from stdin, and the
    output presented to stdout. The key, a text string, is presented as
    a command argument. This is optional, and if ommitted, the file is
    self-{de,en}crypted. To specify decryption, a "-" should be given
    before the key. (Actually encryption and dycryption proper inverse
    operations, so you can use decrypt to scramble and encrypt to
    descramble, if you're perverse.)

    PORTABILITY (A little knowledge is a dangerous thing)

    Its written in ANSI C, and doesn't even assume an ASCII character
    set, (it has an array of the characters to convert), so should be
    portable across many platforms. It passes gcc -ansi -pedantic -O
    -Wall with no warnings (You may get assignment in conditional
    warnings on other platforms though).  Because I've heard that
    conditional jumps slow down fast processors, I've eliminated all
    the ifs from the code, indeed, as its only one statement, it should
    compile to one instruction an a suitably designed CISC machine. To
    speed compilation, there is only one statement in the loop, so that
    another scoping level does not need to be opened.

    Being an encrypter/decrypter, you probably want the source code to
    be obfuscated, to hide the algorithm.

    OBFUSCATION

    Inspite of the fact that it looks like a nice friendly hello world
    program, it isn't (as documented above). (Short lines have been padded,
    as you'll find if you look at an encrypted copy of the source.)

    I've also named some of the macros from commonly used functions,
    just to keep things muddy. Of course, all the variables are
    misnamed. The program is kept simply (one for statement), by
    serious overuse of , and ? :. These are really confusing when used
    together, nested or put in argument lists (is that a comma
    operator, or argument separator?)

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
