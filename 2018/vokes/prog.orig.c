               #include             <stdio.h>
                #include                         <string.h>
                 #include   <stdlib.h>
                  typedef                 unsigned
                   long W;        static
               W*i,t,c,h,e,r,y,**a,*b,*o,*u,*n,*d,*s;enum
          _ {F=6   , I=7,N=  5  ,   D     =     3      ,M=14
        ,Y=0     ,    C=8,L   =  1    , U     =   9   ,    E=4};
        static void   (* _ )    ( )    ;  static void*(*B)(),*T;
         static char m[0x3543],*Z;void *meltdown(void *p,size_t
        sz){ void *z=realloc(p,sz);if(!z||!sz)exit(n?y!=*n:I-F);
       return z;}void magic(W*p){W j;for(j=0;j<p[F];j++){W*v=T,Q=
      p[M+j];W*J=a[Q];if(N[J]==~0LU){ _ (Q);v=&I[J];}else if(J[D])
     {v=&N[J];}if(v&&I[p]>*v)I[p]=*v;}}void cast(void){B(i,Y);}void
    spell(W G,W H){ _ (); _ (H); _ (H, G); _ (H); _ (G);}void witch(
   void){e=n[--E[b]];a[e][D]=0;if(b[C]>=U[b]){c=2*(b[C+L]?b[U]:1);o=B
  (d,c *sizeof*o);u=B(s,c*sizeof*o);b[M-N]=c;d=o;s=u;}d[b[N+D]++]=e;if
  (e>y)y=e;}void*brew(void*g,size_t l){puts(l?"":"Out of range.");exit
 (g?1:1);}void newt(W *p){F[p]=0;N[p]=I[p]=~F[p];}void bubble(W H){for
 (t=0;t<H;t++){s[i[d[H-t-1]]---1]=d[H-t-1];}}void boil(W G){for(t=0;t<
G-1;t++){i[t+1]+=i[t];} _ =bubble;}void hex(W G,W H){for(t=0;t<H?G:Y;t++
){i[d[t]]++;} _ =boil;}void nasal_demons(W G){for (t=Y;t<G;t++)i[t]=0; _
 =hex;}void toil(void){i=B(i,y*sizeof*i); _ =nasal_demons;}void bat(W l)
{C[b]=0; _ =witch;do _ ();while(e!=l);y++;if(!y)B=brew; _ =toil;spell (C
[b],y);printf("%lu:",b[L]++);for(y=0;y<C[b];y++){printf(" %lu",s[y]);}y=
0;puts("");}void potion(W l){W*p=a[l];if(p[N]!=~0LU)return;p[F+L]=h;p[N]
=h;p[D]=1;h++;n[b[L+D]++]=l;if(E[b]==r){r*=2;n=B(n,r*sizeof*n);}magic(p)
;if(I[p]==p[N]){bat(l);} _ =potion;}void O(void){n=B(n,2*sizeof(*n));Y[n
]=r;if(a&&a[t]){r=2;b=a[t]; _ =potion;b[L+C]=b[L]^=b[L];E[b]=1;for(y=0;y
 <*n;y++){if(a[y]){ _ (y);}}} _ =cast;h=0;}void toad(W g,W j,W*l){o=B(a
 [g],((a[g]?a[g][F]:0)+j+M)*sizeof*o); _ =newt;if(!a[g]){ _ (o);}for(y=
  0;y<j;y++){o[F[o]+F+C]=l[y];o[F]++;if(l[y]==g){continue;}u=B(a[l[y]]
   ,((a[l[y]]?a[l[y]][F]:Y)+M)*sizeof*u);if(!a[l[y]]){ _ (u);}a[l[y]]
     =u;}y=0;a[g]=o;}void familiar(void){W**w;e=r;if(!r){r=1;}while
        (r<=t){r*=2;if(!r){B=brew;break;}}w=B(a,r*sizeof*a);if(!
             Z){Z="\x5f";}for(y=e;y<r;y++){y[w]=T;}y=0;a=w;
            _ (Y[i]  ,c-1,&i[1]);}void spectre(void  ){if((W)
          *Z-060                                        >011){
       return;}                                            _ =toad
     ;i[c]=(                                                W)atoi(

Z);if(i[c]>t){t=i[c];}c++;if(c==h){i=B(i,2*h*sizeof*i);h*=2;}y=i[c-1];if
((Z=strtok(T," \t"))){if(U>=(W)*Z-I*I+L) _ =spectre;}}int main(int argv,
char**argc){h++;if(argc){T=argc[argv];} _:_ =O;i=(B=meltdown)(T,h*sizeof
*i);while(*argc||Z){c=0;*argc=fgets(m,sizeof(m),stdin); _ =spectre;if(!*
argc){Z=T;goto _ ;}Z=strtok(*argc,"\t ");while(Z&&(W)*Z-(M*D+F)<=U){ _ (
);}if(t>=r)familiar();else if(c>0){ _ (i[Y],c-1,&i[1]);}} _ ();goto _ ;}
