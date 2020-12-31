# %W% %G% %U%
#
# 1987 makefile
#
# Copyright (c) 1987, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL= /bin/sh
WINNERS= biggar

# for System V style systems
OPSYS= -Dindex=strchr
# for BSD style systems
#OPSYS=

all: ${WINNERS}

biggar: biggar.c
	cc -DC="R>0" -DI="if(T)O" -DO="c=write(1,&c,1);" \
	    -DP="main(){X}" -DR="read(0,&c,1)" -DT="c!=015" \
	    -DW="while(C)I" -DX="char c;W" $? -o $@

clean:
	rm -f core
clobber: clean
	rm -f ${WINNERS}
install: all
	@echo are you kidding'??'
