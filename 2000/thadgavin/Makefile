#!/usr/bin/env make
#
# IOCCC 2000 winning entry - thadgavin

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
CSILENCE= -Wno-empty-body -Wno-implicit-int -Wno-unsequenced \
	  -Wno-deprecated-non-prototype -Wno-unused-parameter \
	  -Wno-misleading-indentation -Wno-sequence-point \
	  -Wno-incompatible-pointer-types

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE}

# Compiler standard
#
CSTD= -std=gnu99

# Compiler bit architecture
#
# Some entries require 32-bitness: ARCH= -m32
# Some entries require 64-bitness: ARCH= -m64
#
ARCH=

# Variable to control amount of time to sleep between updates for alternate code.
#
SLEEP= 30
SDL_SLEEP= 150000
# Defines that are needed to compile
#
CDEFINE= -DZ=${SLEEP} -DZS=${SDL_SLEEP}

# Include files that are needed to compile
#
CINCLUDE= -include unistd.h -include stdlib.h

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS= -lncurses -lm

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-float-conversion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-strict-prototypes \
	   -Wno-extra-semi-stmt -Wno-reserved-identifier -Wno-padded \
	   -Wno-reserved-macro-identifier -Wno-unsafe-buffer-usage
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
ENTRY= thadgavin
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} ${PROG}_sdl
#
ALT_OBJ= ${PROG}.alt.o ${PROG}.alt_sdl.o
ALT_TARGET= ${PROG}.alt ${PROG}.alt_sdl


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
	@echo "WARNING: if you are sensitive to rapid movement you should probably avoid this entry."
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}_sdl: ${PROG}.c
	${CC} ${CFLAGS} -DSDL `${SDL1_CONFIG} --cflags` $< -o $@ ${LDFLAGS} `${SDL1_CONFIG} --libs`

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

${PROG}.alt_sdl: ${PROG}.alt.c
	${CC} ${CFLAGS} -DSDL `${SDL1_CONFIG} --cflags` $< -o $@ ${LDFLAGS} `${SDL1_CONFIG} --libs`


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


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'

waste:
	@echo $@

haste:
	${MAKE} waste

maker: haste
	@echo 'Participate in a maker faire'
	${MAKE} love

easter_egg: maker
	@echo "You are expected to often misunderstand this $${RANDOM} magic, Eggy!"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "p.s.: Careful with That Axe, Eugene!"

sandwich: easter_egg
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    echo "Did you forget the magic word?"; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "Planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ helps ${MAKE} the elements that help form planets"

deep_magic: supernova
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 7889066cdbdf09b0408021754586e895be641cc9be29e7eafd3ca65359541f17 \
			   --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	fi

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 20003 --mode 5717175 --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet"
	@echo "Dwarf planets are a type of planet"
	@echo "Therefore IAU, $@ is a planet"

pluto: charon
	@echo "See https://www.hou.usra.edu/meetings/lpsc2017/pdf/1448.pdf for a good definition of a planet"
	@echo "$@ is a dwarf planet"
	@echo "Dwarf planets are a type of planet"
	@echo "Therefore, $@ is a planet"
	@echo "The geophysical definition of planet gives us ~110 planets in our solar system"
