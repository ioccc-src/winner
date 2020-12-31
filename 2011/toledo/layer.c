/*
** Translation layer to make my 3D Tanks game (20th IOCCC, best non-chess game)
** to work in Windows
**
** by Oscar Toledo G.
** http://nanochess.110mb.com/
**
** From the original game replace:
**    #include <X11/Xlib.h>
**    #include <X11/keysym.h>
**
** with this:
**    #include "layer.c"
**
** Only tested with Dev-C++ 4.9.9.2
**
** Creation: Feb/10/2012.
*/

#include <windows.h>            /* Windows headers */

extern int L[];                 /* Keyboard table from game */

/*
** Original makefile translated
** Choose your keys if you like
*/
#define A VK_UP:0x57
#define B VK_LEFT:0x41
#define C VK_RIGHT:0x44
#define D VK_DOWN:0x53
#define E VK_BACK:VK_TAB
#define Q XFillRectangle(W,X,Y,

/*
** Some X11 definitions translated
*/
#define main ma
#define Display int
#define GC HDC
#define Pixmap HBITMAP
#define Window HWND
typedef struct{ int foreground; int line_width; } XGCValues;
typedef struct{ int type,X; } XEvent;

/* XNextEvent, read Windows messages */
#define XNextEvent(a,b)(GetMessage(&mm,0,0,0),TranslateMessage(&mm),\
  DispatchMessage(&mm),*b=oo,oo.type=0)
/* XOpenDisplay, not needed */
#define XOpenDisplay(a)NULL
/* XSelectInput, only needs to process second argument */
#define XSelectInput(a,b,c)b
/* XCreateSimpleWindow */
#define XCreateSimpleWindow(a,b,c,d,e,f,g,h,i)CreateWindowEx(0,"a","3D Tanks",\
  0xcf0000,c,d,e+8,f+32,0,0,aa,0)
/* XMapWindow, activate window and get DC to draw */
#define XMapWindow(a,b)(ShowWindow(b,dd),h1=GetDC(b),h3=CreateCompatibleDC(h1))
/* XPending, check for pending windows messages */
#define XPending(a)PeekMessage(&mm,O,0,0,PM_NOREMOVE)
/* XFlush, not needed */
#define XFlush(a)
/* XLookupKeysym, argument processing and returns key index */
#define XLookupKeysym(a,b)(b,(a)->X)
/* DefaultDepth, not needed */
#define DefaultDepth(a,b)0
/* XCreatePixmap, creates a double-buffer bitmap */
#define XCreatePixmap(a,b,c,d,e)CreateCompatibleBitmap(h1,c,d)
/* XCreateGC, instead selects bitmap for drawing */
#define XCreateGC(a,b,c,d)(SelectObject(h3,b),h3)
/* XChangeGC, selection of color and line width, all this is required */
#define XChangeGC(a,b,c,d)(rr!=INVALID_HANDLE_VALUE?DeleteObject(rr):0,\
  (d)->foreground=((d)->foreground&0xff0000)>>16|((d)->foreground&0xff)<<16|\
  (d)->foreground&0xff00,\
  rr=CreateSolidBrush((d)->foreground),\
  e2=CreatePen(PS_SOLID,(d)->line_width,(d)->foreground),\
  SelectObject(b,e2),\
  e1!=INVALID_HANDLE_VALUE?DeleteObject(e1):0,e1=e2)
/* XCopyArea, copies double buffer into main for non-flickering display */
#define XCopyArea(a,b,c,d,e,f,g,h,i,j)BitBlt(h1,i,j,g,h,h3,0,0,SRCCOPY)
/* Some windows variables required */
HBITMAP bb;
HBRUSH rr = INVALID_HANDLE_VALUE;
HPEN e1 = INVALID_HANDLE_VALUE, e2;
PAINTSTRUCT pp;
HDC h1, h2, h3;
XEvent oo;
HINSTANCE aa;
int dd;
MSG mm;
/* Main message processing */
LRESULT CALLBACK WP(HWND h,UINT m,WPARAM w,LPARAM l)
{
  if (m==WM_KEYDOWN&&L[w]==0)oo.type=2,oo.X=w;
  else if (m==WM_KEYUP&&L[w]==1)oo.type=3,oo.X=w;
  else if (m==WM_PAINT)BeginPaint(h,&pp),EndPaint(h,&pp);
  else if (m==15)oo.type=12;
  else if (m==2)exit(1);/*PostQuitMessage(0);*/
  else return DefWindowProc(h, m, w, l);
  return 0;
}
/* Main function */
int WINAPI WinMain(HINSTANCE a,HINSTANCE b,LPSTR c,int d)
{
  static WNDCLASSEX w;
  return aa=a,w.hInstance=a,w.lpszClassName="a",
  w.lpfnWndProc=WP,w.cbSize=sizeof(WNDCLASSEX),dd=d,
  w.hIcon=LoadIcon(0,IDI_APPLICATION),
  w.hIconSm=LoadIcon(0,IDI_APPLICATION),
  w.hCursor=LoadCursor(0,IDC_ARROW),
  w.hbrBackground=GetStockObject(BLACK_BRUSH),
  RegisterClassEx(&w),
  main();
}
/* XFillRectangle, note that X uses size and Windows uses coordinates */
void XFillRectangle(int *a, HBITMAP b, HDC c, int d, int e, int f, int g)
{
  RECT rect;

  rect.left = d;
  rect.top = e;
  rect.right = f + d;
  rect.bottom = g + e;
  FillRect(c, &rect, rr);
}
/* XDrawLine */
void XDrawLine(int *a, HBITMAP b, HDC c, int d, int e, int f, int g)
{
  MoveToEx(c, d, e, NULL);
  LineTo(c, f, g);
}
