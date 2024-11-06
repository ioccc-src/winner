#!/usr/bin/env bash

#
# md2html.sh - convert markdown into an IOCCC HTML file via config file
#
# This script was written in 2024 by:
#
#   chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# with important improvements by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# "Because sometimes even the IOCCC Judges need some help." :-)
#
# Convert a markdown file into a HTML file for the IOCCC website,
# using the bin/md2html.cfg configuration file.  Conversion from
# markdown to HTML is performed via the 'pandoc wrapper tool'.
#
# For general information on how IOCCC HTML files are generated, see:
#
#	https://www.ioccc.org/bin/index.html#how
#
####
#
# The command line processing of this tool is rather complex.
# Command line processing occurs in 4 phases called "getopt phases".
#
# In getopt phase 0 we parse command line options and save all arguments for the end of the final command line.
#
# In getopt phase 1 we execute each -o "output tool" from getopt phase 0, parsing the output as a command line.
#
# In getopt phase 2 we parse the "cfg_options" from the first "md2html.cfg" line matched by saved argument.
#
# In getopt phase 3 we execute each -o "output tool" from getopt phase 2, parsing the output as a command line.
#
# Because of these 4 "getopt phases", command line parsing is performed by the "parse_command_line"
# shell function.
#
# For more information on "getopt phases", RTFS :-) or see:
#
#	https://www.ioccc.org/bin/index.html#getopt
#
####
#
# After all "getopt phases" are completed, HTML content is performed in phases called "HTML phases".
#
# HTML phases 0 thru 19 are used to generate the "top" of the HTML file.
#
# NOTE: HTML phases 11-19 are reserved for future use.
#
# HTML phase 20 may be used by a "before tool" to generate content just above markdown generated content.
#
# HTML phase 21 is when the "pandoc wrapper tool" is used to convert markdown into HTML.
#
# HTML phase 22 may be used by an "after tool" to generate content just below markdown generated content.
#
# NOTE: HTML phases 23-29 are reserved for future use.
#
# HTML phases 30 thru 39 are used to generate the "bottom" of the HTML file.
#
# NOTE: HTML phases 35-39 are reserved for future use.
#
# For more information on "HTML phases", RTFS :-) or see:
#
#	https://www.ioccc.org/bin/index.html#html
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


# other required bash options
#
# Requires bash with a version 4.2 or later
#
shopt -s lastpipe	# run last command of a pipeline not executed in the background in the current shell environment


# set variables referenced in the usage message
#
export VERSION="1.7 2024-09-27"
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
PERL_TOOL=$(type -P perl)
export PERL_TOOL
if [[ -z "$PERL_TOOL" ]]; then
    echo "$0: FATAL: perl tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
export TOPDIR
export DOCROOT_SLASH="./"
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
export URL="#"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
	[-c md2html.cfg] [-H phase=name ..] [-t tagline]
	[-b tool] [-a tool]
	[-s token=value ..] [-S] [-o tool ..]
	[-U url] [-w site_url] [-m mdtag] [-e string ..] [-E exitcode]
	[match.md] input.md output.html

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
			NOTE: -d may only be used in command_options (getopt phase 0)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: The '-D docroot/' is passed as leading options on -b tool, -a tool, and -o tool command lines.
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-c md2html.cfg	Use md2html.cfg as the configuration file (def: use topdir/bin/md2html.cfg)
			NOTE: -c may only be used in command_options (getopt phase 0)

	-H phase=name	use 'phase.name.html' file for HTML phase named 'phase' (def: use 'phase.default.html')
	-H phase=.	ignore processing for HTML phase 'phase' (def: process HTML phase)
			NOTE: The 'phase' string may not contain an = (equal), a / (slash), a single-quote, or a double-quote.
			NOTE: The 'name' string may not contain an = (equal), a single-quote, or a double-quote.
			NOTE: The 'phase.name.html' file is assumed to be under the 'topdir/inc' directory.

	-t tagline	string to write about the tool that formed the markdown content (def: unspecified)
			NOTE: 'tagline' may be enclosed within, but may NOT contain an internal single-quote, or double-quote.

	-b tool		run 'before tool' during HTML phase number 20 (def: do not output before pandoc wrapper tool)
	-b .		skip HTML phase number 20 (def: do nothing during HTML phase number 20)

	-a tool		run 'after tool' during HTML phase number 20 (def: do not output after pandoc wrapper tool)
	-a .		skip HTML phase number 22 (def: do nothing during HTML phase number 22)

	-s token=value	substitute %%token%% with value except in HTML phase numbers 20-29 (def: do not substitute any tokens)
			NOTE: A later '-s token=value' will override an earlier '-s token=value' for the same 'token'.
			NOTE: Multiple '-s token=value' are cumulative for the unique set of 'token's.
	-S		Failure to replace a %%token%% is not an error (def: exit non-zero for non-substituted tokens)

	-o tool		use 'output tool' to generate option lines (def: do not)
	-o .		disable use of 'output tool' (def: do not use an 'output tool')
			NOTE: -o may only be used in command_options and md2html.cfg cfg_options (getopt phases 0 and 2)

	-U url		URL of HTML being formed (def: $URL)
			NOTE: The '-U url' is passed as leading options on -b tool, -a tool, and -o tool command lines.
	-w site_url	Base URL of the website (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on -b tool, -a tool, and -o tool command lines.
	-m mdtag	string to write about the markdown file used to form HTML content (def: no markdown file is used)

	-e string	output 'string', followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	[match.md]	use 'match.md' (canonical path from topdir) to match an entry in md2html.cfg (def: use input.md)
			NOTE: match.md cannot be -
	input.md	input markdown path from topdir, - ==> read from stdin
			NOTE: If input.md is -, then 'match.md' must be given.
	output.html	HTML output path from topdir, - ==> write to stdout

Exit codes:
     0	       all OK
     2	       -h and help string printed or -V and version string printed
     3	       command line error
     4	       bash version is too old
     5	       some internal tool is not found or not an executable file
     6         problems found with or in the topdir or topdir/YYYY directory
     7         problems found with or in the entry topdir/YYYY/dir directory
     8	       HTML phase file not found or not readable
 >= 10  < 39   internal error
 >= 40  < 200  HTML phase error
 >= 200	       error generated via -e exit_code, or via bin/md2html.cfg, or awk script error

$NAME version: $VERSION"


##################################
# command line parsing functions #
##################################


# global_variable_setup - setup global variables
#
# Call this once at the start of the shell script.
#
function global_variable_setup
{
    local n	# loop index

    # setup
    #
    # VERSION set above the export USAGE line
    # NAME set above the export USAGE line
    # V_FLAG set above the export USAGE line
    export NOOP=
    export DO_NOT_PROCESS=
    export TOPDIR=
    # REPO_TOP_URL set above the export USAGE line
    # REPO_URL set above the export USAGE line
    export MD2HTML_CFG=
    export BEFORE_TOOL=
    # DOCROOT_SLASH set above the export USAGE line
    # PANDOC_WRAPPER set above the export USAGE line
    # REPO_TOP_URL set above the export USAGE line
    # REPO_URL set above the export USAGE line
    # SITE_URL set above the export USAGE line
    export P_FLAG_FOUND=
    export CAP_P_FLAG_FOUND=
    # REPO_TOP_URL set above the export USAGE line
    # REPO_URL set above the export USAGE line
    export U_FLAG_FOUND=
    # URL set above the export USAGE line
    export CAP_U_FLAG_FOUND=
    export AFTER_TOOL=
    unset TOKEN
    declare -Ag TOKEN
    export CAP_S_FLAG=
    unset OUTPUT_TOOL
    declare -ag OUTPUT_TOOL
    export TAGLINE="unspecified"
    export MDTAG=
    export MATCH_MD=
    export INPUT_MD=
    export OUTPUT_HTML=

    # options we will add to before, pandoc wrapper, after, and output tools
    #
    # NOTE: The O_OPTION used for when an output tool is executed.
    #	    The options produced by the output tool does into OUTPUT_TOOL_OPTIONS
    #	    which is a different array.
    #
    unset B_OPTION
    declare -ag B_OPTION
    unset P_OPTION
    declare -ag P_OPTION
    unset A_OPTION
    declare -ag A_OPTION
    unset O_OPTION
    declare -ag O_OPTION

    # determine path to topdir if we are in a git repo
    #
    GIT_TOOL=$(type -P git)
    export GIT_TOOL
    if [[ -z "$GIT_TOOL" ]]; then
       echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
       exit 5
    fi
    "$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
    status="$?"
    if [[ $status -eq 0 ]]; then
       TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
    fi

    # setup phase names in phase array
    #
    unset PHASE_NAME
    declare -ag PHASE_NAME
    PHASE_NAME=(top head body topbar header navbar before-content
		after-content footer bottom)
    unset HTML_PHASE_NAME
    declare -Ag HTML_PHASE_NAME
    for n in "${PHASE_NAME[@]}"; do
	HTML_PHASE_NAME[$n]="default"
    done

    # initialize command line parse pass number
    #
    export GETOPT_PHASE=0
    return 0
}


# parse_command_line - parse command line arguments
#
# You MUST call this function at least once AND after calling global_variable_setup.
# You may call this function again, after setting a new command line args. For example:
#
#	global_variable_setup	# must be first
#	parse_command_line	# parse the command line given to the shell script
#
#	# collect and parse command line arguments
#	ARG="$1"		# for example, grab only the first command line argument
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
#	# set new command like options and parse them
#	set -- -s token0=value0 -o bin/foo.sh -O bin/foo.sh="-v 3" -s token1=vaulue1
#	parse_command_line
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
#	# set new command like options and parse them
#	set -- -s token2=value2 -o bin/bar.sh -O bin/bar.sh="-v 1" -s token4=vaulue4
#	parse_command_line
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
function parse_command_line
{
    local flag		# getopts found flag
    local NAME		# name from name=value
    local VALUE		# value from name=value

    # setup that will effectively clear any previous getopts state
    #
    unset OPTIND

    # parse command line
    #
    while getopts :hv:VnNd:D:c:H:t:m:b:a:s:So:U:w:e:E: flag; do
      case "$flag" in
	h) echo "$USAGE" 1>&2
	    exit 2
	    ;;
	v) V_FLAG="$OPTARG"
	    ;;
	V) echo "$VERSION"
	    exit 2
	    ;;
	n) NOOP="-n"
	    ;;
	N) DO_NOT_PROCESS="-N"
	    ;;
	d) # -d only in getopt phase 0
	    if [[ $GETOPT_PHASE -ne 0 ]]; then
		echo "$0: ERROR: -d may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
	    fi
	    #
	    TOPDIR="$OPTARG"
	    ;;
	D) # parse -D docroot/
	    case "$OPTARG" in
	    */) ;;
	    *) echo "$0: ERROR: in -D docroot/, the docroot must end in /" 1>&2
	       echo 1>&2
	       echo "$USAGE" 1>&2
	       exit 3
	       ;;
	    esac
	    DOCROOT_SLASH="$OPTARG"
	    B_OPTION+=("-D")
	    B_OPTION+=("$DOCROOT_SLASH")
	    A_OPTION+=("-D")
	    A_OPTION+=("$DOCROOT_SLASH")
	    O_OPTION+=("-D")
	    O_OPTION+=("$DOCROOT_SLASH")
	;;
	c) # -c only in getopt phase 0
	    if [[ $GETOPT_PHASE -ne 0 ]]; then
		echo "$0: ERROR: -c may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
	    fi
	    #
	    MD2HTML_CFG="$OPTARG"
	    ;;
	H) # parse: -H phase=name
	    case "$OPTARG" in
	    *=*) # parse name=value
		NAME=${OPTARG%%=*}
		VALUE=${OPTARG#*=}
		;;
	    *) echo "$0: ERROR: -H phase=name not in -H phase=name form" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    esac
	    #
	    case "$NAME" in
	    *=*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain an = (equal) character: $NAME" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    */*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a / (slash) character: $NAME" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a single-quote character: $NAME" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a double-quote character: $NAME" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    case "$VALUE" in
	    *=*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a = (equal) character: $VALUE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a single-quote character: $VALUE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a double-quote character: $VALUE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    # name must be a known phase name
	    #
	    if [[ -z ${HTML_PHASE_NAME[$NAME]} ]]; then
		echo "$0: ERROR: -H name=value, name is unknown" 1>&2
		echo "$0: notice: list of valid start below" 1>&2
		for n in "${PHASE_NAME[@]}"; do
		    echo "$0: notice: valid name: $n"
		done 1>&2
		echo "$0: notice: list of valid end above" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
	    fi
	    # change phase name
	    HTML_PHASE_NAME[$NAME]="$VALUE"
	    ;;
	t) TAGLINE="$OPTARG"
	    ;;
	m) MDTAG="$OPTARG"
	    ;;
	b) # parse: -b tool
	    if [[ $OPTARG == . ]]; then
		# unset before tool
		BEFORE_TOOL=
	    else
		# change before tool
		BEFORE_TOOL="$OPTARG"
	    fi
	    ;;
	a) # parse: -a tool
	    if [[ $OPTARG == . ]]; then
		# unset after tool
		AFTER_TOOL=
	    else
		# change after tool
		AFTER_TOOL="$OPTARG"
	    fi
	    ;;
	s) # parse: -s token=value
	    case "$OPTARG" in
	    *=*) # parse name=value
		NAME=${OPTARG%%=*}
		VALUE=${OPTARG#*=}
		;;
	    *) echo "$0: ERROR: -s token=value not in -s token=value form" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
		;;
	    esac
	    #

	    # set %%token%% value
	    #
	    TOKEN[$NAME]="$VALUE"
	    ;;
	S) CAP_S_FLAG="-S"
	    ;;
	o) # -o only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -ne 0 && $GETOPT_PHASE -ne 2 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 2, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		echo "$USAGE" 1>&2
		exit 3
	    fi
	    #
	    OUTPUT_TOOL+=("$OPTARG")
	    ;;
	U) URL="$OPTARG"
	    B_OPTION+=("-U")
	    B_OPTION+=("$URL")
	    A_OPTION+=("-U")
	    A_OPTION+=("$URL")
	    O_OPTION+=("-U")
	    O_OPTION+=("$URL")
	    ;;
	w) SITE_URL="$OPTARG"
	    B_OPTION+=("-w")
	    B_OPTION+=("$SITE_URL")
	    A_OPTION+=("-w")
	    A_OPTION+=("$SITE_URL")
	    O_OPTION+=("-w")
	    O_OPTION+=("$SITE_URL")
	    ;;
	e) echo "$OPTARG" 1>&2
	    ;;
	E) exit "$OPTARG"
	    ;;
	\?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	    echo 1>&2
	    echo "$USAGE" 1>&2
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
    return 0
}


# debug_parameters - if verbose enough, print parameters
#
# usage:
#	debug_parameters debug_level dbg_prefix
#
#	debug_level	the minimum debug level needed to print messages
#	dbg_prefix	what to print after the debug[debug_level]: and before a ":"
#
function debug_parameters
{
    local DEBUG_LEVEL		# minimum debug level needed to print messages
    local DBG_PREFIX		# what to print after the debug[debug_level]: and before a ":"
    local index			# index :-)

    # parse args
    #
    if [[ $# -ne 2 ]]; then
	echo "$0: ERROR: debug_parameters requires 2 args, found: $#" 1>&2
	exit 10
    fi
    DEBUG_LEVEL="$1"
    DBG_PREFIX="$2"

    # return if debug level is too low
    #
    if [[ $V_FLAG -lt $DEBUG_LEVEL ]]; then
	return 0
    fi

    # print values that could be modified by parse_command_line
    #
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: VERSION=$VERSION" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: NAME=$NAME" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: PERL_TOOL=$PERL_TOOL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: URL=$URL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: NOOP=$NOOP" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: MD2HTML_CFG=$MD2HTML_CFG" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: BEFORE_TOOL=$BEFORE_TOOL" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: P_FLAG_FOUND=$P_FLAG_FOUND" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: CAP_P_FLAG_FOUND=$CAP_P_FLAG_FOUND" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: U_FLAG_FOUND=$U_FLAG_FOUND" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: CAP_U_FLAG_FOUND=$CAP_U_FLAG_FOUND" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: AFTER_TOOL=$AFTER_TOOL" 1>&2
    for index in "${!TOKEN[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: TOKEN[$index]=${TOKEN[$index]}" 1>&2
    done
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: CAP_S_FLAG=$CAP_S_FLAG" 1>&2
    for index in "${!OUTPUT_TOOL[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: OUTPUT_TOOL[$index]=${OUTPUT_TOOL[$index]}" 1>&2
    done
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: TAGLINE=$TAGLINE" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: MDTAG=$MDTAG" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: MATCH_MD=$MATCH_MD" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: INPUT_MD=$INPUT_MD" 1>&2
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: OUTPUT_HTML=$OUTPUT_HTML" 1>&2
    for index in "${!B_OPTION[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: B_OPTION[$index]=${B_OPTION[$index]}" 1>&2
    done
    for index in "${!P_OPTION[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: P_OPTION[$index]=${P_OPTION[$index]}" 1>&2
    done
    for index in "${!A_OPTION[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: A_OPTION[$index]=${A_OPTION[$index]}" 1>&2
    done
    for index in "${!O_OPTION[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: O_OPTION[$index]=${O_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: GIT_TOOL=$GIT_TOOL" 1>&2
    for index in "${!PHASE_NAME[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: PHASE_NAME[$index]=${PHASE_NAME[$index]}" 1>&2
    done
    for index in "${!HTML_PHASE_NAME[@]}"; do
	echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: HTML_PHASE_NAME[$index]=${HTML_PHASE_NAME[$index]}" 1>&2
    done
    echo "$0: debug[$DEBUG_LEVEL]: $DBG_PREFIX: GETOPT_PHASE=$GETOPT_PHASE" 1>&2
    return 0
}


#################################
# md2html.cfg related functions #
#################################


# match_md2html - first file_glob match for md2html.cfg file
#
# usage:
#	match_md2html md2html_path match_md
#
#	md2html_path	md2html.cfg configuration file path
#	match_md	file path to match in md2html.cfg
#
# returns:
#	0	match_md matched in md2html_path
#	1	match_md not matched
#   >= 10	internal error
#
# NOTE: If match_md matches a file_glob line from md2html_path, then
#	for every intended cfg_option, add that line (without the leading whitespace)
#	to the MATCH_OPTIONS shell array.
#
function match_md2html
{
    local MD2HTML_CFG_PATH	# path to md2html.cfg file
    local FILENAME_TO_MATCH	# file path to match in md2html.cfg
    local FILE_GLOB		# file pattern from the md2html.cfg file
    local OPTION		# option line found in the md2html.cfg file
    local MATCH_FOUND		# 1 ==> found a match in md2html.cfg, 0 ==> no match found

    # parse args
    #
    if [[ $# -ne 2 ]]; then
	echo "$0: ERROR: match_md2html requires 2 args, found: $#" 1>&2
	exit 11
    fi
    MD2HTML_CFG_PATH="$1"
    FILENAME_TO_MATCH="$2"

    # md2html.cfg must be a non-empty file
    #
    if [[ ! -s $MD2HTML_CFG_PATH ]]; then
	echo "$0: ERROR: md2html.cfg configuration is not a non-empty file: $MD2HTML_CFG_PATH" 1>&2
	exit 12
    fi

    # verify that md2html.cfg contains no lines that start with . followed by whitespace.
    #
    # We do this because of how we will scan md2html.cfg below.
    #
    if grep -E -q '^\.\s\s*\S' "$MD2HTML_CFG_PATH" >/dev/null 2>&1; then
	echo "$0: ERROR: md2html.cfg configuration contains a line that starts with . (dot) followed by whitespace" 1>&2
	exit 13
    elif [[ $V_FLAG -ge 9 ]]; then
	echo "$0: debug[9]: in match_md2html: md2html.cfg does NOT contain a . whitespace line: $MD2HTML_CFG_PATH" 1>&2
    fi

    # scan md2html.cfg for first match
    #
    # We use sed to transform the md2html.cfg for easier shell processing, such
    # as removing comments, removing any trailing whitespace, removing empty lines,
    # and converting any leaving whitespace into a leading ". ".
    #
    MATCH_FOUND=0
    sed -e 's/[[:space:]]*#.*$//' \
	-e 's/[[:space:]]*$//' \
	-e '/^$/d' \
	-e '/^[[:space:]]/s/[[:space:]]*/. /' < "$MD2HTML_CFG_PATH" |
      while read -r FILE_GLOB OPTION; do

        # case: no match has been found, and FILE_GLOB matches our FILENAME_TO_MATCH arg
	#
	# Set the MATCH_FOUND flag.
	#
	# SC2053 (warning): Quote the right-hand side of == in [[ ]] to prevent glob matching.
	# https://www.shellcheck.net/wiki/SC2053
	# shellcheck disable=SC2053
	if [[ $MATCH_FOUND -eq 0 && $FILE_GLOB != "." && $FILENAME_TO_MATCH == $FILE_GLOB ]]; then
	    if [[ $V_FLAG -ge 7 ]]; then
		echo "$0: debug[7]: in match_md2html: $FILENAME_TO_MATCH matches file_glob: $FILE_GLOB" 1>&2
	    fi
	    MATCH_FOUND=1
	    continue
	fi

	# case: match as been found, and we have a ". option"
	#
	# Add that option to the MATCH_OPTIONS shell array.
	#
	if [[ $MATCH_FOUND -eq 1 && $FILE_GLOB == "." && -n $OPTION ]]; then
	    if [[ $V_FLAG -ge 7 ]]; then
		echo "$0: debug[7]: in match_md2html: adding to MATCH_OPTIONS: $OPTION" 1>&2
	    fi
	    MATCH_OPTIONS+=("$OPTION");
	    continue
	fi

	# case: match as been found, and we have a new FILE_GLOB
	#
	# Stop scanning the md2html.cfg file.
	#
	if [[ $MATCH_FOUND -eq 1 && $FILE_GLOB != "." ]]; then
	    if [[ $V_FLAG -ge 7 ]]; then
		echo "$0: debug[7]: in match_md2html: end of MATCH_OPTIONS" 1>&2
	    fi
	    break
	fi
	if [[ $V_FLAG -ge 9 ]]; then
	    if [[ $FILE_GLOB != "." ]]; then
		echo "$0: debug[0]: in match_md2html: file_glob: $FILE_GLOB does not match: $FILENAME_TO_MATCH" 1>&2
	    elif [[ $FILE_GLOB == "." ]]; then
		echo "$0: debug[9]: in match_md2html: ignoring non-file_glob line: $OPTION" 1>&2
	    fi
	fi
    done

    # return 0 if match was found
    #
    if [[ $MATCH_FOUND -eq 1 ]]; then
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: in match_md2html: processed match for: $FILENAME_TO_MATCH" 1>&2
	fi
	return 0

    # else return 1 if no match was found
    #
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: in match_md2html: no match found for: $FILENAME_TO_MATCH" 1>&2
    fi
    return 1
}


################################
# HTML phase related functions #
################################


# append_html_phase - append a sed modified HTML phase file to a growing temporary HTML file
#
# usage:
#	append_html_phase phase_number name_of_phase starting_exit_code sed_script tmp_phase_file tmp_append
#
#	phase_number	    - HTML phase number (see inc/md2readme.cfg)
#	name_of_phase	    - Name of HTML phase (see inc/md2readme.cfg and the HTML_PHASE_NAME array)
#	starting_exit_code  - On error, exit starting at this exit code
#	sed_script	    - file contain sed commands
#	tmp_phase_file	    - temp file used to write sed script results
#	tmp_append	    - growing temporary HTML file to append tmp_phase onto
#
# returns:
#	0  ==> ALL is OK
#	>0 ==> fatal ERROR, exit with this code
#
function append_html_phase
{
    local PHASE_NUMBER		# HTML phase number
    local NAME_OF_PHASE		# Name of HTML phase
    local STARTING_EXIT_CODE	# On error, return exit code starting at this exit code
    local SED_SCRIPT		# file contain sed commands
    local TMP_PHASE_FILE	# temp file used to write sed script results
    local TMP_APPEND		# growing temporary HTML file to append tmp_phase onto
    local PHASE_FILE		# HTML filename for the given phase

    # parse args
    #
    if [[ $# -ne 6 ]]; then
	echo "$0: ERROR: append_html_phase requires 6 args, found: $#" 1>&2
	# We have to return non-zero but we don't have the args to know STARTING_EXIT_CODE.
	# We might as well use 7 since that is an HTML phase exit code
	return 7
    fi
    PHASE_NUMBER="$1"
    NAME_OF_PHASE="$2"
    STARTING_EXIT_CODE="$3"
    SED_SCRIPT="$4"
    TMP_PHASE_FILE="$5"
    TMP_APPEND="$6"
    #
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: starting: append_html_phase $PHASE_NUMBER $NAME_OF_PHASE $STARTING_EXIT_CODE" \
	     "$SED_SCRIPT $TMP_PHASE_FILE $TMP_APPEND" 1>&2
    fi

    # If ${HTML_PHASE_NAME[$NAME_OF_PHASE] is . then do nothing
    #
    if [[ ${HTML_PHASE_NAME[$NAME_OF_PHASE]} == . ]]; then
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: in: append_html_phase phase name: $NAME_OF_PHASE, -H . disables phase output" 1>&2
	fi
	return 0
    fi

    # HTML phase setup
    #
    PHASE_FILE="$INC_DIR/$NAME_OF_PHASE.${HTML_PHASE_NAME[$NAME_OF_PHASE]}.html"
    #
    # we validated all HTML phase names previously: so only a readable file check is needed
    #
    if [[ ! -r "$PHASE_FILE" ]]; then
	echo "$0: ERROR: cannot read HTML phase $PHASE_NUMBER ($NAME_OF_PHASE) file: $PHASE_FILE" 1>&2
	return "$STARTING_EXIT_CODE";
    fi

    # output, with sed modification, HTML phase file
    #
    if [[ -z $NOOP ]]; then
	sed -f "$SED_SCRIPT" "$PHASE_FILE" > "$TMP_PHASE_FILE"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: sed error on HTML phase $PHASE_NUMBER ($NAME_OF_PHASE) file: $PHASE_FILE failed," \
		 "error code: $status" 1>&2
	    return $(( STARTING_EXIT_CODE+1 ))
	fi
    elif [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: because of -n, disabled: sed -f $SED_SCRIPT $PHASE_FILE > $TMP_PHASE_FILE" 1>&2
    fi

    # verify that no %%symbol%%'s were missed
    #
    if [[ -z $NOOP ]]; then
	if grep -F -q '%%' "$TMP_PHASE_FILE" 2>/dev/null; then

	    # warn about the problem
	    #
	    echo "$0: WARNING: %% symbols found in HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)" \
		 "starts below: $TMP_PHASE_FILE" 1>&2
	    grep -F '%%' "$TMP_PHASE_FILE" 1>&2
	    echo "$0: WARNING: %% symbols found in HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)" \
		 "ends above: $TMP_PHASE_FILE" 1>&2

	    # -S means just warn
	    #
	    if [[ -n $CAP_S_FLAG ]]; then
		echo "$0: WARNING: -S and %% symbols found in HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)" \
			 "file: $TMP_PHASE_FILE" 1>&2
	    else
		echo "$0: ERROR: %% symbols found in HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)" \
			 "file: $TMP_PHASE_FILE" 1>&2
		return $(( STARTING_EXIT_CODE+2 ))
	    fi
	elif [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: no %%'s found in: $TMP_PHASE_FILE" 1>&2
	fi
    elif [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: because of -n, disabled: grep -F -q '%%' $TMP_PHASE_FILE 2>/dev/null" 1>&2
    fi

    # append HTML phase file to temporary index HTML file
    #
    if [[ -z $NOOP ]]; then
	cat "$TMP_PHASE_FILE" >> "$TMP_APPEND"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: cat $TMP_PHASE_FILE >> $TMP_APPEND for HTML phase $PHASE_NUMBER ($NAME_OF_PHASE) failed," \
		 "error code: $status" 1>&2
	    return $(( STARTING_EXIT_CODE+3 ))
	fi
    elif [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: because of -n, disabled: cat $TMP_PHASE_FILE >> $TMP_APPEND" 1>&2
    fi

    # report progress if verbose
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: successfully completed HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)" 1>&2
    fi
    return 0
}


###################################
# required initial variable setup #
###################################


global_variable_setup


##################
# getopt phase 0 #
##################


# set getopt phase to 0
#
GETOPT_PHASE=0


# process command line options
#
parse_command_line "$@"


# parse the command line arguments
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: debug level: $V_FLAG" 1>&2
fi
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: after parse_command_line of getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} parse_command_line call file argument count: $#" 1>&2
fi
case "$#" in
2) INPUT_MD="$1"
    if [[ $INPUT_MD == - ]]; then
	echo "$0: ERROR: when 1st input.md arg is -, the 3 arg form must be used" 1>&2
	exit 3
    fi
    MATCH_MD="$INPUT_MD"
    OUTPUT_HTML="$2"
    ;;
3) MATCH_MD="$1"
    INPUT_MD="$2"
    OUTPUT_HTML="$3"
    ;;
*) echo "$0: ERROR: phase ${GETOPT_PHASE} parse_command_line call expected 2 or args, found: $#" 1>&2
    echo "$0: notice: phase ${GETOPT_PHASE} args: $*" 1>&2
    exit 3
    ;;
esac
if [[ $MATCH_MD == - ]]; then
    echo "$0: ERROR: 1st match.md arg cannot be -" 1>&2
    exit 3
fi


# determine working directory
#
# We will use the dirname of match.md as our working directory.  This is path from
# topdir, that is to be used to match an entry in the md2html.cfg configuration file.
# In the case of a entry directory, this will be a YYYY/dir working directory.
# In the case of a year level directory, this will be a YYYY working directory.
# In the case of a top level directory, this will be just a . working directory.
#
WORKING_DIR=$(dirname "$MATCH_MD")
export WORKING_DIR


# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_TOP_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
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


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


# verify that the bin/pandoc-wrapper.sh tool is executable
#
export PANDOC_WRAPPER="$BIN_DIR/pandoc-wrapper.sh"
if [[ ! -e $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh does not exist: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -f $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not a regular file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -x $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not an executable file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi


# verify that we have an inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 6
fi
export INC_DIR="inc"


# verify that we have a readable .top file
#
export TOP="$TOPDIR/.top"
if [[ ! -e $TOP ]]; then
    echo "$0: ERROR: topdir/.top does not exist: $TOP" 1>&2
    exit 6
fi
if [[ ! -f $TOP ]]; then
    echo "$0: ERROR: topdir/.top is not a file: $TOP" 1>&2
    exit 6
fi
if [[ ! -r $TOP ]]; then
    echo "$0: ERROR: topdir/.top is not a readable file: $TOP" 1>&2
    exit 6
fi


# verify we have a readable md2html.cfg file
#
if [[ -z $MD2HTML_CFG ]]; then
    MD2HTML_CFG="$BIN_DIR/md2html.cfg"
fi
if [[ ! -e $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg does not exist: $MD2HTML_CFG" 1>&2
    exit 5
fi
if [[ ! -f $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a file: $MD2HTML_CFG" 1>&2
    exit 5
fi
if [[ ! -r $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a readable file: $MD2HTML_CFG" 1>&2
    exit 5
fi


# new parameter debugging
#
debug_parameters 5 "after parse in getopt phase: $GETOPT_PHASE"
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


##################
# getopt phase 1 #
##################


# set getopt phase to 1
#
GETOPT_PHASE=1
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


# run output tools and parse output as more options
#
# report output tools and output tool options
if [[ $V_FLAG -ge 5 ]]; then
    for n in "${!OUTPUT_TOOL[@]}"; do
	VALUE="${OUTPUT_TOOL[$n]}"
    done
fi


# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 5
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 5
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 5
    fi
done


# pre-clear our output tool options array
#
# NOTE: The OUTPUT_TOOL_OPTIONS array contains the options that an "output tool" produces.
#	    The O_OPTION array is when we execute an "output tool".
#
unset OUTPUT_TOOL_OPTIONS
declare -ag OUTPUT_TOOL_OPTIONS


# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    # The output tool will print zero of more options to be parsed as a command line
    # at the end of this getopt phase.
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool:" \
	     "$VALUE ${O_OPTION[*]} -- ${WORKING_DIR}" 1>&2
    fi
    "$VALUE" "${O_OPTION[@]}" -- "${WORKING_DIR}" | while read -r optline; do
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool $VALUE produced: $optline" 1<&2
	fi
	OUTPUT_TOOL_OPTIONS+=("$optline")
    done
done


# process command line arguments from all output tools
#
if [[ ${#OUTPUT_TOOL_OPTIONS[@]} -gt 0 ]]; then

    # parse all output tool options
    #
    parse_command_line "${OUTPUT_TOOL_OPTIONS[@]}"

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} output tools produced no additional command line options to parse" 1>&2
fi
#
debug_parameters 5 "after parse in getopt phase: $GETOPT_PHASE"


# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTIONS
declare -ag OUTPUT_TOOL_OPTIONS
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


##################
# getopt phase 2 #
##################


# set getopt phase to 2
#
GETOPT_PHASE=2
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


# setup an empty MATCH_OPTIONS array for match_md2html to append options
#
unset MATCH_OPTIONS
declare -ag MATCH_OPTIONS


# find the first match md2html.cfg for the 'match.md' argument
#
match_md2html "$MD2HTML_CFG" "$MATCH_MD"
status="$?"
# case: no match for MATCH_MD
#
if [[ $status -ne 0 ]]; then
    echo "$0: Warning: $MATCH_MD does not match any lines in: $MD2HTML_CFG, match_md2html return code: $status" 1>&2


# case: MATCH_MD matched and command line options were appended to MATCH_OPTIONS
#
elif [[ ${#MATCH_OPTIONS[@]} -gt 0 ]]; then

    # report match count if verbose enough
    #
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} ${#MATCH_OPTIONS[@]} options to parse starts below" 1>&2
	for index in "${!MATCH_OPTIONS[@]}"; do
	    echo "$0: debug[5]: MATCH_OPTIONS[$index]=${MATCH_OPTIONS[$index]}" 1>&2
	done
	echo "$0: debug[5]: phase ${GETOPT_PHASE} ${#MATCH_OPTIONS[@]} options to parse ends above" 1>&2
    fi

    # parse the command line options
    #
    parse_command_line "${MATCH_OPTIONS[@]}"


# case: MATCH_MD matched and no command line options found
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} no command line options were found for: $MATCH_MD" 1>&2
fi
#
debug_parameters 5 "after parse in getopt phase: $GETOPT_PHASE"
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


##################
# getopt phase 3 #
##################


# set getopt phase to 3
#
GETOPT_PHASE=3
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


# run output tools and parse output as more options
#
# report output tools and output tool options
if [[ $V_FLAG -ge 5 ]]; then
    for n in "${!OUTPUT_TOOL[@]}"; do
	VALUE="${OUTPUT_TOOL[$n]}"
    done
fi


# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 5
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 5
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 5
    fi
done


# pre-clear our output tool options array
#
# NOTE: The OUTPUT_TOOL_OPTIONS array contains the options that an "output tool" produces.
#	    The O_OPTION array is when we execute an "output tool".
#
unset OUTPUT_TOOL_OPTIONS
declare -ag OUTPUT_TOOL_OPTIONS


# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    # The output tool will print zero of more options to be parsed as a command line
    # at the end of this getopt phase.
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool:" \
	     "$VALUE ${O_OPTION[*]} -- ${WORKING_DIR}" 1>&2
    fi
    "$VALUE" "${O_OPTION[@]}" -- "${WORKING_DIR}" | while read -r optline; do
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool $VALUE produced: $optline" 1<&2
	fi
	OUTPUT_TOOL_OPTIONS+=("$optline")
    done
done


# process command line arguments from all output tools
#
if [[ ${#OUTPUT_TOOL_OPTIONS[@]} -gt 0 ]]; then

    # parse all output tool options
    #
    parse_command_line "${OUTPUT_TOOL_OPTIONS[@]}"

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} output tools produced no additional command line options to parse" 1>&2
fi
#
debug_parameters 5 "after parse in getopt phase: $GETOPT_PHASE"


# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTIONS
declare -ag OUTPUT_TOOL_OPTIONS
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi


############################################
# debugging after getopt phase is complete #
############################################


# set getopt phase to 4
#
GETOPT_PHASE=4
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: NAME=$NAME" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: URL=$URL" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: after parse in getopt phase: $GETOPT_PHASE: TOP=$TOP" 1>&2
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: finished all getopt parsing" 1>&2
fi


# validate HTML phase names
#
for n in "${PHASE_NAME[@]}"; do
    if [[ ${HTML_PHASE_NAME[$n]} != . ]]; then
	export HTML_PHASE_FILE="$INC_DIR/$n.${HTML_PHASE_NAME[$n]}.html"
	if [[ $V_FLAG -ge 9 ]]; then
	    echo "$0: debug[9]: HTML phase $n: ${HTML_PHASE_NAME[$n]} file: $HTML_PHASE_FILE" 1>&2
	fi
	if [[ ! -e "$HTML_PHASE_FILE" ]]; then
	    echo "$0: ERROR: HTML phase $n file not found: $HTML_PHASE_FILE" 1>&2
	    exit 8
	fi
	if [[ ! -f "$HTML_PHASE_FILE" ]]; then
	    echo "$0: ERROR: HTML phase $n not a file: $HTML_PHASE_FILE" 1>&2
	    exit 8
	fi
	if [[ ! -r "$HTML_PHASE_FILE" ]]; then
	    echo "$0: ERROR: HTML phase $n not a readable file: $HTML_PHASE_FILE" 1>&2
	    exit 8
	fi
    else
	if [[ $V_FLAG -ge 9 ]]; then
	    echo "$0: debug[9]: HTML phase $n is disabled" 1>&2
	fi
    fi
done


# validate before tool
#
if [[ -n $BEFORE_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $BEFORE_TOOL ]]; then
	    echo "$0: debug[5]: -b before tool: $BEFORE_TOOL" 1>&2
	fi
    fi
    if [[ ! -e "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not found: $BEFORE_TOOL" 1>&2
	exit 5
    fi
    if [[ ! -f "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not a file: $BEFORE_TOOL" 1>&2
	exit 5
    fi
    if [[ ! -x "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not an executable file: $BEFORE_TOOL" 1>&2
	exit 5
    fi
fi


# validate after tool
#
if [[ -n $AFTER_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $AFTER_TOOL ]]; then
	    echo "$0: debug[5]: -a after tool: $AFTER_TOOL" 1>&2
	fi
    fi
    if [[ ! -e "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not found: $AFTER_TOOL" 1>&2
	exit 5
    fi
    if [[ ! -f "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not a file: $AFTER_TOOL" 1>&2
	exit 5
    fi
    if [[ ! -x "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not an executable file: $AFTER_TOOL" 1>&2
	exit 5
    fi
fi


# report TOKEN sed patterns
#
if [[ $V_FLAG -ge 7 ]]; then
    for n in "${!TOKEN[@]}"; do
	echo "$0: debug[7]: -s token replacement: sed -e s|%%$n%%|${TOKEN[$n]}|g" 1>&2
    done
fi

# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


##########################
# HTML pre-0 phase setup #
##########################


# create a temporary sed script
#
export TMP_SED_SCRIPT=".tmp.$NAME.SED_SCRIPT.$$.tmp"
if [[ $V_FLAG -ge 5 ]]; then
    echo  "$0: debug[5]: temporary sed script: $TMP_SED_SCRIPT" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT; exit' 0 1 2 3 15
    rm -f "$TMP_SED_SCRIPT"
    if [[ -e $TMP_SED_SCRIPT ]]; then
	echo "$0: ERROR: cannot remove temporary sed script: $TMP_SED_SCRIPT" 1>&2
	exit 14
    fi
    :> "$TMP_SED_SCRIPT"
    if [[ ! -e $TMP_SED_SCRIPT ]]; then
	echo "$0: ERROR: cannot create temporary sed script: $TMP_SED_SCRIPT" 1>&2
	exit 15
    fi

    # load the sed script with sed commands from any "-s token=value"
    #
    for n in "${!TOKEN[@]}"; do
	echo "s|%%$n%%|${TOKEN[$n]}|g" >> "$TMP_SED_SCRIPT"
    done
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: temporary sed script starts below: $TMP_SED_SCRIPT" 1>&2
	cat "$TMP_SED_SCRIPT" 1>&2
	echo "$0: debug[5]: temporary sed script ends above: $TMP_SED_SCRIPT" 1>&2
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary sed script is not formed: $TMP_SED_SCRIPT" 1>&2
    echo "$0: debug[3]: the temporary sed script that would have been written starts below: $TMP_SED_SCRIPT" 1>&2
    for n in "${!TOKEN[@]}"; do
	echo "s|%%$n%%|${TOKEN[$n]}|g" 1>&2
    done
    echo "$0: debug[3]: the temporary sed script that would have been written ends above: $TMP_SED_SCRIPT" 1>&2
fi


# create a temporary HTML phase file
#
# NOTE: This file, when we are finished building it, will be come the final index.html file.
#
export TMP_PHASE=".tmp.$NAME.PHASE.$$.tmp"
if [[ $V_FLAG -ge 5 ]]; then
    echo  "$0: debug[5]: temporary HTML file: $TMP_PHASE" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE; exit' 0 1 2 3 15
    rm -f "$TMP_PHASE"
    if [[ -e $TMP_PHASE ]]; then
	echo "$0: ERROR: cannot remove temporary HTML file: $TMP_PHASE" 1>&2
	exit 15
    fi
    :> "$TMP_PHASE"
    if [[ ! -e $TMP_PHASE ]]; then
	echo "$0: ERROR: cannot create temporary HTML file: $TMP_PHASE" 1>&2
	exit 17
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary HTML file is not formed: $TMP_PHASE" 1>&2
fi


# create a temporary index HTML file
#
# NOTE: This file, when we are finished building it, will be come the final index.html file.
#
export TMP_INDEX_HTML=".tmp.$NAME.INDEX_HTML.$$.tmp"
if [[ $V_FLAG -ge 5 ]]; then
    echo  "$0: debug[5]: temporary index HTML file: $TMP_INDEX_HTML" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML; exit' 0 1 2 3 15
    rm -f "$TMP_INDEX_HTML"
    if [[ -e $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: cannot remove temporary index HTML file: $TMP_INDEX_HTML" 1>&2
	exit 18
    fi
    :> "$TMP_INDEX_HTML"
    if [[ ! -e $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: cannot create temporary index HTML file: $TMP_PHASE" 1>&2
	exit 19
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary index HTML file is not formed: $TMP_INDEX_HTML" 1>&2
fi


# input.md is -, we will need to capture standard input into a new temporary file
#
export ORIG_INPUT_MD="$MATCH_MD"
if [[ -z $NOOP ]]; then
    if [[ $INPUT_MD == - ]]; then
	export TMP_INPUT_MD=".tmp.$NAME.INPUT_MD.$$.tmp"
	if [[ $V_FLAG -ge 5 ]]; then
	    echo  "$0: debug[5]: temporary stdin file: $TMP_INPUT_MD" 1>&2
	fi
	trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML $TMP_INPUT_MD; exit' 0 1 2 3 15
	rm -f "$TMP_INPUT_MD"
	if [[ -e $TMP_INPUT_MD ]]; then
	    echo "$0: ERROR: cannot remove temporary stdin file: $TMP_INPUT_MD" 1>&2
	    exit 20
	fi
	:> "$TMP_INPUT_MD"
	if [[ ! -e $TMP_INPUT_MD ]]; then
	    echo "$0: ERROR: cannot create temporary stdin file: $TMP_INPUT_MD" 1>&2
	    exit 21
	fi

	# capture standard input into the temporary stdin file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	     echo "$0: debug[5]: about to capture stdin into: $TMP_INPUT_MD" 1>&2
	fi
	cat > "$TMP_INPUT_MD"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: cat into stdin file: $TMP_INPUT_MD failed, error code: $status" 1>&2
	    exit 22
	fi

	# replace 'input.md' of - with temporary stdin file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	     echo "$0: debug[5]: input.md arg was - is now: $TMP_INPUT_MD" 1>&2
	fi
	INPUT_MD="$TMP_INPUT_MD"
	ORIG_INPUT_MD="((stdin))"
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary stdin file is not formed: $TMP_INPUT_MD" 1>&2
fi


# strip commented language after markdown code block
#
if [[ -z $NOOP ]]; then

    export TMP_STRIPPED_MD=".tmp.$NAME.STRIPPED_MD.$$.tmp"
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: temporary stripped markdown file: $TMP_STRIPPED_MD" 1>&2
    fi
    trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML $TMP_INPUT_MD $TMP_STRIPPED_MD; exit' 0 1 2 3 15
    rm -f "$TMP_STRIPPED_MD"
    if [[ -e $TMP_STRIPPED_MD ]]; then
	echo "$0: ERROR: cannot remove temporary stripped markdown file: $TMP_STRIPPED_MD" 1>&2
	exit 23
    fi
    :> "$TMP_STRIPPED_MD"
    if [[ ! -e $TMP_STRIPPED_MD ]]; then
	echo "$0: ERROR: cannot create temporary stripped markdown file: $TMP_STRIPPED_MD" 1>&2
	exit 24
    fi

    # Note beginning of markdown input
    #
    echo "<!-- BEFORE: 1st line of markdown file: $ORIG_INPUT_MD -->" > "$TMP_STRIPPED_MD"

    # perform the %%TOKEN%% substitutions markdown file AND
    # strip commented language after markdown code block
    #
    # We do not want the sed extended regular expression to be expanded, so
    # we put it inside single quotes.
    #
    # SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
    # https://www.shellcheck.net/wiki/SC2016
    # shellcheck disable=SC2016
    sed -E -e 's/^```[[:space:]]<!---[^-][^-]*-->/```/' -f "$TMP_SED_SCRIPT" "$INPUT_MD" >> "$TMP_STRIPPED_MD"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: token substitution and strip code block command language from $INPUT_MD into file:" \
	     "$TMP_INPUT_MD failed, error code: $status" 1>&2
	exit 25
    fi
    echo "<!-- AFTER: last line of markdown file: $ORIG_INPUT_MD -->" >> "$TMP_STRIPPED_MD"

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary stripped markdown file is not formed: $TMP_INPUT_MD" 1>&2
fi


#######################################
# HTML phase 0: inc/top.__name__.html #
#######################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
export CUR_PHASE_NUM=0
export CUR_PHASE_NAME="top"
export BASE_EXIT_CODE=40	# possible: exit 40 or exit 41 or exit 42 or exit 43 or exit 44
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
	 "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


########################################
# HTML phase 1: inc/head.__name__.html #
########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=1
CUR_PHASE_NAME="head"
BASE_EXIT_CODE=45	# possible: exit 45 or exit 46 or exit 47 or exit 48 or exit 49
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


# Special output to indicate which tool was used
#
if [[ -z $NOOP && ${HTML_PHASE_NAME[$CUR_PHASE_NAME]} != . ]]; then
    {
	echo
	echo "<!-- -->"
	echo "<!-- This web page was formed via the tool: $TAGLINE -->"
if [[ -n $MDTAG ]]; then
	echo "<!-- The content of main section of this web page came from: $MDTAG -->"
else
	echo "<!-- The main section of this web page came from JSON and other data files -->"
fi
	echo "<!-- -->"
	echo
	echo "<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->"
if [[ -n $MDTAG ]]; then
	echo "<!-- !!! Do not modify this web page, instead modify the file: $MDTAG !!! -->"
	echo "<!-- !!! Do not modify this web page, instead modify the file: $MDTAG !!! -->"
	echo "<!-- !!! Do not modify this web page, instead modify the file: $MDTAG !!! -->"
else
	echo "<!-- The main section of this web page was generated via the tool: $TAGLINE -->"
	echo "<!-- The main section of this web page was generated via the tool: $TAGLINE -->"
	echo "<!-- The main section of this web page was generated via the tool: $TAGLINE -->"
fi
	echo "<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->"
	echo
	echo "<!-- Markdown content was converted into HTML via the tool: bin/$NAME -->"
	echo
    } >> "$TMP_INDEX_HTML"
fi


########################################
# HTML phase 2: inc/body.__name__.html #
########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=2
CUR_PHASE_NAME="body"
BASE_EXIT_CODE=50	# possible: exit 50 or exit 51 or exit 52 or exit 53 or exit 54
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


########################################
# HTML phase 3: inc/topbar.__name__.html #
########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=3
CUR_PHASE_NAME="topbar"
BASE_EXIT_CODE=55	# possible: exit 55 or exit 56 or exit 57 or exit 58 or exit 59
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


##########################################
# HTML phase 4: inc/header.__name__.html #
##########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=4
CUR_PHASE_NAME="header"
BASE_EXIT_CODE=60	# possible: exit 60 or exit 61 or exit 62 or exit 63 or exit 64
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


##########################################
# HTML phase 5: inc/navbar.__name__.html #
##########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=5
CUR_PHASE_NAME="navbar"
BASE_EXIT_CODE=65	# possible: exit 65 or exit 66 or exit 67 or exit 68 or exit 69
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


###################################################
# HTML phase 6: inc/before-content.__name__.html #
###################################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=6
CUR_PHASE_NAME="before-content"
BASE_EXIT_CODE=70	# possible: exit 70 or exit 71 or exit 72 or exit 73 or exit 74
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


##############################
# HTML phase 20: before tool #
##############################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=20
CUR_PHASE_NAME="before-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    for index in "${!B_OPTION[@]}"; do
	echo "$0: debug[5]: B_OPTION[$index]=${B_OPTION[$index]}" 1>&2
    done
fi
#
if [[ -n $BEFORE_TOOL ]]; then
    if [[ -z $NOOP ]]; then

	# write START of section comment
	#
	{
	    echo "<!-- START: this line starts content for HTML phase $CUR_PHASE_NUM" \
		 "by: $BEFORE_TOOL via bin/$NAME -->"
	    echo
	} >> "$TMP_INDEX_HTML"

	# append before tool output
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		 "$BEFORE_TOOL ${B_OPTION[*]} -- $WORKING_DIR >> $TMP_INDEX_HTML" 1>&2
	fi
	"$BEFORE_TOOL" "${B_OPTION[@]}" -- "$WORKING_DIR" >> "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: before tool:" \
		 "$BEFORE_TOOL ${B_OPTION[*]} -- $WORKING_DIR failed," \
		 "error code: $status" 1>&2
	    exit 95
	fi

	# write START of section comment
	#
	{
	    echo
	    echo "<!-- END: this line ends content for HTML phase $CUR_PHASE_NUM" \
		 "by: $BEFORE_TOOL via bin/$NAME -->"
	} >> "$TMP_INDEX_HTML"

    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: because of -n, disabled use of before tool: $BEFORE_TOOL" 1>&2
    fi
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -b ., use of before tool was disabled" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: successfully completed HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)" 1>&2
fi


######################################
# HTML phase 21: pandoc wrapper tool #
######################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=21
CUR_PHASE_NAME="pandoc-wrapper-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    for index in "${!P_OPTION[@]}"; do
	echo "$0: debug[5]: P_OPTION[$index]=${P_OPTION[$index]}" 1>&2
    done
fi
#
if [[ -z $NOOP ]]; then

    # write START of section comment
    #
    {
	echo "<!-- START: this line starts content for HTML phase $CUR_PHASE_NUM" \
	     "by: $PANDOC_WRAPPER via bin/$NAME -->"
	echo
    } >> "$TMP_INDEX_HTML"

    # append pandoc wrapper tool output
    #
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to execute:" \
	     "$PANDOC_WRAPPER ${P_OPTION[*]} -- $TMP_STRIPPED_MD - >> $TMP_INDEX_HTML" 1>&2
    fi
    "$PANDOC_WRAPPER" "${P_OPTION[@]}" -- "$TMP_STRIPPED_MD" - >> "$TMP_INDEX_HTML"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc wrapper tool:" \
	     "$PANDOC_WRAPPER ${P_OPTION[*]} -- $TMP_STRIPPED_MD - failed," \
	     "error code: $status" 1>&2
	exit 100
    fi

    # fix any pandoc footnote bogons
    #
    # The pandoc(1) tool will generate the following BOGUS HTML 5 code
    # when any markdown footnotes are used:
    #
    #	<!-- AFTER: last line of markdown file: PATH/FILE/NAME -->
    #	<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">
    #	<hr />
    #
    # The section element lacks any HTML h1..h6 heading element inside it,
    # and "<hr />" has no effect in standard HTML 5 and interacts badly with
    # unquoted attribute values.
    #
    # We replace such HTML 5 with HTML 5 code as follows:
    #
    #	<!-- AFTER: last line of markdown file: PATH/FILE/NAME -->
    #	<hr style="width:10%;text-align:left;margin-left:0">
    #	<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">
    #	<h5>Footnotes</h5>
    #
    # It is easier to compose a perl script inline than to use an external file
    # because we then have to test for that perl script to be a non-empty readable file,
    # and perhaps allow some arg to specify an alternate location for the perl script/
    # So instead we just build the perl script inline.
    #
    PERL_LINE='s|(<!-- AFTER: last line of markdown file: \S+ -->)\n'
    PERL_LINE="$PERL_LINE"'(<section id="footnotes" class="footnotes footnotes-end-of-document" role="doc-endnotes">)\n'
    PERL_LINE="$PERL_LINE"'<hr />|'
    PERL_LINE="$PERL_LINE\$1"'\n'
    PERL_LINE="$PERL_LINE"'<hr style="width:10%;text-align:left;margin-left:0">\n'
    PERL_LINE="$PERL_LINE\$2"'\n'
    PERL_LINE="$PERL_LINE"'<h5>Footnotes</h5>|gms'
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to execute:" \
	     "$PERL_TOOL -0 -p -i -e $PERL_LINE -- $TMP_INDEX_HTML" 1>&2
    fi

    "$PERL_TOOL" -0 -p -i -e "$PERL_LINE" -- "$TMP_INDEX_HTML"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc wrapper tool:" \
	     "$PERL_TOOL -0 -p -i -e $PERL_LINE -- $TMP_INDEX_HTML - failed," \
	     "error code: $status" 1>&2
	exit 101
    fi

    # write START of section comment
    #
    {
	echo
	echo "<!-- END: this line ends content for HTML phase $CUR_PHASE_NUM" \
	     "by: $PANDOC_WRAPPER via bin/$NAME -->"
    } >> "$TMP_INDEX_HTML"

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, disabled use of pandoc wrapper tool: $PANDOC_WRAPPER" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: successfully completed HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)" 1>&2
fi


#############################
# HTML phase 22: after tool #
#############################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=22
CUR_PHASE_NAME="after-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    for index in "${!A_OPTION[@]}"; do
	echo "$0: debug[5]: A_OPTION[$index]=${A_OPTION[$index]}" 1>&2
    done
fi
#
if [[ -n $AFTER_TOOL ]]; then
    if [[ -z $NOOP ]]; then

	# write START of section comment
	#
	{
	    echo "<!-- START: this line starts content for HTML phase $CUR_PHASE_NUM" \
		 "by: $AFTER_TOOL via bin/$NAME -->"
	    echo
	} >> "$TMP_INDEX_HTML"

	# append after tool output
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		 "$AFTER_TOOL ${A_OPTION[*]} -- $WORKING_DIR >> $TMP_INDEX_HTML" 1>&2
	fi
	"$AFTER_TOOL" "${A_OPTION[@]}" -- "$WORKING_DIR" >> "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: after tool:" \
		 "$AFTER_TOOL ${A_OPTION[*]} -- $WORKING_DIR failed," \
		 "error code: $status" 1>&2
	    exit 105
	fi

	# write START of section comment
	#
	{
	    echo
	    echo "<!-- END: this line ends content for HTML phase $CUR_PHASE_NUM" \
		 "by: $AFTER_TOOL via bin/$NAME -->"
	} >> "$TMP_INDEX_HTML"

    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: because of -n, disabled use of after tool: $AFTER_TOOL" 1>&2
    fi
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -a ., use of after tool was disabled" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: successfully completed HTML phase $CUR_PHASE_NUM" 1>&2
fi


##################################################
# HTML phase 30: inc/after-content.__name__.html #
##################################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=30
CUR_PHASE_NAME="after-content"
BASE_EXIT_CODE=110	# possible: exit 110 or exit 111 or exit 112 or exit 113 or exit 114
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


###########################################
# HTML phase 31: inc/footer.__name__.html #
###########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=31
CUR_PHASE_NAME="footer"
BASE_EXIT_CODE=115	# possible: exit 115 or exit 116 or exit 117 or exit 118 or exit 119
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


###########################################
# HTML phase 32: inc/bottom.__name__.html #
###########################################


# NOTE: See bin/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=32
CUR_PHASE_NAME="bottom"
BASE_EXIT_CODE=120	# possible: exit 120 or exit 121 or exit 122 or exit 123 or exit 124
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML failed," \
	 "error code: $status" 1>&2
    exit "$status"
fi


################################
# finalize the index.html file #
################################


# sanity check - temporary index HTML file must be a readable file
#
if [[ -z $NOOP ]]; then
    if [[ ! -e $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME) failed," \
	     "temporary index HTML file is missing: $TMP_INDEX_HTML" 1>&2
	exit 135
    fi
    if [[ ! -f $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME) failed," \
	     "temporary index HTML file is not a file: $TMP_INDEX_HTML" 1>&2
	exit 136
    fi
    if [[ ! -r $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME) failed," \
	     "temporary index HTML file is not a readable file: $TMP_INDEX_HTML" 1>&2
	exit 137
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled readable file check of: $TMP_PHASE_FILE 2>/dev/null" 1>&2
fi


# move temporary index HTML in place
#
if [[ -z $NOOP ]]; then

    # case: output.html is -
    #
    if [[ $OUTPUT_HTML == - ]]; then

	# we simply output the temporary html file to stdout
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: output.html arg is -, about to write temporary html file to standard output" 1>&2
	fi
	cat "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: write temporary html file: $TMP_INDEX_HTML to standard output filed, error code: $status" 1>&2
	    exit 138
	fi

    # case: output.html is not -, compare files
    #
    elif cmp -s "$TMP_INDEX_HTML" "$OUTPUT_HTML"; then

	# case: file did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: file did not change: $OUTPUT_HTML" 1>&2
	fi

    else

	# case: index.html changed, update the file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: mv -f -- $TMP_INDEX_HTML $OUTPUT_HTML" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    mv -f -v -- "$TMP_INDEX_HTML" "$OUTPUT_HTML"
	    status="$?"
	else
	    mv -f -- "$TMP_INDEX_HTML" "$OUTPUT_HTML"
	    status="$?"
	fi
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_INDEX_HTML $OUTPUT_HTML filed, error code: $status" 1>&2
	    exit 139
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: built replaced HTML file: $OUTPUT_HTML" 1>&2
	fi
	if [[ ! -s $OUTPUT_HTML ]]; then
	    echo "$0: ERROR: not a non-empty index HTML file: $OUTPUT_HTML" 1>&2
	    exit 140
	fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: mv -f -- $TMP_INDEX_HTML $OUTPUT_HTML" 1>&2
fi


# file cleanup
#
if [[ -z $NOOP ]]; then
    rm -f -- "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML" "$TMP_INPUT_MD" "$TMP_STRIPPED_MD"
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: rm -f --" \
	 "$TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML $TMP_INPUT_MD $TMP_STRIPPED_MD" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -n $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	if [[ $OUTPUT_HTML == - ]]; then
	    echo "$0: debug[1]: because of -n, skipped forming index HTML file in standard output" 1>&2
	else
	    echo "$0: debug[1]: because of -n, skipped forming index HTML file: $OUTPUT_HTML" 1>&2
	fi
    fi
fi
exit 0
