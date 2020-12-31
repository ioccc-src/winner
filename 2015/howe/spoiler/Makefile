.POSIX :

.SUFFIXES :
A = .a
O = .o
.SUFFIXES : .c .h .i $O $A

########################################################################
### No further configuration beyond this point.
########################################################################

top_srcdir	:= ..
CC		:= gcc
CFLAGS		:= -g -O2 -std=c99 -Wall -pedantic -Wno-char-subscripts
LDFLAGS		:=

# Assume a POSIX compliant shell.
#
# On Linux
#	/bin/sh = /bin/bash
#
# On NetBSD
#	/bin/ksh
#	/usr/pkg/bin/bash
#
# On OpenBSD
#	/bin/ksh = /bin/pdksh
#
SHELL		:= /bin/ksh

W64CC		:= i686-w64-mingw32-gcc
W64CFLAGS	:= -I. -Os -s -std=c99 -Wno-char-subscripts

ZIP	:= README.txt prog-w64.exe prog-test.sh avgtime.sh makeholes-w64.exe

.c$O :
	${CC} ${CFLAGS} -c $<

.c$E :
	$(CC) $(CFLAGS) $(LDFLAGS) -o$* $<

$O :
	$(LD) $(LDFLAGS) -o$* $*$O

.c.i:
	${CC} -E ${CFLAGS} $*.c >$*.i

########################################################################

all: build

build: prog

clean:
	-rm prog *.exe *.i *$O *.tmp *.rej *.orig *.core *.out 2>/dev/null

distclean: clean

prog: prog.c
	${CC} ${CFLAGS} ${LDFLAGS} -o$@ prog.c

prog-w64: err.h prog.c
	${W64CC} ${W64CFLAGS} ${LDFLAGS} -o$@ prog.c

test:
	${SHELL} ${top_srcdir}/prog-test.sh

test-w64:
	${SHELL} ${top_srcdir}/prog-test.sh -w
