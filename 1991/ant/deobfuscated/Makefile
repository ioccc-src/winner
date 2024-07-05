#
# Anthony's Editor
#
# IOCCC 1991
#
# Winner Best Utility
#

CFLAGS	= -Os -Wno-deprecated-non-prototype

all: build

build: ant ant-c89

clean:
	-rm -f ant ant-c89

# NOTE: some systems may need:
#
#  old SYS V:
#	cc ${CFLAGS} -DMODE=0600 -DBUF=32767 -o ant ant.c -lcurses
#  ATARI ST:
#	cc -DMODE=0 -DBUF=32767 -o ant.ttp ant.c curses.a
#  PC class:
#	wcl -mc -DMODE=0 -DBUF=32767 ant.c curses.lib
#
# This older version may generate lots of warnings with newer compilers.
#
ant: ant.c
	${CC} ${CFLAGS} -DMODE=0600 -DBUF=32767 ant.c -o $@ -lcurses -ltermcap

# Mostly cosmetic changes to read like ANSI C 89.
ant-c89: ant-c89.c
	${CC} ${CFLAGS} -DMODE=0600 ant-c89.c -o $@ -lcurses -ltermcap
