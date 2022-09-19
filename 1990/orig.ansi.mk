# %W% %G% %U%
#
# 1990 makefile

SHELL=/bin/sh

# flags for ANSI compiles
#
# These flags are setup for gcc, change as/if needed
#
PEDANTIC=-pedantic
CFLAGS=-O -ansi 
CHMOD=chmod
CC=gcc
CP=cp
RM=rm
LN=ln

# winners that may be ok to compile with ANSI
#
WINNERS=cmills pjr westley stig tbr dg baruch jaw scjones

all: ${WINNERS}

ansi: all

common:
	@echo "wrong makefile, use common.mk"
	exit 1

cmills: cmills.c
	${CC} ${CFLAGS} -DM=500 -DN=52 -DX="srand((int)time(0L))" -DV=void \
	    -o cmills cmills.c

pjr: pjr.c
	${CC} ${CFLAGS} pjr.c -o pjr

westley: westley.c
	${CC} ${CFLAGS} westley.c -o westley

stig: stig.c stig.ksh
	@echo "run the Korn shell, and source stig.ksh"
	@echo "or read stig.hint and create your own aliases"

scjones: scjones.c
	${CC} ${CFLAGS} scjones.c -o scjones

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

jaw: jaw.c shark.sh
	${RM} -f ./zcat ./atob ./jaw
	${CC} ${CFLAGS} ${PEDANTIC} jaw.c -o zcat
	${LN} zcat atob
	echo 'PATH=;export PATH;atob|zcat' > jaw
	${CHMOD} 0555 ./jaw

clean:
	${RM} -f *.o a.out core
clobber: clean
	${RM} -f ${WINNERS} sorter.c sorter
	${RM} -f fibonacci.c fibonacci atob zcat
nuke: clobber
	@true
install: all
	cat ${WINNERS} > /dev/null
