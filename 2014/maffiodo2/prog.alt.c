d=80,e,j;g(){j+=getchar();}main(){for(;;){j=0;g();if(j<0)break;g(g());putchar(" .:#@"[j/3*5>>8]);if(!(++e%d))puts("");}}
