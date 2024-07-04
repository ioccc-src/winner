#!/usr/bin/env bash
#
# check_file_list.sh - look for problems with file_list.* files
#
# XXX - This is a temporary utility that will be replaced when
#	the .winner.json files are built
#

# setup
#
export REQUIRED_FILE_LIST="file_list.required.txt"
export BUILT_FILE_LIST="file_list.built.txt"
export FULL_MANIFEST_LIST="file_list.full_manifest.txt"
export FOUND_LIST="file_list.found.txt"
export EXIT_CODE=0

# firewall
#
if [[ ! -f $REQUIRED_FILE_LIST ]]; then
    echo "$0: ERROR: missing REQUIRED_FILE_LIST: $REQUIRED_FILE_LIST" 1>&2
    exit 10
fi
if [[ ! -s $REQUIRED_FILE_LIST ]]; then
    echo "$0: ERROR: REQUIRED_FILE_LIST is empty: $REQUIRED_FILE_LIST" 1>&2
    exit 11
fi
if [[ ! -f $BUILT_FILE_LIST ]]; then
    echo "$0: ERROR: missing BUILT_FILE_LIST: $BUILT_FILE_LIST" 1>&2
    exit 12
fi
if [[ ! -s $BUILT_FILE_LIST ]]; then
    echo "$0: ERROR: BUILT_FILE_LIST is empty: $BUILT_FILE_LIST" 1>&2
    exit 13
fi
if [[ ! -f $FULL_MANIFEST_LIST ]]; then
    echo "$0: ERROR: missing FULL_MANIFEST_LIST: $FULL_MANIFEST_LIST" 1>&2
    exit 14
fi
if [[ ! -s $FULL_MANIFEST_LIST ]]; then
    echo "$0: ERROR: FULL_MANIFEST_LIST is empty: $FULL_MANIFEST_LIST" 1>&2
    exit 15
fi
if [[ ! -f $FOUND_LIST ]]; then
    echo "$0: ERROR: missing FOUND_LIST: $FOUND_LIST" 1>&2
    exit 16
fi
if [[ ! -s $FOUND_LIST ]]; then
    echo "$0: ERROR: FOUND_LIST is empty: $FOUND_LIST" 1>&2
    exit 17
fi

# look for missing required files
#
export TMP_FILE="tmp.$$.missing"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
comm -23 "$REQUIRED_FILE_LIST" "$FOUND_LIST" | sort -t/ > "$TMP_FILE"
if [[ -s $TMP_FILE ]]; then
    COUNT=$(wc -l < "$TMP_FILE" | sed -e 's/^ *//')
    echo "# $0: Waning: missing required file count: $COUNT"
    EXIT_CODE=18	# exit 18
    echo "#"
    echo "# $0: missing required file list starts below"
    cat "$TMP_FILE"
    echo "# $0: missing required file list ends above"
fi
rm -f "$TMP_FILE"

# look for found files not in the manifest
#
export TMP_FILE="tmp.$$.missing"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
comm -13 "$FULL_MANIFEST_LIST" "$FOUND_LIST" | sort -t/ > "$TMP_FILE"
if [[ -s $TMP_FILE ]]; then
    COUNT=$(wc -l < "$TMP_FILE" | sed -e 's/^ *//')
    echo "# $0: Waning: found files not in the manifest count: $COUNT"
    EXIT_CODE=19	# exit 19
    echo "#"
    echo "# $0: found files not in the manifest list starts below"
    cat "$TMP_FILE"
    echo "# $0: found files not in the manifest list ends above"
fi
rm -f "$TMP_FILE"

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit: $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
