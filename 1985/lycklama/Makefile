# %W% %G% %U%
#
# 1985 makefile
#
# Copyright (c) 1985, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL= /bin/sh
WINNERS= lycklama

all: ${WINNERS}

lycklama: lycklama.c
	cc $? -o $@

clean:
	rm -f core
clobber: clean
	rm -f ${WINNERS}

install: all
	@echo are you kidding'??'
