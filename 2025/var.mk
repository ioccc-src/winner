#######################
# common tool locations
#######################
#
# IMPORTANT: While many of these commands are common to POSIX/SUS/macOS/Linux/UNIX - be careful!
#            Do NOT assume some of the less common commands exist.
#            Test for their existence before using them!
#
# Sort this list with: LC_ALL=C sort -d -u
#
APROPOS= apropos
AR= ar
ARCH= arch
AS= as
AT= at
ATQ= atq
ATRM= atrm
AWK= awk
BASE64= base64
BASENAME= basename
BASH= bash
BATCH= batch
BC= bc
BISON= bison
BSDTAR= bsdtar
BUNDLE= bundle
BUNZIP2= bunzip2
BZCAT= bzcat
BZCMP= bzcmp
BZDIFF= bzdiff
BZEGREP= bzegrep
BZFGREP= bzfgrep
BZGREP= bzgrep
BZIP2= bzip2
BZIP2RECOVER= bzip2recover
BZLESS= bzless
BZMORE= bzmore
C89= c89
C99= c99
CAL= cal
CALC= calc
CANCEL= cancel
CAPTOINFO= captoinfo
CAT= cat
CD= cd
CHGRP= chgrp
CHMOD= chmod
CKSUM= cksum
CLANG= clang
CLANG_FORMAT= clang-format
CLANG_PLUSPLUS= clang++
CLEAR= clear
CMP= cmp
COL= col
COLRM= colrm
COLUMN= column
COMM= comm
COMPRESS= compress
CP= cp
CPAN= cpan
CPIO= cpio
C_PLUSPLUS= c++
C_PLUSPLUS_FILT= c++filt
CPP= cpp
CRC32= crc32
CSH= csh
CSPLIT= csplit
CTAGS= ctags
CURL= curl
CUT= cut
DASH= dash
DATE= date
DC= dc
DD= dd
DF= df
DIFF= diff
DIFF3= diff3
DIG= dig
DIRNAME= dirname
DU= du
ECHO= echo
ED= ed
EGREP= grep -E
ENV= env
EQN= eqn
ERB= erb
EXPAND= expand
EXPECT= expect
EXPR= expr
FALSE= false
FGREP= fgrep
FILE= file
FIND= find
FLEX= flex
FLEX_PLUSPLUS= flex++
FMT= fmt
FOLD= fold
FUNZIP= funzip
FUSER= fuser
GCC= gcc
GCOV= gcov
GDIFFMK= gdiffmk
GEM= gem
GENCAT= gencat
GETCONF= getconf
GETOPT= getopt
GETOPTS= getopts
GIT= git
GPERF= gperf
G_PLUSPLUS= g++
GREP= grep
GROFF= groff
GROPS= grops
GROTTY= grotty
GROUPS= groups
GUNZIP= gunzip
GZEXE= gzexe
GZIP_PROG= gzip
H2PH= h2ph
H2XS= h2xs
HASH= hash
HEAD= head
HEXDUMP= hexdump
HOST= host
HOSTNAME_PROG= hostname
ICONV= iconv
ID= id
INDENT= indent
INFO= info
INFOCMP= infocmp
INFOTOCAP= infotocap
IPCRM= ipcrm
IPCS= ipcs
IRB= irb
JSON_PP= json_pp
KILL= kill
KILLALL= killall
KSH= ksh
LAST= last
LASTCOMM= lastcomm
LD= ld
LESSECHO= lessecho
LESSKEY= lesskey
LESS_PROG= less
LEX= lex
LIBTOOL= libtool
LINK= link
LLDB= lldb
LN= ln
LOCALE= locale
LOCALEDEF= localedef
LOCATE= locate
LOGNAME= logname
LOOK= look
LS= ls
LZCAT= lzcat
LZCMP= lzcmp
LZDIFF= lzdiff
LZEGREP= lzegrep
LZFGREP= lzfgrep
LZLESS= lzless
LZMA= lzma
LZMORE= lzmore
M4= m4
# DO NOT SET.  Make assigns this variable as "make" or "gmake"
##MAKE= make
MAN= man
MANDOC= mandoc
MANPATH= manpath
MESG= mesg
MKDIR= mkdir
MKFIFO= mkfifo
MKTEMP= mktemp
MORE= more
MV= mv
NANO= nano
NASM= nasm
NC= nc
NEQN= neqn
NET_SERVER= net-server
NICE= nice
NL= nl
NM= nm
NOHUP= nohup
NROFF= nroff
NSLOOKUP= nslookup
OBJDUMP= objdump
OD= od
OPENSSL= openssl
PASTE= paste
PATCH= patch
PATHCHK= pathchk
PDFLATEX= pdflatex
PERL= perl
PERLBUG= perlbug
PERLDOC= perldoc
PERLIVP= perlivp
PERLTHANKS= perlthanks
PGREP= pgrep
PICONV= piconv
PIP3= pip3
POD2HTML= pod2html
POD2MAN= pod2man
POD2TEXT= pod2text
POD2USAGE= pod2usage
PODCHECKER= podchecker
PR= pr
PRINTENV= printenv
PRINTF= printf
PROVE= prove
PS= ps
PTAR= ptar
PTARDIFF= ptardiff
PTARGREP= ptargrep
PWD= pwd
PYDOC= pydoc
PYTHON= python
PYTHON3= python3
QUOTA= quota
RANLIB= ranlib
READLINK= readlink
REALPATH= realpath
RENICE= renice
RESET= reset
REV= rev
RM= rm
RMDIR= rmdir
RPCGEN= rpcgen
RS= rs
RSYNC= rsync
RUBY= ruby
RVIEW= rview
RVIM= rvim
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
SHAR= shar
SHASUM= shasum
SHLOCK= shlock
SIZE= size
SLEEP= sleep
SOELIM= soelim
SORT= sort
SPLIT= split
SSH= ssh
SSH_ADD= ssh-add
SSH_AGENT= ssh-agent
SSH_COPY_ID= ssh-copy-id
SSH_KEYGEN= ssh-keygen
SSH_KEYSCAN= ssh-keyscan
STAT= stat
STDBUF= stdbuf
STREAMZIP= streamzip
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
TOE= toe
TOP= top
TOUCH= touch
TPUT= tput
TR= tr
TROFF= troff
TRUE= true
TRUNCATE= truncate
TSET= tset
TSORT= tsort
TTY= tty
UL= ul
UMASK= umask
UNAME= uname
UNCOMPRESS= uncompress
UNEXPAND= unexpand
UNIFDEF= unifdef
UNIQ= uniq
UNITS= units
UNLINK= unlink
UNLZMA= unlzma
UNXZ= unxz
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
VIMTUTOR= vimtutor
W= w
WAIT= wait
WC= wc
WGET= wget
WHATIS= whatis
WHICH= which
WHO= who
WHOAMI= whoami
WHOIS= whois
WRTIE= write
XAR= xar
XARGS= xargs
XMLCATALOG= xmlcatalog
XMLLINT= xmllint
XPATH= xpath
XSUBPP= xsubpp
XXD= xxd
XZ= xz
XZCAT= xzcat
XZCMP= xzcmp
XZDEC= xzdec
XZDIFF= xzdiff
XZEGREP= xzegrep
XZFGREP= xzfgrep
XZGREP= xzgrep
XZLESS= xzless
XZMORE= xzmore
YACC= yacc
YAPP= yapp
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


############
# Homebrew #
############
#
# Set HOMEBREW_PREFIX the top of where Homebrew installs thibgs
#
#       macOS Apple Silicon: HOMEBREW_PREFIX= /opt/homebrew
#       macOS Intel:         HOMEBREW_PREFIX= /usr/local
#       Linux:               HOMEBREW_PREFIX= /home/linuxbrew/.linuxbrew
#
# For macOS users, we recommend Homebrew:
#
#       https://brew.sh
#
# NOTE: And while MacPorts might work, we noticed a number of subtle differences
#       with some of their ported tools to suggest you might be better off
#       with installing Homebrew (see https://brew.sh).  No disrespect is intended
#       to the MacPorts team as they do a commendable job.  Nevertheless, we ran
#       into enough differences with MacPorts environments to suggest you might
#       find a better IOCCC experience with this tool under Homebrew instead.
#
####

HOMEBREW_PREFIX= /opt/homebrew
#HOMEBREW_PREFIX= /usr/local
#HOMEBREW_PREFIX= /home/linuxbrew/.linuxbrew


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
#      make all SDL2_INCLUDE_ROOT=/some/path
#
#SDL2_INCLUDE_ROOT= /usr
#SDL2_INCLUDE_ROOT= /opt/homebrew
SDL2_INCLUDE_ROOT= ${HOMEBREW_PREFIX}
