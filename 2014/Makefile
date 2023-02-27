#!/usr/bin/env make
#
# 2014 makefile
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

# Set X11_LIBDIR to the directory where the X11 library resides
#
X11_LIBDIR= /usr/X11R6/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
X11_INCDIR= /usr/X11R6/include

# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
CC= cc


###############
# IOCCC winners
###############
#
WINNERS= birken deak endoh1 endoh2 maffiodo1 maffiodo2 morgan sinon skeggs vik wiedijk

###################
# build all entries
###################
#
all:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) X11_LIBDIR=${X11_LIBDIR} X11_INCDIR=${X11_INCDIR} $@)"; \
	    (cd $$i && $(MAKE) "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" $@); \
	done

# alternative executable
#
alt:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) X11_LIBDIR=${X11_LIBDIR} X11_INCDIR=${X11_INCDIR} $@)"; \
	    (cd $$i && $(MAKE) "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" $@); \
	done


###############
# utility rules
###############
#
everything: all alt

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

nuke: clobber
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

install:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done


##################
# 133t hacker rulz
##################
#
love:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

haste:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

waste:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

easter_egg:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

deep_magic:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done

magic:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) $@)"; \
	    (cd $$i && $(MAKE) $@); \
	done
