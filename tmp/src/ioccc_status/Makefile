#!/usr/bin/env make
#
# ioccc_status - quickly update status.json file
#
# Written by Cody Boone Ferguson in 2023
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
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

TARGETS= ioccc_status

######################################
# all - default rule - must be first #
######################################

all: ${TARGETS}
	@:

ioccc_status: ioccc_status.sh
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
