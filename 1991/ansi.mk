# %W% %G% %U%
#
# 1991 makefile

SHELL=/bin/sh
CHMOD=chmod
CP=cp
RM=rm
SED=sed
LN=ln

# flags for ansi compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#	others such as gcc may want -ansi, others may want nothing
#	at all.  Adjust the CFLAGS line as needed.
#
CFLAGS=-O -Xa
CC=cc

# winners that may be ok to compile with common K&R
#
WINNERS= ant brnstnd buzzard cdupont davidguy dds fine westley rince

all: ${WINNERS}

common:
	@echo "wrong makefile, use ansi.mk"
	exit 1

ansi: all

# NOTE: some systems may need:
#
#  old SYS V:
#	cc ${CFLAGS} -DMODE=0600 -DBUF=32767 -o ant ant.c -lcurses
#  ATARI ST:
#	cc -DMODE=0 -DBUF=32767 -o ant.ttp ant.c curses.a
#  PC class:
#	wcl -mc -DMODE=0 -DBUF=32767 ant.c curses.lib
#
ant: ant.c
	${CC} ${CFLAGS} -DMODE=0600 -DBUF=32767 ant.c -o ant -lcurses -ltermcap 

brnstnd: brnstnd_ansi.c
	${CC} ${CFLAGS} -DM=malloc -DX=free -Do=250 brnstnd_ansi.c -o brnstnd

buzzard: buzzard.c
	${CC} ${CFLAGS} buzzard.c -o buzzard

cdupont: cdupont_ansi.c
	${CC} ${CFLAGS} -Ds=\"cdupont.c\" -Dt=\"r\" cdupont_ansi.c -o cdupont

# NOTE: some systems may need:
#
#  ${CC} ${CFLAGS} davidguy.c -o davidguy
# or:
#  ${CC} ${CFLAGS} davidguy.c -o davidguy -linet
#
davidguy: davidguy.c
	${CC} ${CFLAGS} davidguy.c -o davidguy -lsocket -lnsl

# NOTE: this is the original program that won the contest
#
# BSD:
#	${CC} ${CFLAGS} davidguy.orig.c -o davidguy.orig
#
davidguy.orig: davidguy.orig.c
	${CC} ${CFLAGS} davidguy.orig.c -o davidguy.orig -lsocket -lnsl

dds: dds.ansi.c LANDER.BAS
	${CC} ${CFLAGS} dds.ansi.c -o dds

fine: fine.c
	${CC} ${CFLAGS} fine.c -o fine

westley: westley.c ttt
	${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    westley.c -o westley

# the hint file gives nextmove.c as an example, provide a build rule for it
#
nextmove: nextmove.c ttt
	${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    nextmove.c -o nextmove

# the ttt script has been added by the judges to make playing westley easy
#
ttt: ttt.sh
	rm -f ttt
	cp ttt.sh ttt
	chmod +x ttt

# used by the ttt shell script when playing westley
#
# The ttt script controls what goes into merlyn.c, and how it is used.
# The merlyn program and source represent the best (hopefully) state that
# the program has evolved into thus far.  The ttt_game program and source
# represent the current state of the game.
#
merlyn: merlyn.c ttt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    merlyn.c -o merlyn
ttt_game: ttt_game.c ttt
	@${CC} ${CFLAGS} -DP=putchar -DN="P(10)" -DQ="P(34)" -DF="S(&X)" \
	    -DJ=z[4] -DK=J[14] \
	    -DH="w[]={146,7,292,73,448,56,84,273,325,297,108,324,22,40,48,40,17,325}" \
	    ttt_game.c -o ttt_game

# The upper level makefile wants to make these source files if they don't
# already exist.
#
merlyn.c: westley.c
	rm -f merlyn.c
	cp westley.c merlyn.c
	chmod +w merlyn.c
nextmove.c: westley.c
	rm -f nextmove.c
	cp westley.c nextmove.c
	chmod +w nextmove.c
ttt_game.c: westley.c
	rm -f ttt_game.c
	cp westley.c ttt_game.c
	chmod +w ttt_game.c

# NOTE: some systems may need:
#
#  old SYS V:
#	cc ${CFLAGS} -o rince rince.c -lcurses
#
# The original source is found in rince.orig.c.  Many ANSI compilers have
# problems with it, so by default we use rince_ansi.c.
#
# GNU CC users can compile this with:
#
#	gcc -ansi rince.orig.c -o rince -lcurses -ltermcap
#
rince: rince.c
	${CC} ${CFLAGS} rince_ansi.c -o rince -lcurses -ltermcap 

clean:
	${RM} -f *.o a.out core merlyn new_merlyn.c
clobber: clean
	${RM} -f ${WINNERS} a.c a.out davidguy.orig ttt
	${RM} -f merlyn merlyn.c nextmove.c nextmove.c
	${RM} -f ttt_game ttt_game.c ttt_old.c ttt_new.c nextmove
nuke: clobber
	@true
install: all
	cat ${WINNERS} > /dev/null
