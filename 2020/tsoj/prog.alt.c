#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>
int t(){struct timeval t;gettimeofday(&t,0);return t.tv_usec/1000+t.tv_sec*1000;}

                                                            #define g(x,y,u,v,s)\
  for(int j=0,X=x,Y=y;j<v&&Y+j<h-X/w&&Y>=0&&X>=0;++j)memcpy(&f[Y+j][X],&s[j*u],u)
                                                      #define l(x,y,w,h,a,b,c,d)\
                    !((x-a>c&&x>=a)||(a-x>w&&a>=x)||(y-b>d&&y>=b)||(b-y>h&&b>=y))

                                                                      int main(){
             struct termios z,o;tcgetattr(0,&z);o=z;z.c_lflag&=~ICANON&~ECHO;
                      z.c_cc[VMIN]=0;z.c_cc[VTIME]=0;tcsetattr(0,TCSANOW,&z);
          srand(time(0));struct winsize v;ioctl(STDOUT_FILENO,TIOCGWINSZ,&v);
                 int h=v.ws_row,w=v.ws_col,A=w*h/100,l=t(),k,s=0,g=1,i,c=0,L;
                          struct V{float x,y;}p={w/2,h/2},b={-3*h},a[A],m[A];
                         char*r=" /\\ /__\\ ^^ ",*n="o0o0OO",u=0,q,f[h+1][w];
                                                                while(u^'q'){
                                                    float d=(t()-l)*.001;
                             q=u;do read(0,&u,1);while((u&'p')>=(u|'p'));
                                                     l=t();c+=15;i=h*w-1;
                                                                           K:
                                        L=c*d;L=abs(((i/w)-L)*(i%w)+h*w);
                        (*f)[i]=L%3+L%5+L%7+L%11+L%13+L%17+L%19>14?32:46;
                                                           if(i--)goto K;
                                         u^' '?0:(b.x=p.x+2,b.y=p.y,u=q);
                                               q^'h'?q^'l'?q^'k'?q^'j'?0:
                                                         (p.y+=d*15):
                                                        (p.y+=d*-15):
                                                         (p.x+=d*20):
                                                        (p.x+=d*-20);
                                            p.x=p.x<0?0:p.x>=w-4?w-4:p.x;
                                            p.y=p.y<0?0:p.y>=h-3?h-3:p.y;
                                                              b.y+=d*-20;
                                   int Y=b.y,X=b.x;Y*w+X>=0?f[Y][X]=64:0;
                                                                   i=A-1;
                                                                           L:
                                           k=0;struct V*e=&a[i],*z=&m[i];
                                               e->x+=d*z->x;e->y+=d*z->y;
                     l(b.x,b.y,1,1,e->x,e->y,6,4)&&!g?k=1,s++,b.y=-3*h:0;
                                    e->x<0-3||e->x>=w+3||e->y>=h+2||k||g?
                                                e->y=-rand()%h*(1+g),
                                                       e->x=rand()%w,
                                                   z->x=-8+rand()%15,
                                                  z->y=10+rand()%5:0;
                                    l(p.x,p.y,4,3,e->x,e->y,3,2)?u='q':0;
                                                      g(e->x,e->y,3,2,n);
                                                           if(i--)goto L;
                                                        g(p.x,p.y,4,3,r);
                                                               *(f[h])=0;
                printf("\033[0;4H%s\033[0;0H    \033[4D%i\n",&f[0][4],s);
                                                      while(t()-l<9);g=0;
                                                                            }
                                                   tcsetattr(0,TCSADRAIN,&o);
                                                                                }
