#!/bin/sh

# unob is a proof-of-concept script.
# Prior to tac, scripting the layout of C code was intractable.
#
# There are uncountably many possible refinements to this script.
# Enjoy the madness of getting a perfect layout of C code via
# an automated process.  Or just enjoy a significant help in
# reading obfuscated C code!

: ${PROG:=./prog}  # PROG=tac ./unob.sh prog.c
: ${KW:=c11}       # KW=ioccc.kw.freq ./unob.sh prog.c
: ${DEF:=}         # DEF="-DW=\\\"kandr2\\\" -DU=\\\"usage\ string\\\"" ./unob.sh -p prog.c

# optionally preprocess up to 3 times to handle #ifdef X #define Y
# unob prog.c			# nonce
# unob -p prog.c		# once
# unob -p -p prog.c		# twice
# unob -p -p -p prog.c		# thrice
# unob -p -p -p -p prog.c	# yer out

function pp {
    cpp2=cat
    cpp3=cat
    if [ "x$1" == "x-p" ]; then
	shift
	if [ "x$1" == "x-p" ]; then
	    cpp2="cpp -E"
	    shift
	fi
	if [ "x$1" == "x-p" ]; then
	    cpp3="cpp -E"
	    shift
	fi
	cat $* |
	  sed 's/# *include/##include/' |
	  eval cpp -E "$DEF" |
	  eval $cpp2 |
	  eval $cpp3 |
	  sed 's/^#[^#].*$//' |
	  sed 's/##inc/#inc/'
    else
	cat $*
    fi
}

script='
BEGIN {
	last=nl="\n";
	f="'$KW'"; while(getline <f > 0) ++kw[$0]; close(f);
	if (length(kw) == 0) {
		print "cannot find",f "; check KW environment variable" | "cat 1>&2"
		exit
	}
}

function iskw(a)   { return a in kw }
function indent()  { return sprintf("%.*s", n*3, "                              ") }
function newline() { if (!infor && last != nl) printf last=nl }
function show(a) {
	if (len>80 || (len>60 && (last ~ /^;/ || (last ~ /^,/ && paren==0))))
		printf "%c%s", last=nl, indent()	# yes, double indent here
	if (len>60 && last ~ /^\)/ && a !~ /^\)/ && paren == 0)
		printf last=nl
	if (last==nl) { len=0; printf "%s", indent() }

	if (length(a) > 80 && a ~ /\"/) {
		newline()
		len = 80
		max = length(a)
		for (off=0; off <= max; off += len)
			printf "%s%s%c%s",
				substr(a, off, len),
				(off+len > max) ? "" : "\\",
				last=nl, indent()
		len = 0
		return
	}

	printf "%s%s", space(), a
	len += length(a space())
	last=a
}
function space() {
	return iskw(last) ||
	 (last != "." &&
	  last ~ /[A-Za-z0-9_+-\/%^|&\]\)=:<>;]$/ && $0 !~ /[\.:;()\[\],]/) ? " " : ""
}

/^\(/   { ++paren }
/^\)/   { --paren }

/^(if|while|for|return|switch|case|default|union|struct|typedef|#)/   { newline() }

/^for$/		    { newline(); infor=1 }
infor && /^;/	    { ++infor; show($0 " "); next }
infor==1 && /^:/    { ++infor }
infor>1 && paren==0 { infor=0 }

/^\?/		{ ++tern; ++n; newline(); show($0 " "); next }
tern && /^:/	{ newline(); show($0); --tern; --n; next }

/^#/	{ newline(); show($0); newline(); next }
/^;/	{ show($0); newline(); next }
/^{/	{ show($0); ++n; newline(); next }
/^}/	{ --n; newline(); show($0); newline(); next }

{ show($0) }
'

pp $* | $PROG -t | ./tokenfix | awk "$script" # sed 's/""//g'
