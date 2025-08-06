#include <stdio.h>
#include <math.h>

                        #define o(x,o)x##o
                                        char X[
                                             1<<16
                      ][4],Z[1<<28],*N=         X[1]
                  ,*P=Z,*H,A[12];char*C(int       i,o(u
               ,nsigned)             x){char*B      =0,*
             D;if((x                     >>16)||      0==*
           (B=X[x        ])){int a,b        =(sqrt     (x)+
          0.5),      c=x-b*b;D=C(0,65535      &b);o     (spr
        ,intf      )(A,"%s"       "*%s%c%"     "s",D     ,D,c
        ?c<0     ?45:43               :0,C(0    ,c<0?    -c:c
       ));B     =B?a=       *N,b=       N[1],    c=N[2    ],*B
      =a+!b    -90?a     =='z'?65:a+     1:(b     ='z'    -b?b
      -90?    b%64+     65:97   :(c=c    ?'z'-    c?-~     c:48
     :'a',    65),     'j')      ,B[1     ]=b,    B[2]     =c,o
     (prin    ,tf)    (",%"    "s=%s"    ,B,A)    ,(N=     B):A
     ;;}o(    ret,     urn)     i>0     ?P+=o     (spr    ,intf
      )(P,    ",%s"    ,B):B           ;}int     main     (){;
      ;int     a,i=     **X=Z[1     ]='a',c     ,n=0;    *X[1]
       =98;     for(      printf("#inclu"      "de "    "<st"
       "dio"     ".h>"        "\nint"        " a;i"     "nt"
        " ma"     "in()"                   "{int"     " b="
         "-~a")      ;i>3&&P-           Z+33<1<<     28;C(
           i,a))       for(a=i=0;i<4&&0<=(c=       o(get,
            char)(         ));n++)((char         *)&a)[
              i++]=c;                         H=P;C(1
                ,n);*H++=                 0;printf(
                   ",Z[]={%s};fwrite(Z,b,%s,std"
                        "out);}\n",Z+1,H);}
