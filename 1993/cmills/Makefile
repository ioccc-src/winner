#!/usr/bin/env make
#
# IOCCC 1993 winning entry - cmills

################################################################################
#
# An Historical Makefile NOTE:
#
# The orig.Makefile, if it exits, is the original Makefile before this IOCCC
# year directory was reworked so that entries are in separate directories.
# This also applies to any orig.ansi.mk and orig.common.mk files.
#
# Several Makefiles were modified / formed in 2022, and as such it may have
# elements that are not historically compatible with way entries were built.
# The orig.Makefile, if it exits, is a copy of the pre-modified Makefile.
#
# Regarding individual entries:
#
# IOCCC winning entry code may not work on your system.  Even with standards,
# conditions and build environments change, especially when it comes to more
# extreme code such you might find in an IOCCC winner.  Moreover, what was
# allowed and liked in one IOCCC contest may no longer be liked/allowed in
# later IOCCC years.
#
# Corrections on winning author and fixing typos in remarks are VERY WELCOME.
#
# GitHub pull requests are welcome:
#
# If you have a patch that might make running an entry work in modern Unix-like
# environments, please create a GitHub pull request for the IOCCC judges to
# consider.
#
# Suggestions and corrections regarding Makefiles, winning author information,
# fixing typos in remarks, and code patches are welcome via opening a GitHub
# issue or better yet, by creating a GitHub pull request for the IOCCC judges
# to consider.  To form a GitHub issue or GitHub pull, please visit:
#
# https://github.com/ioccc-src/winner
#
################################################################################

# This work by Landon Curt Noll and Leonid A. Broukhis is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

#######################
# common tool locations
#######################
include ../../var.mk
#

# Set X11_LIBDIR to the directory where the X11 library resides
#
#X11_LIBDIR= /usr/X11R6/lib
#X11_LIBDIR= /usr/X11/lib
X11_LIBDIR= /opt/X11/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
#X11_INCDIR= /usr/X11R6/include
#X11_INCDIR= /usr/X11/include
X11_INCDIR= /opt/X11/include

# Common C compiler warnings to silence
#
#CSILENCE=
CSILENCE= -Wno-return-type

# Common C compiler warning flags
#
#CWARN= ${CSILENCE}
#CWARN= -Wall ${CSILENCE}
CWARN= -Wall -Wextra ${CSILENCE}
#CWARN= -Wall -Wextra -pedantic ${CSILENCE}

# Compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=gnu90

# Compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitness:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=
#CDEFINE= -DIOCCC

# Include files that are needed to compile
#
#CINCLUDE=
#CINCLUDE= -include stdlib.h
#CINCLUDE= -include stdio.h
#CINCLUDE= -include stdlib.h -include stdio.h
CINCLUDE= -I ${X11_INCDIR}
#CINCLUDE= -I ${HOMEBREW_PREFIX}/include/SDL2

# Optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
# Reasonable compilers will allow for -O3.
#
#OPT=
#OPT= -O
#OPT= -O1
#OPT= -O2
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
#LIBS=
#LIBS= -lm
LIBS= -L ${X11_LIBDIR} -lX11
#LIBS= -L ${HOMEBREW_PREFIX}/lib -lSDL

# C compiler to use
#
CC= cc
#CC=clang
#CC=gcc

# Compiler add-ons or replacements for clang only
#
ifeq ($(CC),clang)
#
CSILENCE+= -Wno-comma -Wno-missing-prototypes -Wno-missing-variable-declarations \
	-Wno-pedantic -Wno-poison-system-directories -Wno-shadow \
	-Wno-shorten-64-to-32 -Wno-sign-conversion -Wno-strict-prototypes
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq ($(CC),gcc)
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special flags for this entry
##############################
#
ENTRY= cmills
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber install \
	love haste waste maker easter_egg sandwich \
	supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

chris: ${PROG}
	${RM} -f $@
	${CP} -v $< $@

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


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
	@-if [ -f indent.c ]; then \
	    echo ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -f chris
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

install:
	@echo "Dr. Spock says that is not logical!"
	@${TRUE}

# you may be able to misunderstand the source by reading indent.c
#
indent.c: ${PROG}.c
	@if which "${GINDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${GINDENT} < $< > $@"; \
	    ${GINDENT} < $< > $@; \
	elif which "${INDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${INDENT} < $< > $@"; \
	    ${INDENT} < $< > $@; \
	else \
	    echo "no intent tool found, ident $< yourself, sorry"; \
	    echo "exit 1"; \
	    exit 1; \
	fi


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

maker:
	@echo 'Participate in a maker faire'
	@${TRUE}

easter_egg:
	@echo "you expected to often misunderstand this $${RANDOM} magic"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "Eggy"

sandwich: easter_egg
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    exit 1; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ helps ${MAKE} the elements that help form planets"
	@${TRUE}

deep_magic: supernova
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 7889066cdbdf09b0408021754586e895be641cc9be29e7eafd3ca65359541f17 \
	    		   --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 20003 --mode 5717175 --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore IAU, $@ is a planet"

pluto: charon
	${MAKE} charon
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore, $@ is a planet"
	@echo "having lots of planets is good feature because supernovae can help ${MAKE} a lot of them"
