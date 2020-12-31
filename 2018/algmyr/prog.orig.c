#include<stdio.h>
#include<stdlib.h>
#define M malloc(sizeof(
#define R fread(x,sizeof(float),Z*w,f)
#define E free(

char*G=
"   "
"    '"
"@(*AP(  "
"             "
"                     "
"                              "
"                                        "
"                                                   _"
"0   #@ .  \"C^*/XH\"Q2_U(D&(5*E0C 4B54DV   X    \"!9A@   89H$ !"
"0(/@@4 @(/@@(   #@T  @(\" @(    P, , P# , #Y1244^   ?R 0#%)14,A#9)24$B 1"
"_)!0,$Y145%R Y145$^&!81T! #9)24DV#Y)24DP  ;&P     -C4 $$B% @ !04%!04 @4(D$ #!(1"
"4 @#U574$^'^0D)!_&Z1D9'_$*!@8%^'Z!@8'_(&1D9'_(\"0D)#_%Z1D8%^/\\0$!#_ \"!_X$ /X! 0"
"$&(-$*!#_ $! 0'_/] ,$#_/\\&&&#_'Z!@8%^&\"0D)#_'V\"A8%^&>8D)#_$Z1D9%B(\" _X\" /X"
"! 0'^/ , PSP/P#' /\\,<H$\"C', @'R# ,&AD8F'(&!_P   ,,,,     _X&!! @0\" 0 "
"$! 0$!  @0(   \\5%14\" X1$0G_!$1$1$./\\2$1$. T5%14. \"0D'\\ 'Y)"
"144X \\0$ C_  !7Q     7A$! $2# 3_ $!_H   \\0'Q ? \\0"
"$! ? X1$1$.#A$1\"1_'](1$0X @0$ @? (5%14)"
"  1$?X0!\\\" 0$>!@& 088!X!#@$>"
"!$*! H1#X)!04X!$9%1,1"
"(&!;A 0   _P "
" ! 0;H&!"
" @$\""
"! ("
"\0";                            int s,p,e,c,t,r,a,l;   /* l e a k a g e */
 
                                                     int
                                                   F(int o
                                                ,int n, int t
                                             ){char*p=(o*(136-o)
                                           >=1260)*7*(o-9)+G; for(
                                          n=!(o=-1); n=*p+++64*n-*G
                                        ,(o+=3)>>2<5-t; ); return 255
                                       &n>>2*o%8; } float L[0x400];int
                                     T(float a,float b,float l,float*e)
                                    {return L[0x3ff]||!(e[1]=b*a+l**e)||
                                   !T(l*a-b**e,b,l,e+1); } float f(int x)
                                  {int w=s<<!!T(1,6.135885e-3,-1.882472e-5
                                 +1,L); x=(x%w+w)%w<<9; return(L[x/s]*(s-x%
                                s)+L[x/s+1]*(x%s))/s; } int C(float*h,float*
                               i,int r,int P){ int x,y,c; for(y=0; h<i; ++y,h
                               +=r){ c=P<1; for(*h=x=0; x<8; c+=(1&P>>x&&P+(*
                              h+=f(e*(l+a*(2*x+1))*y)*f(s/2-e*a*y+e*a*y*y*(t/p
                             )/(s/p)))),++x); float z=f(y*t)*f(y*t); *h=z*(1+3*
                             z+2*z*z)/6**h/c; } return h-i-r+1; } void d(int w,
                            int n,FILE*f){int Z=s/t; int S[5]; float**P=M float*
                            )*c);for(r=0;r<c;++r){ P[r]=M float)*Z); C(P[r],P[r]
                           +Z,1,r); } float*x=M float)*Z*w); for (; ; ){ for(r=0;
                r<5        ; ++r){ int o=1; for(R,a=256; o&&--a; )for(o=t=0; t<Z;        o+=
               P[a][       t]!=x[w*t+n],++t); S[r]=a; } if(R-Z*w)break; for(r=a=-       12;r<
              5&&(a+=     a<11?22:1)<127; )for(r=-1; ++r<5&&F(a,1,r)==S[r]; );if(a     <127&&r
    ==5      )putchar(    a); } for(; --c; E P[c])); E P); fclose(f);}int main(int    q,char**v)      {s=
   44100     ;p=25; e=    55;c=256; t=75; r=q>1?v[1][0]*c+v[1][1]:0; a=7;l=16;if(r    ==11620){d     (atoi
  (v[2]),   atoi(v[3]),  q<5?stdin:fopen(v[4],"r")); return 0; } char*H=malloc(c),*  h=H; sprintf   (H,"\0"
 "Usage\n"  "    %s [-"  "h] [-d #c cid] file1 file2 ... (or stdin)"+(q-1&&r==11624  ),v[0]);if(*  H)q=1;int
 w=2>q?1:q -1; FILE**f=M FILE*)*w); f[0]=stdin; if(q>1)for(r=0; r<w; f[r]=fopen(v[r +1],"r"),++r); int l=s/t
 *w; float *b=M float)*l ),*t=b+l; int*i=M int)*w); for(; ; ){ int x=*h&&1>ungetc(* H++,*f); for(r =w; r--;)
{ i[r]=getc (f[r]); if(i[r]<0)i[r]=!++x; } if(x==w)break; while(++r<6){ while(C(b++,t,w,F(*i++,r< 5,r))); i-=
w; fwrite(b-=w,sizeof(float),l,stdout); } fflush(stdout); } while(fclose(f[--w]),w); E f); E b); E i); E h);}

