#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
main(int c, char *v[]) {
	FILE * f;
	int flen, ctxt, osize, pos, npos, i, k, l;
	char * m, *loc;
	char a;
	if (c != 5) exit(1);
	f = fopen(v[1], "r");
	if (!f) exit(1);
	osize = atoi(v[2]);
	ctxt = atoi(v[3]);
	srandom(atoi(v[4]));
	fseek(f, 0, SEEK_END); flen = ftell(f); fseek(f, 0, SEEK_SET);
	if (ctxt < 1 || ctxt >= flen) exit(1);

	m = malloc(flen + flen + ctxt);
	if (!m) exit(1);
	fread(m, flen, 1, f);

     for (i = k = l = 0; i < flen;)
        if ('_' - (a = m[i++]))
          {
            if (a == '<')
              for (a = ' '; i < flen && m[i++] - '>';);;
            if ((a - ' ' && a - '\n' &&
                 a - '\r' && a - '\t') || k - (a = ' '))
              m[l++] = k = a;
          };
      flen = l;

	memcpy(m+flen, m, flen + ctxt);
	pos = random() % flen;
	for (i = 0; i < osize; ++i) {
		npos = random() % flen;
		// find the context at pos starting from npos
		loc = memmem(m+npos, flen+ctxt-1, m+pos, ctxt);
		if (!loc) puts("I'm lost!!!"), exit(1);
		npos = (loc-m) % flen;
		putchar(m[npos]);
		pos = npos+1;
	}
	putchar('\n');
}

