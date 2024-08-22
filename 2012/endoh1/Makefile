#!/usr/bin/env make
#
# IOCCC 2012 winning entry - endoh1

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
CSILENCE= -Wno-absolute-value -Wno-strict-prototypes

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu11

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= -DG="${GRAVITY}" -DP="${PRESSURE}" -DV="${VISCOSITY}"

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
LDFLAGS= -lm

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-conversion -Wno-double-promotion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-unreachable-code-return -Wno-extra-semi-stmt \
	   -Wno-misleading-indentation -Wno-unsafe-buffer-usage
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
ENTRY= endoh1
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= column.txt column2.txt column3.txt corners.txt dripping-pan.txt \
	evaporation.txt flat.txt fountain.txt funnel.txt funnel2.txt \
	funnel3.txt leidenfrost.txt logo.txt pour-out.txt tanada.txt
TARGET= ${PROG} ${PROG}_color
#
ALT_OBJ= ${PROG}.alt.o ${PROG}_color.alt.o ${PROG}.alt2.o
ALT_TARGET= ${PROG}.alt ${PROG}_color.alt ${PROG}.alt2

# The factor of gravity
#
GRAVITY=1

# The factor of pressure
#
PRESSURE=4

# The factor of viscosity
#
VISCOSITY=8


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}_color: ${PROG}_color.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# Variables that control the alarm(3) timer and how much to sleep for alternate code
#
TIMER= 10
SLEEP= 12321

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} -DS=${SLEEP} -DA=${TIMER} $< -o $@ ${LDFLAGS}

# this does NOT correspond to endoh1.alt2.c but rather endoh1.alt.c: it is NOT
# deobfuscated.
${PROG}_color.alt: ${PROG}_color.alt.c
	${CC} ${CFLAGS} -DS=${SLEEP} -DA=${TIMER} $< -o $@ ${LDFLAGS}

# deobfuscated version:
${PROG}.alt2: ${PROG}.alt2.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}


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
	${RM} -rf *.dSYM ${ALT_TARGET}2 ${PROG}_color.alt ${PROG}.alt2


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
