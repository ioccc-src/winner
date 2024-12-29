#
#  Keywords & Phrases
#
#/LOG/d
#/NDEBUG/d

/^#if/,/^#else/d
/^#endif/d
/UPDATE_ERRNO/d

#
# Replace macros.
#
/^#define peek/d
s/peek(fp)/ungetc(fgetc(fp), fp)/

/^#.*define closesocket/d
s/closesocket/close/

/^#.*define SOCKET/d
s/SOCKET/int/

#
#
#

s/\<int\>/I/
1i\
#define I int

s/char \*/c /
1i\
#define c char *

s/fscanf(fp,/G/
1i\
#define G fscanf(f,
 
#s/break;/B/
#1i\
##define B break;

#s/goto/j/
#1i\
##define j goto

s/while (/W /
1i\
#define W while(

s/return/k/
1i\
#define k return

s/if (/Q /
1i\
#define Q if(

#s/ else / E /
#1i\
##define E else

#s/fgetc(stdin)/G/
#1i\
##define G	fgetc(stdin)
#
#s/fputc(\(.*\), stdout);/p(\1)/
#1i\
##define p(c)	fputc(c, stdout);
#
#s/ungetc(\(.*\), stdin)/u(\1)/
#1i\
##define u(c)	ungetc(c, stdin)

#
# Constant expansion
#
s/LENGTH/Z/g
s/BUFSIZ/Z/g
s/NULL/0/g
s/(void)//g
s/'\\0'/0/g

s/bufferLength/B/g
s/buffer/b/g
s/\<host\>/h/g
s/\<port\>/H/g
s/linksLength/L/g
s/links/l/g

#
#  Functions & Types
#
s/printc(/P(/
s/prints(/p(/
s/mynx(/M(/
s/head/d/
s/spit/D/
s/link/a/
s/fnext(/X(/
s/entity(/e(/

#
# Labels
#
s/error0/a/
s/error1/b/
s/error2/c/
s/display/d/
s/nextpage/e/

#
#  Variables
#
#  n, m, *s, *t, x, y are used for parameters and local variables.
#
s/fmtbuf/s/g
s/fmt/t/g
s/args/x/g

s/url/t/g
s/mark/m/g
s/rows/R/g
s/row/r/g
s/cols/C/g
s/fp/f/g
s/fd/m/g
s/table/Y/g
s/text/T/g
s/entities\[/S[/g
s/lastspace/q/g
s/next/N/g
s/argc/V/g
s/argv/v/g
s/winsz/w/g

s/\<addr\>/A/g
s/\([^t]\)ch\([^ar]\)/\1x\2/g
s/\([^t]\)he\([^a]\)/\1y\2/g

#
#  Expressions
#
#s/([a-z ]*\*) 0/0/g
#s/0 == /!/g
#s/0 == /!/g

s/\([^ ]*[^)]\) == 0/!\1/g
s/\([a-z]*(.*)\) == 0/!\1/g
#s/\((.*)\) == 0/!\1/g

#s/0 < sscanf/sscanf/
s/(0 < /(/g
s/ != 0//g
s/\([^ 	]*[^[]\)\[0\]/*\1/g

#s/0 > //g
#s/ < 0)/)/g
#s/R (\(.*\))/R \1/


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
#s/	/&&&&/g

# Compress tabs...
#s/	/ /g
