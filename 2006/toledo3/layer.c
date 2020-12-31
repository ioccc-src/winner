#include <windows.h>
#define main ma
#define Display int
#define XOpenDisplay(a)1
#define BlackPixel(a,b)2
#define WhitePixel(a,b)3
#define XCreateGC(a,b,c,d)4
#define Window HWND
#define XCreateSimpleWindow(a,b,c,d,e,f,g,h,i)CreateWindowEx(0,"a","Chess",\
0xcf0000,c,d,e+8,f+32,0,0,aa,0)
#define XSelectInput(a,b,c)
#define XMapWindow(a,b)ShowWindow(b,dd)
#define XCreateBitmapFromData(a,b,c,d,e)CreateBitmap(d,e,1,1,c)
#define XNextEvent(a,b){ MSG m; if(!GetMessage(&m,0,0,0))return \
m.wParam; TranslateMessage(&m); DispatchMessage(&m); *b=oo; oo.type=0; }
#define XCopyPlane(a,b,c,d,e,f,g,h,i,j,k)(h1=GetDC(c),h2=CreateCompatibleDC\
(h1),h3=SelectObject(h2,b),BitBlt(h1,i,j,g,h,h2,e,f,0xcc0020),SelectObject\
(h2,h3),DeleteDC(h2),ReleaseDC(c,h1))
#define XFlush(a)
typedef struct{ int foreground; } XGCValues;
typedef struct{ int type,x,y; } XButtonEvent;
HDC h1,h2,h3; XButtonEvent oo; HINSTANCE aa; int dd; LRESULT CALLBACK
WP(HWND h,UINT m,WPARAM w,LPARAM l){ if(m==513)oo.type=4,oo.x=LOWORD(l)
,oo.y=HIWORD(l); else if(m==15)oo.type=12; else if(m==2)PostQuitMessage(0);
else return DefWindowProc(h, m, w, l); return 0; } int WINAPI WinMain
(HINSTANCE a,HINSTANCE b,LPSTR c,int d){ static WNDCLASSEX w;
char*z[]={0,"1",0}; return aa=a,w.hInstance=a,w.lpszClassName="a",
w.lpfnWndProc=WP,w.cbSize=sizeof(WNDCLASSEX),dd=d,w.hIcon=LoadIcon(0,32512),
w.hIconSm=LoadIcon(0,32512),w.hCursor=LoadCursor(0,32512),w.hbrBackground=1,
RegisterClassEx(&w),main(2,z); }
