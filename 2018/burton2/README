tac comes with a small suite of support programs to test and validate against.
Untar tests and variations in the same dir as the sources,
or change runtest and unob.sh to look elsewhere for the keyword and test files.

keywords is a critical file, created from ioccc.kw.freq by mkkeywords.
Only ioccc.kw.freq produces results compatible with iocccsize.c;
however, any of the variations can be used instead:

	mkkeywords c11 > keywords

unob.sh uses the same input file as mkkeywords to control spaces after keywords.
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
keywords		the file #included in prog.c, output of mkkeywords
mkkeywords		reads one of the files from variations, produces string for prog.c
ioccc.kw.freq		keywords used by iocccsize, sorted by frequency in 201x ioccc winners
unob.sh			a more robust unobfuscation script; requires variations/c11 in cur dir
tokenfix		patches up prog -t output for ::, >>>, ...
src.doc.rot13		the answers, or at least significant help
tac.c			more clearly written code, offered as a replacement of iocccsize.c
patch			fixes single quotes in iocccsize.c, adds #ifndef, removes "I"
fixed_iocccsize.c	iocccsize with patch applied, and nop -c argument added

tests/*
runtest			script to run the tests; ./runtest | diff results -
results			results without -k
results.k		results with -k; opt=kcrs ./runtest | diff results.k -
test*.c			various test cases looking for compatability
iocccbug*.c		various test cases demonstrating problems with iocccsize
spotcheck		script to test a lot of files vs iocccsize
spotdiff		summarize the results of spotcheck, showing only differences
discrepancies		text file of the differences found using all the ioccc winning entries

to test prog:

	runtest | diff - results
	opt=kcrs runtest | diff - results.k
	find ~/src/obc -type f -a -name "*.c" | xargs spotcheck prog
		[ | spotdiff | diff -bw - discrepancies ]

to test tac:

	prog=tac runtest | diff - results
	prog=tac opt=krs runtest | diff - results.k
	find ~/src/obc -type f -a -name "*.c" | xargs spotcheck tac

variations/*		as described in the remarks, and in each file below
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
