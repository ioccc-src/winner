#include<stdio.h>
#include<X11/Xlib.h>
#include<stdlib.h>
#include<sys/time.h>
#include<time.h>
#include<string.h>

static 
Display 
*b;static 
Window d; static GC e;
static int f,g,i;static 
double j,k;static void l
(int m){int _=00,__,x;double 
y,_x;y=m/j*02.0;_x=k/j*02.0;(void)
XSetForeground(b,e,BlackPixel(b,DefaultScreen
(b)));(void)XFillRectangle(b,d,e,00,00,(unsigned 
int)g,(unsigned int)f);if(m==00){for(__=0x0;__<g;__++)
for(x=0;x<f;)(void)XDrawPoint(b,d,e,__,x),x++;return;}(void)XSetForeground
(b,e,WhitePixel(b,DefaultScreen(b)));for(x=00;x<f;x++){__=0x0;if(((int)
(_*y)%2)==0)for(;__<g;__++){if(((int)(_*_x)%2)==1)(void)XDrawPoint(b,
d,e,__,x);_++;}_+=i-__;}}int main(int __x,char* ___[]){if(__x!=4)
fprintf(stderr,"usage:%spixelclockcarrier_freqhorizontal_total"
"\n",___[00]),exit(EXIT_FAILURE);j=atof(___[1]),k=atof(
___[(1+1)]),i=atoi(___[(1+1+1)]),b=XOpenDisplay("");
if(!b)exit(EXIT_FAILURE);{XSetWindowAttributes X;
X.event_mask=ExposureMask|ButtonPressMask,
X.override_redirect=True,
g=WidthOfScreen(ScreenOfDisplay
(b,DefaultScreen(b))),f=HeightOfScreen
(ScreenOfDisplay(b,DefaultScreen(b))),d
=XCreateWindow(b,RootWindow(b,DefaultScreen(b)),
00,00,(unsigned int)g,(unsigned int)f,00,CopyFromParent,
InputOutput,(Visual*)CopyFromParent,(unsigned long int)CWOverrideRedirect
|CWEventMask,&X);}(void)XMapWindow(b,d),(void)XRaiseWindow(b,d),e=
XCreateGC(b,d,0,0);{static int _X_[0377];int _x_;_X_[061]=948,
_X_[0x32]=01763,_X_[043]=0x4b9,52[_X_]=0x3dd,_X_[063]=1082,
_X_[0x36]=02143,_X_[42]=02063,_X_[070]=1094,065[_X_]=0x41d,
_X_[48]=02162,_X_[0x39]=02214,55[_X_]=0x406;while((_x_=
getchar())!=EOF){l(_X_[_x_]);{static struct timespec 
_l;_l.tv_nsec=03563262400,nanosleep(&_l,00);}}}
(void)XDestroyWindow(b,d),(void)XCloseDisplay
(b),exit(EXIT_SUCCESS);}
