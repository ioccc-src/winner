#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

/*
 * Wordle generator - text mode
 * This program works in coordination with the obfuscated code
 * to allow one to play more rapidly (e.g. test the algorithm)
 * or just to play along in text mode.
 *
 * This version is a pale imitation of the Real Wordle(tm).
 * If you want to get the real experience, please visit:
 *
 *	https://www.nytimes.com/games/wordle/index.html
 */

static int
check(char *w, char *target)
{
	printf("%.5s ", w);
	for (int i = 0; i < 5; ++i) {
		if (w[i] == target[i])
			putchar('g');
		else if (memchr(target, w[i], 5))
			putchar('y');
		else
			putchar('b');
	}
	putchar('\n');
	fflush(stdout);
	return memcmp(w, target, 5) == 0;
}

int
main(int ac, char **av)
{
	char words[78557][5];
	char buf[100];
	int  cnt = 0, win = 0;
	int  nguesses = 6;

	if (ac < 2) {
		fprintf(stderr, "usage: %s dict [target]\n", av[0]);
		return 1;
	}

	if (getenv("GUESSES")) {
		nguesses = atoi(getenv("GUESSES"));
		// fprintf(stderr, "using %d guesses\n", nguesses);
	}

	FILE *fp = fopen(av[1], "r");
	if (!fp) {
		perror(av[1]);
		exit(1);
	}
	while (fgets(buf, sizeof buf, fp)) {
		if (buf[5] != '\n')
			continue;
		memcpy(words[cnt++], buf, 5);
	}
	fclose(fp);

	srandom(time(0) ^ getpid());

	char *target = ac == 3 ? av[2] : words[random() % cnt];
	getenv("CHEAT") && printf("target: %.5s\n", target);

	int i;
	for (i = 0; i < nguesses; ) {
		printf("? "); fflush(stdout);
		if (!fgets(buf, sizeof buf, stdin))
			break;
		if (buf[5] != '\n') {
			printf("you must enter 5 letters\n");
			continue;
		}
		++i;
		if ((win = check(buf, target)))
			break;
	}
	printf("%c %d %s: %.5s\n", win ? 'y' : 'n', i, win ? "good" : "lose", target);
	return 0;
}
