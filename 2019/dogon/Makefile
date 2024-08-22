#!/usr/bin/env make
#
# IOCCC 2019 winning entry - dogon

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
	  -Wno-deprecated-declarations -Wno-format -Wno-parentheses \
	  -Wno-shift-op-parentheses -Wno-sign-compare -Wno-unused-variable \
	  -Wno-main-return-type -Wno-return-type -Wno-unused-parameter \
	  -Wno-strict-prototypes -Wno-implicit-function-declaration \
	  -Wno-main -Wno-maybe-uninitialized -Wno-misleading-indentation \
          -Wno-shift-negative-value

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

# Variable to simplify changing memory usage
#
MEMORY= 0x20000000

# Defines that are needed to compile
#
CDEFINE= -DX=1280l -DY=1024l -DZ=${MEMORY}

# Include files that are needed to compile
#
CINCLUDE= -include stdio.h -I ${X11_INCDIR} -I ${X11_INCDIR}/X11

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS= -L ${X11_LIBDIR} -lX11 -lm

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-cast-align -Wno-comma -Wno-conditional-uninitialized \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shadow -Wno-shorten-64-to-32 \
	   -Wno-sign-conversion -Wno-missing-noreturn -Wno-declaration-after-statement \
	   -Wno-extra-semi-stmt -Wno-implicit-int-float-conversion \
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
ENTRY= dogon
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= glider.mc gotts-dots.mc infinite.mc infinite_10cell.mc infinite_5x5.mc \
	infinite_minimal.mc jagged.mc message.mc metacatacryst.mc \
	metapixel-parity64.mc mosquito5.mc unlimited-novelty.mc
TARGET= ${PROG} apholife
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

apholife: apholife.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

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
