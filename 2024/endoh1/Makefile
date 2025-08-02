#!/usr/bin/env make
#
# 2024/endoh1

#############################
# shell used by this Makefile
#############################

SHELL= bash


#######################
# common tool locations
#######################

include ../../var.mk


#####################
# C compiler settings
#####################

# Common C compiler warnings to silence
#
# Example: CSILENCE= -Wno-poison-system-directories
#
CSILENCE=

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
# Example: -Dfoo -Dbar=baz
#
CDEFINE=

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE=

# Other flags to pass to the C compiler
#
# Example: COTHER= -fno-math-errno
#
COTHER=

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
# Example: LDFLAGS= -lncurses -lm
#
LDFLAGS=

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
# NOTE: This code is only invoked when CC is "clang"
#       such as when you use the make command line:
#
#           make all CC=clang
#
CSILENCE+= -Wno-poison-system-directories
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
# NOTE: This code is only invoked when CC is "gcc"
#       such as when you use the make command line:
#
#    make all CC=gcc
#
CSILENCE+=
#
CWARN+=
#
endif


###########################################
# Special Makefile variables for this entry
###########################################

ENTRY= prog
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
TARGET= ${PROG} rt.c
#
ALT_OBJ=
ALT_TARGET=

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

# default width
#
W= 32

# default height
#
H= 32


#################
# build the entry
#################

all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

# how to compile
#
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}

rt.c: ${PROG}
	${RM} -f $@
	./${PROG} > $@

%.txt: rt.c
	@${RM} -f $@
	@F="$@" ; E="$${F%%.txt}" ; \
		X="$${E##*-}" ; TX="$${X%%[!0]*}" ; X="$${X#$$TX}" ; X="$${X:-0}" ; \
		Y="$${E#*-}" ; Y="$${Y%-*}" ; TY="$${Y%%[!0]*}" ; Y="$${Y#$$TY}" ; Y="$${Y:-0}" ; \
	   echo ${CC} -E -P -DX="$$X" -DY="$$Y" -DW="${W}" -DH="${H}" rt.c ">" $@
	@F="$@" ; E="$${F%%.txt}" ; \
		X="$${E##*-}" ; TX="$${X%%[!0]*}" ; X="$${X#$$TX}" ; X="$${X:-0}" ; \
		Y="$${E#*-}" ; Y="$${Y%-*}" ; TY="$${Y%%[!0]*}" ; Y="$${Y#$$TY}" ; Y="$${Y:-0}" ; \
	   ${CC} -E -P -DX="$$X" -DY="$$Y" -DW="${W}" -DH="${H}" rt.c > $@

targets= $(shell \
	     for y in $$(${SEQ} -w 0 $$((${H}-1))); do \
		 for x in $$(${SEQ} -w 0 $$((${W}-1))); do \
		     echo "pixel/pixel-$$y-$$x.txt"; \
		 done; \
	     done)

pixel:
	${MKDIR} -p pixel

out.ppm: pixel ${targets}
	echo P3 ${W} ${H} > $@
	echo 255 >> $@
	${FIND} pixel -type f -print | LANG=C ${SORT} | ${XARGS} cat >> $@

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
	${RM} -f out.ppm

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -rf pixel 128.ppm 32.ppm 512.ppm 8.ppm


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
