#!/usr/bin/env perl

use strict;
use warnings;

if ($#ARGV != 4) {
    die "usage: $0 <net> <train corpus 1> <train corpus 0> <test corpus 1> <test corpus 0>\n"
}

my ($net, $train1, $train0, $test1, $test0) = @ARGV[0..4];
my $error = undef;
my $n = 1;

open TOUCH, '>', $net;
close TOUCH;

while (1) {
    print "training $n to " . ($n+1000) . "...\n";
    system "./dlowe -1000 $train1 $train0 < $net > $net.tmp 2>/dev/null";
    rename "$net.tmp", $net;

    my $current_error = 0;
    for my $r (split /\s+/, `./dlowe $test1* < $net 2>&1 | awk '{print \$NF}'`) {
        $current_error += ((1.0 - $r) ** 2);
    }
    for my $r (split /\s+/, `./dlowe $test0* < $net 2>&1 | awk '{print \$NF}'`) {
        $current_error += ((0.0 - $r) ** 2);
    }
    if (defined $error) {
        print "prior error = $error; current error = $current_error\n";
        if ($error - $current_error < 0.01) {
            last;
        }
    }
    $error = $current_error;
    $n += 1000;
}
