#!/usr/bin/env make
#
# iocccsize - IOCCC Source Size Tool
#
# This IOCCC size tool source file is version 2019-06-20-v27.
#
# "You are not expected to understand this" :-)
#
# Public Domain 1992, 2015, 2018, 2019 by Anthony Howe.  All rights released.
# With IOCCC minor mods in 2019 by chongo (Landon Curt Noll) ^oo^

.POSIX :

O := .o
E :=

.SUFFIXES :
.SUFFIXES : .c .h .i $O $E

########################################################################
### No further configuration beyond this point.
########################################################################

top_srcdir	:= ..
PROJ 		:= iocccsize
TAR_I		:= -T
CFLAGS		:= -g -std=c11 -Wall -Wextra -Wno-char-subscripts -pedantic
CFLAGS89	:= -g -std=c89 -Wall -Wextra -Wno-char-subscripts -pedantic
CPPFLAGS	:=
LIBS		:=

.c.i:
	${CC} -E ${CFLAGS} ${CPPFLAGS} $*.c >$*.i

.c$E:
	${CC} ${CFLAGS} ${CPPFLAGS} -o$*$E $*.c

#######################################################################

all: build
	@true

build: ${PROJ}

clean:
	-rm -f ${PROJ}.i ${PROJ}$O *.stackdump *.core

clobber: distclean

distclean: clean
	-rm -fr ${PROJ}$E test a.out
	-rm -fr decom a.out iocccsize.dSYM

test: ./${PROJ}-test.sh ${PROJ}
	./${PROJ}-test.sh -v

unittest: test
	./${PROJ}-test.sh -v

version:
	git describe --tags --abbrev=0 >VERSION
