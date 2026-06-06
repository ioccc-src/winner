#include <stdlib.h>
#include <stdio.h>


            int main
            ( int c,
            char**v)
            {int*u,s
            [5<<15]=
  {0},l=1<<15,*r=s+l*4,q=0,p,o    ,d,b,x,z,n=q;for(;--c>q&&(d=
  b=atoi(*++v))>q&&d<l;r[n++]=    d)for(;s[d]++,b/=10;);;for(;
  q<n;q++)for(p=-1;p++<q;)for(    z=s[x=b=r[q]]+s[d=r[p]]+3,d=
  d<b?b=d,x:d,o=5;--o;x&&x<l&&    (u=s+x,!*u?r[n++]=x:*u>z)?r[
            x-l]=b,*
            u=z,u[l]
            =o,u[l+l
            ]=d:b)x=
            o<2?d*b:


       o>3             ?d-                            b:
     o<3?z+=         (s[b+l]                        /3+s[d+
   l]/3)*o,d/b     +d%b*l:d+b;                    ;for(*r=d=0
     ;d||--c>0;) d?x=s[q+l],                    z=o/2<x/3,x
       &&d<3?*r++=q,*r++=o                    ,o=o==(--x|
         1),*r++=++d,q=s                    [q+d*l],o^=
           x&d,d<3?z&&                    printf("(")
         :printf(" %c ",                "*/+-"[o]),
       d=1:(x?z?printf(")"            ):x:printf(
     "%d",q),d=! q+*--r)?o=*        --r,q=*--r:
   printf(" ="     " %d\n",q):    (q=atoi(*++
     v),r+=d         =q>0&&q        <l&&s[q
       ],o             =2)             ;}


