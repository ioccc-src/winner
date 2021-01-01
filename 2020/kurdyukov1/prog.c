#include <stdint.h>
#include <stdio.h>
#ifdef _WIN32
#include <io.h>
#include <fcntl.h>
#define main() M();i\
nt main(){setmode(fi\
leno(stdin),O_BINARY\
);return M();}int M()
#endif

                int main()
           {uint32_t h[20]={0},
        i=0,x=~i/15,f=x*x-x,a=f^x,
      b=f^x*9,c=~a,d=~b;int64_t z=0,
     g=0,l=566548,p=585873,o=882346,e
   ,m=64336,k,n;for(;d=h[c=h[b=h[a=h[i=
   0]+=a,1]+=b,2]+=c,3]+=d,f;){for(n=64
  ;n==8?h[h[5]=g,4]=g>>32,f=z>=0:n;)h[4+
 --n/4]=x=(z<0?0:(z=getchar())>=0?g+=8,z:
 128)<<24|x>>8;;for(e=0,k=~e<<40;(x=i/16)
 <4;a=d,d=c,c=b,b+=x<<n|x>>(32-n))n=((e*m
 +k*p)>>21)+e*l+k*o,k=(((k*m-e*p)>>21)+k*
  l-e*o)>>20,e=n>>20,n=(i|12)*152%543%82
   %4+i%4*43/8+4,x=a+((x>2?~d|b:x>1?b^d
   :x?(b^c)&d:(c^d)&~b)^c)+h[19-((x*7/2
     &5)-~(x*5&6)*i++)%16]+(e>>40^e>>
      8);}for(;i<33;putchar(i++<32?a
        +=a>9?'a'-10:'0':'\n'))a=h
           [i/8]>>(i%8*4^4)&15;
                return 0;}
