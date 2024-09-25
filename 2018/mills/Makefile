#!/usr/bin/env make
#
# IOCCC 2018 winning entry - mills

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC entries:
#
#	https://www.ioccc.org/bugs.html
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

#######################
# common tool locations
#######################
#
include ../../var.mk

# Common C compiler warnings to silence
#
CSILENCE= -Wno-gnu-empty-initializer -Wno-missing-field-initializers \
	  -Wno-misleading-indentation -Wno-pedantic -Wno-strict-prototypes

# Attempt to silence unknown warning option
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-implicit-int-conversion -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shorten-64-to-32 \
	   -Wno-unsafe-buffer-usage
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special Makefile variables for this entry
##############################
#
ENTRY= mills
PROG= prog
#
OBJ= ${PROG}.o
CSRC= ${PROG}.o
DATA=
TARGET= ${PROG} v0 v6
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
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber

# Variable to decide if the emulator should save state (default no)
#
SAVE=0
MAP=MAP_PRIVATE
ifneq ($((SAVE)),0)
	MAP=MAP_SHARED
endif

${PROG}: ${PROG}.c rk05.bsd.fs
	${CC} ${CFLAGS} -DI='"rk05.bsd.fs"' -DA=4096 -DS=0173030 -DW=${MAP} -DT= -DX=5 -DY=128 \
	      -DV=270 -DP='"89!>@@89T=@@89\"89DQ@K89$$89Q1@H0@@@P@1@@"' ${PROG}.c -o $@ ${LDFLAGS}

rk05.bsd.fs: empty.fs.bz2 builddisk.bsd bsd.img.bz2
	${RM} -f $@
	${BZIP2} -dc empty.fs.bz2 > rk05.bsd.fs
	${BZIP2} -dc bsd.img.bz2 | ./builddisk.bsd

# NOTE: we don't set -DW=${MAP} here because it's already set to MAP_SHARED and
# we don't want to break anything here. The default for the program itself is
# MAP_PRIVATE but it's possible that if MAP is set to MAP_PRIVATE then having W
# set to MAP_PRIVATE here could be a problem as it's meant to be MAP_SHARED.
builddisk.bsd: ${PROG}.c
	${CC} ${CFLAGS} -DI='"rk05.bsd.fs"' -DA=4096 -DS=0 -DW=MAP_SHARED -DT= -DX=0 -DY=0 -DV=270 \
	    -DP='"Q@ 89D?A E@#?@$$D@H?<@E@$$8CA1@H8CJ4EH8CA1@L8CJ4FH)@!F@H%@$$1@H?@%89\"?<@89T89!Q@\"89$$89Q1@[%@#1@D<@ @EHO??@X@@@@@@@1@@"' \
	    -o $@ ${PROG}.c

rk05.v6.fs: empty.fs.bz2 builddisk.v6 v6.img.bz2
	@${RM} -f $@
	${BZIP2} -dc empty.fs.bz2 > rk05.v6.fs
	${BZIP2} -dc v6.img.bz2 | ./builddisk.v6

# NOTE: we don't set -DW=${MAP} here because it's already set to MAP_SHARED and
# we don't want to break anything here. The default for the program itself is
# MAP_PRIVATE but it's possible that if MAP is set to MAP_PRIVATE then having W
# set to MAP_PRIVATE here could be a problem as it's meant to be MAP_SHARED.
builddisk.v6: ${PROG}.c
	${CC} ${CFLAGS} -DI='"rk05.v6.fs"' -DA=4096 -DS=0 -DW=MAP_SHARED -DT= -DX=0 -DY=0 -DV=270 \
	    -DP='"Q@ 89D?A E@#?@$$D@H?<@E@$$8CA1@H8CJ4EH8CA1@L8CJ4FH)@!F@H%@$$1@H?@%89\"?<@89T89!Q@\"89$$89Q1@[%@#1@D<@ @EHO??@X@@@@@@@1@@"' \
	    -o $@ ${PROG}.c

empty.fs.bz2: boot.dat
	${RM} -f empty.fs
	${DD} if=/dev/zero of=empty.fs count=10800
	${DD} if=boot.dat of=empty.fs conv=notrunc
	${BZIP2} empty.fs

v0: ${PROG}.c Makefile v0.image.fs
	${CC} ${CFLAGS} -DI='"v0.image.fs"' -DA=4096 -DS=0 -DW=${MAP} \
	    -DT="INLCR|ICRNL,0,0,ECHO" -DX=5 -DY=128 -DV=200 \
	    -DP='"89!?@@89T=@@89\"Q@M89DQ@L89$$89Q1@I0A@@P@X@@1@@"' ${PROG}.c -o $@
	@echo ""
	@echo "This IOCCC25 Makefile preserves the state of v0.image.fs at the time it won."
	@echo "If you want to look for v0.image.fs updates, try:"
	@echo ""
	@echo "    ${CURL} ${IMAGE_FS_URL} -o v0.image.fs"
	@echo ""
	@echo "Warning: any updates from ${IMAGE_FS_URL}"
	@echo "are unofficial and are not part of this IOCCC entry."
	@echo ""

v6: empty.fs.bz2 builddisk.v6 v6.img.bz2 rk05.v6.fs
	${CC} ${CFLAGS} -DI='"rk05.v6.fs"' -DA=4096 -DS=0173030 -DW=${MAP} -DT= -DX=5 -DY=128 \
	      -DV=270 -DP='"89!>@@89T=@@89\"89DQ@K89$$89Q1@H0@@@P@1@@"' ${PROG}.c -o $@ ${LDFLAGS}

v6.img.bz2: v6.tape.gz
	${RM} -f v6.tape
	${GZIP_PROG} -c -d v6.tape.gz | ${DD} of=v6.img count=4000 skip=100
	${BZIP2} v6.img
	@echo ""
	@echo "This IOCCC25 Makefile preserves the state of v6.tape.gz at the time it won."
	@echo "If you want to look for v6.tape.gz updates, try:"
	@echo ""
	@echo "    ${CURL} ${V6_TAPE_URL} -o v6.tape.gz"
	@echo ""
	@echo "Warning: any updates from ${V6_TAPE_URL}"
	@echo "are unofficial and are not part of this IOCCC entry."
	@echo ""


# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt
	@${TRUE}


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f builddisk.bsd builddisk.v6 v0 rk05.bsd.fs rk05.v6.fs
	${RM} -f empty.fs.bz2 empty.fs v6.fs v6.img.bz2 v0.img v6.tape


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
