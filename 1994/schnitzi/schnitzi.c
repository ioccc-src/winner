#include <stdio.h>
int r=0,x,y=0,    /*
nt                 /
c
lx  /\ / \ /|\ /|\
u,  \/ \\/ \-/ \ /
dn                        ]
e= ||| /|\  /\  /\        =                     p p
 0  \/ \ / |||  \/        f        f       f    r r
<,                        tw       t       s s  i i
sy  || /|\      /\     i  eh       e       e c  n n
t= /-  \ /     |||     n  li       l       e a  t t
d0     |||             t  ll       l  {<   k n  f f
i,  ||     /|\ /|\        (e s     (  fr   ( f  ( (
o    _ ||\ \ / \-/     tu s( t    usw o; i s (  " "
.   || - /           c [[ tg rv   [th rx=f t "  % \
h                   mh111 de{l)   +di (+'( d+%  c n+
>                   aa000 itte; > +il x+ n inc  " "+
 /                  ir000[ns[nytyrrne<=)'<xn,"  , );
 */                 n         =             0     ;
               main        (       )   {
                char       v   [
                100    ]                   ,  s;
          int t[100     ]                    ,
              u[100               ]     ;  u
                  [                   0
      ]=ftell(stdin        )       ;
         while(gets (v    )                 )
                 {t  [         r ]=
             strlen                 (
               v);y=
                 t[         r             ]
                 >y             ?        t [
                  r         ]    :   y;
              u[++r   ]     =      
        ftell(stdin )   ;                          }
              while          (                    n
                  <              y        )
            {for(x=0             ;         x
            <r;x++) {                           s
               =' '       ;              
              if(n<             t        [
                  x            ]     )    {
        fseek(stdin    ,u       [     x    ]
                 +n   ,  0 )                     ;
        scanf("%c",                          &
                                       s        )
                   ;                             }
       printf("%c",   s                       )
                                            ;      }
      printf("\n");                 n
                 ++   ;            }           }
