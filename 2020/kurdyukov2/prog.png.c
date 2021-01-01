#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <png.h>
#define G(n) png_get_##n(J,I);
#define A B(p=t+Z*b+y*S;l=w*h;for(u=j=0;l&&j<b;p++)X->c[j\
++]=(p[w*b+h*S]-p[w*b]-p[h*S]+*p+l/2)/l,-),u+=z*z; X->d=u;}
int main(int c,char**V){while(c==4){struct{uint16_t x,y,w,h;
#define B(e,f) {int x,Z=X->x,y=X->y,w=X->w,h=X->h;e;for(;h--\
;y++)for(x=Z;x<w+Z;x++)for(j=0;j<b;j++)z=d[y*s+x*b+j]f X->c[j]
#define H(W,H,w,h,B,i) for(B=z=i=0;++z<w;u>B?B=u,i=z:0)for(u=j\
=0;p=t+x*b+y*S+j,j<b;j++)K=p[z*W+h*H]-p[z*W],Q=N->c[j]*h,L=p[w*\
W+h*H]-p[w*W]-K-Q*(w-z),K-=p[h*H]-*p+Q*z,u+=L<0?-L:L,u+=K<0?-K:K;
#define W(a,b,c,d,e,f,g,h) if(!(F=fopen(*++V,#a)))return 1;b;J=h\
##create_##g##_struct(PNG_LIBPNG_VER_STRING,0,0,0);I=h##create_i\
nfo_struct(J);h##init_io(J,F);c;h##g##_info(J,I);d;h##g##_image(\
J,R);h##g##_end(J,0); O=&J;h##destroy_##g##_struct e;fclose(F);f;
uint8_t c[4];int64_t d;}*P,*N,*X,o;uint8_t**R,*d;intptr_t n=atoi(
*++V),l,h,s,b,S,i,j,x,y,v,q,z,k,w;int64_t*p,e,f,u,K,L,*t,Q,U;void
*O=&K,*J,*I,*Z,*F;W(rb,if(png_sig_cmp(O,0,fread(O,U=1,8,F)))break
,png_set_sig_bytes(J,8),w=G(image_width)h=G(image_height)png_rea\
d_update_info(J,I);y=8-G(bit_depth)b=G(channels)c=G(color_type)L=
n=n<1?1:n>w*h?w*h:n;K=S=(s=w*b)+b;K=h*sizeof(*R)+sizeof(*X)*L+(u=
K*h+K)*9;if(y||(L=(size_t)K)-K||!(R=malloc(K)))break;t=O=R+h;X=P=
O=t+u;for(d=O=P+n;y<h;y++)R[y]=d+y*s,(O,Z=&I,0);for(X->x=X->y=i=j
=0;j<b;j++)for(x=j-S,z=j-b;x<S*h;x+=b)t[x+S]=x<0?y=0:t[x]+(u=y--?
u+d[z+=b]:(y=w,0)),X->w=w;X->h=h;A for(;N=X=P,U&&++i<n;){for(U=j=
0;j++<i;X++)U=X->d>U?(N=X)->d:U,read,png_)o=*N;v=o.w;q=o.h;x=o.x;
y=o.y;H(b,S,v,q,e,k)H(S,b,q,v,f,l)e<f?o.y+=l,o.h-=N->h=l:(o.x+=k,
o.w-=N->w=k);*X=o;A X=N;A}for(;i--;X++)B(,=);}W(wb,,png_set_IHDR(
J,I,w,h,8,c,0,0,0),,(O,Z),free(R),write,png_)return 0;}return 1;}

