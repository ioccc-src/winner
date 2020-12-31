
#include <stdlib.h>
#include <stdio.h>

void X(char* m, int s) {
	fputs(m, stderr);
	exit(s);
}

void E() {
	X("syntax error\n", 1);
}

void F() {
	X("fail\n", -1);
}

typedef union Argument {
	union Argument* (*init)(union Argument* f);
	union Argument* (*call)(union Argument* f, union Argument* x);
	union Argument* a;
	char c;
	long p;
	size_t n;
} Argument;

#define NUMBER_OF_ARGUMENTS 5

static inline Argument* Reference(Argument* f) {
	f[NUMBER_OF_ARGUMENTS-1].n++;
	return f;
}

Argument* Char(Argument* f);
Argument* Apply(Argument* f);
Argument* fA(Argument* f);
Argument* fD(Argument* f, Argument* x);
Argument* fCont(Argument* f, Argument* x);
Argument* fW(Argument* f, Argument* x);
Argument* fCh(Argument* f, Argument* x);
Argument* rA1(Argument* s, Argument* x);
Argument* rA2(Argument* s, Argument* x);
Argument* rApply1(Argument* s, Argument* x);
Argument* rApply2(Argument* s, Argument* x);
Argument* rS1(Argument* s, Argument* x);
Argument* rS2(Argument* s, Argument* x);
Argument* rD(Argument* s, Argument* x);
Argument* rC(Argument* f, Argument* x);
Argument* rCont(Argument* f, Argument* x);
Argument* rE(Argument* f, Argument* x);

static inline void Dereference(Argument* f) {
	if(f && !--f[NUMBER_OF_ARGUMENTS-1].n) {
		if(f[0].call!=fW && f[0].call!=fCh) Dereference(f[1].a);
		if(f[0].call!=fCont) Dereference(f[2].a);
		if(f[0].call!=rC && f[0].call!=rCont && f[0].call!=rE) Dereference(f[3].a);
		free(f);
	}
}

int ch=EOF, c;
FILE *p, *o=NULL;
static Argument T[256][2];

void Next(void) {
	do {
		if(c==EOF) return;
		if(T[c][0].init) return;
		if(!T[c][1].c) E();
		if(T[c][1].c=='c') for(c=getc(p); c!='\n'&&c!=EOF; c=getc(p));
		c = getc(p);
	} while(1);
}

Argument* I(void) {
	if(c==EOF) E();
	Argument* f = T[c];
	if(f[0].init!=Char) {
		c = getc(p);
		Next();
	}
	return f[0].init(&f[1]);
}

Argument* Create(Argument* f) {
	Argument* record = malloc(sizeof(Argument[NUMBER_OF_ARGUMENTS]));
	if(!record) X("memory error\n", -2);
	record[0] = *f;
	for(int i=1; i<NUMBER_OF_ARGUMENTS; i++) record[i] = (Argument){0};
	return Reference(record);
}

void Output(Argument* f);

int main(int argc, const char** argv) {
	if(argc<2 || argc>3) F();
	p = fopen(argv[1],"rb");
	if(!p) F();
	c = getc(p);
	Next();
	if(argc==3) {
		o = fopen(argv[2],"wb");
		if(!o) F();
	} else o = stderr;
	while(c!=EOF) {
		Argument* f = I();
		while(f[3].a) {
			if(f[0].call==rCont) {
				f = f[1].a[0].call(Reference(f[1].a), f);
			} else if(f[0].call==rE) {
				T[96][0].init = Apply;
				Argument* r = Reference(f[1].a);
				Dereference(f);
				f = r;
			} else {
				Argument* r = Create(&(Argument){ .call=fCont });
				r[1].a = f;
				r[2].p = ftell(p)+(c==EOF);
				f = f[0].call(Reference(f), r);
			}
		}
		if(o) {
			Output(f);
			fputc('\n', o);
			fflush(o);
		}
		Dereference(f);
	}
	return 0;
}

Argument* Char(Argument* f) {
	Argument* r = Create(f);
	c = getc(p);
	if(c==EOF) E();
	r[1].c = c;
	c = getc(p);
	Next();
	return r;
}

Argument* NewLine(Argument* f) {
	Argument* r = Create(f);
	r[1].c = '\n';
	return r;
}

Argument* rCont(Argument* f, Argument* x) {
	Argument* r = Reference(f[2].a);
	Dereference(x);
	Dereference(f);
	return r;
}

Argument* fD0(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=fD });
	r[1].a = x;
	Dereference(f);
	return r;
}

Argument* fA2(Argument* x, Argument*y) {
	if(y[3].a) {
		if(y[0].call==rCont || y[0].call==rE) {
			Dereference(x);
			return y;
		}
		Argument* r = Create(&(Argument){ .call=rA2 });
		r[1].a = x;
		r[3].a = y;
		return r;
	}
	return x[0].call(x, y);
}

Argument* rA2(Argument* s, Argument* x) {
	Argument* a = Reference(s[1].a);
	Argument* b = Reference(s[3].a);
	Dereference(s);
	return fA2(a, b[0].call(b, x));
}

Argument* fA1(Argument* f, Argument* x) {
	if(x[3].a) {
		if(x[0].call==rCont || x[0].call==rE) return x;
		Argument* r = Create(&(Argument){ .call=rA1 });
		r[1].a = f;
		r[3].a = x;
		return r;
	}
	if(x[0].call==fD0) {
		Argument* r = Create(&(Argument){ .call=fD });
		r[1].a = Reference(f[2].a);
		Dereference(x);
		Dereference(f);
		return r;
	}
	Argument* y = fA(f[2].a);
	Dereference(f);
	return fA2(x, y);
}

Argument* rA1(Argument* s, Argument* x) {
	Argument* f = Reference(s[1].a);
	Argument* a = Reference(s[3].a);
	Dereference(s);
	return fA1(f, a[0].call(a, x));
}

Argument* fA(Argument* f) {
	Reference(f);
	if(f[0].init!=fA) return f;
	return fA1(f, fA(f[1].a));
}

Argument* fD1(Argument* a, Argument* x) {
	if(a[3].a) {
		if(a[0].call==rCont || a[0].call==rE) {
			Dereference(x);
			return a;
		}
		Argument* r = Create(&(Argument){ .call=rD });
		r[1].a = x;
		r[3].a = a;
		return r;
	}
	return a[0].call(a, x);
}

Argument* rD(Argument* s, Argument* x) {
	Argument* a = Reference(s[3].a);
	Argument* y = Reference(s[1].a);
	Dereference(s);
	return fD1(a[0].call(a, x), y);
}

Argument* fD(Argument* f, Argument* x) {
	Argument* a = fA(f[1].a);
	Dereference(f);
	return fD1(a, x);
}

Argument* ApplyInit(Argument* f) {
	(void)f;
	Argument* r = Create(&(Argument){ .init=fA });
	r[1].a = I();
	r[2].a = I();
	return r;
}

Argument* ApplyExit(Argument* f) {
	(void)f;
	Dereference(I());
	return I();
}

Argument* Apply2(Argument* x, Argument* y) {
	if(y[3].a) {
		if(y[0].call==rCont || y[0].call==rE) {
			Dereference(x);
			return y;
		}
		Argument* r = Create(&(Argument){ .call=rApply2 });
		r[1].a = x;
		r[3].a = y;
		return r;
	}
	return x[0].call(x, y);
}

Argument* rApply2(Argument* s, Argument* x) {
	Argument* a = Reference(s[1].a);
	Argument* b = Reference(s[3].a);
	Dereference(s);
	return Apply2(a, b[0].call(b, x));
}

Argument* Apply1(Argument* x) {
	if(x[3].a) {
		if(x[0].call==rCont) return x;
		if(x[0].call==rE) {
			Dereference(I());
			return x;
		}
		Argument* r = Create(&(Argument){ .call=rApply1 });
		r[3].a = x;
		return r;
	}
	if(x[0].call!=fD0) return Apply2(x, I());
	Dereference(x);
	T[96][0].init = ApplyInit;
	Argument* r = Create(&(Argument){ .call=fD });
	r[1].a = I();
	T[96][0].init = Apply;
	return r;
}

Argument* rApply1(Argument* s, Argument* x) {
	Argument* a = Reference(s[3].a);
	Dereference(s);
	return Apply1(a[0].call(a, x));
}

Argument* Apply(Argument* f) {
	(void)f;
	return Apply1(I());
}

Argument* fK1(Argument* f, Argument* x) {
	Argument* r = Reference(f[1].a);
	Dereference(x);
	Dereference(f);
	return r;
}

Argument* fK0(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=fK1 });
	r[1].a = x;
	Dereference(f);
	return r;
}

Argument* fS22(Argument* a, Argument* b) {
	if(b[3].a) {
		if(b[0].call==rCont || b[0].call==rE) {
			Dereference(a);
			return b;
		}
		Argument* r = Create(&(Argument){ .call=rS2 });
		r[1].a = a;
		r[3].a = b;
		return r;
	}
	return a[0].call(a, b);
}

Argument* rS2(Argument* s, Argument* x) {
	Argument* a = Reference(s[1].a);
	Argument* b = Reference(s[3].a);
	Dereference(s);
	return fS22(a, b[0].call(b, x));
}

Argument* fS21(Argument* f, Argument* a, Argument* x) {
	if(a[3].a) {
		if(a[0].call==rCont || a[0].call==rE) {
			Dereference(x);
			Dereference(f);
			return a;
		}
		Argument* r = Create(&(Argument){ .call=rS1 });
		r[1].a = f;
		r[2].a = x;
		r[3].a = a;
		return r;
	}
	if(a[0].call==fD0) {
		Argument* r = Create(&(Argument){ .call=fD });
		r[1].a = Create(&(Argument){ .init=fA });
		r[1].a[1].a = Reference(f[2].a);
		r[1].a[2].a = x;
		Dereference(f);
		return r;
	}
	Argument* b = Reference(f[2].a);
	Dereference(f);
	return fS22(a, b[0].call(b, x));
}

Argument* rS1(Argument* s, Argument* x) {
	Argument* a = Reference(s[3].a);
	Argument* y = Reference(s[2].a);
	Argument* f = Reference(s[1].a);
	Dereference(s);
	return fS21(f, a[0].call(a, x), y);
}

Argument* fS2(Argument* f, Argument* x) {
	Argument* a = Reference(f[1].a);
	Reference(x);
	return fS21(f, a[0].call(a, x), x);
}

Argument* fS1(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=fS2 });
	r[1].a = Reference(f[1].a);
	r[2].a = x;
	Dereference(f);
	return r;
}

Argument* fS0(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=fS1 });
	r[1].a = x;
	Dereference(f);
	return r;
}

Argument* fI(Argument* f, Argument* x) {
	Dereference(f);
	return x;
}

Argument* fV(Argument* f, Argument* x) {
	Dereference(x);
	return f;
}

Argument* fW(Argument* f, Argument* x) {
	putc(f[1].c, stdout);
	Dereference(f);
	return x;
}

Argument* fR(Argument* f, Argument* x) {
	ch = getc(stdin);
	Argument* r = Create(&(Argument){ .call=ch!=EOF?fI:fV });
	Dereference(f);
	return x[0].call(x, r);
}

Argument* fCh(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=ch==f[1].c?fI:fV });
	Dereference(f);
	return x[0].call(x, r);
}

Argument* fP(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=ch!=EOF?fW:fV });
	if(ch!=EOF) r[1].c = ch;
	Dereference(f);
	return x[0].call(x, r);
}

Argument* rC(Argument* f, Argument* x) {
	if(x[3].a==x) return x[0].call(x, f);
	Argument* r = Reference(f[1].a);
	Dereference(f);
	return r[0].call(r, x);
}

Argument* fC(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=rC });
	r[1].a = x;
	r[3].a = r;
	Dereference(f);
	return r;
}

Argument* fCont(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=rCont });
	r[1].a = Reference(f[1].a);
	r[2].a = x;
	r[3].a = r;
	if(fseek(p, f[2].p-1, SEEK_SET)) F();
	c = getc(p);
	Next();
	Dereference(f);
	return r;
}

Argument* rE(Argument* f, Argument* x) {
	(void)f;
	return x;
}

Argument* fE(Argument* f, Argument* x) {
	Argument* r = Create(&(Argument){ .call=rE });
	r[1].a = x;
	r[3].a = r;
	T[96][0].init = ApplyExit;
	Dereference(f);
	return r;
}

static Argument T[256][2] = {
	[9]={ [1].c='s' }, //\t
	[10]={ [1].c='s' }, //\n
	[11]={ [1].c='s' }, //\v
	[12]={ [1].c='s' }, //\f
	[13]={ [1].c='s' }, //\r
	[32]={ [1].c='s' }, //' '
	[35]={ [1].c='c' }, //#
	[46]={ {Char}, [1].call=fW }, //.
	[63]={ {Char}, [1].call=fCh }, //?
	[64]={ {Create}, [1].call=fR }, //@
	[96]={ {Apply} }, //`
	[99]={ {Create}, [1].call=fC }, //c
	[100]={ {Create}, [1].call=fD0 }, //d
	[101]={ {Create}, [1].call=fE }, //e
	[105]={ {Create}, [1].call=fI }, //i
	[107]={ {Create}, [1].call=fK0 }, //k
	[114]={ {NewLine}, [1].call=fW }, //r
	[115]={ {Create}, [1].call=fS0 }, //s
	[118]={ {Create}, [1].call=fV }, //v
	[124]={ {Create}, [1].call=fP }, //|
};

void Output(Argument* f) {
	if(f[0].call==fK0) { fputc('k', o);
	} else if(f[0].call==fK1) {
		fprintf(o, "`k");
		Output(f[1].a);
	} else if(f[0].call==fS0) { fputc('s', o);
	} else if(f[0].call==fS1) {
		fprintf(o, "`s");
		Output(f[1].a);
	} else if(f[0].call==fS2) {
		fprintf(o, "``s");
		Output(f[1].a);
		Output(f[2].a);
	} else if(f[0].call==fI) { fputc('i', o);
	} else if(f[0].call==fV) { fputc('v', o);
	} else if(f[0].call==fW) {
		if(f[1].c=='\n') fputc('r', o); else {
			fputc('.', o);
			fputc(f[1].c, o);
		}
	} else if(f[0].call==fR) { fputc('@', o);
	} else if(f[0].call==fCh) {
		fputc('?', o);
		fputc(f[1].c, o);
	} else if(f[0].call==fP) { fputc('|', o);
	} else if(f[0].call==fC) { fputc('c', o);
	} else if(f[0].call==fE) { fputc('e', o);
	} else if(f[0].call==fD0) { fputc('d', o);
	} else if(f[0].call==fD) {
		fprintf(o, "`d");
		Output(f[1].a);
	} else if(f[0].init==fA) {
		fputc('`', o);
		Output(f[1].a);
		Output(f[2].a);
	} else if(f[0].call==fCont) {
		fprintf(o, "<cont:%li>", f[2].p);
	} else {
		fprintf(o, "<unknown>");
	}
}
