#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "jpeglib.h"
#define J(x) jpeg_##x;
#define A B(p=t+Z*b+y*S;l=w*h;for(u=j=0;l&&j<b;p++)X->c[j\
++]=(p[w*b+h*S]-p[w*b]-p[h*S]+*p+l/2)/l,-),u+=z*z; X->d=u;}
#define G(h,n) D.comp_info[0].h##_samp_factor=1;D.image_##n;
#define B(e,f) {int x,Z=X->x,y=X->y,w=X->w,h=X->h;e;for(;h--\
;y++)for(x=Z;x<w+Z;x++)for(j=0;j<b;j++)z=d[y*s+x*b+j]f X->c[j]
#define H(W,H,w,h,B,i) for(B=z=i=0;++z<w;u>B?B=u,i=z:0)for(u=j\
=0;p=t+x*b+y*S+j,j<b;j++)K=p[z*W+h*H]-p[z*W],Q=N->c[j]*h,L=p[w*\
W+h*H]-p[w*W]-K-Q*(w-z),K-=p[h*H]-*p+Q*z,u+=L<0?-L:L,u+=K<0?-K:K;
#define W(r,X,a,o,Y,b,c,S) {S J(error_mgr E)S J(c##_##S D);D.err=\
J(std_error(&E))if(!(F=fopen(*++V,#r)))break;J(create_##c(I=&D))J(\
stdio_##o(I,F))Y;J(start_##c X)while((y=D.a##_scanline)<h)R=d+y*s,J\
(b##_scanlines(I,O=&R,1))J(finish_##c(I))J(destroy_##c(I))fclose(F);}
int main(int c,char**V){while(c==4){intptr_t w,h,s,b,S,j,i,x,y,v,q,z,k
,l,g=JCS_RGB,n=atoi(*++V);uint8_t*d;void*O,*R,*F,*I;int64_t*p,e,f,u,K,L
,*t,Q,U=1;struct{uint16_t x,y,w,h;uint8_t c[4];int64_t d;}*P,*N,*X,o={0}
;W(rb,(I);w=D.output_width;h=D.output_height;b=D.output_components;L=n=n
<1?1:n>w*h?w*h:n;K=S=(s=w*b)+b;K=sizeof(o)*L+(u=K*h+K)*9;if((L=(size_t)K
)-K||!(t=malloc(K)))break;X=P=O=t+u;d=O=P+n,output,src,J(read_header(I,U
))D.do_fancy_upsampling=0;D.out_color_space=g,read,decompress,struct)fo\
r(i=j=0;j<b;j++)for(x=j-S,z=j-b;x<S*h;x+=b)t[x+S]=x<0?y=0:t[x]+(u=y--?u+
d[z+=b]:(y=w,0));;o.w=w;o.h=h;*X=o;A for(;N=X=P,U&&++i<n;){for(U=j=0;j++
<i;X++)U=X->d>U?(N=X)->d:U;;o=*N;v=o.w;q=o.h;x=o.x;y=o.y;H(b,S,v,q,e,k)H
(S,b,q,v,f,l)e<f?o.y+=N->h=l,o.h-=l:(o.x+=N->w=k,o.w-=k);*X=o;A X=N;A}f\
or(;i--;X++)B(,=);}W(wb,(I,1),next,dest,D.input_components=b;D.in_color\
_space=g;J(set_defaults(I))G(h,width=w)G(v,height=h)J(set_quality(I,100,
D.optimize_coding=1)),write,compress,struct)free(t);return 0;}return 1;}

