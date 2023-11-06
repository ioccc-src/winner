#!/usr/bin/env bash
#
# gen_dot_winner.sh - generate .winner.json and .inventory.html for a winner
#
# XXX - This is a temporary utility that will be replaced when
#	the .winner.json files are built
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

# setup
#
export VERSION="1.0.1 2023-11-06"
NAME=$(basename "$0"); export NAME
export DOT_WINNER_JSON_BASENAME=".winner.json"
export DOT_INVENTORY_MD_BASENAME=".inventory.md"
export DOT_INVENTORY_HTML_BASENAME=".inventory.html"
export WINNER_JSON_FORMAT_VERSION="0.5 2023-11-04"
export NO_COMMENT="mandatory comment: because comments were removed from the original JSON spec"
export AUTHOR_WINS_CSV="author_wins.csv"
export YEAR_PRIZE_CSV="year_prize.csv"
export MANIFEST_CSV="manifest.csv"
export PANDOC="/opt/homebrew/bin/pandoc"
#
export V_FLAG=0
export DOMAIN="ioccc-src.github.io"
export DOCPATH="/temp-test-ioccc"
export GITHUB_REPO="https://github.com/ioccc-src/temp-test-ioccc"
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
	-t topdir		path to top of the local GitHub repo tree (def: $TOPDIR)
	-P /path/to/pandoc	path to the pandoc tool (def: $PANDOC)

	year[/dir]		path to winner directory (or just year if there is a path arg
	[dir]			optional winner directory (1st arg is just year)

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find writable winner directory
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
export WINNER_PATH
export YEAR
export WINNER
case "$#" in
1) WINNER_PATH="$1"
   YEAR="${WINNER_PATH%/*}"
   WINNER="${WINNER_PATH#*/}"
   ;;
2) WINNER_PATH="$1/$2"
   YEAR="$1"
   WINNER="$2"
   ;;
*) echo "$0: ERROR: expected 1 or 2 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
export FULL_WINNER_PATH="$TOPDIR/$WINNER_PATH"
export WINNER_ID="${YEAR}_${WINNER}"

# form full DOT_INVENTORY_HTML_URL
#
export URL_PATH="https://$DOMAIN$DOCPATH/$YEAR/$WINNER"
export DOT_INVENTORY_HTML_URL="$URL_PATH/$DOT_INVENTORY_HTML_BASENAME"
export GITHUB_URL_PATH="$GITHUB_REPO/$YEAR/$WINNER"
export GITHUB_URL="$GITHUB_URL_PATH/$DOT_INVENTORY_HTML_BASENAME"

# form Nu Html Checker doc url string
#
VALIDATOR_ENCODED_URL=$(echo "$DOT_INVENTORY_HTML_URL" | sed -e 's;/;%2F;g' -e 's;:;%3A;')
export VALIDATOR_ENCODED_URL

# setup temporary files
#
export WINNER_JSON_PATH="$FULL_WINNER_PATH/$DOT_WINNER_JSON_BASENAME"
export TMP_DOT_WINNER_JSON="$FULL_WINNER_PATH/tmp.$$.$DOT_WINNER_JSON_BASENAME"
export TMP_DOT_INVENTORY_MD="$FULL_WINNER_PATH/tmp.$$.$DOT_INVENTORY_MD_BASENAME"
export DOT_INVENTORY_HTML_PATH="$FULL_WINNER_PATH/$DOT_INVENTORY_HTML_BASENAME"
export TMP_DOT_INVENTORY_HTML="$FULL_WINNER_PATH/tmp.$$.$DOT_INVENTORY_HTML_BASENAME"
trap 'rm -f $TMP_DOT_WINNER_JSON $TMP_DOT_INVENTORY_MD $TMP_DOT_INVENTORY_HTML' 0 1 2 3 15

# print running info if verbose
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[5]: NAME=$NAME" 1>&2
    echo "$0: debug[5]: VERSION=$VERSION" 1>&2
    echo "$0: debug[5]: WINNER_JSON_FORMAT_VERSION=$WINNER_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[5]: NO_COMMENT=$NO_COMMENT" 1>&2
    echo "$0: debug[5]: AUTHOR_WINS_CSV=$AUTHOR_WINS_CSV" 1>&2
    echo "$0: debug[5]: YEAR_PRIZE_CSV=$YEAR_PRIZE_CSV" 1>&2
    echo "$0: debug[5]: MANIFEST_CSV=$MANIFEST_CSV" 1>&2
    echo "$0: debug[5]: GITHUB_URL_PATH=$GITHUB_URL_PATH" 1>&2
    echo "$0: debug[5]: GITHUB_URL=$GITHUB_URL" 1>&2
    echo "$0: debug[5]: DOMAIN=$DOMAIN" 1>&2
    echo "$0: debug[5]: DOCPATH=$DOCPATH" 1>&2
    echo "$0: debug[5]: GITHUB_REPO=$GITHUB_REPO" 1>&2
    echo "$0: debug[5]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[5]: PANDOC=$PANDOC" 1>&2
    echo "$0: debug[5]: FULL_WINNER_PATH=$FULL_WINNER_PATH" 1>&2
    echo "$0: debug[5]: WINNER_ID=$WINNER_ID" 1>&2
    echo "$0: debug[5]: YEAR=$YEAR" 1>&2
    echo "$0: debug[5]: WINNER=$WINNER" 1>&2
    echo "$0: debug[5]: WINNER_PATH=$WINNER_PATH" 1>&2
    echo "$0: debug[5]: URL_PATH=$URL_PATH" 1>&2
    echo "$0: debug[5]: DOT_INVENTORY_MD_BASENAME=$DOT_INVENTORY_MD_BASENAME" 1>&2
    echo "$0: debug[5]: DOT_INVENTORY_HTML_BASENAME=$DOT_INVENTORY_HTML_BASENAME" 1>&2
    echo "$0: debug[5]: DOT_INVENTORY_HTML_URL=$DOT_INVENTORY_HTML_URL" 1>&2
    echo "$0: debug[5]: VALIDATOR_ENCODED_URL=$VALIDATOR_ENCODED_URL" 1>&2
    echo "$0: debug[5]: DOT_WINNER_JSON_BASENAME=$DOT_WINNER_JSON_BASENAME" 1>&2
    echo "$0: debug[5]: WINNER_JSON_PATH=$WINNER_JSON_PATH" 1>&2
    echo "$0: debug[5]: TMP_DOT_WINNER_JSON=$TMP_DOT_WINNER_JSON" 1>&2
    echo "$0: debug[5]: DOT_INVENTORY_HTML_PATH=$DOT_INVENTORY_HTML_PATH" 1>&2
    echo "$0: debug[5]: TMP_DOT_INVENTORY_MD=$TMP_DOT_INVENTORY_MD" 1>&2
    echo "$0: debug[5]: TMP_DOT_INVENTORY_HTML=$TMP_DOT_INVENTORY_HTML" 1>&2
fi

# make is easier to process CSV files
#
IFS="$IFS,"

# verify winner directory is writable
#
if [[ ! -e $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH does not exist: $FULL_WINNER_PATH" 1>&2
    exit 4
fi
if [[ ! -d $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH is not a directory: $FULL_WINNER_PATH" 1>&2
    exit 4
fi
if [[ ! -w $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH is not a writable directory: $FULL_WINNER_PATH" 1>&2
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
AWARD=$(grep -E "^$WINNER_ID," "$YEAR_PRIZE_CSV" | sed -e "s/^$WINNER_ID,//")
export AWARD
if [[ -z $AWARD ]]; then
    echo "$0: ERROR: cannot find award for $WINNER_ID in $YEAR_PRIZE_CSV" 1>&2
    exit 9
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: AWARD for $WINNER_ID: $AWARD" 1>&2
fi

# determine author set
#
AUTHOR_SET=$(grep -E ",$WINNER_ID," "$AUTHOR_WINS_CSV")
declare -a AUTHOR
while read -r author extra; do
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: $WINNER_ID extra: $extra"
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: $WINNER_ID author: $author"
    fi
    if [[ -z $author ]]; then
	echo "$0: ERROR: $WINNER_ID empty author found in $AUTHOR_WINS_CSV with extra: $extra" 1>&2
	exit 10
    fi
    AUTHOR+=( "$author" )
done <<< "$AUTHOR_SET"
export AUTHOR_COUNT=${#AUTHOR[@]}
if [[ $AUTHOR_COUNT -le 0 ]]; then
    echo "$0: ERROR: cannot find any authors for $WINNER_ID" 1>&2
    exit 10
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: author count for $WINNER_ID: $AUTHOR_COUNT"
fi

# collect inventory
#
NUMBER_RANKED_MANIFEST_SET=$(grep -E "^$YEAR,$WINNER,[^,][^,]*,[0-9]" "$MANIFEST_CSV" | sort -t, -k4n)
declare -a FILE_PATH WINNERS_RANK CREATED_BY PROG FILETYPE WINNER_SHOW DISPLAY_VIA WINNER_TEXT
#
# process inventory with a numerical winners_rank
#
while IFS=, read -r year dir file_path winners_rank created_by prog filetype winners_show display_via winners_text extra; do

        # firewall - year dir much match
	#
	if [[ $YEAR != "$year" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$WINNER winners_rank: $winners_rank YEAR: $YEAR != $year" 1>&2
	    exit 30
	fi
	if [[ $WINNER != "$dir" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$WINNER winners_rank: $winners_rank WINNER: $WINNER != $dir" 1>&2
	    exit 31
	fi
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: found: year: $year dir: $dir winners_rank: $winners_rank file_path: $file_path" 1>&2
	    echo "$0: debug[7]:  also: prog: $prog filetype: $filetype winners_show: $winners_show" 1>&2
	    echo "$0: debug[7]:   and: display_via: $display_via winners_text: $winners_text extra: $extra" 1>&2
	fi

	# firewall - nothing except extra should be empty
	#
	if [[ -z $file_path ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty file_path" 1>&2
	    exit 32
	fi
	if [[ -z $winners_rank ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_rank" 1>&2
	    exit 33
	fi
	if [[ -z $created_by ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty created_by" 1>&2
	    exit 34
	fi
	if [[ -z $prog ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty prog" 1>&2
	    exit 35
	fi
	if [[ -z $filetype ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty filetype" 1>&2
	    exit 36
	fi
	if [[ -z $winners_show ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_show" 1>&2
	    exit 37
	fi
	if [[ -z $display_via ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty display_via" 1>&2
	    exit 38
	fi
	if [[ -z $winners_text ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_text" 1>&2
	    exit 39
	fi

	# save inventory information
	#
	FILE_PATH+=( "$file_path" )
	WINNERS_RANK+=( "$winners_rank" )
	CREATED_BY+=( "$created_by" )
	PROG+=( "$prog" )
	FILETYPE+=( "$filetype" )
	WINNER_SHOW+=( "$winners_show" )
	DISPLAY_VIA+=( "$display_via" )
	WINNER_TEXT+=( "$winners_text" )
done <<< "$NUMBER_RANKED_MANIFEST_SET"
#
# process inventory with a null winners_rank
#
NULL_RANKED_MANIFEST_SET=$(grep -E "^$YEAR,$WINNER,[^,][^,]*,null," "$MANIFEST_CSV" | sort)
while IFS=, read -r year dir file_path winners_rank created_by prog filetype winners_show display_via winners_text extra; do

        # firewall - year dir much match
	#
	if [[ $YEAR != "$year" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$WINNER winners_rank: $winners_rank YEAR: $YEAR != $year" 1>&2
	    exit 40
	fi
	if [[ $WINNER != "$dir" ]]; then
	    echo "$0: ERROR:  ^$YEAR,$WINNER winners_rank: $winners_rank WINNER: $WINNER != $dir" 1>&2
	    exit 41
	fi
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: found: year: $year dir: $dir winners_rank: $winners_rank file_path: $file_path" 1>&2
	    echo "$0: debug[7]:  also: prog: $prog filetype: $filetype winners_show: $winners_show" 1>&2
	    echo "$0: debug[7]:   and: display_via: $display_via winners_text: $winners_text extra: $extra" 1>&2
	fi

	# firewall - nothing except extra should be empty
	#
	if [[ -z $file_path ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty file_path" 1>&2
	    exit 42
	fi
	if [[ -z $winners_rank ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_rank" 1>&2
	    exit 43
	fi
	if [[ -z $created_by ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty created_by" 1>&2
	    exit 44
	fi
	if [[ -z $prog ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty prog" 1>&2
	    exit 45
	fi
	if [[ -z $filetype ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty filetype" 1>&2
	    exit 46
	fi
	if [[ -z $winners_show ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_show" 1>&2
	    exit 47
	fi
	if [[ -z $display_via ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty display_via" 1>&2
	    exit 48
	fi
	if [[ -z $winners_text ]]; then
	    echo "$0: ERROR: ^$YEAR,$WINNER winners_rank: $winners_rank empty winners_text" 1>&2
	    exit 49
	fi

	# save inventory information
	#
	FILE_PATH+=( "$file_path" )
	WINNERS_RANK+=( "$winners_rank" )
	CREATED_BY+=( "$created_by" )
	PROG+=( "$prog" )
	FILETYPE+=( "$filetype" )
	WINNER_SHOW+=( "$winners_show" )
	DISPLAY_VIA+=( "$display_via" )
	WINNER_TEXT+=( "$winners_text" )
done <<< "$NULL_RANKED_MANIFEST_SET"
export FILE_COUNT=${#FILE_PATH[@]}
if [[ $FILE_COUNT -le 0 ]]; then
    echo "$0: ERROR: cannot find files in manifest $MANIFEST_CSV for $WINNER_ID" 1>&2
    exit 50
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: manifest file count for $WINNER_ID: $FILE_COUNT"
fi

# write .winners.json
#
# write leading part of .winners.json
#
cat > "$TMP_DOT_WINNER_JSON" << EOF
{
    "no_comment" : "$NO_COMMENT",
    "winner_JSON_format_version" : "$WINNER_JSON_FORMAT_VERSION",
    "award" : "$AWARD",
    "year" : $YEAR,
    "dir" : "$WINNER",
    "winner_id" : "$WINNER_ID",
    "author_set" : [
EOF
#
# write author_handle part of .winners.json
#
((AUTHOR_COUNT_LESS_1=AUTHOR_COUNT-1))
for i in "${!AUTHOR[@]}"; do
    # stupid JSON syntax does not allow a trailing comma
    if [[ $i -lt "$AUTHOR_COUNT_LESS_1" ]]; then
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	{ "author_handle" : "${AUTHOR[$i]}" },
EOF
    else
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	{ "author_handle" : "${AUTHOR[$i]}" }
EOF
    fi
done
#
# write start of manifest of .winners.json
#
cat >> "$TMP_DOT_WINNER_JSON" << EOF
    ],
    "manifest" : [
EOF
((FILE_COUNT_LESS_1=FILE_COUNT-1))
#
# write each file in the manifest of .winners.json
#
for i in "${!WINNERS_RANK[@]}"; do

    #
    # write start and file_path of a given file in manifest of .winners.json
    #
    cat >> "$TMP_DOT_WINNER_JSON" << EOF
	{
	    "file_path" : "${FILE_PATH[$i]}",
EOF

    #
    # write winners_rank of a given file in manifest of .winners.json
    #
    if [[ ${WINNERS_RANK[$i]} == null ]]; then
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "winners_rank" : null,
EOF
    else
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "winners_rank" : ${WINNERS_RANK[$i]},
EOF
    fi

    #
    # write created_by of a given file in manifest of .winners.json
    #
    if [[ ${CREATED_BY[$i]} == null ]]; then
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "created_by" : null,
EOF
    else
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "created_by" : "${CREATED_BY[$i]}",
EOF
    fi

    #
    # write prog of a given file in manifest of .winners.json
    #
    if [[ ${PROG[$i]} == null ]]; then
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "prog" : null,
EOF
    else
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "prog" : "${PROG[$i]}",
EOF
    fi

    #
    # write filetype and winners_show of a given file in manifest of .winners.json
    #
    cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "filetype" : "${FILETYPE[$i]}",
	    "winners_show" : ${WINNER_SHOW[$i]},
EOF

    #
    # write display_via of a given file in manifest of .winners.json
    #
    if [[ ${DISPLAY_VIA[$i]} == null ]]; then
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "display_via" : null,
EOF
    else
	cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "display_via" : "${DISPLAY_VIA[$i]}",
EOF
    fi

    #
    # write winners_text of a given file in manifest of .winners.json
    #
    cat >> "$TMP_DOT_WINNER_JSON" << EOF
	    "winners_text" : "${WINNER_TEXT[$i]}"
EOF

    # stupid JSON syntax does not allow a trailing comma
    if [[ $i -lt "$FILE_COUNT_LESS_1" ]]; then
    cat >> "$TMP_DOT_WINNER_JSON" << EOF
	},
EOF
    else
    cat >> "$TMP_DOT_WINNER_JSON" << EOF
	}
EOF
    fi
done

#
# write trailing part of .winners.json
#
cat >> "$TMP_DOT_WINNER_JSON" << EOF
    ]
}
EOF
if [[ $V_FLAG -ge 7 ]]; then
    echo "$0: debug[7]: start of TMP_DOT_WINNER_JSON below: $TMP_DOT_WINNER_JSON" 1>&2
cat "$TMP_DOT_WINNER_JSON" 1>&2
    echo "$0: debug[7]: end of TMP_DOT_WINNER_JSON above: $TMP_DOT_WINNER_JSON" 1>&2
fi

# write .inventory.md
#
# write header of .inventory.md
#
cat > "$TMP_DOT_INVENTORY_MD" << EOF

[///]:  # (!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)

[//]:   # (DO NOT MODIFY THIS FILE - This file was generated by: $NAME version: $VERSION)

[////]: # (!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)

| About the file | Link to file |
| :------------- | :----------- |
EOF

# add inventory links to .inventory.md
#
for i in "${!WINNERS_RANK[@]}"; do

    # case: display via browser or download via browser
    #
    case ${DISPLAY_VIA[$i]} in
    github)	USE_URL="$GITHUB_URL_PATH/$WINNER_PATH/${FILE_PATH[$i]}" ;;
    browser)	USE_URL="$URL_PATH/${FILE_PATH[$i]}" ;;
    download)	USE_URL="$URL_PATH/${FILE_PATH[$i]}" ;;
    null)	USE_URL="$URL_PATH/${FILE_PATH[$i]}" ;;
    *)		USE_URL="$GITHUB_URL_PATH/$WINNER_PATH/${FILE_PATH[$i]}" ;;
    esac
    export USE_URL

    # print inventory item
    #
    cat >> "$TMP_DOT_INVENTORY_MD" << EOF
| ${WINNER_TEXT[$i]} | [${FILE_PATH[$i]}]($USE_URL) |
EOF
done

# write trailing part of .inventory.md
#
cat >> "$TMP_DOT_INVENTORY_MD" << EOF

#### Nu HTML check

For web site admin: [Check HTML](https://validator.w3.org/nu/?doc=$VALIDATOR_ENCODED_URL)
EOF
if [[ $V_FLAG -ge 7 ]]; then
    echo "$0: debug[7]: start of TMP_DOT_INVENTORY_MD below: $TMP_DOT_INVENTORY_MD" 1>&2
    cat "$TMP_DOT_INVENTORY_MD" 1>&2
    echo "$0: debug[7]: end of TMP_DOT_INVENTORY_MD above: $TMP_DOT_INVENTORY_MD" 1>&2
fi

# convert .inventory.md to .inventory.html
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]:" \
	"$PANDOC" -f markdown -t html -o "$TMP_DOT_INVENTORY_HTML" \
	    --fail-if-warnings=true --metadata title="File inventory of $YEAR/$WINNER" --standalone \
	    --metadata maxwidth="48em" \
	    "$TMP_DOT_INVENTORY_MD"
fi
"$PANDOC" -f markdown -t html -o "$TMP_DOT_INVENTORY_HTML" \
    --fail-if-warnings=true --metadata title="$YEAR/$WINNER Inventory" --standalone \
    --metadata maxwidth="48em" \
    "$TMP_DOT_INVENTORY_MD"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: pandoc: $PANDOC failed, exit code: $status" 1>&2
    exit 51
fi
if [[ ! -s "$TMP_DOT_INVENTORY_HTML" ]]; then
    echo "$0: ERROR: pandoc: $PANDOC produced an empty file: $TMP_DOT_INVENTORY_HTML" 1>&2
    exit 52
fi
if [[ $V_FLAG -ge 7 ]]; then
    echo "$0: debug[7]: start of DOT_INVENTORY_HTML_PATH below: $TMP_DOT_INVENTORY_HTML" 1>&2
    cat "$TMP_DOT_INVENTORY_HTML" 1>&2
    echo "$0: debug[7]: end of DOT_INVENTORY_HTML_PATH above: $TMP_DOT_INVENTORY_HTML" 1>&2
fi
rm -f "$TMP_DOT_INVENTORY_MD"

# update .winner.json if needed
#
if ! cmp -s "$TMP_DOT_WINNER_JSON" "$WINNER_JSON_PATH"; then

    # replace index.html file
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: updating $WINNER_JSON_PATH"
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	mv -f -v "$TMP_DOT_WINNER_JSON" "$WINNER_JSON_PATH"
	status="$?"
    else
	mv -f "$TMP_DOT_WINNER_JSON" "$WINNER_JSON_PATH"
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_DOT_WINNER_JSON $WINNER_JSON_PATH failed, error: $status" 1>&2
	exit 100
    fi

else

    # index.html is OK, remove the tmp file
    #
    rm -f "$TMP_DOT_WINNER_JSON"
    if [[ -e $TMP_DOT_WINNER_JSON ]]; then
	echo "$0: ERROR: TMP_DOT_WINNER_JSON cannot be removed for cleanup: $TMP_DOT_WINNER_JSON" 1>&2
	exit 101
    fi
fi

# update .inventory.html if needed
#
if ! cmp -s "$TMP_DOT_INVENTORY_HTML" "$DOT_INVENTORY_HTML_PATH"; then

    # replace index.html file
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: updating $DOT_INVENTORY_HTML_PATH"
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	mv -f -v "$TMP_DOT_INVENTORY_HTML" "$DOT_INVENTORY_HTML_PATH"
	status="$?"
    else
	mv -f "$TMP_DOT_INVENTORY_HTML" "$DOT_INVENTORY_HTML_PATH"
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_DOT_INVENTORY_HTML $DOT_INVENTORY_HTML_PATH failed, error: $status" 1>&2
	exit 102
    fi

else

    # index.html is OK, remove the tmp file
    #
    rm -f "$TMP_DOT_INVENTORY_HTML"
    if [[ -e $TMP_DOT_INVENTORY_HTML ]]; then
	echo "$0: ERROR: TMP_DOT_INVENTORY_HTML cannot be removed for cleanup: $TMP_DOT_INVENTORY_HTML" 1>&2
	exit 103
    fi
fi

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
