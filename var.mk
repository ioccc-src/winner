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
BASH= bash
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
EGREP= grep -E
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
LEX= len
LINK= link
LN= ln
LS= ls
M4= m4
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
PDFLATEX= pdflatex
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
SDL1_CONFIG= sdl-config
SDL2_CONFIG= sdl2-config
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
STRINGS= strings
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


#####
# X11
#####

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


##########################
# SD1 and SDL2 libraries #
##########################
#
# For details on how to install SDL/SDL2 see the FAQ on how to compile and use
# IOCCC entries that require SDL1 or SDL1:
#
#   https://www.ioccc.org/faq.html#SDL
#
# SDL2_INCLUDE_ROOT is the directory under which include/SDL/ and/or
# include/SDL2/ may be found.
#
# Even if you do not use Homebrew (one of the methods for macOS), you might set
# the environment variable $HOMEBREW_PREFIX to the SDL2_INCLUDE_ROOT directory
# path as the default SDL2_INCLUDE_ROOT value is $HOMEBREW_PREFIX.  Of you may
# run make and set SDL2_INCLUDE_ROOT directly:
#
#	make all SDL2_INCLUDE_ROOT=/some/path
#
#SDL2_INCLUDE_ROOT= /usr
#SDL2_INCLUDE_ROOT= /opt/homebrew
SDL2_INCLUDE_ROOT= ${HOMEBREW_PREFIX}
