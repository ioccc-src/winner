#include <X11/Xlib.h>
char *l="dbcefcbddabcddcba~WAB+  +BAW~              +-84HLSU?A6J57IKJT576,",
*F="          ,>>,>  xl~w/?  ,>>>,s  m\177>>\177\177  mm2>>>  >uk>>> ",*f;y,u;
#define v for (i=0,b=0;b>511?b=0,i+=64:0,i<512;b+=64) A=i/64*10+b/64+21,XCopy\
Plane(d, r[I[A]+7+14*(i+b>>6&1)+28*(A==z)],w,C,0,0,64,64,b,i,1); XFlush(d);
#define _(a) *f++=a&*F?-(z%14<7):"U\252U\0DDDD"[z/14*2|u&1],
#define G(p) p##Pixel(d,DefaultScreen(d))
#define R(a) |(a==O|p==a)*
#define P return y=~y,
#define a X(0,0,0,
#define H while(
#define D ;if(

I[304],b,i,z;main(x,W)                   char**W; { Display *d =
 XOpenDisplay(""); Window               w = XCreateSimpleWindow
  (d, DefaultRootWindow(d),            64,64,512,512,2,G(Black)
   ,G(Black)); XGCValues g;           XButtonEvent e; int A,r
    [56],Z,* m = I , C ,Y;           XSelectInput(d,w,32772);
     XMapWindow( d, w); g.          foreground = G(White);
      C=XCreateGC(d,w,4,&g);       F+=48; H f=I,i=0,z<56){
       H u=0,i++<8){ H _(0)_(     64)_(16)_(8)_(4)_(2)_(1
       )_(0)++u<8); F++; } F-=   z%7-6?z%14<6?16:0:8; r[
        z++]=XCreateBitmapFromData(d,w,I,64,64); } srand(
       time(z=u=0)); H I[z]=-(   z>98|z<21|(z+1)%10<2),
      ++z<120); H ++m<9+I) 80     [m]=-2,90[m]=~(20[m]=7&*
     l++),30[m]=1; D 1<x) Z=       *W[1]-45; D 2<x){ a u,1
   ,Z); a u,0,1); z=0; } H          1){ XNextEvent(d,&e); D
  e.type==12){ v } D e.              type==4){ b=e.y/64*10+e
.x/64+21; D(b[I]^y)<-1)               { z=b; v} else{ i=(b<29
|b>90)&((z[I]^y)==-2)?-                6^y:z[I]; Y=y; a u,0,1);
z=0; v D 1<x&&Y-y){ a u                ,1,Z); a u,0,1); } z=0;
        v } } } }


                             X(w,c,h,e,S,s)


{ int p,O=          *l,t,d,o,C          ,*g,E,n,*m          =I,N=-1e8,
          A,L,r,x =           10,q; y=~y          ; H--O>20)
{ o=I[p=O]          D q=o^y,q>          0){ q+=(q<          2)*y,C=q
         ["51#/+++"],       A=q["95+3/33"];       do { m=0,
r=I[p+=C[l          ]-64] D !w          |p==w&&q>1          |C+2<A|!r)
          { d=abs(O-          p) D g=q<2          &e>>6==p+(
y?x:-x)?I+          (e>>6):0,           !r&(q>1|d%          x<1||g)|(r
          ^y)<-1){ n          =o,t=q<2&(          89<p|30>p)
?n+=y|1,6^          y:o+(y|1)           D (r^y)<-6          ) P 1e7-811
          *h; H n-t)          { O[I]=0,p          [I]=n,m?*g
=*m,*m=0:g          ?*g=0:0;            E=e&63 R(           91)16 R(28)
          4 R(21)2 R          (98)32; L=          (q>1?6-q?l
[p/x-1]-l[          O/x-1]-q+2          :(E|=y?8:1          ,!!m)*9:(E
          |=20-d?0:           64*p,n-o?(          l[15+n]-' '
)*9:d/8+!!          g*99))+(l[          r+15]-' ')          *9+l[p%x]-
          h-l[O%x];           L-=s>h||s==         h&L>49&1<s
?X(s>h?0:p          ,L,h+1,E,N          ,s):0 D !(          z-O|i-n|h|
          p-b|S|L<-           1e6))return         u=E; O[I]=
o,p[I]=r,m          ?*m=*g,*g=          0:g?*g=-2^          y:0 D S|h&&
          (L>N||!h&N          ==L&&rand(          )&4)){ N=L
D !h&&s) i          =n,z=O,b=p          D h&&c-L<S          ) P L; } q
          >5&d<2&C+6          <A&&(g=I+p          ,r=I[p+=p-
O],m=p<O?g          -3:g+2,!(e          &(p<O?3:5)          <<3*-y|*g|
          r|m[p<O?1:          -1])&&L>-           1e6&&1e6>a
63,1,0))?d          ++:(n+=y|1          );} } } C           +=q<2&C+3>
          A&((y?O<80          :39<O)||r)          ; } H!r&q>
2&q<6||(p=          O,++C<A))           ; } } P N+          1e8?N:0; }

