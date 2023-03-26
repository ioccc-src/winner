#!/usr/bin/env make
#
# IOCCC 2013 winning entry - misaka

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

# Common C compiler warnings to silence
#
#CSILENCE=
CSILENCE= -Wno-comment -Wno-empty-body

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
CSILENCE+= -Wno-documentation -Wno-format-nonliteral -Wno-missing-prototypes \
	-Wno-missing-variable-declarations -Wno-poison-system-directories \
	-Wno-shorten-64-to-32 -Wno-sign-conversion \
	-Wno-unreachable-code-loop-increment -Wno-unused-macros
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
ENTRY= misaka
PROG= ${ENTRY}
#
OBJ= misaka.o misaka2.o misaka3.o misaka4.o misaka5.o \
        misaka6.o misaka7.o misaka8.o misaka9.o
DATA= bf.pl spoiler.html
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

.PHONY: all alt data everything clean clobber install \
	love haste waste maker easter_egg sandwich \
	supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

horizontal_cat: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

${PROG}2.c: horizontal_cat ${PROG}.c
	${RM} -f $@
	./horizontal_cat ${PROG}.c ${PROG}.c > $@

vertical_cat: ${PROG}2.c
	${CC} ${CFLAGS} ${PROG}2.c -o $@ ${LIBS}

${PROG}3.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c > $@

long_cat: ${PROG}3.c
	${CC} ${CFLAGS} ${PROG}3.c -o $@ ${LIBS}

${PROG}4.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c > $@

loong_cat: ${PROG}4.c
	${CC} ${CFLAGS} ${PROG}4.c -o $@ ${LIBS}

${PROG}5.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c > $@

loooong_cat: ${PROG}5.c
	${CC} ${CFLAGS} ${PROG}5.c -o $@ ${LIBS}

${PROG}6.c: vertical_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c ${PROG}.c > $@

loooooooong_cat: ${PROG}6.c
	${CC} ${CFLAGS} ${PROG}6.c -o $@ ${LIBS}

${PROG}7.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c | ./horizontal_cat - - > $@

long_fat_cat: ${PROG}7.c
	${CC} ${CFLAGS} ${PROG}7.c -o $@ ${LIBS}

${PROG}8.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./vertical_cat ${PROG}.c ${PROG}.c | ./horizontal_cat - - - > $@

long_faat_cat: ${PROG}8.c
	${CC} ${CFLAGS} ${PROG}8.c -o $@ ${LIBS}

${PROG}9.c: vertical_cat horizontal_cat ${PROG}.c
	${RM} -f $@
	./horizontal_cat ${PROG}.c ${PROG}.c | ./vertical_cat ${PROG}.c - > $@

same_as_long_cat: ${PROG}9.c
	${CC} ${CFLAGS} ${PROG}9.c -o $@ ${LIBS}

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
