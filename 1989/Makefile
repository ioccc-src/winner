# %W% %G% %U%
#
# 1989 makefile
#
# Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL=/bin/sh
CFLAGS=-O
CC=cc

WINNERS=ovdluhe jar.1 jar.2 fubar westley paul robison roemer vanb tromp.bsd
ALTERNATE=jar.1.orig fubar.orig tromp.s5

all: ${WINNERS}

ovdluhe: ovdluhe.c
	${CC} ${CFLAGS} $? -o $@

# NOTE: jar.1.c outputs its string in one section
#       this program may not print well on some terminals
jar.1: jar.1.c jar.1.sh
	rm -f jar.1
	cp jar.1.sh jar.1
	chmod +x jar.1
# NOTE: The jar.1.orig file is the original entry
jar.1.orig: jar.1.orig.c jar.1.orig.sh
	rm -f jar.1.orig
	cp jar.1.sh jar.1.orig
	chmod +x jar.1.orig

jar.2: jar.2.c
	${CC} ${CFLAGS} $? -o $@

# NOTE: fubar.c uses the /bin/sh shell
fubar: fubar.c fubar.sh
	rm -f fubar
	cp fubar.sh fubar
	chmod +x fubar
# NOTE: The fubar.orig.c file is the original entry
fubar.orig: fubar.orig.c fubar.orig.sh
	rm -f fubar.orig
	cp fubar.orig.sh fubar.orig
	chmod +x fubar.orig

westley: westley.c
	${CC} ${CFLAGS} -Dtrgpune=putchar $? -o $@

paul: paul.c
	${CC} ${CFLAGS} $? -o $@

robison: robison.c
	${CC} ${CFLAGS} $? -o $@

roemer: roemer.c
	${CC} ${CFLAGS} $? -o $@

# NOTE: this version requires BSD style signals and setitimer
#	this may not work well on low baud rate terminals
#	the file tromp.bsd.c is the original version
tromp: tromp.bsd.c
	${CC} ${CFLAGS} $? -o $@
	touch HI
	-chmod 0666 HI
# NOTE: sites without BSD style signals and setitimer (e.g. System V.3)
#	should use this version
tromp.s5: tromp.s5.c
	${CC} ${CFLAGS} $? -o $@
	touch HI
	-chmod 0666 HI

vanb: vanb.c
	${CC} ${CFLAGS} $? -o $@

clean:
	rm -f ovdluhe.o jar.2.o fubar.o westley.o paul.o robison.o
	rm -f roemer.o tromp.o vanb.o 
	rm -f x x1 ouroboros.c ouroboros.o fubar.orig.o tromp.bsd.o tromp.s5.o core
clobber: clean
	rm -f ${WINNERS} 
	rm -f jar.1.o HI 
	rm -f ${ALTERNATE}
nuke: clobber
	@true
install: all
	cat ${WINNERS} > /dev/null
