#!/usr/bin/env make
#
# IOCCC 2012 winning entry - endoh2

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be the liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes for VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC winners:
#
#	http://www.ioccc.org/bugs.md
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms this license:
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

# Set X11_LIBDIR to the directory where the X11 library resides
#
#X11_LIBDIR= /usr/X11R6/lib
#X11_LIBDIR= /usr/X11/lib
X11_LIBDIR= /opt/X11/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
#X11_INCDIR= /usr/X11R6/include
#X11_INCDIR= /usr/X11/include
X11_INCDIR= /opt/X11/include

# Common C compiler warnings to silence
#
#CSILENCE=
CSILENCE= -Wno-parentheses -Wno-empty-body

# Common C compiler warning flags
#
#CWARN= ${CSILENCE}
#CWARN= -Wall ${CSILENCE}
#CWARN= -Wall -Wextra ${CSILENCE}
CWARN= -Wall -Wextra -pedantic ${CSILENCE}

# Compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=gnu11

# Compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitness:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=
#CDEFINE= -DIOCCC

# Include files that are needed to compile
#
CINCLUDE=
#CINCLUDE= -include stdlib.h
#CINCLUDE= -include stdio.h
#CINCLUDE= -include stdlib.h -include stdio.h
#CINCLUDE= -I ${X11_INCDIR} -I ${X11_INCDIR}/X11
#CINCLUDE= `${SDL2_CONFIG} --cflags`

# Optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
# Reasonable compilers will allow for -O3.
#
#OPT=
#OPT= -O
#OPT= -O1
#OPT= -O2
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=
#LIBS= -lm
#LIBS= -L ${X11_LIBDIR} -lX11
#LIBS= `${SDL2_CONFIG} --libs`

# C compiler to use
#
CC= cc
#CC=clang
#CC=gcc

# Compiler add-ons or replacements for clang only
#
ifeq ($(CC),clang)
#
CSILENCE+= -Wno-comma -Wno-format-nonliteral -Wno-missing-variable-declarations \
	-Wno-poison-system-directories
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq ($(CC),gcc)
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special flags for this entry
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

.PHONY: all alt data everything clean clobber install \
	love haste waste maker easter_egg sandwich \
	supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

pi.c: ${PROG}
	${RM} -f $@
	./$< > $@

pi: pi.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

314.c: pi
	${RM} -f $@
	./$< > $@

314: 314.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

3141.c: 314
	${RM} -f $@
	./$< > $@

3141: 3141.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

31415.c: 3141
	${RM} -f $@
	./$< > $@

31415: 31415.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

314159.c: 31415
	${RM} -f $@
	./$< > $@

314159: 314159.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

3141592.c: 314159
	${RM} -f $@
	./$< > $@

3141592: 3141592.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

31415926.c: 3141592
	${RM} -f $@
	./$< > $@

31415926: 31415926.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

314159265.c: 31415926
	${RM} -f $@
	./$< > $@

314159265: 314159265.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

3141592653.c: 314159265
	${RM} -f $@
	./$< > $@

3141592653: 3141592653.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

31415926535.c: 3141592653
	${RM} -f $@
	./$< > $@

31415926535: 31415926535.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

# you get the transcendental idea ... :-)

e.c: ${PROG}
	${RM} -f $@
	./$< e > $@

e: e.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

271.c: e
	${RM} -f $@
	./$< > $@

271: 271.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

2718.c: 271
	${RM} -f $@
	./$< > $@

2718: 2718.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

27182.c: 2718
	${RM} -f $@
	./$< > $@

27182: 27182.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

271828.c: 27182
	${RM} -f $@
	./$< > $@

271828: 271828.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

2718281.c: 271828
	${RM} -f $@
	./$< > $@

2718281: 2718281.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

27182818.c: 2718281
	${RM} -f $@
	./$< > $@

27182818: 27182818.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

271828182.c: 27182818
	${RM} -f $@
	./$< > $@

271828182: 271828182.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

2718281828.c: 271828182
	${RM} -f $@
	./$< > $@

2718281828: 2718281828.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

27182818284.c: 2718281828
	${RM} -f $@
	./$< > $@

27182818284: 27182818284.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

271828182845.c: 27182818284
	${RM} -f $@
	./$< > $@

271828182845: 271828182845.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

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
	${RM} -f ${ALT_C}
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
	    echo "no intent tool found, ident $< yourself, sorry"; \
	    echo "exit 1"; \
	    exit 1; \
	fi


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'
	@${TRUE}

haste:
	$(MAKE) waste
	@${TRUE}

waste:
	@echo 'haste'
	@${TRUE}

maker:
	@echo 'Participate in a maker faire'
	@${TRUE}

easter_egg:
	@echo "you expected to often misunderstand this $${RANDOM} magic"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "Eggy"

sandwich: easter_egg
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    exit 1; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ helps ${MAKE} the elements that help form planets"
	@${TRUE}

deep_magic: supernova
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 7889066cdbdf09b0408021754586e895be641cc9be29e7eafd3ca65359541f17 \
	    		   --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 20003 --mode 5717175 --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore IAU, $@ is a planet"

pluto: charon
	${MAKE} charon
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore, $@ is a planet"
	@echo "having lots of planets is good feature because supernovae can help ${MAKE} a lot of them"
