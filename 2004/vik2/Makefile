#!/usr/bin/env make
#
# IOCCC 2004 winning entry - vik2

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
CSILENCE= -Wno-strict-prototypes -Wno-implicit-function-declaration \
	  -Wno-builtin-declaration-mismatch

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
CSILENCE+= -Wno-poison-system-directories -Wno-unused-macros \
	   -Wno-reserved-macro-identifier
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
ENTRY= vik2
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
	${CC} ${CFLAGS} -DFNAME='"${PROG}.c"' '-DSTOP=_5' ${PROG}.c -o ${PROG}

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

# The original vik2 source
#
# On some systems such as Linux, this source either fails
# to finish compiling or takes a super-long time generating
# a huge number of compiler errors.  As such, we do not
# recommend compiling this code.  However for ailurophiles the
# curiosity factor, even though it may have the effect of:
#
#	kill -9 cat
#
# may be too strong to not try and compile the original
# vik2 source code.  Therefore we offer this special
# Makefile rule for those who do not wish to curtail (or cattail :-) )
# their curiosity.
#
cat-killing-curiosity: vik2.possible.cat.death.c
	@echo 'Curiosity killed the cat ...'
	${RM} -f ${PROG}.possible.cat.death_1.c
	${CC} -E '-DSTOP=_5' '-DFNAME="${PROG}.possible.cat.death_1.c"' \
	    ${PROG}.possible.cat.death.c > ${PROG}.possible.cat.death_1.c
	${RM} -f ${PROG}.possible.cat.death_2.c
	${CC} -E ${PROG}.possible.cat.death_1.c > ${PROG}.possible.cat.death_2.c
	${CC} ${CFLAGS} ${PROG}.possible.cat.death_2.c -o $@ 2>/dev/null
	@echo '... but satisfaction brought it back.  :-)'


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
vik2_clean:
	${RM} -f vik2.o

vik2_clobber: vik2_clean
	${RM} -f vik2

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f ${PROG}.possible.cat.death_1.c ${PROG}.possible.cat.death_2.c cat-killing-curiosity


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
