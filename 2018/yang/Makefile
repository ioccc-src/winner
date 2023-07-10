#!/usr/bin/env make
#
# IOCCC 2018 winning entry - yang

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be the liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes for VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC winners:
#
#	http://www.ioccc.org/bugs.md
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
CSILENCE= -Wno-strict-prototypes

# Common C compiler warning flags
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
# Some entries require 32-bitness: ARCH= -m32
# Some entries require 64-bitness: ARCH= -m64
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
ifeq ($(CC),clang)
#
CSILENCE+= -Wno-comma -Wno-implicit-int-conversion -Wno-missing-variable-declarations \
	-Wno-poison-system-directories -Wno-sign-conversion -Wno-unused-macros
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
ENTRY= yang
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA= spoiler.html
TARGET= left right shift msg0 msg1 msg2
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

left: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

right: generated1.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

shift: generated2.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

msg0: generated3.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

msg1: generated4.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

msg2: generated5.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

generated1.c: ${PROG}.c left
	@${RM} -f $@
	./left < $< > $@

generated2.c: ${PROG}.c right
	@${RM} -f $@
	./right < $< > $@

generated3.c: ${PROG}.c left
	@${RM} -f $@
	./left < $< | ./left > $@

generated4.c: ${PROG}.c left shift
	@${RM} -f $@
	./shift < $< | ./left > $@

generated5.c: ${PROG}.c right shift
	@${RM} -f $@
	./shift < $< | ./right > $@

############
# spoilers #
############

spoiler: spoilers

spoilers:
	@echo "Really show spoilers?  Please build this target to confirm:"
	@echo "   i_give_up_show_me_the_spoilers"

i_give_up_show_me_the_spoilers: msg3 msg4 msg5 msg6 msg7 msg8 msg9

msg3: generated6.c
	$(CC) $(CFLAGS) $< -o $@

msg4: generated7.c
	$(CC) $(CFLAGS) $< -o $@

msg5: generated8.c
	$(CC) $(CFLAGS) $< -o $@

msg6: generated9.c
	$(CC) $(CFLAGS) $< -o $@

msg7: generated10.c
	$(CC) $(CFLAGS) $< -o $@

msg8: generated11.c
	$(CC) $(CFLAGS) $< -o $@

msg9: generated12.c
	$(CC) $(CFLAGS) $< -o $@

generated6.c: ${PROG}.c right left shift
	@${RM} -f $@
	./right < $< | ./shift | ./left > $@

generated7.c: ${PROG}.c right shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./right > $@

generated8.c: generated7.c right left shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./left > $@

generated9.c: generated8.c right shift
	@${RM} -f $@
	./right < $< | ./right | ./shift | ./right | ./shift | ./right > $@

generated10.c: generated9.c right left shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./left > $@

generated11.c: generated10.c right shift
	@${RM} -f $@
	./right < $< | ./right | ./shift | ./right | ./shift | ./right > $@

generated12.c: msg7
	./msg7 > $@

####################################
# spoilers for the truly_impatient #
####################################

spoiler_for_the_truly_impatient: i_just_want_to_see_the_final_message

i_just_want_to_see_the_final_message: msg11.txt
	@cat $<

msg11.txt: msg11 ${PROG}.c
	@${RM} -f $@
	./$< < ${PROG}.c > $@

msg10: generated13.c
	$(CC) $(CFLAGS) $< -o $@

msg11: generated14.c
	$(CC) $(CFLAGS) $< -o $@

generated13.c: ${PROG}.c left shift
	./left < $< | ./left | ./left | ./shift | ./left | ./shift | ./left | ./shift | ./left > $@

generated14.c: ${PROG}.c msg10
	./msg10 < $< > $@

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
	${RM} -f generated*.c msg*
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
	$(MAKE) waste

maker: haste
	@echo 'Participate in a maker faire'
	$(MAKE) love

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
