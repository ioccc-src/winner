#!/usr/bin/env make
#
# 2024/burton

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
CSILENCE= -Wno-misleading-indentation -Wno-parentheses -Wno-unused-value

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
CDEFINE= -D_FORTIFY_SOURCE=0

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
CSILENCE+= -Wno-array-bounds-pointer-arithmetic -Wno-comma \
	-Wno-declaration-after-statement -Wno-format-nonliteral \
	-Wno-implicit-int-conversion -Wno-missing-prototypes \
	-Wno-missing-variable-declarations -Wno-poison-system-directories \
	-Wno-shadow -Wno-shorten-64-to-32 -Wno-vla -Wno-extra-semi-stmt \
	-Wno-misleading-indentation -Wno-unsafe-buffer-usage
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
TARGET= ${PROG} ${TOOLS}
#
ALT_OBJ=
ALT_TARGET=

# list any data files supplied with your submission
#
# Example: DATA= curds whey
#
DATA= dict test.abode test.light test.jaunt correct.test.abode \
      correct.test.jaunt correct.test.light r.blast r.crate r.query r.terns

# utility scripts
#
SCRIPTS= avg comp.avg exhaust extra_guesses freq mkresults rank wavg word.result worst wrank
TOOLS= gen dups run reveal usdw
IOCCCSIZE= iocccsize
DICTIONARY= /usr/share/dict/words


#################
# build the entry
#################

all: data ${TARGET} ${SCRIPTS} ${TOOLS}
	@${TRUE}

.PHONY: all alt data everything clean clobber

# how to compile
#
${PROG}: ${PROG}.c
	${CC} ${CFLAGS} ${PROG}.c -o $@ ${LDFLAGS}

define stest
	echo -n "$(2): ";
	if ${CAT} $(2) | $(1) dict | ${DIFF} - correct.$(2); then echo pass; else echo fail; fi
endef

test: prog size
	@ $(call stest,./prog,test.light,-lt)
	@ $(call stest,./prog,test.abode,-lt)
	@ $(call stest,./prog,test.jaunt,-eq)

size:
	${IOCCCSIZE} prog.c
	@# iocccsize-2019 -i < prog.c
	@# iocccsize-2020 -i < prog.c > /dev/null

tfmt: fmt
	@ $(call stest,./fmt,test.light,-lt)
	@ $(call stest,./fmt,test.abode,-lt)
	@ $(call stest,./fmt,test.jaunt,-eq)

fmt: fmt.c
	${CC} ${CFLAGS} fmt.c -o $@ ${LDFLAGS}

fmt.c: prog.c
	${RM} -f $@
	${CLANG_FORMAT} -style=file < prog.c > fmt.c

dups: dups.c
	${CC} ${CFLAGS} dups.c -o $@ ${LDFLAGS}

gen: gen.c
	${CC} ${CFLAGS} gen.c -o $@ ${LDFLAGS}

run: run.c
	${CC} ${CFLAGS} run.c -o $@ ${LDFLAGS}

reveal: reveal.c
	${CC} ${CFLAGS} reveal.c -o $@ ${LDFLAGS}

usdw:
	${RM} -f $@
	${GREP} '^.....$$' ${DICTIONARY} | ${GREP} -v '[A-Z]' | ${GREP} -v beant > $@

spoiler: reveal fmt.c
	@if test -x ${CLANG_FORMAT}; then ${CLANG_FORMAT} -style=file < prog.c | ./reveal; else ./reveal < fmt.c; fi

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
	${RM} -f fmt.c fmt


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
