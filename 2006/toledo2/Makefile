#!/usr/bin/env make
#
# IOCCC 2006 winning entry - toledo2

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
CSILENCE= -Wno-bitwise-conditional-parentheses -Wno-bitwise-op-parentheses \
	  -Wno-conditional-type-mismatch -Wno-error \
	  -Wno-implicit-function-declaration -Wno-implicit-int \
	  -Wno-int-conversion -Wno-pointer-type-mismatch -Wno-unsequenced \
	  -Wno-deprecated-non-prototype -Wno-parentheses -Wno-unused-value

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
CINCLUDE= -include unistd.h -include stdlib.h

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
CSILENCE+= -Wno-implicit-int-conversion -Wno-missing-variable-declarations \
	   -Wno-pedantic -Wno-poison-system-directories -Wno-shorten-64-to-32 \
	   -Wno-strict-prototypes -Wno-extra-semi-stmt -Wno-unsafe-buffer-usage
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
ENTRY= toledo2
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
ZIP_DATA= KAYPROII.ZIP
SUBDIR_SET= ADVENTUR BASICS DBASEII GAMES KERMIT MASTER MFDISK MODEM7 \
	PRO8 SOURCE THE-WORD TINKER WS33-1 WS33-2 WS33-KPR WS33
DATA= C.BASIC C.BIOS ${ZIP_DATA}
TARGET= ${PROG} C
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
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

C: C.BASIC
	${RM} -f C
	${CP} C.BASIC C

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# data files
#
data ${SUBDIR_SET}: ${DATA}
	${RM} -rf ${SUBDIR_SET}
	${UNZIP} ${ZIP_DATA}

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
	${RM} -f C
	${RM} -rf ${SUBDIR_SET}


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
