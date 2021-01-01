#!/usr/bin/env make
#
# 2020 makefile
#
# This work by Landon Curt Noll, Simon Cooper, and Leonid A. Broukhis
# is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/

#############################
# shell used by this Makefile
#############################
#
SHELL= /bin/bash

#######################
# common tool locations
#######################
#
A2P= a2p
AR= ar
ASA= asa
AT= at
ATQ= atq
ATRM= atrm
AWK= awk
BANNER= banner
BASE64= base64
BASENAME= basename
BATCH= batch
BC= bc
BINHEX= binhex
BISON= bison
BUNZIP2= bunzip2
BZCAT= bzcat
BZCMP= bzcmp
BZDIFF= bzdiff
BZEGREP= bzegrep
BZFGREP= bzfgrep
BZGREP= bzgrep
BZIP2= bzip2
BZLESS= bzless
BZMORE= bzmore
C2PH= c2ph
C89= c89
C99= c99
CAL= cal
CALC= calc
CAT= cat
CD= cd
CHFLAGS= chflags
CHGRP= chgrp
CHMOD= chmod
CKSUM= cksum
CLANG= clang
CLANG_PLUSPLUS= clang++
CLEAR= clear
CMP= cmp
COL= col
COLLDEF= colldef
COLRM= colrm
COLUMN= column
COMPRESS= compress
CP= cp
CPIO= cpio
CPP= cpp
CRC32= crc32
CSH= csh
CSPLIT= csplit
CURL= curl
CUT= cut
C_PLUSPLUS= c++
C_PLUSPLUS_FILT= c++filt
DATE= date
DC= dc
DD= dd
DF= df
DIFF3= diff3
DIFF= diff
DIG= dig
DIRNAME= dirname
ECHO= echo
ED= ed
EGREP= egrep
ENV= env
EQN= eqn
ETAGS= etags
EXPECT= expect
EXPR= expr
FALSE= false
FGREP= fgrep
FILE= file
FIND2PERL= find2perl
FIND= find
FLEX= flex
FLEX_PLUSPLUS= flex++
FMT= fmt
FOLD= fold
FS_USAGE= fs_usage
FUNZIP= funzip
FUSER= fuser
GCC= gcc
GDIFFMK= gdiffmk
GENCAT= gencat
GENSTRINGS= genstrings
GETOPT= getopt
GETOPTS= getopts
GINDENT= gindent
GNUMAKE= gnumake
GREP= grep
GROFF= groff
GROFFER= groffer
GROG= grog
GROPS= grops
GROTTY= grotty
GUNZIP= gunzip
GVIM= gvim
GZCAT= gzcat
GZEXE= gzexe
GZIP_PROG= gzip
G_PLUSPLUS= g++
H2PH= h2ph
H2XS= h2xs
HASH= hash
HEAD= head
HOSTNAME_PROG= hostname
ICONV= iconv
ID= id
INDENT= indent
INFO= info
JOT= jot
KILL= kill
KSH= ksh
LAST= last
LD= ld
LESSECHO= lessecho
LEX= len
LINK= link
LN= ln
LS= ls
M4= m4
MAKE= make
MAN= man
MKDIR= mkdir
MKFIFo= mkfifo
MKTEMP= mktemp
MV= mv
NANO= nano
NASM= nasm
NEQN= neqn
NICE= nice
NL= nl
NM= nm
NOHUP= nohup
NROFF= nroff
NSLOOKUP= nslookup
OD= od
OPENSSL= openssl
PASTE= paste
PATCH= patch
PATHCHK= pathchk
PAX= pax
PERL= perl
PICO= pico
PR= pr
PRINTENV= printenv
PS= ps
PTAR= ptar
PTARDIFF= ptardiff
PTARGREP= ptargrep
PWD= pwd
PYDOC= pydoc
PYTHON= python
PYTHONW= pythonw
READLINK= readlink
RENICE= renice
RESET= reset
REV= rev
RI= ri
RM= rm
RMDIR= rmdir
RSYNC= rsync
RUBY= ruby
RVIM= rvim
SAY= say
SCP= scp
SCREEN= screen
SCRIPT= script
SDIFF= sdiff
SED= sed
SEQ= seq
SFTP= sftp
SH= sh
SHA1= sha1
SHA= sha
SHAR= shar
SHASUM5_18= shasum5.18
SHASUM= shasum
SIZE= size
SLEEP= sleep
SORT= sort
SSH= ssh
STAT= stat
STRIP= strip
STTY= stty
SUM= sum
SYNC= sync
TABS= tabs
TAIL= tail
TAR= tar
TEE= tee
TEST= test
TFTP= tftp
TIDY= tidy
TIME= time
TOP= top
TOUCH= touch
TPUT= tout
TPUT= tput
TR= tr
TROFF= troff
TRUE= true
TSET= tset
TSORT= tsort
UL= ul
UNAME= uname
UNCOMPRESS= uncompress
UNEXPAND= unexpand
UNIFDEF= unifdef
UNIFDEFALL= unifdefall
UNIQ= uniq
UNITS= units
UNLINK= unlink
UNZIP= unzip
UNZIPSFX= unzipsfx
UPTIME= uptime
UUDECODE= uudecode
UUENCODE= uuencode
UUIDGEN= uuidgen
VI= vi
VIEW= view
VIM= vim
VIMDIFF= vimdiff
W= w
WAIT4PATH= wait4path
WAIT= wait
WC= wc
WHAT= what
WHATIS= whatis
WHICH= which
WHO= who
WHOAMI= whoami
WHOIS= whois
WRTIE= write
XAR= xar
XARGS= xargs
XATTR= xattr
XXD= xxd
YACC= yacc
YES= yes
ZCAT= zcat
ZCMP= zcmp
ZDIFF= zdiff
ZEGREP= zegrep
ZFGREP= zfgrep
ZFORCE= zforce
ZGREP= zgrep
ZIP= zip
ZIPCLOAK= zipcloak
ZIPGREp= zipgrep
ZIPINFo= zipinfo
ZIPNOTE= zipnote
ZIPSPLIT= zipsplit
ZLESS= zless
ZMORE= zmore
ZNEW= znew
ZPRINT= zprint
ZSH= zsh

# Set X11_LIBDIR to the directory where the X11 library resides
#
#X11_LIBDIR= /usr/X11R6/lib
#X11_LIBDIR= /usr/X11/lib
X11_LIBDIR= /opt/X11/lib

# Set X11_INCLUDEDIR to the directory where the X11 include files reside
#
#X11_INCDIR= /usr/X11R6/include
#X11_INCDIR= /usr/X11/include
X11_INCDIR= /opt/X11/include

# CWARN - Silence warnings that ${CWARN} would normally complain about
# CSILENCE -Compiler warnings
#
ifeq ($(CC),clang)

# clang CSILENCE and CWARN
#
#CSILENCE=
#CSILENCE= -Wno-implicit-int
CSILENCE= -Wno-comma -Wno-conversion -Wno-documentation -Wno-double-promotion -Wno-missing-prototypes \
	  -Wno-missing-variable-declarations -Wno-redundant-parens -Wno-shadow -Wno-sign-compare \
	  -Wno-unknown-warning-option
#
#CWARN= $CSILENCE}
#CWARN= -Wall $CSILENCE}
#CWARN= -Wall -Wextra $CSILENCE}
#CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything $CSILENCE}
CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

else
ifeq ($(CC),gcc)

# gcc CSILENCE and CWARN
#
#CSILENCE=
#CSILENCE= -Wno-implicit-int
CSILENCE= -Wno-sign-compare -Wno-unknown-warning-option
#
#CWARN= $CSILENCE}
#CWARN= -Wall $CSILENCE}
#CWARN= -Wall -Wextra $CSILENCE}
CWARN= -Wall -Wextra -pedantic ${CSILENCE}

else

# default CSILENCE and WARN
#
#CSILENCE=
#CSILENCE= -Wno-implicit-int
CSILENCE= -Wno-sign-compare -Wno-unknown-warning-option
#
#CWARN= $CSILENCE}
#CWARN= -Wall $CSILENCE}
#CWARN= -Wall -Wextra $CSILENCE}
CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything $CSILENCE}
#CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

endif
endif

# compiler standard
#
#CSTD=
#CSTD= -ansi
#CSTD= -std=c11
CSTD= -std=c99

# compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitness:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# defines that are needed to compile
#
CDEFINE=
#CDEFINE= -DIOCCC

# include files that are needed to compile
#
CINCLUDE=
#CINCLUDE= -include stdlib.h
#CINCLUDE= -include stdio.h
#CINCLUDE= -include stdlib.h -include stdio.h
#CINCLUDE= -I ${X11_INCDIR}

# optimization
#
# Most compiles will safely use -O2.  Some can use only -O1 or -O.
# A few compilers have broken optimizers or this entry make break
# under those buggy optimizers and thus you may not want anything.
# Reasonable compilers will allow for -O3.
#
#OPT=
#OPT= -O
#OPT= -O1
#OPT= -O2
OPT= -O3

# default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=
#LIBS= -L ${X11_LIBDIR}

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
#CC= clang
MAY_NEED_GCC= gcc


##############################
# Special flags for this entry
##############################
#
OBJ= prog.o
DATA= bear.txt hello.txt spoiler.zip yoda.txt
TARGET= prog
#
ALT_OBJ=
ALT_TARGET=


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

prog: prog.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

# alternative executable
#
alt: ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}


###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
	@-if [ -f indent.c ]; then \
	    ${ECHO} ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    ${ECHO} 'ate sandwich'; \
	fi

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@${ECHO} "Surely you are performing, Dr. Science!"
	@${TRUE}

# backwards compatibility
#
build: all
	@${TRUE}

# you may be able to mis-understand the source by reading indent.c
#
indent.c: prog.c
	@if which "${GINDENT}" >/dev/null 2>&1; then \
	    ${ECHO} ${RM} -f $@; \
	    ${RM} -f $@; \
	    ${ECHO} "${GINDENT} < $< > $@"; \
	    ${GINDENT} < $< > $@; \
	elif which "${INDENT}" >/dev/null 2>&1; then \
	    ${ECHO} ${RM} -f $@; \
	    ${RM} -f $@; \
	    ${ECHO} "${INDENT} < $< > $@"; \
	    ${INDENT} < $< > $@; \
	else \
	    ${ECHO} "no intent prog found, ident $< yourself, sorry"; \
	    ${ECHO} "exit 1"; \
	    exit 1; \
	fi


##################
# 133t hacker rulz
##################
#
love:
	@${ECHO} 'not war?'
	@${TRUE}

haste:
	$(MAKE) waste
	@${TRUE}

waste:
	@${ECHO} 'haste'
	@${TRUE}

make:
	@${ECHO} 'We encourage you to attend a maker faire'
	@${TRUE}

easter_egg:
	@${ECHO} you expected to often mis-understand this $${RANDOM} magic
	@${ECHO} chongo '<was here>' "/\\oo/\\"
	@${ECHO} Eggy and Kitty

fabricate fashion form frame manufacture produce: make
	@${TRUE}

sandwich:
	@if [ `id -u` -eq 0 ]; then \
	    ${ECHO} 'Okay.'; \
	    ${ECHO} $${RANDOM}`date +%s`$${RANDOM} | \
	      ${SHASUM} -a 512256 | \
	      ${SED} -e 's/ .*//' > $@; \
	else \
	    ${ECHO} 'Reall?!? Make it yourself.'; \
	    exit 1; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    ${ECHO} "planet deniers, like a few silly IAU members, are so cute when they try to defend their logic"; \
	fi
	@${ECHO} A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 253d8c80830e2df66c018820004b3d4939821bbd7d781fc50d9e633797e44f65d1d62c707bb7e5a82c328a37bbf9ecb4c46fb56aa3f08641fcf45d10ba3c6081 --FNV1a_hash_512_bit "prog"; \
	else \
	    ${ECHO} "Wrong! Do it again!"; \
	    sleep 1; \
	    ${ECHO} "Wrong! Do it again!"; \
	    sleep 1; \
	    ${ECHO} "Wrong! Do it again!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 391581 --mode 216193 --state Riesel --FNV1a_hash_512_bit "prog"; \
	else \
	    ${ECHO} "If you don't eat yer meat, you can't have any pudding!"; \
	    ${ECHO} "How can you have any pudding if you don't eat yer meat?!"; \
	    ${ECHO} "p.s. Be cafeful with that axe, Eugene."; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: supernova
	@${ECHO} $@ is a dwarf planet
	@${ECHO} dwarf is a type of planet
	@${ECHO} therefore we continue to tell the IAU that $@ is a planet

pluto: supernova
	${MAKE} charon
	@${ECHO} $@ is a dwarf planet
	@${ECHO} dwarf is a type of planet
	@${ECHO} therefore, $@ is a planet
	@${ECHO} having lots of planets is good feature because $< can help ${MAKE} a lot of them
