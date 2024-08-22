#!/usr/bin/env make
#
# IOCCC 2012 winning entry - hamano

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
CSILENCE= -Wno-bitwise-op-parentheses -Wno-empty-body -Wno-format \
	  -Wno-format-security -Wno-gnu-zero-variadic-macro-arguments -Wno-main \
	  -Wno-parentheses -Wno-implicit-function-declaration \
	  -Wno-strict-prototypes -Wno-misleading-indentation

# Attempt to silence unknown warnings
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
CSILENCE+= -Wno-comma -Wno-double-promotion -Wno-missing-prototypes \
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
ENTRY= hamano
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
	hello hello.pdf


${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# hint.pdf rules to simplify use of 2012/hamano
#

# This rule generates the hint.pdf file which is the README.md obfuscated as a
# PDF that is NOT part of the repo:
hint.pdf: ${PROG} README.md
	./${PROG} < README.md > hint.pdf
	@echo

# This rule, hint, depends on the hint.pdf rule. That rule generates the
# hint.pdf file (NOT part of the repo) which is an obfuscated (as a PDF) version
# of the README.md. This rule, in turn, COMPILES THAT PDF FILE AS C CODE!
hint: hint.pdf
	${CC} ${CFLAGS} -xc $< -o $@


# hello.pdf rules to simplify use of 2012/hamano
#

# This rule generates the hello.pdf file which is a simple 'Hello World!'
# program obfuscated as a PDF:
hello.pdf:
	echo 'int main(){puts("Hello World!");}' | ./${PROG} > hello.pdf

# This rule, hello, depends on the hello.pdf rule. That rule generates the
# hello.pdf file (NOT part of the repo) which is an obfuscated (as a PDF) version
# of a simple 'Hello World!' program. This rule, in turn, COMPILES THAT PDF FILE
# AS C CODE to hello and then pipes it to cc to compile it to hello2 which when
# run will print 'Hello World!'.
hello: hello.pdf
	@echo
	${CC} ${CFLAGS} -xc hello.pdf -o $@
	@echo
	./hello | ${CC} ${CFLAGS} -xc - -o hello2

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
	${RM} -f ${TARGET} ${ALT_TARGET} hint.pdf hello.pdf hello hello2
	${RM} -rf *.dSYM


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
