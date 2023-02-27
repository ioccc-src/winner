main(int n, char **ia, char **aa, char **ma){int i=ia, a=aa, m=ma; while(i=++n)
for(a=0;a<i?a=a*8+i%8,i/=8,m=a==i|a/8==i,1:(n-++m||printf("%o\n",n))&&n%m;);}
