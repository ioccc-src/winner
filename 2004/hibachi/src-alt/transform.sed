#
#  Keywords & Phrases
#
/LOG/d
/NDEBUG/d
/^#if/d
/^#endif/d

#s/fprintf(stderr,/G/
#1i\
##define G fprintf(stderr,

s/break;/B/
1i\
#define B break;

##s/else if (/E Q (/

s/if (/Q /
1i\
#define Q if(

##s/ else / E /
##1i\
###define E else

s/return/R/
1i\
#define R return

s/getenv(/V /
1i\
#define V getenv(

s/"DOCUMENT_ROOT"/T/g
1i\
#define T "DOCUMENT_ROOT"

#s/"404 Not Found"/N/g
#1i\
##define N "404 Not Found"

##s/for (/F(/
##1i\
###define F for

##s/while (/W(/
##1i\
###define W while

##s/BUFSIZ/Z/g
##1i\
###define Z BUFSIZ

s/snprintf(/S /
1i\
#define S snprintf(



#
# Constant expansion
#
s/NULL/0/g
s/'\\0'/0/g

#
#  Functions & Types
#
s/print(/P(/
s/findAndSet(/A(/
s/status(/X(/

#
#  Variables
#
#  p, c, i, j, k are used for parameters and local variables.
#
s/fd\([^a-z]\)/f\1/g
s/finfo/g/g
s/\([^a-z_]\)addr/\1a/g
s/droot/w/g
s/query/q/g
s/pathtranslated/y/g
s/pathinfo/x/g
s/path/l/g
s/request\[0]/*r/g
s/request/r/g
s/uri/u/g
s/value/v/g
s/client/t/g
s/headers/o/g
s/notfound/m/g
s/error/e/g
/^main/,/^}/s/argc/c/g
/^main/,/^}/s/argv/p/g

s/strcspn(u,/C/
1i\
#define C strcspn(u,

#
#  Expressions
#
s/([a-z ]*\*) 0/0/g
s/0 == /!/g
#s/(0 < /(/g
s/ != 0//g
s/0 > //g
#s/ < 0)/)/g
#%s/(\([^ ][^ ]* \)== 0/(!\1/g
# %s/ \([^ ][^ ]* \)== 0/ !\1/g
#%s/ )/)/g
# %s/ ;/;/g
#%s/CHAR(\(.*\)))/\1)/g
#%s/CHAR(\(.*\))/\1)/g
s/R (\(.*\))/R \1/


#
# Braces
#

#/[ 	]{/ {
#h
#s/[ 	]{//
#a\
#{
#
#}
#

##s/^[ 	]*//
#s/^[ 	]*}/}/
#
##/^[ 	]*$/d

# Expand tabs...
s/	/&&&&/g

# Compress tabs...
#s/	/ /g
