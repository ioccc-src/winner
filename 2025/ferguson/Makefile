#!/usr/bin/env make
#
# 2025/ferguson

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
# This file is Copyright (c) 2026 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################

SHELL= bash

#######################
# common tool locations
#######################

include ../var.mk

#####################
# C compiler settings
#####################

# Common C compiler warnings to silence
#
# Funny fact: the reason the -Wno-tautological-constant-out-of-range-compare is
# even here is because the code challenges you to change something in the code
# to prove to yourself a truth. However depending on what you change it to it
# can trigger that warning. So I have used the Makefile to also obfuscate, or at
# least to further the lie. A more unusual thing in the IOCCC I think.
#
# Yes t he
#
CSILENCE= -Wno-poison-system-directories -Wno-unsafe-buffer-usage -Wno-overriding-deployment-version \
	-Wno-tautological-constant-out-of-range-compare -Wno-sign-compare  -Wno-sign-conversion \
	-Wno-float-conversion -Wno-issing-prototypes -Wno-missing-variable-declarations \
	-Wno-missing-prototypes -Wno-implicit-int-float-conversion -Wno-unused-parameter -Wno-comma \
	-Wno-misleading-indentation -Wno-parentheses -Wno-logical-not-parentheses

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
# Example for 32-bitness: ARCH= -m32
# Example for 64-bitness: ARCH= -m64
#
# NOTE: Normally one should NOT specify a specific architecture.
#
ARCH=

# Defines that are needed to compile
#
RED=255
GREEN=0
BLUE=0
ANTIPODE_RED=0
ANTIPODE_GREEN=255
ANTIPODE_BLUE=0
#
CDEFINE= -Dv="${RED}" -DK="${GREEN}" -DW="${BLUE}" \
	-Dw="${ANTIPODE_RED}" -Dk="${ANTIPODE_GREEN}" -Dr="${ANTIPODE_BLUE}"

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE=

# Other flags to pass to the C compiler
#
# See my remarks.md for why I disable -ffast-math.
#
COTHER= -fno-fast-math

# Optimization
#
# NOTE: Feel free to change the level of compiler optimization.
#       The "-O3" is just a friendly default you might wish to try.
#
# Example: OPT= -O0 -g
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${COTHER} ${OPT}

# Libraries needed to build
#
LDFLAGS= -lm

# C compiler to use
#
# NOTE: The IOCCC Judges recommend you leave CC as just "cc"
#       and NOT set it to clang, or gcc, or something else
#       unless you have a STRONG reason to do so.
#
#       Setting CC to something other than "cc" makes your
#       code less portable to those who do not have your
#       particular C compiler.  **hint**
#
#       If you want to test your code with a particular C compiler,
#       use the make command line.  For example:
#
#           make all CC=clang
#           make all CC=gcc
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
# NOTE: This code is only invoked when CC contains "clang"
#       such as when you use the make command lines like:
#
#           make all CC=clang
#           make all CC=clang-mp-12
#
CSILENCE+=
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
# NOTE: This code is only invoked when CC contains "gcc"
#       such as when you use the make command lines like:
#
#    make all CC=gcc
#    make all CC=gcc-15
#
CSILENCE+=
#
CWARN+=
#
endif

###########################################
# Special Makefile variables for this entry
###########################################

# what to build
#
ENTRY= prog
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

#################
# build the entry
#################

all: data ${SH_TOOLS} ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}

# simple tool to convert DMS coordinates to normal coordinates
#
dms: dms.c
	${CC} ${CFLAGS} $^ -o $@ ${LDFLAGS}

# run test script to verify things are okay (i.e. China<->Argentina map back to
# each other and are the same as the files I have included).
#
# It also runs A LONG process where it runs antipode.c (see below) for a full
# range of coordinates, one invocation per pass, and verifies that prog.c
# matches. This was important because of errors towards the end that I
# discovered.
#
test: test.sh
	./test.sh

# antipode - used by test.sh
#
antipode: antipode.c
	${CC} ${CFLAGS} $^ -o $@ ${LDFLAGS}

check: antipode
	./antipode  >antipode.log 2>&1

# code to print out variables throughout the execution of the program.
#
# Note this is a lot of output but it should show you just how much changes over
# the duration of the short run!
#
# I recommend you run it like so:
#
#	make debug && ./debug 0 0 earth.ppm out.ppm
#
# but you can provide other coordinates too to see what happens and I recommend
# doing that too. You might wish to redirect stdout to another file though like
# so:
#
#	./debug 0 0 earth.ppm out.ppm >dbg.log
#
# and then view dbg.log in a text viewer/editor.
#
debug: debug.c
	${CC} ${CFLAGS} $^ -o $@ ${LDFLAGS}

# this program demonstrates in a SIMPLE way the general idea of the arrow
# rendering except that it is not interleaved and it only shows an ASCII
# rendering of first the up arrow and then the down arrow, right below the up
# arrow.
#
# Remember that in the map (i.e. the output of prog.c based on the input of
# prog.c, both P6 PPM images with a maxval of 255 for [0..255] R,G,B values) the
# UP arrow (GREEN by default as in GO i.e. get the hell out of hell i.e. get out
# of the core of the Earth as quickly as possible!) is at the ANTIPODAL =
# DESTINATION coordinate and the DOWN arrow (RED by default - as in STOP i.e. do
# NOT GO DOWN!) is the ORIGINAL = SOURCE coordinate so in this program arrows.c
# the antipodal arrow (again, UP) is at the top and the source location is at
# the bottom (i.e. DOWN).
#
# The 'draw' flag in the array (same name as in prog.c only fewer rows) are all
# ONES and the 'don't draw' flag is all ZEROS so you can actually see the shape
# (this is possible because the map does NOT interleave the coordinates).
#
# And no - I can no longer parse the S[][7] array in prog.c, not since the
# interleaving and the way the code and coordinates were chosen. Although the
# debug.c file I wrote (which is like prog.c, almost exactly, but not formatted
# and it writes A HUGE amount of debug information) would help it would still
# take a lot of effort.
#
# Nonetheless this file is an educational file in that it shows the general idea
# of how arrows are drawn WITHOUT some complicated algorithm (though in prog.c
# it is obviously much more complicated!).
#
arrows: arrows.c
	${CC} ${CFLAGS} $^ -o $@ ${LDFLAGS}

# small.c - much smaller arrows and before obfuscation. Look at this to see why
# I had to scale the arrows up in size more (and thus potentially be off a bit
# more but again I could barely see the small arrows!) and also compare it to
# debug.c and prog.c in obfuscation.
#
# NOTE: the syntax is different here! The order of the args are opposite and
# there is only one form: in.ppm out.ppm lat lon.
#
# The colours WERE different but I think I fixed it (not configurable). THINK is
# the operative word. If I did not say this properly in the remarks it was a
# last minute change (just over 9 days left and I'm rushing to clean things up).
#
small: small.c
	${CC} ${CFLAGS} $^ -o $@ ${LDFLAGS}

# 1992/westley for try.sh
#
westley: westley.c
	${CC} -std=gnu90 -Wall -Wextra -Wno-bitwise-op-parentheses -Wno-error \
	    -Wno-implicit-function-declaration -Wno-parentheses -Wno-pedantic \
	    -Wno-deprecated-non-prototype -Wno-int-conversion -Wno-implicit-int \
	    -Wno-comma -Wno-missing-prototypes -Wno-return-type -Wno-misleading-indentation \
	    -Wno-missing-parameter-type -Wno-unknown-warning-option \
	    -O3 westley.c -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} ${PROG}.alt.c -o $@ ${LDFLAGS}


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
	${RM} -f antipode antipode.log antipodes.ppm argentina_out.ppm arrows
	${RM} -f asteroid.ppm baker.ppm botswana.ppm chicxulub.ppm china_out.ppm debug
	${RM} -f dms flat-iowa.ppm foo.ppm fun.ppm iowa.ppm island.ppm line.ppm mars.ppm
	${RM} -f mysterious_noclouds.ppm mysterious.ppm natron.ppm null.ppm out.ppm small
	${RM} -f undisclosed.ppm unformatted westley

######################################
# optional include of 1337 hacker rulz
######################################

-include ../1337.mk
