#define JPEG_INTERNALS
#include "jinclude.h"
#include "jpeglib.h"
#include "jdct.h"
#define O S->comp_info[j]
#define F(a,b) for(a=0;a<b;a++)
#define C(j,v) g=z=(v>0)*7;A(j,8,I[v+m+s,*2)
#define A(j,n,v,w) F(j,n)q=P[a=z*8+g]-v*z+g],p=T[i\
][a]w,t=r*2+(q<0?q:-q),p*=t*=t<0?0:t,u-=q*t*p,l+=p*p;
#define L F(y,h/8){JBLOCKROW n=(*S->mem->access_virt_\
barray)((j_common_ptr)S,src_coef_arrays[j],y,1,1)[0];F(\
x,w/8){JCOEF*c=n[x];UINT16*V=Q->quantval;m=(y*s+x)*8+s+1;
#define D(x,o) O.dct_table=N;jpeg_idct_islow(S,&O,c,G+x,o);
#define B(o,n) if(i o 7)F(z,15-n)A(g,n,P[b=(n&9)+8,-T[i][b])
#define jpeg_read_coefficients(A) jpeg_read_coefficients(A);\
{j_decompress_ptr S=A;int w,h,y,x,a,b,g,z,r,i,k,j=0,s,K,m=MAXJ\
SAMPLE+1,f,E;JQUANT_TBL*Q;MULTIPLIER N[64];JSAMPLE*I,R[MAXJSAMP\
LE*6+6]={0},P[64],*G[16];float T[64][64],q=m*2,p,t,u,l,X,Y;S->sam\
ple_range_limit=R+m;F(i,8)G[i]=P+i*8;F(i,64)N[i]=1;F(i,m)R[m+i]=R[\
5*m+i]=i;F(i,3*m/2)R[i+m*2]=m-1;F(i,64){JCOEF c[64]={0};c[i]=q;D(0,0\
)F(k,64)T[i][k]=(P[k]-m/2)/q;}F(j,S->num_components)if((Q=O.quant_tab\
le)){O.quant_table=0;w=O.width_in_blocks*8;h=O.height_in_blocks*8;s=w\
*8+2;if((I=malloc((h+2)*s*sizeof(*I)))){F(i,8)G[i+8]=I+s*i;F(K,3){L F\
(i,64&&!K)c[i]*=V[i];D(8,m)}}F(i,s)*I=I[s],I[h*s+s]=I[h*s],I++;F(y,h)\
*I=I[1],I[w+1]=I[w],I+=s;I-=s*y+s;L X=Y=0;F(E,2){for(f=k=71;(i=k<8?k*\
8-8:k%8-7?k-7:k/8+55);Y+=g*g){r=V[i];if(E)u=(b=c[i])*q;else{u=l=0;if(\
f&&k-i-7){D(0,f=0)}B(&,7)B(>,8)C(g,-s)C(g,s)C(z,-1)C(z,1)u/=l;u+=b=c[\
i];}z=u+(u>0)-0.5f;g=(b+(b<0?-r:r)/2)/r*r;a=((g<1)-r)/2+g;r-=g?1-a:r+\
a;f|=b^=c[k=i]=a=z>r?r:z<a?a:z;X+=a*g;}Y>X?q=Y/X:E++;}}}}free(I);}}F(\
k,NUM_QUANT_TBLS)if((Q=S->quant_tbl_ptrs[k]))F(i,64)Q->quantval[i]=1;}
#include "jpegtran.c"
