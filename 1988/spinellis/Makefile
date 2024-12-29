#!/usr/bin/env make
#
# IOCCC 1988 winning entry - spinellis

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
CSILENCE= -Wno-everything

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
CSILENCE+=
#
CWARN+=
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
CSILENCE+= -w
#
CWARN+=
#
endif


##############################
# Special Makefile variables for this entry
##############################
#
ENTRY= spinellis
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= input.txt input2.txt
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

${PROG}: ${PROG}.c input.txt
	@${RM} -f $@
	@echo
	@echo "Hello, world!  To compile this IOCCC winner, we need you to take charge."
	@echo
	@echo "IMPORTANT NOTE: this entry is likely to NOT compile with some compilers"
	@echo "like clang, NOR will it likely compile under macOS. In particular the"
	@echo "the compiler must accept reading in input from /dev/tty. Where this is"
	@echo "not possible, try this instead: "
	@echo
	@echo "    make clobber alt"
	@echo
	@echo "For hosts with a true gcc compiler, manually run the following command:"
	@echo
	@echo "    ${GCC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}"
	@echo
	@echo "Next copy and paste (on a non-macOS host/host with true gcc)"
	@echo "the folowwing as input to the above command:"
	@echo
	@${CAT} input.txt
	@echo
	@echo "After pasing the above, end input by providing an EOF (usually control-D)."
	@echo
	@echo "Finally run the program you have just compiled:"
	@echo
	@echo "    ./$@"
	@echo
	@echo "Of course you may provide other C code if you wish, even typing it manually."
	@echo

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c input.txt
	@${RM} -f $@ runme
	${CC} ${CFLAGS} ${PROG}.alt.c -o $@ ${LDFLAGS}
	@echo
	@echo "Hello, world!  To compile this IOCCC winner, we need you to take charge."
	@echo
	@echo "Run the following command:"
	@echo
	@echo "   ./$@"
	@echo
	@echo "Next copy and paste the folowwing as input to the above command:"
	@echo
	@${CAT} input.txt
	@echo
	@echo "After pasing the above, end input by providing an EOF (usually control-D)."
	@echo
	@echo "Finally run the program you have just compiled:"
	@echo
	@echo "    ./$@"
	@echo
	@echo "Of course you may provide other C code if you wish, even typing it manually."
	@echo

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
