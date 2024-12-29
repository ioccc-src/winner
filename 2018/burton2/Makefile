#!/usr/bin/env make
#
# IOCCC 2018 winning entry - burton2

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
CSILENCE= -Wno-bitwise-op-parentheses -Wno-char-subscripts -Wno-empty-body \
	  -Wno-logical-op-parentheses -Wno-parentheses -Wno-pointer-sign \
	  -Wno-misleading-indentation -Wno-unused-value \
	  -Wno-sign-compare -Wno-trigraphs

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
CDEFINE= -DW=\"keywords\" -DU=${USAGE}

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
CSILENCE+= -Wno-cast-align -Wno-comma -Wno-extra-semi -Wno-implicit-int-conversion \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-shadow -Wno-shorten-64-to-32 \
	   -Wno-sign-conversion -Wno-strict-prototypes -Wno-unsafe-buffer-usage
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
ENTRY= burton2
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= author-README.txt manpage java8 kandr kandr2 v7unix
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=

EXTRA_DATA= ansi c++11 c++14 c++98 c11 c99 discrepancies.md \
    test01.c test02.c test03.c test04.c test05.c test06.c test07.c \
    test08.c test09.c test10.c test11.c test12.c test13.c test14.c \
    iocccbug01.c iocccbug02.c iocccbug03.c iocccbug04.c iocccbug05.c \
    iocccbug06.c results results.k src.doc.txt patch tac.1 author-README.txt \
    ioc_without_quote
UTILITIES= unob.sh tokenfix.sh spotcheck.sh spotdiff.sh freqcount.sh
USAGE="\"prog [-tcksri] < file.c\ntokenize and count stdin\n\t-t\ttokens only\n\t-c\tcompatible counts\n\t-k\tkeep comments\n\t-s\tsuppress output\n\t-r\treserved words count as 1\n\t-i\tioccc count only\n\""

# this tool requires -trigraphs
#
CFLAGS+= -trigraphs


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c keywords
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

tac: tac.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}


# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA} ${EXTRA_DATA}
	@${TRUE}

# keywords: c11
keywords: ioccc.kw.freq mkkeywords.sh
	./mkkeywords.sh $< > keywords

fixed_iocccsize: fixed_iocccsize.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

test: prog tac runtest.sh fixed_iocccsize ${EXTRA_DATA}
	-./runtest.sh | diff - results
	-opt=kcrs ./runtest.sh | diff - results.k
	-opt=rs prog=./tac ./runtest.sh | diff - results
	-opt=rsk prog=tac ./runtest.sh | diff - results.k
	./fixed_iocccsize -rs < prog.c
	./tac -rs prog.c

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
	${RM} -f fixed_iocccsize tac keywords iocccsize manpage


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
