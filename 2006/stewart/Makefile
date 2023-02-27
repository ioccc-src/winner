# 2006 makefile
#
# Copyright (C) 2006-2009, Landon Curt Noll, Simon Cooper, Peter Seebach
# and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
# educational or non-profit use is granted provided this copyright and
# notice are included in its entirety and remains unaltered.  All other
# uses must receive prior permission from the contest judges.

# Special flags for this entry
#
#CFLAGS= 

# data files for this entry
#
DATA= altar box box2 box3 carpet circles cross cross2 cross3 \
	crystal curve diamonds diamonds2 dragon dragon2 dragon3 \
	fern gasket gasket_mod gasket_mod2 ioccc maze octagon \
	pentagon pentagons rings rings2 spirals spirals2 spirals3 \
	spirals4 squares stars stars2 tree tree2 tree3 tree4 triangle


build: ${ENTRY}


clean:
	-${RM} ${ENTRY}


clobber: clean


alt:


data:


${ENTRY}: ${ENTRY}.c ${DATA}
	${CC} ${CFLAGS} ${ENTRY}.c -o ${ENTRY}
