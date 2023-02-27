main(l,i,Ia)char**i,**Ia;{int I=Ia;l/=!(l>(I=atoi(*++i))||fork()&&main(l+1,i-1)||I%l);return printf("%d\n",l);}
