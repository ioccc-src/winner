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
#	awk -v entry_path=YYYY/dir -f bin/subst.winner-navbar.awk YYYY/.year
#
# where:
#
#	YYYY	IOCCC year or mock
#	dir	name of winner directory under YYYY

BEGIN {

    # setup
    #
    VERSION="1.1 2024-01-29"
    process_next_line = 0;	# 1 ==> we found our entry_path, now process the next line
    found_entry_path = 0;	# 1 ==> we found our entry_path
    prev_line = "";		# the previous YYYY/dir line
    topnav_phase = "mid";	# topnav name to use (-H topnav=topnav_phase)

    # error if github is not set via -v github=REPO_URL
    #
    if (length(entry_path) == 0) {
	exit 210;	# use 210 to match length(entry_path) == 0 error in the END section
    }
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
	print "211";
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
	print "-s";
	print "RIGHT_LINK=../" dir "/index.html";
	print "-s";
	print "RIGHT_TEXT=" dir;
	process_next_line = 0;

    # if we found our entry_path
    #
    } else if (entry_path == $0) {

	# in case our our entry_path is the 1st line
	#
	if (NR == 1) {
	    # no previous line entry_path is the 1st line
	    topnav_phase = "first";
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
		print "212";
		exit
	    }
	    prev_year = file[1];
	    prev_dir = file[2];
	    if (year != prev_year) {
		# ERROR: previous YYYY/dir YYYY does not match current line
		print "-e";
		print "'previous line:", prev_line "year:", prev_year, "!= current line year:", year "'";
		print "-E";
		print "213";
	    }

	    # report the next entry for this year
	    print "-s";
	    print "LEFT_LINK=../" prev_dir "/index.html";
	    print "-s";
	    print "LEFT_TEXT=" prev_dir;
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

    # error if github is not set via -v github=REPO_URL
    #
    if (length(entry_path) == 0) {
	print "-e";
	print "ERROR: github variable not set, call with -v github=REPO_URL";
	print "-E";
	print "210";		# use 210 to match length(entry_path) == 0 error in the BEGIN section
	exit 210;		# use 210 to match length(entry_path) == 0 error in the BEGIN section
    }

    # output inventory link information
    #
    print "-s";
    print "INVENTORY_LINK=#inventory";
    print "-s";
    print "INVENTORY_TEXT=Inventory";

    # case: we did not find our entry_path
    #
    if (!found_entry_path) {
	# ERROR: entry_path was not found
	print "-e";
	print "'we did not find:", entry_path "'";
	print "-E";
	print "215";
	exit

    } else if (process_next_line) {
	# no next line entry_path is the last line
	topnav_phase = "last";
    }

    # output the topnav phase name
    #
    print "-H";
    print "topnav=" topnav_phase;
}
