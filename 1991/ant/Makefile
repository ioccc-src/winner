#!/usr/bin/env make
#
# IOCCC 1991 winning entry - ant

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC entries:
#
#	https://www.ioccc.org/bugs.html
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

#######################
# common tool locations
#######################
#
include ../../var.mk

# Common C compiler warnings to silence
#
CSILENCE= -Wno-error -Wno-implicit-function-declaration -Wno-empty-body \
	  -Wno-implicit-function-declaration -Wno-return-type \
	  -Wno-deprecated-non-prototype -Wno-implicit-int \
	  -Wno-misleading-indentation -Wno-missing-parameter-type \
	  -Wno-unused-value

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu90

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= -DMODE=0600 -DBUF=32767

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS= -lcurses -ltermcap

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-implicit-int-conversion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-shadow -Wno-shorten-64-to-32 \
	   -Wno-strict-prototypes -Wno-unsafe-buffer-usage
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special Makefile variables for this entry
##############################
#
ENTRY= ant
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= README.md
TARGET= ${PROG} hill mole
#
ALT_OBJ= ${PROG}.alt.o ${PROG}.alt2.o
ALT_TARGET= ${PROG}.alt ${PROG}.alt2


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c hill
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

hill: README.md
	${RM} -f $@
	${CP} -f -v $? $@

mole: ${PROG}.c hill
	${RM} -f $@
	${CAT} ${PROG}.c hill > $@

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c hill
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}.alt2: ${PROG}.alt2.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

hill.alt: README.md
	${RM} -f $@
	${CP} -f -v $? $@

mole.alt: ${PROG}.c hill
	${RM} -f $@
	${CAT} ${PROG}.c hill.alt > $@

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt
	@${TRUE}


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM ant.alt ant.alt2


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
