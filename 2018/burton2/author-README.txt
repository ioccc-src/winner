tac comes with a small suite of support programs to test and validate against.
Untar tests and variations in the same dir as the sources,
or change runtest.sh and unob.sh to look elsewhere for the keyword and test files.

keywords is a critical file, created from ioccc.kw.freq by mkkeywords.sh.
Only ioccc.kw.freq produces results compatible with iocccsize.c;
however, any of the variations can be used instead:

	mkkeywords.sh c11 > keywords

unob.sh uses the same input file as mkkeywords.sh to control spaces after keywords.
The script allows an environment variable, KW, to override this.
Use it simply:

	unob.sh prog.c | less
	unob.sh -p prog.c | less
	KW=c11 unob.sh prog.c | less

To handle obscure command line defines, use the environment variable DEF:

	DEF="-D'g(o)'='goto o;'" KW=c11 unob.sh -p prog.c | less

It does an amazingly good job for such a simple script.

Manifest

prog.c                  the reason for this README
keywords		the file #included in prog.c, output of mkkeywords.sh
mkkeywords.sh		reads one of the files from variations, produces string for prog.c
ioccc.kw.freq		keywords used by iocccsize, sorted by frequency in 201x ioccc winners
unob.sh			a more robust unobfuscation script; requires variations/c11 in cur dir
tokenfix.sh		patches up prog -t output for ::, >>>, ...
src.doc.txt		the answers, or at least significant help
tac.c			more clearly written code, offered as a replacement of iocccsize.c
patch			fixes single quotes in iocccsize.c, adds #ifndef, removes "I"
fixed_iocccsize.c	iocccsize with patch applied, and nop -c argument added

tests/*			moved to entry directory by judges
runtest.sh		script to run the tests; ./runtest.sh | diff results -
results			results without -k
results.k		results with -k; opt=kcrs ./runtest.sh | diff results.k -
test*.c			various test cases looking for compatibility
iocccbug*.c		various test cases demonstrating problems with iocccsize
spotcheck.sh		script to test a lot of files vs iocccsize
spotdiff.sh		summarize the results of spotcheck.sh, showing only differences
discrepancies.md	markdown file of the differences found using all the ioccc winning entries

to test prog:

	./runtest.sh | diff - results
	opt=kcrs ./runtest.sh | diff - results.k
	find ~/src/obc -type f -a -name "*.c" | xargs spotcheck.sh ./prog
		[ | ./spotdiff.sh | diff -bw - discrepancies ]

to test tac:

	prog=tac ./runtest.sh | diff - results
	prog=tac opt=krs ./runtest.sh | diff - results.k
	find ~/src/obc -type f -a -name "*.c" | xargs ./spotcheck.sh tac

variations/*		as described in the remarks, and in each file below, also moved to entry directory by judges
ansi	
c++11
c++14
c++98
c11
c99
java8
kandr
kandr2
v7unix
