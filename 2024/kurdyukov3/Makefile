#!/usr/bin/env make
#
# 2024/kurdyukov3

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
CUNKNOWN=

# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=c99

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
CINCLUDE= -I ${HOMEBREW_PREFIX}/include -I /usr/local/include -I /opt/local/include

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
LDFLAGS= -L ${HOMEBREW_PREFIX}/lib -L /usr/local/lib -lX11

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
CSILENCE+= -Wno-comma -Wno-documentation -Wno-implicit-int-conversion \
	-Wno-missing-include-dirs -Wno-poison-system-directories -Wno-shadow \
	-Wno-shorten-64-to-32 -Wno-sign-conversion
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
TARGET= ${PROG}
#
ALT_OBJ= ${PROG}.sdl.o
ALT_TARGET= ${PROG}.sdl2

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA= hello.bin loader.bin fizzbuzz.bin lzmadec.bin doom1.wad sdk.zip.lzma


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

sdk.zip: ${PROG} lzmadec.bin sdk.zip.lzma
	${RM} -f $@
	./${PROG} lzmadec.bin < sdk.zip.lzma > $@

sdk: sdk.zip
	${RM} -rf $@
	${UNZIP} sdk.zip

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.sdl2: ${PROG}.sdl.c
	${CC} ${CFLAGS} `${SDL2_CONFIG} --cflags` ${PROG}.sdl.c -o $@ ${LDFLAGS} `${SDL2_CONFIG} --libs`

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
	${RM} -f ${PROG}.sdl2
	${RM} -rf *.dSYM sdk
	${RM} -f sdk.zip


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
