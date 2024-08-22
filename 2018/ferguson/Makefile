#!/usr/bin/env make
#
# IOCCC 2018 winning entry - ferguson

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
CSILENCE= -Wno-strict-prototypes -Wno-stringop-truncation

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
ARCH=

# Variables to help simplify configuring the build
#

# Maximum size of the target string defaults at 38. See README.md for why this
# is.
#
MAX_SIZE= 38

# Number of offspring per generation defaults at 25.
#
OFFSPRING= 25

# Max attempts defaults at SIZE_MAX - 1 but one can change it to see what
# happens when the maximum is reached.
MAX_ATTEMPTS= SIZE_MAX-1

# Defines that are needed to compile
#
CDEFINE= -DQ='typedef' -D'g(o)'='goto o;' -D'w(x)'="x:" -D'H(main)'='r(main)' -DM=${MAX_ATTEMPTS} \
	-DS=${MAX_SIZE} -DN=${OFFSPRING}

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
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-padded -Wno-poison-system-directories \
	   -Wno-disabled-macro-expansion -Wno-extra-semi-stmt \
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
ENTRY= ferguson
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= FILES hint.css rpm.md test-strings.txt weasel.1 weasel.spec
TARGET= ${PROG} weasel
#
ALT_OBJ= ${PROG}.alt
ALT_TARGET= ${PROG}.alt weasel.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

weasel: ${PROG}
	${CP} -f $< $@

test: ${PROG} test.sh
	@./test.sh

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

weasel.alt: ${PROG}.alt
	${CP} -f $< $@

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


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
