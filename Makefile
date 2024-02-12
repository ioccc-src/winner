#!/usr/bin/env make
#
# IOCCC Makefile

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC winners:
#
#	https://www.ioccc.org/bugs.md
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms this license:
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
include var.mk

#################################
# IOCCC web site maintenance tulz
#################################

ALL_RUN= bin/all-run.sh
GEN_AUTHORS= bin/gen-authors.sh
GEN_LOCATION= bin/gen-location.sh
GEN_YEARS= bin/gen-years.sh
README2INDEX= bin/readme2index.sh
QUICK_README2INDEX= bin/quick-readme2index.sh


#############
# IOCCC years
#############
#
YEARS=	1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 \
	1994 1995 1996 1998 2000 2001 2004 2005 2006 2011 \
	2012 2013 2014 2015 2018 2019 2020


###################
# build all entries
###################
#
all:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
	done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install genpath love haste waste maker \
	easter_egg sandwich supernova deep_magic magic charon pluto

# alternative executable
#
alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# data files
#
data:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# both all and alt
#
everything:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


#####################
# make a difference #
#####################
#
# diff orig source and source
#
diff_orig_prog:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff source and orig source
#
diff_prog_orig:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff alt source and source
#
diff_alt_prog:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff source and alt source
#
diff_prog_alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff orig and alt
#
diff_orig_alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff alt and orig
diff_alt_orig:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


###############
# utility rules
###############
#
clean:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

clobber:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

install:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

indent.c:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


#################################
# IOCCC web site maintenance rulz
#################################

# NOTE: The rules in this section are intended to be used by those
#	who maintain the official IOCCC site.
#
# These rules make certain assumptions about critical tools that
# must be installed on your system in order to be effective.
# While code sometimes makes tests and issues errors if critical
# tools are not found, those tests are NOT exhaustive.
#
# Finally: The rules in this section are NOT needed if you
#	   simple want to examine, run / test winning IOCCC entries.

# XXX - The rules in this section are undergoing development and change.
#	They might not even work (right now).  :-)

.PHONY: genpath gen_authors gen_location gen_years entry_index quick_entry_index \
	quick_www www

# form the top level .top, YYYY level .year and winner level .path files
#
genpath:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@${RM} -f .tmp.genpath
	@-for i in ${YEARS}; do \
	    echo "$$i" >> .tmp.genpath; \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@-if ${CMP} -s .tmp.genpath .top; then \
	    ${RM} -f .tmp.genpath; \
	    echo ".top already up to date"; \
	else \
	    ${MV} -f .tmp.genpath .top; \
	    ${CHMOD} 0444 .top; \
	    echo "updated .top"; \
	fi
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level authors.html page
#
gen_authors: ${GEN_AUTHORS} authors.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_AUTHORS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level location.html page
#
gen_location: ${GEN_LOCATION} location.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_LOCATION} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level years.html page
#
gen_years: ${GEN_YEARS} years.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_YEARS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# force the build of all winner index.html files
#
entry_index: ${ALL_RUN} ${README2INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${README2INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build winner index.html files that might be out of date
#
# This rule uses the QUICK_README2INDEX tool, so
# some winner index.html files that seem to be up to date
# (but might not be up to date) won't be built.
#
quick_entry_index: ${ALL_RUN} ${QUICK_README2INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${QUICK_README2INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# do work to build HTML content for the web site
#
# This rule uses quick_entry_index, not slow_entry_index, so
# some winner index.html files that seem to be up to date
# (but might not be up to date) won't be built.
#
# Well, short of pushing changes to the GitHub repo, that is.  :-)
#
quick_www:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} gen_authors
	${MAKE} gen_location
	${MAKE} gen_years
	${MAKE} quick_entry_index
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# do everything needed to build HTML content for the web site
#
# Well, short of pushing changes to the GitHub repo, that is.  :-)
#
www:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} gen_authors
	${MAKE} gen_location
	${MAKE} gen_years
	${MAKE} entry_index
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


##################
# 133t hacker rulz
##################
#
love:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

haste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

waste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

maker:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

easter_egg:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

sandwich:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

deep_magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

charon:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

pluto:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    echo "cd $$i; make $@"; \
	    (cd $$i; make $@); \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='
