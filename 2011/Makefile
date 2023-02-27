#!/usr/bin/env make
#
# 2011 makefile
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
WINNERS= akari blakely borsanyi dlowe eastman fredriksson goren hou \
	 konno hamaji richards toledo vik zucker


###################
# build all entries
###################
#
all:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i X11_LIBDIR=${X11_LIBDIR} X11_INCDIR=${X11_INCDIR} $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" $@); \
	done

# alternative executable
#
alt:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i X11_LIBDIR=${X11_LIBDIR} X11_INCDIR=${X11_INCDIR} $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" "X11_LIBDIR=${X11_LIBDIR}" "X11_INCDIR=${X11_INCDIR}" $@); \
	done


###############
# utility rules
###############
#
everything: all alt

clean:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" $@); \
	done

clobber: clean
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" $@); \
	done

nuke: clobber
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" $@); \
	done

install:
	@for i in ${WINNERS} ; do \
	    echo "(cd $$i && $(MAKE) ENTRY=$$i $@)"; \
	    (cd $$i && $(MAKE) "ENTRY=$$i" $@); \
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
	@echo Readers shall not be disallowed from being unable to partly misunderstand this final echo.
	@${TRUE}
