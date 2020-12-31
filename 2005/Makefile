#!/bin/make
#
# 2005 makefile
#
# Copyright (C) 2005, Landon Curt Noll, Simon Cooper, Peter Seebach
# and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
# educational or non-profit use is granted provided this copyright and
# notice are included in its entirety and remains unaltered.  All other
# uses must receive prior permission from the contest judges.


# tool locations
#
SHELL= /bin/sh
CP= cp
CPP= cpp
GUNZIP= gunzip
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true


# Set X11_LIBDIR to the directory where the X11 library resides
#
X11_LIBDIR= /usr/X11R6/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
X11_INCLUDEDIR= /usr/X11R6/include

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers and thus you may
# not want anything.
#
#OPT=
#OPT= -O
#OPT= -O1
OPT= -O2


# flags for ANSI compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#       others such as gcc may want -ansi, others (Compaq Tru64 Unix)
#       want -std1, and others may want nothing at all.
#       Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#       incorrectly.  You might want to turn on -O to see if your
#       compiler can handle them.
#
#
#CFLAGS= -Xa ${OPT}
#CFLAGS= -std1 $(OPT)
CFLAGS= -ansi ${OPT}


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


# 2005 winners
#
WINNERS= aidan anon boutines chia giljade jetro klausler mikeash mynx persano sykes timwi toledo vik vince

# default build
#
build: 
	for i in ${WINNERS} ; do (cd $$i; ${MAKE} "CC=${CC}" "CFLAGS=${CFLAGS}" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCLUDEDIR=${X11_INCLUDEDIR}" build) done

# alternative executable
#
alt: 
	for i in ${WINNERS} ; do (cd $$i; ${MAKE} "CC=${CC}" "CFLAGS=${CFLAGS}" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCLUDEDIR=${X11_INCLUDEDIR}" alt) done

# data files
#
data: 
	for i in ${WINNERS} ; do (cd $$i; ${MAKE} data) done



# utility rules
#
everything: build alt data

love:
	@echo 'not war?'

haste:
	$(MAKE) waste

waste:
	@echo 'waste'

clean: 
	for i in ${WINNERS} ; do (cd $$i; ${MAKE} clean) done


clobber: ${CLOBBER}
	for i in ${WINNERS} ; do (cd $$i; ${MAKE} clobber) done

nuke: clobber
	@${TRUE}

install: all
	@${TRUE}

