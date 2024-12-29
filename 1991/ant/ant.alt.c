/*
 * Anthony's Editor
 *
 * Public Domain 1991, 2023 by Anthony Howe.  All rights released.
 */

#include <ctype.h>
#include <curses.h>
#include <fcntl.h>
#include <limits.h>
#include <unistd.h>

#ifndef BUF
# define BUF		(USHRT_MAX)
#endif

#define TABWIDTH	8
#define TABSTOP(col)	(TABWIDTH - ((col) & (TABWIDTH-1)))

static int done;
static int row, col;
static int here, page, epage;
static char buf[BUF];
static char *ebuf;
static char *gap = buf;
static char *egap;
static char *filename;

/*
 *	The following assertions must be maintained.
 *
 *	o  buf <= gap <= egap <= ebuf
 *		If gap == egap then the buffer is full.
 *
 *	o  point = ptr(here) and point < gap or egap <= point
 *
 *	o  page <= here < epage
 *
 *	o  0 <= here <= pos(ebuf) <= BUF
 *
 *
 *	Memory representation of the file:
 *
 *		low	buf  -->+----------+
 *				|  front   |
 *				| of file  |
 *			gap  -->+----------+<-- character not in file
 *				|   hole   |
 *			egap -->+----------+<-- character in file
 *				|   back   |
 *				| of file  |
 *		high	ebuf -->+----------+<-- character not in file
 *
 *
 *	point & gap
 *
 *	The Point is the current cursor position while the Gap is the
 *	position where the last edit operation took place. The Gap is
 *	ment to be the cursor but to avoid shuffling characters while
 *	the cursor moves it is easier to just move a pointer and when
 *	something serious has to be done then you move the Gap to the
 *	Point.
 */

char *
ptr(int offset)
{
	if (offset < 0) {
		return buf;
	}
	return buf+offset + (buf+offset < gap ? 0 : egap-gap);
}

int
pos(char *pointer)
{
	return pointer-buf - (pointer < egap ? 0 : egap-gap);
}

void
top(void)
{
	here = 0;
}

void
bottom(void)
{
	epage = here = pos(ebuf);
}

void
quit(void)
{
	done = 1;
}

void
movegap(void)
{
	char *p = ptr(here);
	while (p < gap) {
		*--egap = *--gap;
	}
	while (egap < p) {
		*gap++ = *egap++;
	}
	here = pos(egap);
}

int
prevline(int offset)
{
	char *p;
	while (buf < (p = ptr(--offset)) && *p != '\n') {
		;
	}
	return buf < p ? ++offset : 0;
}

int
nextline(int offset)
{
	char *p;
	while ((p = ptr(offset++)) < ebuf && *p != '\n') {
		;
	}
	return p < ebuf ? offset : pos(ebuf);
}

int
adjust(int offset, int column)
{
	char *p;
	int i = 0;
	while ((p = ptr(offset)) < ebuf && *p != '\n' && i < column) {
		i += *p == '\t' ? TABSTOP(i) : 1;
		++offset;
	}
	return offset;
}

void
display(void)
{
	char *p;
	int i, j;
	if (here < page) {
		page = prevline(here);
	}
	if (epage <= here) {
		page = nextline(here);
		i = page == pos(ebuf) ? LINES-2 : LINES;
		while (0 < i--) {
			page = prevline(page-1);
		}
	}
	move(0, 0);
	clrtobot();
	i = j = 0;
	epage = page;
	for (;;) {
		if (here == epage) {
			row = i;
			col = j;
		}
		p = ptr(epage);
		if (LINES <= i || ebuf <= p) {
			break;
		}
		if (*p != '\r') {
			/* Handle tab expansion ourselves.  Differences
			 * between historical Curses and NCurses 2021
			 * WRT tab handling I can't suss just yet.
			 *
			 * Historical Curses addch() would handle tab
			 * expansion as I recall while (current 2021)
			 * NCurses does not by default it seems.
			 */
			if (*p == '\t') {
				j += TABSTOP(j);
				move(i, j);
			} else {
				addch(*p);
				j++;
			}
		}
		if (*p == '\n' || COLS <= j) {
			++i;
			j = 0;
		}
		++epage;
	}
	if (++i < LINES) {
		mvaddstr(i, 0, "~EOF~");
	}
	move(row, col);
	refresh();
}

void
redraw(void)
{
	clear();
	display();
}

void
left(void)
{
	if (0 < here) {
		--here;
	}
}

void
right(void)
{
	if (here < pos(ebuf)) {
		++here;
	}
}

void
up(void)
{
	here = adjust(prevline(prevline(here)-1), col);
}

void
down(void)
{
	here = adjust(nextline(here), col);
}

void
lnbegin(void)
{
	here = prevline(here);
}

void
lnend(void)
{
	here = nextline(here);
	left();
}

void
wleft(void)
{
	char *p;
	while (!isspace(*(p = ptr(here))) && buf < p) {
		--here;
	}
	while (isspace(*(p = ptr(here))) && buf < p) {
		--here;
	}
}

void
pgdown(void)
{
	page = here = prevline(epage-1);
	while (0 < row--){
		down();
	}
	epage = pos(ebuf);
}

void
pgup(void)
{
	int i = LINES;
	while (0 < --i) {
		page = prevline(page-1);
		up();
	}
}

void
wright(void)
{
	char *p;
	while (!isspace(*(p = ptr(here))) && p < ebuf) {
		++here;
	}
	while (isspace(*(p = ptr(here))) && p < ebuf) {
		++here;
	}
}

void
insert(void)
{
	int ch;
	movegap();
	while ((ch = getch()) != '\e' && ch != '\f') {
		if (ch == '\b') {
			if (buf < gap) {
				--gap;
			}
		} else if (gap < egap) {
			*gap++ = ch == '\r' ? '\n' : ch;
		}
		here = pos(egap);
		display();
	}
}

void
delete(void)
{
	movegap();
	if (egap < ebuf) {
		here = pos(++egap);
	}
}

void
file(void)
{
	int i;
	int j = here;
	here = 0;
	movegap();
	(void) write(i = creat(filename, MODE), egap, (int)(ebuf-egap));
	(void) close(i);
	here = j;
}

static char key[] = "hjklHJKL[]tbixWRQ";

static void (*func[])(void) = {
	left, down, up, right,
	wleft, pgdown, pgup, wright,
	lnbegin, lnend, top, bottom,
	insert, delete, file, redraw, quit, movegap
};

int
main(int argc, char **argv)
{
	int ch, i;
	egap = ebuf = buf + BUF;
	if (argc < 2) {
		return 2;
	}
	initscr();
	raw();
	noecho();
	idlok(stdscr, 1);
	if (0 < (i = open(filename = *++argv, 0))) {
		gap += read(i, buf, BUF);
		if (gap < buf) {
			gap = buf;
		}
		(void) close(i);
	}
	top();
	while (!done) {
		display();
		ch = getch();
		for (i = 0; key[i] != '\0' && ch != key[i]; i++) {
			;
		}
		(*func[i])();
	}
	endwin();
	return 0;
}
