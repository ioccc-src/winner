#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define u8 unsigned char
#define u32 unsigned int
#define I int
#define R rand()
#define M (u8*)malloc(a)
#define P [i*D+j]
#define N if(k==0){if(k%10000<7)k++;}else if(k==11){if(r%10000<11)k--;}else{if(r%400<7)k++;else if(r%400>393)k--;}
#define O(a) printf("%c", a)
                            char 
                            b[12]=
                             {32,
                             32 ,
      44,58,59,33,63,123,36,37,35,64}; u8 l[45]={206,238
    ,238,170,132,170,170, 132,174,170,132,172,206,228,234,
    0,0,0,214,198,124,214,198,254, 214,198,198,214,254,198
  ,214,254,198,214,198,198, 124,198,198,124,198,254,108,198,
  124};I main(int w,char **z) {I D= atoi(z[1]),W= atoi (z[2]
 ),i=0,k=0,/*P O L I C E     P U B L I C    B O X */r=0,c=0,a,
 j,y,eg,ql;/*                  C A L L            */u8 *s, *t
  ,*u ,*v,*h,*g;u8 q[400 ]={0};float f,m, e=0.878f,o=0.0f;a=
  sizeof(u8)*D*W;eg=D/4;ql=W/4;s=M;t=M;u=M;v=M;h=M;g=M;srand
  (y);while(i<W){j=0;while(j< D){s P=9+R%3;u P=9+R%3;h P=0;g 
  P=0;++j;}    ++    i;    }i=0;a=4    ;k    =3    ;while(i<
  15){j=0;     a=    0;    while(j<    24    ){    q[i*24+j]
  =(l[(j/8     +i    *3    )]>>(7-(    j%    8)    ))&1;++j;
  }++i;}i=0;while(i<W-ql*2){j=0;while(j<D-eg*2-1){h[(i+ql)*D
  +j+eg]=(q    [(    i*    30/W)*24    +j    *48   /D])*11;g
  [(i+ ql)*    D+    j+    eg]=h[(i    +ql   )*    D+j+ eg];
  ++j;}++i;    };    eg    =(u8)((D    *(    1-    e))/2);ql
  =(u8)((W*(1-e))/2);for(;c<280; ++c){;i=0;printf("\x1b[H");
  while(i<W){j=0;while(j<D){if(c<0x6E||(c>0x78 &&c<170)){f=(
  float)i*e/*  TELEPHONE */+2*ql;m=(float)j*e+eg;t P=(s[(I)(
  f)*D+(I)(/*    FREE    */m)]+s[(I)(f+1)*D+(I)(m)]+s[(I)(f)
  *D+(I)(m+/* FOR USE OF */1)] +s[(I)(f+1)*D+(I)(m+1)])>>2;}
  if((c>70 /*   PUBLIC   */&&c<0x8c)||(c>0xaa&&c<0x118)){f=(
  float)i*e/* ========== */+ql;m=(float)j*e+eg;v P=(u[(I)(f)
  *D+(I)(m)/*  ========  */]+u[(I)(f+1)*D+(I)(m)]+u[(I)(f)*D
  +(I)(m+1)/*PULL TO OPEN*/]+u[(I)(f+1)*D+(I)(m+1)])>>2;}if(
  c>175&&c<280){if(c%5==0)g[(I)((i*0.898+ql))*D+(I)(j*0.898+
  eg)]=h P;}++j;}++i;}i=0;while(i<W){j=0;while(j<D){if(c<110
  ||(c>120&&c<170 )){k=t P;r=R;N;s P=(u8)k;}if((c>70&&c<140)
  ||(c>170&&c<280)){k=v P;r=R;N;u P=(u8)k;}if(c<89)O(b[s P])
  ;else if(c<0x78&&c>89)O(b[(I)(s P*(1-o)+u P*o)]);else if(c
  ==0x78)s P=7+R%3;else if(c>120&&c<140) {if(j<D/2)O(b[(I)(u 
  P*(1-o)+s P*o)]);else O(b[(I)(u[i*D+D-j]*(1-o)+s[i*D+D-j]*
  o)]);} else if(c<170&&c>140){if(j<D/2){if(h P){s P =(u8)(h
  P*o*(c%2==0));O(b[(I)(h P*o*2)]);}else O(b[s P]);}else{if(
  h[i*D+D-j]){s P=(u8)(h P*o*((c&1)==0));O(b[(I)(h[i*D+D-j]*
  o*2)]);}else O(b[s[i*D+D-j]]);}}else if(c== 170)u P=8+R%4;
  else if(c>170&&c<280){h P=g P;if(h P)O(b[h P]);else O(b[(I
  )(s P*(1-o)+u P*o)]);} ++j;}printf ("\n");++i;}if(c>89&&c<
  120){if(o<1.0f)o+=0.05f;else o=1.0f;}else if(c==120)o=0.0f
  ;else if(c>120&&c<140){if(o<1.0f)o+=0.02502f;else o=1.0f;}
  else if(c==140){o=0.0f;}else if(c>0x8c&&c<170){if(o<0.5f)o 
  +=0.0194f;else o=0.5f;}else if(c==170) {o=0.0f;}else if(c>
  170&&c<280){if(o<1.0f)o+= 0.05f;else o=1.0f;}usleep(90000)
;}free(s);free(t );free(u);free(v) ;free(h);free(g);return 0;}
