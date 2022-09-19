
             /*                                     ,*/
            #include                              <time.h>
             #include/*                     _  ,o*/  <stdlib.h>
             #define  c(C)/*     -      . */return      ( C); /*    2004*/
              #include   <stdio.h>/*.   Moekan           "'   `\b-'     */
                typedef/*  */char   p;p* u                     ,w       [9
                  ][128] ,*v;typedef  int _;_   R,i,N,I,A               ,m,o,e
             [9],  a[256],k    [9], n[               256];FILE*f       ;_ x   (_ K,_ r
        ,_ q){;   for(;                                         r<     q    ; K       =((
     0xffffff)   &(K>>8))^                                        n[255     &        ( K
   ^u[0        +                                     r  ++      ]     )]);c          (K
  )}        _ E                           (p*r,    p*q  ){     c(          f         =
          fopen                     (r  ,q))}_   B(_ q){c(    fseek        (f,      0
        ,q))}_ D(){c(  fclose(f ))}_  C(  p    *q){c(  0-    puts(q    )   )}_/*   /
      */main(_ t,p**z){if(t<4)c(   C("<in"       "file>"    "\40<l"   "a"  "yout> "
     /*b9213272*/"<outfile>"   ) )u=0;i=I=(E(z[1],"rb")) ?B(2)?0 :   (((o   =ftell
    (f))>=8)?(u     =(p*)malloc(o))?B(0)?0:!fread(u,o,1,f):0:0)?0:  D():0      ;if(
   !u)c(C("      bad\40input  "));if(E(z[2],"rb" )){for(N=-1;256> i;n[i++] =-1   )a[
   i]=0;       for(i=I=0;   i<o&&(R  =fgetc(   f))>-1;i++)++a[R] ?(R==N)?( ++I>7)?(n[
  N]+1       )?0:(n [N   ]=i-7):0:   (N=R)    |(I=1):0;A =-1;N=o+1;for(i=33;i<127;i++
  )(        n[i   ]+  1&&N>a[i])?    N= a     [A=i]     :0;B(i=I=0);if(A+1)for(N=n[A];
 I<       8&&   (R  =fgetc(f ))>    -1&& i   <o        ;i++)(i<N||i>N+7)?(R==A)?((*w[I
 ]             =u [i])?1:(*w[I]=   46))?(a             [I++]=i):0:0:0;D();}if(I<1)c(C(
              "  bad\40la" "yout  "))for(i            =0;256>(R=  i);n[i++]=R)for(A=8;
             A  >0;A --)   R  = ( (R&1)==0)          ?(unsigned int)R>>(01):((unsigned
            /*kero  Q'        ,KSS  */)R>>         1)^        0xedb88320;m=a[I-1];a[I
            ]=(m           <N)?(m=   N+8):        ++        m;for(i=00;i<I;e[i++]=0){
           v=w         [i]+1;for(R                      =33;127  >R;R++)if(R-47&&R-92
           &&       R-(_)* w[i])*(                   v++)=    (p)R;*v=0;}for(sprintf
                  /*'_  G*/  (*w+1,              "%0"     "8x",x(R=time(i=0),m,o)^~
                0)   ;i<       8;++           i)u      [N+ i]=*(*w+i+1);for(*k=x(~
                  0,i=0     ,*a);i>-        1;      ){for (A=i;A<I;A++){u[+a [ A]
                ]=w[A       ][e[A]]  ;     k     [A+1]=x (k[A],a[A],a[A+1]
              );}if     (R==k[I])      c(      (E(z[3  ],"wb+"))?fwrite(
             /* */   u,o,1,f)?D          ()|C("  \n    OK."):0    :C(
            "  \n  WriteError"            ))  for  (i  =+I-
           1  ;i >-1?!w[i][++                 e[+ i]]:0;
             ) for( A=+i--;                 A<I;e[A++]
             =0); (i <I-4                 )?putchar
             ((_   )  46)                  | fflush
            /*'      ,*/                  ( stdout
            ):       0&                    0;}c(C
           ("       \n                   fail")
           )      /*                    dP' /
                 dP                    pd  '
                '                      zc
                                      */
                                     }
