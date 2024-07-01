#!/usr/bin/env make
#
# IOCCC 2015 winning entry - endoh1

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
CSILENCE= -Wno-strict-prototypes -Wno-misleading-indentation \
	  -Wno-multistatement-macros

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu11

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
#
OPT= -O3

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
CSILENCE+= -Wno-comma -Wno-double-promotion -Wno-float-conversion \
	   -Wno-implicit-float-conversion -Wno-implicit-int-conversion \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-redundant-parens -Wno-shadow \
	   -Wno-sign-conversion -Wno-strict-prototypes \
	   -Wno-extra-semi-stmt -Wno-misleading-indentation \
	   -Wno-unsafe-buffer-usage
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
ENTRY= endoh1
PROG= prog
CSRC= ${PROG}.c
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} gray-scott-1 gray-scott-2 gray-scott-3 gray-scott-4 \
	fitzhugh-nagumo-1 fitzhugh-nagumo-2 ginzburg-landau oregonator
#
ALT_OBJ=
ALT_TARGET=

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

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install love haste waste maker easter_egg \
	sandwich supernova deep_magic magic charon pluto

${PROG}: gray-scott-1
	${RM} -f $@
	${CP} gray-scott-1 $@

gray-scott-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.035 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192 ${LDFLAGS}

gray-scott-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.082 -DDv=0.041 -DF=0.035 -DK=0.063 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=128:255:192 ${LDFLAGS}

gray-scott-3: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.030 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192 ${LDFLAGS}

gray-scott-4: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.040 -DDv=0.020 -DF=0.012 -DK=0.050 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=192:192:255 ${LDFLAGS}

fitzhugh-nagumo-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=3 -DA0=-0.1 -DA1=2 -DE=0.06 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,0 \
	    -DTIMESTEP=0.050 -DSPEED=80 -DRGB=128:192:255 ${LDFLAGS}

fitzhugh-nagumo-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=10 -DA0=0.0 -DA1=1 -DE=1 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,1 \
	    -DTIMESTEP=0.005 -DSPEED=20 -DRGB=128:192:255 ${LDFLAGS}

ginzburg-landau: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GINZBURG_LANDAU_MODEL} -DDu=0.1 -DDv=0.1 -DA=0.0625 -DB=1 -DD=1.05 -DG=0.0625 \
	    -DUV_BACKGROUND=-0.1 -DUV_DROP=0,1 \
	    -DTIMESTEP=0.60 -DSPEED=40 -DRGB=128:255:128 ${LDFLAGS}

oregonator: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${OREGONATOR_MODEL} -DDu=0.01 -DDv=0.01 -DE=0.1 -DF=1.4 -DQ=0.002 \
	    -DUV_BACKGROUND=0 -DUV_DROP=0.05,0.2 \
	    -DTIMESTEP=0.001 -DSPEED=80 -DRGB=128:192:255 ${LDFLAGS}

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
	@${TRUE}


#####################
# make a difference #
#####################
#
# diff orig source and source
#
diff_orig_prog: ${PROG}.orig.c ${PROG}.c
	@-${DIFF} -u ${PROG}.orig.c ${PROG}.c

# diff source and orig source
#
diff_prog_orig: ${PROG}.c ${PROG}.orig.c
	@-${DIFF} -u ${PROG}.c ${PROG}.orig.c

# diff alt source and source
#
diff_alt_prog: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.c; \
	fi

# diff source and alt source
#
diff_prog_alt: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.c ${PROG}.alt.c; \
	fi

# diff orig and alt
#
diff_orig_alt: ${PROG}.orig.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.orig.c ${PROG}.alt.c; \
	fi

# diff alt and orig
diff_alt_orig:
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.orig.c; \
	fi


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
	${RM} -rf *.dSYM
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
	    echo "no indent tool found, ident $< yourself, sorry"; \
	    echo "exit 17"; \
	    exit 17; \
	fi


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'

waste:
	@echo $@

haste:
	${MAKE} waste

maker: haste
	@echo 'Participate in a maker faire'
	${MAKE} love

easter_egg: maker
	@echo "You are expected to often misunderstand this $${RANDOM} magic, Eggy!"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "p.s.: Careful with That Axe, Eugene!"

sandwich: easter_egg
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    echo "Did you forget the magic word?"; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "Planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ helps ${MAKE} the elements that help form planets"

deep_magic: supernova
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 7889066cdbdf09b0408021754586e895be641cc9be29e7eafd3ca65359541f17 \
			   --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	fi

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 20003 --mode 5717175 --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet"
	@echo "Dwarf planets are a type of planet"
	@echo "Therefore IAU, $@ is a planet"

pluto: charon
	@echo "See https://www.hou.usra.edu/meetings/lpsc2017/pdf/1448.pdf for a good definition of a planet"
	@echo "$@ is a dwarf planet"
	@echo "Dwarf planets are a type of planet"
	@echo "Therefore, $@ is a planet"
	@echo "The geophysical definition of planet gives us ~110 planets in our solar system"
