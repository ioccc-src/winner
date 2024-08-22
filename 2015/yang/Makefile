#!/usr/bin/env make
#
# IOCCC 2015 winning entry - yang

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
CSILENCE= -Wno-dollar-in-identifier-extension -Wno-null-character \
	  -Wno-misleading-indentation -Wno-pedantic -Wno-null-pointer-subtraction

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
CDEFINE=

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
CSILENCE+= -Wno-c99-compat -Wno-comma -Wno-double-promotion -Wno-float-conversion \
	   -Wno-implicit-float-conversion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-unreachable-code -Wno-c++98-compat -Wno-old-style-cast \
	   -Wno-zero-as-null-pointer-constant -Wno-unsafe-buffer-usage
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
ENTRY= yang
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.c
CPLUSPLUSSRC= ${PROG}.cc
DATA=
TARGET= ${PROG} ${PROG}_c90 ${PROG}_c99 ${PROG}_c11 ${CPLUSPLUSSRC} \
	${PROG}_cpp98 ${PROG}_cpp11
#
ALT_OBJ=
ALT_TARGET=

CPLUSPLUS= clang++
MAY_NEED_GPLUSPLUS= g++


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}_c90: ${CSRC}
	${CC} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT} -std=c90 ${CSRC} -o $@ ${LDFLAGS}

${PROG}_c99: ${CSRC}
	${CC} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT} -std=c99 ${CSRC} -o $@ ${LDFLAGS}

${PROG}_c11: ${CSRC}
	${CC} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT} -std=c11 ${CSRC} -o $@ ${LDFLAGS}

${CPLUSPLUSSRC}: ${CSRC}
	${RM} -f $@
	${CP} -f -p ${CSRC} $@

${PROG}_cpp98: ${CPLUSPLUSSRC}
	${CPLUSPLUS} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT} -std=c++98 ${CPLUSPLUSSRC} -o $@ ${LDFLAGS}

${PROG}_cpp11: ${CPLUSPLUSSRC}
	${CPLUSPLUS} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT} -std=c++11 ${CPLUSPLUSSRC} -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

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
	${RM} -f ${TARGET} ${ALT_TARGET} output output.c
	${RM} -rf *.dSYM


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
