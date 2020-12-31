# %W% %G% %U%
#
# 1993 makefile
#
# Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL=/bin/sh
CHMOD=chmod
CP=cp
RM=rm
SED=sed
LN=ln

# flags for ANSI compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#	others such as gcc may want -ansi, others may want nothing
#	at all.  Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#	entries incorrectly.  You might want need to turn on -O 
#	to see if your compiler can handle them.
#
#CFLAGS=-O -Xa
#CFLAGS=-Xa
CFLAGS= -ansi
#CFLAGS=

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#CC=cc
CC=gcc

# misc shell babble
#
NOINCLUDE=$(SED) -e 's/^.\([	 ]*\)include/%include/'
SPACECLEAN=$(SED) -e 's/\([^	 ]\)\([	 ]\)[ 	][ 	]*/\1\2/g'
CPPCLEAN=$(GREP) -v '^. [0-9][0-9]*'

# winners that compile under ANSI C
#
WINNERS= ant cmills dgibson ejb jonth leo lmfjyh plummer rince schnitzi vanb
ALT_NAMES= ag ag.txt chris mind jkb

all: $(WINNERS) $(ALT_NAMES)

ant: ant.c
	${CC} ${CFLAGS} ant.c -o ant

cmills: cmills.c
	${CC} ${CFLAGS} cmills.c -o cmills -lX11

dgibson: dgibson.c dgibson.sh dgibson.data1
	-@if [ ! -f life.d ] ; then \
	    echo "cp dgibson.data1 life.d"; \
	    cp dgibson.data1 life.d; \
	    echo "rm -f data.name"; \
	    rm -f data.name; \
	    echo "echo dgibson.data1 > data.name"; \
	    echo dgibson.data1 > data.name; \
	fi
	${CC} ${CFLAGS} dgibson.c -o dgibson
	-${CHMOD} +x dgibson.sh

ejb: ejb.c
	${CC} ${CFLAGS} ejb.c -o ejb

jonth: jonth.c
	${RM} -f jonth.tmp.c
	${SED} -e s/\^\ /#define/ -e 's/@/Window(D,/g' jonth.c > jonth.tmp.c
	${CC} ${CFLAGS} \
	    -DXX1='H 19;}M(J,4)}N H 20;}M(T,4)}q(m,w,' \
	    -DXX='XKeycodeToKeysym(D,o[13],0);K 12:Y();}R;}d XX1' \
	    jonth.tmp.c -o jonth -lX11

leo: leo.c
	${CC} ${CFLAGS} leo.c -o leo

lmfjyh: lmfjyh.c
	${RM} -f \"\;main\(\)\{puts\(\"Hello\ World!\"\)\;\}char\*C=\".c
	${CP} lmfjyh.c \"\;main\(\)\{puts\(\"Hello\ World!\"\)\;\}char\*C=\".c
	${CC} ${CFLAGS} \
	    \"\;main\(\)\{puts\(\"Hello\ World!\"\)\;\}char\*C=\".c \
	    -o lmfjyh

plummer: plummer.c
	${CC} ${CFLAGS} plummer.c -o plummer

rince: rince.c
	${CC} ${CFLAGS} rince.c -lcurses -ltermcap -o rince

# NOTE: this is the original source that won
#
rince.orig: rince.orig.c
	$(CC) $(CFLAGS) rince.orig.c -lcurses -ltermcap -o rince.orig

schnitzi: schnitzi.c
	${CC} ${CFLAGS} schnitzi.c -o schnitzi

vanb: vanb.c
	${CC} ${CFLAGS} -DO5=main vanb.c -o vanb


# alternate names for selected entries
#
ag: ant
	$(RM) -f ag
	$(LN) ant ag

ag.txt: ant.txt
	$(RM) -f ag.txt
	$(LN) ant.txt ag.txt

chris: cmills
	$(RM) -f chris
	$(LN) cmills chris

mind: leo
	$(RM) -f mind
	$(LN) leo mind

jkb: rince
	$(RM) -f jkb
	$(LN) rince jkb

tidy:
	${RM} -f \"\;main\(\)\{puts\(\"Hello\ World!\"\)\;\}char\*C=\".c

clean:
	$(RM) -f *.o a.out core 

clobber: clean tidy
	$(RM) -f $(WINNERS)
	$(RM) -f $(ALT_NAMES)
	${RM} -f jonth.tmp.c life.d rince.orig data.name data.name2

nuke: clobber
	@true

install: all
	cat $(WINNERS) > /dev/null
