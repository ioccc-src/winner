#!/usr/bin/env make
#
# 2024/cable1

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
CSILENCE= -Wno-deprecated-non-prototype -Wno-multichar -Wno-parentheses \
	-Wno-pointer-sign -Wno-return-type -Wno-misleading-indentation -Wno-unknown-pragmas

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

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
CDEFINE= -DM=\"model\"

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE=

# Other flags to pass to the C compiler
#
# Example: COTHER= -fno-math-errno
#
COTHER= -ffast-math -fno-math-errno -march=native

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
# NOTE: This code is only invoked when CC is "clang"
#       such as when you use the make command line:
#
#           make all CC=clang
#
CSILENCE+= -Wno-c99-compat -Wno-comma -Wno-deprecated-non-prototype \
	-Wno-dollar-in-identifier-extension -Wno-double-promotion \
	-Wno-float-conversion -Wno-implicit-float-conversion \
	-Wno-missing-prototypes -Wno-missing-variable-declarations \
	-Wno-multichar -Wno-parentheses -Wno-pedantic -Wno-pointer-sign \
	-Wno-poison-system-directories -Wno-return-type -Wno-shadow \
	-Wno-sign-conversion -Wno-source-uses-openmp -Wno-strict-prototypes \
	-Wno-enum-float-conversion -Wno-reserved-identifier \
	-Wno-unsafe-buffer-usage
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
TARGET= ${PROG} snoop eeyore linux rainman
TARGET_MP= openmp snoop_openmp eeyore_openmp linux_openmp rainman_openmp
#
ALT_OBJ=
ALT_TARGET=

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA=

# system prompts for personalities
#
SNOOP= "You are Snoop Dogg."
EEYORE= "You are Eeyore, always miserable, passive aggressive and self-deprecating."
LINUX= "You are a Linux terminal. I will type a command, and you will print its output inside a single code block."
RAINMAN= "You are the title character of the movie Rain Man."

#################
# build the entry
#################

all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

# how to compile
#
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -DS='""' -o $@ ${LDFLAGS}

all_openmp: ${TARGET_MP}

openmp: prog_openmp
	${CP} -f $? $@

prog_openmp: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -fopenmp -DS='""' -o $@ ${LDFLAGS}

snoop: ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -DS='${SNOOP}' -o $@ ${LDFLAGS}

snoop_openmp:  ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -fopenmp -DS='${SNOOP}' -o $@ ${LDFLAGS}

eeyore: ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -DS='${EEYORE}' -o $@ ${LDFLAGS}

eeyore_openmp: ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -fopenmp -DS='${EEYORE}' -o $@ ${LDFLAGS}

linux:   ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -DS='${LINUX}' -o $@ ${LDFLAGS}

linux_openmp: ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -fopenmp -DS='${LINUX}' -o $@ ${LDFLAGS}

rainman:   ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -DS='${RAINMAN}' -o $@ ${LDFLAGS}

rainman_openmp: ${PROG}.c
	 ${CC} ${CFLAGS} ${PROG}.c -fopenmp -DS='${RAINMAN}' -o $@ ${LDFLAGS}

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
	${RM} -f ${TARGET} ${ALT_TARGET} ${TARGET_MP} prog_openmp
	${RM} -rf *.dSYM


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
