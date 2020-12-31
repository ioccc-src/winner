#!/bin/make
#
# 2004 makefile
#
# Copyright (C) 2004, Landon Curt Noll, Simon Cooper, Peter Seebach
# and Leonid A. Broukhis. All Rights Reserved. Permission for personal,
# educational or non-profit use is granted provided this copyright and
# notice are included in its entirety and remains unaltered.  All other
# uses must receive prior permission from the contest judges.


# tool locations
#
SHELL= /bin/sh
CP= cp
CPP= cpp
GUNZIP= gunzip
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true


# Special flags for the gavin entry
#
# FYI: Older versions of GCC have a bug in -O2 optimization, hence -O1
#
GAVIN_OPT= -O1
GAVIN_FLAGS=\
	'-DY(m)=*((int*)(m))'\
	'-DE(f,a,b,c)=((G((*)))(f))(a,b,c)'\
	'-DM=for(D=0;D<786432;D++)'\
	'-DZ=int i=0,j=0,h,n,p=393728,s=26739,C,D'\
	'-DV=0x90200'\
	'-DK=0'\
	'-DR=while((C=E(V-8,100,0,0))&3&&(D=E(V-8,96,0,0))|3){'\
	'-DL(c,d)=E(V+8,100,c,0);R}E(V+8,96,d,0);R}'


# Set X11_LIBDIR to the directory where the X11 library resides
#
X11_LIBDIR= /usr/X11R6/lib


# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers and thus you may
# not want anything.
#
#OPT=
#OPT= -O
#OPT= -O1
OPT= -O2


# flags for ANSI compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#       others such as gcc may want -ansi, others (Compaq Tru64 Unix)
#       want -std1, and others may want nothing at all.
#       Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#       incorrectly.  You might want to turn on -O to see if your
#       compiler can handle them.
#
#
#CFLAGS= -Xa ${OPT}
#CFLAGS= -std1 $(OPT)
CFLAGS= -ansi ${OPT}


# ANSI compiler
#
# Set CC to the name of your ANSI compiler.
#
# Some entries seem to need gcc.  If you have gcc, set
# both CC and MAY_NEED_GCC to gcc.
#
# If you do not have gcc, set CC to the name of your ANSI compiler, and
# set MAY_NEED_GCC to either ${CC} (and hope for the best) or to just :
# to disable such programs.
#
CC= cc
MAY_NEED_GCC= gcc


# 2004 winners
#
WINNERS= anonymous arachnid burley gavare gavin hibachi hoyle jdalbec \
	kopczynski newbern omoikane schnitzi sds vik1 vik2
CLEAN= anonymous_clean arachnid_clean burley_clean gavare_clean gavin_clean \
	hibachi_clean hoyle_clean jdalbec_clean kopczynski_clean \
	newbern_clean omoikane_clean schnitzi_clean sds_clean vik1_clean \
	vik2_clean
CLOBBER= anonymous_clobber arachnid_clobber burley_clobber gavare_clobber \
	gavin_clobber hibachi_clobber hoyle_clobber jdalbec_clobber \
	kopczynski_clobber newbern_clobber omoikane_clobber schnitzi_clobber \
	sds_clobber vik1_clobber vik2_clobber
ALT_NAMES= hoyle.orig kopczynski.orig
DATA_FILES= arachnid_files gavin_files hibachi_files kopczynski_files \
	newbern_files omoikane_files schnitzi_files


# default build
#
all: ${WINNERS}


# Best use of "Precious" Lines
#
anonymous: anonymous.c
	${CC} anonymous.c -o anonymous

anonymous_clean:
	${RM} -f anonymous.o

anonymous_clobber: anonymous_clean
	${RM} -f anonymous


# Best use of Vision
#
arachnid: arachnid.c
	${CC} -o arachnid -DL=LINES -DS=COLS \
	    -DW=mvwaddch\(w,v,u,acs_map\[l\[m\[u arachnid.c -lncurses

arachnid_clean:
	${RM} -f arachnid.o

arachnid_clobber: arachnid_clean
	${RM} -f arachnid

arachnid_files: arachnid.info


# Best Calculated Risk
#
burley: burley.c
	${CC} -ansi burley.c -o burley

burley_clean:
	${RM} -f burley.o

burley_clobber:  burley_clean
	${RM} -f burley


# Best Use of Light and Spheres
#
gavare: gavare.c
	${CC} -O3 gavare.c -o gavare

gavare_clean:
	${RM} -f gavare.o

gavare_clobber: gavare_clean
	${RM} -f gavare


# Best of Show
#
gavin: gavin.c
	${CC} ${GAVIN_OPT} -o gavin ${GAVIN_FLAGS} gavin.c
	${RM} -f kernel
	./gavin > kernel
	${CC} ${GAVIN_OPT} -c ${GAVIN_FLAGS} -DB=_start '-Dputchar(a)=' gavin.c
	${RM} -f sh
	${LD} -s -o sh gavin.o
	${RM} -f vi
	${CP} sh vi
	${RM} -f fs.tar
	${TAR} -cvf fs.tar sh vi gavin.c gavin.hint prim

gavin_clean:
	${RM} -f sh vi kernel gavin.o

gavin_clobber: gavin_clean
	${RM} -f gavin fs.tar

gavin_files: boot.b lilo.conf prim gavin_install.txt


# Best Abuse of the Guidelines
#
hibachi: hibachi.tar.gz
	${RM} -f hibachi.tar
	${GUNZIP} < hibachi.tar.gz > hibachi.tar
	${TAR} -xvf hibachi.tar
	${RM} -f hibachi.tar
	(cd hibachi && ${SHELL} ./configure)
	([ -f hibachi/makefile ] && cd hibachi && $(MAKE) -f makefile || true)

hibachi_clean:
	${RM} -f hibachi/hibachi.o hibachi.tar

hibachi_clobber: hibachi_clean
	${RM} -rf hibachi

hibachi_files: hibachi.tar.gz


# Most Functional Output
#
hoyle: hoyle.c
	${CC} hoyle.c -o hoyle -lm

hoyle.orig: hoyle.orig.c
	${CC} hoyle.orig.c -o hoyle.orig -lm

hoyle_clean:
	${RM} -f hoyle.o hoyle.orig.o

hoyle_clobber: hoyle_clean
	${RM} -f hoyle hoyle.orig


# Best Abuse of the Periodic Table
#
jdalbec: jdalbec.c
	@${RM} -f jdalbec2.c
	-${CC} -E jdalbec.c > jdalbec2.c
	@${RM} -f jdalbec3.c
	${SED} -e 's/ (/(/g' < jdalbec2.c > jdalbec3.c
	${CC} -ansi jdalbec3.c -o jdalbec

jdalbec_clean:
	${RM} -f jdalbec2.c jdalbec3.c jdalbec.o

jdalbec_clobber: jdalbec_clean
	${RM} -f jdalbec


# Best one-liner
#
kopczynski: kopczynski.c
	${CC} -Dif=while kopczynski.c -o kopczynski

kopczynski.orig: kopczynski.orig.c
	${CC} -Dif=while kopczynski.orig.c -o kopczynski.orig

kopczynski_clean:
	${RM} -f kopczynski.o kopczynski.orig.o

kopczynski_clobber: kopczynski_clean
	${RM} -f kopczynski kopczynski.orig

kopczynski_files: kopczynski-10 kopczynski-11 kopczynski-8a kopczynski-8b \
	kopczynski-8c kopczynski-9


# Best Font Engine
#
newbern: newbern.c
	${CC} newbern.c -o newbern

newbern_clean:
	${RM} -f newbern.o

newbern_clobber: newbern_clean
	${RM} -f newbern

newbern_files: newbern.dat


# Best Utility
#
omoikane: omoikane.c
	${CC} -O omoikane.c -o omoikane

omoikane_clean:
	${RM} -f omoikane.o

omoikane_clobber: omoikane_clean
	${RM} -f omoikane

omoikane_files: omoikane.info


# Best Non-Use of Curses
#
schnitzi: schnitzi.c
	${CC} schnitzi.c -o schnitzi

schnitzi_clean:
	${RM} -f schnitzi.o

schnitzi_clobber: schnitzi_clean
	${RM} -f schnitzi

schnitzi_files: schnitzi.inp0 schnitzi.inp1


# Best Abuse of Indentation
#
sds: sds.c
	${CC} -o sds sds.c

sds_clean:
	${RM} -f sds_encoder.c sds_encoder.o sds.o

sds_clobber: sds_clean
	${RM} -f sds sds_encoder


# Best X11 Game
#
vik1: vik1.c
	${CC} -ansi -O2 -o vik1 vik1.c -L${X11_LIBDIR} -lX11

vik1_clean:
	${RM} -f vik1.o

vik1_clobber: vik1_clean
	${RM} -f vik1


# Best Abuse of CPP
#
vik2: vik2.c
	@${RM} -f vik2_1.c
	${CC} -E '-DSTOP=_5' '-DFNAME="vik2_1.c"' vik2.c > vik2_1.c
	@${RM} -f vik2_2.c
	${CC} -E vik2_1.c > vik2_2.c
	${CC} -O vik2_2.c -o vik2

vik2_clean:
	${RM} -f vik2_1.c vik2_2.c vik2.o

vik2_clobber: vik2_clean
	${RM} -f vik2


# utility rules
#
everything: ${WINNERS} ${ALT_NAMES} ${DATA_FILES}

love:
	@echo 'not war?'

haste:
	$(MAKE) waste

waste:
	@echo 'waste'

clean: ${CLEAN}
	${RM} -f a.out core

clobber: ${CLOBBER}
	${RM} -f ${WINNERS}
	${RM} -f ${ALT_NAMES}

nuke: clobber
	@${TRUE}

install: all
	${CAT} ${WINNERS} ${ALT_NAMES} > /dev/null
