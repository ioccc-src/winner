#!/usr/bin/env make
#
# IOCCC 2015 winning entry - muth

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
CSILENCE= -Wno-keyword-macro -Wno-strict-prototypes -Wno-builtin-declaration-mismatch

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
CDEFINE= -DX="$(X)" -DV="$(V)"

# Include files that are needed to compile
#
CINCLUDE= -include "${MACHINE}" -include "${TAPE}"

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
CSILENCE+= -Wno-poison-system-directories -Wno-unused-macros
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
ENTRY= muth
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=

# entry specific variables
#
MACHINE= machine_beaver_4_2.h
TAPE= tape_empty.h

MACHINE_SET= machine_beaver_4_2.h machine_champ_2_4.h machine_chaos_5_2.h \
	machine_cmplx_5_2.h machine_count_5_2.h machine_gcd.h machine_great_3_2.h \
	machine_ioccc.h machine_nop.h machine_ru_2_4.h machine_times2.h

TAPE_SET= tape_15_50.h tape_77_55.h tape_empty.h tape_five.h

#################
# build the entry
#################
#
all: data ${TARGET} ${MACHINE_SET} ${TAPE_SET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# test the entry
#
.PHONY: run
run: ${PROG}
	./${PROG} | ${TR} -d '~'
	[ -z "${V}" ] || [ "${V}" -lt 1 ] || { echo "total:" $$(./${PROG} | ${TR} -dc '~' | wc -c) "steps"; }
	[ -z "${V}" ] || [ "${V}" -lt 2 ] || { ./${PROG} | ${GREP} '^~' | ${CUT} -f2 | ${SORT} | ${UNIQ} -c; }

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
	${RM} -rf *.dSYM


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
