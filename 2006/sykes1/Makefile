# 2006 makefile
#
# Copyright (C) 2006-2009, Landon Curt Noll, Simon Cooper, Peter Seebach
# and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
# educational or non-profit use is granted provided this copyright and
# notice are included in its entirety and remains unaltered.  All other
# uses must receive prior permission from the contest judges.

# Special flags for this entry
#
LOCAL_FLAGS= -Wall -W -ansi -O3 --unroll-loops

# data files for this entry
#
DATA=


build: ${ENTRY} ${ENTRY}.html


clean:
	-${RM} ${ENTRY} ${ENTRY}.html


clobber: clean


alt:


data:


${ENTRY}: ${ENTRY}.c ${DATA}
	${CC} ${CFLAGS} ${LOCAL_FLAGS} ${ENTRY}.c -o ${ENTRY}

${ENTRY}.html: ${ENTRY}.c
	${RM} ${ENTRY}.html
	cp ${ENTRY}.c ${ENTRY}.html
