#!/usr/bin/env make
#
# IOCCC 2019 winning entry - poikola

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
CSILENCE= -Wno-dollar-in-identifier-extension -Wno-empty-body \
	  -Wno-gnu-label-as-value -Wno-sign-compare -Wno-sometimes-uninitialized \
	  -Wno-unsequenced -Wno-misleading-indentation -Wno-pedantic \
	  -Wno-sequence-point

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
# The author did not test gnu17 but did gnu11 so we set to gnu11.
CSTD= -std=gnu11

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
# We disable the optimiser because the author stated that for GCC optimiser
# level 0 gave correct output. With clang [0123s] works which suggests that
# [123s] might or might not work with GCC.
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
CSILENCE+= -Wno-comma -Wno-conditional-uninitialized -Wno-date-time \
	   -Wno-implicit-int-conversion -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shorten-64-to-32 -Wno-sign-conversion \
	   -Wno-unreachable-code -Wno-declaration-after-statement \
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
ENTRY= poikola
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= poikola.tex
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt

DOCS= poikola.tex
#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

# We disable the optimiser because the author stated that for GCC optimiser
# level 0 gave correct output. With clang [0123s] works which suggests that
# [123s] might or might not work with GCC. The author also stated that they did
# not test gnu17 but for clang and GCC gnu11 does so we also set the standard to
# gnu11.
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} -O0 -std=gnu11 $< -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# We disable the optimiser because the author stated that for GCC optimiser
# level 0 gave correct output. With clang [0123s] works which suggests that
# [123s] might or might not work with GCC. The author also stated that they did
# not test gnu17 but for clang and GCC gnu11 does so we also set the standard to
# gnu11.
${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} -O0 -std=gnu11 $< -o $@ ${LDFLAGS}

# data files
#
data: ${DATA}
	@${TRUE}

docs: ${DOCS}
	${PDFLATEX} ${DOCS}

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
	${RM} -f poikola.aux poikola.log poikola.synctex.gz


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
