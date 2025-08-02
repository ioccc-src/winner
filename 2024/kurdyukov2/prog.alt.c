#define JPEG_INTERNALS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "jpeglib.h"
#ifdef _WIN32
#include <fcntl.h>
#define main M();int main\
(){int i;F(i,2)_setmode(i,\
_O_BINARY);return M();}int M
#endif
#define J(x) jpeg_##x;
#define O S.comp_info[j]
#define F(a,b) for(a=0;a<b;a++)
#define C(j,v) g=z=(v>0)*7;A(j,8,I[v+m+s,*2)
#define A(j,n,v,w) F(j,n){q=P[a=z*8+g]-v*z+g];p=T[i]\
[a]w;t=r*2+(q<0?q:-q);p*=t*=t<0?0:t;u-=q*t*p;l+=p*p;}
#define W(x) J(x##_compress(&d))J(x##_decompress(&S))
void J(idct_islow(void*,void*,void*,void*,JDIMENSION))
#define D(x,o) O.dct_table=N;J(idct_islow(&S,&O,c,G+x,o))
#define B(o,n) if(i o 7)F(z,15-n)A(g,n,P[b=(n&9)+8,-T[i][b])
int main(){void*v,**R;JQUANT_TBL*Q;int w,h,y,x,a,b,g,z,r,i,k,j
=0,s,m=MAXJSAMPLE+1,K,f,E;struct J(compress_struct d)JSAMPLE*I,P
#define L F(y,h/8){ JBLOCK*n=*(*S.mem->access_virt_barray)(v=&S,R[\
j],y,1,1);F(x,w/8){ JCOEF*c=n[x];UINT16*V=Q->quantval;m=(y*s+x)*8+s+1;
]64],*G[16],U[MAXJSAMPLE*6+6]={0};struct J(error_mgr e)float T[64][64]
,q=m*2,p,t,u,l,X,Y;struct J(decompress_struct S)MULTIPLIER N[64];d.err
=S.err=J(std_error(&e))W(create)J(stdio_src(&S,stdin))J(stdio_dest(&d,
stdout))J(read_header(&S,1))R=v=J(read_coefficients(&S))S.sample_rang\
e_limit=U+m;F(i,8)G[i]=P+i*8;F(i,64)N[i]=1;F(i,m)U[m+i]=U[5*m+i]=i;F(i
,3*m/2)U[i+m*2]=m-1;F(i,64){JCOEF c[64]={0};c[i]=q;D(0,0)F(k,64)T[i][k
]=(P[k]-m/2)/q;}F(j,S.num_components)if((Q=O.quant_table)){O.quant_ta\
ble=0;w=O.width_in_blocks*8;h=O.height_in_blocks*8;s=w*8+2;if((I=mall\
oc(sizeof(*I)*(h+2)*s))){F(i,8)G[i+8]=I+s*i;F(K,3){L F(i,64&&!K)c[i]*=
V[i];D(8,m)}}F(i,s)*I=I[s],I[h*s+s]=I[h*s],I++;F(y,h)*I=I[1],I[w+1]=I[
w],I+=s;I-=s*y+s;L X=Y=0;F(E,2){for(f=k=71;(i=k<8?k*8-8:k%8-7?k-7:k/8+
55);Y+=g*g){r=V[i];if(E)u=(b=c[i])*q;else{u=l=0;if(f&&k-i-7){D(0,f=0)}
B(&,7)B(>,8)C(g,-s)C(g,s)C(z,-1)C(z,1)u/=l;u+=b=c[i];}z=u+(u>0)-0.5f;g
=(b+(b<0?-r:r)/2)/r*r;a=((g<1)-r)/2+g;r-=g?1-a:r+a;f|=b^=c[k=i]=a=z>r?
r:z<a?a:z;X+=a*g;}Y>X?q=Y/X:E++;}}}}free(I);}}F(k,NUM_QUANT_TBLS)if((Q
=S.quant_tbl_ptrs[k]))F(i,64)Q->quantval[i]=1;J(copy_critical_paramet\
ers(&S,&d))J(write_coefficients(&d,v=R))W(finish)W(destroy) return 0;}
