#!/usr/bin/env make
#
# 2011 makefile
#
# This work by Landon Curt Noll, Simon Cooper, and Leonid A. Broukhis
# is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


################
# tool locations
################
#
SHELL= /bin/bash
CP= cp
CPP= cpp
GUNZIP= gunzip
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true

# Compiler warnings
#
CWARN= -Wall -W -pedantic

# compiler standard
#
CSTD= -std=c99
CSTD2= -ansi

# compiler bit architecture
#
# Some entries require 32-bitness,
# other entries require 64-bitess.
# By default we assume nothing.
#
ARCH=

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
#
OPT= -O2

# default flags for ANSI C compilation
#
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${OPT}
CFLAGS2= ${CSTD2} ${ARCH} ${OPT}

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
CC= cc


##############################
# Special flags for this entry
##############################
#
ENTRY= akari
DATA= example.ppm


#################
# build the entry
#################
#
all: ${ENTRY} ${DATA}
	@${TRUE}

everything: ${ENTRY} \
	    ${ENTRY}2.c ${ENTRY}2 \
	    ${ENTRY}3.c ${ENTRY}3 \
	    ${ENTRY}4.c ${ENTRY}4
	@${TRUE}

${ENTRY}: ${ENTRY}.c
	${CC} ${CFLAGS} ${ENTRY}.c -o ${ENTRY}

${ENTRY}2.c: ${ENTRY}
	./${ENTRY} ${ENTRY}.c $@

${ENTRY}2: ${ENTRY}2.c
	${CC} ${CFLAGS} ${ENTRY}2.c -o $@

${ENTRY}3.c: ${ENTRY} ${ENTRY}.c
	./${ENTRY} < ${ENTRY}.c | ./${ENTRY} > $@

${ENTRY}3: ${ENTRY}3.c
	${CC} ${CFLAGS2} ${ENTRY}3.c -o $@

${ENTRY}4.c: ${ENTRY} ${ENTRY}.c
	./${ENTRY} < ${ENTRY}.c | ./${ENTRY} | ./${ENTRY} > $@

${ENTRY}4: ${ENTRY}4.c
	${CC} ${CFLAGS2} ${ENTRY}4.c -o $@

# alternative executable
#
alt:
	@${TRUE}


###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${ENTRY}.o ${ENTRY}2.c ${ENTRY}3.c ${ENTRY}4.c

clobber: clean
	${RM} -f ${ENTRY} ${ENTRY}2 ${ENTRY}3 ${ENTRY}4

nuke: clobber
	@echo gnab gib!

install:
	@echo "Surely you're joking Mr. Feynman!"

# backwards compatibility
#
build: all


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'

haste:
	$(MAKE) waste

waste:
	@echo 'waste'

easter_egg:
	@echo you expected to mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from being unable to partly misunderstand this final echo.
	@${TRUE}
