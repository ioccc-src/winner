# %W% %G% %U%
#
# 1988 makefile
#
# Copyright (c) 1988, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL=/bin/sh
CFLAGS=-O
CC=cc
CPP=/lib/cpp
# you may need a version of cpp that is faster and/or allows more symbols
# than the standard cpp.  If so, adjust the BIG_CPP below.
#
# If you have the GNU cpp, you should use it below as it is MUCH faster
# than the standard cpp and does not have problems with memory usage.
# However you should note that the non-ANSI nature of defining symbols
# that start with '#' prevents GNU cpp from doing the initial pass.  
# Thus you should not use the GNU cpp for the ${CPP} symbol.
BIG_CPP=${CPP}

WINNERS=dale phillipps robison westley reddy isaak \
	litmaath spinellis zsmall

all: ${WINNERS}

dale: dale.c
	${CC} ${CFLAGS} $? -o $@
phillipps: phillipps.c
	${CC} ${CFLAGS} $? -o $@
robison: robison.c
	${CC} ${CFLAGS} $? -o $@
westley: westley.c
	${CC} ${CFLAGS} $? -o $@
reddy: reddy.c
	${CC} ${CFLAGS} $? -o $@
isaak: isaak.c
	${CC} ${CFLAGS} -DI=B -DO=- -Dy $? -o $@
litmaath: litmaath.c
	${CC} ${CFLAGS} $? -o $@
spinellis: spinellis.c spinellis.data
	@echo This program can not be portably compiled with a makefile
	@echo because it reads from /dev/tty.
	@echo Compile this program with: cc spinellis.c -o spinellis
	@echo and type the following text followed by an EOF '(^D)'.
	@cat spinellis.data
	@-if [ ! -f spinellis ]; then \
	    touch spinellis; \
	fi

# not an official entry
#
# The 'zsmall.c' program was obtained from 'applin.c' by reducing its recursion
# and running it thru the initial /lib/cpp.  That is, 'zsmall.c' is a small
# version of the 'z.c' file as produced by the 'applin' make rule below.
zsmall: zsmall.c
	@echo this reduced version of applin.c can take some time to compile...
	${CC} ${CFLAGS} zsmall.c -o $@

# This entry took 75 minutes to compile on a Amdahl 5980-300E
# (a 55658 Dhyrstone/sec/cpu machine) using the System V cpp.
# (The GNU cpp when defined as BIG_CPP took only 45 seconds)
# Your cpp may not be able to compile it due to a common bug
# that results in ${CPP} running out of space.  The routine
# 'zsmall' is a smaller version of the applin.c entry.
applin: applin.c
	${CPP} '-DM=#include "z.c"' '-DR=#include' '-DF=#if' \
	    '-DI=#ifdef' '-DL=#else' '-DE=#endif' '-DN=#ifndef' \
	    '-DD=#define' '-DU=#undef' applin.c z.c
	@echo this is going to take a very very long time to C-preprocess
	@echo perhaps you should do:  make zsmall   instead
	${BIG_CPP} z.c > large.c
	@echo now for the real compile...
	${CC} ${CFLAGS} large.c -o $@

clean:
	rm -f core *.o
clobber: clean
	rm -f ${WINNERS} applin
nuke: clobber
	rm -f large.c z.c
install: all
	cat ${WINNERS} > /dev/null
