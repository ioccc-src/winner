long h[4];E[80],S;t(){signal(14,t);if(S)longjmp(E,1);}c,d,l,v[]={(int)t,0,2},
w,s,I,K=0,i=276,j,k,q[276],Q[276],*n=q,*m,x=17,f[]={7,-13,-12,1,8,-11,-12,-1,9
,-1,1,12,3,-13,-12,-1,12,-1,11,1,15,-1,13,1,18,-1,1,2,0,-12,-1,11,1,-12,1,13,
10,-12,1,12,11,-12,-1,1,2,-12,-1,12,13,-12,12,13,14,-11,-1,1,4,-13,-12,12,16,-
11,-12,12,17,-13,1,-1,5,-12,12,11,6,-12,12,24};u(){for(i=11;++i<264;)if((k=q[i
])-Q[i]){Q[i]=k;if(i-++I||i%12<1)printf("\033[%d;%dH",(I=i)/12,i%12*2+28);
printf("\033[%dm  "+(K-k?0:5),k);K=k;}alarm(1);Q[263]=c=((S=1)&&!setjmp(E))?
getchar():-1;alarm(0);}G(b){for(i=4;i--;)if(q[i?b+n[i]:b])return 0;return 1;}g
(b){for(i=4;i--;q[i?x+n[i]:x]=b);}main(C,V,a)char**V,*a;{for(a=C>2?V[2]:
"jkl pq";i;i--)*n++=i<25||i%12<2?7:0;srand(getpid());system("stty raw -echo");
signal(14,t);t();puts("\033[H\033[J");for(n=f+rand()%7*4;;g(7),u(),g(0)){if(c<
0){if(G(x+12))x+=12;else{g(7);++w;for(j=0;j<252;j=12*(j/12+1))for(;q[++j];)if(
j%12==10){for(;j%12;q[j--]=0);u();for(;--j;q[j+12]=q[j]);u();}n=f+rand()%7*4;G
(x=17)||(c=a[5]);}}if(c==*a)G(--x)||++x;if(c==a[1])n=f+4**(m=n),G(x)||(n=m);if
(c==a[2])G(++x)||--x;if(c==a[3])for(;G(x+12);++w)x+=12;if(c==a[4]||c==a[5]){
printf("\033[H\033[J\033[0m%d\n",w);if(c==a[5])break;for(j=264;j--;Q[j]=0);
while(getchar()-a[4]);puts("\033[H\033[J\033[7m");}}system("stty cooked echo")
;d=popen("cat - HI|sort -rn|sed -n 1,20p>/tmp/$$;mv /tmp/$$ HI;cat HI","w");
fprintf(d,"%4d on level %1d by %s\n",w,l,getlogin());pclose(d);}
