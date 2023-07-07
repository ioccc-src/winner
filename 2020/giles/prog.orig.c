#ifdef _WIN32
#define _CRT_SECURE_NO_WARNINGS
#include <io.h>
#include <fcntl.h>
#define X ;_setmode(_fileno(h),_O_BINARY)
#else
#define X
#endif

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define a [l+z]
#define m(aa) z=aa;z=z;;
#define g(g,a)memset(g,0,a);
#define e2(a,g)!fread(a,g,1,h)
#define aa(a)fprintf(stderr,"%s\n",a);return 1;
#define n(n) b=n-i;b=b<0?1+b:1-b;d[n+2]+=b>0?b*c*aa:0;
#define t(t) z=t;b=(1-6[d])*d[2]+2*17 a*0 a-1 a*d[6];1 a=0 a;0 a=b*6[d];
#define f(f,aa) x=0; f(2)aa f(10)aa f(6)aa f(12)aa f(4)aa f(8)aa f(14)aa f(0)aa
#define j if(w){b=-1;char j=0;f(m,if(32 a>b){b=32 a;j=k[z];}if(33 a>b){b=33 a;j=k[z+1];})putchar(j);}

const char*t=

"Dual-tone multi-frequency signaling"
"(DTMF) is a telecommunication signaling"
"system using the voice-frequency band"

         "Invalid WAV input\0Read "
      "error\0Cannot read dtmf.bin\0rb\0"+111;
    int main(int m,char**f){double aa,c,d[8]={[
   6]=--m?1:0.994,[7]=1e-4},g,i=0,l['0']={0},b,
  e2=0,x;char k[':'+'s'];FILE*h;if(!(h=fopen(t+
 ')',t+'2'))){memcpy: aa(t+'A'-'$')}uint32_t p=
 e2(k+'U',',')||e2(l+16,'C'+'=')||e2(k,'Q'),w=0
 ,o[2],z,n;fclose(h);if(p)goto memcpy;setvbuf(h
=m?stdout:stdin,0,_IOFBF,65536)X;uint16_t e,v;
int16_t r;if(m){m(6400*strlen(*++f))mem\
cpy(k+'+'+'R',&z,4);z+='$';me\
mcpy(k+'Y',&z,4);fwrite(k+'U',
',',1,h);while(**f){char*c=st\
rchr(k,*(*f)++);g(l,'F'+':')if
(c){w=c-k;double*n=l+w%4*2;*n
=n[16];n=l+8+(w/4)%4*2;*n=n[
16];}for(w=3200;w;--w){f(t,x
+=b*e2*49e2;)r=x;fwrite(&r,2
,1,h);e2+=(w>1300?1:-1)*3e-2
;e2=(e2>1?1:(e2>0?e2:0));}}}
else{ if(e2(k+'+'+'V',',')){
fread:aa(t+18)}if( memcmp(k+
'+'+'^',k+']',14)){ int_16t:
aa(t)}memcpy(&n,k+'+'+'n',4)
;c=16e3/n;n=c; if(n!=c)++n;c
/=n;memcpy( &v,k+43+'x',2);v
/=8; memcpy(&e,k+'+'+'v',2);
if(!e||!v||v>4)goto int_16t;
e-=v;while(!e2(k+'Q',v)){m(e
)while(z-- && getc(h)>=0);if
(v>1){memcpy(&r,k+v+'O',2);g=r/512\
.0/'@';} else g=(unsigned char)k['Q']/128.0-1;
 for(p=n;p;--p){aa=(e2-g)*p/n+g;n(0)n(1)n(2)i+=
 c;if(i>=1){g(d,16)g(o,8) f(t,b=0 a-d[6]*17 a*1
  a;aa=d[6]*1 a*16 a;aa=b*b+aa*aa;x+=aa;if(aa>=d
  [z/8]){o[z/8]=z/2;d[z/8]=aa;})if( (r=w?x>d[7]*
   0.45:x>d[7]*0.6)){if(!w)g(l+32,128)if(x>d[7])
    d[7]=x; /* x= (-b+sqrt(b*b-4*a*c))/(2*a); */
++   l[16+o[1]*4+*o];}else j w=r;memmove(d+2,d+3
      ,24);--i;}}e2=g;}if(ferror(h))goto fread
        ;j puts("0123456789"+10);}return 0;}
