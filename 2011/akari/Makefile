#!/usr/bin/env make
#
# IOCCC 2011 winning entry - akari

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
CSILENCE= -Wno-empty-body -Wno-error -Wno-implicit-function-declaration \
	  -Wno-implicit-int -Wno-return-type -Wno-unused-parameter \
	  -Wno-deprecated-non-prototype -Wno-misleading-indentation

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu99

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
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-conditional-uninitialized -Wno-error \
	   -Wno-implicit-function-declaration -Wno-format-nonliteral \
	   -Wno-implicit-int -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-redundant-parens -Wno-return-type -Wno-shadow \
	   -Wno-shorten-64-to-32 -Wno-strict-prototypes -Wno-pedantic \
	   -Wno-extra-semi-stmt -Wno-misleading-indentation \
	   -Wno-reserved-identifier -Wno-unsafe-buffer-usage
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
ENTRY= akari
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= example.ppm
TARGET= ${PROG} ${PROG}2 ${PROG}3 ${PROG}4
#
ALT_OBJ=
ALT_TARGET=


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}2.c: ${PROG}
	./${PROG} ${PROG}.c $@

${PROG}2: ${PROG}2.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}3.c: ${PROG} ${PROG}.c
	./${PROG} < ${PROG}.c | ./${PROG} > $@

${PROG}3: ${PROG}3.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}4.c: ${PROG} ${PROG}.c
	./${PROG} < ${PROG}.c | ./${PROG} | ./${PROG} > $@

${PROG}4: ${PROG}4.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

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
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM rot13.c
	${RM} -f akari2.c akari3.c akari4.c odd_output.ppm even_output.ppm expanded_and_rot13_output.txt expanded_output.txt


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
