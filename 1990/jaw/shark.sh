for i in "${@?${usage?$0 file...}}";do<"$i"||exit;done
(cat&&tar cbf 1 - "$@"|compress|btoa&&echo w)<<\Z
#!/bin/sh
#
# GENTLE READER -- write this message to file [no headers!]; run "sh file".
#
# [un]shark: By James A. Woods.
# Seed planted by Karl Fox; code intensified by Paul Eggert.
#
# "Cleverly he dialed from within." -- D. Van Vliet, "Trout Mask Replica"
#
PATH=$PATH:. a=atob m=unshark z=zcat
r="rm -f $a $m* $z" v="cc -o $z $m.c"
trap "$r;exit 1" 1 2 13 15
echo decoding...
(:|compress|btoa|$a|$z)2>$m>&2||(sed '1,9s/./#define & /
s/@/[w]/g
s/C/char /g
s/I/;if(/g
s/W/;while(/g
s/Y/%lx /g
s/}/;}/g'>$m.c<<_&&
FX,perror("$m bite: resend"),1;
GgetC()
H(w=g())
K[69001]
PputC
Q256
U*p
Xreturn 0
Zw=QWw--)t@=0
#include<stdio.h>
long M,N,c,f,m,o,r,s,w;y(l){o^=l;m+=l+1;f=f*2+l+(f>>31&1)}int
O,S,e,i,k,n,q,t K;b(g){k=4Wg<k)y(P((C)(w>>--k*8)&255));w=0}CD K,h
K;main(g,V)C**V;{I**V-97)X,a()WG-10)W(g=G)+1&&g-'x')if(g-10)
{I4<k)b(0)Ig>32&g<'v')w=w*85+g-33,++k;else{Ig-'z'|k)F
w=0;k=5}}WG-78)Iscanf("%ldYEYSYRY",&M,&N,&c,&s,&r)-5)F
IM){b(g=3-(M-1&3))Wg--)y(0)}I(M-N|c-o|s-m|r-f)&4294967295)F X}long
g(){CUIm<f&n<k&&(m=(1l<<++n)-1)||O>=S){O=0;S=fread(D,1,n,stdin)*8IS<8)X-1;
S-=n-1}p=D+O/8;q=O&7;O+=n;X,(1<<8-q)-1&U>>q|m&((15<n+q)U[2]*Q|p[1]&255)<<8-q}
a(){CU=D+Q;G;G;k=G;e=k>>7&1;k&=31Ik>16)F
Z,h@=w;n=8;f=Q+e;i=o=HIo<0)X,1;P(i)WH+1){Iw==Q&e){Z;m=n=8;f=QIH<0)X}
c=wIw>=f)U++=i,w=oWw>=Q)U++=h@,w=t@;P(i=h@)Wp>D+Q)P(*--p)
I(w=f)<1l<<k)t@=o,h[f++]=i;o=c}X}
_
($v||$v -Mh)&&ln $z $a)&&$a<<\w>$m-&&$z<$m->$m&&tar xvf $m&&$r
Z
