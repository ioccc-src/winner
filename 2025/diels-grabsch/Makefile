#!/usr/bin/env make
#
# 2025/diels-grabsch

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
CSILENCE= -Wno-deprecated-non-prototype -Wno-error -Wno-implicit-function-declaration \
	-Wno-main -Wno-shift-op-parentheses

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option


# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -ansi

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
# NOTE: Feel free to change the level of compiler optimization.
#       The "-O3" is just a friendly default you might wish to try.
#
# Example: OPT= -O0 -g
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${COTHER} ${OPT}

# Libraries needed to build
#
# Example: LDFLAGS= -lncurses -lm
#
LDFLAGS=

# C compiler to use
#
# NOTE: The IOCCC Judges recommend you leave CC as just "cc"
#       and NOT set it to clang, or gcc, or something else
#       unless you have a STRONG reason to do so.
#
#       Setting CC to something other than "cc" makes your
#       code less portable to those who do not have your
#       particular C compiler.  **hint**
#
#       If you want to test your code with a particular C compiler,
#       use the make command line.  For example:
#
#           make all CC=clang
#           make all CC=gcc
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
# NOTE: This code is only invoked when CC contains "clang"
#       such as when you use the make command lines like:
#
#           make all CC=clang
#           make all CC=clang-mp-12
#
CSILENCE+= -Wno-comma -Wno-deprecated-non-prototype -Wno-error \
	-Wno-implicit-function-declaration -Wno-implicit-int -Wno-main \
	-Wno-main-return-type -Wno-missing-variable-declarations \
	-Wno-poison-system-directories -Wno-shift-op-parentheses \
	-Wno-unsafe-buffer-usage
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
# NOTE: This code is only invoked when CC contains "gcc"
#       such as when you use the make command lines like:
#
#    make all CC=gcc
#    make all CC=gcc-15
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

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

# shell scripts
#
SH_TOOLS= try.sh

#################
# build the entry
#################

all: data ${SH_TOOLS} ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c

# data files
#
data: ${DATA}
	@${TRUE}

everything: all
	@${TRUE}

###############
# utility rules
###############
#
clean:
	@${RM} -f ${OBJ}

clobber:
	@${RM} -f ${TARGET}
	@${RM} -rf *.dSYM
	@${RM} -f mills2-9bit mills2-9bit.c mills2-9bit.o outfile.Z remarks.md.Z spaces spaces.Z

######################################
# optional include of 1337 hacker rulz
######################################

-include ../1337.mk
