#!/usr/bin/env make
#
# IOCCC 2004 winning entry - gavin

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
CSILENCE= -Wno-bitwise-conditional-parentheses -Wno-bitwise-op-parentheses \
	  -Wno-constant-conversion -Wno-error -Wno-implicit-function-declaration \
	  -Wno-int-to-pointer-cast -Wno-parentheses -Wno-pointer-to-int-cast \
	  -Wno-return-type -Wno-unused-parameter -Wno-unused-variable

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu99

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= '-DY(m)=*((int*)(m))' \
	'-DE(f,a,b,c)=((G((*)))(f))(a,b,c)' \
	'-DM=for(D=0;D<786432;D++)' \
	'-DZ=int i=0,j=0,h,n,p=393728,s=26739,C,D' \
	'-DV=0x90200' \
	'-DK=0' \
	'-DR=while((C=E(V-8,100,0,0))&3&&(D=E(V-8,96,0,0))|3){' \
	'-DL(c,d)=E(V+8,100,c,0);R}E(V+8,96,d,0);R}'

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
#
OPT= -O1

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-comma -Wno-implicit-int-conversion -Wno-missing-prototypes \
	   -Wno-reserved-identifier -Wno-unsafe-buffer-usage \
	   -Wno-poison-system-directories
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
ENTRY= gavin
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA= boot.b lilo.conf prim gavin.md
TARGET= ${PROG} kernel sh vi fs.tar
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt kernel.alt sh.alt vi.alt fs.alt.tar


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

kernel: ${PROG}
	${RM} -f $@
	./${PROG} > $@

sh: ${PROG}.c
	${RM} -f ${PROG}.o
	${CC} ${CFLAGS}  -DB=_start '-Dputchar(a)=' $< -c
	${RM} -f $@
	@echo "NOTE: this entry will not work with any platform other than x86/linux."
	${LD} -static -o $@ ${PROG}.o

vi: sh
	${RM} -f $@
	${CP} $< $@

fs.tar: sh vi gavin.c README.md prim
	${RM} -f $@
	${TAR} -cvf $@ sh vi gavin.c README.md prim

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

${PROG}.alt: ${PROG}.alt.c
	${CC} ${CFLAGS} -UK -DK=1 $< -o $@ ${LDFLAGS}

kernel.alt: ${PROG}.alt
	${RM} -f kernel
	./${PROG}.alt > kernel

sh.alt: ${PROG}.alt.c
	${RM} -f ${PROG}.alt.o
	${CC} ${CFLAGS}  -DB=_start '-Dputchar(a)=' $< -c
	@echo "NOTE: this entry will not work with any platform other than x86/linux."
	${LD} -static -o sh ${PROG}.alt.o

vi.alt: sh.alt
	${RM} -f vi
	${CP} $< vi

fs.alt.tar: sh.alt vi.alt gavin.alt.c README.md prim
	${RM} -f $@
	${TAR} -cvf fs.tar sh vi gavin.alt.c README.md prim

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
	${RM} -f sh vi kernel gavin.o

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f gavin fs.tar


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
