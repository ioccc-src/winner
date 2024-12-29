#!/usr/bin/env perl
#
print "#define C \" \"\n";
print "#define O( _ ) # _\n";
print "#define R( n , d ) e ( n , d )\n";
print "#define e(p,o)o##p\n";
print "#define D O ( % ) O ( l ) O ( d )\n";
print "#define U R ( e ( g , n ) , e ( o , l ) )\n";
print "#define M H ( R ( e ( c , i ) , t ) , R ( e ( a , t ) , s ) )\n";
print "#define P H ( R ( e ( f , t ) , n ) , R ( e ( i , r ) , p ) ) (\n";
print "#define H(O,r)R(O,r)\n";
print "#include<stdio.h>\n";

while (<>) {
    chop;
    s,/\*.*\*/,,g; # rm one line comments
    s:([^a-z])int:$1R(e(t,n),i):g;
    s:for:R(e(r,o),f):g;
    s:main:R(e(n,i),e(a,m)):g;
    s:([^a-z])char:$1R(e(r,a),e(h,c)):g;
    s:printf \(:P :g;
    s:void:R(e(d,i),e(o,v)):g;
    s:else:R(e(e,s),e(l,e)):g;
    s:while:H(R(e(e,l),i),e(h,w)):g;
    s:struct:H(R(e(t,c),u),R(e(r,t),s)):g;
    s:return:H(R(e(n,r),u),R(e(t,e),r)):g;
    s:sscanf:H(R(e(f,n),a),R(e(c,s),s)):g;
    s:typedef:H(R(e(f,e),e(d,e)),R(e(p,y),t)):g;
    s:unsigned:H(R(e(d,e),e(n,g)),R(e(i,s),e(n,u))):g;
    s,"/", O(/),g;
    s,20,4*5,g;
    s," = ",C O(=) C,g;
    s," %c ",C O(%)O(c)C,g;
    s,"%c",O(%)O(c),g;
    s,"%ld",O(%)O(l)O(d),g;
    s,"\*/\+-",O(*)O(/)O(+)O(-),g;
    s,init,I,g;
    s,param,p,g;
    s,static,M,g;
    s,work,w,g;
    s,cursor,c,g;
    s,normalize,n,g;
    s,fraction,F,g;
    s,num,n,g;
    s,den,t,g;
    s,LONGEST,U,g;
    s,argc,a,g;
    s,argv,v,g;
    s,bitvec,B,g;
    s,mask,W,g;
    s,FMT,D,g;
    s,p_f,f,g;
    s,calc,k,g;
    s,out,o,g;
    s:10:e(0,1):g;
    s:<<:e(<,<):g;
    s:!=:e(=,!):g;
    s:if:e(f,i):g;
    s:\*=:e(=,*):g;
    s:/=:e(=,/):g;
    s:\|\|:e(|,|):g;
    s:&&:e(&,&):g;
    s:42:6*7:g;
    s:(\S): $1 :g unless /^#/;
    s:[ \t]+: :g;
    s:^ ::;
    s: $::;
    unless (/^$/) {
	    $code .= "$_ " unless (/^#/);
    }
}
chop $code;
$code =~ s/(.{31}) /$1\n/g;
@line = split (/\n/, $code);
for ($i = 0; $i <= $#line; ++$i) {
    $_ = $line[$i];
    $rem = $i % 8;
    if ($rem == 0) {
	    s/(.{8})(.{8})(.{8})(.{7})/\t\1\t\2\t\3\t\4/;
    } elsif ($rem == 1 || $rem == 7) {
	    substr ($_,1,1) = "\t";
	    substr ($_,7,1) = "\t";
	    substr ($_,9,1) = "\t";
	    substr ($_,15,1) = "\t";
	    substr ($_,17,1) = "\t";
	    substr ($_,23,1) = "\t";
	    substr ($_,25,1) = "\t";
    } elsif ($rem == 2 || $rem == 6) {
	    substr ($_,3,1) = "\t";
	    substr ($_,7,1) = "\t";
	    substr ($_,11,1) = "\t";
	    substr ($_,15,1) = "\t";
	    substr ($_,19,1) = "\t";
	    substr ($_,23,1) = "\t";
	    substr ($_,27,1) = "\t";
    } elsif ($rem == 3 || $rem == 5) {
	    substr ($_,5,1) = "\t";
	    substr ($_,7,1) = "\t";
	    substr ($_,13,1) = "\t";
	    substr ($_,15,1) = "\t";
	    substr ($_,21,1) = "\t";
	    substr ($_,23,1) = "\t";
	    substr ($_,29,1) = "\t";
    } else {
	    s/(.{8})(.{8})(.{8})(.{7})/\1\t\2\t\3\t\4/;
    }
    print "$_\n";
}
