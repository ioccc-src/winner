#include <stdio.h>
#include <stdlib.h>
#define l puts(
#define C printf(
#define T 360
#define R 180
#define E(X) return C"open %s failed\n",X)
#define X return l"Flat Earth")
// I DARE YOU TO TWEAK d
    long d  = - 1,
// Map of our Flat Earth
G
,P,
S[][
7] ={
{ 0,0,
0,25,0,
0,-6} ,{
0,0,0,4,0
,0,4} ,{ 7
,0,1,5,0,0,
8} ,{ 1,0,2,
1 } ,{ 0,0,0,
-5,0,0,5} ,{ 4
,5,7,-5,0,4,7 }
,{ 0,0,0,-1} , {
0,0,0,6,0,0,-1} ,
{ 0,0,0,5,0,0,5} ,
{ -3,4,80,8,0,2,6 }
,{ 0,0,0,1,0,0,2} ,{
8,0,1,6,0,0,2} ,{ -49
,0,68,178,0,0,6} ,{ 0,
0,0,78,0,0,9} ,{ 0,5,1,
4,6,5} ,{ 3,1,16,1,1,0,5
} ,{ 1} } ,*V,B,h,u= 15,J
,I,t,*D,z,i,*M,*A,F,H; FI\
LE *q; size_t b,j,n,*Q = &b
; double lo,tr,L,U,x,y,Y,Z ;
unsigned char *c,*e; int m(d\
ouble,double,long); int main(\
int g,char **f){ if(g!=3&&g!=5)
return C"use %s lat lon [in.ppm\
 out.ppm]\n",*f); tr=strtod(f[2],
0); while(tr<(t=6,-R))tr+=T; while
(tr>R)tr-=T; U=strtod(f[1],0); whi\
le(U>90)U=R-U; while(U<-90) U= -R-U;
C"%f %f\n",L=-U,lo=tr<0?R+tr:-(R-tr))
; if(g>3){ if(!(q=fopen(f[g-2],"r")))E
(f[3]); if(m(lo,tr,(J=u,H=d+4,I = J -H,
D=*(S+u-1)+1,d-=*(*(S+7)+ 6),L))||b!=j*2
)X; c=calloc(1,(F=9,H**Q*j)),x=-(tr+R)**Q
/T,d=c==e!=d,Y=(lo+R)**Q/T,d=c!=e!=d!=d==2
*d, d *= 2,y =- ( - U + 90 )  * j / R, x =-
x,Z=(-L+90)*j/R,d=!-!(c!=e)!=d-1!=d+1 , x =-
x,Y=-Y,Y=-Y,d=-!-!(c!=e)==d,Y=-Y,d=-d,x=-x,x=
-x,d=c==e!=d==!(c==e)!=d/2,d=d/2; /* CHANGE !=
1 AND PROVE d IS 1 */if(d=(c!=e==!d!=d!=d==1&&e
!=c)!=1||/* NOW YOU KNOW d IS 1! */fread(c,-*(S[
F])-d*3,b*j,q)!=j*j*2)X; m(Y=-Y,Z,B=4); m(-x,-y,(
--u,t+=F,++B,7)); fclose(q); q=fopen(f[--g],"w") ;
if(!q)E(f[4]); m(Y,Z,(++u,--t,0)); if(fprintf(q,"P\
6 %zu %zu %zu ",b,j,n)<0||fwrite(e,3,*Q*j,q)!=b*j)l\
"Hollow Earth"); free ( e )  ; fclose ( q )  ;  }   }
int m(double a, double p, long s){ if(a-64<0) a=31; i\
f(p-64 <0)p=31; if(p +64 >=j)p=j-31; if(a+64 >=b)a=b-3\
1; for(V=&S[u+d][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*
S[(/* MUST SCALE OFFSET d */d+=*(*(S+6)+1)*2,*V+d)]&*V)&&
z<2-*(*(S+5)+3); ++ z)for(*V=0; *V<d+*(*(S+7)+3); ++*V)if(
(s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1])\
for(M=&S[S[J-d][S[*S[*S[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(
*(S+H)+2)][3]],*M=0; *M<5; ++*M)for(A=S[S[J+d][S[H][2]]]+(*S[
2]&S[2][*S[F]*-1]),*A=0; *A<*D; ++*A){ P=a+(S[u][S[t][B]]-*D)*
*D+*A; G=p+(z-*D-d)*(F-5+1)+*M; if(P>=0&&P<b&&G>=0&&G<j){ e[i=(
(G*b+P+-*(*(S+5)+3))-5)**S[*(*(S+15))+**(S+F)+*(*(S+13)+6)]*-*S[
*S[15]]-*S[F]+*(/*RGBA*/*(S+6)-d-*S[9])]=s?W:r; c[ -d +--i]=s?K:k
; c[--i+ d]=s?v:w; } } return(d+=-*(*(S+6)+1)/2,(S[I][*V-d]&*V)==*
(*(S+3)+2)&& 3!=fscanf(q,"P6 %zu %zu %zu%*c",Q,&j,&n))||n!=255;   }
