#include<stdio.h>
#include<stdlib.h>/*
e=nil;ARGF.each_char{|c|print c;e=e ?c<"A"||c>"Z":c=="\e"?1:!(sleep 0.1)};%q{*/
#define T(_,S,C,R,A,M,B,L,E) _ V,i,o,l,e,t=1,n[4],I[22]={4352,95,4554,1,2902,4\
46,2,29839,1841,11171,8541,511,785,9,23,63,145,96,128,6,61466,135167},g=240,H,\
h,p,q,x,y;typedef struct{_ x,y,z;}b;b*U,u;FILE*f;A m(_ p,_ q){_ d=(p+q)/2;C(d-\
p){m(p,d);m(d,q);S(i=p,o=d,y=H+p;y<H+q;y++)x=i>=d||(o<q&&U[i].y*1e6+U[i].x>U[o\
].y*1e6+U[o].x)?o++:i++,B;S(y=p,x=H+p;y<q;x++,y++)B;}}A v(){S(i=l=0;i<22&&(o=l\
+I[i++],l=o+I[i],e<o||e>l);i++);x+=2-i/22;}A a(){C(H+2>t)U=(b*)realloc(U,(t*=2\
)*24);U[H].x=x;U[H].y=y;U[H++].z=e;p=p>y?y:p;q=q<y?y:q;v();}A P(_ p){n[o=0]=e=\
p;C(p>>7){S(;p>63>>o;p>>=6)n[o++]=(p&63)|128;n[o]=(g*8>>o&g)|p;}S(;o>-1;)fputc\
(n[o--],f);}A Q(_ O){O?fprintf(f,"\33[%d%c",abs(O),V+(O>0)):0;V^=2;}R d[2]="r"\
;_ main(_ O,R**Z){f=stdin;C(--O&&(**++Z-45||1[*Z])&&--Z&&L)M;S(*d|=5;(e=fgetc(\
f))>0;h=h<0?e-91?e<48||e>59?l*=(e&2)-1,e>64&&e<67?y+=l,0:e<69&&(x+=l)<0?x=0:0:\
~(l=l*10+e-48):h:h?(e=l=l<<6|(e&63),!--h)?a(),h:h:(e&224)==192?l=e&31,1:(e&g)=\
=224?l=e&15,2:(248&e)==g?l=e&7,3:e-27?e==10?y++,x=0:e-32?e==9?x=(x+8)&~7:e>32?\
a(),h:h:x++,h:~(l=0))V+=(V+e)<<10,V^=V>>6;E;f=stdout;C(U){C(O<1){m(0,U[H].x=H)\
;S(h=x=0,y=p;h<H;v()){S(;y<U[h].y;y++,x=0)P(10);S(;x<U[h].x;x++)P(32);S(;h<H&&\
U[++h].y==y&&U[h].x==x;);P(U[h-1].z);}C(x)P(10);}else{srand(V);S(x=H;--x;B)y=r\
and()%-~x;C(--O?L:O++)M;S(t=h=0,y=q+1;h<H&&t<O;E){C(t&&L)M;C(!t)S(h=q-p+2;--h;\
)P(10);S(V=65;h<H*-~t/O;y=U[h++].y)Q(U[h].y-y),Q(x-U[h].x),P(U[h].z),x=U[h].x,v
T(int,for,if,char,void,goto X,(u=U[x],U[x]=U[y],U[y]=u),((f=fopen(*++Z,d))?0:-(
perror(*Z),1)),fclose(f))();Q(q-y);P(10);y=q+1;x=!++t;}}}O=0;X:return O;}/*}#*/
