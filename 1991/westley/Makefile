#!/usr/bin/env make
#
# IOCCC 1991 winning entry - westley

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
CSILENCE= -Wno-error -Wno-implicit-function-declaration -Wno-parentheses \
	  -Wno-shift-op-parentheses -Wno-return-type \
	  -Wno-deprecated-non-prototype -Wno-missing-braces -Wno-implicit-int \
	  -Wno-misleading-indentation -Wno-missing-parameter-type -Wno-unused-value

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu90

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE= -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	-DJ=z[4] -DK=J[14] \
	-DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}"

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
CSILENCE+= -Wno-comma -Wno-implicit-int-conversion -Wno-missing-prototypes \
	   -Wno-missing-variable-declarations -Wno-pedantic \
	   -Wno-poison-system-directories -Wno-shadow -Wno-strict-prototypes \
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
ENTRY= westley
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} ttt
#
ALT_OBJ= ${PROG}.alt.o
ALT_TARGET= ${PROG}.alt ttt.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install love haste waste maker easter_egg \
	sandwich supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# the hint file gives nextmove.c as an example, provide a build rule for it
#
nextmove: nextmove.c ttt
	${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    nextmove.c -o nextmove

# the ttt script has been added by the judges to make playing westley easy
#
ttt: ttt.sh
	${RM} -f ttt
	${CP} -f ttt.sh ttt
	${CHMOD} +x ttt

# used by the ttt shell script when playing westley
#
# The ttt script controls what goes into merlyn.c, and how it is used.
# The merlyn program and source represent the best (hopefully) state that
# the program has evolved into thus far.  The ttt_game program and source
# represent the current state of the game.
#
merlyn: merlyn.c ttt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    merlyn.c -o merlyn
ttt_game: ttt_game.c ttt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    ttt_game.c -o ttt_game

# The upper level makefile wants to make these source files if they don't
# already exist.
#
merlyn.c: westley.c
	${RM} -f merlyn.c
	${CP} -f westley.c merlyn.c
	${CHMOD} +w merlyn.c
nextmove.c: westley.c
	${RM} -f nextmove.c
	${CP} -f westley.c nextmove.c
	${CHMOD} +w nextmove.c
ttt_game.c: westley.c
	${RM} -f ttt_game.c
	${CP} -f westley.c ttt_game.c
	${CHMOD} +w ttt_game.c


# alt version
#
# the hint file gives nextmove.alt.c as an example, provide a build rule for it
#
nextmove.alt: nextmove.alt.c ttt_alt
	${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    nextmove.alt.c -o nextmove.alt

# the ttt_alt script has been added by the judges to make playing westley.alt easy
#
ttt_alt: ttt_alt.sh
	${RM} -f ttt_alt
	${CP} -f ttt_alt.sh ttt_alt
	${CHMOD} +x ttt_alt

# used by the ttt_alt shell script when playing westley.alt
#
# The ttt_alt script controls what goes into merlyn.alt.c, and how it is used.
# The merlyn.alt program and source represent the best (hopefully) state that
# the program has evolved into thus far.  The ttt_alt_game program and source
# represent the current state of the game.
#
merlyn.alt: merlyn.alt.c ttt_alt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    merlyn.alt.c -o merlyn.alt
ttt_alt_game: ttt_alt_game.c ttt_alt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    ttt_alt_game.c -o ttt_alt_game

# The upper level makefile wants to make these source files if they don't
# already exist.
#
merlyn.alt.c: westley.alt.c
	${RM} -f merlyn.alt.c
	${CP} -f westley.alt.c merlyn.alt.c
	${CHMOD} +w merlyn.alt.c
nextmove.alt.c: westley.alt.c
	${RM} -f nextmove.alt.c
	${CP} -f westley.alt.c nextmove.alt.c
	${CHMOD} +w nextmove.alt.c
ttt_alt_game.c: westley.alt.c
	${RM} -f ttt_alt_game.c
	${CP} -f westley.alt.c ttt_alt_game.c
	${CHMOD} +w ttt_alt_game.c



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
	${RM} -f new_merlyn.c
	@-if [ -f indent.c ]; then \
	    echo ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f merlyn merlyn.c nextmove nextmove.c
	${RM} -f merlyn.alt merlyn.alt.c nextmove.alt nextmove.alt.c
	${RM} -f ttt_game ttt_game.c ttt_old.c ttt_new.c nextmove
	${RM} -f ttt.alt_game ttt.alt_game.c ttt.alt_old.c ttt_.altnew.c nextmove.alt
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
