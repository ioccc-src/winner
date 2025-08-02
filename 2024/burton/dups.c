/*
 * usage: dups [-n] [len]
 */

#include <stdio.h>
#include <stdlib.h>

int main(int ac, char **av)
{
	char buf[32];

	int no = ac > 1 && av[1][0] == '-' && av[1][1] == 'n' && ++av && --ac;
	int n  = ac > 1 ? atoi(av[1]) : 5;

	while (fgets(buf, sizeof buf, stdin)) {
		char d[256] = {0};
		int skip = 0;
		if (buf[n] != '\n')
			continue;
		for (int i = 0; i < n; ++i) {
			int c = buf[i] |= 32;
			if (++d[c] > 1)
				++skip;
		}
		if (!!skip != no)
			printf("%s", buf);
	}
	return 0;
}
