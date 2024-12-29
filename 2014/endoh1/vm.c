#include<stdio.h>
int H[99999],*s,*c,d,t;
int main(int n,char*v[]){
    for(s=c=H+39999;(*++s="CODE"[d++]););
    for(;n>1&&(*++s=v[1][t++]););
    /*for(;n=getchar(),n>0;)*++s=n;*/
    for(s=H;d=*c++%93,d-9;){
	int v=*s,g[]={n+v,v-n,n*v,v^n,n<v,n?v/n:0,n?v%n:0,v>>n,v==n};
	for(t=0;d<4&&d>=2*!!n&&(c-=d/3*2,v=3+*c++,t||v!=98+d);)
	    t+=v++/6-16?0:v/2%3-1;
	for(t=d-14;t>0&&d<34&&105<*c;)t=t*21+*c++-106;
	n=
	    /*d==12?fprintf(stderr,"test:%d\n",n),*s--:*/
	    d>76?s--,g[d-77]: /* operation */
	    d>55?H[d-21]=n,*s--: /* reg write */
	    d>9?
		*++s=n,
		12>d?H[*c++]+=21-d*2: /* inc / dec */
		d<34?t:H[d] /* imm push / reg read */
	    :
	    d>5?
		s--,
		7<d?putchar(n),v: /* out */
		6<d?H[*g+99]=*s--: /* heap write */
		H[*g+99]: /* heap read */
	    2>d?*s--:n; /* control */
    }
    return n;
}
