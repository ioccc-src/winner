#!/usr/bin/env make
#
# IOCCC 2015 winning entry - mills1

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
CSILENCE= -Wno-error -Wno-implicit-function-declaration -Wno-parentheses \
	  -Wno-strict-prototypes -Wno-misleading-indentation

# Attempt to silence unknown warning option
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
CDEFINE= -DU=${DU} -DD=${DD} -DW=${DW} -DH=${DH} -DA=${DA} -DI=${DI} \
         -DB=${DB} -DF=${DF} -DG=${DG}

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
CSILENCE+= -Wno-missing-variable-declarations -Wno-poison-system-directories
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
		# Make larger if you want a less intense tapping experience!

DB='"<o^="'	# Sprite for player when gliding.
		# HINT: Try using various emojis.
		# NOTE: The string MUST be enclosed inside double quotes.

DF='"<ov="'	# Sprite for player when flapping.
		# HINT: Try using various emojis.
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
  # LDFLAGS= -lncursesw
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

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

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


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
