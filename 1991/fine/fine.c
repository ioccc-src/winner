int main(int a, char **b){while((a=getchar())+1)putchar((b=64^a&223)&&(int)b<27?a&96|((int)b+12)%26+1:a);}
