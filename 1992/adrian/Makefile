# %W% %G% %U%
#
# 1992 makefile
#
# Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
# All Rights Reserved.  Permission for personal, educational or non-profit
# use is granted provided this this copyright and notice are included in its
# entirety and remains unaltered.  All other uses must receive prior permission
# from Landon Curt Noll and Larry Bassel.


SHELL=/bin/sh
CHMOD=chmod
CP=cp
RM=rm
SED=sed
LN=ln
UNIQ=uniq
CB=cb 
GREP=grep
# set this to where your C Processor resides
#
# On some systems:
#	CPP=/lib/cpp
#
CPP=/usr/ccs/lib/acpp

# flags for ansi compiles
#
# NOTE: Some ANSI compilers make use of -Xa to turn on ANSI mode,
#	others such as gcc may want -ansi, others may want nothing
#	at all.  Adjust the CFLAGS line as needed.
#
# NOTE: Some compilers cannot optimize, or optimize some entries
#	entries incorrectly.  You might want need to turn on -O 
#	to see if your compiler can handle them.
#
#CFLAGS=-O -Xa
CFLAGS=-Xa
CC=cc

# misc shell babble
#
NOINCLUDE=$(SED) -e 's/^.\([	 ]*\)include/%include/'
SPACECLEAN=$(SED) -e 's/\([^	 ]\)\([	 ]\)[ 	][ 	]*/\1\2/g'
CPPCLEAN=$(GREP) -v '^. [0-9][0-9]*'

# winners that compile under ANSI C
#
WINNERS= adrian albert ant buzzard.1 buzzard.2 gson kivinen imc \
	lush marangon nathan vern westley
ALT_NAMES= adgrep am babble first ag whereami

all: $(WINNERS) $(ALT_NAMES)

adrian: adrian.c
	$(CC) $(CFLAGS) adrian.c -o adrian
	$(RM) -f ad.temp adwc.c adbasename.c adecho.c adhead.c adsleep.c
	$(SED) '1s/\..*\./. wc ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adwc.c
	$(CC) -o adwc adwc.c
	$(SED) '1s/\..*\./. basename ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adbasename.c
	$(CC) -o adbasename adbasename.c
	$(SED) '1s/\..*\./. echo| ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adecho.c
	$(CC) -o adecho adecho.c
	$(SED) '1s/\..*\./. head; ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adhead.c
	$(CC) -o adhead adhead.c
	$(SED) '1s/\..*\./. sleep ./' adrian.c > ad.temp
	-./adrian ad.temp <ad.temp >adsleep.c
	$(CC) -o adsleep adsleep.c
	$(RM) -f ad.temp

# NOTE: this is the original source that won
#
adrian.orig: adrian.orig.c
	$(CC) $(CFLAGS) adrian.orig.c -o adrian.orig

albert: albert.c
	$(CC) $(CFLAGS) albert.c -o albert

# NOTE: this is the original source that won
#
albert.orig: albert.orig.c
	$(CC) $(CFLAGS) albert.orig.c -o albert.orig

ant: ant.c
	$(CC) $(CFLAGS) ant.c -o ant

buzzard.1: buzzard.1.c
	$(CC) $(CFLAGS) buzzard.1.c -o buzzard.1

babble.cppcb: buzzard.1.c
	$(NOINCLUDE) buzzard.1.c | \
	    $(CPP) $(CPPFLAGS) | \
	    $(CPPCLEAN) | \
	    $(CB) $(CBFLAGS) | \
	    $(UNIQ) | \
	    $(SPACECLEAN) > babble.cppcb 2>&1

buzzard.2: buzzard.2.c
	$(CC) $(CFLAGS) buzzard.2.c -o buzzard.2

# NOTE: this is the original source that won
#
buzzard.2.orig: buzzard.2.orig.c
	$(CC) $(CFLAGS) buzzard.2.orig.c -o buzzard.2.orig

gson: gson.c
	$(CC) $(CFLAGS) gson.c -o gson

# NOTE: some systems may only need:
#
#  $(CC) $(CFLAGS) kivinen.c -o kivinen -lX11
#
kivinen: kivinen.c
	$(CC) $(CFLAGS) kivinen.c -o kivinen -lX11 -lsocket -lresolv -lnsl

# NOTE: this is the original program that won
#
# NOTE: some systems may only need:
#
#  $(CC) $(CFLAGS) kivinen.c -o kivinen -lX11
#
kivinen.orig: kivinen.orig.c
	$(CC) $(CFLAGS) kivinen.orig.c -o kivinen.orig -lX11 \
	    -lsocket -lresolv -lnsl

imc: imc.c
	$(CC) $(CFLAGS) imc.c -o imc

# NOTE: this is the original program that won
#
imc.orig: imc.orig.c
	$(CC) $(CFLAGS) imc.orig.c -o imc.orig

lush: lush.c
	$(CC) $(CFLAGS) lush.c -o lush

lush.again: lush.c
	$(CC) $(CFLAGS) lush.c -o lush.again
	$(RM) -f lush.again

# NOTE: this is the original program that won
#
lush.orig: lush.orig.c
	$(CC) $(CFLAGS) lush.orig.c -o lush.orig

# NOTE: some systems may need:
#
#  $(CC) $(CFLAGS) marangon.c -o marangon -lcurses -ltermcap
#
marangon: marangon.c
	$(CC) $(CFLAGS) marangon.c -o marangon -lcurses

# NOTE: this is the original program that won
#
# NOTE: some systems may need:
#
#  $(CC) $(CFLAGS) marangon.orig.c -o marangon.orig -lcurses -ltermcap
#
marangon.orig: marangon.orig.c
	$(CC) $(CFLAGS) marangon.orig.c -o marangon.orig -lcurses

nathan: nathan.c
	$(CC) $(CFLAGS) nathan.c -o nathan

# NOTE: this is the original program that won
#
nathan.orig: nathan.orig.c
	$(CC) $(CFLAGS) nathan.orig.c -o nathan.orig

vern: vern.tmp.c
	$(CC) $(CFLAGS) vern.tmp.c -o vern

vern.tmp.c: vern.c
	$(RM) -f vern.tmp.c
	$(SED) <vern.c 's/{ /(/g;s/} /)/g;s/;	/#define /' | \
	    $(SED) 's/}	/=/g;s/{	/i/g' >vern.tmp.c

# NOTE: this is the original program that won
#
vern.orig: vern.orig.tmp.c
	$(CC) $(CFLAGS) vern.orig.tmp.c -o vern.orig

vern.orig.tmp.c: vern.orig.c
	$(RM) -f vern.orig.tmp.c
	$(SED) <vern.orig.c 's/{ /(/g;s/} /)/g;s/;	/#define /' | \
	    $(SED) 's/}	/=/g;s/{	/i/g' >vern.orig.tmp.c

westley: westley.c
	$(CC) $(CFLAGS) westley.c -o westley

# alternate names for selected entries
#
adgrep: adrian
	$(RM) -f adgrep
	$(LN) adrian adgrep
am: ant
	$(RM) -f am
	$(LN) ant am
babble: buzzard.1
	$(RM) -f babble
	$(LN) buzzard.1 babble
first: buzzard.2
	$(RM) -f first
	$(LN) buzzard.2 first
ag: gson
	$(RM) -f ag
	$(LN) gson ag
whereami: westley
	$(RM) -f whereami
	$(LN) westley whereami

clean:
	$(RM) -f *.o a.out core 
	$(RM) -f vern.tmp.c lush.again babble.cppcb vern.orig.tmp.c
	$(RM) -f ad.temp adwc.c adbasename.c adecho.c adhead.c adsleep.c

clobber: clean
	$(RM) -f $(WINNERS) a.out
	$(RM) -f $(ALT_NAMES)
	$(RM) -f adwc adbasename adecho adhead adsleep
	$(RM) -f adrian.orig lush.orig nathan.orig buzzard.2.orig
	$(RM) -f kivinen.orig imc.orig albert.orig marangon.orig vern.orig

am_clobber: clean am
	$(RM) -f am.safe
	$(CP) am am.safe
	$(RM) -f $(WINNERS) a.out
	$(RM) -f $(ALT_NAMES)
	$(RM) -f adwc adbasename adecho adhead adsleep
	$(RM) -f adrian.orig lush.orig nathan.orig buzzard.2.orig
	$(RM) -f kivinen.orig imc.orig albert.orig marangon.orig vern.orig
	$(CP) am.safe am
	$(RM) -f am.safe

nuke: clobber
	@true

install: all
	cat $(WINNERS) > /dev/null
