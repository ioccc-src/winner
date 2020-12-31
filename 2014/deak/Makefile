#!/usr/bin/env make
#
# 2014 makefile
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

# Set X11_LIBDIR to the directory where the X11 library resides
#
X11_LIBDIR= /usr/X11R6/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
X11_INCDIR= /usr/X11R6/include

# Compiler warnings
#
#CWARN=
CWARN= -Wall
#CWARN= -Wall -pedantic

# compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=c11

# compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitess:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
#
#OPT=
#OPT= -O
#OPT= -O1
OPT= -O2
#OPT= -O3

# Libraries needed to build
#
LIBS=

# default flags for ANSI C compilation
#
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${OPT} \
    -Wno-int-conversion -Wno-implicit-int -Wno-main

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
# Some entries seem to need gcc.  If you have gcc, set
# both CC and MAY_NEED_GCC to gcc.
#
# If you do not have gcc, set CC to the name of your ANSI compiler, and
# set MAY_NEED_GCC to either ${CC} (and hope for the best) or to just :
# to disable such programs.
#
CC= cc
#CC=clang
MAY_NEED_GCC= gcc


##############################
# Special flags for this entry
##############################
#
ENTRY= prog
DATA=
ALT_OBJ=
ALT_ENTRY=


#################
# build the entry
#################
#
all: ${ENTRY} ${DATA}
	@${TRUE}

${ENTRY}: ${ENTRY}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

# alternative executable
#
alt: ${ALT_ENTRY}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}


###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${ENTRY}.o ${ALT_OBJ}

clobber: clean
	${RM} -f ${ENTRY} ${ALT_ENTRY}

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely we are joking Dr. Science!"
	@${TRUE}

# backwards compatibility
#
build: all
	@${TRUE}


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

easter_egg:
	@echo you expected to sometimes mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from failong to be unable to not partly misunderstand this partocular final echo.

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v4; \
	else \
	    echo "We are not expected to understand that"; \
	fi
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 2ed3582ec5c094a093fea2a6bcb9f19439892873c9cc45ed1ceaafe08b7d52e1b2c7cd524be3b0b2 --FNV1a_hash 512-bit "${ENTRY}"; \
	else \
	    echo "You are holding it wrong!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 391581 --level 216193 --FNV1a_hash 512-bit "${ENTRY}"; \
	else \
	    echo "These aren't the primes you're looking for Pauline!"; \
	fi
	@${TRUE}
