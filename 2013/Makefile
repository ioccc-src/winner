#!/usr/bin/env make
#
# 2013 makefile
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
WINNERS= birken cable1 cable2 cable3 dlowe endoh1 endoh2 endoh3 endoh4 \
         hou mills misaka morgan1 morgan2 robison

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
	@echo 'not war?'

haste:
	$(MAKE) waste

waste:
	@echo 'waste'

easter_egg:
	@echo you expected to mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall be disallowed from not being unable to partly misunderstand this partocular final echo.
	@${TRUE}

# These rules are written in the sytle of "I Am the Walrus"
# and in particular John Lennon's take on deep analysis of art. :-)
#
# See also the sub-directory Makefiles for non-propaganda.
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v3; \
	else \
	    echo "You are not expected to understand this"; \
	fi
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 1c2c85c7a02c55d1add91967eca491d53c101dc1 --FNV1a_hash 256-bit -R ."; \
	else \
	    echo "Understand different"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 391581 --level 216193 --FNV1a_hash 256-bit -R ."; \
	else \
	    echo "These aren't the droids you're looking for Mr. Spock!"; \
	fi
	@${TRUE}
