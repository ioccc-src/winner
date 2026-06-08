#!/usr/bin/env make
#
# 2025/ayu

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
CSILENCE= -Wno-parentheses -Wno-char-subscripts

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=c99

# Compiler bit architecture
#
# Example for 32-bitness: ARCH= -m32
# Example for 64-bitness: ARCH= -m64
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
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+=
#
# CWARN+= -Weverything \
#   -Wno-unsafe-buffer-usage -Wno-missing-variable-declarations -Wno-missing-prototypes \
#   -Wno-comma -Wno-shadow -Wno-sign-conversion -Wno-implicit-int-conversion
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

ENTRY= prog
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

# shell scripts
#
SH_TOOLS= try.sh try.alt.sh

#################
# build the entry
#################

all: data ${SH_TOOLS} ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -DN=11 -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.alt.c -DN=15 -o $@ ${LDFLAGS}

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt
	@${TRUE}

# NOTE(author): Additional fuzz target
#
fuzz: ${PROG}.c fuzz.c
	${CC} ${CFLAGS} fuzz.c -o $@ -g -fsanitize=fuzzer,address,undefined

# NOTE(author): Additional arduino-sketch target
#
arduino-sketch: ${PROG}.c
	${CP} -f $< arduino/serial_play/prog.h

.PHONY: arduino-sketch

###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ} fuzz.o

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET} fuzz
	${RM} -rf *.dSYM
	${RM} -f arduino/serial_play/prog.h

######################################
# optional include of 1337 hacker rulz
######################################

-include ../1337.mk
