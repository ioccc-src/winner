#!/bin/make
# 2001 makefile
#
# Copyright (C) Simon Cooper, Landon Curt Noll, Peter Seebach, 2001.
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

# NOTE: On some systems, the library path does not include the location
#	of the X11 libraries.  You might need to use a -L/path/to/X11/lib/dir
#	in order to compile with these libs.
#
X11CCFLAGS= -I/usr/X11R6/include -I/usr/X11R6/include/X11 -I/usr/include/X11
#X11CCFLAGS=
X11LDFLAGS= -L/usr/X11R6/lib -Wl,-R/usr/X11R6/lib
#X11LDFLAGS=

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
WINNERS= anonymous bellard bellard.otccex cheong coupard \
	 ctk dgbeards herrmann1 herrmann2 jason kev ollinger rosten \
	 schweikh westley williams
ALT_NAMES= westley.orig
DATA_FILES= anonymous_files bellard_files herrmann1_files herrmann2_files


all: ${WINNERS}

# Most likely to amaze
#
anonymous: anonymous.c
	magic='${MAY_NEED_GCC} -O1'; \
	X='-DA(X)=#X'; \
	warning='-pedantic -Dprocessor'; \
	$$magic $$warning -Dmagic= $$X "-DX=A($$magic \"$$X\")" \
		-o anonymous anonymous.c

anonymous_files: anonymous.ten.c

# Best abuse of the rules
#
bellard: bellard.c
	${CC} -rdynamic ${CFLAGS} bellard.c -o bellard -ldl

bellard_files: bellard.otccex.c

# Best short program
#
cheong: cheong.c
	${CC} ${CFLAGS} cheong.c -o cheong

# Most obfuscated sound
#
coupard: coupard.c
	${CC} ${CFLAGS} -o coupard coupard.c

# Worst Driver
#
ctk: ctk.c
	${CC} ${CFLAGS} -o ctk ctk.c

# Worst AI
#
dgbeards: dgbeards.c
	${CC} ${CFLAGS} -DE=break -DF=char -DK=case -DP=int -DR=return \
	      -DI=0xFFFF dgbeards.c -o dgbeards

# Best abuse of the C preprocessor
#
herrmann1: herrmann1.c herrmann1.sh
	@echo "NOTE: $@ must be built/run using the script $@.sh"
	${SHELL} ./herrmann1.sh

herrmann1_files: herrmann1.gcd herrmann1.sh herrmann1.times2

# Most eye-crossing
#
# This entry requires the GCC -include feature.
#
herrmann2: herrmann2.c
	${MAY_NEED_GCC} ${CFLAGS} herrmann2.c -o herrmann2 \
	     -include /usr/include/stdlib.h -include /usr/include/stdio.h \
	     -include /usr/include/time.h -include /usr/include/unistd.h

herrmann2_files: herrmann2.cup herrmann2.ioccc

# Best Of Show
#
jason: jason.c
	${CC} ${CFLAGS} -o jason jason.c

# Best Curses Game
#
kev: kev.c
	${CC} ${CFLAGS} -DPORT=5455 -DSPEED=50 -o kev kev.c \
		-lcurses -ltermcap \
		-Dl_="socket(il.sin_family=AF_INET,SOCK_STREAM,0)"

# Best primal ASCII graphics
#
ollinger: ollinger.c
	${CC} ${CFLAGS} ollinger.c -o ollinger

# Best abuse of the user
#
rosten: rosten.c
	${CC} ${CFLAGS} rosten.c ${X11CCFLAGS} ${X11LDFLAGS} -pedantic -lX11 \
		-o rosten

# Best one-liner
#
schweikh: schweikh.c
	${CC} ${CFLAGS} schweikh.c -o schweikh

# Best position-independant code
#
westley: westley.c
	${CC} ${CFLAGS} westley.c -o westley

westley.orig: westley.orig.c
	${CC} ${CFLAGS} westley.orig.c -o westley.orig

# Best position-independant code
#
williams: williams.c
	${CC} williams.c ${X11CCFLAGS} ${X11LDFLAGS} -lX11 -o williams

everything: ${WINNERS} ${ALT_NAMES} ${DATA_FILES}

love:
	@echo 'not war?'

haste:
	${MAKE} waste

waste:
	@echo 'waste'

clean:
	${RM} -f *.o a.out core ${WINNERS}

clobber: clean
	${RM} -f ${WINNERS}
	${RM} -f ${ALT_NAMES}

nuke: clobber
	@${TRUE}

install: all
	${CAT} ${WINNERS} ${ALT_NAMES} > /dev/null
