#!/usr/bin/perl --
#use strict;
use warnings;
use IPC::Open2;

my $sf_exe = "./sudoku-sf"; # location of sudoku-sf executable

my $vflg=0; my $gcmd=$sf_exe; my $scmd=$sf_exe;
my $gcnt=400; my $soff=2; my $fbad=1; my $ffile=1; 
my $fgen=1; my $zoom=0; my $rflg=1; my $fint=1;

my $n; my $stkc; my $stkw;

my $squstr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" . "abcdefghijklmnopqrstuvwxyz"
    . "0123456789,.";


sub sq($);
sub read_file($);

sub sq_tst($) {
    my $i;
    $i = substr($_[0],1) if($_[0]=~/^-./);
    $i = read_file($_[0]) unless($i);
    $i = squish($i); print $i,"\n";
}

for($n=0;$n<@ARGV;$n++) {
    if($ARGV[$n] eq "-h"||$ARGV[$n] eq "--help") { 
	print "\n",
 "test-su.perl - automated testing for the sudoku-sf sudoku solver\n",
 "Assumes sudoku-sf executable is at \"$sf_exe\" (\$sf_exe)\n",
 "This code is PUBLIC DOMAIN and comes with NO WARRANTY\n\n",
 "Usage:\n",
 "------\n",
 "test-su.perl [-v] [-s solver] [-g <genprog>] [-n <no>] <flags...>\n",
 "   -v            - verbose mode\n",
 "   -s <solver>   - path to sudoku solver executable ($sf_exe)\n",
 "   -g <genprog>  - path to sudoku generator executable ($sf_exe)\n",
 "   -n <no>       - number of random sudokus to generate and solve (400)\n",
 "   -s +Z -Z -z   - none of your business (obscure & useless)\n",
 "   -h|--help     - show this usage screen and exit\n\n",
 "flags (+ enables, - disables):\n",
 "   +B|-B  - enable/disable testing bad sudoku detection (+B)\n",
 "   +F|-F  - enable/disable testing sudokus from *.sudoku files (+F)\n",
 "   +G|-G  - enable/disable sudoku generation (+G)\n",
 "   +R|-R  - enable/disable PRNG tests (+R, may change)\n",
 "   +I|-I  - test using included sudoku (+I)\n",
 "Basic usage is just:  test-su.perl\n",
 "Add -R if the PRNG tests cause problems, and -n 0 if in a hurry\n";
	exit; 
    }
    if($ARGV[$n] eq "-v") { $vflg = 1; next; }
    if($ARGV[$n] eq "-s") { $scmd = $ARGV[++$n]; next; }
    if($ARGV[$n] eq "-g") { $gcmd = $ARGV[++$n]; next; }
    if($ARGV[$n] eq "-n") { $gcnt = 0+$ARGV[++$n]; next; }
    if($ARGV[$n] eq "-S") { $soff = 0+$ARGV[++$n]; next; }
    if($ARGV[$n] eq "-B") { $fbad = 0; next; }
    if($ARGV[$n] eq "+B") { $fbad = 1; next; }
    if($ARGV[$n] eq "-F") { $ffile = 0; next; }
    if($ARGV[$n] eq "+F") { $ffile = 1; next; }
    if($ARGV[$n] eq "-G") { $fgen = 0; $gcnt = 0; next; }
    if($ARGV[$n] eq "+G") { $fgen = 1; next; }
    if($ARGV[$n] eq "+Z") { $zoom = 1; next; }
    if($ARGV[$n] eq "-Z") { $zoom = 0; next; }
    if($ARGV[$n] eq "+R") { $rflg = 1; next; }
    if($ARGV[$n] eq "-R") { $rflg = 0; next; }
    if($ARGV[$n] eq "+I") { $fint = 1; next; }
    if($ARGV[$n] eq "-I") { $fint = 0; next; }
    if($ARGV[$n] eq "-z") { sq_tst($ARGV[++$n]); exit; }
    printf "\nUnknown option '%s', try '-h' for valid options\n\n", $ARGV[$n];
     die("Bad command-line options");
}



sub rpe() {
    my $n = ""; my $c=0; local $_;
    foreach(@l) {
	if(/^\s*[\d.]\s*[\d.]\s*[\d.]\s*\|\s*[\d.]\s*[\d.]\s*[\d.]\s*\|\s*[\d.]\s*[\d.]\s*[\d.]\s*$/) {
	  s/[^.\d]//g;s/0/./g; $n = $n . $_;
        }
    };
    return $n;
}

sub read_proc($$) {
    my $s; my $pid; my $ret; my $file=""; my $wfile=""; my $e = "";
    $stkc = -1; $stkw = -1;
    if($_[0] eq 'G') {
	print "--------- Generating (#" . $_[1] . ") ---------\n";
        $pid = open2($file, $wfile, $gcmd,$_[1]);
    } elsif($_[0] eq 'S') {
	print "--------------- Solving... ---------------\n";
        $pid = open2($file, $wfile, $scmd);
	print $wfile $_[1];
    } elsif($_[0] eq 'U') {
	print "--------------- Solving... ---------------\n";
        $pid = open2($file, $wfile, $scmd,'U');
	print $wfile $_[1];
    } else {
	die("Internal error: bad input to read_proc()");
    }
    local @l = ( ); my $n = 0;
    while($_=<$file>) { 
	push(@l, $_); print "> " . $_ if($vflg); 
	$e = $1 if(/^(!!!.*)$/);
	($stkc = $1+0, $stkw = $2+0) if(/\(stk (\d+) (\d+)\)$/);
    }
#    local @l = <$file>;
    close $file; close $wfile; 
    waitpid $pid, 0;
    if($?) {
	return $e if($e); return "ret=$?";
    }; $s = rpe(); return $s;
}

sub read_file($) {
    my $s;
    open FILE,"<",$_[0]; local @l = <FILE>; $s = rpe();
    close FILE; return $s;
}

sub squish($) {
    my $n = 0; my $c; my $bc = 0; my $dc = 0; my $s = $_[0];
    my $os = "#";
    while($s ne "") {
	$c = substr $s, 0, 1; $s = substr $s, 1;
	if($c eq "." || $c eq "0") {
	    $dc++; if($dc==7||$s eq "") {
	           $n |= (($dc==1?0:$dc+8)<<$bc); $bc += 4;  $dc = 0; 
	    }
	} else {
	    if($dc) {
		$n |= (($dc==1?0:$dc+8)<<$bc); $bc += 4;  $dc = 0;
	    }
	    $n |= (($c)<<$bc); $bc += 4;
	}
	while($bc >= 6) {
	    $os .= substr $squstr, $n & 63, 1;
	    $n = $n >> 6; $bc -= 6;
	}
    }

    $os .= substr $squstr, $n, 1 if($bc);
    return $os;
}

sub unsq($) {
    my $n = 0; my $bc = 0; my $os=""; my $i; my $s = $_[0]; my $j;
    if('#' ne substr($s,0,1)) {
	return $s if(81==length($s)); die("Bad compressed sudoku");
    }; $s = substr $s,1; 
    while((length $os)<81) {
	if($bc < 4) {
	    die("Compressed sudoku ends prrematurely") if($s eq "");
	    $i = index $squstr, substr($s, 0, 1); $s = substr($s,1);
	    die("Bad compressed sudoku") if($i == -1);
	    $n = ($i<<$bc) | $n; $bc +=6;
	}
	$bc -= 4; $i = $n & 15; $n = $n >> 4;
	if($i < 10) {
	    $os .= ($i == 0?".":$i);
	} else {
	    for($j=8;$j<$i;$j++) {$os .= '.';}
	}
    } return $os;
}

sub chksq($$) {
    my $i = squish($_[0]); my $j = unsq($_[1]);
    die("Squash check failed") if($i ne $_[1]);
    die("Unsquash check failed") if($j ne $_[0]);
}

sub chk_fi($$) {
    my $i; my $j; my $k = $_[1]; my $n= $_[0];
    if($k) {
	print "================== Inbuilt $n ==================\n";
	$k = unsq($k);
    } else {
	print "================== File $n ==================\n";
	$k = read_file("$n.sudoku");
    }
    die("*** Problem isn't even valid!") if(chk($k)==1);
    print $k, "\n" if($vflg);
    $i = read_proc('S', $k);
    (length $i) == (81*$soff) or die("*** Failed!!!");
    $i = substr $i,81*($soff-1),81;
    die("*** Solution isn't even valid!") if(chk($i));
    die("*** Solution doesn't fit the problem!") if(scmp($i,$k)); 
    if(-f "$n.sol") {
	$j = read_file("$n.sol");
	die("*** 'Correct' solution isn't valid!") if(chk($j));
	die("*** Mix-up - solution is for another problem!") if(scmp($j,$k));
	($i eq $j) or die("*** Wrong answer!!!");
    }
    print "*** Correct answer\n";
}

sub chk_fail($$$$) {
    my $i = $_[2]; my $e; my $n = $_[0]; my $c=$_[1]; my $o = $_[3];
    print "================ Bad problem '$n' ================\n";
    $i = unsq($i) if($i =~ /^#/);
    $i = read_file("$n") unless(81 == length $i);
    print $i . "\n" if($vflg);
    die("*** Invalid file!") if(81 != length $i);
    if($o eq 'I') {
	die("*** Internal error - chk() passed invalid sudoku!") 
	    if(chk($i)!=1);
    } 
    $o = 'S' if($o ne 'U');
    $e = read_proc($o, $i);
    if($c) {
	print "Expected '" . $c . "' got '" . $e . "'\n";
    } else {    return 2 unless((length $c) == 81);
    return 0;

	print "Got '" . $e . "'\n";
    }
    die("*** Didn't spot a bad problem!") if($e !~ /^!!! /);
    die("*** Took too long to spot bad problem!") if($_[3] eq 'I' && $stkw);
    die("*** Failed test!") if($c ne "" && $c ne $e);
    print "*** Detected bad sudoku successfully\n";
}

sub genrand($$) {
    my $i; my $j; my $k; my $s = $_[0]; my $c = $_[1];
    if($s) {
	print "================== #$s ==================\n";
    } else {
	print "================== Random ==================\n";
	$s = int(rand(999999999)) unless($s);
    }
    $i = read_proc('G', $s);
    (length $i) == (81*3) or die("*** Failed!!!");    
    $j = substr $i,81,81;
    $k = substr $i,81*2,81;
    print $k . "\n" . $j . "\n" if($vflg);
    die("*** Problem isn't even valid!") if(chk($k)!=2);
    die("*** 'Correct' solution isn't!") if(chk($j));
    die("*** Solution doesn't fit the problem!") if(scmp($j,$k)); 
    print "*** Generated problem OK\n";

    $c = unsq($c) if($c);
    if($c && ($c ne $k)) {
	if($rflg) {
	    print "\n  Sudoku generated was valid, but not the expected one.\n",
	    "  This probably isn't serious, and may not even be an error.\n",
	    "  To ignore this, add the -R option to the command line.\n\n";
	    die("*** Not expected sudoku!") 
	} else {
	    print "*** Not expected sudoku, but -R specified; ignoring\n";
	}
    }

    $i = read_proc('S', $k);
    (length $i) == (81*2) or die("*** Failed!!!");
    $i = substr $i,81,81;
    print $i . "\n" . $j . "\n" if($vflg);
    ($i eq $j) or die("*** Wrong answer!!!");
    print "*** Correct answer\n";
}

sub scmp($$) {
    my ($i,$a,$b);
    for($i=0;$i<81;$i++) { 
	$a = substr $_[0], $i, 1; 
	$b = substr $_[1], $i, 1; 
	return 1 unless($a eq $b || $a eq "." || $b eq ".");
    }; return 0;
}

sub chk($) {
    my @a; my $n; my $i; my @v; my $c = 0;
    for($n=0;$n<81;$n++) { $v[$n] = gi($_[0], $n); $c++ if($v[$n]); }
    if($zoom) {
      return 2 unless($c == 81);
      return 0;
    }
    for($n=0;$n<81;$n++) { $a[$n] = 0; }
    for($n=0;$n<81;$n++) { 
	next unless $v[$n];
	$i = int($n/9)*9 + $v[$n]-1;
	if($a[$i]) { 
	    print "row ". int($n/9) . " many " . ${$v[$i]} . " \n";
	    return 1; 
	}; $a[$i] = 1;
    }
    for($n=0;$n<81;$n++) { $a[$n] = 0; }
    for($n=0;$n<81;$n++) { 
	next unless $v[$n];
	$i = ($n % 9)*9 + $v[$n]-1;
	if($a[$i]) { 
	    print "col ". (($n % 9)+1) . " many " . ${$v[$i]} . " \n";
	    return 1; 
	}; $a[$i] = 1;
    }
    for($n=0;$n<81;$n++) { $a[$n] = 0; }
    for($n=0;$n<81;$n++) { 
	next unless $v[$n];
	$i = ( int(($n % 9)/3)+int($n/27)*3 )*9 + $v[$n]-1;
	if($a[$i]) { 
	    print "box ". (int(($n % 9)/3)+int($n/27)*3+1) . " many " . ${$v[$i]} . " \n";
	    return 1; 
	}; $a[$i] = 1;
    }
    return 2 unless($c == 81);
    return 0;
}

sub gi($$) {
    my $n = substr $_[0], $_[1], 1;
    $n = 0 if($n eq "."); $n = $n + 0;
    return $n;
}

srand;
if(!$zoom) {
    print "================ Unsquash Test ==============\n";
    chksq(".............9.........1.............4..1..1....................2.."
	  . "...1..........", "#vnvGvTaox.u0xv");
    chksq("........2.....5.3..58..7...326....158...........362..8..7...4.....5"
	  . "1....6...841..", "#PIdBjWoe7IGHF,8Yii6tUXBbLShC");
    print "*** Passed\n"
}
if($fint) {
    chk_fi("blank","#.......z");
    chk_fi("tough1","#PIdBjWoe7IGHF,8Yii6tUXBbLShC");
    chk_fi("insane1","#KxlV7Jds4.WOa53QQBCEEgz.gF");
    chk_fi("insane2","#yTuoJQgMACknQkyi6AGEQJasobJMfpJ");
    chk_fi("insane3","#LxVHGkHPvBCEEU7N697cyvBMLBpC");
    chk_fi("insane4","#rAZf9MeZQ9QyjVAt2hst0SgUIc5iM");
    chk_fi("insane5","#t0BU2SlN9oHkAVu9QqFjHIw4ECSRM");
    chk_fi("wikipedia","#boHplm6Iqdaqkiu0hnapkejejKqpWp0C");
}
if($ffile) { foreach(glob("*.sudoku")) {
    chk_fi($1,"") if(/^(.+)\.sudoku$/);
} }
if($fbad) {
  chk_fail("row","!!! row 5","#vnvGvTaox.u0xv",'I');
  chk_fail("col","!!! col 5","#vnvGvTa8.Gt0xv",'I');
  chk_fail("box","!!! box 5","#vnvGe4kG..q0xv",'I');
  chk_fail("tele13-mang.bad","","",'S') if(-f "tele13-mang.bad");
  chk_fail("unique",'',"#.XwoFq3OixRhPPmooeL1Vw2iUo",'U')
}
if($fgen) {
    genrand(951464,"#axiBBIPgN1RPQCEc4rDECkbYqome7A");
    genrand(975900,"#GCnOKdlh.7BkvWCQwh.WcqBEoakC");
    genrand(168996,"#tdjO0ahA3LbsmOg55K3G1wIY3Ses");
    genrand(250762,"#s8GCxADk.WnpFq2KawIk6cVTu4HA");
    genrand(909990524,"#t0BU2SlN9oHkAVu9QqFjHIw4ECSRM");
    genrand(105761662,"#LxVHGkHPvBCEEU7N697cyvBMLBpC");
    genrand(100440625,"#yTuoJQgMACknQkyi6AGEQJasobJMfpJ");
    genrand(957749705,"#Q0GnEIAu1OEyHLaU6kXQeCy8e9G");
    genrand(914809978,"#NCDJw9bt5RjGijAt2WhbN,EkQcAC");
    genrand(774849286,"#soDgbcqF.D3a1mTiCHlBBkIQa,7Z0C");
    genrand(862977530,"#xvTUcBJBnwWtHc0i6oyGM5jeYnrQK");
    genrand(103980293,"#oKadABTt4vpO0.nGixnGQpEcashWmo");
    genrand(122255857,"#34lWbkaAkBzr2rhelmblAyCEnS68G");
    genrand(596684993,"#cB2DhAJcMSxiANgo1sBYJfKCpV.vko");
}
for($n = 0; $n<$gcnt; $n++) {
    genrand(0,"");
}
print "\n######### All tests passed! #########\n\n";
