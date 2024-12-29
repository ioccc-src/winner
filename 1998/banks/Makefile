#!/usr/bin/env make
#
# IOCCC 1998 winning entry - banks

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
CSILENCE= -Wno-empty-body -Wno-error -Wno-implicit-function-declaration \
	  -Wno-unsequenced -Wno-incompatible-pointer-types \
	  -Wno-bitwise-instead-of-logical -Wno-strict-prototypes \
	  -Wno-implicit-int -Wno-builtin-declaration-mismatch \
	  -Wno-misleading-indentation -Wno-parentheses -Wno-return-type \
	  -Wno-sequence-point -Wno-unused-value

# Attempt to silence unknown warning option
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

# Variables that control the control keys and time step
#
IT= XK_Page_Up
DT= XK_Page_Down
UP= XK_Up
DN= XK_Down
LT= XK_Left
RT= XK_Right
CS= XK_Return
dt= 0.02

# Defines that are needed to compile
#
CDEFINE= -DIT=${IT} -DDT=${DT} \
	-DUP=${UP} -DDN=${DN} -DLT=${LT} -DRT=${RT} \
	-DCS=${CS} -Ddt=${dt}

# Include files that are needed to compile
#
CINCLUDE= -I ${X11_INCDIR} -I ${X11_INCDIR}/X11

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
CSILENCE+= -Wno-comma -Wno-float-conversion -Wno-float-equal \
	   -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-shadow -Wno-shorten-64-to-32 -Wno-unsafe-buffer-usage
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
ENTRY= banks
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= bb.sc horizon.sc mountains.sc pittsburgh.sc pyramids.sc river.sc
TARGET= ${PROG}
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

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.c
	${CC} ${CFLAGS} -UIT -UDT -DIT=XK_f -DDT=XK_d $< -o $@ ${LDFLAGS}


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
