#!/usr/bin/env make
#
# IOCCC 2019 winning entry - duble

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
CSILENCE= -Wno-bitwise-op-parentheses -Wno-dangling-else -Wno-format-security \
	  -Wno-implicit-int -Wno-incompatible-pointer-types \
	  -Wno-logical-op-parentheses -Wno-pedantic -Wno-return-type \
	  -Wno-unused-value -Wno-misleading-indentation -Wno-parentheses \
	  -Wno-sequence-point

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
CSILENCE+= -Wno-bad-function-cast -Wno-comma -Wno-implicit-int-conversion \
           -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-shadow \
           -Wno-poison-system-directories -Wno-shorten-64-to-32 -Wno-sign-conversion \
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
ENTRY= duble
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt

LINES= 24
COLUMNS= 80

OS_SET= Linux FreeBSD Darwin


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}:
	${MAKE} `${UNAME}`
	@echo "WARNING: this entry will likely leave sockets lying about in the current"
	@echo "working directory. See the bugs.md and README.md for details."

check-os: check-os.sh
	${SHELL} ./check-os.sh ${LINES} ${COLUMNS}

fullscreen: fullscreen.sh
	./$<

Darwin: ${PROG}.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=392 \
			-Ds=46 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG} ${LDFLAGS}
	${LN} ${PROG} $@

FreeBSD: ${PROG}.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=392 \
			-Ds=46 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG} ${LDFLAGS}
	${LN} ${PROG} $@

Linux: ${PROG}.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=11 \
			-Ds=0 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG} ${LDFLAGS}
	${LN} ${PROG} $@

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt:
	${MAKE} `${UNAME}`.alt

Darwin.alt: ${PROG}.alt.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=392 \
			-Ds=46 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG}.alt ${LDFLAGS}
	${LN} ${PROG}.alt $@

FreeBSD.alt: ${PROG}.alt.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=392 \
			-Ds=46 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG}.alt ${LDFLAGS}
	${LN} ${PROG}.alt $@

Linux.alt: ${PROG}.alt.c
	${RM} -f $@
	${CC} ${CFLAGS} -Dg=11 \
			-Ds=0 \
			-DV=${LINES} \
			-DW=${COLUMNS} \
			$< -o ${PROG}.alt ${LDFLAGS}
	${LN} ${PROG}.alt $@

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
	${RM} -f Darwin Darwin.alt FreeBSD FreeBSD.alt Linux Linux.alt


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
