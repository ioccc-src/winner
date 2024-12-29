   #include<stdarg.h>/*Y=\f*/
  #include<stdio.h>/*.(\x.f(*/
  #define z return/*xx))(\x.*/
  #include<stdlib.h>/*f(xx))*/
   typedef union w w;union w{
   #define L(f,y,x,t) w _ ##\
   f(w x,...){va_list argh;w\
   y; va_start(argh,x);y= *\
   (va_arg(argh,w*));va_end\
   (argh);z(t);} w f (w fw)\
   {r((w){.c= &_## f}, fw);}
   int _; void*p;w(*c)(w,...
   #define r(x,y)w*k=malloc\
    (sizeof(w)<<1); k[0]= x\
    ; k[1]=y; z((w) {.p= k})
    #define l(f,x,t)w _##f(\
    w x,...){z(t);}w f={.p\
    =(w[1]){{.c= &_##f}}};
    );};w a(w f,w x){w*d=f
     .p;z((*d->c)(x,d+1)


             ) ; }
      w a_(w f,w fw){r(f,
   fw);}w _(w f){w*k=f.p,r=
  a(*k,k[1]); free(k) ;z(r);}
 L(F,f,x,(w){._=x._?x._*a(_(f),
(w){._=x._-1})._:1})l(F_,f,F(f)
)L(  W,(f),/*=\*/x,a(f,a_(x,x))
)l(      Y,/*=\*/f,a(W(f),W(f))
 )int main(){printf("%.""f\n",
    a(a(Y,F_),(w){._=10})._
        /60./60/24/*d */
             ) ; }
