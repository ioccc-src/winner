#!/usr/bin/env make
#
# 2015 makefile
#
# This work by Landon Curt Noll, Simon Cooper, and Leonid A. Broukhis
# is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


################
# tool locations
################
#
SHELL= bash
CP= cp
CPP= cpp
GUNZIP= gunzip
BUNZIP2= bunzip2
LD= ld
MAKE= make
RM= rm
SED= sed
TAR= tar
TRUE= true
MKDIR= mkdir
MV= mv
TR= tr
GREP= grep
SORT= sort
UNIQ= uniq

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
CSILENCE= -Wno-conversion -Wno-float-conversion -Wno-missing-prototypes \
	  -Wno-missing-variable-declarations -Wno-shadow -Wno-sign-conversion

# Compiler standard
#
#CSTD=
#CSTD= -ansi
#CSTD= -std=c11
CSTD= -std=c99

# Compiler bit architecture
#
# Some entries require 32-bitness:
# ARCH= -m32
#
# Some entries require 64-bitess:
# ARCH= -m64
#
# By default we assume nothing:
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
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
CFLAGS= ${CWARN} ${CSTD} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=

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
ENTRY= prog
CSRC= ${ENTRY}.c
OBJ= ${ENTRY}.o
DATA=
ALT_OBJ=
ALT_ENTRY=
TARGET= gray-scott-1 gray-scott-2 gray-scott-3 gray-scott-4 \
	fitzhugh-nagumo-1 fitzhugh-nagumo-2 ginzburg-landau oregonator

GRAY_SCOTT_MODEL = -Delta_u="Du*laplacian(u)-u*v*v+F*(1-u)" \
		   -Delta_v="Dv*laplacian(v)+u*v*v-v*(F+K)"

FITZHUGH_NAGUMO_MODEL = -Delta_u="Du*laplacian(u)+u-u*u*u-v" \
			-Delta_v="Dv*laplacian(v)+E*(u-A1*v-A0)"

GINZBURG_LANDAU_MODEL = \
    -Delta_u="Du*laplacian(u)+A*u-G*v+(-B*u+D*v)*(u*u+v*v)" \
    -Delta_v="Dv*laplacian(v)+A*v+G*u+(-B*v-D*u)*(u*u+v*v)"

OREGONATOR_MODEL = -Delta_u="Du*laplacian(u)+(u-u*u-F*v*(u-Q)/(u+Q))/E" \
		   -Delta_v="Dv*laplacian(v)+u-v"


#################
# build the entry
#################
#
all: ${TARGET} ${DATA}
	@${TRUE}

${ENTRY}: gray-scott-1
	${RM} -f $@
	${CP} gray-scott-1 $@

gray-scott-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.035 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192

gray-scott-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.082 -DDv=0.041 -DF=0.035 -DK=0.063 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=128:255:192

gray-scott-3: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.100 -DDv=0.050 -DF=0.030 -DK=0.060 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=255:128:192

gray-scott-4: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GRAY_SCOTT_MODEL} -DDu=0.040 -DDv=0.020 -DF=0.012 -DK=0.050 \
	    -DUV_BACKGROUND=1,0 -DUV_DROP=-0.5,0.5 \
	    -DTIMESTEP=1.0 -DSPEED=8 -DRGB=192:192:255

fitzhugh-nagumo-1: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=3 -DA0=-0.1 -DA1=2 -DE=0.06 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,0 \
	    -DTIMESTEP=0.050 -DSPEED=80 -DRGB=128:192:255

fitzhugh-nagumo-2: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${FITZHUGH_NAGUMO_MODEL} -DDu=1 -DDv=10 -DA0=0.0 -DA1=1 -DE=1 \
	    -DUV_BACKGROUND=0 -DUV_DROP=1,1 \
	    -DTIMESTEP=0.005 -DSPEED=20 -DRGB=128:192:255

ginzburg-landau: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${GINZBURG_LANDAU_MODEL} -DDu=0.1 -DDv=0.1 -DA=0.0625 -DB=1 -DD=1.05 -DG=0.0625 \
	    -DUV_BACKGROUND=-0.1 -DUV_DROP=0,1 \
	    -DTIMESTEP=0.60 -DSPEED=40 -DRGB=128:255:128

oregonator: ${CSRC}
	${CC} ${CFLAGS} -o $@ ${CSRC} \
	    ${OREGONATOR_MODEL} -DDu=0.01 -DDv=0.01 -DE=0.1 -DF=1.4 -DQ=0.002 \
	    -DUV_BACKGROUND=0 -DUV_DROP=0.05,0.2 \
    	    -DTIMESTEP=0.001 -DSPEED=80 -DRGB=128:192:255

# alternative executable
#
alt: ${ALT_ENTRY}
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

clobber: clean
	${RM} -f ${TARGET} ${ALT_ENTRY}

nuke: clobber
	@${TRUE}

dist_clean: nuke
	@${TRUE}

install:
	@echo "Surely we are joking Dr. May!"
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
	@echo you expected to sometimes mis-understand this $${RANDOM} magic
	@echo chongo '<was here>' "/\\oo/\\"
	@echo Readers shall not be disallowed from not failing to be unable to not partly misunderstand this partocular final echo.

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: nuke
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v5; \
	else \
	    echo "planet deniers, like the IAU, are amusing"; \
	fi
	@echo A $@ helps ${MAKE} the elements that help form planets
	@${TRUE}

deep_magic:
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 2ed3582ec5c094a093fea2a6bcb9f19439892873c9cc45ed1ceaafe08b7d52e1b2c7cd524be3b0b2 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "You are holding it wrong!"; \
	fi
	@${TRUE}

magic: deep_magic
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --mode 216091 --level 216193 --FNV1a_hash_512_bit "${ENTRY}"; \
	else \
	    echo "These aren't the primes you're looking for Pauline!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: supernova
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet

pluto: supernova
	${MAKE} charon
	@echo $@ is a dwarf planet
	@echo dwarf is a type of planet
	@echo $@ is a planet
	@echo get used to having lots of planets becasue supernovae can ${MAKE} a lot of them
#!/usr/bin/env make
#
# IOCCC 2015 winning entry - endoh1

################################################################################
#
# An Historical Makefile NOTE:
#
# The orig.Makefile, if it exits, is the original Makefile before this IOCCC
# year directory was reworked so that entries are in separate directories.
# This also applies to any orig.ansi.mk and orig.common.mk files.
#
# Several Makefiles were modified / formed in 2022, and as such it may have
# elements that are not historically compatible with way entries were built.
# The orig.Makefile, if it exits, is a copy of the pre-modified Makefile.
#
# Regarding individual entries:
#
# IOCCC winning entry code may not work on your system.  Even with standards,
# conditions and build environments change, especially when it comes to more
# extreme code such you might find in an IOCCC winner.  Moreover, what was
# allowed and liked in one IOCCC contest may no longer be liked/allowed in
# later IOCCC years.
#
# Corrections on winning author and fixing typos in remarks are VERY WELCOME.
#
# GitHub pull requests are welcome:
#
# If you have a patch that might make running an entry work in modern Unix-like
# environments, please create a GitHub pull request for the IOCCC judges to
# consider.
#
# Suggestions and corrections regarding Makefiles, winning author information,
# fixing typos in remarks, and code patches are welcome via opening a GitHub
# issue or better yet, by creating a GitHub pull request for the IOCCC judges
# to consider.  To form a GitHub issue or GitHub pull, please visit:
#
# https://github.com/ioccc-src/winner
#
################################################################################

# This work by Landon Curt Noll and Leonid A. Broukhis is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

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
MKFIFO= mkfifo
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
WGET= wget
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
ZIPGREP= zipgrep
ZIPINFO= zipinfo
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

# Common C compiler warnings to silence
#
CSILENCE=
#CSILENCE= -Wno-implicit-int

# Common C compiler warning flags
#
#CWARN= ${CSILENCE}
#CWARN= -Wall ${CSILENCE}
#CWARN= -Wall -Wextra ${CSILENCE}
CWARN= -Wall -Wextra -pedantic ${CSILENCE}

# Compiler standard
#
#CSTD=
#CSTD= -ansi
CSTD= -std=gnu11

# Compiler bit architecture
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

# Defines that are needed to compile
#
CDEFINE=
#CDEFINE= -DIOCCC

# Include files that are needed to compile
#
CINCLUDE=
#CINCLUDE= -include stdlib.h
#CINCLUDE= -include stdio.h
#CINCLUDE= -include stdlib.h -include stdio.h
#CINCLUDE= -I ${X11_INCDIR}
#CINCLUDE= -I ${HOMEBREW_PREFIX}/include/SDL2

# Optimization
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

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LIBS=
#LIBS= -lm
#LIBS= -L ${X11_LIBDIR} -lX11
#LIBS= -L ${HOMEBREW_PREFIX}/lib -lSDL

# C compiler to use
#
CC= cc
#CC=clang
#CC=gcc

# Compiler add-ons or replacements for clang only
#
ifeq ($(CC),clang)
#
#CSILENCE+=
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq ($(CC),gcc)
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special flags for this entry
##############################
#
ENTRY= endoh1
PROG= prog
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG}
#
ALT_OBJ=
ALT_TARGET=


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber install \
	love haste waste maker easter_egg sandwich \
	supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	${CC} ${CFLAGS} $< -o $@ ${LIBS}

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
	@-if [ -f indent.c ]; then \
	    echo ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

install:
	@echo "Dr. Spock says that is not logical!"
	@${TRUE}

# you may be able to misunderstand the source by reading indent.c
#
indent.c: ${PROG}.c
	@if which "${GINDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${GINDENT} < $< > $@"; \
	    ${GINDENT} < $< > $@; \
	elif which "${INDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${INDENT} < $< > $@"; \
	    ${INDENT} < $< > $@; \
	else \
	    echo "no intent tool found, ident $< yourself, sorry"; \
	    echo "exit 1"; \
	    exit 1; \
	fi


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

maker:
	@echo 'Participate in a maker faire'
	@${TRUE}

easter_egg:
	@echo "you expected to often misunderstand this $${RANDOM} magic"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "Eggy"

sandwich: easter_egg
	@if [ `id -u` -eq 0 ]; then \
	    echo 'Okay.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    exit 1; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [ -r .code_anal ]; then \
	    ${RM} -f .code_anal_v6; \
	else \
	    echo "planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ helps ${MAKE} the elements that help form planets"
	@${TRUE}

deep_magic: supernova
	@-if [ -r .code_anal ]; then \
	    ccode_analysis --deep_magic 7889066cdbdf09b0408021754586e895be641cc9be29e7eafd3ca65359541f17 \
	    		   --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
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
	    ccode_analysis --level 20003 --mode 5717175 --FNV1a_hash_512_bit -v2 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi
	@${TRUE}

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore IAU, $@ is a planet"

pluto: charon
	${MAKE} charon
	@echo "$@ is a dwarf planet"
	@echo "dwarf is a type of planet"
	@echo "therefore, $@ is a planet"
	@echo "having lots of planets is good feature because supernovae can help ${MAKE} a lot of them"
