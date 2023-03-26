#!/usr/bin/env make
#
# IOCCC 2015 winning entry - mills1

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
CSILENCE= -Wno-error -Wno-implicit-function-declaration -Wno-parentheses

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
#CDEFINE=
CDEFINE= -DU=${DU} -DD=${DD} -DW=${DW} -DH=${DH} -DA=${DA} -DI=${DI} \
         -DB=${DB} -DF=${DF} -DG=${DG}

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
#LIBS=
LIBS= -lncurses
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
CSILENCE+= -Wno-missing-variable-declarations -Wno-poison-system-directories
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
ENTRY= mills1
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=

# Game parameters
#
DU=99999	# Time between steps in microseconds.
		# Make it larger if the game is too fast for you.

DW=28		# Pipe-to-pipe spacing, in columns.
		# Farther apart is easier.

DD=20		# Space between pipes.
		# The difference between DD and DW is the width of a pipe.
		# Narrow pipes are easier to fly though.

DH=8		# Height of gap in pipe.
		# Make this larger to make the game easier.

DA=100		# Acceleration due to gravity (scaled by 256).
		# Smaller values make you glide slower.

DI=-200		# Impulse velocity of a flap (scaled by 256).
		# Make larger if you want an less intense tapping experience!

DB='"<o^="'	# Sprite for player when gliding.
		# HINT: Try using various emoji.
		# NOTE: The string MUST be enclosed inside double quotes.

DF='"<ov="'	# Sprite for player when flapping.
		# HINT: Try using various emoji.
		# NOTE: The string MUST be enclosed inside double quotes.

DG='"Tap to Flap!"'	# Instruction text.
			# Change to your native tongue.
		# NOTE: The string MUST be enclosed inside double quotes.

# Here's some fun makefile overrides to try.  Pass them in by adding to the
# make commandline, eg
#
#  make EMOJI=beer LANGUAGE=spanish
#
# Note that use of the EMOJI path may require different include and linker
# options depending on how your system is set up.  The basic requirements is
# a copy of ncurses that that supports "wide" characters.  That could be
# called -lcurses, -lncurses or -lncurses, depending on how it was installed.
# it also might have been installed in a subdirectory and needs to be found
# with a different include and/or library path.
#

ifdef EMOJI
  # You may need to uncomment some of these, depending on your system
  # LIBS= -lncursesw
  # CINCLUDE= -I/usr/local/include/ncursesw

  ifeq ($(EMOJI),beer)
    DB='"\xf0\x9f\x8d\xba"'
    DF='"\xf0\x9f\x8d\xbb"'
  endif
  ifeq ($(EMOJI),smile)
    DB='"\xf0\x9f\x98\x84"'
    DF='"\xf0\x9f\x98\x81"'
  endif
  ifeq ($(EMOJI),bipolar)
    DB='"\xf0\x9f\x98\xa8"'
    DF='"\xf0\x9f\x98\xa1"'
  endif
  ifeq ($(EMOJI),toilet)
    DB='"\xf0\x9f\x9a\xbd"'
    DF='"\xf0\x9f\x92\xa6"'
  endif
  ifeq ($(EMOJI),ET)
    DB='"\xf0\x9f\x9a\xb4"'
    DF='"\xf0\x9f\x91\xbd"'
  endif
  ifeq ($(EMOJI),rocket)
    DB='"\xf0\x9f\x9a\x80"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),frylock)
    DB='"\xf0\x9f\x8d\x9f"'
    DF='"\xf0\x9f\x8e\x89"'
  endif
  ifeq ($(EMOJI),meatwad)
    DB='"\xf0\x9f\x8d\x98"'
    DF='"\xf0\x9f\x8d\x96"'
  endif
  ifeq ($(EMOJI),chicken)
    DB='"\xf0\x9f\x90\x93"'
    DF='"\xf0\x9f\x92\xa8"'
  endif
  ifeq ($(EMOJI),chick)
    DB='"\xf0\x9f\x90\xa4"'
    DF='"\xf0\x9f\x90\xa5"'
  endif
  ifeq ($(EMOJI),finger)
    DB='"\xf0\x9f\x91\x88"'
    DF='"\xf0\x9f\x91\x86"'
  endif
  ifeq ($(EMOJI),heart)
    DB='"\xf0\x9f\x92\x93"'
    DF='"\xf0\x9f\x92\x97"'
  endif
  ifeq ($(EMOJI),poop)
    DB='"\xf0\x9f\x92\xa9"'
    DF='"\xf0\x9f\x92\xa8"'
  endif
  ifeq ($(EMOJI),money)
    DB='"\xf0\x9f\x92\xb5"'
    DF='"\xf0\x9f\x92\xb8"'
  endif
  ifeq ($(EMOJI),book)
    DB='"\xf0\x9f\x93\x98"'
    DF='"\xf0\x9f\x93\x96"'
  endif
  ifeq ($(EMOJI),megaphone)
    DB='"\xf0\x9f\x93\xa2"'
    DF='"\xf0\x9f\x93\xa3"'
  endif
  ifeq ($(EMOJI),mailbox)
    DB='"\xf0\x9f\x93\xaa"'
    DF='"\xf0\x9f\x93\xab"'
  endif
  ifeq ($(EMOJI),lock)
    DB='"\xf0\x9f\x94\x92"'
    DF='"\xf0\x9f\x94\x93"'
  endif
  ifeq ($(EMOJI),fire)
    DB='"\xf0\x9f\x94\xa5"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),bomb)
    DB='"\xf0\x9f\x92\xa3"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),gun)
    DB='"\xf0\x9f\x94\xab"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),knife)
    DB='"\xf0\x9f\x94\xaa"'
    DF='"\xf0\x9f\x92\xab"'
  endif
  ifeq ($(EMOJI),globe)
    DB='"\xf0\x9f\x8c\x8d"'
    DF='"\xf0\x9f\x8c\x8e"'
  endif


  # add some magic to call setlocale
  CFLAGS += -include locale.h \
	-Dmain='__attribute__((constructor))Z(){return!setlocale(LC_ALL,"");}int main'
endif

ifdef LANGUAGE

  ifeq ($(LANGUAGE),spanish)
    DG='"\xc2\xa1Pulse para batir!"'
  endif
  ifeq ($(LANGUAGE),french)
    DG='"Appuyez \xc3\xa0 battre"'
  endif

endif


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
