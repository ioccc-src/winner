#!/usr/bin/env make
#
# IOCCC 2000 winning entry - thadgavin

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
CSILENCE= -Wno-empty-body -Wno-implicit-int -Wno-unsequenced \
	  -Wno-deprecated-non-prototype -Wno-unused-parameter \
	  -Wno-misleading-indentation -Wno-sequence-point \
	  -Wno-incompatible-pointer-types

# Attempt to silence unknown warning option
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

# Variable to control amount of time to sleep between updates for alternate code.
#
SLEEP= 30
SDL_SLEEP= 150000
# Defines that are needed to compile
#
CDEFINE= -DZ=${SLEEP} -DZS=${SDL_SLEEP}

# Include files that are needed to compile
#
CINCLUDE= -include unistd.h -include stdlib.h

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS= -lncurses -lm

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-float-conversion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-strict-prototypes \
	   -Wno-extra-semi-stmt -Wno-reserved-identifier -Wno-padded \
	   -Wno-reserved-macro-identifier -Wno-unsafe-buffer-usage
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
ENTRY= thadgavin
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} ${PROG}_sdl
#
ALT_OBJ= ${PROG}.alt.o ${PROG}.alt_sdl.o
ALT_TARGET= ${PROG}.alt ${PROG}.alt_sdl


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	@echo "WARNING: if you are sensitive to rapid movement you should probably avoid this entry."
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}_sdl: ${PROG}.c
	${CC} ${CFLAGS} -DSDL `${SDL1_CONFIG} --cflags` $< -o $@ ${LDFLAGS} `${SDL1_CONFIG} --libs`

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}.alt_sdl: ${PROG}.alt.c
	${CC} ${CFLAGS} -DSDL `${SDL1_CONFIG} --cflags` $< -o $@ ${LDFLAGS} `${SDL1_CONFIG} --libs`


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
