
#ifndef JIT
#if defined(__x86_64__) || defined(__i386__) || \
		defined(__e2k__) || defined(__aarch64__)
#define JIT 1
#else
#define JIT 0
#endif
#endif

#ifndef DUMP
#define DUMP 0
#endif

#ifdef _WIN32
#include <fcntl.h>
#define U(a,b) b
#else
#define U(a,b) a
#define _GNU_SOURCE
#include <unistd.h>
#if JIT
#include <sys/mman.h>
#endif
#endif

#ifdef SDL
#include <SDL.h>
#if SDL_MAJOR_VERSION < 2
#define V(a,b) a
#else
#define V(a,b) b
#endif
#define L(a,b) a
#else
#define L(a,b) b
#ifdef _WIN32
#include <windows.h>
#define Q(x) (QueryPerformance##x(&q),q.QuadPart)
#else
#include <sys/time.h>
#include <X11/Xlib.h>
#ifdef TERMIOS
#define T(a,b) a
#include <termios.h>
#include <sys/ioctl.h>
#else
#define T(a,b) b
#include <X11/Xutil.h>
#endif
#endif
#endif
#include <stdio.h>
#include <stdlib.h>

#define H x->h[c&7]
typedef struct{
#if JIT
	char**b,*i,*q,*p;
#endif
	unsigned*m,k,y,z; char s[33]; void*h[8];
	L(SDL_Surface*S V(; ,; SDL_Window*W; ),
	U(Display*D; T(struct termios t[2]; char I[64],
		Window W; GC G; XImage*I; Atom A),
		HWND W; HDC D; double f);)
} ctx_t

U(; ,; static int E=0;
static LRESULT CALLBACK P(HWND a,UINT b,WPARAM c,LPARAM d){
	E|=b==2; ; return DefWindowProcA(a,b,c,d); } )

static int sys(unsigned n,int c,unsigned b,ctx_t*x){
	void*f; unsigned a,d;
	L(SDL_Event E,U(struct timeval t,LARGE_INTEGER q; MSG M));
	switch(n) {
		case 1:b=H?c<0?fgetc(H):fputc(b,H):-1; break;
		case 2:L(b=SDL_GetTicks(),U(gettimeofday(&t,0); b=t.tv_sec*1000+t.tv_usec/1000,b=Q(Counter)*x->f)); break;
		case 3:L(SDL_Delay(b),U(t.tv_sec=0; t.tv_usec=b*1000; select(0,0,0,0,&t),Sleep(b))); break;
		case 4:x->s[c&31]=b&&b-48>9&&(b|32)-97>25&&b-46?95:b; break;
		case 5:b=!(H=H?fclose(H),f=0:fopen(x->s,b?"wb":"rb")); break;
		case 6:b=H?c<0?ftell(H):fseek(H,(int)b,c/8):-1; break;
		case 7:
#define B(i,a,j) if(c==i){ x->m[1]=E.a.x|E.a.y<<14|E.a.j<<28; b
#ifdef DUMMY
			fprintf(stderr,"!!! dummy\n"); b=6; break;
		case 8:	b=2; break;
		case 9:
#elif defined SDL
			if(!(x->S||~(-c&-b)>>12)){
				SDL_Init(SDL_INIT_VIDEO);
				V(x->S=SDL_SetVideoMode(x->y=c,x->z=b,32,SDL_SWSURFACE);SDL_WM_SetCaption(x->s,0),
				n=SDL_WINDOWPOS_UNDEFINED;
				x->S=SDL_GetWindowSurface(x->W=SDL_CreateWindow(x->s,n,n,x->y=c,x->z=b,0)));
			}
			b=x->S?V(12,16)+(x->S->format->Rmask*513>>24&3):0; break;
		case 8:
			while(b=2,x->S&&SDL_PollEvent(&E)){
				c=E.type; b=c==SDL_KEYUP;
				if(b||c==SDL_KEYDOWN){ x->m[1]=E.key.keysym.sym; break; }
				b=c==SDL_MOUSEBUTTONUP; B(SDL_MOUSEBUTTONDOWN||b,button,button)+=4; break; }
				B(SDL_MOUSEMOTION,motion,x)=6; break; }
				if(c==SDL_QUIT){ b=3; break; }
			}
			break;
		case 9:b&=x->k; if(x->S&&b+x->y*x->z<x->k){
				for(n=0; n<x->z; n++)memcpy((char*)x->S->pixels+n*x->S->pitch,x->m+b+n*x->y,x->y*4);
				V(SDL_Flip(x->S),SDL_UpdateWindowSurface(x->W));
			}
#elif defined(_WIN32)
			if(!(x->W||~(-c&-b)>>12)){
				WNDCLASSA C={ 0,P,0,0,0,0,0,0,0,x->s} ;
				RECT r={ 0,0,x->y=c,x->z=b} ; RegisterClassA(&C); n=1<<31;
				AdjustWindowRect(&r,c=WS_CAPTION|WS_SYSMENU|WS_VISIBLE,0);
				x->D=GetDC(x->W=CreateWindowExA(0,x->s,x->s,c,n,n,
						r.right-r.left,r.bottom-r.top,0,0,0,0));
			}
			b=x->W?10:0; break;
		case 8:b=E*3;
		 if(!b)while(b=2,x->W&&PeekMessageA(&M,x->W,0,0,1)){
				b=M.message-512; if(b<11){ x->m[1]=M.lParam+(M.wParam&(b>9)<<30); b+=9; break; }
				b=(b|4)+252; if(b<2){ x->m[1]=M.wParam; break; }
				DispatchMessageA(&M);
			}
			break;
		case 9:b&=x->k; if(x->W&&b+x->y*x->z<x->k){
				int B[10]={ 40,x->y,-x->z,1<<21|1};
				SetDIBitsToDevice(x->D,0,0,x->y,x->z,0,0,0,x->z,x->m+b,f=&B,0);
				SwapBuffers(x->D);
			}
#elif defined(TERMIOS)
			if(!(x->y|~(-c&-b)>>12)){
				x->D=XOpenDisplay(0);
				tcgetattr(0,x->t); x->t[1]=*x->t; x->t->c_lflag&=~ICANON&~ECHO;
				x->t->c_cc[VMIN]=x->t->c_cc[VTIME]=0; tcsetattr(0,TCSANOW,x->t);
				x->y=c; x->z=b;
				printf("\33[?25l\33[2J");
			}
			b=x->D?4:0; break;
		case 8:
			{ static int i,n;
			while(read(0,&b,1)>0);
			if(!(i&=255))XQueryKeymap(x->D,&x->I[n^=32]);
			for(b=2;i<256;i++)if((x->I[i>>3]^x->I[i>>3|32])&(a=1<<(i&7))){
				x->m[1]=XKeycodeToKeysym(x->D,i,0); b=!(x->I[n|i++>>3]&a);
				break;
			} }
			break;
		case 9:b&=x->k; if(b+x->y*x->z<x->k){
        unsigned char*p,*r,*g;
        struct winsize s;
				int W,Q,w=x->y,h=x->z,q,e,i,j;
				ioctl(0,TIOCGWINSZ,&s);
				W=s.ws_col; Q=s.ws_row*2;
				p=malloc(W*Q*3);
				e=w*Q<W*h?q=(w*Q+h/2)/h,Q:(q=W,(h*W+w/2)/w);
				r=f=x->m+b;
				{
					int x,y,u,v,a,b,c,k,l,z=16,Y,Z;
					for(v=y=0; y<Q; v=c){ c=++y*z*h/e;
					for(u=x=0; x<W; u=a){ a=++x*z*w/q;
						for(j=0; j<3; p[(y*q+x-q)*3-3+j++]=(l+b/2)/b){ l=0;
							for(i=v; Z=((i^c)<z?c%z:z)-i%z,i<c; i+=Z)
							for(k=u; Y=((k^a)<z?a%z:z)-k%z,k<a; k+=Y)
								l+=r[i/z*w*4+k/z*4+j]*Y*Z;
							b=a-u; b*=c-v; } } }
				}
				for(j=0;j<e;j+=2){
					printf("\33[%dH",j/2+1);
					for(i=0;i<q;i++){
						r=p+(j*q+i)*3,g=r+q*3;
						printf("\33[");
						if(j+1<e)printf("48;2;%d;%d;%d",*g,g[1],g[2]);
						printf("m\33[38;2;%d;%d;%dm\342\226\200",*r,r[1],r[2]);
					}
          printf("\33[m%*s",W-q,"");
				}
				free(p);
				printf(j<Q?"\n\33[J":"\33[F\n");
			}
#else
			if(!(x->I||~(-c&-b)>>12)){
				XSizeHints h; h.flags=PMinSize|PMaxSize;
				h.min_width=h.max_width=c; h.min_height=h.max_height=b;
				x->G=XDefaultGC(x->D=XOpenDisplay(0),0);
				x->W=XCreateSimpleWindow(x->D,RootWindow(x->D,0),0,0,c,b,1,0,0);
				XSelectInput(x->D,x->W,KeyPressMask|KeyReleaseMask|ButtonPressMask|ButtonReleaseMask|PointerMotionMask);
				XSetStandardProperties(x->D,x->W,x->s,0,0,0,0,&h);
				x->A=XInternAtom(x->D,"WM_DELETE_WINDOW",0); XSetWMProtocols(x->D,x->W,&x->A,1);
				XMapWindow(x->D,x->W);
				x->I=XCreateImage(x->D,DefaultVisual(x->D,0),24,ZPixmap,0,0,x->y=c,x->z=b,32,0);
			}
			b=x->I?6:0; break;
		case 8:
			while(b=2,x->I&&XPending(x->D)){
				XEvent E; XNextEvent(x->D,&E); c=E.type;
				if(c-ClientMessage||*E.xclient.data.l-x->A) {
					b=c==KeyRelease; if(b||c==KeyPress){ x->m[1]=XLookupKeysym(&E.xkey,0); break; }
					b=c==ButtonRelease; B(ButtonPress||b,xbutton,button)+=4; break; }
					B(MotionNotify,xmotion,x)=6; break; }
				} else { b=3; break; }
			}
			break;
		case 9:b&=x->k; if(x->I&&b+x->y*x->z<x->k){
				x->I->data=f=x->m+b; XPutImage(x->D,x->W,x->G,x->I,0,0,0,0,x->y,x->z); XSync(x->D,0);
			}
#endif
			break;
		case 10:if(b){
#if JIT
			x->p=x->q; d=x->k/4; for(a=0; a<=d; a++)x->b[a]=x->i;
#endif
			} U(; ,else b=H?_setmode(_fileno(H),O_BINARY):0; )
			break;
		default:L(; ,U(
				T(x->D?(tcsetattr(0,TCSANOW,x->t+1),printf("\33[?25h")):0,
				x->I?x->I->data=0:0); ,; ))
			d=(*x->m-4)&x->k; a=x->m[d]>>14;
			if(a)fprintf(stderr,"bad opcode at 0x%x: 0x%x\n",d*4,x->m[d]);
			//else fprintf(stderr,"exit code: %d (0x%08x)\n",c,c);
#if JIT && DUMP == 2
			if((f=fopen("codedump.bin","wb"))){
				char*p=x->p,*p0=(char*)(x->b+x->k/4+1);
				fwrite(p0,1,p-p0,f); fclose(f);
			}
#endif
			exit(a?1:c);
	}
	return b;
}

#ifdef __e2k__
#define E2K_WAIT(flags) __asm__ ("wait " flags : : : "memory")
#define __clear_cache __clear_cache_e2k
static void __clear_cache_e2k(void *begin, void *end) {
	unsigned long step = 256, ptr = (long)begin & -step;
	E2K_WAIT("st_c=1");
	for (; ptr < (unsigned long)end; ptr += step)
		__builtin_storemas_64u(0, (void*)ptr, 15, __LCC_CHAN_ANY);
	E2K_WAIT("fl_c=1");
}
#endif

int main(int c,char**x){
	void*f=c-->1?fopen(x[1],"rb"):0;
	unsigned a,b=0,d,n=0,k=(1<<24)-1,*m=calloc(k+32,4);
	ctx_t C={ 0} ;
#if JIT
#ifdef __x86_64__
#define S(a,b) a
#define F E
#elif defined(__i386__)
#define S(a,b) b
#define F(x)
#elif defined(__e2k__)
	long*P;
#elif defined(__aarch64__)
	int*P;
#else
#error
#endif
	char**A,*p,*p0,*pr; int An=1<<24; /* 1<<30 max for e2k */
#if DUMP == 1
	FILE*ff=fopen("codedump.bin","wb");
#endif
#endif
	if(m&&f){ for(m+=16; b<=k&&((a=fgetc(f))<256||(a=x[c][n++]&255)||(n=0,--c)); b++)m[b/4]|=a<<b%4*8;
		fclose(f); m[1]=b; C.m=m; C.k=k; C.h[0]=stdin; C.h[1]=stdout; C.h[2]=stderr;
#ifdef _WIN32
		{ LARGE_INTEGER q; C.f=1000.0/Q(Frequency); timeBeginPeriod(1); }
#endif
#if JIT
		n=(k/4+3)*sizeof(f)+An;
		A=U(mmap(0,n,PROT_EXEC+PROT_READ+PROT_WRITE,MAP_PRIVATE+MAP_ANONYMOUS,-1,0),
			VirtualAlloc(0,n,MEM_COMMIT,PAGE_EXECUTE_READWRITE));
		if(!A)return 1;
		*A++=(void*)(size_t)sys; *A++=f=&C; p=p0=f=A+k/4+1;
#ifdef __aarch64__
		P=f=p;
		*P++=0xa9bc7bf9; // stp x25, x30, [sp, #-64]!
		*P++=0xa90163f7; // stp x23, x24, [sp, #16]
		*P++=0xa9025bf5; // stp x21, x22, [sp, #32]
		*P++=0xa90353f3; // stp x19, x20, [sp, #48]
		*P++=0xaa0003f3; // mov x19, x0
		*P++=0xaa0103f4; // mov x20, x1
		*P++=0xa97f5a95; // ldp x21, x22, [x20, #-16]
		a=k*4+3;
		*P++=0xd2800017|(a&65535)<<5; // mov x23, #<lo>
		*P++=0xf2a00017|(a>>16)<<5; // movk x23, #<hi>, lsl #16
		*P++=0x927ceef8; // and x24, x23, #-16
		*P++=0xd341ff18; // lsr x24, x24, #1
		*P++=0x100000d9; // adr x25, #6
		*P++=0xb9400260; // ldr w0, [x19]
		*P++=0x8a000700; // and x0, x24, x0, lsl #1
		*P++=0xf8606a80; // ldr x0, [x20, x0]
		*P++=0xd61f0000; // br x0
		C.b=A; C.i=f=P;
		*P++=0xd2800000; // mov x0, #0
		*P++=0xa94353f3; // ldp x19, x20, [sp, #48]
		*P++=0xa9425bf5; // ldp x21, x22, [sp, #32]
		*P++=0xa94163f7; // ldp x23, x24, [sp, #16]
		*P++=0xa8c47bf9; // ldp x25, x30, [sp], #64
		*P++=0xd65f03c0; // ret
		__clear_cache(p0, P);
#if DUMP == 1
		fwrite(p0,1,(char*)P-p0,ff); fflush(ff);
#endif
		C.q=f=P; sys(10,0,-1,&C);
		for(; ; ){
			unsigned i,x,r,q,X,t,h;
			pr=((char*(*)(void*,void*))(size_t)p0)(m,A);
			if(pr){ P=f=pr; d=(*m=*P)&k; p=A[d/4];
				if(p==C.i&&C.p==pr+8)C.p-=16;
				else{
					pr=p-C.i?p:C.p;
					c=(int*)pr-P+2;
					if((c^c>>31)>>25){
						a=((p-C.i?p:C.p)-C.i-4)>>2;
						P[-2]=0xd2800000|(a&65535)<<5; // mov x0, #<lo>
						P[-1]=0xf2a00000|(a>>16)<<5; // movk x0, #<hi>, lsl #16
						*P=0x8b000b20; // add x0, x25, x0, lsl #2
						P[1]=0xd61f0000; // br x0
					} else P[-2]=0x14000000|(c&0x3ffffff); // b (An=1<<27 max)
					__clear_cache(P-2,P+2);
					if(p-C.i)continue;
				}
			}
			if(C.p>p0+An-128)sys(10,0,-1,&C);
			P=f=C.p;
			a=m[d=*m&k]; X=d+4; A[d/4]=f=P;
			if(a==1<<28&&m[d+1]+m[d+2])X+=m[d+3],x=0;
			else{
				n=a>>23; c=q=0;
				r=n-64<64?c=256<<(~n/4&8),q=c>>n/16%2,n<96:2;
				i=m[d+2]||n-32>95||(n&12); do{
					x=a&127; a>>=7; b=m[++d];
					if(x>1)b*=4; if(x)b&=k*4+3;
					if(x-1<2&&!b)x=0,b=X;
					if(!x){
						b=((b+q)|-c)+q; h=0x12800000; // movn
						t=~b>>16&&~b<<16?h|=1<<30,b:~b; // mov
						if(!t||t<<16)*P++=h|i|(t&65535)<<5,h|=1<<29;
						if(t>>16)*P++=1<<21|h|i|(t>>16)<<5; // mov{k|z}, #{t>>16}, lsl #16
					} else{
#define R(i) \
	h=x>2?2:r; \
	t=0x39400260|(b>>h)<<10; \
	if(b&~(4095<<h)){ \
		*P++=0x52800000|i|(b&65535)<<5; /* mov */ \
		if(b>>16)*P++=0x72a00000|i|(b>>16)<<5; /* movk */ \
		t=0x38606a60|i<<16; /* ldrb w{i}, [x19, x{i}] */ \
	} \
	if(x>2){ \
		*P++=t|2<<30|i; \
		b=x-65; /* {sub|add} x{i+4}, x19, #{b} */ \
		if(b)*P++=0x91000264|(b>>31)<<30|i|(b>>31?-b:b)<<10; \
		*P++=0x0a170000|i*33; /* and w{i}, w{i}, w23 */ \
		t=0x38606800|i<<16|(b?i+4:19)<<5; \
	}
						R(i)
						*P++=t|r<<30|(c!=q)<<23|i; // ldr[s][h|b] w{i}, [x19, x{i}]
					}
				} while(i++&1);

				c=0; r=0;
				if(i-3)a>>=7,++d;
				else if(n-32<96)switch((q=n&15)){
					case 5:*P++=0x1b027c20; break; /* mul */
					case 6:case 7:*P++=0x1ac20820|(n&16)<<6; /* div{u|s} */
					if(n&1)*P++=0x1b028400; /* msub w0, w0, w2, w1 */
					break;
					case 8:P-=!x,*P++=x?0x1ac22020: /* lsl */
						0x53007c20^(b&31)<<10^(-b&31)<<16; break;
					case 9:P-=!x,*P++=x?0x1ac22420+((n&16)<<6): /* {l|a}sr */
						0x53007c20^(n&16)<<26^(b&31)<<16; break;
					case 0:case 1:
						if(!x&&!(b>>12&&-b>>12)){
							if(b>>31)b=-b,q^=1;
							P[-1]=0x11000020|q<<30|b<<10; /* {add|sub} w0, w1, #{b} */
							break;
						}
					case 2:case 3:case 4:
						*P++=0x020020|(0x0a4a2a4b0b>>q*8&255)<<24; break;
					default: c=1;
						if(x||(b>>12&&-b>>12))*P++=0x6b02003f; /* cmp w1, w2 */
						else P[-1]=b>>31?0x3100003f|-b<<10:0x7100003f|b<<10; /* cm{p|n} w1, #{b} */
						r=(n&16?0xbdca01:0x398201)>>(q-10)*4&15;
						*P++=0x1a9f07e0|r<<12; // cset w0, {r}
				} else{
					*P++=n>31||(!n&&a)?0x12800000:0x52800000|n<<5; // w0 = -1 or n
					if(n-1>9){
						*P++=0x52800004|(X&65535)<<5; // mov w4, {x.lo}
						if(X>>16)*P++=0x72a00004|(X>>16)<<5; // movk w4, {x.hi}
						*P++=0xb9000264; // str w4, [x19]
					}
					*P++=0xaa1603e3; // mov x3, x22
					*P++=0xd63f02a0; // blr x21
				}

				b=m[d+1]; x=a&127;
				if(x){
					n=a>>7&3; // 0123 -> 4321
					r=0x12>>n*2&3;
					if(x>1)b*=4; if(x)b&=k*4+3;
					if(x>2||b){
						R(1)
						*P++=t^1<<22^r<<30; // str[h|b] w0, [x19, x1]
          } else{
						// dynamic jump
						*P++=0xb9000260; // str w0, [x19]
						*P++=0x8a000700; // and x0, x24, x0, lsl #1
						*P++=0xf8606a80; // ldr x0, [x20, x0]
						*P++=0xd61f0000; // br x0
						x=-1;
					}
				} else if(b){ // jump if neq
					// b.{!r} or cbz w0, #5
					P-=c,*P++=c?0x540000a0|r:0x340000a0;
					*P++=0x10000040; // adr x0, #2
					*P++=0xd61f0320; // br x25
					*P++=X+b; *P++=0;
				}
			}
			if(~x){
				*P++=0x10000040; // adr x0, #2
				*P++=0xd61f0320; // br x25
				*P++=X; *P++=0;
			}
			p=f=P;
			__clear_cache(C.p, p);
#elif defined(__e2k__)
#define NOP 128
#define E4(x) *P++=(long)(x)<<32;
		P=f=p;
		*P++=0x58ecda86bc108056|NOP*2;
		*P++=0x6781d18211c0db84;
		*P++=0x6781d5836680c085;
		*P++=0x01c00000040000c4;
		*P++=k*4+3-(1L<<37);
		*P++=0x0118fff8fff0;

		*P++=0x0185d88520000011; E4(k&-4)
		*P++=0x1985c18520000001;
		*P++=0x6781858520000001|NOP*3;
		*P++=0x8000000004001012|NOP*7; *P++=0xe1c085d1;
		*P++=0;
		*P++=0xc000042000001001;
		C.b=A; C.i=f=P;
		*P++=0x11c0c00004000001;
		*P++=0x8000000020005013|NOP*5; *P++=0xf00000001100c080;
		*P++=0xc0000c2000001001;
		__clear_cache(p0, P);
#if DUMP == 1
		fwrite(p0, 1, (char*)P-p0, ff); fflush(ff);
#endif
		C.q=f=P; sys(10,0,-1,&C);
		for(; ; ){
			unsigned i,x,r,q,X,t;
			long pr=((long(*)(void*,void*))(size_t)p0)(m,A);
			if(pr){ d=(*m=pr)&k; p=A[d/4]; b=pr>>32; f=(char*)A+b;
				if(p==C.i&&C.p==(char*)f+8)C.p-=24;
				else{ *((int*)f-1)=((long*)(p-C.i?p:C.p)-(long*)f+2)&~0U>>4; __clear_cache((int*)f-1,f);
					if(p-C.i)continue; }
			}
			if(C.p>p0+An-256)sys(10,0,-1,&C);
			P=f=C.p;
			a=m[d=*m&k]; X=d+4; A[d/4]=f=P;
			if(a==1<<28&&m[d+1]+m[d+2])X+=m[d+3],x=0;
			else{
				n=a>>23; c=q=0;
				r=n-64<64?c=256<<(~n/4&8),q=c>>n/16%2,n<96:2;
				i=m[d+2]||n-32>95||(n&12); do{
					x=a&127; a>>=7; b=m[++d];
					if(x>1)b*=4; if(x)b&=k*4+3;
					if((x-1)<2&&!b)x=0,b=X;
					if(!x){
						b=((b+q)|-c)+q; t=(n&16)<<20;
						if(b>~32U)*P++=0x0ac0c00004000001|(long)(t|~b<<16|i)<<32;
						else if(b>>5)*P++=0x10c0d80004000011|(long)(t|i)<<32,E4(b)
						else*P++=0x10c0c00004000001|(long)(t|b<<16|i)<<32;
					} else{
						if(b>>5)*P++=0x6480d80004000011|NOP*2|(long)((x>2?2:r)<<24|i)<<32,E4(b)
						else*P++=0x64c0800004000001|NOP*2|(long)((x>2?2:r)<<24|b<<16|i)<<32;
						if(x>2){
							b=x-65; if(b){
								*P++=0x1180d8040c000012|(long)i<<32;
								*P++=0x01008400|i<<16|i|(long)b<<32;
							} else*P++=0x0100840004000001|(long)(i<<16|i)<<32;
							*P++=0x6400000004000001|NOP*2|((b?i+4:128)<<16|r<<24|i*257L)<<32;
						}
						if(c-q||(i<2&&n==23))*P++=0x0cc0000020000001|(r<<16|i*257L)<<32;		
					}
				} while(i++&1);

				c=0; r=1;
				if(i-3)a>>=7,++d;
				else if(n-32<96)switch((q=n&15)){
#if __iset__ < 5
					case 5:*P++=0x2001020020800011|NOP*5; *P++=7<<22; break;
#else
					case 5:*P++=0x2601020041000011|NOP*3; *P++=7<<22; break;
#endif
					case 6:*P++=0x4001020080000001|NOP*7|(n&16L)<<53; *P++=NOP*2; break;
					case 7:*P++=0x4501020080000001|NOP*7|(n&16L)<<53; *P++=NOP*2; break;
					default:
					if(q>9){ c=1;
						*P++=0x2001020004000001|NOP|((n&16?0xceec44:0x266244)>>(q-=10)*4&15L)<<36;
						*P++=0x0ec0c10004010011|NOP; r=0x32>>q&1; *P++=(r*8|0x846L)<<52;
					} else*P++=0x0001020004000001|((0xdcfff04298>>q*4&15L)+(q==9&&(n&16)))<<57;
				} else{
					if(n>31||(!n&&a))n=-1;
					if(n-1>9){ *P++=0x10c0d88504000011,E4(X)*P++=0x2680c08510000001; }
					*P++=0x8000000004001012|NOP*7; *P++=0xe1c082d1;
					*P++=0x11c083030c000012; *P++=0x10c0d800|(long)n<<32;
					*P++=0xc000042000009012; *P++=0x50000004;
				}

				b=m[d+1]; x=a&127;
				if(x){
					n=a>>7&3; // 0123 -> 4321
					q=0x12>>n*2&3;
					if(x>2){
						b=(b&k)*4;
						if(b>>5)*P++=0x6680d88504000011|NOP*2,E4(b)
						else*P++=0x66c0808504000001|NOP*2|(long)b<<48;
						b=x-65; if(b){
							*P++=0x1180d8860c000012;
							*P++=0x01858485|(long)b<<32;
						} else*P++=0x0185848504000001;
						*P++=0x2480850010000001|(b?6L:0L)<<48|(long)q<<56;
					} else{
						b=(x-1?b*4:b)&(k*4+3);
						if(b>>5)*P++=0x2480d80010000011|(long)q<<56,E4(b)
						else if(b)*P++=0x24c0800010000001|(long)q<<56|(long)b<<48;
						else{
							*P++=0x0100d88514000012;
							*P++=0x2680c000|(k&-4L)<<32;
							*P++=0x1985c18520000001;
							*P++=0x6781858520000001|NOP*3;
							*P++=0x8000000004001012|NOP*7; *P++=0xe1c085d1;
							*P++=0;
							*P++=0xc000042000001001;
							x=-1;
						}
					}
				} else if(b){
					if(c)P-=2; else*P++=0x2000c04004000001|NOP*2;
					*P++=0xc000004004005023|(long)r<<37;
					*P=0x11c0dc00|(((long*)C.i-P+2)&0xfffffffL)<<32; P++;
					*P=(long)(X+b)<<32|((char*)P-(char*)A); P++;
				}
			}
			if(~x){
				*P++=0xc000002004005023;
				*P=0x11c0dc00|(((long*)C.i-P+2)&0xfffffffL)<<32; P++;
				*P=(long)X<<32|((char*)P-(char*)A); P++;
			}
			p=f=P;
			__clear_cache(C.p, p);
#else /* x86 */
#define E(x) *p++=(char)(0x##x);
#define E4(x) *(int*)p=x; p+=4;
		E(55)E(53)F(41)E(56)
		S(E(48)E(89)U(E(fb),E(cb))E(49)E(89)U(E(f6),E(d6)),
			E(8b)E(5c)E(24)E(10)E(8b)E(74)E(24)E(14))
		E(bd)E4(k*4+3)
		E(8b)E(03)
		E(25)E4(k&-4)
		F(41)E(ff)E(24)S(E(46),E(06))
		C.b=A; C.i=p;
		E(6a)E(00)
		E(58)F(41)E(5e)E(5b)E(5d)E(c3)
		C.q=p; sys(10,0,-1,&C);
		for(; ; ){
			unsigned i,x,r,q,X;
			pr=((void*(*)(void*,void*))(size_t)p0)(m,A);
			if(pr){ d=(*m=*(int*)pr)&k; pr[-5]=-23; p=A[d/4]; // *(int*)pr=0;
				if(p!=C.i){ *(int*)(pr-4)=p-pr; continue; } *(int*)(pr-4)=C.p-pr; C.p-=C.p-pr-4?0:9; }
			if(C.p>p0+An-256)sys(10,0,-1,&C);
			p=C.p;
#define ER if(b>>7){ E(83+i*8)E4(b)} else{ E(43+i*8)E(0+b)}
			a=m[d=*m&k]; X=d+4; A[d/4]=p;
			if(a==1<<28&&m[d+1]+m[d+2])X+=m[d+3],x=0;
			else{
				n=a>>23; r=c=q=0;
				if(n-64<64)r=(n/2&8)+46-n/32,c=256<<(~n/4&8),q=c>>n/16%2;
				for(i=0; i<2; i++){
					x=a&127; a>>=7; b=m[++d];
					switch(x){
					case 0:E(b8+i)E4(b=((b+q)|-c)+q)break;
					case 1:case 2:
						b=(x-1?b*4:b)&(k*4+3);
						if(b){ if(r)E(f)E(8b+r)ER }
						else{ E(b8+i)E4(X)} break;
					default:
						b=(b&k)*4; E(8b)ER
						E(21)E(e8+i)b=x-65;
						if(r)E(f)E(8b+r)E(04+!!b*64+i*8)E(03+i*8)if(b)E(0+b)
					}
				}

				c=n>31&&n%16>9; r=0;
				if(n-32<96)switch(n&15){
					case 5:E(0f)E(af)E(c1)break;
					case 6:case 7:if(n&16){ E(99)E(f7)E(f9)}
						else{ E(33)E(d2)E(f7)E(f1)} r=n&1; break;
					case 8:E(d3)E(e0)break;
					case 9:E(d3)E(e8+(n&16))break;
					default:q=(n%16<5?0x46150>>n%8*4&7:7)*8;
						if(x){ E(03+q)E(c1)} else if(b||n%16>3){
							if(b-(char)b)p[-5]=5+q; else{ p-=5;E(83)E(c0+q)E(0+b)}
						} else p-=n=5; break;
				} else{
					if(n>31||(!n&&a))n=-1;
					if(n-1>9){ E(c7)E(03)E4(X)}
					S(E(89)U(E(ca)E(89)E(c6)E(bf),E(c2)E(49)E(89)E(c8)E(b9))
						E4(n)U(E(49),E(4d))E(8b)E(4e)E(f8)E(41),
						E(ff)E(76)E(fc)E(51)E(50)E(6a)E(0+n))
					E(ff)E(56)S(E(f0),E(f8)E(83)E(c4)E(10))
				}

				q=c?(n&16?0x45cefd:0x452673)>>~n%8*4&15:5;
				b=m[d+1]; x=a&127;
				if(x){
					n=a>>7&3;
					if(c){ E(0f)E(90+q)E(c0)if(n<3){ E(0f)E(b6)E(c0)} }
					if(x>2){
						E(8b)b=(b&k)*4; i=1; ER
						E(21)E(e9)
					}
					if(n==2)E(66)E(89-n%2)
					if(x<3){ b=x-1?(b&k)*4:b&(k*4+3);
						if(b>>7){ E(83+r*16)E4(b)} else{
							E(43+r*16)E(0+b)
							if(!b){ if(r)E(90+d*2)E(25)E4(k&-4)F(41)E(ff)E(24)S(E(46),E(06)) x=-1; }
						}
					} else{ b=x-65; E(04+!!b*64+r*16)E(0b)if(b)E(0+b) }
				} else if(b){
					if(n<32||n%16-5<3){ E(85)E(c0+r*18)}
					E(71^q)E(9)E(e8)E4(C.i-p-2)E4(X+b)
				}
			}
			if(x+1){ E(e8)E4(C.i-p-2)E4(X)}
#endif
#if DUMP == 1
			fwrite(C.p,1,p-C.p,ff); fflush(ff);
#endif
			C.p=p;
#else
		for(; ; ){
#define R b=m[++d]; n=a&127; if(n){ if(n-1)b=m[b&k]+(n>2?n-65:0); \
	if(n-2){ n=b%4*8; b=b/4&k; b=m[b]>>n|m[b+1]*2<<~n%32; } } a>>=7;
			a=m[d=*m&k]; *m+=4; R c=b; R d=m[d+1]; n=a>>9;
			switch(n){
#define X(n,t,o) case n:b=(t)c o(t)b; break;
#define Y(n,t,a,b,c,d)X(n,t,a)X(n+1,t,b)X(n+2,t,c)X(n+3,t,d)
#define O(n,t) Y(n,t,+,-,|,^)Y(n+4,t,&,*,/,%)Y(n+8,t,<<,>>,==,!=)Y(n+12,t,<,<=,>,>=)
				default:b=sys(n,c,b,&C); break;
				O(32,unsigned)O(48,int)
				O(64,unsigned short)O(80,short)
				O(96,unsigned char)O(112,signed char)
			}
			n=a&127; if(n){ c=0; d=n>2?m[d&k]+n-65:d;
			d=(n-2?c=d%4*8,d/4:d)&k; n=-1; n>>=a>>4&24;
#define W(c) m[d]=(m[d]|n c)^(~b&n)c;
			W(<<c)d++; if(c)W(>>(32-c))} else *m+=b?d:0;
#endif
		}
	}
	return 1;
}

