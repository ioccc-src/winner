#!/usr/bin/env perl
$num = 0;
while(read(STDIN, $byte, 1)) {
	print "$num\n" if $byte;
	++$num;
}
