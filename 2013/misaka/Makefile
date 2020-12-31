#!/usr/bin/env make
#
# 2013 makefile
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
CHMOD= chmod

# Set X11_LIBDIR to the directory where the X11 library resides
#
X11_LIBDIR= /usr/X11R6/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
X11_INCDIR= /usr/X11R6/include

# Compiler warnings
#
#CWARN=
CWARN= -Wall -W -Wno-comment -Wno-empty-body
#CWARN= -Wall -W -pedantic

# compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=c99

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
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${OPT} ${LIBS}

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
ENTRY= horizontal_cat vertical_cat long_cat loong_cat \
	loooong_cat loooooooong_cat long_fat_cat \
	long_faat_cat same_as_long_cat
OBJS= misaka.o misaka2.o misaka3.o misaka4.o misaka5.o \
	misaka6.o misaka7.o misaka8.o misaka9.o
OTHER_C= misaka2.c misaka3.c misaka4.c misaka5.c \
	misaka6.c misaka7.c misaka8.c misaka9.c
DATA= bf.pl
ALT_OBJ=
ALT_ENTRY=


#################
# build the entry
#################
#
all: ${ENTRY} ${DATA}
	@${TRUE}

misaka: all
	@${TRUE}

horizontal_cat: misaka.c
	${CC} ${CFLAGS} $< -o $@

misaka2.c: horizontal_cat misaka.c
	${RM} -f misaka2.c
	./horizontal_cat misaka.c misaka.c > misaka2.c

vertical_cat: misaka2.c
	${CC} ${CFLAGS} misaka2.c -o $@

misaka3.c: vertical_cat misaka.c
	${RM} -f misaka3.c
	./vertical_cat misaka.c misaka.c > misaka3.c

long_cat: misaka3.c
	${CC} ${CFLAGS} misaka3.c -o $@

misaka4.c: vertical_cat misaka.c
	${RM} -f misaka4.c
	./vertical_cat misaka.c misaka.c misaka.c > misaka4.c

loong_cat: misaka4.c
	${CC} ${CFLAGS} misaka4.c -o $@

misaka5.c: vertical_cat misaka.c
	${RM} -f misaka5.c
	./vertical_cat misaka.c misaka.c misaka.c misaka.c > misaka5.c

loooong_cat: misaka5.c
	${CC} ${CFLAGS} misaka5.c -o $@

misaka6.c: vertical_cat misaka.c
	${RM} -f misaka6.c
	./vertical_cat misaka.c misaka.c misaka.c misaka.c misaka.c > misaka6.c

loooooooong_cat: misaka6.c
	${CC} ${CFLAGS} misaka6.c -o $@

misaka7.c: vertical_cat horizontal_cat misaka.c
	${RM} -f misaka7.c
	./vertical_cat misaka.c misaka.c | ./horizontal_cat - - > misaka7.c

long_fat_cat: misaka7.c
	${CC} ${CFLAGS} misaka7.c -o $@

misaka8.c: vertical_cat horizontal_cat misaka.c
	${RM} -f misaka8.c
	./vertical_cat misaka.c misaka.c | ./horizontal_cat - - - > misaka8.c

long_faat_cat: misaka8.c
	${CC} ${CFLAGS} misaka8.c -o $@

misaka9.c: vertical_cat horizontal_cat misaka.c
	${RM} -f misaka9.c
	./horizontal_cat misaka.c misaka.c | ./vertical_cat misaka.c - > misaka9.c

same_as_long_cat: misaka9.c
	${CC} ${CFLAGS} misaka9.c -o $@

# Information on the misaka programs
#
understanding: bf.pl misaka.c ${OTHER_C}
	@${CHMOD} +x bf.pl
	@for c in misaka.c ${OTHER_C}; do \
	    echo ./bf.pl $$c; \
	    ./bf.pl $$c; \
	done

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
	${RM} -f ${OBJS} ${ALT_OBJ}

clobber: clean
	${RM} -f ${ENTRY} ${ALT_ENTRY}
	${RM} -f ${OTHER_C}

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely we are joking Dr. Lehmer!"
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
	@echo you expected to mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from being unable to not partly misunderstand this partocular final echo.

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
	    echo "Park different"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 391581 --level 216193 --FNV1a_hash 512-bit "${ENTRY}"; \
	else \
	    echo "These aren't the primes you're looking for Paul Erdos!"; \
	fi
	@${TRUE}
