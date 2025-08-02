#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "jpeglib.h"
#ifdef _WIN32
#include <fcntl.h>
#define main X(); void M(); int main(){ int \
i; F(i,2)_setmode(i,_O_BINARY); M(); } void M
#endif
#define J(x) jpeg_##x;
#define O S.comp_info[j].
#define F(a,b) for(a=0; a<b; a++)
#define C(j,v) g=z=(v>0)*7; A(j,8,I[v+m+s,*2)
#define D(o,s) { int d,e,h,p,q,t,u,v,T[64]; N(\
=c[z+8*,+1024; T[,*8+z]=f>>11; f=) N(=T[z*8+,-(~\
H<<17); (o+s*z) [,]=(f>>=18)&-H?~(f>>31|-H):f; f=)}
#define W(x) J(x##_compress(&d))J(x##_decompress(&S))
#define A(j,n,v,w) F(j,n){ q=P[a=z*8+g]-v*z+g]; p=T[i]\
[a]w; t=r*2+(q<0?q:-q); p*=t*=t<0?0:t; u-=q*t*p; l+=p*p;}
#define B(o,n)if(i o 7)F(z,15-n)A(g,n,P[b=(n&9)+8,-T[i][b])
#define N(A,B,C) F(z,8){ d=t A 2]; d+=a A 6]; d*=4433; h=g A\
 0]<<13; e=h+=p A 4]<<13; u=g-=p; u+=a=d-a*15137; g-=a; e+=d+=\
t*6270; h-=d; p=a A 7]; t=b A 5]; p+=v A 3]; t+=d A 1]; q=(a+d)*\
7373; f=(p+t)*9633; p=p*16069-f; f-=t*3196; t=(b+v)*20995; a=q+p-a\
*2446; p+=t-v*25172; t-=f+b*16819; q-=f+d*12299; f=e-q B 0 C e+q B 7\
 C u-p B 1  C u+p B 6 C g-t B 2  C g+t B 5 C h-a B 3  C h+a B 4 C 0; }
#define L F(y,h/8){ JBLOCK*n=*(*S.mem->access_virt_barray)(v=&S,R[j],\
y,1,1); F(x,w/8){ JCOEF*c=n[x]; UINT16*V=Q->quantval; m=(y*s+x)*8+s+1;
int main(){ struct J(compress_struct d)struct J(error_mgr e)JQUANT_TBL
*Q; struct J(decompress_struct S)void*v,**R; int a,b,i,j,k,g,x,y,z,w,h
,s,r,K,H=MAXJSAMPLE+1,m,f,E,c[64]; JSAMPLE*I,P[64]; float T[64][64],q=
H*2,p,t,u,l,X,Y; d.err=S.err=J(std_error(&e))W(create)J(stdio_dest(&d,
stdout))J(stdio_src(&S,stdin))J(read_header(&S,1))R=v=J(read_coeffici\
ents(&S))F(i,64){ F(k,64)c[k]=k-i?0:q; D(P,8)F(k,64)T[i][k]=(P[k]-H/2)
/q; } F(j,S.num_components)if((Q=O quant_table)){ w=O width_in_blocks*
8; O quant_table=0; h=O height_in_blocks*8; s=w*8+2; if((I=malloc((h+2
)*s*sizeof(*I)))){ F(K,3){ L F(i,64&&!K)c[i]*=V[i]; D(I+m,s)} } F(i,s)
*I=I[s],I[h*s+s]=I[h*s],I++; F(y,h)*I=I[1],I[w+1]=I[w],I+=s; I-=s*y+s; 
L X=Y=0; F(E,2){ for(f=k=71; (i=k<8?k*8-8:k%8-7?k-7:k/8+55); ){ r=V[i]
; if(E)u=(b=c[i])*q; else{ if(f&&k-i-7)D(P,8) u=l=0; B(&,7)B(>,8)C(g,-
s)C(g,s)C(z,-1)C(z,1)u/=l; u+=b=c[i]; } z=u+(u>0)-0.5f; g=(b+(b<0?-r:r
)/2)/r*r; a=((g<1)-r)/2+g; r-=g?1-a:r+a; f|=b^=c[k=i]=a=z>r?r:z<a?a:z; 
X+=a*g; Y+=g*g; } Y>X?q=Y/X:E++; } } } } free(I); } } F(k,NUM_QUANT_T\
BLS)if((Q=S.quant_tbl_ptrs[k]))F(i,64)Q->quantval[i]=1; J(copy_critic\
al_parameters(&S,&d))J(write_coefficients(&d,v=R))W(finish)W(destroy)}
