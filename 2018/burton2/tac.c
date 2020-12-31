/*
 * tac - tokenize and count C-like languages
 *
 * tac is offered as a replacement for iocccsize.
 * Version 2018.04.18
 * Public Domain 2015 by Dave Burton.
 * Please keep this attribution with the source code.
 *
 * cc -O3 -DW=\"keywords\" -Wall -pedantic -o tac tac.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

/*
 * The keywords recognized by tac should be defined in an external file,
 * filtered by the following script into a new file, and #included
 * by defining the preprocessor variable W as this new file.
 *
 * The input to the script is a list of keywords, one word per line,
 * in any order.  The output is a single string suitable for tac.
 * --------------------------------------------------

#!/bin/sh
awk '/^[^$]/{l=length;m=m>l?m:l;a[l]=a[l]$1}
     END{printf"\"";for(i=1;i<=m;++i)printf" "a[i];print"\""}' $*

 * --------------------------------------------------
 * The pre-defined string below is the IOCCC reserved word list for 2016.
 * It was created by the above script, then inserted here in case the
 * source keywords file is not available.
 *
 * The format of the keyword string is precise; addition or removal of
 * a single character will cause improper operation.
 * 
 * DO NOT EDIT the string kw; instead:
 *
 *	mkkeywords < my.list > my.keywords
 *	cc -DW=\"my.keywords\" -o tac tac.c
 */

char *keywords = ""
#ifndef W

"  ifdoor intfor#ifandnotxor voidcharelsegotocaselongenumautobooltr\
ue whilebreakconstfloatshortunion#else#elif#line_Boolfalsecomplbito\
ror_eq returnsizeofstructdoubleswitchstaticexternsigned#ifdef#endif\
inline#errorbitandand_eqnot_eqxor_eq typedefdefault#ifndef#pragma_A\
tomic_Pragmaalignasalignof #includeunsignedcontinuevolatileregister\
restrict#warning_Complex_Generic_Alignas_Alignofnoreturn _Noreturn \
_Imaginary  thread_local _Thread_localstatic_assert _Static_assert"

#else
#  include W
#  undef W
#endif
;

int cline, cword, cbyte, cioccc, ckey, cextra;			// counts
int tsaved, tkey;						// totals
int fkeep, fsuppress, freserved, fioccc, fcompat, ftoken;	// flags

unsigned char *buf, *cur, *end, *white, *start;

enum {
	  CPP   = 256
	, CMT   = 257
	, KEYW  = 258
	, DIVEQ = 259
	, MULEQ = 260
	, MODEQ = 261
	, ADDEQ = 262
	, SUBEQ = 263
	, XOREQ = 264
	, OREQ  = 265
	, ANDEQ = 266
	, RSHEQ = 267
	, LSHEQ = 268
	, NOTEQ = 269
	, EQ    = 270
	, GE    = 271
	, LE    = 272
	, OR2   = 273
	, AND2  = 274
	, PP    = 275
	, MM    = 276
	, PTR   = 277
	, LSH   = 278
	, RSH   = 279
	, INT   = 300
	, FLOAT = 301
	, ID    = 302
	, DOT3  = 303
};

enum {
	  O=0x01	// octal
	, H=0x02	// hex
	, D=0x04	// decimal
	, I=0x08	// identifier
	, W=0x10	// whitespace
	, B=0x20	// brace, semi
	, OHD = O|H|D
	, HD  = H|D
	, HI  = H|I
};

char tab[256] = {
	 W, 00, 00, 00, 00, 00, 00, 00,   00,  W,  W,  W,  W,  W, 00, 00,
	00, 00, 00, 00, 00, 00, 00, 00,   00, 00, 00, 00, 00, 00, 00, 00,
	 W, 00, 00,  I, 00, 00, 00, 00,   00, 00, 00, 00, 00, 00, 00, 00,
	OHD,OHD,OHD,OHD,OHD,OHD,OHD,OHD,  HD, HD, 00,  B, 00, 00, 00, 00,

	00, HI, HI, HI, HI, HI, HI,  I,    I,  I,  I,  I,  I,  I,  I,  I,
	 I,  I,  I,  I,  I,  I,  I,  I,    I,  I,  I, 00, 00, 00, 00,  I,
	00, HI, HI, HI, HI, HI, HI,  I,    I,  I,  I,  I,  I,  I,  I,  I,
	 I,  I,  I,  I,  I,  I,  I,  I,    I,  I,  I,  B, 00,  B, 00, 00,
};

char tri[256] = {
	['='] = '#',
	['('] = '[',
	['/'] = '\\',
	[')'] = ']',
	['\'']= '^',
	['<'] = '{',
	['!'] = '|',
	['>'] = '}',
	['-'] = '~',
};

#define is(x, c) (tab[c]&(x))

/*
 * discard backslash-newline as-if not present, even if trigraph backslash
 * iocccsize counts tri as xbcount+=2,
 * and bs-nl as xb+=2, xw++, xl++ to match wc(1)
 */

void readsource() {
	int c, d, o=2, len=4096;
	buf = malloc(len);
	while ((c = getchar()) != EOF) {
		if (c == '\r') {
			if (fcompat) ++cextra;
			continue;
		}
		if (buf[o-1] == '?' && buf[o-2] == '?' && tri[c]) {
			c = tri[c];
			o -= 2;
			if (fcompat) cextra += 2;
		}

		/*
		 * digraph support:
		 * translating digraphs after trigraphs is,
		 * for the purposes of this code, essentially during tokenization.
		 */
		d = c;
		switch (buf[o-1]) {
		case '<': d = (c == ':' ? '[' : c == '%' ? '{' : c); break;
		case '%': d = (c == '>' ? '}' : c == ':' ? '#' : c); break;
		case ':': d = (c == '>' ? ']' : c); break;
		}
		if (c != d) {
			c = d;
			o--;
			if (fcompat) ++cextra;
		}

		if (c == '\n' && buf[o-1] == '\\') {
			--o;
			cline++;
			if (fcompat) {
				++cword;
				cextra += 2;
			}
		} else
			buf[o++] = c;
		if (o == len)
			buf = realloc(buf, len+=4096);
	}
	buf[o] = 0;
	end = buf + o;
	cur = buf += 2;
}

/*
 * keyword recognition: kw is sorted by length, space separated between lengths
 *	e.g. "  ifdo forint#if charvoidelsegoto..."
 * build a table of offsets for each length
 *	e.g. [0]0, [1]1, [2]2, [3]7, [4]17, ...
 * this allows scans for only words of same length instead of entire list
 * trade-off is a small, but constant start-up cost to get a configurable
 * word list (backported from obfuscated code: it was too nice to give up)
 */

int nkwoff, kwoff[32];	   // allows keywords up to 32 characters in length

void kwinit() {
	char *k = keywords;
	for (nkwoff = 0; *k; ++k)
		while (*k == ' ')
			kwoff[++nkwoff] = ++k - keywords;
	kwoff[++nkwoff] = ++k - keywords;
}

int iskw(unsigned char *s, int len) {
	int found = 0;
	if (len < nkwoff) {
		char *off = keywords + kwoff[len];
		char *end = keywords + kwoff[len + 1] - 1;
		for (; !found && off < end; off += len)
			found = *s == *off && !strncmp((char*)s, off, len);
		if (found) {
			++ckey;
			tkey += len - 1;
		}
	}
	return found;
}

int want(char m) {
	while (cur < end) {
		if (*cur == '\\') {
			/*
			 * need to only ignore: ntbrfv\'"a?, octal, x, hex
			 * 0111 = two chars, \091 = three, \xabc = one char(!)
			 * for our purposes, only need: ' "  and \ newline,
			 * but readsource eats \ newline, so only quotes here
			 */
			if (cur[1] == '\\' || cur[1] == '\'' || cur[1] == '"') {
				cur += 2;
				continue;
			}
		}
		if (*cur == '\n') ++cline;
		if (*cur++ == m) return m;
	}
	return 0;
}

int follow(char m, int y, int n) {
	if (*cur == m) return ++cur,y;
	return n;
}

int follow2(char m, int y, int n, int y2) {
	if (*cur == m) return ++cur,y;
	if (*cur == n) return ++cur,y2;
	return n;
}

int skipwhite() {
	int c;
	for (c=*cur++; cur<=end && is(W, c); c=*cur++) {
		++cbyte;
		if (c == '\n') ++cline;
	}
	return c;
}

/*
 * CPP tokens may extend beyond a single line of text and include comments
 * To do this correctly, need to scan and remove comments during readsource
 * and present comments as whitespace.  Note that "# include" is a valid CPP
 * token, and does not match "#include".
 *
 * Because the global pointers cur, start and white are well-known, and
 * because comments are not consumed during readsource, it is more difficult
 * to parse CPP stuff.  Also note that for backwards compat, we need to also
 * count words correctly, with and without -k.
 */

int lex() {
	int c, t;

	white = cur;
	c = skipwhite();
	start = cur-1;

	if (cur >= end)
		return c;

	switch (c) {
	case '\'': want(c); return c;
	case '"':  want(c); return c;
	case '/':
		t = follow2('=', DIVEQ, c, CMT);
		if (t == CMT)
			want('\n');
		else if (t == c && (t = follow('*', CMT, c)) == CMT)
			do want('*'); while (cur<end && follow('/', 0, 1));
		return t;
	case '*':  return follow ('=', MULEQ, c);
	case '%':  return follow ('=', MODEQ, c);
	case '=':  return follow ('=', EQ,    c);
	case '!':  return follow ('=', NOTEQ, c);
	case '^':  return follow ('=', XOREQ, c);
	case '|':  return follow2('=', OREQ,  c, OR2);
	case '&':  return follow2('=', ANDEQ, c, AND2);
	case '+':  return follow2('=', ADDEQ, c, PP);
	case '-':  t =    follow2('=', SUBEQ, c, MM);
	   return t==c?   follow ('>', PTR,   t) : t;
	case '>':  t =    follow2('=', GE,    c, RSH);
	   return t==RSH? follow ('=', RSHEQ, t) : t;
	case '<':  t =    follow2('=', LE,    c, LSH);
	   return t==LSH? follow ('=', LSHEQ, t):t;

	case '#':  if (ftoken || !fcompat) return want('\n'), CPP;
	case '.':  if (cur[0] == c && cur[1] == c) return cur+=2, DOT3;
	}

	if (is(D, c)) {
	    if (c == '0' && (*cur|32) == 'x')
		c = *++cur;
	    while (is(OHD, c))
		c = *cur++;
	    if (c == '.' || (c|32) == 'e') {
		(void)strtod((char*)start, (char**)&cur);  // find end of float
		return FLOAT;
	    }
	    return --cur, INT;
	}

	if (is(I, c)) {
	    while (is(I|D, c))
	    	c = *cur++;
	    --cur;
	    return iskw(start, cur-start) ? KEYW : ID;
	}

	return c ? c : ' ';	// allows nulls in source code
}

// iocccsize compat: adjust whitespace counts
void compat_words(int tlen, int inword) {
	int c;
	for (c=0; c<tlen; ++c) {
		int isw = is(W,start[c]);
		if (isw || (is(B,start[c]) && is(W,start[c+1])))
			--cioccc;
		if (inword)    inword = !isw;
		else if (!isw) inword = ++cword;
	}
}

void compat_kw(int tlen, int inword) {
	int c, w=0;
	for (w=c=2; c<tlen; ++c) {	// skip comment lead-in chars
		int isw = !is(I|D,start[c]);
		if (inword) {
			inword = !isw;
			if (!inword && iskw(start+w, c-w))
				cioccc -= c-w-1;
		} else if (!isw)
			inword = w = c;
	}
}

void compat(int t, int tlen) {
	static int tprev;
	int c;
	if (tprev == CMT) {
		/*
		 * do not bcount spaces following comment blocks,
		 * including the newline!  nor lcount the newline following
		 * a comment block if last on line
		 */
		unsigned char *ow = white;
		while (ow<start && *ow++ != '\n')
			;
		if (!fkeep && ow[-1] == '\n')
			--cline;
		cbyte -= ow-white;
		tprev = 0;
	}
	// new-style comments eat preceding newline,
	// leaving no whitespace if token starts line
	// add it back here for compat word boundary detection
	if (white == start && white[-1] == '\n')
		--white;
	if (t == CMT) {
		// do not count newlines within comments
		// and checks for keywords in new-style comments
		if (fkeep) {
			int inword = white==start && start>buf;
			cioccc += tlen;
			if (start[1] == '/')
				compat_kw(tlen, inword);
			compat_words(tlen, inword);
		} else for (c=0; c<tlen; ++c)
			if (start[c] == '\n') --cline;

		// nor spaces before comments IFF the comment
		// is first non-white on line
		unsigned char *os = start;
		while (os > white) {
			if (*--os == '\n')
				break;
		}

		// look for last ends with newline,
		// only remove ccounts if whitespace
		if (*os == '\n' || os == buf || white[-1] == '\n')
			cbyte -= start - os - (*os == '\n');

		// look for whitespace before the comment, as well as after
		if (!fkeep
		&& (white != start || start == buf)
		&& !is(W, start[tlen]) && start[1] == '*')
			++cword;

		if (start[1] == '*')
			tprev = CMT;
	} else if (t == '"' || t == '\'') {
		// iocccsize -i does not count whitespace WITHIN a string!!!
		// and {;} can be "free" within a string if follows the "rules"
		compat_words(tlen, 1);
	}
	// count words, not tokens (a preceding old-style CMT is whitespace)
	if (t && t != CMT && white == start && start > buf)
		--cword;
	if (!fsuppress && (t != CMT || fkeep))
		printf("%.*s", (int)(start-white)+tlen, white);
}

void count() {
	int t, tlen;
	kwinit();
	while ((t=lex())) {
		tlen = cur-start;
		if (t != CMT) {
			cbyte += tlen;
			++cword;
			if (freserved && t == KEYW)
				cioccc += 1;
			else if (t < 256 && is(B, t) && (is(W, *cur) || !*cur))
				;
			else
				cioccc += tlen;
		}
		if (fcompat)
			compat(t, tlen);
		else if (!fsuppress && (t != CMT || fkeep)) {
			if (!ftoken) printf("%3d ", t);
			printf("%.*s", tlen, start);
			if (cur[-1] != '\n') printf("\n");
		}
	}

	if (fcompat) {
		// process comments just before end of file
		compat(0, end-white);
	}

	if (fkeep) cbyte = end - buf;
	if (!freserved) tkey = 0;
	tsaved = cbyte - cioccc - tkey;
	cbyte += cextra;
}

int main(int ac, char **av) {
	static char usage[] = "[flags] [file]\n\
	-t  tokenize input\n\
	-c  compatible count and display token ids\n\
	-k  keep comments\n\
	-s  suppress source\n\
	-r  reserved words count as 1\n\
	-i  ioccc size (implies -rs)\n\
	-h  this help";

	fcompat = 1;	// default: compact with iocccsize: invert sense of -c

	int c;
	while ((c = getopt(ac, av, "?tcksrih")) != EOF) {
	    switch (c) {
	    case 't': ftoken    = 1; // fallthru - -t implies -c
	    case 'c': fcompat   = 0; break;
	    case 'k': fkeep     = 1; break;
	    case 's': fsuppress = 1; break;
	    case 'r': freserved = 1; break;
	    case 'i': fioccc = freserved = fsuppress = fcompat = 1; break;
	    case 'h': // fallthru, alias for -?
	    default:
	    	fprintf(stderr, "%s %s\n", av[0], usage);
		return 1;
	    }
	}

	ac -= optind;
	av += optind;
	if (ac > 0 && !freopen(*av, "r", stdin)) {
		perror(*av);
		exit(1);
	}

	readsource();
	count();

	if (!ftoken) {
		if (fioccc) printf("%d\n", cioccc);
		else        fprintf(stderr, "%d %d %d %d %d %d %d\n",
				cline,cword,cbyte,cioccc,tsaved,ckey,tkey);
	}
	return 0;
}
