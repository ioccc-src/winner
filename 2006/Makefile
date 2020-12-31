#
# 2006 makefile
#
# Copyright (C) 2006-2009, Landon Curt Noll, Simon Cooper, Peter Seebach
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
X11_INCDIR= /usr/X11R6/include


# optimization
#
# Most compiles will safely use -O3.  Some can use only -O2 or -O1 or -O.
# A few compilers have broken optimizers and thus you may
# not want anything.
#
#OPT=
#OPT= -O
#OPT= -O1
#OPT= -O2
OPT= -O3


# default flags for ANSI C compilation
#
#CFLAGS=
#CFLAGS= -Wall -W -ansi
#CFLAGS= -Wall -W -ansi -pedantic
#CFLAGS= -Wall -W -ansi ${OPT}
CFLAGS= -Wall -W -ansi -pedantic ${OPT}


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


# 2006 winners
#
WINNERS= birken borsanyi grothe hamre meyer monge night sloane stewart sykes1 \
	sykes2 toledo1 toledo2 toledo3


# default build
#
build: 
	for i in ${WINNERS} ; do (cd $$i && ${MAKE} "ENTRY=$$i" "CC=${CC}" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" build) done

# alternative executable
#
alt: 
	for i in ${WINNERS} ; do (cd $$i && ${MAKE} "ENTRY=$$i" "CC=${CC}" "CFLAGS=${CFLAGS}" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" alt) done

# data files
#
data: 
	for i in ${WINNERS} ; do (cd $$i && ${MAKE} "ENTRY=$$i" data) done


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
	for i in ${WINNERS} ; do (cd $$i && ${MAKE} "ENTRY=$$i" clean) done


clobber: 
	for i in ${WINNERS} ; do (cd $$i && ${MAKE} "ENTRY=$$i" clobber) done

nuke: clobber
	@${TRUE}

install: all
	@${TRUE}

