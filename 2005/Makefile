#!/usr/bin/env make
#
# 2005 Makefile

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
# This file is Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
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
include ../var.mk


###############
# IOCCC entries
###############
#
# BEGIN - DO NOT REMOVE THIS LINE - make new_entry uses this line #
ENTRIES= aidan anon boutines chia giljade jetro klausler mikeash \
	mynx persano sykes timwi toledo vik vince
# END - DO NOT REMOVE THIS LINE - make new_entry also uses this #

YEAR= 2005


###################
# build all entries
###################
#
all:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install genpath love haste waste maker \
	easter_egg sandwich supernova more_magic magic charon pluto

# alternative executable
#
alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# data files
#
data:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# both all and alt
#
everything:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


#####################
# make a difference #
#####################
#
# diff orig source and source
#
diff_orig_prog:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff source and orig source
#
diff_prog_orig:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff alt source and source
#
diff_alt_prog:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff source and alt source
#
diff_prog_alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff orig and alt
#
diff_orig_alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff alt and orig
diff_alt_orig:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


###############
# utility rules
###############
#
clean:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

clobber:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

genpath:
	@echo '=-=-= IOCCC begin make $@ =-=-='
	@${RM} -f .tmp.genpath
	@${TOUCH} .tmp.genpath
	@-for i in ${ENTRIES}; do \
	    echo "${YEAR}/$$i" >> .tmp.genpath; \
	    ${RM} -f "$$i/.tmp.genpath"; \
	    echo "${YEAR}/$$i" >> "$$i/.tmp.genpath"; \
	    if ${CMP} -s "$$i/.tmp.genpath" "$$i/.path"; then \
	        ${RM} -f "$$i/.tmp.genpath"; \
		echo "$$i/.path already up to date"; \
	    else \
		 ${MV} -f "$$i/.tmp.genpath" "$$i/.path"; \
		 ${CHMOD} 0444 "$$i/.path"; \
		 echo "updated $$i/.path"; \
	    fi; \
        done
	@-if ${CMP} -s .tmp.genpath .year; then \
	    ${RM} -f .tmp.genpath; \
	    echo ".year already up to date"; \
	else \
	    ${MV} -f .tmp.genpath .year; \
	    ${CHMOD} 0444 .year; \
	    echo "updated .year"; \
	fi
	@echo '=-=-= IOCCC complete make $@ =-=-='


#############################################################
# NOTE: 'Don't Panic' if you don't understand the stuff below
#############################################################

# add ${NEW_ENTRY} to the list of ${ENTRIES} and output Makefile lines to set updated ${ENTRIES} value
#
new_entry:
	@(echo 'ENTRIES= '; \
	  (echo ${ENTRIES} ${NEW_ENTRY}) | ${TR} ' ' '\012' | ${SORT} -d -u) | \
	  ${FMT} | ${SED} -e '2,$$s/^/\t/' -e 's/$$/ \\/' -e '$$s/ \\//'


########################
# extended utility rules
########################

.PHONY: indent_clean indent_clobber

# you may be able to misunderstand the source by reading indent.c
#
indent.c:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

indent_clean: clean
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

indent_clobber: indent_clean clobber
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

install:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


##################
# 1337 hacker rulz
##################

love:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

haste:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

waste:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

maker:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

easter_egg:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

sandwich:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

more_magic:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

magic:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

charon:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

pluto:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    echo "=-= start ${YEAR}/$$i =-="; \
	    echo "(cd $$i && ${MAKE} $@)"; \
	    (cd $$i && ${MAKE} $@); \
	    echo "=-= end ${YEAR}/$$i =-="; \
	    echo; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='
