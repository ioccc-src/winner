#!/usr/bin/env bash
#
# readme2index - convert README.md into index.html
#
# Copyright (c) 2023,2024 by Landon Curt Noll.  All Rights Reserved.
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

# firewall - must be bash with a version 4.2 or later
#
# We must declare arrays with -ag or -Ag
#
if [[ -z ${BASH_VERSINFO[0]} || ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi

# setup bash file matching
#
# Requires bash with a version 4.2 or later
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -s globskipdots	# enable never matching . or ..
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
export VERSION="1.1.1 2024-01-20"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
    exit 10
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export PANDOC_WRAPPER="bin/pandoc-wrapper.sh"
export PANDOC_WRAPPER_OPTSTR="-f markdown -t html --fail-if-warnings=true"
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
export TOP_URL="https://ioccc-src.github.io/temp-test-ioccc"

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
	[-c md2html.cfg] [-H phase=name ..]
	[-b tool] [-B optstr] [-p tool] [-P optstr] [-a tool] [-A optstr]
	[-s token=value ..] [-S] [-o tool ..] [-O tool=optstr ..]
	[-u repo_url] [-U top_url] [-e string ..] [-E exitcode]
	yyyy/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
			NOTE: -d may only be used in command_options (getopt phase 0)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-c md2html.cfg	Use md2html.cfg as the configuration file (def: use topdir/inc/md2html.cfg)
			NOTE: -c may only be used in command_options (getopt phase 0)

	-H phase=name	use 'phase.name.html' file for HTML phase named 'phase' (def: use 'phase.default.html')
	-H phase=.	ignore processing for HTML phase 'phase' (def: process HTML phase)
			NOTE: The 'phase' string may not contain an = (equal), a / (slash), a single-quote, or a double-quote.
			NOTE: The 'name' string may not contain an = (equal), a single-quote, or a double-quote.
			NOTE: The 'phase.name.html' file is assumed to be under the 'topdir/inc' directory.

	-b tool		run 'before tool' during HTML phase number 20 (def: do not output before pandoc wrapper tool)
	-b .		skip HTML phase number 20 (def: do nothing during HTML phase number 20)
	-B optstr	run 'before tool' with options found in 'optstr' (def: do not add any options to 'before tool')
			NOTE: The 'optstr' may not contain a single-quote or a double-quote.

	-p tool		run 'pandoc wrapper tool' (not pandoc path) during HTML phase number 21 (def: use $PANDOC_WRAPPER)
	-p .		skip HTML phase number 21 (def: do nothing during HTML phase number 21)
			NOTE: The '-p tool' will be passed as leading options on the -b tool and -a tool command lines.
	-P optstr	run 'pandoc wrapper tool' with options found in 'optstr' (def: $PANDOC_WRAPPER_OPTSTR)
			NOTE: The 'optstr' may not contain a single-quote or a double-quote.
			NOTE: The '-P optstr' will be passed as leading options on the -b tool and -a tool command lines.

	-a tool		run 'after tool' during HTML phase number 20 (def: do not output after pandoc wrapper tool)
	-a .		skip HTML phase number 22 (def: do nothing during HTML phase number 22)
	-A optstr	run 'after tool' with options found in 'optstr' (def: do not add any options to 'after tool')
			NOTE: The 'optstr' may not contain a single-quote or a double-quote.

	-s token=value	substitute %%token%% with value except in HTML phase numbers 20-29 (def: do not substitute any tokens)
			NOTE: The 'token' string may not contain a ; (semicolon), a = (equal) or a % (percent).
			NOTE: The 'value' string may not contain a ; (semicolon).
			NOTE: A later '-s token=value' will override an earlier '-s token=value' for the same 'token'.
			NOTE: Multiple '-s token=value' are cumulative for the unique set of 'token's.
	-S		failure to replace a %%token%% is not an error (def: exit non-zero for non-substituted tokens)

	-o tool		Use 'output tool' to generate option lines (def: do not)
	-o .		disable use of 'output tool' (def: do not use an 'output tool')
			NOTE: -o may only be used in command_options and md2html.cfg cfg_options (getopt phases 0 and 2)
	-O tool=optstr	run the 'token replace' named 'tool' with options found in 'optstr' (def: do not add any options)
			NOTE: Neither 'tool' nor 'optstr' may not contain an = (equal), a single-quote or a double-quote.
			NOTE: A later '-O tool=optstr' will override all earlier '-O tool=optstr' for the same 'tool'.
			NOTE: -O may only be used in command_options and md2html.cfg cfg_options (getopt phases 0 and 2)

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)
			NOTE: The '-u repo_url' is passed as leading options on -o tool, -b tool, and -a tool command lines.
	-U top_url	Top level URL of web site where HTML files will be viewed (def: $TOP_URL)
			NOTE: The '-U top_url' is passed as leading options on -o tool, -b tool, and -a tool command lines.

	-e string	output 'string', followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	yyyy/dir	path from topdir to winner directory: must contain the files: README.md, .path and .winner.json

Exit codes:
     0	       all OK
     2	       -h and help string printed or -V and version string printed
     3	       command line error
     4	       bash version is < 4.2
     5	       yyyy/dir is not a winner directory
     6	       tool not found or not executable (before, pandoc wrapper, after, output tools)
     7	       HTML phase file not found or not readable
 >= 10 < 200   internal error
 >= 200	       tool error

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
    # REPO_URL set above the export USAGE line
    export MD2HTML_CFG=
    export BEFORE_TOOL=
    export BEFORE_TOOL_OPTSTR=
    # PANDOC_WRAPPER set above the export USAGE line
    export P_FLAG_FOUND=
    # PANDOC_WRAPPER_OPTSTR set above the export USAGE line
    export CAP_P_FLAG_FOUND=
    # REPO_URL set above the export USAGE line
    export U_FLAG_FOUND=
    # TOP_URL set above the export USAGE line
    export CAP_U_FLAG_FOUND=
    export AFTER_TOOL=
    export AFTER_TOOL_OPTSTR=
    unset TOKEN
    declare -Ag TOKEN
    export CAP_S_FLAG=
    unset OUTPUT_TOOL
    declare -ag OUTPUT_TOOL
    unset OUTPUT_TOOL_OPTSTR
    declare -Ag OUTPUT_TOOL_OPTSTR
    export MATCH_OPTIONS=

    # determine path to topdir if we are in a git repo
    #
    GIT_TOOL=$(type -P git)
    export GIT_TOOL
    if [[ -z "$GIT_TOOL" ]]; then
	echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
	exit 10
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
    PHASE_NAME=(top head body header topnav begin-row begin-leftcolumn
	        sidenav end-leftcolumn end-leftcolumn begin-rightcolumn before-content
		after-content end-rightcolumn end-row footer bottom)
    unset HTML_PHASE_NAME
    declare -Ag HTML_PHASE_NAME
    for n in "${PHASE_NAME[@]}"; do
	HTML_PHASE_NAME[$n]="default"
    done

    # initialize command line parse pass number
    #
    export GETOPT_PHASE=0
}

# print_usage - print the usage message, exit code and version information
#
# Call this to print the usage message, by default to stdout.
# However one might usually want to do:
#
#	print_usage 1>&2
#
function print_usage
{
    # print usage message
    #
    echo "$USAGE"
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
    while getopts :hv:VnNd:c:H:b:B:p:P:a:A:s:So:Ou:U:e:E: flag; do
      case "$flag" in
	h) print_usage 1>&2
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
		print_usage 1>&2
		exit 3
	    fi
	    #
	    TOPDIR="$OPTARG"
	    ;;
	c) # -c only in getopt phase 0
	    if [[ $GETOPT_PHASE -ne 0 ]]; then
		echo "$0: ERROR: -c may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
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
		print_usage 1>&2
		exit 3
		;;
	    esac
	    #
	    case "$NAME" in
	    *=*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a = character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    */*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a / character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a single-quote character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -H phase=name, the phase may not contain a double-quote character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    case "$VALUE" in
	    *=*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a = character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a single-quote character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -H phase=name, the name may not contain a double-quote character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    # name must be a known phase name
	    #
	    if [[ -z ${HTML_PHASE_NAME[$NAME]} ]]; then
		echo "$0: ERROR: -H name=value, name is unknown" 1>&2
		for n in "${PHASE_NAME[@]}"; do
		    echo "$0: notice: valid name: $n"
		done 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    # treat VALUE of . as an HTML PHASE name unset
	    #
	    if [[ $VALUE == . ]]; then
		# unset phase name
		HTML_PHASE_NAME[$NAME]=
	    else
		# change phase name
		HTML_PHASE_NAME[$NAME]="$VALUE"
	    fi
	    ;;
	b) # parse: -p tool
	    if [[ $OPTARG == . ]]; then
		# unset before tool
		BEFORE_TOOL=
	    else
		# change before tool
		BEFORE_TOOL="$OPTARG"
	    fi
	    ;;
	B) # parse -B optstr
	    case "$OPTARG" in
	    *"'"*)
		echo "$0: ERROR: in -B optstr, the optstr may not contain a single-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -B optstr, the optstr may not contain a double-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    BEFORE_TOOL_OPTSTR="$OPTARG"
	    ;;
	p) # parse -p tool
	    if [[ $OPTARG == . ]]; then
		# unset pandoc wrapper tool
		PANDOC_WRAPPER=
	    else
		# change pandoc wrapper tool
		PANDOC_WRAPPER="$OPTARG"
	    fi
	    P_FLAG_FOUND="-p"
	    ;;
	P) # parse -P optstr
	    case "$OPTARG" in
	    *"'"*)
		echo "$0: ERROR: in -P optstr, the optstr may not contain a single-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -P optstr, the optstr may not contain a double-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    PANDOC_WRAPPER_OPTSTR="$OPTARG"
	    CAP_P_FLAG_FOUND="-P"
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
	A) # parse -A optstr
	    case "$OPTARG" in
	    *"'"*)
		echo "$0: ERROR: in -A optstr, the optstr may not contain a single-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -A optstr, the optstr may not contain a double-quote character: $OPTARG" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    AFTER_TOOL_OPTSTR="$OPTARG"
	    ;;
	s) # parse: -s token=value
	    case "$OPTARG" in
	    *=*) # parse name=value
		NAME=${OPTARG%%=*}
		VALUE=${OPTARG#*=}
		;;
	    *) echo "$0: ERROR: -s token=value not in -s token=value form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    #
	    case "$NAME" in
	    *\;*)
		echo "$0: ERROR: in -s token=value, the token may not contain a ; (semicolon) character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *=*)
		echo "$0: ERROR: in -s token=value, the token may not contain a = (equal) character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *%*)
		echo "$0: ERROR: in -s token=value, the token may not contain a % (percent) character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    case "$VALUE" in
	    *\;*)
		echo "$0: ERROR: in -s token=value, the value may not contain a ; (semicolon) character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
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
		print_usage 1>&2
		exit 3
	    fi
	    #
	    OUTPUT_TOOL+=("$OPTARG")
	    ;;
	O) # parse -O tool=optstr
	    # -O only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -ne 0 && $GETOPT_PHASE -ne 2 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 2, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    case "$OPTARG" in
	    *=*) # parse name=value
		NAME=${OPTARG%%=*}
		VALUE=${OPTARG#*=}
		;;
	    *) echo "$0: ERROR: -O tool=optstr not in -O tool=optstr form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    #
	    case "$NAME" in
	    *=*)
		echo "$0: ERROR: in -O tool=optstr, the tool may not contain a = character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -O tool=optstr, the tool may not contain a single-quote character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -O tool=optstr, the tool may not contain a double-quote character: $NAME" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    case "$VALUE" in
	    *=*)
		echo "$0: ERROR: in -O tool=optstr, the optstr may not contain a = character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *"'"*)
		echo "$0: ERROR: in -O tool=optstr, the optstr may not contain a single-quote character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *'"'*)
		echo "$0: ERROR: in -O tool=optstr, the optstr may not contain a double-quote character: $VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    *) ;;
	    esac
	    #
	    # set tool optstr value
	    #
	    OUTPUT_TOOL_OPTSTR[$NAME]="$VALUE"
	    ;;
	u) REPO_URL="$OPTARG"
	    U_FLAG_FOUND="-u"
	    ;;
	U) TOP_URL="$OPTARG"
	    CAP_U_FLAG_FOUND="-U"
	    ;;
	e) echo "$OPTARG" 1>&2
	    ;;
	E) exit "$OPTARG"
	    ;;
	\?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	:) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
      esac
    done

    # clear options we will add to tools
    #
    export B_OPTSTR=
    export P_OPTSTR=
    export A_OPTSTR=
    export O_OPTSTR=

    # add '-p tool' options to tool arguments
    #
    if [[ -n $P_FLAG_FOUND && -n $PANDOC_WRAPPER ]]; then

	# add '-p tool' to '-b before tool'
	#
	if [[ -z $B_OPTSTR ]]; then
	    B_OPTSTR="-p \"$PANDOC_WRAPPER\""
	else
	    B_OPTSTR="$B_OPTSTR -p \"$PANDOC_WRAPPER\""
	fi

	# we do not add '-p tool' to 'pandoc wrapper tool'
	# instead we simply execute $PANDOC_WRAPPER\

	# add '-p tool' to '-a after tool'
	#
	if [[ -z $A_OPTSTR ]]; then
	    A_OPTSTR="-p \"$PANDOC_WRAPPER\""
	else
	    A_OPTSTR="$A_OPTSTR -p \"$PANDOC_WRAPPER\""
	fi
    fi

    # add '-P optstr' options to tool arguments
    #
    if [[ -n $CAP_P_FLAG_FOUND && -n $PANDOC_WRAPPER_OPTSTR ]]; then

	# add '-P optstr' to '-b before tool'
	#
	if [[ -z $B_OPTSTR ]]; then
	    B_OPTSTR="-P \"$PANDOC_WRAPPER_OPTSTR\""
	else
	    B_OPTSTR="$B_OPTSTR -P \"$PANDOC_WRAPPER_OPTSTR\""
	fi

	# add '-P optstr' to '-a after tool'
	#
	if [[ -z $A_OPTSTR ]]; then
	    A_OPTSTR="-P \"$PANDOC_WRAPPER_OPTSTR\""
	else
	    A_OPTSTR="$A_OPTSTR -P \"$PANDOC_WRAPPER_OPTSTR\""
	fi
    fi

    # add '-u repo_url' options to tool arguments
    #
    if [[ -n $U_FLAG_FOUND && -n $REPO_URL ]]; then

	# add '-u repo_url' to '-b before tool'
	#
	if [[ -z $B_OPTSTR ]]; then
	    B_OPTSTR="-u \"$REPO_URL\""
	else
	    B_OPTSTR="$B_OPTSTR -u \"$REPO_URL\""
	fi

	# add '-u repo_url' to '-p pandoc wrapper tool'
	#
	if [[ -z $P_OPTSTR ]]; then
	    P_OPTSTR="-u \"$REPO_URL\""
	else
	    P_OPTSTR="$P_OPTSTR -u \"$REPO_URL\""
	fi

	# add '-u repo_url' to '-a after tool'
	#
	if [[ -z $A_OPTSTR ]]; then
	    A_OPTSTR="-u \"$REPO_URL\""
	else
	    A_OPTSTR="$A_OPTSTR -u \"$REPO_URL\""
	fi

	# add '-u repo_url' to '-o output tool'
	#
	if [[ -z $O_OPTSTR ]]; then
	    O_OPTSTR="-u \"$REPO_URL\""
	else
	    O_OPTSTR="$O_OPTSTR -u \"$REPO_URL\""
	fi
    fi

    # add '-U top_url' options to tool arguments
    #
    if [[ -n $CAP_U_FLAG_FOUND && -n $TOP_URL ]]; then

	# add '-U top_url' to '-b before tool'
	#
	if [[ -z $B_OPTSTR ]]; then
	    B_OPTSTR="-U \"$TOP_URL\""
	else
	    B_OPTSTR="$B_OPTSTR -U \"$TOP_URL\""
	fi

	# add '-U top_url' to '-p pandoc wrapper tool'
	#
	if [[ -z $P_OPTSTR ]]; then
	    P_OPTSTR="-U \"$TOP_URL\""
	else
	    P_OPTSTR="$P_OPTSTR -U \"$TOP_URL\""
	fi

	# add '-U top_url' to '-a after tool'
	#
	if [[ -z $A_OPTSTR ]]; then
	    A_OPTSTR="-U \"$TOP_URL\""
	else
	    A_OPTSTR="$A_OPTSTR -U \"$TOP_URL\""
	fi

	# add '-U top_url' to '-o output tool'
	#
	if [[ -z $O_OPTSTR ]]; then
	    # We need to use \"-s (SC2089) because we will later evaluate this
	    # value into command line options.
	    #
	    # SC2089 (warning): Quotes/backslashes will be treated literally. Use an array.
	    # https://www.shellcheck.net/wiki/SC2089
	    # shellcheck disable=SC2089
	    O_OPTSTR="-U \"$TOP_URL\""
	else
	    O_OPTSTR="$O_OPTSTR -U \"$TOP_URL\""
	fi
    fi

    # always add '-B optstr' to '-b before tool'
    #
    if [[ -n $BEFORE_TOOL_OPTSTR ]]; then
	if [[ -z $B_OPTSTR ]]; then
	    B_OPTSTR="$BEFORE_TOOL_OPTSTR"
	else
	    B_OPTSTR="$B_OPTSTR \"$BEFORE_TOOL_OPTSTR\""
	fi
    fi

    # always add '-P optstr' to '-p pandoc wrapper tool'
    #
    if [[ -n $PANDOC_WRAPPER_OPTSTR ]]; then
	if [[ -z $P_OPTSTR ]]; then
	    # We need to use \"-s (SC2089) because we will later evaluate this
	    # value into command line options.
	    #
	    # SC2089 (warning): Quotes/backslashes will be treated literally. Use an array.
	    # https://www.shellcheck.net/wiki/SC2089
	    # shellcheck disable=SC2089
	    P_OPTSTR="-P \"$PANDOC_WRAPPER_OPTSTR\""
	else
	    P_OPTSTR="$P_OPTSTR -P \"$PANDOC_WRAPPER_OPTSTR\""
	fi
    fi

    # always add '-A optstr' to '-a after tool'
    #
    if [[ -n $AFTER_TOOL_OPTSTR ]]; then
	if [[ -z $A_OPTSTR ]]; then
	    A_OPTSTR="$AFTER_TOOL_OPTSTR"
	else
	    A_OPTSTR="$A_OPTSTR $AFTER_TOOL_OPTSTR"
	fi
    fi
}

#################################
# md2html.cfg related functions #
#################################

# match_md2html - first file_glob match for md2html.cfg file
#
# usage:
#	match_md2html md2html_path file_path
#
#	md2html_path	md2html.cfg configuration file path
#	file_path	file path to match in md2html.cfg
#
# returns:
#	0	file_path matched in md2html_path
#	1	file_path not matched
#   >= 10	internal error
#
# NOTE: This function sets MATCH_OPTIONS to the cfg_options set of
#	the first line from md2html_path with a file_glob that matches file_path.
#
function match_md2html
{
    local MD2HTML_PATH;		# path to md2html.cfg file
    local FILE_PATH;		# file path to match in md2html.cfg
    local FILE_GLOB;		# file pattern from the md2html.cfg file
    local CFG_OPTIONS;		# args associated with file pattern from the md2html.cfg file
    local NO_MATCH_FOUND;	# 0 ==> found a match in md2html.cfg, =! 0 ==> no match found

    # parse args
    #
    if [[ $# -ne 2 ]]; then
	echo "$0: ERROR: match_md2html requires 2 args, found: $#" 1>&2
	exit 11
    fi
    MD2HTML_PATH="$1"
    FILE_PATH="$2"

    # md2html.cfg must be a non-empty file
    #
    if [[ ! -s $MD2HTML_PATH ]]; then
	echo "$0: ERROR: md2html_path is not a non-empty file: $MD2HTML_PATH" 1>&2
	exit 12
    fi

    # scan md2html.cfg for first match
    #
    NO_MATCH_FOUND=1
    sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' < "$MD2HTML_PATH" | while read -r FILE_GLOB CFG_OPTIONS; do
	# The $FILE_GLOB is a glob by design and thus we do not want to quote (SC2053) it.
	#
	# SC2053 (warning): Quote the right-hand side of == in [[ ]] to prevent glob matching.
	# https://www.shellcheck.net/wiki/SC2053
	# shellcheck disable=SC2053
	if [[ $FILE_PATH == $FILE_GLOB ]]; then
	    if [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: file_path: $FILE_PATH matches file_glob: $FILE_GLOB" 1>&2
	    fi
	    MATCH_OPTIONS="$CFG_OPTIONS"
	    NO_MATCH_FOUND=0
	    break
	fi
    done

    # return 0 if match was found
    #
    if [[ $NO_MATCH_FOUND -eq 0 ]]; then
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: cfg_options matches file_path: $FILE_PATH: $CFG_OPTIONS" 1>&2
	fi
	return 0
    fi

    # no match
    #
    MATCH_OPTIONS=
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: file_path: $FILE_PATH no match found" 1>&2
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
    local PHASE_NUMBER;		# HTML phase number
    local NAME_OF_PHASE;	# Name of HTML phase
    local STARTING_EXIT_CODE;	# On error, return exit code starting at this exit code
    local SED_SCRIPT;		# file contain sed commands
    local TMP_PHASE_FILE;	# temp file used to write sed script results
    local TMP_APPEND;		# growing temporary HTML file to append tmp_phase onto

    # parse args
    #
    if [[ $# -ne 6 ]]; then
	echo "$0: ERROR: in append_html_phase, expected 6 args, found $#" 1>&2
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
	    echo "$0: ERROR: sed error on HTML phase $PHASE_NUMBER ($NAME_OF_PHASE) file: $PHASE_FILE," \
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
	    echo "$0: ERROR: cat $TMP_PHASE_FILE >> $TMP_APPEND for HTML phase $PHASE_NUMBER ($NAME_OF_PHASE)," \
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
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: phase ${GETOPT_PHASE} parse_command_line call expected 1 arg, found: $#" 1>&2
    exit 3
fi
#
export WINNER_PATH="$1"
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: WINNER_PATH=$WINNER_PATH" 1>&2
fi

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 13
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 14
fi

# verify that we have a inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 15
fi
export INC_DIR="inc"

# verify that we have an author subdirectory
#
export AUTHOR_DIR="$TOPDIR/author"
if [[ ! -d $AUTHOR_DIR ]]; then
    echo "$0: ERROR: author is not a directory under topdir: $AUTHOR_DIR" 1>&2
    exit 16
fi

# verify that we have a readable .top file
#
export TOP="$TOPDIR/.top"
if [[ ! -e $TOP ]]; then
    echo "$0: ERROR: topdir/.top does not exist: $TOP" 1>&2
    exit 17
fi
if [[ ! -f $TOP ]]; then
    echo "$0: ERROR: topdir/.top is not a file: $TOP" 1>&2
    exit 18
fi
if [[ ! -r $TOP ]]; then
    echo "$0: ERROR: topdir/.top is not a readable file: $TOP" 1>&2
    exit 19
fi

# verify we have a readable md2html.cfg file
#
if [[ -z $MD2HTML_CFG ]]; then
    MD2HTML_CFG="$INC_DIR/md2html.cfg"
fi
if [[ ! -e $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg does not exist: $MD2HTML_CFG" 1>&2
    exit 20
fi
if [[ ! -f $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a file: $MD2HTML_CFG" 1>&2
    exit 21
fi
if [[ ! -r $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a readable file: $MD2HTML_CFG" 1>&2
    exit 22
fi

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 23
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 24
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 25
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi

# verify that WINNER_PATH is a winner directory
#
# WINNER_PATH must be in yyyy/dir form
# yyyy must be a directory
# yyyy must be a writable directory
# yyyy/.year must be a non-empty file
# yyyy/dir must be a directory
# yyyy/dir/.path must be a non-empty file
# WINNER_PATH must match the contents of yyyy/dir/.path
# yyyy/dir/.winner.json must be a non-empty file
#
if [[ ! -d $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a directory: $WINNER_PATH" 1>&2
    exit 5
fi
if [[ ! -w $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $WINNER_PATH" 1>&2
    exit 5
fi
export YEAR_DIR=${WINNER_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in yyyy/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
export WINNER_DIR=${WINNER_PATH#*/}
if [[ -z $WINNER_DIR ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH not in $YEAR_DIR/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
if [[ $WINNER_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $WINNER_PATH contains a /: $WINNER_DIR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: yyyy from arg: $WINNER_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 5
fi
export DOT_YEAR="$YEAR_DIR/.year"
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR/$WINNER_DIR ]]; then
    echo "$0: ERROR: yyyy/dir from arg: $WINNER_PATH is not a directory: $YEAR_DIR/$WINNER_DIR" 1>&2
    exit 5
fi
export DOT_PATH="$YEAR_DIR/$WINNER_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 5
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
if [[ $WINNER_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 5
fi
export WINNER_JSON="$YEAR_DIR/$WINNER_DIR/.winner.json"
if [[ ! -e $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json does not exist: $WINNER_JSON" 1>&2
    exit 5
fi
if [[ ! -f $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a file: $WINNER_JSON" 1>&2
    exit 5
fi
if [[ ! -r $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a readable file: $WINNER_JSON" 1>&2
    exit 5
fi

# setup README_PATH and INDEX_PATH based on YEAR_DIR and WINNER_DIR
#
export README_PATH="$YEAR_DIR/$WINNER_DIR/README.md"
if [[ ! -e $README_PATH ]]; then
    echo "$0: ERROR: file does not exist: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -f $README_PATH ]]; then
    echo "$0: ERROR: not a file: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -r $README_PATH ]]; then
    echo "$0: ERROR: not a readable file: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -s $README_PATH ]]; then
    echo "$0: ERROR: readable file is empty: $README_PATH" 1>&2
    exit 5
fi
#
export INDEX_PATH="$YEAR_DIR/$WINNER_DIR/index.html"

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: WINNER_DIR=$WINNER_DIR" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: WINNER_JSON=$WINNER_JSON" 1>&2
    echo "$0: debug[3]: README_PATH=$README_PATH" 1>&2
    echo "$0: debug[3]: INDEX_PATH=$INDEX_PATH" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: TOP_URL=$TOP_URL" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
fi
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
	echo "$0: debug[5]: phase ${GETOPT_PHASE} -o output tool: $VALUE args: ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    done
fi

# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 6
    fi
done

# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool:" \
	     "$VALUE $O_OPTSTR ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- ${WINNER_PATH}" 1>&2
    fi
    # We are evaluating the next line on purpose as $O_OPTSTR and ${OUTPUT_TOOL_OPTSTR[$VALUE]}
    # may contain multiple command options, we cannot simply double quote them (SC2086).
    # We need to let eval do its work split (SC2046) the values.
    #
    # SC2046 (warning): Quote this to prevent word splitting.
    # https://www.shellcheck.net/wiki/SC2046
    # SC2086 (info): Double quote to prevent globbing and word splitting.
    # https://www.shellcheck.net/wiki/SC2086
    # shellcheck disable=SC2046,SC2086
    OUTPUT_TOOL_OUTPUT=$(eval "$VALUE" $O_OPTSTR ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- "${WINNER_PATH}")
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} $VALUE output starts below" 1>&2
	echo "$OUTPUT_TOOL_OUTPUT" 1>&2
	echo "$0: debug[5]: phase ${GETOPT_PHASE} $VALUE output ends above" 1>&2
    fi

    # process command line arguments from output tool
    #
    if [[ -n $OUTPUT_TOOL_OUTPUT ]]; then

	# parse output tool options by evaluating by globbing and splitting (SC2086)
	# the $OUTPUT_TOOL_OUTPUT value.
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	eval parse_command_line $OUTPUT_TOOL_OUTPUT

	# parse output tool arguments
	#
	shift $(( OPTIND - 1 ));
	#
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool file argument count: $#" 1>&2
	fi
	if [[ $# -ne 1 ]]; then
	    echo "$0: ERROR: phase ${GETOPT_PHASE} output tool expected 1 arg, found: $#" 1>&2
	    exit 3
	fi
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool produced no output" 1>&2
    fi
done

# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTSTR
declare -Ag OUTPUT_TOOL_OPTSTR
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

# find the first match md2html.cfg for README_PATH
#
match_md2html "$MD2HTML_CFG" "$README_PATH"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: README_PATH: $README_PATH does not match any lines in: $MD2HTML_CFG, error code: $status" 1>&2
    exit 26
fi

# set new options from match md2html.cfg for README_PATH
#
# We intend for eval to do its work, globbing and splitting (SC2086)
# the $MATCH_OPTIONS value.
#
# SC2086 (info): Double quote to prevent globbing and word splitting.
# https://www.shellcheck.net/wiki/SC2086
# shellcheck disable=SC2086
set -- $MATCH_OPTIONS

# parse the command line options
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: after phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: phase ${GETOPT_PHASE} parse_command_line call expected 0 args, found: $#" 1>&2
    exit 3
fi
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
	echo "$0: debug[5]: phase ${GETOPT_PHASE} -o output tool: $VALUE args: ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    done
fi

# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 6
    fi
done

# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool:" \
	     "$VALUE ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- ${WINNER_PATH}" 1>&2
    fi
    # We are evaluating the next line on purpose as $O_OPTSTR and ${OUTPUT_TOOL_OPTSTR[$VALUE]}
    # may contain multiple command options, we cannot simply double quote them (SC2086).
    # We need to let eval do its work split (SC2046) the values.
    #
    # SC2046 (warning): Quote this to prevent word splitting.
    # https://www.shellcheck.net/wiki/SC2046
    # SC2086 (info): Double quote to prevent globbing and word splitting.
    # https://www.shellcheck.net/wiki/SC2086
    # shellcheck disable=SC2046,SC2086
    OUTPUT_TOOL_OUTPUT=$(eval "$VALUE" $O_OPTSTR ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- "${WINNER_PATH}")
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} $VALUE output starts below" 1>&2
	echo "$OUTPUT_TOOL_OUTPUT" 1>&2
	echo "$0: debug[5]: phase ${GETOPT_PHASE} $VALUE output ends above" 1>&2
    fi

    # process command line arguments from output tool
    #
    if [[ -n $OUTPUT_TOOL_OUTPUT ]]; then

	# parse output tool options by evaluating by globbing and splitting (SC2086)
	# the $OUTPUT_TOOL_OUTPUT value.
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	eval parse_command_line $OUTPUT_TOOL_OUTPUT

	# parse output tool arguments
	#
	shift $(( OPTIND - 1 ));
	#
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool file argument count: $#" 1>&2
	fi
	if [[ $# -ne 0 ]]; then
	    echo "$0: ERROR: phase ${GETOPT_PHASE} output tool expected 0 args, found: $#" 1>&2
	    exit 3
	fi
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool produced no output" 1>&2
    fi
done

# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTSTR
declare -Ag OUTPUT_TOOL_OPTSTR
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
    echo "$0: debug[3]: finished all getopt parsing" 1>&2
fi

# validate HTML phase names
#
for n in "${PHASE_NAME[@]}"; do
    HTML_PHASE_FILE="$INC_DIR/$n.${HTML_PHASE_NAME[$n]}.html"
    if [[ $V_FLAG -ge 9 ]]; then
	echo "$0: debug[9]: HTML phase $n: ${HTML_PHASE_NAME[$n]} file: $HTML_PHASE_FILE" 1>&2
    fi
    if [[ ! -e "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n file not found: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
    if [[ ! -f "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n not a file: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
    if [[ ! -r "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n not a readable file: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
done

# validate before tool
#
if [[ -n $BEFORE_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $BEFORE_TOOL ]]; then
	    echo "$0: debug[5]: -b before tool: $BEFORE_TOOL" 1>&2
	fi
	if [[ -n $BEFORE_TOOL_OPTSTR ]]; then
	    echo "$0: debug[5]: -B before tool options: $BEFORE_TOOL_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not found: $BEFORE_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -f "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not a file: $BEFORE_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -x "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not an executable file: $BEFORE_TOOL" 1>&2
	exit 6
    fi
fi

# validate pandoc wrapper tool
#
if [[ -n $PANDOC_WRAPPER ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $PANDOC_WRAPPER ]]; then
	    echo "$0: debug[5]: -p pandoc wrapper tool: $PANDOC_WRAPPER" 1>&2
	fi
	if [[ -n $PANDOC_WRAPPER_OPTSTR ]]; then
	    echo "$0: debug[5]: -P pandoc wrapper tool options: $PANDOC_WRAPPER_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$PANDOC_WRAPPER" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not found: $PANDOC_WRAPPER" 1>&2
	exit 6
    fi
    if [[ ! -f "$PANDOC_WRAPPER" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not a file: $PANDOC_WRAPPER" 1>&2
	exit 6
    fi
    if [[ ! -x "$PANDOC_WRAPPER" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not an executable file: $PANDOC_WRAPPER" 1>&2
	exit 6
    fi
fi

# validate after tool
#
if [[ -n $AFTER_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $AFTER_TOOL ]]; then
	    echo "$0: debug[5]: -a after tool: $AFTER_TOOL" 1>&2
	fi
	if [[ -n $AFTER_TOOL_OPTSTR ]]; then
	    echo "$0: debug[5]: -A after tool options: $AFTER_TOOL_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not found: $AFTER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -f "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not a file: $AFTER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -x "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not an executable file: $AFTER_TOOL" 1>&2
	exit 6
    fi
fi

# report TOKEN sed patterns
#
if [[ $V_FLAG -ge 7 ]]; then
    for n in "${!TOKEN[@]}"; do
	echo "$0: debug[7]: -s token replacement: sed -e s;%%$n%%;${TOKEN[$n]};g" 1>&2
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
TMP_SED_SCRIPT=".$NAME.$$.sed"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary sed script: $TMP_SED_SCRIPT" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT; exit' 0 1 2 3 15
    rm -f "$TMP_SED_SCRIPT"
    if [[ -e $TMP_SED_SCRIPT ]]; then
	echo "$0: ERROR: cannot remove temporary sed script: $TMP_SED_SCRIPT" 1>&2
	exit 27
    fi
    :> "$TMP_SED_SCRIPT"
    if [[ ! -e $TMP_SED_SCRIPT ]]; then
	echo "$0: ERROR: cannot create temporary sed script: $TMP_SED_SCRIPT" 1>&2
	exit 28
    fi

    # load the sed script with sed commands from any "-s token=value"
    #
    for n in "${!TOKEN[@]}"; do
	echo "s;%%$n%%;${TOKEN[$n]};g" >> "$TMP_SED_SCRIPT"
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
	echo "s;%%$n%%;${TOKEN[$n]};g" 1>&2
    done
    echo "$0: debug[3]: the temporary sed script that would have been written ends above: $TMP_SED_SCRIPT" 1>&2
fi

# create a temporary HTML phase file
#
# NOTE: This file, when we are finished building it, will be come the final index.html file.
#
TMP_PHASE=".$NAME.$$.html-phase.html"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary HTML file: $TMP_PHASE" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE; exit' 0 1 2 3 15
    rm -f "$TMP_PHASE"
    if [[ -e $TMP_PHASE ]]; then
	echo "$0: ERROR: cannot remove temporary HTML file: $TMP_PHASE" 1>&2
	exit 27
    fi
    :> "$TMP_PHASE"
    if [[ ! -e $TMP_PHASE ]]; then
	echo "$0: ERROR: cannot create temporary HTML file: $TMP_PHASE" 1>&2
	exit 28
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary HTML file is not formed: $TMP_PHASE" 1>&2
fi

# create a temporary index HTML file
#
# NOTE: This file, when we are finished building it, will be come the final index.html file.
#
TMP_INDEX_HTML=".$NAME.$$.index.html"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary index HTML file: $TMP_INDEX_HTML" 1>&2
fi
if [[ -z $NOOP ]]; then

    # form the temp file
    #
    trap 'rm -f $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML; exit' 0 1 2 3 15
    rm -f "$TMP_INDEX_HTML"
    if [[ -e $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: cannot remove temporary index HTML file: $TMP_INDEX_HTML" 1>&2
	exit 29
    fi
    :> "$TMP_INDEX_HTML"
    if [[ ! -e $TMP_INDEX_HTML ]]; then

	exit 30
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary index HTML file is not formed: $TMP_INDEX_HTML" 1>&2
fi

#######################################
# HTML phase 0: inc/top.__name__.html #
#######################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
export CUR_PHASE_NUM=0
export CUR_PHASE_NAME="top"
export BASE_EXIT_CODE=40	# possible: exit 40 or exit 41 or exit 42 or exit 43 or exit 44
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
	 "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

# Special output to indicate which tool was used
#
if [[ -z $NOOP ]]; then
    {
	echo "<!-- -->"
	echo "<!-- This file was formed by the tool: bin/$NAME version: $VERSION -->"
	echo "<!-- -->"
    } >> "$TMP_INDEX_HTML"
fi

########################################
# HTML phase 1: inc/head.__name__.html #
########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=1
CUR_PHASE_NAME="head"
BASE_EXIT_CODE=45	# possible: exit 45 or exit 46 or exit 47 or exit 48 or exit 49
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

########################################
# HTML phase 2: inc/body.__name__.html #
########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=2
CUR_PHASE_NAME="body"
BASE_EXIT_CODE=50	# possible: exit 50 or exit 51 or exit 52 or exit 53 or exit 54
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

##########################################
# HTML phase 3: inc/header.__name__.html #
##########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=3
CUR_PHASE_NAME="header"
BASE_EXIT_CODE=55	# possible: exit 55 or exit 56 or exit 57 or exit 58 or exit 59
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

##########################################
# HTML phase 4: inc/topnav.__name__.html #
##########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=4
CUR_PHASE_NAME="topnav"
BASE_EXIT_CODE=60	# possible: exit 60 or exit 61 or exit 62 or exit 63 or exit 64
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

#############################################
# HTML phase 5: inc/begin-row.__name__.html #
#############################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=5
CUR_PHASE_NAME="begin-row"
BASE_EXIT_CODE=65	# possible: exit 65 or exit 66 or exit 67 or exit 68 or exit 69
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

####################################################
# HTML phase 6: inc/begin-leftcolumn.__name__.html #
####################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=6
CUR_PHASE_NAME="begin-leftcolumn"
BASE_EXIT_CODE=70	# possible: exit 70 or exit 71 or exit 72 or exit 73 or exit 74
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

###########################################
# HTML phase 7: inc/sidenav.__name__.html #
###########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=7
CUR_PHASE_NAME="sidenav"
BASE_EXIT_CODE=75	# possible: exit 75 or exit 76 or exit 77 or exit 78 or exit 79
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

##################################################
# HTML phase 8: inc/end-leftcolumn.__name__.html #
##################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=8
CUR_PHASE_NAME="end-leftcolumn"
BASE_EXIT_CODE=80	# possible: exit 80 or exit 81 or exit 82 or exit 83 or exit 84
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

#####################################################
# HTML phase 9: inc/begin-rightcolumn.__name__.html #
#####################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=9
CUR_PHASE_NAME="begin-rightcolumn"
BASE_EXIT_CODE=85	# possible: exit 85 or exit 86 or exit 87 or exit 88 or exit 89
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

###################################################
# HTML phase 10: inc/before-content.__name__.html #
###################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=10
CUR_PHASE_NAME="before-content"
BASE_EXIT_CODE=90	# possible: exit 90 or exit 91 or exit 92 or exit 93 or exit 94
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

##############################
# HTML phase 20: before tool #
##############################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=20
CUR_PHASE_NAME="before-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: B_OPTSTR: $B_OPTSTR" 1>&2
fi
#
if [[ -n $BEFORE_TOOL ]]; then
    if [[ -z $NOOP ]]; then

	# append before tool output
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		 "$BEFORE_TOOL $B_OPTSTR -- $YEAR_DIR/$WINNER_DIR >> $TMP_INDEX_HTML" 1>&2
	fi
	# We need to eval $B_OPTSTR because it does contain things that
	# need to be globbed and split (SC2086).
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	eval "$BEFORE_TOOL" $B_OPTSTR -- "$YEAR_DIR/$WINNER_DIR" >> "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: before tool:" \
		 "$BEFORE_TOOL $B_OPTSTR -- $YEAR_DIR/$WINNER_DIR failed," \
		 "error code: $status" 1>&2
	    exit 95
	fi

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

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=21
CUR_PHASE_NAME="pandoc-wrapper-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: P_OPTSTR: $P_OPTSTR" 1>&2
fi
#
if [[ -n $PANDOC_WRAPPER ]]; then
    if [[ -z $NOOP ]]; then

	# append pandoc wrapper tool output
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		 "$PANDOC_WRAPPER $P_OPTSTR -- $README_PATH - >> $TMP_INDEX_HTML" 1>&2
	fi
	# We need to eval $P_OPTSTR because it does contain things that
	# need to be globbed and split (SC2086).
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	eval "$PANDOC_WRAPPER" $P_OPTSTR -- "$README_PATH" - >> "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: pandoc wrapper tool:" \
		 "$PANDOC_WRAPPER $P_OPTSTR -- $README_PATH - failed," \
	         "error code: $status" 1>&2
	    exit 100
	fi

    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: because of -n, disabled use of pandoc wrapper tool: $PANDOC_WRAPPER" 1>&2
    fi
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -p ., use of pandoc wrapper tool was disabled" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: successfully completed HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)" 1>&2
fi

#############################
# HTML phase 22: after tool #
#############################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=22
CUR_PHASE_NAME="after-tool"
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: A_OPTSTR: $A_OPTSTR" 1>&2
fi
#
if [[ -n $AFTER_TOOL ]]; then
    if [[ -z $NOOP ]]; then

	# append after tool output
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		 "$AFTER_TOOL $A_OPTSTR $AFTER_TOOL_OPTSTR -- $YEAR_DIR/$WINNER_DIR >> $TMP_INDEX_HTML" 1>&2
	fi
	# We need to eval $A_OPTSTR because it does contain things that
	# need to be globbed and split (SC2086).
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	eval "$AFTER_TOOL" $A_OPTSTR $AFTER_TOOL_OPTSTR -- "$YEAR_DIR/$WINNER_DIR" >> "$TMP_INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: after tool:" \
		 "$AFTER_TOOL $A_OPTSTR $AFTER_TOOL_OPTSTR -- $YEAR_DIR/$WINNER_DIR failed," \
		 "error code: $status" 1>&2
	    exit 105
	fi

    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: because of -n, disabled use of after tool: $AFTER_TOOL" 1>&2
    fi
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -a ., use of after tool was disabled" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: successfully completed HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)" 1>&2
fi

##################################################
# HTML phase 30: inc/after-content.__name__.html #
##################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=30
CUR_PHASE_NAME="after-content"
BASE_EXIT_CODE=110	# possible: exit 110 or exit 111 or exit 112 or exit 113 or exit 114
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

####################################################
# HTML phase 31: inc/end-rightcolumn.__name__.html #
####################################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=31
CUR_PHASE_NAME="end-rightcolumn"
BASE_EXIT_CODE=115	# possible: exit 115 or exit 116 or exit 117 or exit 118 or exit 119
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

############################################
# HTML phase 32: inc/end-row.__name__.html #
############################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=32
CUR_PHASE_NAME="end-row"
BASE_EXIT_CODE=120	# possible: exit 120 or exit 121 or exit 122 or exit 123 or exit 124
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

###########################################
# HTML phase 33: inc/footer.__name__.html #
###########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=33
CUR_PHASE_NAME="footer"
BASE_EXIT_CODE=125	# possible: exit 125 or exit 126 or exit 127 or exit 128 or exit 129
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
	 "error code: $status" 1>&2
    exit "$status"
fi

###########################################
# HTML phase 34: inc/bottom.__name__.html #
###########################################

# NOTE: See inc/md2html.cfg for details on HTML phase numbers, HTML phase names, and HTML phase files
#
CUR_PHASE_NUM=34
CUR_PHASE_NAME="bottom"
BASE_EXIT_CODE=130	# possible: exit 130 or exit 131 or exit 132 or exit 133 or exit 134
#
append_html_phase "$CUR_PHASE_NUM" "$CUR_PHASE_NAME" "$BASE_EXIT_CODE" "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: append_html_phase" \
         "$CUR_PHASE_NUM $CUR_PHASE_NAME $BASE_EXIT_CODE $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML," \
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
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)," \
	     "temporary index HTML file is missing: $TMP_INDEX_HTML" 1>&2
	exit 135
    fi
    if [[ ! -f $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)," \
	     "temporary index HTML file is not a file: $TMP_INDEX_HTML" 1>&2
	exit 136
    fi
    if [[ ! -r $TMP_INDEX_HTML ]]; then
	echo "$0: ERROR: after HTML phase $CUR_PHASE_NUM ($CUR_PHASE_NAME)," \
	     "temporary index HTML file is not a readable file: $TMP_INDEX_HTML" 1>&2
	exit 137
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled readable file check of: $TMP_PHASE_FILE 2>/dev/null" 1>&2
fi

# move temporary index HTML in place
#
if [[ -z $NOOP ]]; then

    # compare files
    #
    if cmp -s "$TMP_INDEX_HTML" "$INDEX_PATH"; then

	# case: file did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: file did not change: $INDEX_PATH" 1>&2
	fi

    else

	# case: index.html changed, update the file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: mv -f -- $TMP_INDEX_HTML $INDEX_PATH" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    mv -f -v -- "$TMP_INDEX_HTML" "$INDEX_PATH"
	    status="$?"
	else
	    mv -f -- "$TMP_INDEX_HTML" "$INDEX_PATH"
	    status="$?"
	fi
	if [[ status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_INDEX_HTML $INDEX_PATH filed, error code: $status" 1>&2
	    exit 138
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[3]: built index HTML file: $INDEX_PATH" 1>&2
	fi
	if [[ ! -s $INDEX_PATH ]]; then
	    echo "$0: ERROR: not a non-empty index HTML file: $INDEX_PATH" 1>&2
	    exit 139
	fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: mv -f -- $TMP_INDEX_HTML $INDEX_PATH" 1>&2
fi

# file cleanup
#
if [[ -z $NOOP ]]; then
    rm -f -- "$TMP_SED_SCRIPT" "$TMP_PHASE" "$TMP_INDEX_HTML"
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: rm -f -- $TMP_SED_SCRIPT $TMP_PHASE $TMP_INDEX_HTML" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
if [[ -n $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[3]: because of -n, skipped forming index HTML file: $INDEX_PATH" 1>&2
    fi
fi
exit 0
