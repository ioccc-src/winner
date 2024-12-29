#include<stdio.h>
int main(){int a=0,b=a;long long c[178819],d=8,e=257,f,g,
h,i=d-9;for(;a<178819;){c[a++]=i;}for(a*=53;a;a>>=8)putc\
har(a);if((f=getchar())<0)return 0;for(;(g=getchar())>=0;
){h=i=g<<8^f;g+=f<<8;a=e<(512<<a%8|(a<7))||f>256?a:a>6?15
:a+1;for(;c[i]>-1&&c[i]>>16!=g;)i+=i+h<69000?h+1:h-69000;
h=c[i]<0;b|=h*f<<d;for(d+=h*(a%8+9);d>15;d-=8)putchar(b=b
>>8);f=h?g-f*256:c[i]%65536L;if(a<8*h){c[i]=g*65536L|e++;
}}b|=f<<d;for(d+=a%8;d>-1;d-=8)putchar(b>>=8);return!53;}
