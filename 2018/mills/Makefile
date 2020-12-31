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
CWARN= -Wall ${CSILENCE}
#CWARN= -Wall -Wextra
#CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything
#CWARN= -Wall -Wextra -Weverything -pedantic
#CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

# Silence warnings that ${CWARN} would normally complain about
#
CSILENCE= -Wno-unused-result
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
TARGET= prog v0 v6
#
ALT_OBJ=
ALT_TARGET=

# NOTE: These URLs record the location of where v0.image.fs and v6.tape.gz
#	were obtained at the time this entry won IOCCC25.  We have preserved
#	the state of those files in this Makefile.  These URLs are left here
#	for historical purposes and for those who may wish to re-download
#	these two files later on.
#
IMAGE_FS_URL= https://raw.githubusercontent.com/DoctorWkt/pdp7-unix/master/binaries/image.fs
V6_TAPE_URL= https://www.tuhs.org/Archive/Distributions/Research/Ken_Wellsch_v6/v6.tape.gz


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

prog: prog.c rk05.bsd.fs
	${CC} ${CFLAGS} -DI='"rk05.bsd.fs"' -DA=4096 -DS=0173030 -DW=MAP_PRIVATE -DT= -DX=5 -DY=128 \
	      -DV=270 -DP='"89!>@@89T=@@89\"89DQ@K89$$89Q1@H0@@@P@1@@"' prog.c -o $@ ${LIBS}

rk05.bsd.fs: empty.fs.bz2 builddisk.bsd bsd.img.bz2
	@${RM} -f $@
	${BZIP2} -dc empty.fs.bz2 > rk05.bsd.fs
	${BZIP2} -dc bsd.img.bz2 | ./builddisk.bsd

builddisk.bsd: prog.c
	${CC} ${CFLAGS} -DI='"rk05.bsd.fs"' -DA=4096 -DS=0 -DW=MAP_SHARED -DT= -DX=0 -DY=0 -DV=270 \
	    -DP='"Q@ 89D?A E@#?@$$D@H?<@E@$$8CA1@H8CJ4EH8CA1@L8CJ4FH)@!F@H%@$$1@H?@%89\"?<@89T89!Q@\"89$$89Q1@[%@#1@D<@ @EHO??@X@@@@@@@1@@"' \
	    -o $@ prog.c

rk05.v6.fs: empty.fs.bz2 builddisk.v6 v6.img.bz2
	@${RM} -f $@
	${BZIP2} -dc empty.fs.bz2 > rk05.v6.fs
	${BZIP2} -dc v6.img.bz2 | ./builddisk.v6

builddisk.v6: prog.c
	${CC} ${CFLAGS} -DI='"rk05.v6.fs"' -DA=4096 -DS=0 -DW=MAP_SHARED -DT= -DX=0 -DY=0 -DV=270 \
	    -DP='"Q@ 89D?A E@#?@$$D@H?<@E@$$8CA1@H8CJ4EH8CA1@L8CJ4FH)@!F@H%@$$1@H?@%89\"?<@89T89!Q@\"89$$89Q1@[%@#1@D<@ @EHO??@X@@@@@@@1@@"' \
	    -o $@ prog.c

empty.fs.bz2: boot.dat
	@${RM} -f empty.fs
	${DD} if=/dev/zero of=empty.fs count=10800
	${DD} if=boot.dat of=empty.fs conv=notrunc
	${BZIP2} empty.fs

v0: prog.c Makefile v0.image.fs
	@echo "This IOCCC25 Makefile preserves the state of v0.image.fs at the time it won."
	@echo "If you want to look for v0.image.fs updates, try: ${CURL} ${IMAGE_FS_URL} -o v0.image.fs"
	@echo "Warning: any updates from ${IMAGE_FS_URL} are unofficial and are not part of the IOCCC."
	${CC} ${CFLAGS} -DI='"v0.image.fs"' -DA=4096 -DS=0 -DW=MAP_PRIVATE \
	    -DT="INLCR|ICRNL,0,0,ECHO" -DX=5 -DY=128 -DV=200 \
	    -DP='"89!?@@89T=@@89\"Q@M89DQ@L89$$89Q1@I0A@@P@X@@1@@"' prog.c -o $@

v6: empty.fs.bz2 builddisk.v6 v6.img.bz2 rk05.v6.fs
	${CC} ${CFLAGS} -DI='"rk05.v6.fs"' -DA=4096 -DS=0173030 -DW=MAP_PRIVATE -DT= -DX=5 -DY=128 \
	      -DV=270 -DP='"89!>@@89T=@@89\"89DQ@K89$$89Q1@H0@@@P@1@@"' prog.c -o $@ ${LIBS}

v6.img.bz2: v6.tape.gz
	@echo "This IOCCC25 Makefile preserves the state of v6.tape.gz at the time it won."
	@echo "If you want to look for v6.tape.gz updates, try: ${CURL} ${V6_TAPE_URL} -o v6.tape.gz"
	@echo "Warning: any updates from ${V6_TAPE_URL} are unofficial and are not part of the IOCCC."
	@${RM} -f v6.tape
	${GZIP_PROG} -c -d v6.tape.gz | ${DD} of=v6.img count=4000 skip=100
	${BZIP2} v6.img

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
	${RM} -f builddisk.bsd builddisk.v6 v0 rk05.bsd.fs rk05.v6.fs empty.fs.bz2 empty.fs v6.fs v6.img.bz2 v0.img
	${RM} -f v6.tape
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
