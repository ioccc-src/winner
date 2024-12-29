#!/usr/bin/perl -w
$/ = "\0";
$_ = <>;
s/[;{}][ \t\n]/\n/g;
s/[ \t\n]+//g;
print length ($_),"\n";


