#!/usr/bin/env make
#
# IOCCC 1992 winning entry - adrian

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
CSILENCE= -Wno-bitwise-op-parentheses -Wno-comment -Wno-deprecated-declarations \
	  -Wno-error -Wno-implicit-function-declaration -Wno-format-security \
	  -Wno-logical-op-parentheses -Wno-macro-redefined -Wno-parentheses \
	  -Wno-return-type -Wno-uninitialized -Wno-unused-value -Wno-unused-variable \
	  -Wno-unused-but-set-variable -Wno-unsequenced -Wno-unused-parameter \
	  -Wno-empty-translation-unit -Wno-implicit-int \
	  -Wno-builtin-declaration-mismatch -Wno-sequence-point

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu90

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
CSILENCE+= -Wno-comma -Wno-float-conversion -Wno-missing-noreturn \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-padded \
	   -Wno-poison-system-directories -Wno-shadow -Wno-unreachable-code \
	   -Wno-unused-macros -Wno-shorten-64-to-32 -Wno-sign-conversion \
	   -Wno-empty-translation-unit -Wno-extra-semi-stmt -Wno-misleading-indentation \
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
ENTRY= adrian
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} adgrep
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
	${RM} -f ad.temp adwc.c adbasename.c adecho.c adhead.c adsleep.c
	${SED} '1s/\..*\./. wc ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adwc.c
	${CC} ${CFLAGS} -o adwc adwc.c
	${SED} '1s/\..*\./. basename ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adbasename.c
	${CC} ${CFLAGS} -o adbasename adbasename.c
	${SED} '1s/\..*\./. echo| ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adecho.c
	${CC} ${CFLAGS} -o adecho adecho.c
	${SED} '1s/\..*\./. head; ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adhead.c
	${CC} ${CFLAGS} -o adhead adhead.c
	${SED} '1s/\..*\./. sleep ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adsleep.c
	${CC} ${CFLAGS} -o adsleep adsleep.c
	${RM} -f ad.temp

adgrep: ${PROG}
	${RM} -f $@
	${LN} $< $@

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
	${RM} -f adbasename adbasename.c adecho adecho.c adgrep adhead
	${RM} -f adhead.c adrian adsleep adsleep.c adwc adwc.c
	${RM} -f ad.alt.temp adwc.alt.c


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
