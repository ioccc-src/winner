#!/usr/bin/env make
#
# IOCCC 2004 winning entry - jdalbec

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
CSILENCE= -Wno-int-to-pointer-cast -Wno-int-to-void-pointer-cast \
	  -Wno-trigraphs -Wno-unused-value -Wno-gnu-line-marker

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -ansi

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= -DAg=${Ag}

# Include files that are needed to compile
#
CINCLUDE= -include stddef.h -include stdlib.h -include stdio.h

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-missing-variable-declarations -Wno-padded \
	   -Wno-poison-system-directories -Wno-sign-conversion -Wno-trigraphs \
	   -Wno-unsafe-buffer-usage
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
ENTRY= jdalbec
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	@${RM} -f ${PROG}2.c $@
	-${CC} ${CSILENCE} -E ${PROG}.c > ${PROG}2.c
	@${RM} -f ${PROG}3.c
	${SED} -e 's/ (/(/g' < ${PROG}2.c > ${PROG}3.c
	${CC} ${CFLAGS} ${PROG}3.c -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# Variable to control how many numbers to print on a line for alternate code
#
Ag= 11

${PROG}.alt: ${PROG}.alt.c
	@${RM} -f ${PROG}2.alt.c $@
	-${CC} ${CSILENCE} -E ${PROG}.alt.c > ${PROG}2.alt.c
	@${RM} -f ${PROG}3.alt.c
	${SED} -e 's/ (/(/g' < ${PROG}2.alt.c > ${PROG}3.alt.c
	${CC} ${CFLAGS} ${PROG}3.alt.c -o $@ ${LDFLAGS}


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
	${RM} -rf *.dSYM
	${RM} -f ${PROG}2.c ${PROG}3.c  ${PROG}2.alt.c ${PROG}3.alt.c


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
