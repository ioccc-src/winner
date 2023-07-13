#!/usr/bin/env make
#
# sgit - run sed (by default with -i) on all files (or one or more globs) under
# git control.
#
# The most up to date version of this tool and everything related can be found
# at https://github.com/xexyl/sgit.
#
# - Cody Boone Ferguson / @xexyl
#
# This Makefile was created by Landon Curt Noll.
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

DESTDIR= ../../bin

TARGETS= sgit

######################################
# all - default rule - must be first #
######################################

all: ${TARGETS}

winner_name: winner_name.sh
	${RM} -f -v $@
	${CP} -f -v $? $@
	${CHMOD} +x $@

#################################################
# .PHONY list of rules that do not create files #
#################################################

.PHONY: all configure clean clobber install

###################################
# standard Makefile utility rules #
###################################

configure:
	@:

clean:
	@:

clobber: clean
	rm -f ${TARGETS}

install: all
	${INSTALL} -m 0555 ${TARGETS} ${DESTDIR}
