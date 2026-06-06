#define G t[6]
#define A t[7]
#define M Z(2,0)
#define E (G&128)
#define B (G&16)
#define O if(y
#define Y O ==
#define _(r) (b=I(r++),b|I(r++)<<8)
#define S _(F)

  typedef  unsigned  char u; u w,X,T,D[1<<16],t[]=R,U=255; unsigned
short J=-2,F=256,H=65280,b; I(a){ int r=D[a]; return a^H?r:(r&16?U>>4
: U)&                                                           15|r&
240;   } N(a,v){ if(a>>15)for(D[a]=a^H+68?v:0,a=(a==H+70)*160;   a--;
) D[  65024|a]=D[v<<8|a]; } Z(k,p){ return k<3?t[k*2]<<8|t[k*2+  1]:p
?A<<  8|G:J; } P(k,v,p){ k<3?(t[k*2]=v>>8,t[k*2+1]=v):p?(A=v>>8  ,G=v
&240  ):(J=v); } W(i){ return i^6?t[i]:I(M); } V(i,v){ i^6?t[i]  =v:N
(M,v  ) ; } L(z,n,c){ G=(z?128:0)|(n?64:0)|(c?16:0); } Q(v){ N(  --J,
v>>8  ); N(--J,v); } j(o,v){ int c=(o&1 and o<4)*(G>>4&1),e=o>1  , h=
o &4  and o^7,r=h?(o&1?A^v:o>4?A|v:A&v):(e?A-v-c:A+v+c); G=(!(r  &255
)<<7  )|((!h and e)<<6)|(!h and(e?r<0:r>255))<<4; if(o^7)A=r; }  m(){
if(X  ) { if(D[65535]&D[H+15])X=0; return; } if(T){ w=1; T=0; }  {  u
o=C,  x=o>>6,y=o>>3&7,z=o&7,p=y>>1,q=y&1; int a,c,e,r,v,k[]={ !  E,E,
!B,B  }  ; switch(x){ case 0:switch(z){ case 0:Y 2 or!y)return;  Y 1)
{ a=  S; N(a,J); N(a+1,J>>8); return; } { e=(signed char)C; Y 3  or k
[y-4  ] )F+=e; return; } case 1:if(!q)P(p,S,0); else{ L(E,0,(r=  M +Z
( p,  0 ))>65535); P(2,r,0); } return; case 2:a=p>1?M:Z(p,0); q  ? (A
= I(  a )):N(a,A); if(p>1)P(2,M+5-2*p,0); return; case 3:P(p,Z(  p ,0
) +1  - 2*q,0); return; case 4:case 5:o=W(y)+9-2*z; V(y,o); L(!  o ,z
& 1,  B ); return; case 6:V(y,C); return; default:O<4){ c=(y&1?  A :A
>> 7  ) &1; A=y&1?A>>1:A<<1; A or_eq(y&2? !!B:c)<<((y&1)*7); L(  0 ,0
, c)  ;  } else Y 4){ if(G&64){ if(B)A-=96; } else{ if(B|A>153)  {  A
+=96  ; G or_eq 16; } if((A&15)>9)A+=6; } L(!A,G&64,B); } else  Y  5)
{  A  =  ~ A; L(E,1,B); } else{ L(E,0,y&1? !B:1); } return; }  case 1
:if(  o ==118)X=1; else V(y,W(z)); return; case 2:j(y,W(z))  ; return
;      default :switch(z){ case 0:O<4){ if(k[y])F=_(J);    return ; }
Y  4)                                                    {  N(H|C,A);
return; } Y 6){ A=I(H|C); return; } { e=(signed char)C; r=J+e; L(0,0,
(J^e^r)&256); Y 5)J=r; else P(2,r,0); return; } case 1:if(!q){ P(p,_(
J ),1); return; } if(p&2){ p&1?(J=M):(F=M); return; } F=_(J); w or_eq
p ; return; case 2:a=(y<4 or y&1)?S:H|t[1]; O<4){ if(k[y])F=a; } else
{ y&2?(A=I(a)):N(a,A); } return; case 3:if(!y){ a=S; F=a; return; } O
>5){ y==6?(w=T=0):(T=1); return; } o=C; x=o>>6; y=o>>3&7; z=o&7; v=r=
W(z); if(     x==1){ L(!(v&(1<<y)),0,B); return; } if(x)r    = x==2?v
&  ~(1<<y     ) :v|1<<y; else{ c=y not_eq 6&v>>7* !(y&1)      ; r=y==
6?v<<            4|v>>4:(y&1?v>>1:v<<1); O<4)r or_eq(y&2      ?  !!B:
c )<<            ( y&1)*7; Y 5)r or_eq v&128; x=r    ; L(    ! x,0,c)
; } V            (z,r); return; case 4:O<4){ a=S      ;  if(k[y]){ Q(
F ); F=a      ; } } return; case 5:if(!q)Q(Z(p,1      )); else if(!p)
{ a=S; Q      ( F); F=a; } return; case 6:j(y,C);    return ; default
: Q(F); F=y*8; return; } } } } i(x,y){ int e=D[H+64],c=0,p,q,h,k=0; u
* o; if(e&1){ o=D+H+66; p=x+o[1]; q=y+ *o; h=D[38912+(q/8&31)*32+(p/8
& 31)]; o=D+(e&16?8:9)*4096+(e&16?h:(signed char)h)*16+(q&7)*2; c=(*o
>>(7-(p&7))&1)|(o[1]>>(7-(p&7))&1)*2; } if(e&2)for(; k<40; k++){ o=D+
65024+k*4; q=y- *o+16; p=x-o[1]+8; if((unsigned)q<8 and(unsigned)p<8)
{  o=D+32768+o[2]*16+q*2; h=(*o>>(7-p)&1)|(o[1]>>(7-p)&1)*2; if(h)c=h
;  } } return 255-7*(e   & 128?c:0)   ;  } main(){ static  u d[9]; u*
a=D+H+68,c; char*k=   K,*x,*e,s[   1<<20]; int p=0,q  =0,f  ,g; read(
3,D,32768); D[H]   = 207; a[-   4 ]=145; a[187]  = 1;  for(  ;  ; ){
m(); D[H+4]++; p+=8; for(; p>=456; p-=456)  ++ *  a ==  144?  D[H+15
] or_eq 1,q=0: *a>153? *a=q=0:0; if(*a==144  and   ! q)  {  q  = 1;
while(read(0,&c,1)>0)x=strchr(k,c),x?d[x-k]=  9:0;  for   ( U=  255
, f =0; f<8; f++)d[f]?d[f]--,U xor_eq 1<<f:0;  for   ( e=  strcpy(
s,"\x1b[H")+3,f=0; f<144; *e++ =10,f+=2)for(g=  0; g  <160; g++)
e+=sprintf(e,"\x1b[38;5;%dm\x1b[48;5;%dm▀",i(g,  f),i(g,f+1
)); write(1,s,e-s); usleep(14000); } w and(D[65535]&D
  [H+15]&1)?w=0,D[H+15]and_eq~1,Q(F),F=64:0; } }
