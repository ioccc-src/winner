#!/usr/bin/env make
#
# IOCCC 2013 winning entry - misaka

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
CSILENCE= -Wno-comment -Wno-empty-body -Wno-strict-prototypes \
	  -Wno-misleading-indentation

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
CSILENCE+= -Wno-documentation -Wno-format-nonliteral -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-poison-system-directories \
	   -Wno-shorten-64-to-32 -Wno-sign-conversion \
	   -Wno-unreachable-code-loop-increment -Wno-unused-macros \
	   -Wno-extra-semi-stmt -Wno-unsafe-buffer-usage
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
ENTRY= misaka
PROG= ${ENTRY}
#
OBJ= misaka.o misaka2.o misaka3.o misaka4.o misaka5.o \
        misaka6.o misaka7.o misaka8.o misaka9.o
DATA= bf.pl obfuscation.html
TARGET= ${PROG} horizontal_cat vertical_cat long_cat loong_cat \
	loooong_cat loooooooong_cat long_fat_cat \
	long_faat_cat same_as_long_cat
#
ALT_OBJ=
ALT_TARGET=

OTHER_C= misaka2.c misaka3.c misaka4.c misaka5.c \
	misaka6.c misaka7.c misaka8.c misaka9.c


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install love haste waste maker easter_egg \
	sandwich supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

horizontal_cat: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}2.c: horizontal_cat ${PROG}.c
	${RM} -f $@
	./horizontal_cat ${PROG}.c ${PROG}.c > $@

vertical_cat: ${PROG}2.c
	${CC} ${CFLAGS} ${PROG}2.c -o $@ ${LDFLAGS}

${PROG}3.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c > $@

long_cat: ${PROG}3.c
	${CC} ${CFLAGS} ${PROG}3.c -o $@ ${LDFLAGS}

${PROG}4.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c > $@

loong_cat: ${PROG}4.c
	${CC} ${CFLAGS} ${PROG}4.c -o $@ ${LDFLAGS}

${PROG}5.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c > $@

loooong_cat: ${PROG}5.c
	${CC} ${CFLAGS} ${PROG}5.c -o $@ ${LDFLAGS}

${PROG}6.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c > $@

loooooooong_cat: ${PROG}6.c
	${CC} ${CFLAGS} ${PROG}6.c -o $@ ${LDFLAGS}

${PROG}7.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c | ./horizontal_cat - - > $@

long_fat_cat: ${PROG}7.c
	${CC} ${CFLAGS} ${PROG}7.c -o $@ ${LDFLAGS}

${PROG}8.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c | ./horizontal_cat - - - > $@

long_faat_cat: ${PROG}8.c
	${CC} ${CFLAGS} ${PROG}8.c -o $@ ${LDFLAGS}

${PROG}9.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./horizontal_cat ${PROG}.c ${PROG}.c | ./vertical_cat ${PROG}.c - > $@

same_as_long_cat: ${PROG}9.c
	${CC} ${CFLAGS} ${PROG}9.c -o $@ ${LDFLAGS}

# Information on the ${PROG} programs
#
understanding: bf.pl ${PROG}.c ${OTHER_C}
	@${CHMOD} +x bf.pl
	@for c in ${PROG}.c ${OTHER_C}; do \
	    echo ./bf.pl $$c; \
	    ./bf.pl $$c; \
	done

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


#####################
# make a difference #
#####################
#
# diff orig source and source
#
diff_orig_prog: ${PROG}.orig.c ${PROG}.c
	@-${DIFF} -u ${PROG}.orig.c ${PROG}.c

# diff source and orig source
#
diff_prog_orig: ${PROG}.c ${PROG}.orig.c
	@-${DIFF} -u ${PROG}.c ${PROG}.orig.c

# diff alt source and source
#
diff_alt_prog: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.c; \
	fi

# diff source and alt source
#
diff_prog_alt: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.c ${PROG}.alt.c; \
	fi

# diff orig and alt
#
diff_orig_alt: ${PROG}.orig.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.orig.c ${PROG}.alt.c; \
	fi

# diff alt and orig
diff_alt_orig:
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.orig.c; \
	fi


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
	@-if [ -f indent.c ]; then \
	    echo ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f misaka2.c misaka3.c misaka4.c misaka5.c
	${RM} -f misaka6.c misaka7.c misaka8.c misaka9.c
	${RM} -f same_as_long_cat.txt long_cat.txt
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

install:
	@echo "Dr. Spock says that is not logical!"
	@${TRUE}

# you may be able to misunderstand the source by reading indent.c
#
indent.c: ${PROG}.c
	@if which "${GINDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${GINDENT} < $< > $@"; \
	    ${GINDENT} < $< > $@; \
	elif which "${INDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${INDENT} < $< > $@"; \
	    ${INDENT} < $< > $@; \
	else \
	    echo "no indent tool found, ident $< yourself, sorry"; \
	    echo "exit 17"; \
	    exit 17; \
	fi


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
