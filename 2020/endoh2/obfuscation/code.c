int*d,D[9999],N=20,L=4,n,m,k,a[3],i;
char*p,*q,S[2000]="L@X-SGD-HNBBB-AD-VHSG--XNT\x1b[2J\x1b[H",*s=S,*G="GLYPHS";
#include<complex.h>
typedef/**/complex/**/double(c);c(X)[3],P,O;
c/**/B(double t){
    double s=1-t,u;
    P=s*s*X[1]+2*s*t**X+t*t*X[2]+O;
    u=I*P;
    return+48*((s=P)+48*I)/(1<u?u:1);
}
#include<stdio.h>
void/**/b(double t,double u){
    double s=P=B(t)-B(u);
    (s=P*(2*s-P))<1?
        m=P=B((t+u)/2),k=-I*P,
        m>-41&&m<39&&9<k&&k<48?
            m+=k/2*80+73,
            S[m]=S[m]-73?k%2?S[m]-96?95:73:S[m]-95?96:73:73
        :
            1
    :
        (
            b(t,(t+u)/2),
            b((t+u)/2,u),
            0
        );
}
#include<time.h>
int(main)(int(x),char**V){
    clock_t(c)=clock();
    // default message
    for(d=D;m<26;m++,s++)
        *s>63?
            *d++=m%7*16-7*8,*d++=m/7*25,*d++=*s-64
        :
            0;;
    if(V[1]){
        // read a given file
        ;;;FILE*F=fopen(V[+1],"r");
        for(d=D,L=N=m=0;(x=fgetc(F))>0||fclose(F);)
            if(
                x>13?
                    64<x&&x<91?
                        *d++=m*16,
                        *d++=L*25,
                        *d++=x%26
                    :
                        0,
                    m++,
                    0
                :
                    1
            )
                for(++L;d-D>N*3||(m=0);N++)D[N*3]-=m*8;
    }
    for(;i<200+L*25;i++){
        // clear the screen
        for(n=0,p=S+33;n<1920;*p++=n++%80>78?10:32){}
        // render the message
        for(*p=x=0,d=D;x<N;x++,d+=3){
            O=(d[1]-i-40)*I+*d;
            // render a letter
            n=d[2];
            p=G;
            for(;n--;)for(;*p++>33;);
            *a=a[1]=*p++;
            for(;*p>33;p++)
                if(
                    *p%2?
                        *a=*p,0
                    :
                        1
                ){
                    a[2]=*p;
                    for(m=0;m<3;m++){
                        // calculate the point on the load
                        k=a[m]/2-18;
                        q="POINTTABLE";
                        for(n=POINTSTART;k--;)n+=*q++-34;
                        X[m]=n%XMAX+n/XMAX*I;
                    }
                    // bezier
                    b(0,1);
                    *a=a[1]=*p;
                }
        }
        // show and wait
        for(puts(s),s=S+30;(clock()-c)*10<i*CLOCKS_PER_SEC;);
    }
    return 0;
}
