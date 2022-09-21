# %W% %G% %U%
#
# 1984 makefile
#
# Copyright (c) 1984, Landon Curt Noll.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL= /bin/sh
WINNERS= decot

all: ${WINNERS}

decot: decot.c
	cc $? -o $@ -lm

clean:
	rm -f core
clobber: clean
	rm -f ${WINNERS}

install: all
	@echo are you kidding'??'
