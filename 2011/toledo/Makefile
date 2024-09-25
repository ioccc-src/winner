#!/usr/bin/env make
#
# IOCCC 2011 winning entry - toledo

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
CSILENCE= -Wno-bitwise-conditional-parentheses -Wno-empty-body -Wno-error \
	  -Wno-implicit-function-declaration -Wno-implicit-int \
	  -Wno-incompatible-pointer-types -Wno-int-conversion -Wno-parentheses \
	  -Wno-return-type -Wno-shift-op-parentheses -Wno-unsequenced \
	  -Wno-deprecated-non-prototype -Wno-builtin-declaration-mismatch \
	  -Wno-misleading-indentation -Wno-sequence-point

# Attempt to silence unknown warning option
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

# Variables to help simplify defining the defines
#
FIRE= XK_BackSpace:XK_Tab
FORWARD= XK_Up:XK_w
BACKWARD= XK_Down:XK_s
LEFT= XK_Left:XK_a
RIGHT= XK_Right:XK_d
WIDTH= 512
HEIGHT= 288
# Defines that are needed to compile
#
CDEFINE= -DA=${FORWARD} -DB=${LEFT} -DC=${RIGHT} -DD=${BACKWARD} \
	-DE=${FIRE} "-DQ=XFillRectangle(W,X,Y,"

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
CSILENCE+= -Wno-comma -Wno-disabled-macro-expansion -Wno-double-promotion \
	   -Wno-float-conversion -Wno-implicit-float-conversion \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-shadow -Wno-sign-conversion \
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
ENTRY= toledo
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
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

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS}  -DM=${WIDTH} -DN=${HEIGHT} $< -o $@ ${LDFLAGS}

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
