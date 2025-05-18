#!/usr/bin/env awk
#
# subst.year-navbar.awk - output substitutions for navbar on behalf of a year
#
# This tool is usually invoked from the bin/subst.year-index.sh output tool.
# That tool, in turn, is usually invoked by:
#
#	-o bin/subst.year-index.sh
#
# IMPORTANT: Each command line option / argument MUST be printed on a separate line!
#
# usage:
#
#	awk -v year_arg=YYYY -f bin/subst.year-navbar.awk .top
#
# where:
#
#	YYYY	IOCCC year or mock

BEGIN {

    # setup
    #
    VERSION="1.2.1 2025-05-17"
    NAME = "subst.year-navbar.awk"
    process_next_line = 0;	# 1 ==> we found our year_arg, now process the next line
    found_year_arg = 0;		# 1 ==> we found our year_arg
    prev_line = "";		# the previous YYYY line
    navbar_phase = "year.mid";	# navbar name to use (-H navbar=navbar_phase)

    # error if year_arg is not set via -v year_arg=YYYY
    #
    if (length(year_arg) == 0) {
	exit 210;	# use 210 to match length(year_arg) == 0 error in the END section
    }
}

# process YYYY lines
#
{
    # obtain the YYYY line
    #
    year = $0;

    # if we need the line after we found our year_arg
    #
    if (process_next_line) {

	# process the line after we found our year_arg
	#
	# report the previous year
	print "-s";
	print "RIGHT_LINK=../" year "/index.html";
	print "-s";
	print "RIGHT_TEXT=" year;
	process_next_line = 0;

    # if we found our year_arg
    #
    } else if (year_arg == $0) {

	# in case our our year_arg is the 1st line
	#
	if (NR == 1) {
	    # no previous line year_arg is the 1st line
	    navbar_phase = "year.first";
	}

	# process the previous YYYY line with this match
	#
	if (prev_line) {

	    # process previous line
	    #
	    prev_year = prev_line;

	    # report the next entry for this year
	    print "-s";
	    print "LEFT_LINK=../" prev_line "/index.html";
	    print "-s";
	    print "LEFT_TEXT=" prev_line;
	}

	# process our found year_arg
	#
	# report up link top year index.html
	print "-s";
	print "UP_LINK=../years.html";
	print "-s";
	print "UP_TEXT=top";
	process_next_line = 1;
	found_year_arg = 1;
    }

    # save the line as the next previous line
    #
    prev_line = $0;
}

END {

    # error if github is not set via -v github=REPO_URL
    #
    if (length(year_arg) == 0) {
	print "-e";
	print "ERROR:", NAME ": year_arg variable not set, call with -v year_arg=YYYY";
	print "-E";
	print "210";		# use 210 to match length(year_arg) == 0 error in the BEGIN section
	exit 210;		# use 210 to match length(year_arg) == 0 error in the BEGIN section
    }

    # case: we did not find our year_arg
    #
    if (!found_year_arg) {
	# ERROR: year_arg was not found
	print "-e";
	print "'" NAME ": did not find:", year_arg "'";
	print "-E";
	print "215";
	exit

    } else if (process_next_line) {
	# no next line year_arg is the last line
	navbar_phase = "year.last";
    }

    # output the navbar phase name
    #
    print "-H";
    print "navbar=" navbar_phase;
}
