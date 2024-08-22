#!/usr/bin/env make
#
# IOCCC 2013 winning entry - endoh2

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
CSILENCE= -Wno-strict-prototypes -Wno-misleading-indentation

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
CSILENCE+= -Wno-comma -Wno-float-conversion -Wno-implicit-int-conversion \
	   -Wno-missing-prototypes -Wno-missing-variae-declarations \
	   -Wno-poison-system-directories -Wno-shadow \
	   -Wno-missing-variable-declarations -Wno-extra-semi-stmt \
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
ENTRY= endoh2
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= ocr.rb
TARGET= ${PROG} jpeg jpeg.jpg
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
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

jpeg.c: ${PROG}
	${RM} -f $@
	./${PROG} < ${PROG}.c > $@

jpeg: jpeg.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

jpeg.jpg: jpeg
	${RM} -f $@
	@echo "This next step may take some time to complete:"
	./jpeg > $@

check: ${DATA}
	${RM} -f jpeg2.c
	@if ! type -P convert >/dev/null 2>&1; then \
	    echo "The 'convert' tool from ImageMagick could not be found." 1>&2; \
	    echo ""; 1>&2; \
	    echo "See the following website for ImageMagick:" 1>&2; \
	    echo ""; 1>&2; \
	    echo "    https://imagemagick.org/script/download.php"; 1>&2; \
	    echo ""; 1>&2; \
	    echo "or use your OS package manager to install it." 1>&2; \
	fi
	@if ! type -P ${RUBY} >/dev/null 2>&1; then \
	    echo "${RUBY} language could not be found." 1>&2; \
	    echo "${RUBY} must be installed in order to run the $@ rule." 1>&2; \
	    echo ""; 1>&2; \
	    echo "See the following website for ${RUBY}:" 1>&2; \
	    echo ""; 1>&2; \
	    echo "    https://www.ruby-lang.org/"; 1>&2; \
	    echo ""; 1>&2; \
	    echo "or use your OS package manager to install it." 1>&2; \
	    ERROR=1; \
	fi
	@if type -P ${RUBY} >/dev/null 2>&1 || ! type -P convert >/dev/null 2>&1; then \
	    exit 1; \
	fi
	${RUBY} ocr.rb jpeg.jpg > jpeg2.c
	${DIFF} jpeg.c jpeg2.c && echo Check succeeded

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
	${RM} -f jpeg.c


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
