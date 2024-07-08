#!/usr/bin/perl
#
# yahoo-ticker.pl
#
# Copyright 1998 by Anthony Howe.  All rights reserved.
#
# Usage: yahoo-ticker.pl?<symbol>
#

##########################################################################
#	Nothing to be configured below this point.
##########################################################################

use Socket;

# WORK-AROUND 1.
# BAH! Some Perl implementations (for Windows) are not created equal.
# Force I/O flushes after each read/write operation.

$| = 1;

#########################################################################
#	Open connection to URL.
#########################################################################

my ($symbol) = $ENV{'QUERY_STRING'} =~ /\??(.*)/;

# Figure out who we have to call.
#($host, $port, $path) = ($url =~ m!http://([^:/]+)(?:\:(\d*))?(/.*)!);

$host = "finance.yahoo.com";
$port = 80 unless defined $port;
$path = "/q?s=$symbol";

# Get a socket...
unless (socket(HTTP, PF_INET, SOCK_STREAM, getprotobyname('tcp'))) {
	print("[CGI failed ($!)]\n");
	exit(0);
}

# ...set socket to be line buffered...
select( (select(HTTP), $| = 1)[0] );

# .. make the connection.
unless (connect(HTTP, sockaddr_in($port, inet_aton("$host")))) {
	print("[CGI failed ($!)]\n");
	exit(0);
}

print HTTP "GET $path HTTP/1.0\nHost: $host\n\n";

while (<HTTP>) {
	# Last trade price line.
	if (m!>Last Trade:<!) {
		($price) = (m!Last Trade:</td><td class="yfnc_tabledata1"><big><b>(\d+\.\d+)</b></big></td>!);
	}
	
	if (m!>Trade Time:<!) {
		($last) = (m!Trade Time:</td><td class="yfnc_tabledata1">([^<]+)</td>!);
	} 
	
	if (m!>Volume:<!) {
		($volume) = (m!Volume:</td><td class="yfnc_tabledata1">([^<]+)</td>!);
	}
}

close(HTTP);

print "HTTP/1.0 200 OK\n";
print "Content-Type: text/javascript\n\n";

print "var ticker = new Array();\n";
print "ticker['price'] = $price;\n";
print "ticker['volume'] = \"$volume\";\n";
print "ticker['last'] = \"$last\";\n";

exit 0;
