#!/usr/bin/env awk
#
# filelist.entry.json.awk - output list of files from the entry's .entry.json file
#
# usage:
#
#   print paths from topdir:
#
#	awk -f bin/filelist.entry.json.awk YYYY/dir/.entry.json
#
#   print paths relative to the winning entry directory:
#
#	awk -v print_relative=true -f bin/filelist.entry.json.awk YYYY/dir/.entry.json
#
#   print the YYYY/dir/.entry.json contents up until the end of the JSON manifest array
#
#	awk -v print_until=true -f bin/filelist.entry.json.awk YYYY/dir/.entry.json
#
# where:
#
#	YYYY		IOCCC year or mock
#	dir		name of entry's directory under YYYY containing .entry.json
#
# NOTE: This code is MUCH FASTER than using the bin/filelist.entry.json.sh tool.

# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the .entry.json file  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX

BEGIN {

    # setup
    #
    VERSION="1.0.2 2026-04-27"
    NAME = "filelist.entry.json.awk"
    found_manifest_array = 0;	# 1 ==> we found the manifest ARRAY
    within_manifest_array = 0;	# 1 ==> found start of "manifest" : [ JSON array
    begin_manifest_element = 0;	# 1 ==> we have found the start of the manifest array element

    # extract YYYY and dir from file argument
    #
    YYYY = "";
    dir = "";
    tmp = ARGV[1];
    gsub(/\.entry\.json$/, "", tmp);
    arg_path_count = split(tmp, part, "/");
    if (arg_path_count >= 2) {
	dir=part[arg_path_count-1];
	YYYY=part[arg_path_count-2];
    }
    if (length(dir) == 0) {
	exit 210;	# END section will output ERROR message about cannot find dir
    }
    if (length(YYYY) == 0) {
	exit 211;	# END section will output ERROR message about cannot find YYYY
    }

    # print_relative and print_until conflict
    #
    if (length(print_relative) > 0 && length(print_until) > 0) {
	exit 212;	# cannot use both print_relative and print_until
    }
}

# look for the start of "manifest" JSON array
#
# We look for a line with 3 tokens:
#
#	"manifest" : [
#
NF == 3 && $1 ~ /^"manifest"$/ && $2 ~ /^:$/ && $3 ~ /^\[$/ {

    # print JSON line if print_until
    #
    if (length(print_until) > 0) {
	print $0;
    }

    # note we have found the start of "manifest" JSON array
    #
    found_manifest_array = 1;
    within_manifest_array = 1;
    begin_manifest_element = 0;
}

# scan over lines that are before the start of "manifest" JSON array
#
found_manifest_array == 0 {

    # print JSON line if print_until
    #
    if (length(print_until) > 0) {
	print $0;
    }
}

# after start of "manifest" JSON array, process start of a manifest array element
#
# We have just seen the start of "manifest" JSON array:
#
#	"manifest" : [
#
# Now, when we see a line of this form:
#
#	{
#
# we know that we are about to see the start of one of the manifest array elements.
#
within_manifest_array == 1 && NF == 1 && $1 ~ /^{$/ {

    # print JSON line if print_until
    #
    if (length(print_until) > 0) {
	print $0;
    }

    # note the start of the manifest array element
    #
    begin_manifest_element = 1;

    # clear values for the JSON members of this manifest array elements
    #
    file_path = "";

    # clear unquoted values for the JSON members of this manifest array elements
    #
    unquote_file_path = "";
}

# record file_path from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"file_path" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"file_path"$/ && $2 ~ /^:$/ {

    # print JSON line if print_until
    #
    if (length(print_until) > 0) {
	print $0;
    }

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    file_path = $0;

    # Remove any trailing ,
    #
    if (file_path ~ /,$/) {
	file_path = substr(file_path, 1, length(file_path)-1);
    }

    # remove any enclosing double quotes
    #
    if (file_path ~ /^".*"$/) {
	unquote_file_path = substr(file_path, 2, length(file_path)-2);
    } else {
	unquote_file_path = file_path;
    }
}

# scan over other non-file_path members of this manifest array element
#
# We seen the start of the manifest line:
#
#	"manifest" : [
#
# We have seen the start of an of a manifest array element:
#
#	{
#
# Scan over non-file_path lines.
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $2 ~ /^:$/ {

    # print JSON line if print_until
    #
    if (length(print_until) > 0) {
	print $0;
    }
}

# process end of manifest array element
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF == 1 && $1 ~ /^},?$/ {

    # verify we have seen a file_path JSON member
    #
    if (length(file_path) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a file_path JSON member in:", ARGV[1] > "/dev/stderr";
	exit 213;
    }

    # print file_path information, unless print_until
    #
    if (length(print_until) == 0) {
	if (length(print_relative) > 0) {
	    print unquote_file_path;
	} else {
	    print YYYY "/" dir "/" unquote_file_path;
	}
    }

    # note the end of the manifest array element
    #
    begin_manifest_element = 0;

    # note if we found the end of the manifest array
    #
    if ($1 ~ /^}$/) {
	within_manifest_array = 0;
    }

    # print JSON line if print_until
    #
    if (length(print_until) > 0 && within_manifest_array) {
	print $0;
    }
}

END {

    # case: we quit because we could not determine dir from ARGV[1]
    #
    if (length(dir) == 0) {
	print "ERROR:", NAME ": cannot determine dir from:", ARGV[1] > "/dev/stderr";
	exit 210;	# END section will output ERROR message about cannot find dir
    }

    if (length(YYYY) == 0) {
	print "ERROR:", NAME ": cannot determine YYYY from:", ARGV[1] > "/dev/stderr";
	exit 211;	# END section will output ERROR message about cannot find YYYY
    }

    # print_relative and print_until conflict
    #
    if (length(print_relative) > 0 && length(print_until) > 0) {
	print "ERROR:", NAME ": cannot use both print_relative and print_until:", ARGV[1] > "/dev/stderr";
	exit 212;	# cannot use both print_relative and print_until
    }

    # verify we have seen a file_path JSON member
    #
    if (length(file_path) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a file_path JSON member in:", ARGV[1] > "/dev/stderr";
	exit 213;
    }

    # case: no manifest array was found
    #
    if (!found_manifest_array) {
	print "ERROR:", NAME ": we did not find a manifest JSON array in:", ARGV[1] > "/dev/stderr";
	exit 214;
    }

    # case: manifest array was found, but manifest array element did not finish
    #
    if (begin_manifest_element) {
	print "ERROR:", NAME ": manifest JSON array element did not end in:", ARGV[1] > "/dev/stderr";
	exit 215;
    }

    # case: manifest array did not end
    #
    if (within_manifest_array) {
	print "ERROR:", NAME ": manifest JSON array did not end in:", ARGV[1] > "/dev/stderr";
	exit 216;
    }
}
