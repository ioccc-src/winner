/*
 * run - connect gen and prog via pipes
 *
 * one-shot: run dict
 * specific: run dict $start $target
 * automate: cat dict | while read a; do run dict $start $a; done
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>

static int DB;

static int
error(char *who)
{
	perror(who);
	kill(0, SIGKILL);
	exit(1);
}

static int
xread(int fd, char *buf, int len)
{
	int remain = len;
	int t = 0;

	if (DB) { printf("xread %d:", len); fflush(stdout); }

	do {
		int n = read(fd, buf + t, remain);
		if (n < 0) error("read");
		if (n == 0) return t;
		if (n <= remain) {
			remain -= n;
			t += n;
		}
	} while (t != len);
	buf[t] = 0;

	if (DB) {
		printf(" %s", buf);
		if (buf[t-1] != '\n') printf("\n");
		fflush(stdout);
	}

	return t;
}

static void
spawn(int r[2], int w[2], char **ev, char *path, char *name, char *dict, char *opt)
{
	pipe(r) && error("pipe r");
	pipe(w) && error("pipe w");

	pid_t pid = fork();
	if (pid == -1)
		error("fork");

	if (pid == 0) {
		char *v[4] = { name, dict, opt, 0 };

		dup2(r[0], 0) < 0 && error("dup2 r[0]");
		dup2(w[1], 1) < 0 && error("dup2 w[1]");

		close(r[1]);
		close(w[0]);

		execve(path, v, ev);
		error(path);
	}

	close(r[0]);
	close(w[1]);
}

int
main(int ac, char **av, char **ev)
{
	int pgr[2], pgw[2]; // gen r/w
	int ppr[2], ppw[2]; // prog r/w

	static char guess[20], report[20];
	static char xyzzy[] = "xyzzy";
	char *cp, *prog = "./prog";
	int n, end = 0;
	int nguesses = 6;

	if (ac < 2) {
		fprintf(stderr, "usage: %s dict [start [target]]\n", av[0]);
		return 1;
	}

	DB = !!getenv("DEBUG");

	if ((cp = getenv("GUESSES")))
		nguesses = atoi(cp);
	if ((cp = getenv("PROG")))
		prog = cp;

	spawn(pgr, pgw, ev, "./gen",  "gen",  av[1], ac==4 ? av[3] : 0);
	spawn(ppr, ppw, ev, prog,     "prog", av[1], 0);

	// wait for gen to be ready; read the prompt
	char buf[20];
	xread(pgw[0], buf, 2);
	if (buf[0] != '?') {
		xread(pgw[0], buf+2, 12); // target: guess
		printf("gen: %s", buf);
		xread(pgw[0], buf, 2);
	}

	// wait for prog prompt
	xread(ppw[0], buf, 2);

	memcpy(guess, ac>2 ? av[2] : "blast", 5);
	guess[5] = '\n';  // mimic reading from stdin

	for (int i = 0; i < nguesses && end != 1; ++i) {
		printf("guess%d: %s", i+1, guess);

		n = write(pgr[1], guess, 6);
		if (n < 0) error("write pgw[1]");
		n = xread(pgw[0], report, 12);
		if (n != 12) {
			if (n < 0) error("read pgr[0]");
			printf("bad read from pgr[0]: %d\n", n);
			return 2;
		}

		printf("gen: %s", report);

		xread(pgw[0], guess, 2); // read the prompt
		if (guess[0] != '?') {
			xread(pgw[0], guess+2, 14);
			printf("gen result end=%d: %s", end, guess);
			if (end == 2) {
				close(pgr[1]);
				close(ppr[1]);
				return 0;
			}
			close(pgw[0]);
			close(pgr[1]);
			end = 1;
		}

		if (end == 2) {
			// cannot write to prog, it exited on winner, but gen disagrees
			printf("ERROR: prog reported win, gen does not\n");
			close(pgr[1]);
			close(ppr[1]);
			return 1;
		}

		n = write(ppr[1], report, n);
		if (n < 0) error("ppw[1]");
		n = xread(ppw[0], guess, 6);
		if (n != 6) {
			if (n < 0) error("read ppr");
			printf("bad read from pipe_prog: %d {%.*s}\n", n, n, guess);
			return 3;
		}
		if (strncmp(guess, xyzzy, sizeof(xyzzy)-1) == 0) {
			printf("ERROR: desired word not in this dictionary\n");
			close(pgr[1]);
			close(ppr[1]);
			return 1;
		}

		// might not prompt, just exit
		if (xread(ppw[0], report, 2) == 0) { // read the prompt
			printf("prog: EOF\n");
			if (end == 1) {
				close(pgr[1]);
				close(ppr[1]);
				return 0;
			}
			end = 2;
			close(ppr[1]);
			close(ppw[0]);
		}
	}
}
