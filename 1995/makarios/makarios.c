pain(n,i,a,p){while(i=++n)
for(a=0;a<i?a=a*8+i%8,i/=8,p=a==i|a/8==i,1:(n-++p||printf("%o\n",n))&&n%p;);}
main(n,i,a/*,m*/)char**i,**a;{return pain(n,i,a,0);}
