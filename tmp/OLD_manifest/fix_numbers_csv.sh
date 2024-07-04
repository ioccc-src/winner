#!/usr/bin/env bash
#
# fix_numbers_csv - fix the exported CSV files from numbers
#
# When Apple numbers exports a CSV file from manifest.numbers,
# and exports a CSV file from missing-manifest.numbers,
# the CSV file lines are separated by carriage returns (\015)
# and is not terminated by a newline.  This script will "correct"
# these issues.
#
# XXX - This is a temporary utility that will be removed when
#	the .winner.json files are built

# setup
#
export MANIFEST_CSV="manifest.csv"
export MISSING_MANIFEST_CSV="missing_manifest.csv"
export FULL_MANIFEST_CSV="full_manifest.csv"
export TMP_CSV

# process files that exist
#
for i in "$MANIFEST_CSV" "$MISSING_MANIFEST_CSV"; do

    # process if non-empty file exists
    #
    if [[ -s $i ]]; then

	# setup temp file
	#
	TMP_CSV="tmp.$$.$i"
	rm -f "$TMP_CSV"
	if [[ -e $TMP_CSV ]]; then
	    echo "$0: ERROR: TMP_CSV cannot be removed: $TMP_CSV" 1>&2
	    exit 10
	fi

	# remove carriage returns
	#
	trap 'rm -f $TMP_CSV; exit' 0 1 2 3 15
	tr -d '\015' < "$i" > "$TMP_CSV"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s failed, error: %s\n" "$i" "$TMP_CSV" "$status" 1>&2
	    exit 11
	fi
	if [[ ! -s $TMP_CSV ]]; then
	    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s produced a empty file" "$i" "$TMP_CSV" 1>&2
	    exit 12
	fi

	# sort file
	#
	sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 "$TMP_CSV" -o "$TMP_CSV"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    printf "$0: ERROR: sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 %s -o %s failed, error: %s\n" "$TMP_CSV" "$TMP_CSV" "$status" 1>&2
	    exit 13
	fi

	# append newline if last line is not empty
	#
	LAST_CHAR=$(tail -c 1 "$TMP_CSV")
	if [[ -n $LAST_CHAR ]]; then
	    echo "" >> "$TMP_CSV"
	fi

	# replace CSV file if different
	#
	if ! cmp -s "$TMP_CSV" "$i"; then

	    # replace CSV file with a better formatted version
	    #
	    echo "$0: updating $i"
	    mv -f -v "$TMP_CSV" "$i"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: mv -f -v $TMP_CSV $i failed, error: $status" 1>&2
		exit 14
	    fi

	else

	    # CSV file is OK, remove the tmp file
	    #
	    rm -f "$TMP_CSV"
	    if [[ -e $TMP_CSV ]]; then
		echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
		exit 15
	    fi
	fi
    fi
done

# setup the full manifest
#
TMP_CSV="tmp.$$.$FULL_MANIFEST_CSV"
sed -e '/^# -/d' "$MANIFEST_CSV" "$MISSING_MANIFEST_CSV" |
    sort -u |
    sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 > "$TMP_CSV"
if [[ ! -s $TMP_CSV ]]; then
    echo "$0: ERROR: sorted $MANIFEST_CSV $MISSING_MANIFEST_CSV is empty" 1>&2
    exit 16
fi
if ! cmp -s "$TMP_CSV" "$FULL_MANIFEST_CSV"; then

    # replace full CSV file if different
    #
    echo "$0: updating $FULL_MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$FULL_MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $FULL_MANIFEST_CSV failed, error: $status" 1>&2
	exit 17
    fi

else

    # fill CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 18
    fi
fi

# build required file list
#
export REQUIRED_FILE_LIST="file_list.required.txt"
export TMP_FILE="tmp.$$.$REQUIRED_FILE_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && $5 == "null" { print $1 "/" $2 "/" $4; }' "$FULL_MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for required file list, is empty: $TMP_CSV" 1>&2
    exit 19
fi
if ! cmp -s "$TMP_FILE" "$REQUIRED_FILE_LIST"; then

    # replace required file
    #
    echo "$0: updating $REQUIRED_FILE_LIST"
    mv -f -v "$TMP_FILE" "$REQUIRED_FILE_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $REQUIRED_FILE_LIST failed, error: $status" 1>&2
	exit 20
    fi

else

    # required file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 21
    fi
fi

# build the built file list
#
export BUILT_FILE_LIST="file_list.built.txt"
export TMP_FILE="tmp.$$.$BUILT_FILE_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && $5 != "null" { print $1 "/" $2 "/" $4; }' "$FULL_MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for built file list, is empty: $TMP_CSV" 1>&2
    exit 22
fi
if ! cmp -s "$TMP_FILE" "$BUILT_FILE_LIST"; then

    # replace built file
    #
    echo "$0: updating $BUILT_FILE_LIST"
    mv -f -v "$TMP_FILE" "$BUILT_FILE_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $BUILT_FILE_LIST failed, error: $status" 1>&2
	exit 23
    fi

else

    # built file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 24
    fi
fi

# build full_manifest file list
#
export FULL_MANIFEST_LIST="file_list.full_manifest.txt"
export TMP_FILE="tmp.$$.$BUILT_FILE_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
cat "$REQUIRED_FILE_LIST" "$BUILT_FILE_LIST" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for full_manifest file list, is empty: $TMP_CSV" 1>&2
    exit 25
fi
if ! cmp -s "$TMP_FILE" "$FULL_MANIFEST_LIST"; then

    # replace full_manifest file
    #
    echo "$0: updating $FULL_MANIFEST_LIST"
    mv -f -v "$TMP_FILE" "$FULL_MANIFEST_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $FULL_MANIFEST_LIST failed, error: $status" 1>&2
	exit 26
    fi

else

    # full_manifest file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 27
    fi
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
