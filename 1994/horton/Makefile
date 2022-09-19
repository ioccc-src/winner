# %W% %G% %U%
#
# 1994 makefile
#
# Copyright (c) 1994, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


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
#	entries incorrectly.  You might want need to turn on -O 
#	to see if your compiler can handle them.
#
#CFLAGS=-O -Xa
#CFLAGS=-Xa
#CFLAGS= -ansi
CFLAGS= -ansi -O
#CFLAGS=

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#CC=cc
CC=gcc

# winners that compile under ANSI C
#
WINNERS= dodsond1 dodsond2 horton imc ldb schnitzi shapiro smr tvr weisberg \
	westley
ALT_NAMES= dodsond2.orig shapiro.alt horton.alt gtface weisberg.alt tvr.alt

all: $(WINNERS) $(ALT_NAMES)

westley: westley.c
	${CC} ${CFLAGS} westley.c -DO -o westley

weisberg: weisberg.c
	${CC} ${CFLAGS} -Dc='n*n>x?p:((m=*(b+1)),N))'	\
	-De='(2<<6*sizeof(int))'			\
	-Do='(8<<5*sizeof(int))'			\
	-DN='((b=t+1),x+=2,x>e?exit():o' 		\
	-Dp='(a-t<o?*(a++)=x:47),printf("%d ",x),N)' 	\
	weisberg.c -o weisberg

# If you want weisberg to generate all values up to MAXINT
# and have the memory to malloc a 512M table, use the following.
#
weisberg.alt: weisberg.c
	${CC} ${CFLAGS} -Dc='n*n>x?p:((m=*(b+1)),N))'	\
	-De='~(1<<8*sizeof(int)-1)' 			\
	-Do='(2<<7*sizeof(int))'			\
	-DN='((b=t+1),x+=2,x>e?exit():o' 		\
	-Dp='(a-t<o?*(a++)=x:47),printf("%d ",x),N)' 	\
	weisberg.c -o weisberg.alt

tvr: tvr.c
	${CC} ${CFLAGS} tvr.c -o tvr -lX11

# The following is an alternate version of tvr.  Modes 0-3 have been
# renumbered 1-4.  Mode 0 is Mandelbrot / julian calculated correctly.
#
tvr.alt: tvr.alt.c
	${CC} ${CFLAGS} tvr.alt.c -o tvr.alt -lX11

smr: smr.c
	@${RM} -rf smr
	${CP} smr.c smr
	${CHMOD} +x smr

shapiro: shapiro_t2.c
	${CC} ${CFLAGS} shapiro_t2.c -o shapiro

shapiro_t2.c: shapiro_t1
	@${RM} -f shapiro_t2.c
	./shapiro_t1 > shapiro_t2.c

shapiro_t1: shapiro.c
	${CC} ${CFLAGS} shapiro.c -o shapiro_t1

shapiro.alt: shapiro.alt.c
	${CC} ${CFLAGS} shapiro.alt.c -o shapiro.alt

schnitzi: schnitzi.c
	${CC} ${CFLAGS} schnitzi.c -o schnitzi

horton: horton.c
	${CC} ${CFLAGS} horton.c -o horton

# Here are some programs related to the horton entry.  See horton.hint
# for details.
#
horton.alt: horton.alt.c
	${CC} ${CFLAGS} horton.alt.c -o horton.alt
gtface: gtface.c
	${CC} ${CFLAGS} gtface.c -o gtface

ldb: ldb.c
	${CC} ${CFLAGS} ldb.c -o ldb

imc: imc.c
	${CC} ${CFLAGS} imc.c -o imc

dodsond2: dodsond2.c
	${CC} ${CFLAGS} dodsond2.c -o dodsond2

# NOTE: this is the original (gziped) file that won
#
dodsond2.orig: dodsond2.gz
	@${RM} -f dodsond2.orig.c
	-${GUNZIP} < dodsond2.gz > dodsond2.orig.c
	-@if [ -s dodsond2.orig.c ]; then \
	    ${ECHO} "${CC} ${CFLAGS} dodsond2.orig.c -o dodsond2.orig"; \
	    ${CC} ${CFLAGS} dodsond2.orig.c -o dodsond2.orig; \
	else \
	    ${RM} -f dodsond2.orig.c; \
	    ${ECHO} "sorry, we could not gunzip dodsond2.gz"; \
	fi

dodsond2.gz: dodsond2.gz.uu
	@${RM} -f dodsond2.gz
	${UUDECODE} dodsond2.gz.uu

dodsond1: dodsond1.c
	${CC} ${CFLAGS} dodsond1.c -o dodsond1

clean:
	$(RM) -f *.o a.out core 

clobber: clean
	$(RM) -f $(WINNERS)
	$(RM) -f $(ALT_NAMES)
	${RM} -f dodsond2.orig.c dodsond2.gz shapiro_t2.c shapiro_t1

nuke: clobber
	@${TRUE}

install: all
	${CAT} $(WINNERS) $(ALT_NAMES) > /dev/null
