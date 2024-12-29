#!/usr/bin/env make
#
# IOCCC 2020 winning entry - ferguson1

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
CSILENCE= -Wno-unused-value -Wno-implicit-fallthrough -Wno-parentheses \
	  -Wno-binding-in-condition -Wno-comment -Wno-implicit-function-declaration \
	  -Wno-misleading-indentation

# Attempt to silence unknown warning option
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

# Defines that are needed to compile
#
CDEFINE= -D_XOPEN_SOURCE -D_POSIX_C_SOURCE -D'f(a,b)'='((a)<(b)?(a):(b))' -DWALL='COLOR_CYAN' \
	 -DHEAD='COLOR_RED' -DBODY='COLOR_GREEN' -DWB='COLOR_BLACK' -DHB='COLOR_BLACK' -DBS='COLOR_BLACK' \
	 -DBG='COLOR_WHITE' -DBB='COLOR_BLACK'

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
LDFLAGS= -lncurses

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE= -Wno-unused-value -Wno-misleading-indentation -Wno-parentheses \
	  -Wno-poison-system-directories -Wno-declaration-after-statement \
	  -Wno-padded -Wno-extra-semi-stmt -Wno-implicit-fallthrough \
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
ENTRY= ferguson1
PROG= prog
#
OBJ= ${PROG}.o
DATA= COMPILING.md HACKING.md bugs.md cake.jpg cannibalism.log.md \
	chocolate-cake.md crazy.log.md gameplay.md \
	ioccc-cake.jpg play.sh prog.2.c prog.3-j.c \
	prog.3.c snake-colours.sh snake.1 obfuscation.md \
	termcaps.c terminals.md troubleshooting.md
TARGET= ${PROG} termcaps play snake-colours
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
	@${TOUCH} sandwich

# termcaps - test utility for terminal capabilities, size etc.
termcaps: termcaps.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}


# play - allows configuring colours and playing pre-configured gameplay modes
#
play:	play.sh
	${CAT} $< > $@
	${CHMOD} a+x $@

# snake-colours - allows for configuring colours prior to compiling and playing
#
snake-colours: snake-colours.sh
	${CAT} $< > $@
	${CHMOD} a+x $@

# make test: run termcaps
#
test: termcaps
	@./termcaps

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
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
	${RM} -f ${TARGET} ${ALT_TARGET} sandwich
	${RM} -rf *.dSYM


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
