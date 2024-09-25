#!/usr/bin/env make
#
# IOCCC 2012 winning entry - endoh2

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
CSILENCE= -Wno-parentheses -Wno-empty-body -Wno-strict-prototypes \
	  -Wno-format-overflow -Wno-int-in-bool-context -Wno-misleading-indentation

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
CSILENCE+= -Wno-comma -Wno-format-nonliteral -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-float-conversion \
	   -Wno-implicit-int-conversion -Wno-extra-semi-stmt \
	   -Wno-unsafe-buffer-usage -Wno-extra-semi-stmt -Wno-unsafe-buffer-usage
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
ENTRY= endoh2
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= find-font-table.rb
TARGET= ${PROG}
#
ALT_OBJ= pi.o 314.o 3141.o 31415.o 314159.o 3141592.o \
	31415926.o 314159265.o 3141592653.o 31415926535.o \
	e.o 271.o 2718.o 27182.o 271828.o 2718281.o \
	27182818.o 271828182.o 2718281828.o 27182818284.o
ALT_TARGET= pi 314 3141 31415 314159 \
	3141592 31415926 314159265 3141592653 31415926535 \
	e 271 2718 27182 271828 \
	2718281 27182818 271828182 2718281828 27182818284

ALT_C= pi.c 314.c 3141.c 31415.c 314159.c 3141592.c \
	31415926.c 314159265.c 3141592653.c 31415926535.c \
	e.c 271.c 2718.c 27182.c 271828.c 2718281.c \
	27182818.c 271828182.c 2718281828.c 27182818284.c


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

pi.c: ${PROG}
	${RM} -f $@
	./$< > $@

pi: pi.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

314.c: pi
	${RM} -f $@
	./$< > $@

314: 314.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

3141.c: 314
	${RM} -f $@
	./$< > $@

3141: 3141.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

31415.c: 3141
	${RM} -f $@
	./$< > $@

31415: 31415.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

314159.c: 31415
	${RM} -f $@
	./$< > $@

314159: 314159.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

3141592.c: 314159
	${RM} -f $@
	./$< > $@

3141592: 3141592.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

31415926.c: 3141592
	${RM} -f $@
	./$< > $@

31415926: 31415926.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

314159265.c: 31415926
	${RM} -f $@
	./$< > $@

314159265: 314159265.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

3141592653.c: 314159265
	${RM} -f $@
	./$< > $@

3141592653: 3141592653.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

31415926535.c: 3141592653
	${RM} -f $@
	./$< > $@

31415926535: 31415926535.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# you get the transcendental idea ... :-)

e.c: ${PROG}
	${RM} -f $@
	./$< e > $@

e: e.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

271.c: e
	${RM} -f $@
	./$< > $@

271: 271.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

2718.c: 271
	${RM} -f $@
	./$< > $@

2718: 2718.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

27182.c: 2718
	${RM} -f $@
	./$< > $@

27182: 27182.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

271828.c: 27182
	${RM} -f $@
	./$< > $@

271828: 271828.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

2718281.c: 271828
	${RM} -f $@
	./$< > $@

2718281: 2718281.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

27182818.c: 2718281
	${RM} -f $@
	./$< > $@

27182818: 27182818.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

271828182.c: 27182818
	${RM} -f $@
	./$< > $@

271828182: 271828182.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

2718281828.c: 271828182
	${RM} -f $@
	./$< > $@

2718281828: 2718281828.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

27182818284.c: 2718281828
	${RM} -f $@
	./$< > $@

27182818284: 27182818284.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

271828182845.c: 27182818284
	${RM} -f $@
	./$< > $@

271828182845: 271828182845.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

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
	${RM} -f ${ALT_C}


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
