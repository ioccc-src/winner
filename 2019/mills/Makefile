#!/usr/bin/env make
#
# 2019 makefile
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

# Compiler warnings
#
#CWARN=
#CWARN= -Wall
#CWARN= -Wall -Wextra
CWARN= -Wall -Wextra -pedantic ${CSILENCE}
#CWARN= -Wall -Wextra -Weverything
#CWARN= -Wall -Wextra -Weverything -pedantic
#CWARN= -Wall -Wextra -Weverything -pedantic ${CSILENCE}

# Silence warnings that ${CWARN} would normally complain about
#
#CSILENCE=
#CSILENCE= -Wno-implicit-int
CSILENCE= -Wno-missing-field-initializers -Wno-for-loop-analysis

# compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=c11

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
#CDEFINE=
#CDEFINE= -DIOCCC=26
CDEFINE= ${param}

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
#LIBS=
#LIBS= -L ${X11_LIBDIR}
LIBS= -lm

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
#CC=clang
MAY_NEED_GCC= gcc


##############################
# Special flags for this entry
##############################
#
OBJ= prog.o
INPUTS_GZ= IOCCC-hints.txt.gz Shakespeare.txt.gz \
	   IOCCC-Rules-Guidelines.txt.gz Eugene_Onegin.txt.gz
INPUTS= IOCCC-hints.txt Shakespeare.txt \
	IOCCC-Rules-Guidelines.txt Eugene_Onegin.txt
CPFILES= IOCCC-hints.cp09_1.809 Shakespeare.cp04_1.633 \
	 IOCCC-Rules-Guidelines.cp98_0.175 Eugene_Onegin.cp11_1.188
OUTPUTS= IOCCC-hints.output.txt Shakespeare.output.txt \
	 IOCCC-Rules-Guidelines.output.txt Eugene_Onegin.output.txt
DATA= ${CPFILES} ${INPUTS_GZ} ${CPFILES}
TARGET = lin1 per1 rnn1 rnn2 rnn3 lstm1 lstm2 lstm3 lstmp1 lstmp2 lstmp3 \
	 rlstm1 rlstm2 rlstm3 gru1 gru2 gru3 prog
#
ALT_OBJ=
ALT_TARGET=

# hyperparameters
param = -DRS=.15 -DTR=.95 -DLR=.002 -DLD=.97 -DLE=10 -DCL=5 -DB1=.9 -DB2=.999 \
        -DEP=1e-8 -DWD=8e-5 -DDI=100 -DSL=200 -DN=50 -DTP=1                   \
        -DPF='"cp%02d_%.3f"'

##############################################################
# Networks
#
# Note that temp variables have been added to force evaluation
# order.  This allows checkpoint files to be portable beetween
# different compilers.
##############################################################

# linear
lin       = -DBK='y=x'

# perceptron
per       = -DBK='y=T(x)'

# recurrent neural network
rnn       = -DHS=128  -DBK='                   \
   hp = I(HS),                                 \
   t1 = L(HS, x),                              \
   h  = C(hp, T(A(t1, L(HS, hp)))),            \
   y  = h                                      \
'

# long short term memory
lstm   = -DHS=128 -DBK='                       \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   f   = S(A(t1, L(HS, hp))),                  \
   t2  = L(HS, x),                             \
   i   = S(A(t2, L(HS, hp))),                  \
   t3  = L(HS, x),                             \
   cn  = T(A(t3, L(HS, hp))),                  \
   t4  = M(f, cp),                             \
   c   = C(cp, A(t4, M(i, cn))),               \
   t5  = L(HS, x),                             \
   o   = S(A(t5, L(HS, hp))),                  \
   h   = C(hp, M(o, T(c))),                    \
   y   = h                                     \
'

# lstm with passthrough
lstmp = -DHS=128 -DBK='                        \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   t2  = A(t1, L(HS, hp)),                     \
   f   = S(A(CM(cp), t2)),                     \
   t3  = L(HS, x),                             \
   t4  = A(t3, L(HS, hp)),                     \
   i   = S(A(CM(cp), t4)),                     \
   t5  = L(HS, x),                             \
   cn  = T(A(t5, L(HS, hp))),                  \
   t6  = M(f, cp),                             \
   c   = C(cp, A(t6, M(i, cn))),               \
   t7  = L(HS, x),                             \
   t8  = A(t7, L(HS, hp)),                     \
   o   = S(A(CM(c),  t8)),                     \
   h   = C(hp, M(o, T(c))),                    \
   y   = h                                     \
'

# residual lstm
rlstm = -DHS=128 -DBK='                        \
   cp  = I(HS),                                \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   t2  = A(t1, L(HS, hp)),                     \
   f   = S(A(CM(cp), t2)),                     \
   t3  = L(HS, x),                             \
   t4  = A(t3, L(HS, hp)),                     \
   i   = S(A(CM(cp), t4)),                     \
   t5  = L(HS, x),                             \
   cn  = T(A(t5, L(HS, hp))),                  \
   t6  = M(f, cp),                             \
   c   = C(cp, A(t6, M(i, cn))),               \
   t7  = L(HS, x),                             \
   t8  = A(t7, L(HS, hp)),                     \
   o   = S(A(CM(c),  t8)),                     \
   m   = L(HS, T(c)),                          \
   h   = C(hp, M(o, A(m, L(HS, x)))),          \
   y   = h                                     \
'

# gated recurrent unit
gru    = -DHS=128 -DBK='                       \
   hp  = I(HS),                                \
   t1  = L(HS, x),                             \
   z   = S(A(t1, L(HS, hp))),                  \
   t2  = L(HS, x),                             \
   r   = S(A(t2, L(HS, hp))),                  \
   t3  = L(HS, x),                             \
   c   = T(A(t3, L(HS, M(r, hp)))),            \
   zc  = OG(1, -1, z),                         \
   t4  = M(zc, hp),                            \
   h   = C(hp, A(t4, M(z, c))),                \
   y   = h                                     \
'

# single-layer network
one_layer = -DNW='                             \
   x   = I(n),                                 \
   y   = L(n, MD(x))                           \
'

# two-layer network
two_layer = -DNW='                             \
   x   = I(n),                                 \
   y   = L(n, MD(MD(x)))                       \
'

# three-layer network
three_layer = -DNW='                           \
   x   = I(n),                                 \
   y   = L(n, MD(MD(MD(x))))                   \
'

# Enumerated list of networks
#
lin1   = ${lin}   ${one_layer}
per1   = ${per}   ${one_layer}
rnn1   = ${rnn}   ${one_layer}
rnn2   = ${rnn}   ${two_layer}
rnn3   = ${rnn}   ${three_layer}
lstm1  = ${lstm}  ${one_layer}
lstm2  = ${lstm}  ${two_layer}
lstm3  = ${lstm}  ${three_layer}
lstmp1 = ${lstmp} ${one_layer}
lstmp2 = ${lstmp} ${two_layer}
lstmp3 = ${lstmp} ${three_layer}
rlstm1 = ${rlstm} ${one_layer}
rlstm2 = ${rlstm} ${two_layer}
rlstm3 = ${rlstm} ${three_layer}
gru1   = ${gru}   ${one_layer}
gru2   = ${gru}   ${two_layer}
gru3   = ${gru}   ${three_layer}

# default network
#
prog   = ${rnn1}

#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

${TARGET}: prog.c Makefile ${INPUTS}
	${CC} ${CFLAGS} -o $@ $< $($@) ${LIBS}

# alternative executable
#
alt: ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}

${INPUTS}: %.txt: %.txt.gz
	${ZCAT} < $< > $@

test: ${OUTPUTS}

# First 1000 lines of generated output
#
generator = ./lstm2

test-64bit:	IOCCC-hints.output.txt IOCCC-Rules-Guidelines.output.txt Shakespeare.output.txt Eugene_Onegin.output.txt

IOCCC-hints.output.txt: IOCCC-hints.cp09_1.809 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

Shakespeare.output.txt: Shakespeare.cp04_1.633 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

IOCCC-Rules-Guidelines.output.txt: IOCCC-Rules-Guidelines.cp98_0.175 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

Eugene_Onegin.output.txt: Eugene_Onegin.cp11_1.188 ${generator}
	${generator} < $< | ${HEAD} -n 1000 > $@

###############
# utility rules
###############
#
everything: all alt

clean:
	${RM} -f ${OBJ} ${ALT_OBJ}

cpclean:
	${RM} -f cp*_*.*

clobber: clean cpclean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -f ${INPUTS}
	${RM} -f ${OUTPUTS}
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely you are performing, Dr. May!"
	@${TRUE}

# backwards compatibility
#
build: all
	@${TRUE}


##################
# 133t hacker rulz
##################
#
love:
	@echo 'not war?'
	@${TRUE}

haste:
	$(MAKE) waste
	@${TRUE}

waste:
	@echo 'haste'
	@${TRUE}

make:
	@echo 'Attend a maker faire'
	@${TRUE}

easter_egg:
	@echo you expected to often mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Eggy

fabricate fashion form frame manufacture produce: make
	@${TRUE}

sandwich:
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo $${RANDOM}`date +%s`$${RANDOM} > $@; \
	else \
	    echo 'What? Make it yourself.'; \
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
	    echo "planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic fc6b6af226b7cc598de3d48fc20ed0bd54f7b4f7f0f651a32b9cf8345b2a3b3f --FNV1a_hash_512_bit "prog"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	    sleep 2; \
	    echo "Wrong! Do it again!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --level 391581 --mode 216193 --FNV1a_hash_512_bit "prog"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: supernova
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo therefore IAU, $@ is a planet

pluto: supernova
	${MAKE} charon
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo therefore, $@ is a planet
	@echo get used to having lots of planets because a $< can ${MAKE} a lot of them
