# 2006 makefile
#
# Copyright (C) 2006-2009, Landon Curt Noll, Simon Cooper, Peter Seebach
# and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
# educational or non-profit use is granted provided this copyright and
# notice are included in its entirety and remains unaltered.  All other
# uses must receive prior permission from the contest judges.

# Special flags for this entry
#
LOCAL_FLAGS= -I${X11_INCDIR} -L${X11_LIBDIR} -lX11 ${OPT}

# data files for this entry
#
DATA=


build: ${ENTRY} ${ENTRY}-sbar ${ENTRY}-txt


clean:
	-${RM} ${ENTRY} ${ENTRY}-sbar ${ENTRY}-txt


clobber: clean


alt:


data:


${ENTRY}: ${ENTRY}.c ${DATA}
	${CC} ${CFLAGS} ${LOCAL_FLAGS} ${ENTRY}.c -o ${ENTRY}

${ENTRY}-sbar: ${ENTRY}-sbar.c ${DATA}
	${CC} ${CFLAGS} ${LOCAL_FLAGS} ${ENTRY}-sbar.c -o ${ENTRY}-sbar

${ENTRY}-txt: ${ENTRY}-txt.c ${DATA}
	${CC} ${CFLAGS} ${LOCAL_FLAGS} ${ENTRY}-txt.c -o ${ENTRY}-txt
