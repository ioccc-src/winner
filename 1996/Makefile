# %W% %G% %U%
#
# 1996 makefile
#
# Copyright (c) 1997, Landon Curt Noll & Sriram Srinivasan
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Sriram Srinivasan.


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
WINNERS= august dalbec eldby gandalf huffman jonth rcm schweikh1 \
	schweikh2 schweikh3 westley
ALT_NAMES= august.orig

LEVEL=5

all: $(WINNERS)

# NOTE: Some compilers will compile this code into infinite loop
#	progs.  We have found gcc to work on a number of platforms.
#	If the following example does not execute in a very
#	short time, try a better compiler:
#
#		cat august.c test.oc | ./august > test.oo
#	
august: august.c fac.oc parse.oc test.oc
	${CC} ${CFLAGS} -DZ=60000 -D'T=m[s]' -D'P=m[s++]' \
	    -D'L=m[p++]' -D'g=getchar()' -DE=else -DW=while -D'B=m[p++]' \
	    -DI=if -DR='s=s+l/2;T=r;I(l%2)s++' -D'X=m[s-' \
	    -D'D=Q(13,-)Q(14,*)Q(15,/)Q(16,%)Q(6,==)Q(7,!=)Q(8,<)C(1,r=P;m[T]=r;T=r)C(9,r=P;m[T]=r;s++)' \
	    august.c -o august 
	${CHMOD} +r fac.oc parse.oc test.oc

# This forms a byte code execution engine written in OC
#
august.oc: august.c
	${RM} -f august.oc
	${CC} ${CFLAGS} -E -DZ=40000 -D'T=m[s]' -D'P=m[s++]' \
	    -D'L=m[p++]' -D'g=getchar()' -DE=else -DW=while -D'B=m[p++]' \
	    -DI=if -DR='s=s+l/2;T=r;I(l%2)s++' -D'X=m[s-' \
	    -D'D=Q(13,-)Q(14,*)Q(15,/)Q(16,%)Q(6,==)Q(7,!=)Q(8,<)C(1,r=P;m[T]=r;T=r)C(9,r=P;m[T]=r;s++)' \
	    august.c > august.oc
	${CHMOD} +r august.oc

# NOTE: this is the original source that won
#
august.orig: august.orig.c fac.oc parse.oc test.oc
	${CC} ${CFLAGS} -DZ=60000 -DZ=60000 -D'T=m[s]' -D'P=m[s++]' \
	    -D'L=m[p++]' -D'g=getchar()' -DE=else -DW=while -D'B=m[p++]' \
	    -DI=if -DR='s=s+l/2;T=r;I(l%2)s++' -D'X=m[s-' \
	    -D'D=Q(13,-)Q(14,*)Q(15,/)Q(16,%)Q(6,==)Q(7,!=)Q(8,<)C(1,r=P;m[T]=r;T=r)C(9,r=P;m[T]=r;s++)' \
	    august.orig.c -o august.orig
	${RM} -f august.oc
	${CC} ${CFLAGS} -E -DZ=40000 -D'T=m[s]' -D'P=m[s++]' \
	    -D'L=m[p++]' -D'g=getchar()' -DE=else -DW=while -D'B=m[p++]' \
	    -DI=if -DR='s=s+l/2;T=r;I(l%2)s++' -D'X=m[s-' \
	    -D'D=Q(13,-)Q(14,*)Q(15,/)Q(16,%)Q(6,==)Q(7,!=)Q(8,<)C(1,r=P;m[T]=r;T=r)C(9,r=P;m[T]=r;s++)' \
	    august.orig.c > august.oc
	${CHMOD} +r fac.oc parse.oc test.oc august.oc

dalbec: dalbec.c
	${CC} ${CFLAGS} dalbec.c -o dalbec

eldby: eldby.c
	${CC} ${CFLAGS} eldby.c -o eldby

gandalf: gandalf.c
	${CC} ${CFLAGS} gandalf.c -o gandalf
	${RM} -f hatcat cathat
	${CP} gandalf hatcat 
	${CP} gandalf cathat

huffman: huffman.c
	${CC} ${CFLAGS} huffman.c -o huffman

# Add -I${X}/include and -L${X}/lib if this doesn't build
#  (X is the root of the X Window distribution)
# Solaris users add -lsocket
#
jonth: jonth.c
	${CC} ${CFLAGS} jonth.c -o jonth -lX11 -lm

rcm: rcm.c
	${CC} ${CFLAGS} -DJ='if(' -Ds='else J O==' -DU='B(' \
	    -DX='for(' -DH='unsigned' -Dn='struct x' -DA='0,0,0,0,' \
	    -DT='<stdio.h>' -DY='<stdlib.h>' -DR='malloc(sizeof(n))' \
	    -DM='%=K' -DK=32768 -DD='getchar()' -DN=putchar rcm.c -o rcm

schweikh1: schweikh1.c errno.h
	${CC} ${CFLAGS} -I. schweikh1.c -o schweikh1

schweikh2: schweikh2.c hunni.c hunni.pl
	${CC} ${CFLAGS} -D_POSIX_SOURCE schweikh2.c -o schweikh2

# NOTE: On some systems such as SunOS, one may need to compile with:
#
#	${CC} ${CFLAGS} \
#	  -I. -D_POSIX_SOURCE '-Ddifftime(a,b)=(double)(b-a)' \
#	  schweikh3.c -o schweikh3
#	
schweikh3: schweikh3.c iso646.h
	${CC} ${CFLAGS} -I. -D_POSIX_SOURCE schweikh3.c -o schweikh3

westley: westley.c clock1 clock2 clock3
	${CC} ${CFLAGS} westley.c -o westley
	${CHMOD} +x clock1 clock2 clock3

clean:
	${RM} -f *.o a.out core ${WINNERS}

clobber: clean
	${RM} -f $(WINNERS)
	${RM} -f $(ALT_NAMES)
	${RM} -f fac.oo parse.oo test.oo hatcat cathat august.oc

nuke: clobber
	@${TRUE}

install: all
	${CAT} $(WINNERS) $(ALT_NAMES) > /dev/null
