#!/usr/bin/env make
#
# 1987 makefile
#
# This work by Landon Curt Noll, Simon Cooper, and Leonid A. Broukhis
# is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


################
# tool locations
################
#
SHELL= /bin/bash
CP= cp
CPP= cpp
GUNZIP= gunzip
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true

# for System V style systems
OPSYS= -Dindex=strchr
# for BSD style systems
#OPSYS=

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
CC= cc


###############
# IOCCC winners
###############
#
WINNERS= heckbert wall westley hines korn biggar lievaart

###################
# build all entries
###################
#
all:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) OPSYS=${OPSYS} $@)"; \
	    (cd $$i && $(MAKE) "OPSYS=${OPSYS}" $@); \
	done


###############
# utility rules
###############
#
clean:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

clobber:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

install:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done
