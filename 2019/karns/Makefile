#!/usr/bin/env make
#
# IOCCC 2019 winning entry - karns

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
CSILENCE= -Wno-error -Wno-implicit-function-declaration -Wno-implicit-int \
	  -Wno-incompatible-function-pointer-types \
	  -Wno-logical-op-parentheses -Wno-sign-compare \
	  -Wno-tautological-bitwise-compare -Wno-unused-label \
	  -Wno-unused-variable -Wno-strict-prototypes \
	  -Wno-builtin-declaration-mismatch -Wno-incompatible-pointer-types \
          -Wno-misleading-indentation -Wno-parentheses -Wno-unused-value

# Attempt to silence unknown warning option
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
# We disable the optimiser because the entry has problems with it enabled.
OPT= -O0

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
CSILENCE+= -Wno-conditional-uninitialized -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shadow -Wno-shorten-64-to-32 \
	   -Wno-sign-conversion -Wno-declaration-after-statement \
	   -Wno-incompatible-function-pointer-types-strict -Wno-reserved-identifier \
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
ENTRY= karns
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= maze try.sh
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=

############################
# FORCE no -O level        #
# ##########################
OPT+= -O0

#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber


# We FORCE the use of -O0 even if someone overrides it because this entry has
# problems with it enabled.
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} -O0 $< -o $@ ${LDFLAGS}
	${LN} -sf ${PROG} tbfs

test: ${PROG}
	./${PROG} < ${PROG}.c


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
	${RM} -f tbfs


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
