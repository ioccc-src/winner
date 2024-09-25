#!/usr/bin/env make
#
# IOCCC 1988 winning entry - applin

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC entries:
#
#	http://www.ioccc.org/bugs.html
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
CSILENCE= -Wno-expansion-to-defined -Wno-implicit-int -Wno-strict-prototypes \
	  -Wno-gnu-line-marker -Wno-return-type

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu89

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
CSILENCE+= -Wno-poison-system-directories -Wno-gnu-line-marker
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
ENTRY= applin
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ= applin.alt.o
ALT_TARGET= applin.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber install

# Way back in 1988 ..
#
# This entry took 75 minutes to compile on a Amdahl 5980-300E
# (a 55658 Dhyrstone/sec/cpu machine) using the System V cpp.
# (The GNU cpp when defined as BIG_CPP took only 45 seconds.)
# Your cpp may not be able to compile it due to a common bug
# that results in cpp running out of space.  The routine
# 'zsmall' is a smaller version of the applin.c entry.
#
${PROG}: ${PROG}.c
	${RM} -f large.c
	${CPP} '-DM=#include "large.c"' '-DR=#include' '-DF=#if' \
	    '-DI=#ifdef' '-DL=#else' '-DE=#endif' '-DN=#ifndef' \
	    '-DD=#define' '-DU=#undef' ${PROG}.c > large.c
	${CC} ${CFLAGS} large.c -o $@

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${ALT_TARGET}: ${PROG}.alt.c
	${CP} -f ${PROG}.alt.c zsmall.c
	${CC} ${CFLAGS} zsmall.c -o $@

# not an official entry
#
# The 'zsmall.c' program was obtained from 'applin.c' by reducing its recursion
# and running it through the initial /lib/cpp.  That is, 'zsmall.c' is a small
# version of the 'large.c' file as produced by the 'applin' make rule above.
zsmall: zsmall.c
	${CC} ${CFLAGS} zsmall.c -o $@

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
	${RM} -f large.o

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM zsmall.c
	${RM} -f large.c


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
