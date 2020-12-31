#!/bin/make
# 2000 makefile
#
# Copyright (C) Simon Cooper, Landon Curt Noll, Peter Seebach
# and Leonid A. Broukhis, 2000.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from the contest judges.

SHELL= /bin/sh
CAT= cat
RM= rm
SED= sed
TRUE= true

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O.
# A few compilers have broken optimizers and thus you may
# not want anything.
#
#OPT=
#OPT= -O
OPT= -O2

# flags for ANSI compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#	others such as gcc may want -ansi, others (Compaq Tru64 Unix)
#       want -std1, and others may want nothing at all.
#       Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#	incorrectly.  You might want to turn on -O to see if your
#	compiler can handle them.
#
#
#CFLAGS= -Xa ${OPT}
#CFLAGS= -std1 $(OPT)
CFLAGS= -ansi ${OPT}

NO_ANSI_CFLAGS=
#NO_ANSI_CFLAGS=

# NOTE: On some systems, the library path does not include the location
#	of the X11 libraries.  You might need to use a -L/path/to/X11/lib/dir
#	in order to compile with these libs.
#
X11CCFLAGS= -I/usr/X11R6/include -I/usr/X11R6/include/X11 -I/usr/include/X11
#X11CCFLAGS=
X11LDFLAGS= -L/usr/X11R6/lib
#X11LDFLAGS=

# Perl
#
PERL= perl
#PERL= perl5

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
# Some entries seem to need gcc.  If you have gcc, set
# both CC and MAY_NEED_GCC to gcc.
#
# If you do not have gcc, set CC to the name of your ANSI compiler, and
# set MAY_NEED_GCC to either ${CC} (and hope for the best) or to just :
# to disable such programs.
#
CC= cc
MAY_NEED_GCC= gcc

# winners that compile under ANSI C
#
WINNERS= anderson schneiderwent primenum bellard bmeyer briddlebane dhyang \
	dmy2jd jarijyrki dlowe natori rince robison thadgavin tomx
ALT_NAMES= schneiderwent.orig briddlebane.orig thadgavin.orig
DATA_FILES= schneiderwent_files bmeyer_files jarijyrki_files


all: ${WINNERS}

# Best use of flags
#
anderson: anderson.c
	${CC} ${CFLAGS} $? -o $@

# Most Timely Output
#
schneiderwent: schneiderwent.c
	${CC} ${CFLAGS} $? -o $@

schneiderwent_files: schneiderwent.data

schneiderwent.orig: schneiderwent.orig.c
	${CC} ${CFLAGS} $? -o $@

# Best Abuse of CPP
#
primenum: primenum.c
	${CC} ${CFLAGS} $? -o $@

# Most Specific Output
#
bellard: bellard.c
	${CC} ${CFLAGS} $? -o $@

# Best Utility
#
# machines operating in 64 bit mode:
#
bmeyer: bmeyer.c
	${CC} -DY= -O6 $? -o $@ -lm
#
# linux/x86, glibc 2.0, libc4/5:
#
# bmeyer: bmeyer.c
# 	${CC} -DY="__setfpucw(0x127f)" -O6 $? -o $@ -lm
#
# linux/x86, glibc 2.1:
#
# bmeyer: bmeyer.c
# 	${MAY_NEED_GCC} -DY='int x=0x127f; __asm__ ("fldcw %0" : : "m" (*&x))' \
# 			-O6 $? -o $@ -lm

bmeyer_files: lavabus.pgm lenna.glic michael.pgm

# Best Abuse of User
#
briddlebane: briddlebane.c
	${CC} ${CFLAGS} $? -o $@ -lm

briddlebane.orig: briddlebane.orig.c
	${CC} ${CFLAGS} $? -o $@ -lm

# Best Layout
#
dhyang: dhyang.c
	${CC} ${CFLAGS} $? -o $@

dmy2jd: dmy2jd.c
	${CC} ${CFLAGS} $? -o $@

# Best of Show
#
jarijyrki: jarijyrki.c
	${CC} ${X11CCFLAGS} ${CFLAGS} -DNeedFunctionPrototypes \
	    -DU=40 -DT=98 '-Dz=(T+1)*U*U' -DQ=80 -DS=20 -DN=10 -DB=5 -DG=23 \
	    -Dp=7 '-DM=((p+1)*Q)+S' '-DH=(G*S)+S+S' -DC=XK_Up -DL=XK_Down \
	    -DO=XK_Left -DV=XK_Right -DR=XK_Escape -D_=XK_BackSpace \
	    $? -o $@ ${X11LDFLAGS} -lX11

jarijyrki_files: sheet1.info

# Worst Abuse of the Rules
#
# NOTE: You will need to adjust this path to the place where Perl has been
#	installed on your system.  Running "perl -V" may help you locate
#	this place.
#
# The following bit of perl may help determining the values you need:
#
#	perl -MConfig -e 'print "$Config{archlibexp}/CORE\n"'
#
#
dlowe: dlowe.c
	${CC} ${NO_ANSI_CFLAGS} -DPERL_POLLUTE \
		`${PERL} -MExtUtils::Embed -e ccopts` $? -o $@ \
		`${PERL} -MExtUtils::Embed -e ldopts`

# Best Small Program
#
natori: natori.c
	${CC} ${CFLAGS} $? -o $@ -lm

# Astronomically Obfuscated
#
rince: rince.c
	${CC} ${X11CCFLAGS} ${CFLAGS} -DM_PI=3.14159265358979323846 \
		$? -o $@ -lm ${X11LDFLAGS} -lX11

# Best game
#
robison: robison.c
	${CC} ${CFLAGS} $? -o $@

# Most Portable Output
#
thadgavin: thadgavin.c
	${CC} ${CFLAGS} $? -o $@ -lcurses -lm

thadgavin.orig: thadgavin.orig.c
	${CC} ${CFLAGS} $? -o $@ -lncurses -lm

# Most Complete Program
#
tomx: tomx.c
	${CC} ${CFLAGS} $? -o $@

everything: ${WINNERS} ${ALT_NAMES} ${DATA_FILES}

clean:
	${RM} -f *.o a.out core ${WINNERS}

clobber: clean
	${RM} -f ${WINNERS}
	${RM} -f ${ALT_NAMES}

nuke: clobber
	@${TRUE}

install: all
	${CAT} ${WINNERS} ${ALT_NAMES} > /dev/null
