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
# IOCCC website maintenance tulz
#################################

# NOTE: The "tulz" (tools) in this section are intended to be used by those
#	who maintain the official IOCCC site.
#
# The "tulz" paths should be relative to the top directory of the repo.
# We need only list those "tulz" that are invoked directly by the
# "IOCCC website maintenance rulz" section below.

ALL_RUN= bin/all-run.sh
ALL_YEARS= bin/all-years.sh
GEN_AUTHORS= bin/gen-authors.sh
GEN_LOCATION= bin/gen-location.sh
GEN_YEARS= bin/gen-years.sh
GEN_YEAR_INDEX= bin/gen-year-index.sh
ALL_JFMT= bin/all-jfmt.sh
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
FIND_INVALID_JSON= bin/find-invalid-json.sh
CSV2ENTRY= bin/csv2entry.sh
ENTRY2CSV= bin/entry2csv.sh


#############
# IOCCC years
#############
#
# BEGIN - DO NOT REMOVE THIS LINE - make new_year uses this line #
YEARS= 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 \
	1996 1998 2000 2001 2004 2005 2006 2011 2012 2013 2014 2015 2018 \
	2019 2020
# END - DO NOT REMOVE THIS LINE - make new_year also uses this #

###################
# build all entries
###################
#
all:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
	done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install clang-format genpath new_year genpath_top

# alternative executable
#
alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# data files
#
data:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# both all and alt
#
everything:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
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
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff source and orig source
#
diff_prog_orig:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff alt source and source
#
diff_alt_prog:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff source and alt source
#
diff_prog_alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff orig and alt
#
diff_orig_alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    (cd $$i; make $@); \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

diff_alt_orig:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


###############
# utility rules
###############
#
clean:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

clobber:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


#################################
# IOCCC website maintenance rulz
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

.PHONY: help genpath genfilelist all_jfmt verify_entry_files gen_authors quick_authors \
	gen_location quick_location gen_years find_missing_links test entry_index gen_top_html \
	gen_next thanks gen_other_html quick_other_html quick_entry_index find_invalid_json \
	gen_year_index quick_year_index quick_www www untar_entry_tarball untar_year_tarball \
	form_entry_tarball form_year_tarball tar gen_status gen_sitemap \
	sitemap timestamp update csv2entry entry2csv about contact pw_change submit news

# Suggest rules in this section
#
# This may not be much help to people who are not already familiar with
# the tools needed to build the website, but it does print out a friendly
# reminder to those who understand it. For all else, there is "RTFS". :-)
#
help:
	@echo '# Rules for those who wish to expore the winning IOCCC entries:'
	@echo
	@echo 'make clobber		;: remove all temporary, compiled and constructed files from all winning IOCCC entries'
	@echo 'make all		;: compile all winning IOCCC entries'
	@echo
	@echo 'make alt		;: compile all alternative executables for winning IOCCC entries'
	@echo 'make everything		;: make all and make alt'
	@echo
	@echo 'make diff_orig_prog	;: diff original source and current source'
	@echo 'make diff_prog_orig	;: diff current source and original source'
	@echo 'make diff_alt_prog	;: diff alternative source and current source'
	@echo 'make diff_prog_alt	;: diff current source and alternative source'
	@echo 'make diff_alt_orig	;: diff alternative source and original source'
	@echo 'make diff_orig_alt	;: diff original source and alternative source'
	@echo
	@echo '# Rules for building a local copy of the IOCCC website:'
	@echo
	@echo 'make tab_check		;: check for ASCII tabs in markdown files'
	@echo 'make genpath		;: form top level .top and .allyear, YYYY level .year and winner .path files'
	@echo 'make genfilelist	;: generate YYYY level .filelist'
	@echo 'make verify_entry_files	;: check to be sure all files in all entries exist'
	@echo 'make sort_gitignore	;: sort .gitignore files according to rules in bin/sgi.sh'
	@echo 'make gen_authors	;: generate the top level authors.html page'
	@echo 'make quick_authors	;: build authors.html if out of date with author JSON files'
	@echo 'make gen_location	;: generate the top level location.html page'
	@echo 'make quick_location	;: build location.html if out of date with author JSON files'
	@echo 'make gen_years		;: generate the top level years.html page'
	@echo 'make entry_index	;: force the build of ALL winner index.html files'
	@echo 'make gen_other_html	;: build entry HTML files from markdown other than README.md'
	@echo 'make quick_other_html	;: build entry non-index.html files that might be out of date'
	@echo 'make gen_year_index	;: generate year level index.html files using from README.md files'
	@echo 'make quick_year_index	;: generate year level index.html when year level README.md is newer'
	@echo 'make gen_top_html	;: generate a number of the top level HTML files from markdown'
	@echo 'make gen_next		;: generate the HTML files in next/'
	@echo 'make quick_entry_index	;: build winner index.html files that might be out of date'
	@echo 'make find_missing_links	;: find markdown links to missing local files'
	@echo 'make find_invalid_json	;; find invalid JSON files'
	@echo
	@echo 'make test		;: summary of mostly harmless tests'
	@echo
	@echo 'make entry2csv		;: convert all .entry.json files into 3 CSV files'
	@echo 'make csv2entry		;: rebuild all all .entry.json files from 3 CSV spreadsheets'
	@echo
	@echo '# Rules for building specific web pages, a subset of rules mentioned above:'
	@echo
	@echo 'make about		;: generate about.html'
	@echo 'make bugs		;: generate bugs.html'
	@echo 'make contact		;: generate contact.html'
	@echo 'make faq		;: generate faq.html'
	@echo 'make guidelines		;: generate next/guidelines.hmtl'
	@echo 'make markdown		;: generate markdown.html'
	@echo 'make news		;: generate news.html'
	@echo 'make pw_change		;: generate next/pw-change.html'
	@echo 'make remarks		;: generate next/remarks.html'
	@echo 'make rules		;: generate next/rules.hmtl'
	@echo 'make security		;: generate SECURITY.html'
	@echo 'make social		;: generate social.html'
	@echo 'make submit		;: generate next/submit.html'
	@echo 'make thanks		;: generate thanks-for-help.html'
	@echo
	@echo '# Compound make rules for building a local copy of the IOCCC website:'
	@echo
	@echo 'make quick_www		;: generate html files more quickly, checking timestamps'
	@echo 'make www		;: build html pages for website'
	@echo
	@echo '# Rules that are useful only for those IOCCC judges who maintain the official IOCCC website:'
	@echo
	@echo 'make untar_entry_tarball;: untar all entry tarballs'
	@echo 'make untar_year_tarball	;: untar all year level tarballs'
	@echo
	@echo 'make all_jfmt		;: convert all entry and author JSON files into canonical form'
	@echo
	@echo 'make form_entry_tarball	;: form all entry compressed tarballs'
	@echo 'make form_year_tarball	;: form all IOCCC year level compressed tarballs'
	@echo 'make tar		;: build all tarballs'
	@echo
	@echo 'make gen_status		;: generate status.json and status.html'
	@echo 'make gen_sitemap	;: generate the XML sitemap'
	@echo 'make timestamp		;: generate things with timestamps (status, sitemap etc.)'
	@echo
	@echo 'make update		;: update everything in a local copy of the website'


######################################################
# Rules for building a local copy of the IOCCC website
######################################################

# verify that there are no leading ASCII tabs in leading whitespace in markdown files
#
tab_check:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@TAB_LIST="$$(${FIND} * \( -name NOTES -o -name tmp -o -name markdown.md \) -prune -o \
				     -type f -name '*.md' -print0 | \
			      ${XARGS} -0 ${GREP} -E -l '	')"; \
	    if [[ -n $$TAB_LIST ]]; then \
	        echo "$@: ERROR: ASCII tab found in markdown file(s)" 1>&2 ; \
		echo "$0: Warning: list of offending markdown file(s) starts below" 1>&2 ; \
		echo "$${TAB_LIST}" 1>&2 ; \
		echo "$0: Warning: list of offending markdown file(s) ends above" 1>&2 ; \
		exit 1; \
	    fi
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# form the top level .top and .allyear, YYYY level .year and winner level .path files
#
# IMPORTANT: This file assumes that make clobber was previously done.
#
genpath:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@${MAKE} genpath_top
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@${RM} -f ".allyear.tmp"
	@for i in ${YEARS}; do \
	    cat "$$i/.year"; \
	done | ${SORT} -f -d -u > ".allyear.tmp"
	@if ${CMP} -s ".allyear.tmp" .allyear; then \
	    ${RM} -f ".allyear.tmp"; \
	else \
	    ${MV} -f ".allyear.tmp" .allyear; \
	    ${CHMOD} 0444 .allyear; \
	fi
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate YYYY level .filelist
#
# This rule assumes that a YYYY/README.md will produce a YYYY/index.html file.
# This rule assumes that if there is a YYYY/rules.md then YYYY/rules.html will be created.
# This rule assumes that if there is a YYYY/guidelines.md then YYYY/guidelines.html will be created.
# These html files may be later created or updated by the quick_year_index or gen_year_index rules.
#
# IMPORTANT: .filelist assumes that make clobber was previously done.
#
genfilelist:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    ${RM} -f "$$i/.genfilelist.tmp"; \
	    (${FIND} "$$i" -mindepth 1 -maxdepth 1 -type f -name '*.md' | \
		${SED} -e 's/\.md$$/.html/' -e 's/\/README\.html/\/index.html/'; \
	     ${FIND} "$$i" -mindepth 1 -maxdepth 1 -type f ! -path "$$i/.genfilelist.tmp" \
		    ! -name .DS_Store ! -name '*.swp') | \
	      LANG=C ${SORT} -f -d -u > "$$i/.genfilelist.tmp"; \
	    if ${CMP} -s "$$i/.genfilelist.tmp" "$$i/.filelist"; then \
		${RM} -f "$$i/.genfilelist.tmp"; \
	    else \
		${MV} -f "$$i/.genfilelist.tmp" "$$i/.filelist"; \
		${CHMOD} 0444 "$$i/.filelist"; \
		echo "updated $$i/.filelist"; \
	    fi; \
	done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# be sure that all JSON files are canonical
#
all_jfmt: ${ALL_RUN} ${CHK_ENTRY}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_JFMT} -v 1
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
# ${GEN_AUTHORS} tool bin/gen-authors.sh.
#
gen_authors: ${GEN_AUTHORS}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_AUTHORS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='



# build authors.html if it is out of date from any author/author_handle.json file
#
quick_authors: ${GEN_AUTHORS}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_AUTHORS} -v 1 -Q
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level location.html page using the
# ${GEN_LOCATION} tool bin/gen-location.sh.
#
gen_location: ${GEN_LOCATION}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_LOCATION} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build location.html if it is out of date from any author/author_handle.json file
#
# generate the top level location.html page using the
# ${GEN_LOCATION} tool bin/gen-location.sh.
#
quick_location: ${GEN_LOCATION}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_LOCATION} -v 1 -Q
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate the top level years.html page using the ${GEN_YEARS}
# tool bin/gen-years.sh.
#
gen_years: ${GEN_YEARS}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_YEARS} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# force the build of ALL winner index.html files using
# the ${README2INDEX} tool bin/readme2index.sh
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

gen_next: ${GEN_TOP_HTML} next/README.md next/guidelines.md next/rules.md next/register.md next/submit.md next/pw-change.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_TOP_HTML} -v 1 next/README
	${GEN_TOP_HTML} -v 1 next/guidelines
	${GEN_TOP_HTML} -v 1 next/rules
	${GEN_TOP_HTML} -v 1 next/register
	${GEN_TOP_HTML} -v 1 next/remarks
	${GEN_TOP_HTML} -v 1 next/submit
	${GEN_TOP_HTML} -v 1 next/pw-change
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build entry HTML files, other than README.md to index.html, from markdown
#
gen_other_html: ${GEN_OTHER_HTML}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_OTHER_HTML} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build entry HTML files from non-README.md markdown files that might be out of date
#
# This rule uses the -Q option of ${GEN_OTHER_HTML}, so that some
# non-README.md markdown files that seem to be up to date (but might
# not be up to date) won't be built.
#
quick_other_html: ${GEN_OTHER_HTML}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_OTHER_HTML} -v 1 -Q
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate year level index.html files using the
# ${GEN_YEAR_INDEX} tool bin/gen-year-index.sh.
#
gen_year_index: ${ALL_YEARS} ${GEN_YEAR_INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_YEARS} -v 1 ${GEN_YEAR_INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate year level index.html files when year level README.md is newer
#
# generate year level index.html files using the
# ${GEN_YEAR_INDEX} tool bin/gen-year-index.sh.
#
quick_year_index: ${ALL_YEARS} ${GEN_YEAR_INDEX}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ALL_YEARS} -v 1 -Q ${GEN_YEAR_INDEX} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# build winner index.html files that might be out of date
#
# This rule uses the ${QUICK_README2INDEX} tool
# bin/quick-readme2index.sh, so some winner
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

# find invalid JSON files
#
find_invalid_json:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${FIND_INVALID_JSON} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# convert author_wins.csv, manifest.csv and year_prize.csv CSV files to
# .entry.json files.
#
csv2entry:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${CSV2ENTRY} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# convert .entry.json files to author_wins.csv, manifest.csv and year_prize.csv
# CSV files.
#
entry2csv:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${ENTRY2CSV} -v 1
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# Mostly Harmless tests
#
test:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make clobber =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} clobber >/dev/null
	@echo '=-=-=-=-= IOCCC complete make clobber =-=-=-=-='
	@${MAKE} tab_check
	@echo '=-=-=-=-= IOCCC begin make genpath =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} genpath >/dev/null
	@echo '=-=-=-=-= IOCCC complete make genpath =-=-=-=-='
	${MAKE} genfilelist
	${MAKE} verify_entry_files
	${MAKE} find_missing_links
	${MAKE} find_invalid_json
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


###########################################################################
# Rules for building specific web pages - a subset of rules mentioned above
###########################################################################

.PHONY: about bugs contact faq guidelines markdown rules \
	security social submit thanks

# generate about.html
#
# What is this all about? It is better that you do not decipher what this is all
# about because if anyone ever does discover exactly what the IOCCC is for and
# why it is here, it will instantly disappear and be replaced by something even
# more bizarre and inexplicable!
#
about: ${GEN_TOP_HTML} about.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You wonder what this is all about?"
	@${GEN_TOP_HTML} about
	@echo
	@echo "You better not find out, because if you"
	@echo "find out, it will instantly be replaced"
	@echo "by something even more bizarre and"
	@echo "inexplicable!"
	@echo
	@echo "Nobody wants that, do they?"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# Bugs Bunny rule
bugs: ${GEN_TOP_HTML} bugs.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "Shhh. Be vewy vewy quiet."
	@echo "I'm hunting wabbits 🐇 .. and bugs 🪳🪲🦟🐜🐛."
	${GEN_TOP_HTML} bugs
	@echo "Eh, what's up, doc?"
	@echo
	@echo "I'm hunting wabbits 🐇 .. and bugs 🪳🪲🦟🐜🐛"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate contact.html
#
contact: ${GEN_TOP_HTML} contact.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You wish to make contact with the IOCCC Judges?"
	${GEN_TOP_HTML} contact
	@echo
	@echo "I hope you're used to confused aliens!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

faq: ${GEN_TOP_HTML} faq.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You have a question ⁉️ ?"
	${GEN_TOP_HTML} -v 1 faq
	@echo "Perhaps the FAQ might help!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

guidelines: ${GEN_TOP_HTML} next/guidelines.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_TOP_HTML} -v 1 next/guidelines
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

markdown: ${GEN_TOP_HTML} markdown.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You want to markdown?"
	${GEN_TOP_HTML} markdown
	@echo "Careful that we don't mark down your submission!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

news: gen_status ${GEN_TOP_HTML} markdown.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "All the IOCCC news 📰 ..."
	${GEN_TOP_HTML} news
	@echo "that's fit browse 💻!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

pw_change: next/pw-change.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "Did your password get breached?"
	${GEN_TOP_HTML} next/pw-change
	@echo "Perhaps you should change your password!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

remarks: ${GEN_TOP_HTML} next/remarks.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@${GEN_TOP_HTML} -v 1 next/remarks
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

rules: ${GEN_TOP_HTML} next/rules.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You wish to change the IOCCC rules?"
	${GEN_TOP_HTML} -v 1 next/rules
	@echo "Be careful you don't break them!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

security: ${GEN_TOP_HTML} SECURITY.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You wish to make IOCCC entries secure?"
	@${GEN_TOP_HTML} SECURITY
	@echo "We also didn't want Pluto 🪐 demoted!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

social: social.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "This rule is sponsored by the Royal Society"
	${GEN_TOP_HTML} social
	@echo "For Putting Things On Top of Other Things"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

submit: next/submit.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "You wish to submit to the IOCCC?"
	${GEN_TOP_HTML} next/pw-change
	@echo "Be careful, we only have a pet fish 🐟"
	@echo "called Eric, not a service dog 🐕‍🦺!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate thanks-for-help.html
#
# So Long, and Thanks for All the Fish :-)
#
thanks: ${GEN_TOP_HTML} thanks-for-help.md
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "Thanks for all the help ..."
	${GEN_TOP_HTML} thanks-for-help
	@echo "... and thanks for all the fish 🐟🐠🎏 :-)"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


####################################################################
# Compound make rules for building a local copy of the IOCCC website
####################################################################

# do work to build HTML content for the website
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
	@${MAKE} tab_check
	@echo '=-=-=-=-= IOCCC begin make genpath =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} genpath >/dev/null
	@echo '=-=-=-=-= IOCCC complete make genpath =-=-=-=-='
	${MAKE} genfilelist
	${MAKE} sort_gitignore
	${MAKE} verify_entry_files
	${MAKE} quick_authors
	${MAKE} quick_location
	${MAKE} gen_years
	${MAKE} quick_year_index
	${MAKE} gen_top_html
	${MAKE} quick_entry_index
	${MAKE} quick_other_html
	${MAKE} gen_status
	${MAKE} gen_sitemap
	${MAKE} find_missing_links
	@echo '=-=-=-=-=-= IOCCC complete make $@ =-=-=-=-=-='

# do everything needed to build HTML content for the website
#
# Well, short of pushing changes to the GitHub repo, that is.  :-)
#
www:
	@echo '=-=-=-=-=-= IOCCC begin make $@ =-=-=-=-=-='
	@echo '=-=-=-=-= IOCCC begin make clobber =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} clobber >/dev/null
	@echo '=-=-=-=-= IOCCC complete make clobber =-=-=-=-='
	@${MAKE} tab_check
	@echo '=-=-=-=-= IOCCC begin make genpath =-=-=-=-='
	@echo '... hiding verbose output on stdout ...'
	@${MAKE} genpath >/dev/null
	@echo '=-=-=-=-= IOCCC complete make genpath =-=-=-=-='
	${MAKE} genfilelist
	${MAKE} sort_gitignore
	${MAKE} verify_entry_files
	${MAKE} gen_authors
	${MAKE} gen_location
	${MAKE} gen_years
	${MAKE} gen_year_index
	${MAKE} gen_top_html
	${MAKE} entry_index
	${MAKE} gen_other_html
	${MAKE} gen_status
	${MAKE} gen_sitemap
	${MAKE} find_invalid_json
	${MAKE} find_missing_links
	@echo '=-=-=-=-=-= IOCCC complete make $@ =-=-=-=-=-='


###########################################################################################
# Rules that are useful only for those IOCCC judges who maintain the official IOCCC website
###########################################################################################

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
	${MAKE} all_jfmt
	${MAKE} verify_entry_files
	${MAKE} sort_gitignore
	${MAKE} form_entry_tarball
	${MAKE} form_year_tarball
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# generate status.json and status.html
#
gen_status: ${GEN_STATUS}
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${GEN_STATUS} -v 1
	${MAKE} gen_next
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
	${MAKE} gen_sitemap
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# update everything on the website
#
update:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	${MAKE} www
	${MAKE} tar
	${MAKE} timestamp
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


#############################################################
# NOTE: 'Don't Panic' if you don't understand the stuff below
#############################################################

# add ${NEW_YEAR} to the list of ${YEARS} and output Makefile lines to set updated ${YEARS} value
#
new_year:
	@(echo 'YEARS= '; \
	  (echo ${YEARS} ${NEW_YEAR}) | ${TR} ' ' '\012' | ${SORT} -n -u) | \
	  ${FMT} | ${SED} -e '2,$$s/^/\t/' -e 's/$$/ \\/' -e '$$s/ \\//'

# form the top level .top only
#
genpath_top:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@${RM} -f .tmp.genpath
	@-for i in ${YEARS}; do \
	    echo "$$i" >> .tmp.genpath; \
        done
	${SORT} -n -u .tmp.genpath -o .tmp.genpath;
	@-if ${CMP} -s .tmp.genpath .top; then \
	    ${RM} -f .tmp.genpath; \
	else \
	    ${MV} -f .tmp.genpath .top; \
	    ${CHMOD} 0444 .top; \
	    echo "updated .top"; \
	fi
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


########################
# extended utility rules
########################

.PHONY: indent_clean indent_clobber

# you may be able to misunderstand the source by reading indent.c
#
indent.c:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

indent_clean: clean
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

indent_clobber: indent_clean clobber
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

install:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

clang-format:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


#############################################################
# NOTE: 'Don't Panic' if you don't understand the stuff below
#############################################################


##################
# 1337 hacker rulz
##################

love:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

haste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

waste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

maker:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

easter_egg:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@echo "Finding the Easter eggs 🥚 ..."
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo "Found all the Easter eggs 🥚!"
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

sandwich:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

more_magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

charon:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

pluto:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in ${YEARS}; do \
	    if [[ -f $$i/Makefile ]]; then \
		echo "cd $$i; make $@"; \
		(cd $$i; make $@); \
	    else \
		echo "Warning: $$i/Makefile not found, skipping $$i for $@ processing" 1>&2 ; \
	    fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='
