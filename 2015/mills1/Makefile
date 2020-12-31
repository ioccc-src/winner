#!/usr/bin/env make
#
# 2015 makefile
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
BUNZIP2= bunzip2
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true
MKDIR= mkdir
MV= mv
TR= tr
GREP= grep
SORT= sort
UNIQ= uniq

# Set X11_LIBDIR to the directory where the X11 library resides
#
#X11_LIBDIR= /usr/X11R6/lib
#X11_LIBDIR= /usr/X11/lib
X11_LIBDIR= /opt/X11/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
#X11_INCDIR= /usr/X11R6/include
#X11_INCDIR= /usr/X11/include
X11_INCDIR= /opt/X11/include

# Compiler warnings
#
#CWARN=
#CWARN= -Wall
#CWARN= -Wall -Wextra
CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything
#CWARN= -Wall -Wextra -Weverything -pedantic
#CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

# Silence warnings that ${CWARN} would normally complain about
#
#CSILENCE=
CSILENCE= -Wno-parentheses -Wno-implicit-function-declaration \
	  -Wno-missing-variable-declarations

# compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=c11

# compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitess:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# defines that are needed to compile
#
#CDEFINE=
CDEFINE= -DU=${DU} -DD=${DD} -DW=${DW} -DH=${DH} -DA=${DA} -DI=${DI} \
         -DB=${DB} -DF=${DF} -DG=${DG}


# Game parameters
#
DU=99999	# Time between steps in microseconds.
		# Make it larger if the game is too fast for you.

DW=28		# Pipe-to-pipe spacing, in columns.
		# Farther apart is easier.

DD=20		# Space between pipes.
		# The difference between DD and DW is the width of a pipe.
		# Narrow pipes are easier to fly though.

DH=8		# Height of gap in pipe.
		# Make this larger to make the game easier.

DA=100		# Acceleration due to gravity (scaled by 256).
		# Smaller values make you glide slower.

DI=-200		# Impulse velocity of a flap (scaled by 256).
		# Make larger if you want an less intense tapping experience!

DB='"<o^="'	# Sprite for player when gliding.
		# HINT: Try using various emoji.
		# NOTE: The string MUST be enclosed inside double quotes.

DF='"<ov="'	# Sprite for player when flapping.
		# HINT: Try using various emoji.
		# NOTE: The string MUST be enclosed inside double quotes.

DG='"Tap to Flap!"'	# Instruction text.
			# Change to your native tongue.
		# NOTE: The string MUST be enclosed inside double quotes.

# include files that are needed to compile
#
CINCLUDE=

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
# Reasonable compilers will allow for -O3.
#
#OPT=
#OPT= -O
#OPT= -O1
#OPT= -O2
OPT= -O3

# default flags for ANSI C compilation
#
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
#LIBS=
LIBS= -lcurses

#
# Here's some fun makefile overrides to try.  Pass them in by adding to the
# make commandline, eg
#
#  make EMOJI=beer LANGUAGE=spanish
#
# Note that use of the EMOJI path may require different include and linker
# options depending on how your system is set up.  The basic requirements is
# a copy of ncurses that that supports "wide" characters.  That could be
# called -lcurses, -lncurses or -lncurses, depending on how it was installed.
# it also might have been installed in a subdirectory and needs to be found
# with a different include and/or library path.
#

ifdef EMOJI
  # You may need to uncomment some of these, depending on your system
  # LIBS= -lncursesw
  # CINCLUDE= -I/usr/local/include/ncursesw

  ifeq ($(EMOJI),beer)
    DB='"\xf0\x9f\x8d\xba"'
    DF='"\xf0\x9f\x8d\xbb"'
  endif
  ifeq ($(EMOJI),smile)
    DB='"\xf0\x9f\x98\x84"'
    DF='"\xf0\x9f\x98\x81"'
  endif
  ifeq ($(EMOJI),bipolar)
    DB='"\xf0\x9f\x98\xa8"'
    DF='"\xf0\x9f\x98\xa1"'
  endif
  ifeq ($(EMOJI),toilet)
    DB='"\xf0\x9f\x9a\xbd"'
    DF='"\xf0\x9f\x92\xa6"'
  endif
  ifeq ($(EMOJI),ET)
    DB='"\xf0\x9f\x9a\xb4"'
    DF='"\xf0\x9f\x91\xbd"'
  endif
  ifeq ($(EMOJI),rocket)
    DB='"\xf0\x9f\x9a\x80"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),frylock)
    DB='"\xf0\x9f\x8d\x9f"'
    DF='"\xf0\x9f\x8e\x89"'
  endif
  ifeq ($(EMOJI),meatwad)
    DB='"\xf0\x9f\x8d\x98"'
    DF='"\xf0\x9f\x8d\x96"'
  endif
  ifeq ($(EMOJI),chicken)
    DB='"\xf0\x9f\x90\x93"'
    DF='"\xf0\x9f\x92\xa8"'
  endif
  ifeq ($(EMOJI),chick)
    DB='"\xf0\x9f\x90\xa4"'
    DF='"\xf0\x9f\x90\xa5"'
  endif
  ifeq ($(EMOJI),finger)
    DB='"\xf0\x9f\x91\x88"'
    DF='"\xf0\x9f\x91\x86"'
  endif
  ifeq ($(EMOJI),heart)
    DB='"\xf0\x9f\x92\x93"'
    DF='"\xf0\x9f\x92\x97"'
  endif
  ifeq ($(EMOJI),poop)
    DB='"\xf0\x9f\x92\xa9"'
    DF='"\xf0\x9f\x92\xa8"'
  endif
  ifeq ($(EMOJI),money)
    DB='"\xf0\x9f\x92\xb5"'
    DF='"\xf0\x9f\x92\xb8"'
  endif
  ifeq ($(EMOJI),book)
    DB='"\xf0\x9f\x93\x98"'
    DF='"\xf0\x9f\x93\x96"'
  endif
  ifeq ($(EMOJI),megaphone)
    DB='"\xf0\x9f\x93\xa2"'
    DF='"\xf0\x9f\x93\xa3"'
  endif
  ifeq ($(EMOJI),mailbox)
    DB='"\xf0\x9f\x93\xaa"'
    DF='"\xf0\x9f\x93\xab"'
  endif
  ifeq ($(EMOJI),lock)
    DB='"\xf0\x9f\x94\x92"'
    DF='"\xf0\x9f\x94\x93"'
  endif
  ifeq ($(EMOJI),fire)
    DB='"\xf0\x9f\x94\xa5"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),bomb)
    DB='"\xf0\x9f\x92\xa3"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),gun)
    DB='"\xf0\x9f\x94\xab"'
    DF='"\xf0\x9f\x92\xa5"'
  endif
  ifeq ($(EMOJI),knife)
    DB='"\xf0\x9f\x94\xaa"'
    DF='"\xf0\x9f\x92\xab"'
  endif
  ifeq ($(EMOJI),globe)
    DB='"\xf0\x9f\x8c\x8d"'
    DF='"\xf0\x9f\x8c\x8e"'
  endif


  # add some magic to call setlocale
  CFLAGS += -include locale.h \
	-Dmain='__attribute__((constructor))Z(){return!setlocale(LC_ALL,"");}int main'
endif

ifdef LANGUAGE

  ifeq ($(LANGUAGE),spanish)
    DG='"\xc2\xa1Pulse para batir!"'
  endif
  ifeq ($(LANGUAGE),french)
    DG='"Appuyez \xc3\xa0 battre"'
  endif

endif


# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
# Some entries seem to need gcc.  If you have gcc, set
# both CC and MAY_NEED_GCC to gcc.
#
# If you do not have gcc, set CC to the name of your ANSI compiler, and
# set MAY_NEED_GCC to either ${CC} (and hope for the best) or to just :
# to disable such programs.
#
CC= cc
#CC=clang
MAY_NEED_GCC= gcc


##############################
# Special flags for this entry
##############################
#
ENTRY= prog
CSRC= ${ENTRY}.c
OBJ= ${ENTRY}.o
DATA=
ALT_OBJ=
ALT_ENTRY=
TARGET= ${ENTRY}


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

${ENTRY}: ${CSRC}
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

# alternative executable
#
alt: ${ALT_ENTRY}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}


###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${TARGET} ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_ENTRY}

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely we are joking Dr. May!"
	@${TRUE}

# backwards compatibility
#
build: all
	@${TRUE}


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'
	@${TRUE}

haste:
	$(MAKE) waste
	@${TRUE}

waste:
	@echo 'haste'
	@${TRUE}

make:
	@echo 'Attend a maker faire'
	@${TRUE}

easter_egg:
	@echo you expected to sometimes mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from not failing to be unable to not partly misunderstand this partocular final echo.

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v5; \
	else \
	    echo "planet deniers, like the IAU, are amusing"; \
	fi
	@echo A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 2ed3582ec5c094a093fea2a6bcb9f19439892873c9cc45ed1ceaafe08b7d52e1b2c7cd524be3b0b2 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "You are holding it wrong!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 216091 --level 216193 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "These aren't the primes you're looking for Pauline!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: supernova
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet

pluto: supernova
	${MAKE} charon
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet
	@echo get used to having lots of planets because a $< can ${MAKE} a lot of them
