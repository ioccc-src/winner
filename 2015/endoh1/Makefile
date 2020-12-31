#!/usr/bin/env make
#
# 2015 makefile
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
BUNZIP2= bunzip2
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true
MKDIR= mkdir
MV= mv
TR= tr
GREP= grep
SORT= sort
UNIQ= uniq

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

# Compiler warnings
#
#CWARN=
#CWARN= -Wall
#CWARN= -Wall -Wextra
CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything
#CWARN= -Wall -Wextra -Weverything -pedantic
#CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

# Silence warnings that ${CWARN} would normally complain about
#
#CSILENCE=
CSILENCE= -Wno-conversion -Wno-float-conversion -Wno-missing-prototypes \
	  -Wno-missing-variable-declarations -Wno-shadow -Wno-sign-conversion

# compiler standard
#
#CSTD=
#CSTD= -ansi
#CSTD= -std=c11
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

# defines that are needed to compile
#
CDEFINE=

# include files that are needed to compile
#
CINCLUDE=

# optimization
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

# default flags for ANSI C compilation
#
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=

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
CSRC= ${ENTRY}.c
OBJ= ${ENTRY}.o
DATA=
ALT_OBJ=
ALT_ENTRY=
TARGET= gray-scott-1 gray-scott-2 gray-scott-3 gray-scott-4 \
	fitzhugh-nagumo-1 fitzhugh-nagumo-2 ginzburg-landau oregonator

GRAY_SCOTT_MODEL = -Delta_u="Du*laplacian(u)-u*v*v+F*(1-u)" \
		   -Delta_v="Dv*laplacian(v)+u*v*v-v*(F+K)"

FITZHUGH_NAGUMO_MODEL = -Delta_u="Du*laplacian(u)+u-u*u*u-v" \
			-Delta_v="Dv*laplacian(v)+E*(u-A1*v-A0)"

GINZBURG_LANDAU_MODEL = \
    -Delta_u="Du*laplacian(u)+A*u-G*v+(-B*u+D*v)*(u*u+v*v)" \
    -Delta_v="Dv*laplacian(v)+A*v+G*u+(-B*v-D*u)*(u*u+v*v)"

OREGONATOR_MODEL = -Delta_u="Du*laplacian(u)+(u-u*u-F*v*(u-Q)/(u+Q))/E" \
		   -Delta_v="Dv*laplacian(v)+u-v"


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

${ENTRY}: gray-scott-1
	${RM} -f $@
	${CP} gray-scott-1 $@

gray-scott-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.035 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192

gray-scott-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.082 -DDv=0.041 -DF=0.035 -DK=0.063 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=128:255:192

gray-scott-3: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.030 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192

gray-scott-4: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.040 -DDv=0.020 -DF=0.012 -DK=0.050 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=192:192:255

fitzhugh-nagumo-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=3 -DA0=-0.1 -DA1=2 -DE=0.06 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,0 \
	    -DTIMESTEP=0.050 -DSPEED=80 -DRGB=128:192:255

fitzhugh-nagumo-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=10 -DA0=0.0 -DA1=1 -DE=1 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,1 \
	    -DTIMESTEP=0.005 -DSPEED=20 -DRGB=128:192:255

ginzburg-landau: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GINZBURG_LANDAU_MODEL} -DDu=0.1 -DDv=0.1 -DA=0.0625 -DB=1 -DD=1.05 -DG=0.0625 \
	    -DUV_BACKGROUND=-0.1 -DUV_DROP=0,1 \
	    -DTIMESTEP=0.60 -DSPEED=40 -DRGB=128:255:128

oregonator: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${OREGONATOR_MODEL} -DDu=0.01 -DDv=0.01 -DE=0.1 -DF=1.4 -DQ=0.002 \
	    -DUV_BACKGROUND=0 -DUV_DROP=0.05,0.2 \
    	    -DTIMESTEP=0.001 -DSPEED=80 -DRGB=128:192:255

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
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_ENTRY}

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely we are joking Dr. May!"
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

make:
	@echo 'Attend a maker faire'
	@${TRUE}

easter_egg:
	@echo you expected to sometimes mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from not failing to be unable to not partly misunderstand this partocular final echo.

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v5; \
	else \
	    echo "planet deniers, like the IAU, are amusing"; \
	fi
	@echo A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 2ed3582ec5c094a093fea2a6bcb9f19439892873c9cc45ed1ceaafe08b7d52e1b2c7cd524be3b0b2 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "You are holding it wrong!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 216091 --level 216193 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "These aren't the primes you're looking for Pauline!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: supernova
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet

pluto: supernova
	${MAKE} charon
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet
	@echo get used to having lots of planets because a $< can ${MAKE} a lot of them
