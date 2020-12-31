Most Complete Program:

    Thomas P John
    Mishybi Plamoottil
    Parottukonam
    Nalanchira P.O, Trivandrum-695015
    India

    http://tomx.tripod.com/


Judges' Comments:

    To build:

	make tomx

    Try:

	rm -f ./tomx
	sh tomx.c              
	./tomx

    If sh is your shell:

	rm -f ./tomx
	chmod +x ./tomx.c
	./tomx.c 
	./tomx

    Also try:

	rm -f ./tomx
	make -f tomx.c
	./tomx

    Polyglots have come and gone, but this was the first one we'd seen
    where one language *used* another to perform its tasks.  An interesting
    approach.  Admittedly, it's not all that obfuscated - but there's more
    to it than you might think, since you have to make sure that your
    changes don't change the shell code or the makefile.


Selected Author's Comments:

    Summary
    -------
    This program works as a C source file, a Makefile and also as a
    Shell (/bin/sh) script. But unlike some other multi-language prog-
    rams, this one is NOT meant to print "Hello, world" in all 3 cases
    (At least in the true sense ;-)). The C, make and shell code build
    upon each other to create a C program (?) which when executed as a
    shell script will compile itself through the C compiler using a
    makefile! - Pretty useful, Eh?.

    Probably, this is the first entry ever to fully satisfy Rule #1
    ("Your entry must be a complete program") in the strictest sense;-)

    Top 5 reasons (IMHO) why this code is an entry for IOCCC
    --------------------------------------------------------
    1. A glance at the source itself will tell U that most of the
       Obfuscation is NOT in the C code per se, but in the comments
       to the C code. (But sadly, I could not find an "International
       Obfuscated C COMMENT contest". So I HAD to sent this entry
       here to the IOCCC itself).

    2. Of the 3 languages in the source, the least obfuscated is
       C (But again, there was NO obfuscated make/shscript contest)
       (Does this hint for a rule in IOCCC-2001 that the major
       obfuscation should be in C and not elsewhere???. Mmmmm...)

    3. Extending Argument #2... Obfuscation done in the C code
       (comments?) create obfuscated code for the other 2 languages.
       This opens new possibilities to be explored in depth in future
       IOCCCs

    4. LOOKS like a makefile, WORKS like a shell script and COMPILES
       like a C program

    5. Does something useful (See Notes #1, #2)

    Notes
    -----
    1. The program could have been something other than the simple
       "Hello, world" program that it is. It is possible to do
       #include "prog2.c" in the place of the main(), leaving the
       complexities of the C file elsewhere and making this source
       still acceptable to "make" and "sh". The following modif-
       ication to the last few lines will compile IOCCCs famous
       "mkentry.c"

        .PHONY: /* true clean */
        #undef   true
      	#include "mkentry.c"

       Ain't that useful?

    2. By extending this program's idea, It is possible to do some
       very interesting things like generating C code on execution
       by adding additional code in  make/sh (open up a loop????).
       This opens the possibilities of generating & compiling some
       [obfuscated?] C code.(Maybe should try this if this program
       fails at IOCCC 2000)

    3. Changing the "%:%.c" dependency to a "$(PROG):$(PROG).c" form
       can compile this program with some other make-s (I got it to
       work in Windows using nmake and Gnuwin32's sh ;-)

    4. Interesting things to do: try "$ ./tomx.c clean". This will
       do the same as "make clean" :-)). Also: "$ ./tomx.c all"

    5. Be careful about the Tabs in the source code. Removing them
       or converting Tabs to spaces can be disasterous

