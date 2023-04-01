#!/bin/sh

function usage {
	cat <<'EoT'
NAME
  manpage - format an ascii text file into man page format

SYNOPSIS
  manpage [-PR] [-d pdate] [-r rel] [-v vol] [-s sect] [-t title]
	[-w ncols] [filename]

DESCRIPTION
  manpage converts its input into the man(7) macros as used by man(1),
  but without the user needed to understand any formatting syntax.
  It is designed to process a flat ascii file that roughly appears in the format
  desired, adding the specific flourishes that distinguish a readable man page:

  - font changes for names and arguments throughout the document
  - automatic recognition of command, C, C++, and Java names, types and arguments
  - automatic recognition of paragraphs, list formats, sections, and non-formatted displays
  - constant width fonts for code and displays
  - cross-references highlighted
  - pass-through of nroff formatting commands

  The input resembles the man page to be formatted, with just a few rules of presentation:
     Sections   ~
     	Section names are input lines in all upper case.  If a section name begins
	with spaces, it starts a subsection.
     Paragraphs   ~
	A blank line between text marks a paragraph.  All text in the same
	paragraph must be left-aligned relative to itself.
     Line Breaks    ~
        A twiddle (~) at the end of a line is consumed and replaced
	with a line break.  This is especially useful in tag lists (this section).
     Displays   ~
	These are sections not to be formatted further.  They are introduced
	by a preceding blank line and indented relative to the surrounding text.
	Displays are output in constant width font, and all code escapes may
	be presented naturally:

		printf("Hello, World\n");

     Tag Lists   ~
	The tag is identified by three (3) or more spaces between itself
	and its description.  These rules are tag lists.  Note especially
	the trailing spaces on the tags in this section.
     Bullet Lists    ~
	These are identified by a leading dash (-), dot (.), or star (*).
     Numbered Lists    ~
	These begin with a number and a dot; e.g. "3. Number three".
     Cross References   ~
	This is a word followed by a number in parenthesis; e.g. man(1).
     Bold / Italic    ~
	A word surrounded by underscores (_) is rendered in _italic_;
	and by stars (*) is rendered as *boldface*.

  There are two sections handled specially:
     NAME   
	This is the name of the command or function, followed by a terse,
	one-line summary of its primary use.
     SYNOPSIS   
	This section is scanned for names, arguments, and flags.  Names found
	in this area are remembered, and each occurance throughout the document
	are presented in bold.  Arguments are similarly detected and remembered,
	and presented in italics.  Other text in this area is presented in
	a constant width font.

OPTIONS
  -d pdate   set the man page date
  -r rel     set the release name
  -v vol     set the volume name
  -s sect    set the section name
  -t title   set the man page title
  -w ncols   force the output to be ncols wide
  -P         PostScript output
  -R         roff output

EXAMPLES
  This usage is in the proper format for manpage.  Try:

	manpage -h | manpage -tmanpage -s1

  To view the nroff(1) formatted page, perhaps for inclusion in the system man pages:

	manpage -h | manpage -tmanpage -s1 -R > manpage.1

ENVIRONMENT
  PAGER     defaults to less(1); used if neither -P nor -R is specified as arguments
  MANPATH   input .man files searched in current dir, then HOME/man, then MANPATH
  ORG       name of organization (e.g. $ORG Reference Manual)

SEE ALSO
  man(1), man(7), groff(1), less(1), txt2man(1)

PORTABILITY
  This program uses generic bourne shell and awk syntax, POSIX compatible systems should work.

BUGS
  Code displays that span page breaks do not restore the troff(1) escape
  during header / footer processing.

AUTHOR
  Dave Burton <ioccc@snox.net>

  manpage(1) input format is inspired by txt2man(1) by Marc Vertes <mvertes@free.fr>,
  although the code is a clean redesign from first principles.
EoT
}

function getwidth {
	echo $(stty -a 2>/dev/null) |
	if test $(uname) == "Darwin"; then
		awk '/columns/{for(i=1;i<=NF;++i)if($i~/columns/)print$(i-1)+0}'
	else
		awk '/columns/{for(i=1;i<=NF;++i)if($i~/columns/)print$(i+1)+0}'
	fi
}

function scan {
	for dir in . $HOME/man $(echo $MANPATH | tr : '\n'); do
		test -r $dir/$1 && { echo $dir/$1; break; }
	done
}

function searchfor {
	# examine the current dir for name, name.man, or scan a searchpath for name.man
	test "$1" || { echo ""; return; }
	filename=$1
	if ! test -r $filename || test -x $filename; then
		expr "$filename" : .*.man >/dev/null 2>&1 || filename=$filename.man
		result=$(scan $filename)
		if ! test "$result"; then
			echo cannot find $filename in curdir, $HOME/man or MANPATH >&2
			exit 1
		fi
		filename=$result
	fi
	echo $filename
}

width=0
sys=($uname -s)
date= rel= vol= sect= title=
post=

args="?hPRd:r:v:s:t:w:"
while getopts $args opt
do
    case $opt in
    d) date=$OPTARG;;
    r) rel=$OPTARG;;
    v) vol=$OPTARG;;
    s) sect=$OPTARG;;
    t) title=$OPTARG;;
    w) width=$OPTARG;;
    P) post="groff -man -Tps";;
    R) post=cat;;
    \?) echo "usage: $0 [-$args] [filename]" >&2; exit 1;;
    h|*) usage; exit 1;;
    esac
done
shift $((OPTIND-1))

date=${date:-$(date +'%d %B %Y')}

# format and display the page now
if test $width -eq 0 -a ! "$post" ; then
    width=$(getwidth)
fi

# -is for pre-el-capitan
: ${post:="groff -man -Tascii | ${PAGER:-less -R}"}

# seek for it, perhaps without the .man extension
filename=$(searchfor $1) || exit; shift;
# echo $filename; exit

# intuit the title, section and volume from the input file
if ! test "$title" && test "$filename"; then
    title=${filename##*/}; title=${title%.man}
    title=$(echo $title | tr a-z A-Z)
    if sed '/DESCRIPTION/q' $filename | egrep -q "#include|.import"; then
	sect=${sect:-3}
	vol=${vol:-"$ORG Programmer's Manual"}
    else
	sect=${sect:-1}
	vol=${vol:-"$ORG Reference Manual"}
    fi
fi

# --------------------------------------------------
# the formatting engine

expand $filename |
awk -v width=$width -v th="$title $sect \"$date\" \"$rel\" \"$vol\"" '
BEGIN {
	if (width+0 > 0) {
		# adjust output to a specific width; useful as man(1) replacement
		cpi = (width+0)/11
		print ".ll " cpi "i"
		print ".nr LL " cpi "i"
	}
	print ".TH", th
	print ".if n .na\n.if n .nh"
	block = 0	# depth of the block display
	list = 0	# depth of the list indent
	indent = 0	# current RS indent level
	rs[indent] = 0	# array of starting indents
	lw = 0		# leading whitespace
	blank = 0	# NR of last blank line
}

function bold(w)   { return "\\fB" w "\\fP" }
function italic(w) { return "\\fI" w "\\fP" }

function before(s) { return substr(s, 1, RSTART-1) }
function after(s)  { return substr(s, RSTART+RLENGTH) }

function add(t, r) {
	gsub(/\./, "\\.", t)
	pattern[t] = r
}

# replace logic is W*P, but both W (words) and P (patterns) are small,
# and this is the only way to portably, reliably detect substitutable patterns
# within the larger text
#
function replace(dummy,   i,count,other,pat,re) {
	other  = "[^-_A-Za-z0-9]+"
	for (i=1; i<=NF; ++i) {
		count = 0
		for (pat in pattern) {
			# re = "^" pat "$|^" other pat "$|^" pat other "$|^" other pat other "$"
			re = "^" pat "$|" other pat "$|^" pat other "|" other pat other
			if ($i ~ re) {
				count = sub(pat, pattern[pat], $i)
				break;
			}
		}

		# one-time, in place bold, italic, and cross-ref
		if (section != "SYNOPSIS" && count == 0) {
		    # match foo(1) or foo(1pkg) not foo(1 2) or foo(1, 2) or foo(int)
		    # but not in a see also section
		    if ((section != "SEE") &&	# aka SEE ALSO
		       ($i ~ /[_A-Za-z0-9]+\([0-9][A-Za-z0-9]*\)/)) {
			a = index($i, "(")
			$i = bold(substr($i, 1, a-1)) substr($i, a)
		    }
		    else if (match($i, "[A-Za-z]_.*_[A-Za-z]"))
			;
		    else if (match($i, "_.*_"))
			$i = before($i) italic(substr($i, RSTART+1, RLENGTH-2)) after($i)
		    else if (match($i, "\\*.*\\*"))
			$i = before($i) bold(substr($i, RSTART+1, RLENGTH-2)) after($i)
		}
	}
	if ($NF == "~") {
		$NF = ""
		return 1
	}
	return 0
}

function paragraph() {
	print ".PP"
	list = lw			# reset list on a paragraph
	tplen = ""
}

function restore() {
	if (blank == NR-1)		# restore the blank line to the display
		print ""
	n = lw - block
	if (n==0) n=1			# avoid eating leading dots in displays
	printf "%*s", n, " "		# restore leading spaces in displays
}

function block_start() {
	block = lw
	blank = 0
	paragraph()
	print ".RS " block
	print ".eo\n.nf\n.fam C"
}

function block_end() {
	if (block > 0) {
		block = 0
		print ".ec\n.fi\n.fam T"
		print ".RE"
	}
}

function reset_indent() {
	rs[0] = indent = 0
}

# pass through nroff formatting commands
/^\..+/ {
	print $0
	next
}

# remember leading whitespace, strip blank lines
{
	lw = match($0, /[^ ]/)
	if (lw == 0) {
		blank = NR
		next
	} else {
		$0 = substr($0, lw)
		# sub(/^  */, "")
		# sub(/  *$/, "")	# prevents TP match if desc on next line
	}
	--lw
	if (rs[indent] == 0)
		rs[indent] = lw
}

# new section (must end with a cap letter to avoid tag list match)
/^[A-Z ]+[A-Z]$/ {
	if (section == "SYNOPSIS")
		print ".fi"
	block_end()
	reset_indent()
	list = 0
	tplen = ""
	section = $1
	print (lw>0) ? ".SS" : ".SH", $0
	if (section == "SYNOPSIS") {
		print ".nf"
		print ".fam C"
	}
	if (section == "SEE")
		print ".nf"
	next
}

section == "NAME" && name == "" && $1 != "" {
	name = $1
	# add(name, bold(name))
	sub(/ - /, " \\- ")
}

section == "SYNOPSIS" {
	if (format == "") {
		block = lw	# this is a pseudo-block; see new section
		if ($0 ~ /\(/)				   format = "code"
		else if ($1 == "struct" || $2 == "struct") format = "struct"
		else if ($1 == "union"  || $2 == "union")  format = "struct"
		else if ($1 == "class"  || $2 == "class")  format = "class"
		else if ($1 !~ /#|import|typedef|enum/)    format = "cmd"
	}
	if (format == "cmd") {
		# cmd [-a N] [-b N] [-m ab] [-p S]
		#     [-r] [-qst] @interface ip:port [filename ...]
		i = 1
		if ($1 !~ /^\[/) {
			++i
			a = $1
			gsub("-", "\\-", a)
			add(a, bold(a))
		}
		for (; i<=NF; ++i) {
			a = $i
			gsub(/[\[\]]/, "", a)	# remove all brackets
			if (a == "-")           ;
			else if (a ~ /^-./)     add(a, bold("\\" a))
			else if (a !~ /\.\.\./) add(a, italic(a))
		}
	} else if (format == "code") {
		# void foo()
		# void foo(int);
		# void foo(int a);
		# void foo(int a, char *b);
		# void *foo(char **b, int *a, ...)
		# void (*signal(int sig, void (*func)(int)))(int);
		# ssize_t readv(int d, const struct iovec *iov, int iovcnt);
		if ($1 != "typedef")
		    for (i = 1; i<=NF; ++i) {
			a = $i
			gsub("[\\*]", "", a)	# dont want to mess with pointers
			if (match(a, "[A-Za-z0-9_]+\\(")) {
				a = substr(a, RSTART, RLENGTH-1)
				add(a, bold(a))
			} else if (match(a, "[A-Za-z0-9_]+[,\\)]")) {
				a = substr(a, RSTART, RLENGTH-1)
				add(a, italic(a))
			}
		}
	} else if (format == "struct") {
		if (match($0, "[A-Za-z0-9_]+[ ]*{")) {
			a = substr($0, RSTART)
			sub("[ ]*{", "", a);
			add(a, bold(a));
		}
		format = "code"
	} else if (format == "class") {
		# public class Foo extends Bar implements Snox, Blah, Nuts {
		# so remove from extends or implements, play as if C++
		a = $0
		if (match(a, "extends|implements"))
			a = substr(a, 1, RSTART-1)
		if (match(a, "[A-Za-z0-9_]+[ ]*{")) {
			a = substr(a, RSTART)
			sub("[ ]*{", "", a);
			add(a, bold(a));
			format = "code"
		}
	}
	replace()
}

block == 0 {
	if (lw > rs[indent]+2) {
		if (blank == NR-1)
			block_start()
		else if (lw > list) {
			# XXX list?
			rs[++indent] = lw;
			print ".RS"
		}
	} else while (lw < rs[indent]) {
		print ".RE"
		--indent
		list = 0
		tplen = ""
	}
}

block > 0 {
	if (lw < block)
		block_end()
	else {
		restore()
		print $0
		next
	}
}

{
	# if replace before matching, awk collapses multiple spaces into one....
	if (match($0, /[^ ]   +/)) {		# tag description
		list = lw + RSTART + RLENGTH
		tag = substr($0, 1, RSTART)
		def = substr($0, RSTART + RLENGTH)
		$0 = tag
		if (tplen == "" && def !~ /[.~]/)
			tplen = list-3
		replace()
		print ".TP " tplen "\n" bold($0)
		$0 = def

	} else if (match($0, /^[o\.\*+] +/)) {	# bullet list
		list = lw + RSTART + RLENGTH
		print ".IP \\(bu 3"
		$0 = substr($0, RLENGTH+1)

	} else if (match($0, /^- +/)) {		# dash list
		list = lw + RSTART + RLENGTH
		print ".IP \\(em 3"
		$0 = substr($0, RLENGTH+1)

	} else if (match($0, /^[0-9]+\. +/)) {	# number list
		list = lw + RSTART + RLENGTH
		print ".IP " $1 " 3"
		$0 = substr($0, RLENGTH+1)

	} else {
		# the lists above supply their own vertical separation
		if (blank == NR-1)
			paragraph()
	}

	# if there is anything left to print...
	if (length $0 > 0) {
		br = replace();
		if (length $0 > 0)
			print $0
		if (br) print ".br"
	}
}
' | eval $post
