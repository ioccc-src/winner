_,x,y,o       ,N;char       b[1920]       ;p(n,c)
{for(;n       --;x++)       c==10?y       +=80,x=
o-1:x>=       0?80>x?             c       !='~'?b
[y+x]=c       :0:                         0:0;}c(
       q,l,r)       char*l,*r;{while             (q>=0)q
       =("E"    "?yYrIxC{e^}KhE>[|LXbj}"         "dOVsJ"
       "@"    "idOV{Yab[bW}[bW}\\qFywyv{D"       "ma\\A"
       ""   "Ztq?Lyw>e{|Zq>Y\\gq\\qI[tYBe{w"     "yvDZE\
vBA[`_"    "Lo>}KcqdYrWqKxzKtW]|DXRwsfcUaT\\\
KXw{Y"   "RsFwsFwsFw{zaqyaz|FmMpyaoyI\\]cuUw{J"
[_/6]   -62>>_++%6&1?r[q]:l[q])-99;return q;}E(a
){for   (o=x=a,y=0,_=0;_        <1006;)a=" /\\\n"
       "~|_."[c(6,"b"              "cd\\a[g","^`"   "_e"
       "]fh")+8], p(   "#$%"        "&'()*+,-.1"[   c(11
      ,"_ac[]\\YZi"   "jkm",         "`bd^efghXWlV" )+13
      ]-34,a);}main   (k,Z){         float z[1920]  ,A=0
,B=0  ,i,j; puts(""         "\x1b"   "[2J");for(;;
)  {  float e=sin(A         ),  n=   sin(B),g=cos(
A),m   =cos(B);for(k        =0;k<   1840;k++)y=-k
/80-   10,o=41+(k%80-              40)*1.3/y+n,N=
        A-100.0/y, b[k]=        ".#"[o+N&1],z[k]   =0;E(
        80-(int)(9*B)%250);for(j=0;6.28>j;j+=0.07  )for(
         i=0;6.28>i;i+=0.02) { float c=sin(i),d   =cos(j
           ),f=sin(j),h=d+2,D=15/(c*h*e+f*g+5    ),l=cos
(i),t=c     *h*g-f*e;x=40+2*D*(l*h*m-t*n),y=   12
+D*(l*h       *n+t*m),o=x+80*y,N=8*((f*e-c    *d*
g)*m-c*         d*e-f*g-l*d*n);if(D>z[o]    )z[o]
=D,b[o]             =" ..,,-++=#$@"[      N>0?N:0
       ]  ;  }                                   printf(
       "\x1b["       "H"           );for(k       =1;1841
       >k;k++)       putchar       (k%80?b       [k]:10)
       ;  A +=       0.053;B       +=0.037       ;  }  }
