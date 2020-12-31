#!/bin/make
# 1998 makefile
#
# Copyright (c) Landon Curt Noll, Jeremy Horn, Peter Seebach
# and Leonid A. Broukhis, 1999.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from the contest judges.

SHELL=/bin/sh
CAT=cat
CHMOD=chmod
CP=cp
MV=mv
ECHO=echo
LN=ln
RM=rm
SED=sed
TRUE=true

# flags for ANSI compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#	others such as gcc may want -ansi, others may want nothing
#	at all.  Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#	incorrectly.  You might want to turn on -O to see if your
#	compiler can handle them.
#
# NOTE: On some systems, the library path does not include the location
#	of the X11 libraries.  You might need to use a -L/path/to/X11/lib/dir
#	in order to compile with these libs.
#
#CFLAGS=-O -Xa
#CFLAGS=-Xa
CFLAGS= -ansi
#CFLAGS= -ansi -O
#CFLAGS=
#CFLAGS= -ansi -L/usr/X11R6/lib

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
WINNERS= schweikh1 df dloweneil banks dlowe bas2 fanf bas1 tomtorfs dorssel \
	 schweikh2 schnitzi chaos schweikh3
ALT_NAMES= schweikh2.orig banks.orig dlowe.orig df.orig schweikh1.orig \
	chaos_nohalf
DATA_FILES= banks_files chaos_files fanf_files schweikh1_files schweikh3_files


all: ${WINNERS}

schweikh1: schweikh1.c
	${MAY_NEED_GCC} ${CFLAGS} $? -o $@

schweikh1.orig: schweikh1.orig.c
	${MAY_NEED_GCC} ${CFLAGS} $? -o $@

schweikh1_files: data

df: df.c
	${CC} ${CFLAGS} $? -o $@

df.orig: prog.c
	${CC} ${CFLAGS} $? -o $@

prog.c : df.c
	${RM} -f prog.c
	${CP} $? prog.c

dloweneil: dloweneil.c
	${CC} ${CFLAGS} $? -lcurses -o $@

# See note about use of -L/path/to/X11/lib/dir above this rule fails to link
#
banks: banks.c
	${CC} ${CFLAGS} $? -DIT=XK_Page_Up -DDT=XK_Page_Down \
		-DUP=XK_Up -DDN=XK_Down -DLT=XK_Left -DRT=XK_Right \
		-DCS=XK_Return -Ddt=0.02 -lm -lX11 -o $@

# See note about use of -L/path/to/X11/lib/dir above this rule fails to link
#
banks.orig: banks.orig.c
	${MAY_NEED_GCC} ${CFLAGS} $? -DIT=XK_Page_Up -DDT=XK_Page_Down \
		-DUP=XK_Up -DDN=XK_Down -DLT=XK_Left -DRT=XK_Right \
		-DCS=XK_Return -Ddt=0.02 -lm -lX11 -o $@

banks_files: bb.sc horizon.sc mountains.sc pittsburgh.sc pyramids.sc river.sc

dlowe: dlowe.c
	${CC} ${CFLAGS} $? -o $@

dlowe.orig: dlowe.orig.c
	${CC} ${CFLAGS} $? -o $@

bas2: bas2.c
	${CC} ${CFLAGS} $? -o $@

fanf: fanf.c
	${RM} -f fanftmp1.c fanftmp2.c
	${MAY_NEED_GCC} ${CFLAGS} -E $? > fanftmp1.c
	${MAY_NEED_GCC} ${CFLAGS} -E fanftmp1.c > fanftmp2.c
	${MAY_NEED_GCC} ${CFLAGS} fanftmp2.c ${LDFLAGS} -o $@

fanf_files: fanf.lambda

bas1: bas1.c
	${CC} ${CFLAGS} $? -o $@

tomtorfs: tomtorfs.c
	${CC} ${CFLAGS} $? -o $@

dorssel: dorssel.c
	${CC} ${CFLAGS} $? -o $@

schweikh2: schweikh2.c
	${MAY_NEED_GCC} ${CFLAGS} $? -o $@

schweikh2.orig: schweikh2.orig.c
	${MAY_NEED_GCC} ${CFLAGS} $? -o $@

schweikh3: schweikh3.c
	${MAY_NEED_GCC} ${CFLAGS} $? -DM0=sizeof -DM1=long -DM2=void \
		-DM3=realloc -DM4=calloc -DM5=free -o $@

schweikh3_files: samefile.1

schnitzi: schnitzi.c
	${CC} ${CFLAGS} $? -o $@

chaos: chaos.c
	${CC} ${CFLAGS} $? -lcurses -o $@

# some libcurses do not have halfdelay().  This rule is for those systems
#
chaos_nohalf: chaos_nohalf.c
	${CC} ${CFLAGS} $? -lcurses -o $@
	${CP} -f $@ chaos

chaos_nohalf.c: chaos.c
	${RM} -f $@
	${SED} -e 's/halfdelay([^)]*);//' < $? > $@

chaos_files: cube.data desk.data ioccc.data pyramid.data xwing.data

everything: ${WINNERS} ${ALT_NAMES} ${DATA_FILES}

clean:
	${RM} -f *.o a.out core ${WINNERS}
	${RM} -f prog.c fanftmp1.c fanftmp2.c chaos_nohalf.c

clobber: clean
	${RM} -f ${WINNERS}
	${RM} -f ${ALT_NAMES}

nuke: clobber
	@${TRUE}

install: all
	${CAT} ${WINNERS} ${ALT_NAMES} > /dev/null
