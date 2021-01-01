#include <stdint.h>
#include <stdio.h>
#include <math.h>
#ifdef _WIN32
#include <io.h>
#include <fcntl.h>
#define main() M();i\
nt main(){setmode(fi\
leno(stdin),O_BINARY\
);return M();}int M()
#endif

#ifndef IDX
#define IDX 1
#endif
#if IDX==1 // float round

              int main(){
          uint32_t i=0,h[20]=
       {0},x=~i/15,f=x*x-x,a=f^x
     ,b=f^x*9,c=~a,d=~b;int64_t z=
    0,g=0,n;for(;d=h[c=h[b=h[a=h[n=
  i=0]+=a,1]+=b,2]+=c,3]+=d,f;){for(;
  n==56?h[h[18]=g,19]=g>>32,f=z>=0:n<
 64;)h[n++/4+4]=x=(z<0?0:(z=getchar())
 >=0?g+=8,z:128)<<24|x>>8;;for(;(x=i>>
 4)<4;a=d,d=c,c=b,b+=x<<n|x>>(32-n))n=
 (i|12)*152%543%82%4+i%4*43/8+4,x=a+((
  x>2?~d|b:x>1?b^d:x?(b^c)&d:(c^d)&~b
  )^c)+h[((x*7/2&5)-~(x*5&6)*i++)%16+
    4],x+=a=fabs(sin(i))*8*(8<<26);
     }for(;n<33;putchar(n++<32?a+=
       a>9?'a'-10:'0':'\n'))a=h[
          n/8]>>(n%8*4^4)&15;
              ;return 0;}

#elif IDX==2 // float square

int main(){uint32_t f=0,x=~f/15,
i=x*x-x,a=i^x,b=i^x*9,n,c=~a,d=~
b,h[20]={0};int64_t z=0,g=0;for(
;d=h[c=h[b=h[a=h[i=0]+=a,1]+=b,2
]+=c,3]+=d,!f;){for(f=64;f==8?h[
h[5]=g,4]=g>>32,z>=0:f;)h[--f/4+
4]=x=x>>8|(z<0?0:(z=getchar())>=
0?g+=8,z:128)<<24;for(;(x=i/16)<
4;a=d,d=c,c=b,b+=x<<n|x>>(32-n))
n=(i|12)*152%543%82%4+i%4*43/8+4
,x=a+((x>2?~d|b:x>1?b^d:x?(b^c)&
d:(c^d)&~b)^c)+h[19-((x*7/2&5)-~
(x*5&6)*i++)%16],x+=a=fabs(sin(i
))*8*(8<<26);}for(;i<33;putchar(
i++<32?a+=a>9?'a'-10:'0':'\n'))a
=h[i/8]>>(i%8*4^4)&15;return 0;}

#elif IDX==3 // integer 62x10, twitter profile cover (3:1)

int main(){uint32_t i=0,x=~i/15,f=x*x-x,a=f^x,b=f^x*9,c=~a,d=~
b,h[20]={0};int64_t e,k,l=566548,m=64336,o=882346,p=585873,n,z
=0,g=0;for(;d=h[c=h[b=h[a=h[e=i=n=0]+=a,1]+=b,2]+=c,3]+=d,f;){
for(;n==56?h[h[18]=g,19]=g>>32,f=z>=0:n<64;)h[n++/4+4]=x=x>>8|
(z<0?0:(z=getchar())>=0?g+=8,z:128)<<24;;for(k=~e<<40;(x=i/16)
<4;a=d,d=c,c=b,b+=x<<n|x>>(32-n))n=((e*m+k*p)>>21)+e*l+k*o,k=(
((k*m-e*p)>>21)+k*l-e*o)>>20,e=n>>20,n=(i|12)*152%543%82%4+i%4
*43/8+4,x=a+((x?x>2?~d|b:x>1?b^d:(b^c)&d:(c^d)&~b)^c)+h[((x*7/
2&5)+(x*5%8|1)*i++)%16+4]+(e>>8^e>>40);}for(;n<33;putchar(n++<
32?a+=a<10?'0':'a'-10:'\n'))a=h[n/8]>>(n%8*4^4)&15;;return 0;}

#elif IDX==4 // float 65x8, linkedin profile cover (4:1)

int main(){uint32_t i=0,x=~i/15,f=x*x-x,a=f^x,b=f^x*9,n,c=~a,d=~b
,h[20]={0};int64_t z=0,g=0;for(;d=h[c=h[b=h[a=h[n=i=0]+=a,1]+=b,2
]+=c,3]+=d,f;){for(;n==56?h[h[18]=g,19]=g>>32,f=z>=0:n<64;)h[n++/
4+4]=x=x>>8|(z<0?0:(z=getchar())>=0?g+=8,z:128)<<24;for(;(x=i/16)
<4;x+=a=fabs(sin(i))*8*(8<<26),a=d,d=c,c=b,b+=x<<n|x>>(32-n))n=(i
|12)*152%543%82%4+i%4*43/8+4,x=a+(x?(x>2?~d|b:x>1?b^d:(b^c)&d)^c:
((c^d)&b)^d)+h[((x*7/2&5)+(x*5%8|1)*i++)%16+4];}for(;n<33;putchar
(n++<32?a+=a>9?'a'-10:'0':'\n'))a=h[n/8]>>(n%8*4^4)&15;return 0;}

#endif
