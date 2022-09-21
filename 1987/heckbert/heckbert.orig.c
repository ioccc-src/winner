#include <ctype.h>
#include <stdio.h>
#define _ define
#_ A putchar
#_ B return
#_ C index
char*r,c[300001],*d=">=<=!===||&&->++-->><<",*i,*l,*j,*m,*k,*n,*h,*y;e,u=1,v,w,
f=1,p,s,x;main(a,b)char**b;{p=a>1?atoi(b[1]):79;r=c+read(0,j=l=i=c,300000);v=g(
j,&m);for(k=m;v!=2;j=k,m=n,v=w,k=m){w=g(k,&n);if(v==1&&m-j==1&&*j==35)e&&A(10),
e=f=0;if(!f&&v==3&&(char*)C(j,10)<m)A(10),e=0,f=1;else if(v>2&&(u||w)&&(f||u)&&
(l-i>1||*i!=61||n-k>1||!C("-*&",*k)))continue;else if(v==3)if(f&&e+1+n-k>p&&e)A
(10),e=0;else A(32),e++;else{if(f&&e+m-j>p&&e)A(10),e=0;e+=m-j;k=j;while(k<m)A(
*k++);}i=j;l=m;u=v;}e&&A(10);}g(j,m)char*j,**m;{if(j>=r)B*m=j,2;s=isdigit(*j)||
*j==46&&isdigit(j[1]);for(h=j;h<r;h++)if(!isalnum(*h)&&*h!=95&&(!s||*h!=46)&&(!
s||h[-1]!=101&&h[-1]!=69||!C("+-",*h)))break;if(h>j)B*m=h,0;x=1;for(h=j;h<r&&C(
" \t\n",*h);h++);if(h>j)h--,x=3;if(*j==34||*j==39)for(h=j+1;h<r&&*h!=*j;h++)if(
*h==92)h++;for(y=d;*y&&strncmp(y,j,2);y+=2);if(*y)h=j+1;if(!strncmp("/*",j,2)){
h=j+2;while(*++h!=42||*++h!=47);x=4;}*m=h+1;B x;}
