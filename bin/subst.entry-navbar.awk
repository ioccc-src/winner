#!/usr/bin/env awk
#
# subst.entry-navbar.awk - output substitutions for navbar on behalf of an entry
#
# This tool is usually invoked from the bin/subst.entry-index.sh output tool.
# That tool, in turn, is usually invoked by:
#
#	-o bin/subst.entry-index.sh
#
# IMPORTANT: Each command line option / argument MUST be printed on a separate line!
#
# usage:
#
#	awk -v entry_path=YYYY/dir -f bin/subst.entry-navbar.awk YYYY/.year
#
# where:
#
#	YYYY	IOCCC year or mock
#	dir	name of entry directory under YYYY

BEGIN {

    # setup
    #
    VERSION="1.3.1 2025-05-17"
    NAME = "subst.entry-navbar.awk"
    process_next_line = 0;	# 1 ==> we found our entry_path, now process the next line
    found_entry_path = 0;	# 1 ==> we found our entry_path
    prev_line = "";		# the previous YYYY/dir line
    navbar_phase = "mid";	# navbar name to use (-H navbar=navbar_phase)

    # error if github is not set via -v github=REPO_URL
    #
    if (length(entry_path) == 0) {
	exit 210;	# use 210 to match length(entry_path) == 0 error in the END section
    }

    # determine entry_path_year and entry_path_dir
    #
    len = split(entry_path, file, "/");
    if (len != 2) {
	exit 211;	# use 211 to match len != 2 error in the END section
    }
    entry_path_year = file[1];
    entry_path_dir = file[2];
}

# process YYYY/dir lines
#
$0 ~ /[^\/]+\/[^\/]+/ {

    # split line into year (file[1]) and dir (file[2])
    #
    len = split($0, file, "/");
    if (len != 2) {
	# ERROR: invalid split of a YYYY/dir line
	print "-e";
	print "'invalid split of:", $0, "expected 2 part, found:", len "'";
	print "-E";
	print "212";
	exit
    }
    year = file[1];
    dir = file[2];

    # if we need the line after we found our entry_path
    #
    if (process_next_line) {

	# process the line after we found our entry_path
	#
	# report the previous entry for this year
	if (year == entry_path_year) {
	    print "-s";
	    print "RIGHT_LINK=../" dir "/index.html";
	} else {
	    print "-s";
	    print "RIGHT_LINK=../../" year "/" dir "/index.html";
	}
	print "-s";
	print "RIGHT_TEXT=" year "/" dir;
	process_next_line = 0;

    # if we found our entry_path
    #
    } else if (entry_path == $0) {

	# in case our our entry_path is the 1st line
	#
	if (NR == 1) {
	    # no previous line entry_path is the 1st line
	    navbar_phase = "first";
	}

	# process the previous YYYY/dir line with this match
	#
	if (prev_line) {

	    # split previous line into year (file[1]) and dir (file[2])
	    #
	    prev_len = split(prev_line, file, "/");
	    if (prev_len != 2) {
		# ERROR: invalid split of a previous YYYY/dir line
		print "-e";
		print "'invalid split of:", prev_line "expected 2 part, found:", prev_len "'";
		print "-E";
		print "213";
		exit
	    }
	    prev_year = file[1];
	    prev_dir = file[2];

	    # report the next entry for this year
	    if (prev_year == entry_path_year) {
		print "-s";
		print "LEFT_LINK=../" prev_dir "/index.html";
	    } else {
		print "-s";
		print "LEFT_LINK=../../" prev_year "/" prev_dir "/index.html";
	    }
	    print "-s";
	    print "LEFT_TEXT=" prev_year "/" prev_dir;
	}

	# process our found entry_path
	#
	# report up link top year index.html
	print "-s";
	print "UP_LINK=../index.html";
	print "-s";
	print "UP_TEXT=" year;
	process_next_line = 1;
	found_entry_path = 1;
    }

    # save the line as the next previous line
    #
    prev_line = $0;
}

# report any non-YYYY/dir line
#
$0 !~ /[^\/]+\/[^\/]+/ {

    # bogus line found
    print "-e";
    print "'found a non-YYYY/dir line in", ARGV[1] ":", $0 "'";
    print "-E";
    print "214";
    exit
}

END {

    # error if entry_path is not set via -v entry_path=YYYY/dir
    #
    if (length(entry_path) == 0) {
	print "-e";
	print "ERROR:", NAME ": github variable not set, call with -v github=REPO_URL";
	print "-E";
	print "210";		# use 210 to match length(entry_path) == 0 error in the BEGIN section
	exit 210;		# use 210 to match length(entry_path) == 0 error in the BEGIN section
    }

    # error if entry_path_year and entry_path_dir
    #
    len = split(entry_path, file, "/");
    if (len != 2) {
	# ERROR: invalid split of a YYYY/dir line
	print "-e";
	print "'invalid split of entry_path:", entry_path, "expected 2 part, found:", len "'";
	print "-E";
	print "211";
	exit 211;
    }

    # case: we did not find our entry_path
    #
    if (!found_entry_path) {
	# ERROR: entry_path was not found
	print "-e";
	print "'" NAME ": did not find:", entry_path "'";
	print "-E";
	print "215";
	exit

    } else if (process_next_line) {
	# no next line entry_path is the last line
	navbar_phase = "last";
    }

    # output the navbar phase name
    #
    print "-H";
    print "navbar=" navbar_phase;
}
