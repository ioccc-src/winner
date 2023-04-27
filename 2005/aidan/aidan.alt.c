#include <stdio.h> /* sudoku-bfi.c */
#define S(t) for(n=0;n<9;v[n++]=0);for(n=0;n<81;n++)if(i[n]){z=1<<i[n];if(v[t]\ 
&z)for(;;){if(p<0)goto d;if(i[p]++<9)goto f;i[p]=0;p=s[p];}v[t]|=z;}
int i[82],s[81],v[9],n,p,z;int main(void){for(n=0;n<81;){p=getchar()^48;if(p==
30)p=0;if(p<10)i[n++]=p;}i[81]=0;p=-1;f:S(n%9)S(n/9)S(n%9/3+n/27*3)if(p>80)goto
d;for(n=p;i[++p];);s[p]=n;i[p]=1;goto f;d:z=p<81;printf("\n%s!\n\n",z?"Fail":
"Success");for(n=0;n<81;){p=i[n];printf("%c %s",(p?p|48:'.'),(++n%3?"":n%9?"| "
:n%27?"\n":n%81?"\n------+-------+------\n":"\n\n"));}return z;}

