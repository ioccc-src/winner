#!/usr/bin/env bash
#
# jval-wrapper.sh - write JSON values to stdout using XPath via python3
#
# By default, this script will print both JSON member and JSON value separated
# by an ASCII tab when processing a JSON member element, keep any enclosing double
# quotes around JSON strings, and keep newlines.
#
# Use '-b' to print values only.
# Use '-e' to print shell-style assignments (tag=value) instead of tab separation.
# Note: '-b' and '-e' are mutually exclusive.
#
# For information on XPath, see:
#
#   https://www.w3.org/TR/xpath/
#
# Copyright (c) 2024-2026 by Landon Curt Noll.  All Rights Reserved.
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


# IOCCC requires use of C locale
#
export LANG="C"
export LC_CTYPE="C"
export LC_NUMERIC="C"
export LC_TIME="C"
export LC_COLLATE="C"
export LC_MONETARY="C"
export LC_MESSAGES="C"
export LC_PAPER="C"
export LC_NAME="C"
export LC_ADDRESS="C"
export LC_TELEPHONE="C"
export LC_MEASUREMENT="C"
export LC_IDENTIFICATION="C"
export LC_ALL="C"


# set variables referenced in the usage message
#
VERSION="2.1.0 2026-11-16"
NAME=$(basename "$0")
V_FLAG=0
#
QUICK_CHECK=""
SORT_KEYS=""
PRESERVE_UTF8=""
PATTERN=""
#
PRINT_ONLY_VALUES=""
SHELL_FORMAT=""
REMOVE_QUOTES=""


# Locate python3 without aborting under 'set -e'
#
PYTHON3_TOOL=$(type -P python3 2>/dev/null || true)
export PYTHON3_TOOL


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N] [-b | -e] [-q] [-p python3] [-P] [-Q] [-s] file.json [pattern]

    -h              print help message and exit
    -v level        set verbosity level (def level: 0)
    -V              print version string and exit

    -n              do nothing (same as -N) (def: do the action)
    -N              do not process file, just parse arguments and ignore the file (def: process the file)

    -b              print only values (def: print both JSON member and JSON value separated by TAB)
    -e              print shell assignment: member=value (def: separated by TAB) (conflicts with -b)
    -q              remove enclosing double quotes (def: keep any enclosing double quotes)

    -p python3      path to the python3 tool (def: $PYTHON3_TOOL)
    -P              preserve literal UTF-8 output (def: non-ASCII characters are re-encoded as ASCII escape sequences)
    -Q              quick check python3 using trivial input and exit, ignore file.json (def: do not)
    -s              canonical key sorting as per RFC 8785 (def: print JSON in the IOCCC JSON style)

    file.json       JSON file to read, - ==> read stdin (ignored if -Q)
    pattern         XPath query pattern (def: .//* or pattern set in \$PATTERN) (ignored if -Q)

Exit codes:
     0         all OK
     1         file or stdin not valid JSON, or invalid XPath pattern
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5         python3 not found
     6         file.json does not exist or is not readable
     7         -Q used, and python3 failed quick check
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
NOOP=
DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:VnNbeqp:PQs flag; do
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
    b) PRINT_ONLY_VALUES="true"
	;;
    e) SHELL_FORMAT="true"
	;;
    q) REMOVE_QUOTES="true"
	;;
    p) PYTHON3_TOOL=$(type -P "$OPTARG" 2>/dev/null || echo "$OPTARG")
	;;
    P) PRESERVE_UTF8="true"
	;;
    Q) QUICK_CHECK="-Q"
	;;
    s) SORT_KEYS="true"
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
#
# check for mutually exclusive options
#
if [[ -n $PRINT_ONLY_VALUES && -n $SHELL_FORMAT ]]; then
    echo "$0: ERROR: -b and -e are mutually exclusive" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
#
# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[5]: argument count: $#" 1>&2
fi
case "$#" in
0) if [[ -z $QUICK_CHECK && -z $DO_NOT_PROCESS ]]; then
        echo "$0: ERROR: 0 args allowed only with -Q or -N" 1>&2
        echo "$USAGE" 1>&2
        exit 3
   fi
   ;;
1) JSON_FILE="$1"
   ;;
2) JSON_FILE="$1"
   PATTERN="$2"
   ;;
*) echo "$0: ERROR: expected 1 or 2 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
#
# Default PATTERN if not provided on CLI or environment
#
if [[ -z $PATTERN ]]; then
    PATTERN=".//*"
fi
#
# Canonicalize $JSON_FILE to an absolute path
#
if [[ $JSON_FILE == "-" ]]; then
    JSON_FILE=""
elif [[ -n "$JSON_FILE" && "$JSON_FILE" != /* ]]; then
    JSON_FILE="$PWD/$JSON_FILE"
fi
#
# Verify $JSON_FILE readability
#
if [[ -n "$JSON_FILE" ]]; then
    if [[ ! -f "$JSON_FILE" ]]; then
        echo "$0: ERROR: JSON_FILE is not a regular file: $JSON_FILE" 1>&2
        exit 6
    fi
    if [[ ! -r "$JSON_FILE" ]]; then
        echo "$0: ERROR: JSON_FILE is not a readable file: $JSON_FILE" 1>&2
        exit 6
    fi
fi


# verify a python3 tool
#
if [[ -z "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
fi
if [[ ! -f "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 is not a file: $PYTHON3_TOOL" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
fi
if [[ ! -x "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 is not an executable file: $PYTHON3_TOOL" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
fi


# print running info if verbose
#
# If -v 3 or higher, print variables in order
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: LANG=$LANG" 1>&2
    echo "$0: debug[3]: LC_CTYPE=$LC_CTYPE" 1>&2
    echo "$0: debug[3]: LC_NUMERIC=$LC_NUMERIC" 1>&2
    echo "$0: debug[3]: LC_TIME=$LC_TIME" 1>&2
    echo "$0: debug[3]: LC_COLLATE=$LC_COLLATE" 1>&2
    echo "$0: debug[3]: LC_MONETARY=$LC_MONETARY" 1>&2
    echo "$0: debug[3]: LC_MESSAGES=$LC_MESSAGES" 1>&2
    echo "$0: debug[3]: LC_PAPER=$LC_PAPER" 1>&2
    echo "$0: debug[3]: LC_NAME=$LC_NAME" 1>&2
    echo "$0: debug[3]: LC_ADDRESS=$LC_ADDRESS" 1>&2
    echo "$0: debug[3]: LC_TELEPHONE=$LC_TELEPHONE" 1>&2
    echo "$0: debug[3]: LC_MEASUREMENT=$LC_MEASUREMENT" 1>&2
    echo "$0: debug[3]: LC_IDENTIFICATION=$LC_IDENTIFICATION" 1>&2
    echo "$0: debug[3]: LC_ALL=$LC_ALL" 1>&2
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: QUICK_CHECK=$QUICK_CHECK" 1>&2
    echo "$0: debug[3]: SORT_KEYS=$SORT_KEYS" 1>&2
    echo "$0: debug[3]: PRESERVE_UTF8=$PRESERVE_UTF8" 1>&2
    echo "$0: debug[3]: PATTERN=$PATTERN" 1>&2
    echo "$0: debug[3]: PRINT_ONLY_VALUES=$PRINT_ONLY_VALUES" 1>&2
    echo "$0: debug[3]: SHELL_FORMAT=$SHELL_FORMAT" 1>&2
    echo "$0: debug[3]: REMOVE_QUOTES=$REMOVE_QUOTES" 1>&2
    echo "$0: debug[3]: PYTHON3_TOOL=$PYTHON3_TOOL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
fi


# if -Q, verify we have a functional python3 tool that can process JSON and XPath
#
if [[ -n $QUICK_CHECK ]]; then

    # try python3 tool on a trivial JSON and XPath check
    #
    CANARY_CHECK=$("$PYTHON3_TOOL" -c '
import sys, json, re, xml.etree.ElementTree as ET
try:
    d = json.loads("{\"status\":\"ok\",\"curds\":\"whey²\"}")
    root = ET.Element("root")
    for k, v in d.items():
        child = ET.SubElement(root, k)
        child.text = str(v)
    tree = ET.ElementTree(root)
    node = tree.find(".//status")
    if node is not None and node.text == "ok":
        print("verified")
        sys.exit(0)
    sys.exit(1)
except Exception as e:
    sys.stderr.write(str(e) + "\n")
    sys.exit(1)
' 2>&1)
    status="$?"
    if [[ $status -ne 0 || "$CANARY_CHECK" != "verified" ]]; then
	echo "$0: FATAL: python3 failed standard library validation for json/ElementTree: $PYTHON3_TOOL" 1>&2
	echo "$0: CANARY_CHECK starts below" 1>&2
	echo "$CANARY_CHECK" 1>&2
	echo "$0: CANARY_CHECK ends above" 1>&2
	echo "$0: notice: perhaps python3 import sys, json, re, or xml.etree.ElementTree failed?" 1>&2
	exit 7
    fi

    # report success if verbose
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: python3 tool on a trivial JSON and XPath check passed" 1>&2
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: CANARY_CHECK starts below" 1>&2
	    echo "$CANARY_CHECK" 1>&2
	    echo "$0: debug[3]: CANARY_CHECK ends above" 1>&2
	fi
    fi
    exit 0
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# -n means we have nothing to do
#
if [[ -n $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[3]: -n given, nothing to do, exiting 0" 1>&2
    fi
    exit 0
fi


# extract value(s) from JSON on stdin or from a file
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: executing python3 XPath extractor (file: ${JSON_FILE:-stdin}, pattern: $PATTERN)" 1>&2
fi
#
export JVAL_PATTERN="$PATTERN"
export JVAL_ONLY_VALUES="$PRINT_ONLY_VALUES"
export JVAL_SHELL_FORMAT="$SHELL_FORMAT"
export JVAL_REMOVE_QUOTES="$REMOVE_QUOTES"
export JVAL_SORT_KEYS="$SORT_KEYS"
export JVAL_PRESERVE_UTF8="$PRESERVE_UTF8"
#
"$PYTHON3_TOOL" -c '
import sys, os, json, re
import xml.etree.ElementTree as ET

pattern = os.environ.get("JVAL_PATTERN", ".//*")
only_values = bool(os.environ.get("JVAL_ONLY_VALUES", ""))
shell_format = bool(os.environ.get("JVAL_SHELL_FORMAT", ""))
remove_quotes = bool(os.environ.get("JVAL_REMOVE_QUOTES", ""))
sort_keys = bool(os.environ.get("JVAL_SORT_KEYS", ""))
ensure_ascii = not bool(os.environ.get("JVAL_PRESERVE_UTF8", ""))

# Read input JSON
try:
  if len(sys.argv) > 1 and sys.argv[1]:
    with open(sys.argv[1], "r", encoding="utf-8") as f:
      data = json.load(f)
  else:
    data = json.load(sys.stdin)
except Exception as e:
  sys.stderr.write(f"JSON parse error: {e}\n")
  sys.exit(1)

node_counter = 0
val_map = {}

def sanitize_tag(name):
  # Replace characters that are invalid in XML element tags with underscores
  s = re.sub(r"[^a-zA-Z0-9_\-\.]", "_", str(name))
  if not s or (not s[0].isalpha() and s[0] != "_"):
    s = "_" + s
  return s

def json_to_xml(tag_name, val):
  global node_counter
  xml_tag = sanitize_tag(tag_name)
  elem = ET.Element(xml_tag)
  node_counter += 1
  elem.set("_nid", str(node_counter))
  val_map[str(node_counter)] = (str(tag_name), val)

  if isinstance(val, dict):
    for k, v in val.items():
      elem.append(json_to_xml(k, v))
  elif isinstance(val, list):
    for item in val:
      elem.append(json_to_xml("item", item))
  else:
    if val is None:
      elem.text = "null"
    elif isinstance(val, bool):
      elem.text = "true" if val else "false"
    else:
      elem.text = str(val)
  return elem

def format_val(val):
  if isinstance(val, str):
    s = json.dumps(val, ensure_ascii=ensure_ascii)
    if remove_quotes and len(s) >= 2 and s[0] == "\"" and s[-1] == "\"":
      return s[1:-1]
    return s
  elif isinstance(val, (dict, list)):
    return json.dumps(val, indent=4, separators=(",", " : "), sort_keys=sort_keys, ensure_ascii=ensure_ascii)
  elif val is None:
    return "null"
  elif isinstance(val, bool):
    return "true" if val else "false"
  else:
    return str(val)

root = json_to_xml("root", data)
tree = ET.ElementTree(root)

try:
  matches = tree.findall(pattern)
except Exception as e:
  sys.stderr.write(f"XPath evaluation error: {e}\n")
  sys.exit(1)

for node in matches:
  nid = node.get("_nid")
  orig_tag, val = val_map.get(nid, (node.tag, node.text))
  formatted = format_val(val)
  if only_values:
    print(formatted)
  elif shell_format:
    print(f"{orig_tag}={formatted}")
  else:
    # Default: print original tag and value separated by an ASCII tab
    if remove_quotes:
      tag_str = orig_tag
    else:
      tag_str = json.dumps(orig_tag, ensure_ascii=ensure_ascii)
    print(f"{tag_str}\t{formatted}")
' "$JSON_FILE"
status="$?"
if [[ $status -ne 0 ]]; then
    if [[ -n "$JSON_FILE" ]]; then
        echo "$0: ERROR: invalid JSON or XPath pattern error: $JSON_FILE" 1>&2
    else
        echo "$0: ERROR: stdin appears to not be valid JSON or XPath pattern error" 1>&2
    fi
    exit 1
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
