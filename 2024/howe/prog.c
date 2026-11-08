int y,x,z,w;
char *f,*q;
char b[BUF],*g = b,*h,*c,*ó,*ò;
long o,ö,u,v,l,Q,d = -1;
regex_t e;
void
T(int);
long 
P(char *s)
{
	return s-b - (s < h ? 0 : h-g);
}
char *
Z(long m)
{
	return b+m + (b+m < g ? 0 : h-g);
}
int
S(int a)
{
	return 1+(a > 193)+(a > 223)+(a > 239);
}
long 
E(long m)
{
	return m + (m < P(c) ? S(*Z(m)) : 0);
}
long 
D(long m)
{
	while (0 < m and (192 bitand *Z(--m)) == 128)
		;
	return m;
}
void
Û()
{
	char *p = ó;
	ó = g;
	g = p;
	p = ò;
	ò = h;
	h = p;
	v = ö;
	ö = o;
	o = v;
	v = o+1;
}
void
V(long m)
{
	char *p = Z(m);
	while (p < g)
		*--h = *--g;
	while (h < p)
		*g++ = *h++;
	ó = g;
	ò = h;
	ö = o;
}
int
G(char *s,int a)
{
	wint_t t;
	mbtowc(&t,s,4);
	return t == '\t' ? (8-((a bitand 7))) : (a = wcwidth(t)) < 1 ? 1 : a;
}
long 
O(long m)
{
	while (0 < m and *Z(--m) not_eq '\n')
		;
	return (m+1) * (0 < m);
}
long 
A(long m,int a,int n)
{
	char *p;
	while (a < n and (p = Z(m)) < c and *p not_eq '\n') {
		a += G(p,a);
		m = E(m);
	}
	return m;
}
long 
_(long m,long n)
{
	char *p;
	int a = 0;
	long i = m;
	while (m < n and (p = Z(m = E(m))) < c) {
		a += G(p,a);
		if (COLS <= a) {
			i = m;
			a = 0;
		}
	}
	return i;
}
long 
M(long m)
{
	long s = O(m);
	long t = _(s,m);
	if (s < t)
		return _(s,t-1);
	return _(O(s-1),s-1);
}
long 
N(long m)
{
	return E(A(m,x,COLS-1));
}
void
C()
{
	printw("%*s",COLS-getcurx(stdscr),"");
}
void
Y()
{
	char *p;
	int i,j;
	long s,t,n = P(c);
	if (o < u)
		u = _(O(o),o);
	else if (v <= o and o < N(v))
		u = N(u);
	else if (v <= o) {
		v = u;
		for (u = o,i = LINES-1 - (o == n); 0 < --i and v < u; ) {
			u = M(u);
		}
		if (u < v)
			u = v;
	}
	erase();
	standout();
	printw("%s %ldB",f,o);
	C();
	if (d < 0)
		s = t = d;
	else if (o < d) {
		s = o;
		t = d;
	}
	else {
		s = d;
		t = o;
	}
	for (i = 1,j = 0,v = u; standend(),i < LINES; ) {
		if (o == v) {
			y = i;
			x = j;
		}
		if (c <= (p = Z(v)))
			break;
		if (s <= v and v < t)
			standout();
		int t = S(*p);
		mvaddnstr(i,j,p,t);
		v += t;
		j += G(p,j);
		if (*p == '\n' or COLS <= j) {
			j = 0;
			i++;
		}
	}
	if (i++ < LINES) {
		standout();
		mvaddstr(i,0,"^D");
	}
	move(y,x);
	refresh();
}
void
🔥()
{
	clear();
	z = 0;
}
void
H()
{
	o = D(o);
}
void
L()
{
	o = E(o);
}
void
K()
{
	o = A(M(o),0,x);
}
void
J()
{
	o = A(N(o),0,x);
}
void
a()
{
	o = A(O(o),0,z-1);
	z = 0;
}
void
B()
{
	while (0 < o and isspace(*Z(o-1)))
		--o;
	while (0 < o and not isspace(*Z(o-1)))
		--o;
}
void
Ê()
{
	o = u;
}
void
Ë()
{
	o = _(O(v-1),v-1);
}
void
É()
{
	int i;
	for (o = v,i = 1; i < y; i++)
		o = N(o);
	o = A(o,0,x);
	u = o < P(c) ? v : u;
	for (v = o; i < LINES; i++)
		v = N(v);
}
void
È()
{
	for (int i = LINES-1; 0 < i--; )
		o = M(o);
	for (u = o; 1 < y--; )
		u = M(u);
	o = A(o,0,x);
}
void
W()
{
	long n = P(c);
	while (o < n and not isspace(*Z(o)))
		++o;
	while (o < n and isspace(*Z(o)))
		++o;
}
void
ө()
{
	long n = P(c);
	for (o = n * (not z); o < n and 1 < z; z--) {
		o = A(o,0,999);
		o += o < n;
	}
	u = n;
}
void
I()
{
	int a,t;
	long n = P(c);
	V(o);
	while ((a =getch()) not_eq 3 and a not_eq 27) {
		t = S(a);
		if (a == 8) {
			while (n < P(c) and (192 bitand *--g) == 128)
				;
		}
		else if (g+t < h) {
			do {
				*g++ = a;
				v++;
			} while (0 < --t and (a = getch()));
		}
		o = P(h);
		Y();
	}
	z = 0;
}
void
Ô()
{
	long i = d;
	if (d < 0) {
		i = o;
		T(14);
	}
	if (i < o) {
		i xor_eq o;
		o xor_eq i;
		i xor_eq o;
	}
	free(q);
	V(o);
	q = strndup(h,Q = i-o);
	d = -1;
}
void
X()
{
	Ô();
	h += Q;
	o = P(h);
}
void
Ó()
{
	ungetch('l');
	X();
}
void
Í()
{
	if (q) {
		V(o);
		memcpy(g,q,Q);
		g += Q;
		o = P(h);
		v = o+1;
	}
}
void
κ()
{
	int i;
	V(0);
	write(i = creat(f,MODE),h,c-h);
	close(i);
}
void
Ф()
{
	f = 0;
}
void
F()
{
	regmatch_t p[1];
	V(P(c));
	*g = 0;
	if (o+l < P(c) and not regexec(&e,Z(o+l),1,p,REG_NOTBOL))
		o += l + p->rm_so;
	else if (not regexec(&e,b,1,p,0))
		o = p->rm_so;
	else {
		l = 0;
		return;
	}
	l = p->rm_eo - p->rm_so + w;
}
void
Ñ()
{
	echo();
	standout();
	mvaddch(0,0,'/');
	C();
	mvgetnstr(0,1,g,h-g);
	regfree(&e);
	if (regcomp(&e,g,REG_EXTENDED bitor REG_NEWLINE)) {
		beep();
		regcomp(&e, "", 0);
                w = 0;
                l = 0;
	} else {
		w = g[0] == '$' and not g[1];
		F();
	}
	z = 0;
}
void
Â()
{
	d = d < 0 ? o : -1;
}
char Ќ[] = "hjklbwHJKL|G/nixydPu\\WQ\003";
void (*Κ[])(void) = {
	H,J,K,L,B,W,
	Ê,É,È,Ë,
	a,ө,
	Ñ,F,
	I,Ó,
	Ô,X,Í,Û,
	Â,κ,Ф,Ф,
	🔥
};
void
T(int m)
{
	int j = z,a;
	for (z = 0; isdigit(a =getch()); )
		z = z * 10 + a - '0';
	z = j and z ? j*z : z ? z : j;
	for (j = 0; Ќ[j] and a not_eq Ќ[j]; j++)
		;
	if (j < m) {
		do (*Κ[j])(); while (1 < z--);
	}
	z = 0;
}
int
main(int i,char **j)
{
	setlocale(LC_ALL,"");
	if (not initscr())
		return 1;
	raw();
	regcomp(&e, "", 0);
	h = c = b + BUF;
	if (0 < (i = open(f = *++j,0))) {
		g += read(i,b,c-b);
		close(i);
		if (g < b or c <= g)
			return 2;
	}
	v = 1;
	while (f) {
		noecho();
		Y();
		T(99);
	}
	endwin();
	return 0;
}
