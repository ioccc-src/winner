#define F 0xF
#define U 512

#define std(x,y)                                     (*x)(const char *,...)=y##f
#define str(l,e,x)                                                       l e,l x
#define mx(p,v1,v2)                                p[3]=v2,p[1]=v1,p[2]=v2,*p=v1
#define vi(n)                                                        q+2,n,q+3,n
#define rt                                                                return

                                                             #include <stdlib.h>
                                                              #include <stdio.h>

                          typedef double n; n *d,*b,*f; typedef unsigned char c;
char _[ ]="    <?%s version=\"1.0\"?>\n<%s %s=\"%d\" %s=\"%d\">\n", q [7][7] = {
"ivory","black","width","height","text"};int v,std(i,scan),std(o,print);

int cc(str(const void*,x,y))
{
        rt(*(n*)x>*(n*)y)-(*(n*)x<*(n*)y);
                                                                               }
        n t(n f,n g,str(n*,x,y))
                                                                               {
        f=*x++-f,g=g-*x,*y=f*f;rt *y+g*g;
                                                                               }
        c*ln(n*p)
                                                                               {
        c*f=((c*)(d+2*(2+v))+2*(p-d)); while(!*f) mx(f,rand(),rand());rt f;
                                                                               }
        n*put(str(n*,f,l),n z)
                                                                               {
        int r=(l-f)/4,p=*(f+(r*=2))<z;rt r>0?put(f+p*r,p?l:f+r,z):f;
                                                                               }
        n*g(n u,n w)
                                                                               {
        n y=u/(U-1),*s=put(d,d+v+2,y),z=w/(U-1),k,l=t(y,z,s,&k),
        m=l,*r[4],g[4],*f; c p; for(mx(r,s,0),mx(g,k,l);
        p=*(1+g)<*g,(m>*(g+1))+(*g<m);s=*f<m?m=*f,*(r+p):s)*(f=g+p+2)=t
        
        (y,z,*(r+p)+=p?-2:2,p+g);rt s;
                                                                               }
        c*a(str(n*,x,r))
                                                                               {
        n*y; int i=0,j=0,k=0,u;for(u=0;y=g(*x+u/4/4.,*r+u%4/4.),16>u;++u)
        i+=*ln(y),j+=*(1+ln(y)),k+=*(ln(y)+2);
        *_=i/u,*(1+_)=j/u,*(_+2)=k/u;rt(c*)_;
}

void tr(n x,n y,n i)
{
        c*h,w;n*m=g(y,i); for(w=4*(x<2);++w<4&&m==g(w/2*x+y,i+w%2*x););       
        for(w=4*(w>3&&(h=x>1?ln(m):a(&y,&i))&&o("<rect style=\"fill:rgb(%d,%d,%d\
        );\" x=\"%f\" y=\"%f\" %s=\"%f\" %s=\"%f\"/>\n",*h,*(1+h),*(2+h),str(F+,
        y,i),vi(x))),x/=2;x>0&&w<4;++w)tr(x,y+w/2*x,w%2*x+i);
}

int main()
{
        long k,r=1e6,h;d=calloc(r,k=sizeof(n)),f=d+r,b=d;

        while(0<(h=i("%lf",b)))*--f=*b++;v=b-d;if

        (!h+v%2+!v&&(r=0x630C65u)){o("\n0x7");while(r-->0)o("F");rt -1;}
        mx((d+v),-r,r);qsort(d,2+(v/=2),2*k,cc);
        tr(U,0&o(4+_,"xml","svg",vi(2*F+U)),0);

        for(b=d-1+r,k=0;r=1,v>k++;b-=2)
        str(o("<%s x=\"%f\" y=\"%f\" fill=\"%s\" %s-anchor=\"end\">%d</%s>\n",
        4+q,str(F+r/2.-5+U**,b,(b-1)),q+r,q+4,k+!o
        ("<circle style=\"fill:%s;\" cx=\"%f\" cy=\"%f\" r=\"3\"/>\n",
        r+q,str(F+r/4.+U**,b,(b-1))),4+q),&&r--,);

        free(d);rt o("</svg>\n")-7;
}
