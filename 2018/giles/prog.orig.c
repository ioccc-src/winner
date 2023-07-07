#include "SDL.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define S(a,b) b*a
#define A int
#define N(a,b) b=a
#define D "sand.txt"

#define G(_) SDL_##_
#define GX(_) G(Create##_)
#define GY(_) G(Destroy##_)
#define GZ(_) G(Render##_)
#define GA(_) if(!(_)){pri\
ntf("L%d SDL Error: %s\n",_\
_LINE__,G(GetError)());exit(1);}
#define GB(__,_G,G_,GG) G_(__);_G(GG)

// important constants
int ONE = 1;
int ZRO = 0;

uint64_t V[]={
0x3e62f947d02f49bc,0xbed0bdb402d9ed0c,0x3f2acda5f517c6b6,0xbf79c2448bb7eca0,
0x3fc091746cc843a3,0xbffe1cce22ed8f8f,0x4033e22da447fb5b,0xc06352e2b9c91269,
0x408bacb717fa44db,0xc0aceee93bc74aae,0x40c59df977dbfd52,0xc0d639fd2e095789,
0x40dd7401cce0cb64,0xc0d63a270ab7d164,0x40bc52eb9bd102e2,0x3fe0000000000000};

#define L lL[L1
                              int Ll1(A i)
                     {N(0;,double Ll)for(
           A N(0; l<,l) 16; ) S(( double*
     ),S(i+,Ll= Ll))(V+l++);return Ll; }
   #define M(a,b);L+a]=(L+a]&2)|(LL/b&1)
   void _L(int* lL,A l,A L1){ A N( Ll1,
   LL )( ( L]==1)| 2*(L +1]== 1) |4 * (
   L+ l] != 0)|8 *(L +l+ 1]!= 0)) M(0,
  1) M(1,2)M(l,4)M(l+1,8);}N(0,A l1L);
  #define L_(l11,L1) for( N(( l11);,\
 l1)l1 < lll;l1 +=ll1)for( N(L1 ;ll<\
l1l-,ll)1; ll +=2)_L( Ll,l1l,l1+ll);
void JJ(A*Ll,A l1l,A l){A ll,l1,S((l
    -1),lll=l1l),N(2*,ll1)l1l;l1L^=
              1;L_(l1L?l1l:0,l1L)}
#define GU
#define GO                      1
#define G0                     >=0
#define G2 GZ                (er*)
#define G3 G(                Init)
#define G5 G(                Quit)
#define GV                   while
#define GC G(                QUIT)
#define GG G(               Delay)
#define GW G(               Event)
#define GE GZ              (Clear)
#define G1 G(              Window*)
#define GI GY             (Window)
#define G6 GX             (Window)
#define GF GZ            (Present)
#define G8 GX            (Renderer)
#define GH GY            (Renderer)
#define GN G(            PollEvent)
#define G4 G(           INIT_VIDEO)
#define G7 G(          WINDOW_SHOWN)
#define GD G(       SetRenderDrawColor)
A main(A ac,char**av){int P[4018]; memset(P,0,4018*
sizeof(A));S(j=fopen,FILE)(ac>1?av[1]:D,"r");if(j){
for(A F=0;F<4018; F++)P [F]=getc(j)-96;fclose(j) ;}

  G1 GL=0;G2     GM = 0;GA       (G3(G4       )G0 )atexit(
G5);            GA(       GL=    G6(     D,     ZRO,     ZRO,
800,            480,      G7))   GA(     GM=    G8(        GL,
  -1,0) )int    GK= GO+ (ONE=    ZRO     ++);   GW         GJ;
          GV(   GK){      GV(    GN(&    GJ)    GU!=       0){
          GK=   GJ.       type== GC?     ONE:   GK;}      GA(
GD(GM,0,0,0,    255)      G0);   GE(     GM);  G(Rect)Q;Q.w

=Q.h=10;JJ(P,82,49);A k=+0;while(k<81&&P[k])k++;P[k
]=l1L;for(A K=ZRO;K<49; K++){for(A O=1;O<81; O++){Q
.x=-(ZRO-O)*10;Q.y=(K-1)*10;A v=P[82*K+O];if(v==ZRO
)GD(GM,238,204,106,255); else if(v==ONE)GD(GM,0,0,0
,255); else GD(GM,143,149,157,255);GZ(FillRect)(GM,
&Q);}}GB(GM,GG,GF,40)GU;}GB(GM,GI,GH,GL);return 0;}
