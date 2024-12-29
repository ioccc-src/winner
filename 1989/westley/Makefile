#!/usr/bin/env make
#
# IOCCC 1989 winning entry - westley

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
CSILENCE= -Wno-comment -Wno-error -Wno-implicit-function-declaration \
	  -Wno-logical-op-parentheses -Wno-deprecated-non-prototype \
	  -Wno-int-conversion -Wno-return-type -Wno-parentheses \
	  -Wno-comma -Wno-missing-variable-declarations -Wno-unused-value \
	  -Wno-implicit-int -Wno-missing-parameter-type -Wno-pointer-to-int-cast \
	  -Wno-conditional-type-mismatch -Wno-non-literal-null-conversion

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
CDEFINE= -Dtrgpune=putchar -Dpune=char -Dvag=int -Dznva=main

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
CSILENCE+= -Wno-missing-prototypes -Wno-pedantic -Wno-poison-system-directories \
	   -Wno-strict-prototypes -Wno-unsafe-buffer-usage
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
ENTRY= westley
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG}
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

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

ver0: ${PROG}
	-./${PROG} < westley.c > ver0.c
	-${CC} ${CFLAGS} ver0.c -o $@ ${LDFLAGS}

ver1: ${PROG}
	-./${PROG} 1 < westley.c > ver1.c
	-${CC} ${CFLAGS} ver1.c -o $@ ${LDFLAGS}

ver2: ${PROG}
	-./${PROG} 1 2 < westley.c > ver2.c
	@echo "** NOTE: this version will not compile with clang **"
	-${CC} ${CFLAGS} -Uznva ver2.c -o $@ ${LDFLAGS}

ver3: ${PROG}
	-./${PROG} 1 2 3 < westley.c > ver3.c
	@echo "** NOTE: this version will not compile with clang **"
	-${CC} ${CFLAGS} -Uznva ver3.c -o $@ ${LDFLAGS}


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
	${RM} -f ver0.c ver1.c ver2.c ver3.c


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
