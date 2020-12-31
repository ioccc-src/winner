#!/usr/bin/env make
#
# 2018 makefile
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
GZIP_PROG= gzip
BZIP2= bzip2
CURL= curl
DD= dd
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
STRIP= strip

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
CSILENCE=
#CSILENCE= -Wno-implicit-int

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
# Some entries require 64-bitness:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# defines that are needed to compile
#
CDEFINE=
#CDEFINE= -DIOCCC=25

# include files that are needed to compile
#
CINCLUDE=
#CINCLUDE= -include stdlib.h
#CINCLUDE= -include stdio.h
#CINCLUDE= -include stdlib.h -include stdio.h
#CINCLUDE= -I ${X11_INCDIR}

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
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=
#LIBS= -L ${X11_LIBDIR}

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
OBJ= prog.o
DATA=
TARGET= left right shift msg0 msg1 msg2
#
ALT_OBJ=
ALT_TARGET=


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

left: prog.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

right: generated1.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

shift: generated2.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

msg0: generated3.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

msg1: generated4.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

msg2: generated5.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

generated1.c: prog.c left
	@${RM} -f $@
	./left < $< > $@

generated2.c: prog.c right
	@${RM} -f $@
	./right < $< > $@

generated3.c: prog.c left
	@${RM} -f $@
	./left < $< | ./left > $@

generated4.c: prog.c left shift
	@${RM} -f $@
	./shift < $< | ./left > $@

generated5.c: prog.c right shift
	@${RM} -f $@
	./shift < $< | ./right > $@

############
# spoilers #
############

spoiler: spoilers

spoilers:
	@echo "Really show spoilers?  Please build this target to confirm:"
	@echo "   i_give_up_show_me_the_spoilers"

i_give_up_show_me_the_spoilers: msg3 msg4 msg5 msg6 msg7 msg8 msg9

msg3: generated6.c
	$(CC) $(CFLAGS) $< -o $@

msg4: generated7.c
	$(CC) $(CFLAGS) $< -o $@

msg5: generated8.c
	$(CC) $(CFLAGS) $< -o $@

msg6: generated9.c
	$(CC) $(CFLAGS) $< -o $@

msg7: generated10.c
	$(CC) $(CFLAGS) $< -o $@

msg8: generated11.c
	$(CC) $(CFLAGS) $< -o $@

msg9: generated12.c
	$(CC) $(CFLAGS) $< -o $@

generated6.c: prog.c right left shift
	@${RM} -f $@
	./right < $< | ./shift | ./left > $@

generated7.c: prog.c right shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./right > $@

generated8.c: generated7.c right left shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./left > $@

generated9.c: generated8.c right shift
	@${RM} -f $@
	./right < $< | ./right | ./shift | ./right | ./shift | ./right > $@

generated10.c: generated9.c right left shift
	@${RM} -f $@
	./shift < $< | ./right | ./shift | ./left > $@

generated11.c: generated10.c right shift
	@${RM} -f $@
	./right < $< | ./right | ./shift | ./right | ./shift | ./right > $@

generated12.c: msg7
	./msg7 > $@

####################################
# spoilers for the truly_impatient #
####################################

spoiler_for_the_truly_impatient: i_just_want_to_see_the_final_message

i_just_want_to_see_the_final_message: msg11.txt
	@cat $<

msg11.txt: msg11 prog.c
	@${RM} -f $@
	./$< < prog.c > $@

msg10: generated13.c
	$(CC) $(CFLAGS) $< -o $@

msg11: generated14.c
	$(CC) $(CFLAGS) $< -o $@

generated13.c: prog.c left shift
	./left < $< | ./left | ./left | ./shift | ./left | ./shift | ./left | ./shift | ./left > $@

generated14.c: prog.c msg10
	./msg10 < $< > $@

# alternative executable
#
alt: ${ALT_TARGET}
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
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -f generated*.c msg*
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely you are performing, Dr. May!"
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
	@echo you expected to often mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Eggy

fabricate fashion form frame manufacture produce: make
	@${TRUE}

sandwich:
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo $${RANDOM}`date +%s`$${RANDOM} > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    exit 1; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 3a3fabb90892eeb2f610ae0f74a35a970060665a063ab702bd686c17c4ae07f6 --FNV1a_hash_256_bit "prog"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 216091 --level 216193 --FNV1a_hash_256_bit "prog"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
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
