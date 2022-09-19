// Initially you will be calm and serene:

                      int
                   X=320      ,Y=200,
                 n=0,m,     x,y,   j=1024;
               double     T=44.0     /7,P[
              333333     ],C[5]       ={ 0,3,
              0,0,8}      ,p=1,         B=11.0
               /630,      f=0,r   =     3,g
                =7,b        =13,*q=P,   D,*J;
                unsigned               char
                  U[66666],*v=U,*h,l[5555]
                       ,c=0,*e,*a,*z;

                    #include <math.h>
                #define R1(t)   t=(int)(t\
              *123456789           )%j; t/=j;
             #define                 Rl(C,t)\
             n++[C]         =         t*n/12;
              #define      RI(C)     B=-B; R1\
              (r)R1(g     )R1(b     )for(n\
               =0; n<j; ){ Rl(C   ,r)Rl\
                   (C,g)Rl(C    ,b)++n; }


// Later your brain will look more like this:

       #ifdef __DJGPP__
         #include <sys/movedata.h>
               #include <dpmi.h>
                 #include <pc.h>
   #define          Q(u,v)         u##portb(0x3##v
     #define          W        ; Q(out,C9),*h++/4)
          void       F(int i){  __dpmi_regs r
           ; if(i){ for(; i>=0; i-=8)while(
                     ~Q(in,DA) 
                  )&8^i); for(m=0,z
              =h+j; h    <z; m     ++){ Q(
         out,C8),m     )W W W; ++h; } dosmemput
   (v,X*Y,0xA0000   ); } else{       r.x.ax=
 0x13;            __dpmi_int(    0x10,&r); } }
                   #elif defined(SDL)
              #include "SDL/SDL.h"
          SDL_Surface    *s; void
         F(int i){ if   (i){ SDL_SetColors(
     s,h,0,256);         SDL_UpdateRect
     (s,0,0,0,        0); } else {  SDL_Init( 
       SDL_INIT_VIDEO); s=SDL_SetVideoMode
       (X,Y,8,0);       v=s->pixels; } }
                  #else
               #include "curses.h"
             void F(i){ if(i){ for(y=0;
          y<X*Y                   ; y++)
         { move  (y/X,y%X);        addch
        ((*(v   +y)/     32)      [" ."
        ",:+"   "=@#"   ]); } ;  refresh
        (); }     else{          initscr
        (),x=     COLS&~1,X=x<X?x:X,y=
         LINES      &~1,Y=y<Y?y:Y; } }
          #endif

main()
{
    F(0);

    for (x=-X/2,y=-Y/2;y<Y/2;++x>=X/2?x=-X/2,y++:4)
                {*q++ = sqrt(x*x+y*y);

    // store result of atan2 of x and y in *q++
    *q++ = atan2(x,y);

    }for (;n<j*2;l[n++]=0);
        for(;;)
        {
            a=l;z=l+j;e=l+j*2;
            if ((p+=B)>1){p=2-p;RI(l+j)}
                        else if (p<0){p=-p;RI(l)}

            // will the maintenance programmer get this?
            while(a<l+j) D=p**a+++(1-p)**z++,*e++=D;
            h=l+j*2;

            // best way?
            for (J=P,z=v; z<v+X*Y;){
                D = *J++;
                *z++=fabs(sin((*J+++C[1])*1.5+D*C[0]+C[2]*sin(C[3]+D/C[4]))*255);
            }F(8);

            // tidy up later
            C[2]+=B; f+=T/360; C[3]+=f;

            // just in case
            if (f>T)
                {C[1] += (f-T)/8;

            // sorry
            if (f>T*2)
                C[0]=sin(f)+sin(f*2)/2;
        }
    }
}
