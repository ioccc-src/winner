#!/usr/bin/env make
#
# IOCCC 2019 winning entry - mills

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
CSILENCE= -Wno-for-loop-analysis -Wno-missing-field-initializers \
	  -Wno-strict-prototypes -Wno-misleading-indentation \
	  -Wno-old-style-declaration -Wno-unused-value -Wno-unsafe-buffer-usage

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= ${param}

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
LDFLAGS= -lm

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-double-promotion -Wno-float-conversion -Wno-format-nonliteral \
	   -Wno-implicit-float-conversion -Wno-implicit-int-conversion \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shadow -Wno-shorten-64-to-32 \
	   -Wno-sign-conversion -Wno-strict-prototypes -Wno-vla \
	   -Wno-conditional-uninitialized -Wno-declaration-after-statement
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
ENTRY= mills
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
#
INPUTS_GZ= IOCCC-hints.txt.gz Shakespeare.txt.gz \
	   IOCCC-Rules-Guidelines.txt.gz Eugene_Onegin.txt.gz
INPUTS= IOCCC-hints.txt Shakespeare.txt \
	IOCCC-Rules-Guidelines.txt Eugene_Onegin.txt
CPFILES= IOCCC-hints.cp09_1.809 Shakespeare.cp04_1.633 \
	 IOCCC-Rules-Guidelines.cp98_0.175 Eugene_Onegin.cp11_1.188
OUTPUTS= IOCCC-hints.output.txt Shakespeare.output.txt \
	 IOCCC-Rules-Guidelines.output.txt Eugene_Onegin.output.txt
DATA= ${CPFILES} ${INPUTS_GZ} ${CPFILES}
TARGET = lin1 per1 rnn1 rnn2 rnn3 lstm1 lstm2 lstm3 lstmp1 lstmp2 lstmp3 \
	 rlstm1 rlstm2 rlstm3 gru1 gru2 gru3 prog
#
ALT_OBJ=
ALT_TARGET=

# hyperparameters
param = -DRS=.15 -DTR=.95 -DLR=.002 -DLD=.97 -DLE=10 -DCL=5 -DB1=.9 -DB2=.999 \
        -DEP=1e-8 -DWD=8e-5 -DDI=100 -DSL=200 -DN=50 -DTP=1                   \
	-DPF='"cp%02d_%.3f"'

##############################################################
# Networks
#
# Note that temp variables have been added to force evaluation
# order.  This allows checkpoint files to be portable beetween
# different compilers.
##############################################################

# linear
lin       = -DBK='y=x'

# perceptron
per       = -DBK='y=T(x)'

# recurrent neural network
rnn       = -DHS=128  -DBK='                   \
   hp = I(HS),                                 \
   t1 = L(HS, x),                              \
   h  = C(hp, T(A(t1, L(HS, hp)))),            \
   y  = h                                      \
'

# long short term memory
lstm   = -DHS=128 -DBK='                       \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   f   = S(A(t1, L(HS, hp))),                  \
   t2  = L(HS, x),                             \
   i   = S(A(t2, L(HS, hp))),                  \
   t3  = L(HS, x),                             \
   cn  = T(A(t3, L(HS, hp))),                  \
   t4  = M(f, cp),                             \
   c   = C(cp, A(t4, M(i, cn))),               \
   t5  = L(HS, x),                             \
   o   = S(A(t5, L(HS, hp))),                  \
   h   = C(hp, M(o, T(c))),                    \
   y   = h                                     \
'

# lstm with passthrough
lstmp = -DHS=128 -DBK='                        \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   t2  = A(t1, L(HS, hp)),                     \
   f   = S(A(CM(cp), t2)),                     \
   t3  = L(HS, x),                             \
   t4  = A(t3, L(HS, hp)),                     \
   i   = S(A(CM(cp), t4)),                     \
   t5  = L(HS, x),                             \
   cn  = T(A(t5, L(HS, hp))),                  \
   t6  = M(f, cp),                             \
   c   = C(cp, A(t6, M(i, cn))),               \
   t7  = L(HS, x),                             \
   t8  = A(t7, L(HS, hp)),                     \
   o   = S(A(CM(c),  t8)),                     \
   h   = C(hp, M(o, T(c))),                    \
   y   = h                                     \
'

# residual lstm
rlstm = -DHS=128 -DBK='                        \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   t2  = A(t1, L(HS, hp)),                     \
   f   = S(A(CM(cp), t2)),                     \
   t3  = L(HS, x),                             \
   t4  = A(t3, L(HS, hp)),                     \
   i   = S(A(CM(cp), t4)),                     \
   t5  = L(HS, x),                             \
   cn  = T(A(t5, L(HS, hp))),                  \
   t6  = M(f, cp),                             \
   c   = C(cp, A(t6, M(i, cn))),               \
   t7  = L(HS, x),                             \
   t8  = A(t7, L(HS, hp)),                     \
   o   = S(A(CM(c),  t8)),                     \
   m   = L(HS, T(c)),                          \
   h   = C(hp, M(o, A(m, L(HS, x)))),          \
   y   = h                                     \
'

# gated recurrent unit
gru    = -DHS=128 -DBK='                       \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   z   = S(A(t1, L(HS, hp))),                  \
   t2  = L(HS, x),                             \
   r   = S(A(t2, L(HS, hp))),                  \
   t3  = L(HS, x),                             \
   c   = T(A(t3, L(HS, M(r, hp)))),            \
   zc  = OG(1, -1, z),                         \
   t4  = M(zc, hp),                            \
   h   = C(hp, A(t4, M(z, c))),                \
   y   = h                                     \
'

# single-layer network
one_layer = -DNW='                             \
   x   = I(n),                                 \
   y   = L(n, MD(x))                           \
'

# two-layer network
two_layer = -DNW='                             \
   x   = I(n),                                 \
   y   = L(n, MD(MD(x)))                       \
'

# three-layer network
three_layer = -DNW='                           \
   x   = I(n),                                 \
   y   = L(n, MD(MD(MD(x))))                   \
'

# Enumerated list of networks
#
lin1   = ${lin}   ${one_layer}
per1   = ${per}   ${one_layer}
rnn1   = ${rnn}   ${one_layer}
rnn2   = ${rnn}   ${two_layer}
rnn3   = ${rnn}   ${three_layer}
lstm1  = ${lstm}  ${one_layer}
lstm2  = ${lstm}  ${two_layer}
lstm3  = ${lstm}  ${three_layer}
lstmp1 = ${lstmp} ${one_layer}
lstmp2 = ${lstmp} ${two_layer}
lstmp3 = ${lstmp} ${three_layer}
rlstm1 = ${rlstm} ${one_layer}
rlstm2 = ${rlstm} ${two_layer}
rlstm3 = ${rlstm} ${three_layer}
gru1   = ${gru}   ${one_layer}
gru2   = ${gru}   ${two_layer}
gru3   = ${gru}   ${three_layer}

# default network
#
prog   = ${rnn1}


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber
	text

${TARGET}: ${PROG}.c Makefile ${INPUTS}
	${CC} ${CFLAGS} -o $@ $< $($@) ${LDFLAGS}

# alternative executable
#
alt: ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}

${INPUTS}: %.txt: %.txt.gz
	${ZCAT} < $< > $@

text: ${INPUTS}
	@${TRUE}

test: ${OUTPUTS}

# First 1000 lines of generated output
#
generator = ./lstm2

test-64bit:	IOCCC-hints.output.txt IOCCC-Rules-Guidelines.output.txt Shakespeare.output.txt Eugene_Onegin.output.txt

IOCCC-hints.output.txt: IOCCC-hints.cp09_1.809 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

Shakespeare.output.txt: Shakespeare.cp04_1.633 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

IOCCC-Rules-Guidelines.output.txt: IOCCC-Rules-Guidelines.cp98_0.175 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

Eugene_Onegin.output.txt: Eugene_Onegin.cp11_1.188 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

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

cpclean:
	${RM} -f cp*_*.*

clobber: clean cpclean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f ${INPUTS}
	${RM} -f ${OUTPUTS}


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
