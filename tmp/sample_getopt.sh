#!/usr/bin/env bash
#
# sample_getopt.sh - sample command line option parsing
#
# Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
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

# firewall - bash must be version 4,2 or later
#
# We must declare arrays with -ag or -Ag
#
if [[ ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N]
	[-d topdir] [-c md2html.cfg] [-H phase=name ..]
	[-b tool] [-B optstr] [-p tool] [-P optstr] [-a tool] [-A optstr]
	[-s token=value ..] [-S] [-o tool ..] [-O tool=optstr ..]
	[-e string ..] [-E exitcode] filename_arg

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just ignore the file (def: process the file)

	-d topdir	set topdir (def: if 'git rev-parse --is-inside-work-tree' is true, then
					 topdir is output of 'git rev-parse --show-toplevel')
			NOTE: -d may only be used in command_options (getopt phase 0)

	-c md2html.cfg	Use md2html.cfg as the configuration file (def: use topdir/inc/md2html.cfg)
			NOTE: -c may only be used in command_options (getopt phase 0)

	-H phase=name	use 'phase.name.html' file for HTML phase named 'phase' (def: use 'phase.default.html')
	-H phase=.	ignore processing for HTML phase 'phase' (def: process HTML phase)
			NOTE: The 'phase' string may not contain = (equal), nor / (slash).
			NOTE: The 'phase.name.html' file is assumed under the 'topdir/inc' directory.

	-b tool		run 'before tool' during HTML phase number 20 (def: do not output before pandoc tool)
	-b .		skip HTML phase number 20 (def: do nothing during HTML phase number 20)
	-B optstr	run 'before tool' with options found in 'optstr' (def: do not add any options to 'before tool')

	-p tool		run 'pandoc tool' wrapper (not path to pandoc) during HTML phase number 21 (def: use inc/pandoc.sh)
	-p .		skip HTML phase number 21 (def: do nothing during HTML phase number 21)
	-P optstr	run 'pandoc tool' with options found in 'optstr' (def: use only the 'pandoc tool' default options)

	-a tool		run 'after tool' during HTML phase number 20 (def: do not output after pandoc tool)
	-a .		skip HTML phase number 22 (def: do nothing during HTML phase number 22)
	-A optstr	run 'after tool' with options found in 'optstr' (def: do not add any options to 'after tool')

	-s token=value	substitute %%token%% with value except in HTML phase numbers 20-29 (def: do not substitute)
			NOTE: The 'token' string may not contain ; (semicolon), nor = (equal), nor % (percent).
			NOTE: The 'value' string may not contain ; (semicolon).
	-S		failure to replace a %%token%% is not an error (def: exit non-zero for non-substituted tokens)

	-o tool		Use output tool, 'tool', to generate option lines (def: do not)
	-o .		disable use of 'output tool' (def: do not use an 'output tool')
			NOTE: -o may only be used in command_options and cfg_options (getopt phases 0 and 1)
	-O tool=optstr	run the 'token replace' named 'tool' with options found in 'optstr' (def: do not add any options)
			NOTE: The 'tool' string may not contain = (equal), nor double-quote, nor single-quote.
			NOTE: -O may only be used in command_options and cfg_options (getopt phases 0 and 1)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	filename_arg

Exit codes:
     0	       all OK
     2	       -h and help string printed or -V and version string printed
     3	       command line error
     4	       bash version is < 4.2
 >= 10 < 200   internal error
 >= 200	       tool error

$NAME version: $VERSION"

##################################
# command line parsing functions #
##################################

# setup global variables
#
# Call this once at the start of the shell script.
#
function global_variable_setup
{
    local n	# loop index

    # setup
    #
    export VERSION="0.1 2023-12-10"
    NAME=$(basename "$0")
    export NAME
    #
    export V_FLAG=0
    export NOOP=0
    export DO_NOT_PROCESS=0
    export TOPDIR
    export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
    export REPO_NAME="temp-test-ioccc"
    export MD2HTML_CFG
    export BEFORE_TOOL
    export BEFORE_TOOL_OPTSTR
    export PANDOC_WRAPPER
    export PANDOC_WRAPPER_OPTSTR
    export AFTER_TOOL
    export AFTER_TOOL_OPTSTR
    unset TOKEN
    declare -Ag TOKEN
    export CAP_S_FLAG
    unset OUTPUT_TOOL
    declare -ag OUTPUT_TOOL
    unset OUTPUT_TOOL_OPTSTR
    declare -Ag OUTPUT_TOOL_OPTSTR

    # determine path to topdir if we are in a git repo
    #
    GIT_TOOL=$(type -P git)
    export GIT_TOOL
    if [[ -z "$GIT_TOOL" ]]; then
	echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
	exit 11
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
    PHASE_NAME=(top head body header topnav begin-row begin-leftcolumn sidenav end-leftcolumn
		end-leftcolumn begin-rightcolumn before-content before-content after-content
		end-row footer bottom)
    unset HTML_PHASE_NAME
    declare -Ag HTML_PHASE_NAME
    for n in "${PHASE_NAME[@]}"; do
	HTML_PHASE_NAME[$n]="default"
    done

    # initialize command line parse pass number
    #
    export GETOPT_PHASE=0
}

# print the usage message, exit code and version information
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

# parse command line arguments
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
#	set -- -s token0=value0 -o inc/foo.sh -O inc/foo.sh="-v 3" -s token1=vaulue1
#	parse_command_line
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
#	# set new command like options and parse them
#	set -- -s token2=value2 -o inc/bar.sh -O inc/bar.sh="-v 1" -s token4=vaulue4
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
    local NAME_VALUE	# name=value string
    local NAME		# name from name=value
    local VALUE		# value from name=value

    # setup that will effectively clear any previous getopts state
    #
    unset OPTIND

    # parse command line
    #
    while getopts :hv:VnNd:c:H:b:B:p:P:a:A:s:So:O:e:E: flag; do
      case "$flag" in
	h) print_usage 1>&2
	    exit 2
	    ;;
	v) V_FLAG="$OPTARG"
	    ;;
	V) echo "$VERSION"
	    exit 2
	    ;;
	n) NOOP="true"
	    ;;
	N) DO_NOT_PROCESS="true"
	    ;;
	d) # -d only in getopt phase 0
	    if [[ $GETOPT_PHASE -gt 0 ]]; then
		echo "$0: ERROR: -d may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    TOPDIR="$OPTARG"
	    ;;
	c) # -c only in getopt phase 0
	    if [[ $GETOPT_PHASE -gt 0 ]]; then
		echo "$0: ERROR: -c may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    MD2HTML_CFG="$OPTARG"
	    ;;
	H) # parse: -H phase=name
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # name cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, name cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # name cannot contain a /
	    if [[ $NAME == *'/'* ]]; then
		echo "$0: ERROR: -H name=value, name cannot contain a / character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # name must be a known phase name
	    if [[ -z ${HTML_PHASE_NAME[$NAME]} ]]; then
		echo "$0: ERROR: -H name=value, name is unknown" 1>&2
		for n in "${PHASE_NAME[@]}"; do
		    echo "$0: notice: valid name: $n"
		done 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
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
	B) BEFORE_TOOL_OPTSTR="$OPTARG"
	    ;;
	p) # parse -p tool
	    if [[ $OPTARG == . ]]; then
		# unset pandoc wrapper tool
		PANDOC_WRAPPER=
	    else
		# change pandoc wrapper tool
		PANDOC_WRAPPER="$OPTARG"
	    fi
	    ;;
	P) BEFORE_TOOL_OPTSTR="$OPTARG"
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
	A) AFTER_TOOL_OPTSTR="$OPTARG"
	    ;;
	s) # parse: -s token=value
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # token cannot contain a ;
	    if [[ $NAME == *';'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a ; character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a %
	    if [[ $NAME == *'%'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a % character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # value cannot contain a ;
	    if [[ $VALUE == *';'* ]]; then
		echo "$0: ERROR: -H name=value, value cannot contain a ; character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # set %%token%% value
	    TOKEN[$NAME]="$VALUE"
	    ;;
	S) CAP_S_FLAG="true"
	    ;;
	o) # -o only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -gt 1 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 1, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    OUTPUT_TOOL+=("$OPTARG")
	    ;;
	O) # -O only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -gt 1 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 1, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    # parse: -O tool=optstr
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # token cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a double-quote
	    if [[ $NAME == *'"'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a double-quote character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a single-quote
	    if [[ $NAME == *'"'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a single-quote character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # set tool optstr value
	    OUTPUT_TOOL_OPTSTR[$NAME]="$VALUE"
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

    # increment command line parse pass number
    #
    ((++GETOPT_PHASE))
}

# required initial variable setup
#
global_variable_setup

##################
# getopt phase 0 #
##################

# process command line arguments
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
    echo "$0: debug[1]: after 1st call to parse_command_line, OPTIND: $OPTIND" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: 1st parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: 1st parse_command_line call expected 1 arg, found: $#" 1>&2
    print_usage 1>&2
    exit 3
fi
#
export FILE="$1"
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: FILE=$FILE" 1>&2
fi

# verify that we have a topdir directory
#
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 12
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 13
fi

# verify that we have in inc directory
#
export INC="$TOPDIR/inc"
if [[ ! -d $TOPDIR/inc ]]; then
    echo "$0: ERROR: inc is not a directory under TOPDIR/inc: $TOPDIR/inc" 1>&2
    exit 14
fi

# verify we have a readable md2html.cfg file
#
if [[ -z $MD2HTML_CFG ]]; then
    MD2HTML_CFG="$INC/md2html.cfg"
fi
if [[ ! -e $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg does not exist: $MD2HTML_CFG" 1>&2
    exit 15
fi
if [[ ! -f $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a file: $MD2HTML_CFG" 1>&2
    exit 16
fi
if [[ ! -r $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a readable file: $MD2HTML_CFG" 1>&2
    exit 17
fi

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 18
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 19
fi
export CD_FAILED
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 20
fi

##################
# getopt phase 1 #
##################

# pretend that $FILE matches a line in md2html.cfg and that this is was the rest of the configuration line
#
set -- -s token0=value0 -o inc/foo.sh -O inc/foo.sh="-v 3" -s token1=vaulue1

# parse the command line arguments
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: after 2nd call to parse_command_line, OPTIND: $OPTIND" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: 2nd parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: 2nd parse_command_line call expected 0 arg, found: $#" 1>&2
    print_usage 1>&2
    exit 3
fi

##################
# getopt phase 2 #
##################

# pretend that the tool:
#
#	inc/foo.sh -v 3
#
# has produced these additional command line options
#
set -- -s token2=value2 -s token3=value3

# parse the new options on the command line
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: after 3rd call to parse_command_line, OPTIND: $OPTIND" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: 3rd parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: 3rd parse_command_line call expected 0 arg, found: $#" 1>&2
    print_usage 1>&2
    exit 3
fi

# report TOKEN sed patterns
#
if [[ $V_FLAG -ge 3 ]]; then
    for n in "${!TOKEN[@]}"; do
	VALUE="${TOKEN[$n]}"
	echo "$0: debug[3]: token replacement: sed -e s;%%$n%%;$VALUE;g" 1>&2
    done
fi

# report output tool and output tool arguments
#
if [[ $V_FLAG -ge 3 ]]; then
    for n in "${!OUTPUT_TOOL[@]}"; do
	VALUE="${OUTPUT_TOOL[$n]}"
	echo "$0: debug[3]: output tool: $VALUE args: ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    done
fi
