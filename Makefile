# %W% %G% %U%
#
# Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# in writing from both Landon Curt Noll and Larry Bassel.


SHELL=/bin/sh

all:
	@-for i in [12][0-9][0-9]?; do \
	    if [ -f $$i/[Mm]akefile ]; then \
		echo "cd $$i; make all"; \
		(cd $$i; make all); \
	    fi; \
	done

clean:
	@-for i in [12][0-9][0-9]?; do \
	    if [ -f $$i/[Mm]akefile ]; then \
		echo "cd $$i; make clean"; \
		(cd $$i; make clean); \
	    fi; \
	done
clobber:
	@-for i in [12][0-9][0-9]?; do \
	    if [ -f $$i/[Mm]akefile ]; then \
		echo "cd $$i; make clobber"; \
		(cd $$i; make clobber); \
	    fi; \
	done
install:
	@-for i in [12][0-9][0-9]?; do \
	    if [ -f $$i/[Mm]akefile ]; then \
		echo "cd $$i; make install"; \
		(cd $$i; make install); \
	    fi; \
	done
