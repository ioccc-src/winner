#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#undef D
#undef E
#undef U
#ifndef C
#define I int n,r;
#define D(N) void*N(void*);
#define C pthread_create
#define E int l;char *ak(char *u){return (*u=(l+=6,*u)=\
='@'?'K':*u=='.'?'P':*u=='-'?'M':tolower(*u))?ak(u+1)-1:u;}
#define U int
#elif ! defined J
#define H "x\0\b\0\200\1\0\0\0\0\377\377\377,\0\0\0\0x\0\b\0\0\3"
#define E tn; char h[30]="GIF87a" H;void *(*fn[25])(void*)={
#define U };
#define D(N) N,
#define L return fwrite("\1\t\0;",1,4,stdout)!=4;
#define K {I for(r=0;r<8;r++)for(n=0,putchar(l);n<l;n++)putchar(B[r][n]|8)
#define J h[6]=h[24]=l=l-3;fwrite(h,1,30,stdout);K
#else
#define T pthread_t
#define E char B[8][256];
#define U int main(int c,char **a) { bdefhklmnprtuvwxyz57(ak(a[1]));J;}L}
#define D(N)  void *N(void *y) {\
    static I char *x=y;\
    T t=0;\
    if(!n && (r=tn)<24) C(&t,NULL,fn[++tn],y);\
    if(*x&&strchr(# N,*x))  B[2+r/5][2+n*6+r%5]=16;\
    n++;\
    if(*x) N(x+1);\
    if(t) pthread_join(t,&y);\
    return y;\
}
#endif

E

D(bdefhklmnprtuvwxyz57)
D(bcdefgiopqrstz23567890K)
D(abcdefgjopqrstz123567890K)
D(cefghkoqstz23457890K)
D(mntuvwxyz7)

D(bcdefghklmnopqrsuvw256890K)
D(aimnxy1)
D(jkt14)
D(abdhmprxyz0)
D(mnoquvw237890K)

D(abcdefghklmnopqruvw560K)
D(befhikprs45689MK)
D(befghjmnqprstwxyz156890MK)
D(dghs234789M)
D(amnoquvw90K)

D(abcdefghjklmnopqruw4680K)
D(aivxz40PK)
D(ajkrtwy1247PK)
D(abdghnqvx456K)
D(amnosuw34890K)

D(abdefhklmnprxz25_)
D(bcdegijloqsuwz12356890_PK)
D(bcdegloqstuvyz123567890_PK)
D(cehklorsuwz1234890_K)
D(amnqxz2_K)

U

#ifndef T
#include __FILE__
#endif
