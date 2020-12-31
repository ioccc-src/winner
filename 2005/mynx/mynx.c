#define I int
#define c char *
#define G fscanf(f,
#define W while(
#define k return
#define Q if(
#define Z			512
#include <errno.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
FILE *f;
short w[4] = { 24, 80 };
I L, B, r, H;
c l[Z], b[Z], s[Z], S[Z][10], T[Z], h[Z];
I
e(c s)
{
	I n = 0;
	Q *s == '#')	
		k (I) strtol(s+1, 0, 0);
	W n < Z) {
		Q *S[n] && !strcmp(s, S[n]+1))
			k *S[n];
		n++;
	}
	k '?';
}
void
P(I x)
{
	Q x == '\n' || w[1] - 3 < B) {
		b[B] = 0;
		b[B+1] = 0;
		B = printf("%s", b);
		B = snprintf(
			b, Z,
			"\n   %s", 
			b + B + 1
		);
		r++;
	}
	Q b[B-1] != ' ' || !isspace(x)) {
		b[B++] = isspace(x) ? ' ' : x;
		Q w[1] - 3 < B)
			*strrchr(b, ' ') = 0;
	}
}
void
p(c t, ...)
{
	va_list x;
	va_start(x, t);	
	vsnprintf(s, Z, t, x);
	t = s;
	W *t)
		P(*t++);
	va_end(x);
}
I
X(c s)
{
	I x;
	c t = s;
	long m = ftell(f);
	W *t && (x = fgetc(f)) != EOF) {
		Q *t == '*')
			s = t++;
		Q tolower(x) != *t) {
			Q *s != '*')
				break;
			t = s;
		}
		t++;
	}
	Q *t)
		fseek(f, m, SEEK_SET);
	k !*t;
}
void
d(c s)
{
	Q 4 < B)
		P('\n');
	P('\n');
	Q *s == 'h')
		B = 1;
}
void
a(c s)
{
	*T = 0;
	G 
		ungetc(fgetc(f), f) == '"' 
			? "\"%511[^\"]" 
			: "'%511[^']", 
		T
	);
	Q *s == 'a' || *s == 'f' || s[1] == 'f') {
		free(l[++L]);
		l[L] = strdup(T);
		p(" [%d] ", L);
	} 
	Q *s != 'a')
		p("%s%s\n", T, *s == 'b' || s[1] == 'h' ? "" : "\n");
	X("*>");
}
void *Y[] = {
	"!--*-->"	,	0	,
	"a *href="	,	a	,	
	"ifr*src="	,	a	,
	"fra*src="	,	a	,
	"img*src="	,	a	,		
	"p*>"		,	d	,	
	"bl*>"		,	d	,
	"br"		,	a	,
	"hr"		,	a	,
	"h*>"		,	d	,	
	"/h"		,	a	,
	"/tr"		,	a	,
	"/dt"		,	a	,
	"/dd"		,	a	,
	"li*>"		,	d	,	
	"*>"		,	0	,	
	0		,	0
};
I
main(I V, c *v)
{
	I x, n = 0;
	c t = v[1];
	ioctl(0, TIOCGWINSZ, w);
	f = fopen("entities.txt", "r");
	Q f) {
		W G "%s %d", S[n]+1, &x) == 2)
			*S[n++] = x;
		fclose(f);
		n = 0;
	}	
	W t) {
		I m = 0;
		struct hostent *y;
		struct sockaddr_in A;
		L = 0;
		B = 1;
		Q !sscanf(t, "http://%255[^/]%n", h, &n) && !*h) {
			Q !(f = fopen(t, "rb")))
				k 1;
			goto e;
		}
		Q 0 < sscanf(h, "%*[^:]%n:%d", &x, &H))
			h[x] = 0;
		else
			H = 80;
		y = gethostbyname(h);
		Q !y)
			k 1;
		memcpy(&A.sin_addr.s_addr, y->h_addr, y->h_length);
		A.sin_port = htons( (short) H);
		A.sin_family = y->h_addrtype;
		f = tmpfile();
		Q !f)
			k 1;
		W 
			connect(
				m = socket(
					A.sin_family, SOCK_STREAM, 0
				), (void *) &A, sizeof A
			)
			|| errno == EINTR
		)
			;
		n = snprintf(
			b, Z, 
			"GET %s%s HTTP/1.0\r\nHost: %s:%d\r\n\r\n", 
			t[n] == '/' ? "" : "/", t+n, h, H
		);
		Q send(m, b, n, 0) == n) {
			W 0 < (n = recv(m, b, Z, 0)))
				fwrite(b, 1, n, f);
		}
		close(m);
		rewind(f);
		 X("*\r\n\r\n");
e:
		r = 3;
		*b = ' ';
		W r < *w && (x = fgetc(f)) != EOF) {
			Q x == '<') {
				void **p = Y;
				W *p) {
					Q X(*p)) {
						Q p[1])
							(* (void (*)(c ))
							p[1])(*p);
						break;
					}
					p += 2;
				}		
			} else {
				Q x == '&') {
					G "%9[^;];", T);
					x = e(T);
				}
				P(isspace(x) ? ' ' : x);
			}
		}
		printf("\n? ");
		fflush(stdout);
		fgets(T, Z, stdin);
		Q *T == '\n')
			goto e;
		t = l[strtol(T, 0, 0)];
		fclose(f);
	}
	k 0;
}
