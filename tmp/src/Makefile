#!/usr/bin/env make
#
# src - all source for bin tools
#
# Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

#############
# utilities #
#############

CC= cc
CHMOD= chmod
CP= cp
INSTALL= install
RM= rm
SHELL= bash

#CFLAGS= -O3 -g3 --pedantic -Wall -Werror
CFLAGS= -O3 -g3 --pedantic -Wall

######################
# target information #
######################

TARGETS= winner_name

######################################
# all - default rule - must be first #
######################################

all: ${TARGETS}
	@for dir in ${TARGETS}; do \
	    if [[ ! -d $$dir ]]; then \
		echo "$0: FATAL: not a sub-directory: $$dir" 1>&2; \
		exit 1; \
	    fi; \
	    if [[ ! -f $$dir/Makefile ]]; then \
		echo "$0: FATAL: not a file: $$dir/Makefile" 1>&2; \
		exit 2; \
	    fi; \
	    echo "make -C \"$$dir\" $@"; \
	    make -C "$$dir" $@; \
	done

#################################################
# .PHONY list of rules that do not create files #
#################################################

.PHONY: all configure clean clobber install

###################################
# standard Makefile utility rules #
###################################

configure:
	@for dir in ${TARGETS}; do \
	    if [[ ! -d $$dir ]]; then \
		echo "$0: FATAL: not a sub-directory: $$dir" 1>&2; \
		exit 1; \
	    fi; \
	    if [[ ! -f $$dir/Makefile ]]; then \
		echo "$0: FATAL: not a file: $$dir/Makefile" 1>&2; \
		exit 2; \
	    fi; \
	    echo "make -C \"$$dir\" $@"; \
	    make -C "$$dir" $@; \
	done

clean:
	@for dir in ${TARGETS}; do \
	    if [[ ! -d $$dir ]]; then \
		echo "$0: FATAL: not a sub-directory: $$dir" 1>&2; \
		exit 1; \
	    fi; \
	    if [[ ! -f $$dir/Makefile ]]; then \
		echo "$0: FATAL: not a file: $$dir/Makefile" 1>&2; \
		exit 2; \
	    fi; \
	    echo "make -C \"$$dir\" $@"; \
	    make -C "$$dir" $@; \
	done

clobber: clean
	@for dir in ${TARGETS}; do \
	    if [[ ! -d $$dir ]]; then \
		echo "$0: FATAL: not a sub-directory: $$dir" 1>&2; \
		exit 1; \
	    fi; \
	    if [[ ! -f $$dir/Makefile ]]; then \
		echo "$0: FATAL: not a file: $$dir/Makefile" 1>&2; \
		exit 2; \
	    fi; \
	    echo "make -C \"$$dir\" $@"; \
	    make -C "$$dir" $@; \
	done

install: all
	@for dir in ${TARGETS}; do \
	    if [[ ! -d $$dir ]]; then \
		echo "$0: FATAL: not a sub-directory: $$dir" 1>&2; \
		exit 1; \
	    fi; \
	    if [[ ! -f $$dir/Makefile ]]; then \
		echo "$0: FATAL: not a file: $$dir/Makefile" 1>&2; \
		exit 2; \
	    fi; \
	    echo "make -C \"$$dir\" $@"; \
	    make -C "$$dir" $@; \
	done
