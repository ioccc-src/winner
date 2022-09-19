# %W% %G% %U%
#
# 1990 makefile

SHELL=/bin/sh
CHMOD=chmod
CC=gcc
CP=cp
RM=rm
SED=sed
LN=ln

# flags for common K&R compiles
#
CFLAGS=-O
CC=cc

# winners that may be ok to compile with common K&R
#
WINNERS=cmills pjr westley tbr dg dds theorem baruch jaw scjones

all: ${WINNERS}

ansi:
	@echo "wrong makefile, use ansi.mk"
	exit 1

common: all

cmills: cmills.c
	${CC} ${CFLAGS} -DM=500 -DN=52 -DX="srand((int)time(0L))" -DV=int \
	    -o cmills cmills.c

pjr: pjr.c
	${CC} ${CFLAGS} pjr.c -o pjr

westley: westley.alt.c
	${CC} ${CFLAGS} westley.alt.c -o westley

westley.alt.c: westley.c
	${RM} -f westley.alt.c
	-${SED} -e 's/signed//' -e 's/1s/1/g' -e 's/^	#/#/' \
	    westley.c > westley.alt.c

stig: stig.c stig.ksh
	@echo "run the Korn shell, and source stig.ksh"
	@echo "or read stig.hint and create your own aliases"

tbr: tbr.c
	${CC} ${CFLAGS} tbr.c -o tbr

dg: dg.c
	${CC} ${CFLAGS} dg.c -Dindex=strchr -o dg
	# compile with the following if you don't have strchr()
	#${CC} ${CFLAGS} dg.c -o dg

dds: dds.c LANDER.BAS
	${CC} ${CFLAGS} dds.c -o dds

theorem: theorem.c
	${CC} ${CFLAGS} theorem.c -o theorem
	${RM} -f sorter.c
	-./theorem -r 0 0 0 0 < theorem.c > sorter.c
	${CC} ${CFLAGS} sorter.c -o sorter
	${RM} -f fibonacci.c
	-./sorter 0 0 0 0 < theorem.c > fibonacci.c
	${CC} ${CFLAGS} fibonacci.c -o fibonacci

baruch: baruch.c
	${CC} ${CFLAGS} baruch.c -o baruch

jaw: jaw.c
	${RM} -f ./zcat ./atob ./jaw
	${CC} ${CFLAGS} jaw.c -o zcat
	${LN} zcat atob
	echo 'PATH=;export PATH;atob|zcat' > jaw
	${CHMOD} 0555 ./jaw

scjones: scjones.alt.c stdlib.h
	${CC} ${CFLAGS} -I. scjones.alt.c -o scjones

# NOTE: scjones.alt.c is just a de-ANSI-fied scjones.c for example only
#
scjones.alt.c: scjones.c
	${RM} -f scjones.alt.c
	-${SED} -e 's#??/#\\#g' -e 's/??=/#/g' -e 's/??(/[/g' -e 's/??)/]/g' \
		-e "s/??'/^/g" -e 's/??</{/g' -e 's/??!/|/g' -e 's/??>/}/g' \
		-e 's/??-/~/g' scjones.c > scjones.alt.c

stdlib.h:
	${RM} -f stdlib.h
	echo "#define EXIT_SUCCESS 0" >stdlib.h
	echo "#define EXIT_FAILURE 1" >>stdlib.h
	echo "void exit(); /* may need to be int on some systems */" >>stdlib.h

clean:
	rm -f *.o a.out core
clobber: clean
	${RM} -f ${WINNERS} sorter.c sorter westley.alt.c stdlib.h
	${RM} -f fibonacci.c fibonacci atob zcat scjonds.alt.c
nuke: clobber
	@true
install: all
	cat ${WINNERS} > /dev/null
