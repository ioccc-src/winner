#!/usr/bin/env bash
#
# fix_csv - fix the exported CSV files, form path_list.* files
#
# When Apple numbers exports a CSV file from manifest.numbers,
# and exports a CSV file from missing-manifest.numbers,
# the CSV file lines are separated by carriage returns (\015)
# and is not terminated by a newline.  This script will "correct"
# these issues.
#
# XXX - This is a temporary utility that will be removed when
#	the .entry.json files are built

# setup
#
export MANIFEST_CSV="manifest.csv"
export TMP_CSV

if [[ ! -f $MANIFEST_CSV ]]; then
    echo "$0: ERROR: MANIFEST_CSV is missing: $MANIFEST_CSV" 1>&2
    exit 10
fi
if [[ ! -s $MANIFEST_CSV ]]; then
    echo "$0: ERROR: MANIFEST_CSV is empty: $MANIFEST_CSV" 1>&2
    exit 11
fi

# setup temp manifest CSV file
#
TMP_CSV="tmp.$$.$MANIFEST_CSV"
rm -f "$TMP_CSV"
if [[ -e $TMP_CSV ]]; then
    echo "$0: ERROR: TMP_CSV cannot be removed: $TMP_CSV" 1>&2
    exit 12
fi

# remove carriage returns in manifest CSV file
#
trap 'rm -f $TMP_CSV; exit' 0 1 2 3 15
tr -d '\015' < "$MANIFEST_CSV" > "$TMP_CSV"
status="$?"
if [[ $status -ne 0 ]]; then
    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s failed, error: %s\n" "$MANIFEST_CSV" "$TMP_CSV" "$status" 1>&2
    exit 13
fi
if [[ ! -s $TMP_CSV ]]; then
    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s produced an empty file" "$MANIFEST_CSV" "$TMP_CSV" 1>&2
    exit 14
fi

# sanity check manifest CSV
#

# check for double whitespace
#
trap 'rm -f $TMP_CSV $TMP_CHECK; exit' 0 1 2 3 15
TMP_CHECK="tmp.$$.check"
rm -f "$TMP_CHECK"
grep -E '[[:space:]][[:space:]]' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found multiple consecutive whitespace in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: consecutive whitespace lines from $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: consecutive whitespace lines from $MANIFEST_CSV ends above" 1>&2
    exit 15
fi

# check for leading whitespace
#
rm -f "$TMP_CHECK"
grep -E ',[[:space:]]|^[[:space:]]' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found leading whitespace in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: leading whitespace lines from $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: leading whitespace lines from $MANIFEST_CSV ends above" 1>&2
    exit 16
fi

# check for trailing whitespace
#
rm -f "$TMP_CHECK"
grep -E '[[:space:]],|[[:space:]]$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found trailing whitespace in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: trailing whitespace lines from $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: trailing whitespace lines from $MANIFEST_CSV ends above" 1>&2
    exit 17
fi

# check for duplicate year,dir,file_path
#
rm -f "$TMP_CHECK"
sed -e 's/^\([^,]*,[^,]*,[^,]*\).*/\1/' "$TMP_CSV" | sort | uniq -d > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found duplicated year,dir,file_path in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: duplicated year,dir,file_path in $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: duplicated year,dir,file_path in $MANIFEST_CSV ends above" 1>&2
    exit 18
fi

# check for ,TRUE,
#
rm -f "$TMP_CHECK"
grep -E ',TRUE,|,TRUE$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found ,TRUE, instead of ,true, in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: lines with ,TRUE, $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: lines with ,TRUE, $MANIFEST_CSV ends above" 1>&2
    exit 19
fi

# check for ,FALSE,
#
rm -f "$TMP_CHECK"
grep -E ',FALSE,|,FALSE$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found ,FALSE, instead of ,false, in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: lines with ,FALSE, $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: lines with ,FALSE, $MANIFEST_CSV ends above" 1>&2
    exit 20
fi

# check for ,null,
#
rm -f "$TMP_CHECK"
grep -E ',null,|.,null$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found ,null, in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: lines with ,null, $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: lines with ,null, $MANIFEST_CSV ends above" 1>&2
    exit 21
fi
rm -f "$TMP_CHECK"

# check for ,NULL,
#
rm -f "$TMP_CHECK"
grep -E ',NULL,|,NULL$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found ,NULL, in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: lines with ,NULL, $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: lines with ,NULL, $MANIFEST_CSV ends above" 1>&2
    exit 22
fi
rm -f "$TMP_CHECK"

# fix manifest CSV
#

# sort manifest CSV file
#
# sort by: year  dir    file_path inventory_order  everything_else
#
sort -t,   -k1,1 -k2d,2 -k4g,4    -k3d,3           -k5d,8 "$TMP_CSV" -o "$TMP_CSV"
status="$?"
if [[ $status -ne 0 ]]; then
    printf "$0: ERROR: sort -t, -k1,1 -k2d,2 -k4n,4 -k3d,3 -k5d,8 %s -o %s failed, error: %s\n" "$TMP_CSV" "$TMP_CSV" "$status" 1>&2
    exit 23
fi

# append newline if last line of manifest CSV file if not empty
#
LAST_CHAR=$(tail -c 1 "$TMP_CSV")
if [[ -n $LAST_CHAR ]]; then
    echo "" >> "$TMP_CSV"
fi

# check for empty cells
#
rm -f "$TMP_CHECK"
grep -E ',,|,$' "$TMP_CSV" > "$TMP_CHECK"
if [[ -s $TMP_CHECK ]]; then
    echo "$0: ERROR: found ,empty cell in $MANIFEST_CSV" 1>&2
    echo "$0: Warning: lines with empty cell $MANIFEST_CSV starts below" 1>&2
    cat "$TMP_CHECK" 1>&2
    echo "$0: Warning: lines with empty cell $MANIFEST_CSV ends above" 1>&2
    exit 24
fi
rm -f "$TMP_CHECK"

# replace manifest CSV file if different
#
if ! cmp -s "$TMP_CSV" "$MANIFEST_CSV"; then

    # replace CSV file with a better formatted version
    #
    echo "$0: updating $MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $MANIFEST_CSV failed, error: $status" 1>&2
	exit 25
    fi

else

    # CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 26
    fi
fi

# setup the full manifest path list
#
TMP_CSV="tmp.$$.$MANIFEST_CSV"
sed -e '/^# -/d' "$MANIFEST_CSV" |
    sort -u |
    sort -t, -k1,1 -k2d,2 -k4g,4 -k3d,3 -k5d,10 > "$TMP_CSV"
if [[ ! -s $TMP_CSV ]]; then
    echo "$0: ERROR: sorted $MANIFEST_CSV is empty" 1>&2
    exit 27
fi
if ! cmp -s "$TMP_CSV" "$MANIFEST_CSV"; then

    # replace full CSV file if different
    #
    echo "$0: updating $MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $MANIFEST_CSV failed, error: $status" 1>&2
	exit 28
    fi

else

    # fill CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 29
    fi
fi

# build required file path list
#
export REQUIRED_PATH_LIST="path_list.required.txt"
export TMP_FILE="tmp.$$.$REQUIRED_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && ( $5 == "true" || $8 == "original source" ) { print $1 "/" $2 "/" $3; }' "$MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for required file list, is empty: $TMP_CSV" 1>&2
    exit 30
fi
if ! cmp -s "$TMP_FILE" "$REQUIRED_PATH_LIST"; then

    # replace required file
    #
    echo "$0: updating $REQUIRED_PATH_LIST"
    mv -f -v "$TMP_FILE" "$REQUIRED_PATH_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $REQUIRED_PATH_LIST failed, error: $status" 1>&2
	exit 31
    fi

else

    # required file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 32
    fi
fi

# build the built file path list
#
export BUILT_PATH_LIST="path_list.built.txt"
export TMP_FILE="tmp.$$.$BUILT_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && $5 == "false" && $8 != "original source" { print $1 "/" $2 "/" $3; }' "$MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for built file list, is empty: $TMP_CSV" 1>&2
    exit 33
fi
if ! cmp -s "$TMP_FILE" "$BUILT_PATH_LIST"; then

    # replace built file
    #
    echo "$0: updating $BUILT_PATH_LIST"
    mv -f -v "$TMP_FILE" "$BUILT_PATH_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $BUILT_PATH_LIST failed, error: $status" 1>&2
	exit 34
    fi

else

    # built file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 35
    fi
fi

# build manifest file list
#
export MANIFEST_LIST="path_list.manifest.txt"
export TMP_FILE="tmp.$$.$BUILT_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
cat "$REQUIRED_PATH_LIST" "$BUILT_PATH_LIST" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for manifest file list, is empty: $TMP_CSV" 1>&2
    exit 36
fi
if ! cmp -s "$TMP_FILE" "$MANIFEST_LIST"; then

    # replace manifest file
    #
    echo "$0: updating $MANIFEST_LIST"
    mv -f -v "$TMP_FILE" "$MANIFEST_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $MANIFEST_LIST failed, error: $status" 1>&2
	exit 37
    fi

else

    # manifest file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 38
    fi
fi

# fix other CSV files
#
# We will fix author_wins.csv, and year_prize.csv
#
for csv in author_wins.csv year_prize.csv; do

    # verify that a CSV file exists
    #
    if [[ ! -f $csv ]]; then
	echo "$0: ERROR: CSV is missing: $csv" 1>&2
	exit 39
    fi
    if [[ ! -s $csv ]]; then
	echo "$0: ERROR: CSV is empty: $csv" 1>&2
	exit 40
    fi

    # setup temp CSV file
    #
    TMP_CSV="tmp.$$.$csv"
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed: $TMP_CSV" 1>&2
	exit 41
    fi

    # remove carriage returns in CSV file
    #
    trap 'rm -f $TMP_CSV; exit' 0 1 2 3 15
    tr -d '\015' < "$csv" > "$TMP_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s failed, error: %s\n" "$csv" "$TMP_CSV" "$status" 1>&2
	exit 42
    fi
    if [[ ! -s $TMP_CSV ]]; then
	printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s produced an empty file" "$csv" "$TMP_CSV" 1>&2
	exit 43
    fi

    # sort CSV file
    #
    sort -t, -k1d,1 -k2d,2 "$TMP_CSV" -o "$TMP_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	printf "$0: ERROR: sort -t, -k1d,1 -k2d,2 %s -o %s failed, error: %s\n" "$TMP_CSV" "$TMP_CSV" "$status" 1>&2
	exit 44
    fi

    # append newline if last line of CSV file if not empty
    #
    LAST_CHAR=$(tail -c 1 "$TMP_CSV")
    if [[ -n $LAST_CHAR ]]; then
	echo "" >> "$TMP_CSV"
    fi

    # replace CSV file if different
    #
    if ! cmp -s "$TMP_CSV" "$csv"; then

	# replace CSV file with a better formatted version
	#
	echo "$0: updating $csv"
	mv -f -v "$TMP_CSV" "$csv"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -v $TMP_CSV $csv failed, error: $status" 1>&2
	    exit 45
	fi

    else

	# CSV file is OK, remove the tmp file
	#
	rm -f "$TMP_CSV"
	if [[ -e $TMP_CSV ]]; then
	    echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	    exit 46
	fi
    fi
done

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
