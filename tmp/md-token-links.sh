#!/usr/bin/env bash
#
# md--token-links.sh - print all markdown links that start with a **%%TOKEN%%**
#
# Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

# firewall - run only with a bash that is version 5.1.8 or later
#
# The "/usr/bin/env bash" command must result in using a bash that
# is version 5.1.8 or later.
#
# We could relax this version and insist on version 4.2 or later.  Versions
# of bash between 4.2 and 5.1.7 might work.  However, to be safe, we will require
# bash version 5.1.8 or later.
#
# WHY 5.1.8 and not 4.2?  This safely is done because macOS Homebrew bash we
# often use is "version 5.2.26(1)-release" or later, and the RHEL Linux bash we
# use often use is "version 5.1.8(1)-release" or later.  These versions are what
# we initially tested.  We recommend you either upgrade bash or install a newer
# version of bash and adjust your $PATH so that "/usr/bin/env bash" finds a bash
# that is version 5.1.8 or later.
#
# NOTE: The macOS shipped, as of 2024 March 15, a version of bash is something like
#	bash "version 3.2.57(1)-release".  That macOS shipped version of bash
#	will NOT work.  For users of macOS we recommend you install Homebrew,
#	(see https://brew.sh), and then run "brew install bash" which will
#	typically install it into /opt/homebrew/bin/bash, and then arrange your $PATH
#	so that "/usr/bin/env bash" finds "/opt/homebrew/bin" (or whatever the
#	Homebrew bash is).
#
# NOTE: And while MacPorts might work, we noticed a number of subtle differences
#	with some of their ported tools to suggest you might be better off
#	with installing Homebrew (see https://brew.sh).  No disrespect is intended
#	to the MacPorts team as they do a commendable job.  Nevertheless we ran
#	into enough differences with MacPorts environments to suggest you
#	might find a better experience with this tool under Homebrew instead.
#
if [[ -z ${BASH_VERSINFO[0]} ||
	 ${BASH_VERSINFO[0]} -lt 5 ||
	 ${BASH_VERSINFO[0]} -eq 5 && ${BASH_VERSINFO[1]} -lt 1 ||
	 ${BASH_VERSINFO[0]} -eq 5 && ${BASH_VERSINFO[1]} -eq 1 && ${BASH_VERSINFO[2]} -lt 8 ]]; then
    echo "$0: ERROR: bash version needs to be >= 5.1.8: $BASH_VERSION" 1>&2
    echo "$0: Warning: bash version >= 4.2 might work but 5.1.8 was the minimum we tested" 1>&2
    echo "$0: Notice: For macOS users: install Homebrew (see https://brew.sh), then run" \
	 ""brew install bash" and then modify your \$PATH so that \"#!/usr/bin/env bash\"" \
	 "finds the Homebrew installed (usually /opt/homebrew/bin/bash) version of bash" 1>&2
    exit 4
fi


# setup bash file matching
#
# We must declare arrays with -ag or -Ag, and we need loops to "export" modified variables.
# This requires a bash with a version 4.2 or later.  See the larger comment above about bash versions.
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories

# set variables referenced in the usage message
#
export VERSION="1.0 2024-04-25"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd:nN flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    d) TOPDIR="$OPTARG"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	print_usage 1>&2
	exit 3
	;;
    :) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
  esac
done

# remove the options
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
#
# verify arg count and parse args
#
export TOOL
case "$#" in
0) ;;
*) echo "$0: ERROR: expected 0 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac

# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
fi


# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 6
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 6
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi


# collect markdown links with a path that starts with a %%TOKEN%%
#
#	Here be extended regular expression magic dragons! :-)
#
# We will try to explain, as best as we can, these complex regular expressions.
#
# After grep of markdown files (files in sorted dictionary order) for (%%TOKEN%%) lines, we sed:
#
#	# remove any "[some string]" that is not immediately followed by "("
#
#	-e 's/\[[^]]*\]([^(])/\1/' \
#
#	# remove any trialing "[followed by text without a closing bracket"
#
#	-e 's/\[[^]]*$//' \
#
# Then processing the second file (after the filename field) we sed:
#
#	# remove any leading "..non-[-stuff..["
#
#	    -e 's/^[^[]()+\[/[/' \
#
#	# replace "beginning text stuff](" with "[text stuff]("
#	#     because the previous line might have ended with "[beginning"
#
#	    -e 's/^([^][]*\]\()/[\1/g' \
#
#	# remove any "[..non-]-stuff..][..more-non-]-stuff..]"
#
#	    -e 's/(\[[^][]*\])+([^(])/\2/g' \
#
#	# remove any non-link before the first "[some string](path)"
#
#	    -e 's/^[^][]+(\[[^]]*\]\([^(]*\))/\1/' \
#
#	# remove any final "[..non-]-stuff..$"
#
#	    -e 's/\[[^]]*$//' \
#
#	# remove any final "(..non-)-stuff..)..non-[-stuff.."
#
#	    -e 's/(\([^)]*\))[^[]*$/\1/' \
#
#	# remove any trailing non-[-text after the final "[some string](%%TOKEN%%path)"
#
#	    -e 's/(\[[^]]*\]\([^(]*\))[^[]+$/\1/' \
#
#	# replace ")..non-open-bracket-stuff.["  with ") ["
#
#	    -e 's/\)[^[]*\[/) [/g' \
#
#	# replace "[some string](apath) [other string](bpath)" with two lines:
#	#
#	#	"[some string](apath)"
#	#	"[other string](bpath)"
#
#	    -e 's/(\[[^]]*\]\([^(]*\))/\1\n/g' \
#
#	# remove blank and empty lines
#
#	    -e '/^\s*$/d' \
#
# Then pipe the lines into another sed:
#
#	# replace multiple space with a single space
#
#	    -e 's/  +/ /g' \
#
#	# remove blank and empty lines
#
#	    -e '/^\s*$/d' \
#
#	# prepend the markdown path (without the leading "./") followed by space to each line
#
#	    -e "s;^;$MD_PATH ;" \
#
#	# replace multiple space with a single space
#
#	    -e 's/  +/ /g'
#
# Output are lines of the form:
#
#	markdown_path.md [pseudo title](%%TOKEN%%path)
#
# We do not process markdown.md because it contains examples
# of poor markdown use.
#
find . -name '*.md' ! -name markdown.md ! -path './tmp/*' -print |
    LANG=C sort -d |
    xargs grep '\](%%[A-Za-z][0-9A-Za-z_]*%%[^)]*)' /dev/null |
    sed -E \
	-e 's;^\.\/;;' \
	-e 's/^([^:]+):\s*/\1 /' \
	|
    while read -r MD_PATH MD_LINE; do
	echo "$MD_LINE" |
	sed -E \
	    -e 's/^[^[]()+\[/[/' \
	    -e 's/^([^][]*\]\()/[\1/g' \
	    -e 's/(\[[^][]*\])+([^(])/\2/g' \
	    -e 's/^[^][]+(\[[^]]*\]\([^(]*\))/\1/' \
	    -e 's/\[[^]]*$//' \
	    -e 's/(\([^)]*\))[^[]*$/\1/' \
	    -e 's/(\[[^]]*\]\([^(]*\))[^[]+$/\1/' \
	    -e 's/\)[^[]*\[/) [/g' \
	    -e 's/(\[[^]]*\]\([^(]*\))/\1\n/g' \
	    -e '/^\s*$/d' \
	    |
	sed -E \
	    -e 's/  +/ /g' \
	    -e '/^\s*$/d' \
	    -e "s;^;${MD_PATH} ;" \
	    -e 's/  +/ /g'
     done

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
