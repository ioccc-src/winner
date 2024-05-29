#!/usr/bin/env make
#
# IOCCC Makefile

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

# NOTE: The "tulz" (tools) in this section are intended to be used by those
#	who maintain the official IOCCC site.
#
# We file "tulz" paths should be relative to the top directory of the repo.
# We need only list those "tulz" that are invoked directly by the
# "IOCCC web site maintenance rulz" section below.

ALL_RUN= bin/all-run.sh
ALL_YEARS= bin/all-years.sh
GEN_AUTHORS= bin/gen-authors.sh
GEN_LOCATION= bin/gen-location.sh
GEN_YEARS= bin/gen-years.sh
GEN_YEAR_INDEX= bin/gen-year-index.sh
CHK_ENTRY= bin/chk-entry.sh
GEN_TOP_HTML= bin/gen-top-html.sh
GEN_OTHER_HTML= bin/gen-other-html.sh
README2INDEX= bin/readme2index.sh
QUICK_README2INDEX= bin/quick-readme2index.sh
UNTAR_ENTRY= bin/untar-entry.sh
UNTAR_YEAR= bin/untar-year.sh
TAR_ENTRY= bin/tar-entry.sh
TAR_YEAR= bin/tar-year.sh
GEN_STATUS= bin/gen-status.sh
GEN_SITEMAP= bin/gen-sitemap.sh
SORT_GITIGNORE= bin/sort.gitignore.sh
FIND_MISSING_LINKS= bin/find-missing-links.sh


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

.PHONY: help genpath genfilelist verify_entry_files gen_authors gen_location gen_years \
	find_missing_links entry_index gen_top_html thanks gen_other_html quick_entry_index \
	gen_year_index quick_www www \
	untar_entry_tarball untar_year_tarball \
	form_entry_tarball form_year_tarball tar \
	gen_status gen_sitemap sitemap timestamp update

# Suggest rules in this section
#
# This may not be much help to people who are not already familiar with
# the tools needed to build the web site, but it does print out a friendly
# reminder to those who understand it. For all else, there is "RTFS". :-)
#
# Note: there is one rule that should not be in this list. We want to make sure
# to thank people for not adding it if they find it, perhaps with a hint right
# here!
#
help:
	@echo '# Rules for those who wish to expore the winning IOCCC entries:'
	@echo
	@echo 'make clobber		 - Remove all temprary, compiled and constructed files from all winning IOCCC entries'
	@echo 'make all		 - Compile all winning IOCCC entries'
	@echo
	@echo 'make alt		 - Compile all alternative executables for winning IOCCC entries'
	@echo 'make everything		 - make all and make alt'
	@echo
	@echo 'make diff_orig_prog	- diff original source and current source'
	@echo 'make diff_prog_orig	- diff current source and original source'
	@echo
	@echo 'make diff_alt_prog	- diff alternative source and current source'
	@echo 'make diff_prog_alt	- diff current source and alternative source'
	@echo
	@echo 'make diff_alt_orig	- diff alternative source and original source'
	@echo 'make diff_orig_alt	- diff original source and alternative source'
	@echo
	@echo '# Rules for building a local copy of the IOCCC web site:'
	@echo
	@echo 'make genpath		 - form top level .top, YYYY level .year and winner .path files'
	@echo 'make genfilelist	 - generate YYYY level .filelist'
	@echo 'make verify_entry_files	 - check to be sure all files in all entries exist'
	@echo 'make gen_authors	 - generate the top level authors.html page'
	@echo 'make gen_location	 - generate the top level location.html page'
	@echo 'make gen_years		 - generate the top level years.html page'
	@echo 'make entry_index	 - force the build of ALL winner index.html files'
	@echo 'make gen_other_html	 - build entry HTML files from markdown other than README.md'
	@echo 'make gen_year_index	 - generate year level index.html files using the'
	@echo 'make gen_top_html	 - generate a number of the top level HTML files from markdown'
	@echo 'make quick_entry_index	 - build winner index.html files that might be out of date'
	@echo 'make find_missing_links	 - find markdown links to missing local files'
	@echo
	@echo '# Compound make rules for building a local copy of the IOCCC web site:'
	@echo
	@echo 'make quick_www		 - generate html files more quickly, checking timestamps'
	@echo 'make www		 - build html pages for web site'
	@echo
	@echo '# Rules that are useful only for those IOCCC judges who mainain the official IOCCC web site:'
	@echo
	@echo 'make sort_gitignore	 - sort .gitignore files according to rules in bin/sgi.sh'
	@echo
	@echo 'make untar_entry_tarball - untar all entry tarballs'
	@echo 'make untar_year_tarball	 - untar all year level tarballs'
	@echo
	@echo 'make form_entry_tarball	 - form all entry compressed tarballs'
	@echo 'make form_year_tarball	 - form all IOCCC year level compressed tarballs'
	@echo 'make tar		 - build all tarballs'
	@echo
	@echo 'make gen_status		 - generate status.json and status.html'
	@echo 'make gen_sitemap	 - generate the XML sitemap'
	@echo 'make timestamp		 - generate things with timestamps (status, sitemap etc.)'
	@echo
	@echo 'make update		 - update everything in a local copy of the web site'

# form the top level .top, YYYY level .year and winner level .path files
#
# IMPORTANT: This file assumes that make clobber was previously done.
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
	else \
	    ${MV} -f .tmp.genpath .top; \
	    ${CHMOD} 0444 .top; \
	    echo "updated .top"; \
	fi
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate YYYY level .filelist
#
# IMPORTANT: .filelist assumes that make clobber was previously done.
#
genfilelist:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    ${RM} -f "$$i/.genfilelist.tmp"; \
	    ${FIND} "$$i" -mindepth 1 -maxdepth 1 -type f ! -path "$$i/.genfilelist.tmp" \
		    ! -name .DS_Store ! -name '*.swp' | \
	      ${SORT} -f -d -u > "$$i/.genfilelist.tmp"; \
	    if ${CMP} -s "$$i/.genfilelist.tmp" "$$i/.filelist"; then \
		${RM} -f "$$i/.genfilelist.tmp"; \
	    else \
		${MV} -f "$$i/.genfilelist.tmp" "$$i/.filelist"; \
		${CHMOD} 0444 "$$i/.filelist"; \
		echo "updated $$i/.filelist"; \
	    fi; \
	done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# check to be sure all files in all entries exist
#
verify_entry_files: ${ALL_RUN} ${CHK_ENTRY}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 1 ${CHK_ENTRY}
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# sort .gitignore files according to rules in bin/sgi.sh
#
sort_gitignore: ${ALL_RUN} ${SORT_GITIGNORE}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 1 ${SORT_GITIGNORE} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level authors.html page using the
# ${GEN_AUTHORS} tool (bin/gen-authors.sh).
#
gen_authors: ${GEN_AUTHORS} authors.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_AUTHORS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level location.html page using the
# ${GEN_LOCATION} tool (bin/gen-location.sh).
#
gen_location: ${GEN_LOCATION} location.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_LOCATION} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level years.html page using the ${GEN_YEARS}
# tool (bin/gen-years.sh).
#
gen_years: ${GEN_YEARS} years.html
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_YEARS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# force the build of ALL winner index.html files using
# the ${README2INDEX} tool (bin/readme2index.sh)
#
entry_index readme2index: ${ALL_RUN} ${README2INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${README2INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate a number of the top level HTML files from top level markdown files
#
gen_top_html: ${GEN_TOP_HTML}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_TOP_HTML} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

#   Say, can you see
#   By the dawn's early light
#   What so proudly we hailed
#   At the twilight's last gleaming?
#
#   Whose broad stripes and bright stars
#   Through the perilous fight
#   O'er the ramparts we watched
#   Were so gallantly, yeah, streaming?
#
#   And the rockets' red glare
#   The bombs bursting in air
#   Gave proof through the night
#   That our flag was still there
#
#   O say, does that star-spangled banner yet wave
#   O'er the land of the free and the home of the brave
#
# Just kidding .. So Long, and Thanks for All the Fish :-)
thanks: ${GEN_TOP_HTML} thanks-for-help.md
	@echo "Thanks for all the help ..."
	@${GEN_TOP_HTML} thanks-for-help
	@echo "... and thanks for all the fish :-)"

# build entry HTML files from markdown other than README.md to index.html
#
gen_other_html: ${GEN_OTHER_HTML}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_OTHER_HTML} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate year level index.html files using the
# ${GEN_YEAR_INDEX} tool (bin/gen-year-index.sh).
#
gen_year_index: ${ALL_YEARS} ${GEN_YEAR_INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_YEARS} -v 1 ${GEN_YEAR_INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build winner index.html files that might be out of date
#
# This rule uses the ${QUICK_README2INDEX} tool
# (bin/quick-readme2index.sh), so some winner
# index.html files that seem to be up to date
# (but might not be up to date) won't be built.
#
quick_entry_index quick_readme2index: ${ALL_RUN} ${QUICK_README2INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${QUICK_README2INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# find markdown links to missing local files
#
find_missing_links:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${FIND_MISSING_LINKS} -v 1
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
	@echo '=-=-=-=-=-= IOCCC begin make $@ =-=-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make clobber =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} clobber >/dev/null
	@echo '=-=-=-=-= IOCCC complete make clobber =-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make genpath =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} genpath >/dev/null
	@echo '=-=-=-=-= IOCCC complete make genpath =-=-=-=-='
	${MAKE} genfilelist
	${MAKE} verify_entry_files
	${MAKE} gen_authors
	${MAKE} gen_location
	${MAKE} gen_years
	${MAKE} gen_year_index
	${MAKE} gen_top_html
	${MAKE} quick_entry_index
	${MAKE} gen_other_html
	${MAKE} find_missing_links
	@echo '=-=-=-=-=-= IOCCC complete make $@ =-=-=-=-=-='

# do everything needed to build HTML content for the web site
#
# Well, short of pushing changes to the GitHub repo, that is.  :-)
#
www:
	@echo '=-=-=-=-=-= IOCCC begin make $@ =-=-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make clobber =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} clobber >/dev/null
	@echo '=-=-=-=-= IOCCC complete make clobber =-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make genpath =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} genpath >/dev/null
	@echo '=-=-=-=-= IOCCC complete make genpath =-=-=-=-='
	${MAKE} genfilelist
	${MAKE} verify_entry_files
	${MAKE} gen_authors
	${MAKE} gen_location
	${MAKE} gen_years
	${MAKE} gen_year_index
	${MAKE} gen_top_html
	${MAKE} entry_index
	${MAKE} gen_other_html
	${MAKE} find_missing_links
	@echo '=-=-=-=-=-= IOCCC complete make $@ =-=-=-=-=-='

# untar all entry tarballs
#
untar_entry_tarball: ${ALL_RUN}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${UNTAR_ENTRY} -v 1
	${MAKE} verify_entry_files
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# untar all year level tarballs
#
untar_year_tarball: ${ALL_RUN}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_YEARS} -v 3 ${UNTAR_YEAR} -v 1
	${MAKE} verify_entry_files
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# form all entry compressed tarballs
#
form_entry_tarball: ${ALL_RUN} ${TAR_ENTRY}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_RUN} -v 3 ${TAR_ENTRY} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# form all IOCCC year level compressed tarballs
#
form_year_tarball: ${ALL_YEARS} ${TAR_YEAR}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_YEARS} -v 3 ${TAR_YEAR} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build all tarballs
#
tar:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} clobber
	${MAKE} genpath
	${MAKE} genfilelist
	${MAKE} verify_entry_files
	${MAKE} sort_gitignore
	${MAKE} form_entry_tarball
	${MAKE} form_year_tarball
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate status.json and status.html
#
gen_status: ${GEN_STATUS}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} gen_top_html
	${GEN_STATUS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the XML sitemap
#
gen_sitemap sitemap: ${GEN_SITEMAP}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_SITEMAP} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate things with timestamps
#
timestamp:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} gen_status
	${MAKE} gen_top_html
	${MAKE} gen_sitemap
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# update everything on the web site
#
update:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} www
	${MAKE} tar
	${MAKE} timestamp
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
