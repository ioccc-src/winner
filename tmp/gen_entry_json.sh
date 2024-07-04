#!/usr/bin/env bash
#
# gen_entry_json.sh - generate .entry.json for an entry
#
# XXX - This is a temporary utility that will be replaced when
#	the .entry.json files are built.
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

# setup
#
export VERSION="1.1 2024-01-14"
NAME=$(basename "$0"); export NAME
export DOT_ENTRY_JSON_BASENAME=".entry.json"
export ENTRY_JSON_FORMAT_VERSION="1.1 2024-02-11"
export NO_COMMENT="mandatory comment: because comments were removed from the original JSON spec"
export AUTHOR_WINS_CSV="author_wins.csv"
export YEAR_PRIZE_CSV="year_prize.csv"
export MANIFEST_CSV="manifest.csv"
export PANDOC="/opt/homebrew/bin/pandoc"
#
export V_FLAG=0
export DOMAIN="ioccc-src.github.io"
export DOCPATH="/temp-test-ioccc"
export GITHUB_REPO="https://github.com/ioccc-src/temp-test-ioccc/blob/master"
export TOPDIR=".."

# usage
#
export USAGE="usage: $0 [-h] [-v level]
	[-d www.domain.org] [-p /path/to/docroot] [-g github_url ] [-t topdir] [-P /path/to/pandoc]
	year[/dir] [dir]

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)

	-d www.domain.org	change domain (def: $DOMAIN)
	-p /path/to/docroot	use path under domain to document root (def: $DOCPATH)
	-g github_url		path to the GitHub repo (def: $GITHUB_REPO)
	-t topdir		path to top of the local tree (def: $TOPDIR)
	-P /path/to/pandoc	path to the pandoc tool (def: $PANDOC)

	year[/dir]		path ton entry directory (or just year if there is a path arg
	[dir]			optionaln entry directory (1st arg is just year)

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find writablen entry directory
     5	    cannot find readable author_wins.csv
     6	    cannot find readable year_prize.csv
     7	    cannot find readable manifest.csv
     8	    cannot find pandoc executable
     9	    cannot determine the award for year/dir
    10	    cannot determine authors of year/dir
 >= 20	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:d:p:g:t:P: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    d) DOMAIN="$OPTARG"
	;;
    p) DOCPATH="$OPTARG"
	;;
    g) GITHUB_REPO="$OPTARG"
	;;
    t) TOPDIR="$OPTARG"
	;;
    P) PANDOC="$OPTARG"
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
# remove the options
#
shift $(( OPTIND - 1 ));
#
# verify arg count and parse args
#
export ENTRY_PATH
export YEAR
export ENTRY
case "$#" in
1) ENTRY_PATH="$1"
   YEAR="${ENTRY_PATH%/*}"
   ENTRY="${ENTRY_PATH#*/}"
   ;;
2) ENTRY_PATH="$1/$2"
   YEAR="$1"
   ENTRY="$2"
   ;;
*) echo "$0: ERROR: expected 1 or 2 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
export FULL_ENTRY_PATH="$TOPDIR/$ENTRY_PATH"
export ENTRY_ID="${YEAR}_${ENTRY}"

export URL_PATH="https://$DOMAIN$DOCPATH/$YEAR/$ENTRY"

# setup temporary files
#
export ENTRY_JSON_PATH="$FULL_ENTRY_PATH/$DOT_ENTRY_JSON_BASENAME"
export TMP_DOT_ENTRY_JSON="$FULL_ENTRY_PATH/tmp.$$.$DOT_ENTRY_JSON_BASENAME"
trap 'rm -f $TMP_DOT_ENTRY_JSON' 0 1 2 3 15

# print running info if verbose
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[5]: NAME=$NAME" 1>&2
    echo "$0: debug[5]: VERSION=$VERSION" 1>&2
    echo "$0: debug[5]: ENTRY_JSON_FORMAT_VERSION=$ENTRY_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[5]: NO_COMMENT=$NO_COMMENT" 1>&2
    echo "$0: debug[5]: AUTHOR_WINS_CSV=$AUTHOR_WINS_CSV" 1>&2
    echo "$0: debug[5]: YEAR_PRIZE_CSV=$YEAR_PRIZE_CSV" 1>&2
    echo "$0: debug[5]: MANIFEST_CSV=$MANIFEST_CSV" 1>&2
    echo "$0: debug[5]: DOMAIN=$DOMAIN" 1>&2
    echo "$0: debug[5]: DOCPATH=$DOCPATH" 1>&2
    echo "$0: debug[5]: GITHUB_REPO=$GITHUB_REPO" 1>&2
    echo "$0: debug[5]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[5]: PANDOC=$PANDOC" 1>&2
    echo "$0: debug[5]: FULL_ENTRY_PATH=$FULL_ENTRY_PATH" 1>&2
    echo "$0: debug[5]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[5]: YEAR=$YEAR" 1>&2
    echo "$0: debug[5]: ENTRY=$ENTRY" 1>&2
    echo "$0: debug[5]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[5]: URL_PATH=$URL_PATH" 1>&2
    echo "$0: debug[5]: DOT_ENTRY_JSON_BASENAME=$DOT_ENTRY_JSON_BASENAME" 1>&2
    echo "$0: debug[5]: ENTRY_JSON_PATH=$ENTRY_JSON_PATH" 1>&2
    echo "$0: debug[5]: TMP_DOT_ENTRY_JSON=$TMP_DOT_ENTRY_JSON" 1>&2
fi

# make is easier to process CSV files
#
IFS="$IFS,"

# verify entry directory is writable
#
if [[ ! -e $FULL_ENTRY_PATH ]]; then
    echo  "$0: ERROR: FULL_ENTRY_PATH does not exist: $FULL_ENTRY_PATH" 1>&2
    exit 4
fi
if [[ ! -d $FULL_ENTRY_PATH ]]; then
    echo  "$0: ERROR: FULL_ENTRY_PATH is not a directory: $FULL_ENTRY_PATH" 1>&2
    exit 4
fi
if [[ ! -w $FULL_ENTRY_PATH ]]; then
    echo  "$0: ERROR: FULL_ENTRY_PATH is not a writable directory: $FULL_ENTRY_PATH" 1>&2
    exit 4
fi

# verify author_wins.csv is readable
#
if [[ ! -e $AUTHOR_WINS_CSV ]]; then
    echo  "$0: ERROR: AUTHOR_WINS_CSV does not exist: $AUTHOR_WINS_CSV" 1>&2
    exit 5
fi
if [[ ! -f $AUTHOR_WINS_CSV ]]; then
    echo  "$0: ERROR: AUTHOR_WINS_CSV is not a file: $AUTHOR_WINS_CSV" 1>&2
    exit 5
fi
if [[ ! -r $AUTHOR_WINS_CSV ]]; then
    echo  "$0: ERROR: AUTHOR_WINS_CSV is not a readable file: $AUTHOR_WINS_CSV" 1>&2
    exit 5
fi

# verify year_prize.csv is readable
#
if [[ ! -e $YEAR_PRIZE_CSV ]]; then
    echo  "$0: ERROR: YEAR_PRIZE_CSV does not exist: $YEAR_PRIZE_CSV" 1>&2
    exit 6
fi
if [[ ! -f $YEAR_PRIZE_CSV ]]; then
    echo  "$0: ERROR: YEAR_PRIZE_CSV is not a file: $YEAR_PRIZE_CSV" 1>&2
    exit 6
fi
if [[ ! -r $YEAR_PRIZE_CSV ]]; then
    echo  "$0: ERROR: YEAR_PRIZE_CSV is not a readable file: $YEAR_PRIZE_CSV" 1>&2
    exit 6
fi

# verify manifest.csv is readable
#
if [[ ! -e $MANIFEST_CSV ]]; then
    echo  "$0: ERROR: MANIFEST_CSV does not exist: $MANIFEST_CSV" 1>&2
    exit 7
fi
if [[ ! -f $MANIFEST_CSV ]]; then
    echo  "$0: ERROR: MANIFEST_CSV is not a file: $MANIFEST_CSV" 1>&2
    exit 7
fi
if [[ ! -r $MANIFEST_CSV ]]; then
    echo  "$0: ERROR: MANIFEST_CSV is not a readable file: $MANIFEST_CSV" 1>&2
    exit 7
fi

# verify we have a pandoc executable
#
if [[ ! -x $PANDOC ]]; then
    echo  "$0: ERROR: pandoc executable not found: $PANDOC" 1>&2
    exit 8
fi

# determine award
#
AWARD=$(grep -E "^$ENTRY_ID," "$YEAR_PRIZE_CSV" | sed -e "s/^$ENTRY_ID,//")
export AWARD
if [[ -z $AWARD ]]; then
    echo "$0: ERROR: cannot find award for $ENTRY_ID in $YEAR_PRIZE_CSV" 1>&2
    exit 9
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: AWARD for $ENTRY_ID: $AWARD" 1>&2
fi

# determine author set
#
AUTHOR_SET=$(grep -E ",$ENTRY_ID," "$AUTHOR_WINS_CSV")
declare -a AUTHOR
while read -r author extra; do
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: $ENTRY_ID extra: $extra"
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: $ENTRY_ID author: $author"
    fi
    if [[ -z $author ]]; then
	echo "$0: ERROR: $ENTRY_ID empty author found in $AUTHOR_WINS_CSV with extra: $extra" 1>&2
	exit 10
    fi
    AUTHOR+=( "$author" )
done <<< "$AUTHOR_SET"
export AUTHOR_COUNT=${#AUTHOR[@]}
if [[ $AUTHOR_COUNT -le 0 ]]; then
    echo "$0: ERROR: cannot find any authors for $ENTRY_ID" 1>&2
    exit 10
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: author count for $ENTRY_ID: $AUTHOR_COUNT"
fi

# collect inventory
#
NUMBER_RANKED_MANIFEST_SET=$(grep -E "^$YEAR,$ENTRY,[^,][^,]*,[0-9]" "$MANIFEST_CSV" | sort -t, -k4n)
declare -a FILE_PATH INVENTORY_ORDER OK_TO_EDIT DISPLAY_AS DISPLAY_VIA_GITHUB ENTRY_TEXT
#
# process inventory with a numerical inventory_order
#
while IFS=, read -r year dir file_path inventory_order OK_to_edit display_as display_via_github entry_text extra; do

        # firewall - year dir much match
	#
	if [[ $YEAR != "$year" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$ENTRY inventory_order: $inventory_order YEAR: $YEAR != $year" 1>&2
	    exit 30
	fi
	if [[ $ENTRY != "$dir" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$ENTRY inventory_order: $inventory_order ENTRY: $ENTRY != $dir" 1>&2
	    exit 31
	fi
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: found: year: $year dir: $dir inventory_order: $inventory_order file_path: $file_path" 1>&2
	    echo "$0: debug[7]:  also: display_as: $display_as display_via_github: $display_via_github" 1>&2
	    echo "$0: debug[7]:   and: entry_text: $entry_text extra: $extra" 1>&2
	fi

	# firewall - nothing except extra should be empty
	#
	if [[ -z $file_path ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty file_path" 1>&2
	    exit 32
	fi
	if [[ -z $inventory_order ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty inventory_order" 1>&2
	    exit 33
	fi
	if [[ -z $OK_to_edit ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty OK_to_edit" 1>&2
	    exit 34
	fi
	if [[ -z $display_as ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty display_as" 1>&2
	    exit 37
	fi
	if [[ -z $display_via_github ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty display_via_github" 1>&2
	    exit 38
	fi
	if [[ -z $entry_text ]]; then
	    echo "$0: ERROR: ^$YEAR,$ENTRY inventory_order: $inventory_order empty entry_text" 1>&2
	    exit 39
	fi

	# save inventory information
	#
	FILE_PATH+=( "$file_path" )
	INVENTORY_ORDER+=( "$inventory_order" )
	OK_TO_EDIT+=( "$OK_to_edit" )
	DISPLAY_AS+=( "$display_as" )
	DISPLAY_VIA_GITHUB+=( "$display_via_github" )
	ENTRY_TEXT+=( "$entry_text" )
done <<< "$NUMBER_RANKED_MANIFEST_SET"
export FILE_COUNT=${#FILE_PATH[@]}
if [[ $FILE_COUNT -le 0 ]]; then
    echo "$0: ERROR: cannot find files in manifest $MANIFEST_CSV for $ENTRY_ID" 1>&2
    exit 50
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: manifest file count for $ENTRY_ID: $FILE_COUNT"
fi

# write .entry.json
#
# write leading part of .entry.json
#
cat > "$TMP_DOT_ENTRY_JSON" << EOF
{
    "no_comment" : "$NO_COMMENT",
    "entry_JSON_format_version" : "$ENTRY_JSON_FORMAT_VERSION",
    "award" : "$AWARD",
    "year" : $YEAR,
    "dir" : "$ENTRY",
    "entry_id" : "$ENTRY_ID",
    "author_set" : [
EOF
#
# write author_handle part of .entry.json
#
((AUTHOR_COUNT_LESS_1=AUTHOR_COUNT-1))
for i in "${!AUTHOR[@]}"; do
    # stupid JSON syntax does not allow a trailing comma
    if [[ $i -lt "$AUTHOR_COUNT_LESS_1" ]]; then
	cat >> "$TMP_DOT_ENTRY_JSON" << EOF
	{ "author_handle" : "${AUTHOR[$i]}" },
EOF
    else
	cat >> "$TMP_DOT_ENTRY_JSON" << EOF
	{ "author_handle" : "${AUTHOR[$i]}" }
EOF
    fi
done
#
# write start of manifest of .entry.json
#
cat >> "$TMP_DOT_ENTRY_JSON" << EOF
    ],
    "manifest" : [
EOF
((FILE_COUNT_LESS_1=FILE_COUNT-1))
#
# write each file in the manifest of .entry.json
#
for i in "${!INVENTORY_ORDER[@]}"; do

    #
    # write start and file_path of a given file in manifest of .entry.json
    # write inventory_order of a given file in manifest of .entry.json
    # write OK_to_edit of a given file in manifest of .entry.json
    # write display_as of a given file in manifest of .entry.json
    # write display_via_github of a given file in manifest of .entry.json
    # write entry_text of a given file in manifest of .entry.json
    #
    cat >> "$TMP_DOT_ENTRY_JSON" << EOF
	{
	    "file_path" : "${FILE_PATH[$i]}",
	    "inventory_order" : ${INVENTORY_ORDER[$i]},
	    "OK_to_edit" : ${OK_TO_EDIT[$i]},
	    "display_as" : "${DISPLAY_AS[$i]}",
	    "display_via_github" : ${DISPLAY_VIA_GITHUB[$i]},
	    "entry_text" : "${ENTRY_TEXT[$i]}"
EOF

    # stupid JSON syntax does not allow a trailing comma
    if [[ $i -lt "$FILE_COUNT_LESS_1" ]]; then
	cat >> "$TMP_DOT_ENTRY_JSON" << EOF
	},
EOF
    else
	cat >> "$TMP_DOT_ENTRY_JSON" << EOF
	}
EOF
    fi
done

#
# write trailing part of .entry.json
#
cat >> "$TMP_DOT_ENTRY_JSON" << EOF
    ]
}
EOF
if [[ $V_FLAG -ge 7 ]]; then
    echo "$0: debug[7]: start of TMP_DOT_ENTRY_JSON below: $TMP_DOT_ENTRY_JSON" 1>&2
cat "$TMP_DOT_ENTRY_JSON" 1>&2
    echo "$0: debug[7]: end of TMP_DOT_ENTRY_JSON above: $TMP_DOT_ENTRY_JSON" 1>&2
fi

# update .entry.json if needed
#
if ! cmp -s "$TMP_DOT_ENTRY_JSON" "$ENTRY_JSON_PATH"; then

    # replace index.html file
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: updating $ENTRY_JSON_PATH"
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	mv -f -v "$TMP_DOT_ENTRY_JSON" "$ENTRY_JSON_PATH"
	status="$?"
    else
	mv -f "$TMP_DOT_ENTRY_JSON" "$ENTRY_JSON_PATH"
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_DOT_ENTRY_JSON $ENTRY_JSON_PATH failed, error: $status" 1>&2
	exit 100
    fi

else

    # index.html is OK, remove the tmp file
    #
    rm -f "$TMP_DOT_ENTRY_JSON"
    if [[ -e $TMP_DOT_ENTRY_JSON ]]; then
	echo "$0: ERROR: TMP_DOT_ENTRY_JSON cannot be removed for cleanup: $TMP_DOT_ENTRY_JSON" 1>&2
	exit 101
    fi
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
