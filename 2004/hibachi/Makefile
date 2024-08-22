#!/usr/bin/env make
#
# IOCCC 2004 winning entry - hibachi

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
CSILENCE= -Wno-pointer-sign -Wno-unused-parameter \
	  -Wno-format-truncation -Wno-sign-compare -Wno-stringop-overflow

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
CSILENCE+= -Wno-format-nonliteral -Wno-implicit-int-conversion -Wno-missing-prototypes \
           -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-disabled-macro-expansion -Wno-unsafe-buffer-usage -Wno-shorten-64-to-32 \
	   -Wno-sign-conversion
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
ENTRY= hibachi
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= build/${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= build-alt/${PROG}.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

build/${PROG}: src/hibachi.c src
	${RM} -rf build
	${CP} -v -r src build
	@echo "This next step may take some time to complete:"
	cd build; CFLAGS="${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}" \
	    LDFLAGS="${LDFLAGS}" \
	    CC="${CC}" \
	    ${SHELL} ./configure
	cd build; ${MAKE}

src/hibachi.c: hibachi.c
	${CP} -f -v $? $@

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

build-alt/${PROG}.alt: src-alt/hibachi.alt.c src-alt
	${RM} -rf build-alt
	${CP} -v -r src-alt build-alt
	@echo "This next step may take some time to complete:"
	cd build-alt; CFLAGS="${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}" \
	    LDFLAGS="${LDFLAGS}" \
	    CC="${CC}" \
	    ${SHELL} ./configure
	cd build-alt; ${MAKE}

src-alt/hibachi.alt.c: hibachi.alt.c
	${CP} -f -v $? $@


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
	${RM} -f src/hibachi.c src/config.log src-alt/hibachi.c src-alt/hibachi.c
	${RM} -rf *.dSYM
	${RM} -rf build build-alt


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
