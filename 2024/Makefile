#!/usr/bin/env make
#
# 2024 Makefile

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC entries:
#
#       https://www.ioccc.org/bugs.html
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#       Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################

SHELL= bash

#######################
# common tool locations
#######################

include ../var.mk


###############
# IOCCC entries
###############

# 1st - DO NOT REMOVE THIS LINE - bin/new-dir.sh uses this line #
ENTRIES= burton cable1 cable2 carlini codemeow endoh1 endoh2 \
	ferguson1 ferguson2 howe kramer kurdyukov1 kurdyukov2 kurdyukov3 \
	kurdyukov4 macke maffiodo mills stedolan straadt tmarrec tompng weaver
# 2nd - DO NOT REMOVE THIS LINE - bin/new-dir.sh uses this line #

YEAR= 2024


###################
# build all entries
###################

all:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install genpath clang-format add_dir love haste \
	waste maker easter_egg sandwich supernova more_magic magic charon pluto

# alternative executable
#
alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# data files
#
data:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# both all and alt
#
everything:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


#####################
# make a difference #
#####################

# diff orig source and source
#
diff_orig_prog:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff source and orig source
#
diff_prog_orig:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff alt source and source
#
diff_alt_prog:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff source and alt source
#
diff_prog_alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff orig and alt
#
diff_orig_alt:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

# diff alt and orig
diff_alt_orig:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


###############
# utility rules
###############

clean:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

clobber:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

genpath:
	@echo '=-=-= IOCCC begin make $@ =-=-='
	@${RM} -f .tmp.genpath
	@${TOUCH} .tmp.genpath
	@-for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
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

# new_entry - add a new entry directory name to the ${ENTRIES} Makefile variable
#
# Add ${NEW_ENTRY} to the list of ${ENTRIES} and output Makefile lines to set updated
# ${ENTRIES} Makefile variable.
#
# If list of ${ENTRIES} is long, we format it into a multi-line value setting with required
# backslashes and indentation.  Duplicate values are removed and the initial 'submit.[0-9]*' (used
# during judging) is removed.  The words (directory names) in ${ENTRIES} are sorted in C dictionary order.
#
# This rule is used by the bin/new-dir.sh shell script via:
#
#	make -C ${YEAR} new_entry NEW_ENTRY=curds
#
new_entry:
	@if [[ -z "${NEW_ENTRY}" ]]; then echo "$@: ERROR: NEW_ENTRY is empty" 1>&2; exit 1; fi
	@if [[ ! -d "${NEW_ENTRY}" ]]; then echo "$@: ERROR: not a directory: ${YEAR}/${NEW_ENTRY}" 1>&2; exit 2; fi
	@(echo -n 'ENTRIES= '; \
	   (for dir in ${ENTRIES} ${NEW_ENTRY}; do \
	      if [[ $$dir != 'submit.[0-9]*' ]]; then echo "$$dir"; fi; \
	    done | \
	    LANG=C ${SORT} -d -u; \
	   ) \
	 ) | \
	 ${FMT} | \
	 ${SED} -e '2,$$s/^/\t/' -e 's/$$/ \\/' -e '$$s/ \\//'


########################
# extended utility rules
########################

install:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

clang-format:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


##################
# 1337 hacker rulz
##################

love:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

haste:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

waste:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

maker:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

easter_egg:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

sandwich:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

more_magic:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

magic:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

charon:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='

pluto:
	@echo '=-=-= ${YEAR} begin make $@ =-=-='
	@echo
	@for i in ${ENTRIES}; do \
	    if [[ -d $$i ]]; then \
		echo "=-= start ${YEAR}/$$i =-="; \
		echo "(cd $$i && ${MAKE} $@)"; \
		(cd $$i && ${MAKE} $@); \
		echo "=-= end ${YEAR}/$$i =-="; \
		echo; \
	    fi; \
	done
	@echo '=-=-= ${YEAR} complete make $@ =-=-='
