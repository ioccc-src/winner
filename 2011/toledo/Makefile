#!/usr/bin/env make
#
# 2011 makefile
#
# Copyright (C) 2011, Landon Curt Noll, Simon Cooper, and Leonid A. Broukhis.
#
# Creative Commons Attribution-ShareAlike 3.0 Unported License.
# See: http://creativecommons.org/licenses/by-sa/3.0/


################
# tool locations
################
#
SHELL= /bin/bash
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
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
#
OPT= -O2

# bitness
#
# Some entries require 32-bitness,
# other entries require 64-bitess.
# By default we assume nothing.
#
ARCH=

# default flags for ANSI C compilation
#
CFLAGS= -Wall -W -ansi ${ARCH} ${OPT} -I${X11_INCDIR} -L${X11_LIBDIR} -lX11 -lm -DA=XK_Up:XK_w -DB=XK_Left:XK_a -DC=XK_Right:XK_d -DD=XK_Down:XK_s -DE=XK_BackSpace:XK_Tab "-DQ=XFillRectangle(W,X,Y,"

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
CC= cc


##############################
# Special flags for this entry
##############################
#
ENTRY= toledo
DATA=


#################
# build the entry
#################
#
all: ${ENTRY} ${DATA}
	@${TRUE}

${ENTRY}: ${ENTRY}.c
	${CC} ${CFLAGS} ${ENTRY}.c -o ${ENTRY}

# alternative executable
#
alt:
	@${TRUE}


###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${ENTRY}.o

clobber: clean
	${RM} -f ${ENTRY}

nuke: clobber
	@echo gnab gib!

install:
	@echo "Surely you're joking Mr. Feynman!"

# backwards compatibility
#
build: all


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'

haste:
	$(MAKE) waste

waste:
	@echo 'waste'

easter_egg:
	@echo you expected to mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from being unable to partly misunderstand this final echo.
	@${TRUE}
