/* clang-format --style=LLVM < prog.c | reveal */

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main(void)
{
	int start = 0, len;
	char buf[128];

	while (fgets(buf, sizeof buf, stdin)) {
		len = strlen(buf);
		if (len > 3 && !isspace(buf[0])) {
			char c = buf[2];
			if (c == 'i')	   start = 1;
			if (c == 'm')	   start = 0;
			if (!start)	   continue;
			if (buf[2] == '*') c = buf[3];
			if (isalpha(c))	   putchar(c);
		} else if (start && len > 6 && buf[6] == ']')
			putchar(buf[4]);
	}
	putchar('\n');
	return 0;
}
