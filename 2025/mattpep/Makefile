#!/usr/bin/env make
#
# 2025/mattpep

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
# This file is Copyright (c) 2026 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################

SHELL= bash

#######################
# common tool locations
#######################

include ../var.mk

#####################
# C compiler settings
#####################

# Common C compiler warnings to silence
#
# Example: CSILENCE= -Wno-int-conversion
#
CSILENCE= -Wno-poison-system-directories -Wno-unused-value -Wno-type-limits -Wno-char-subscripts \
	-Wno-misleading-indentation -Wno-strict-prototypes -Wno-unicode-homoglyph

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
#
CSTD= -std=gnu17

# Compiler bit architecture
#
# Example for 32-bitness: ARCH= -m32
# Example for 64-bitness: ARCH= -m64
#
# NOTE: Normally one should NOT specify a specific architecture.
#
ARCH=

# Defines that are needed to compile
#
# Example: -Dfoo -Dbar=baz
#
CDEFINE=

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE=

# Other flags to pass to the C compiler
#
# Example: COTHER= -fno-math-errno
#
COTHER=

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${COTHER} ${OPT}

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
CSILENCE+=
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
CSILENCE+=
#
CWARN+=
#
endif

###########################################
# Special Makefile variables for this entry
###########################################

# what to build
#
ENTRY= prog
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=

# list any data files supplied with the submission
#
DATA= test-4k.bin test-100k.bin 1.txt 2.txt 3.txt 4.txt 5.txt 6.txt

# shell scripts
#
SH_TOOLS= try.sh

#################
# build the entry
#################

all: data ${SH_TOOLS} ${TARGET}

.PHONY: all data clean clobber install

# how to compile
#
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} ${PROG}.alt.c -o $@ ${LDFLAGS}

# data files
#
data: ${DATA}

everything: all
	@${TRUE}

###############
# utility rules
###############

clean:
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -rf ${TARGET} ${ALT_TARGET} *.dSYM
	${RM} -f infile.b64 output output.c output.o prog_classify prog_classify.c
	${RM} -f prog_classify.o prog_generate prog_generate.c prog_generate.o prog_head
	${RM} -f prog_head.c prog_head.o prog_tail prog_tail.c prog_tail.o test-4k.b64
	${RM} -f test-4k.bin.new

######################################
# optional include of 1337 hacker rulz
######################################

-include ../1337.mk
