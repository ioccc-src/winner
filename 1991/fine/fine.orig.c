main(a,b){while((a=getchar())+1)putchar((b=64^a&223)&&b<27?a&96|(b+12)%26+1:a);}
