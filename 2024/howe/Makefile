#!/usr/bin/env make
#
# 2024/howe

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
# -Wno-char-subscripts			ctypes macros
# -Wno-incompatible-pointer-types	atexit(endwin)
# -Wno-unused-parameter			main(int argc, ...)
#
# -Wno-strict-prototypes		functions no arguments
# -Wno-missing-prototypes		clang functiosn without static
# -Wno-missing-variable-declarations	clang globals without static
# -Wno-tentative-definition-array	clang array definitions
#
CSILENCE= -Wno-strict-prototypes -Wno-pointer-sign

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
# Frack need extra #define to enable SUS standard strdup(), strndup().
#
CDEFINE= -DBUF=${BUF} -DMODE=${MODE} -D_XOPEN_SOURCE=700

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE= -include curses.h -include ctype.h -include string.h \
          -include stdlib.h -include iso646.h -include regex.h \
          -include fcntl.h -include locale.h -include unistd.h

# Other flags to pass to the C compiler
#
# Example: COTHER= -fno-math-errno
#
COTHER= -funsigned-char

# Optimization
#
# NOTE: Feel free to change the level of compiler optimization.
#       The "-O3" is just a friendly default you might wish to try.
#
# Example: OPT= -O0 -g
#
OPT= -Os

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${COTHER} ${OPT}

# Libraries needed to build
#
LDFLAGS= -lcurses

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
CSILENCE+= -Wno-c99-compat -Wno-comma \
	-Wno-declaration-after-statement -Wno-implicit-int-conversion \
	-Wno-incompatible-function-pointer-types-strict -Wno-missing-prototypes \
	-Wno-missing-variable-declarations -Wno-poison-system-directories \
	-Wno-shadow -Wno-sign-conversion -Wno-strict-prototypes -Wno-unsafe-buffer-usage
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
TARGET= ${PROG} eh
#
ALT_OBJ=
ALT_TARGET=

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

# Buffer size 128KB
#
BUF= 131072

# File creation mode
#
MODE= 0600


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

eh: ${PROG}
	${RM} -f $@
	${CP} -f -v ${PROG} $@

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


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
