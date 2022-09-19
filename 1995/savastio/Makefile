# %W% %G% %U%
#
# 1995 makefile
#
# Copyright (c) 1996, Landon Curt Noll, Larry Bassel & Sriram Srinivasan
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll, Larry Bassel and Sriram Srinivasan.


SHELL=/bin/sh
CAT=cat
CHMOD=chmod
CP=cp
ECHO=echo
GUNZIP=gunzip
UUDECODE=uudecode
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
#CFLAGS=-O -Xa
#CFLAGS=-Xa
#CFLAGS= -ansi
CFLAGS= -ansi -O
#CFLAGS=

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
CC=cc
#CC=gcc

# winners that compile under ANSI C
#
WINNERS= cdua dodsond1 dodsond2 esde garry heathbar leo makarios savastio \
	schnitzi spinellis vanschnitz
ALT_NAMES= leo.orig garry.fmt garry.test

LEVEL=5

all: $(WINNERS)

cdua: cdua.c
	${CC} ${CFLAGS} cdua.c -o cdua

dodsond1: dodsond1.c
	${CC} ${CFLAGS} -DXXXXXX= -DXXXXXXX= dodsond1.c -o dodsond1

dodsond2: dodsond2.c
	${CC} ${CFLAGS} dodsond2.c -o dodsond2 -lcurses -ltermcap

esde: esde.c esde.data esde.data2
	${CC} ${CFLAGS} esde.c -o esde

garry: garry.c
	${CC} ${CFLAGS} garry.c -o garry

heathbar: heathbar.c
	${CC} ${CFLAGS} heathbar.c -o heathbar

# The following as a less obfuscated version of garry.
#
garry.fmt: garry.fmt.c
	${CC} ${CFLAGS} garry.fmt.c -o garry.fmt

# The following are test progs for garry
#
garry.test: garry.test.sh garry garry.data
	rm -f garry.test
	cp garry.test.sh garry.test
	chmod +x garry.test

leo: leo.c
	${CC} ${CFLAGS} -DGa=608 -DAs=792 -DMo=int -DAr='unsigned long' \
			-DS='struct Se' leo.c -o leo

# NOTE: this is the original program that was non-interactive
#
leo.orig: leo.orig.c
	${CC} ${CFLAGS} -DGa=608 -DAs=792 -DMo=int -DAr='unsigned long' \
			-DS='struct S' leo.orig.c -o leo.orig

makarios: makarios.c
	${CC} ${CFLAGS} makarios.c -o makarios

schnitzi: schnitzi.c
	${CC} ${CFLAGS} schnitzi.c -o schnitzi

spinellis: spinellis.c
	${CC} ${CFLAGS} spinellis.c -o spinellis

vanschnitz: vanschnitz.c
	${CC} ${CFLAGS} -Dn=${LEVEL} vanschnitz.c -o vanschnitz

clean:
	$(RM) -f *.o a.out core ${WINNERS}

clobber: clean
	$(RM) -f $(WINNERS)
	$(RM) -f $(ALT_NAMES)

nuke: clobber
	@${TRUE}

install: all
	${CAT} $(WINNERS) $(ALT_NAMES) > /dev/null
