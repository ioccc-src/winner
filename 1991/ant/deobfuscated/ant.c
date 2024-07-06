/*
 *	ae.c		Anthony's Editor  IOCCC '91
 *
 *	Public Domain 1991 by Anthony Howe.  All rights released.
 */

#include <ctype.h>
#include <curses.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>


int done;
int row, col;
int idx, page, epage;
char buf[BUF];
char *ebuf;
char *gap = buf;
char *egap;
char *filename;

/*
 *	The following assertions must be maintained.
 *
 *	o  buf <= gap <= egap <= ebuf
 *		If gap == egap then the buffer is full.
 *
 *	o  point = ptr(idx) and point < gap or egap <= point
 *
 *	o  page <= idx < epage
 *
 *	o  0 <= idx <= pos(ebuf) <= BUF
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

int adjust();
int nextline();
int pos();
int prevline();
char *ptr();

void bottom();
void delete();
void display();
void down();
void file();
void insert();
void left();
void lnbegin();
void lnend();
void movegap();
void pgdown();
void pgup();
void redraw();
void right();
void quit();
void top();
void up();
void wleft();
void wright();

char key[] = "hjklHJKL[]tbixWRQ";
void (*func[])() = {
	left, down, up, right, 
	wleft, pgdown, pgup, wright,
	lnbegin, lnend, top, bottom, 
	insert, delete, file, redraw, quit, movegap
};

char *
ptr(offset)
int offset;
{
	if (offset < 0)
		return (buf);
	return (buf+offset + (buf+offset < gap ? 0 : egap-gap));
}

int
pos(pointer)
char *pointer;
{
	return (pointer-buf - (pointer < egap ? 0 : egap-gap)); 
}

void
top()
{
	idx = 0;
}

void
bottom()
{
	epage = idx = pos(ebuf);
}

void
quit()
{
	done = 1;
}

void
redraw()
{
	clear();
	display();
}

void
movegap()
{
	char *p = ptr(idx);
	while (p < gap)
		*--egap = *--gap;
	while (egap < p)
		*gap++ = *egap++;
	idx = pos(egap);
}

int
prevline(offset)
int offset;
{
	char *p;
	while (buf < (p = ptr(--offset)) && *p != '\n')
		;
	return (buf < p ? ++offset : 0);
}

int
nextline(offset)
int offset;
{
	char *p;
	while ((p = ptr(offset++)) < ebuf && *p != '\n')	
		;
	return (p < ebuf ? offset : pos(ebuf));
}

int
adjust(offset, column)
int offset, column;
{
	char *p;
	int i = 0;
	while ((p = ptr(offset)) < ebuf && *p != '\n' && i < column) {
		i += *p == '\t' ? 8-(i&7) : 1;
		++offset;
	}
	return (offset);
}

void
left()
{
	if (0 < idx)
		--idx;
} 

void
right()
{
	if (idx < pos(ebuf))
		++idx;
}

void
up()
{
	idx = adjust(prevline(prevline(idx)-1), col);
}

void
down()
{
	idx = adjust(nextline(idx), col);
}

void
lnbegin()
{
	idx = prevline(idx);
}

void
lnend()
{
	idx = nextline(idx);
	left();
}

void
wleft()
{
	char *p;
	while (!isspace(*(p = ptr(idx))) && buf < p)
		--idx;
	while (isspace(*(p = ptr(idx))) && buf < p)
		--idx;
}

void
pgdown()
{
	page = idx = prevline(epage-1);
	while (0 < row--)
		down();
	epage = pos(ebuf);
}

void
pgup()
{
	int i = LINES;
	while (0 < --i) {
		page = prevline(page-1); 
		up();
	}
}

void
wright()
{
	char *p;
	while (!isspace(*(p = ptr(idx))) && p < ebuf)
		++idx;
	while (isspace(*(p = ptr(idx))) && p < ebuf)
		++idx;
}

void
insert()
{
	int ch;
	movegap();
	while ((ch = getch()) != '\f') {
		if (ch == '\b') {
			if (buf < gap)
				--gap;
		} else if (gap < egap) {
			*gap++ = ch == '\r' ? '\n' : ch;
		}
		idx = pos(egap);
		display();
	}
}

void
delete()
{
	movegap();
	if (egap < ebuf)
		idx = pos(++egap);
}

void
file()
{
	int i;
	int j = idx;
	idx = 0;
	movegap();
	write(i = creat(filename, MODE), egap, (int)(ebuf-egap));
	close(i);
	idx = j;
}

void
display()
{
	char *p;
	int i, j;
	if (idx < page)
		page = prevline(idx);
	if (epage <= idx) {
		page = nextline(idx); 
		i = page == pos(ebuf) ? LINES-2 : LINES; 
		while (0 < i--)
			page = prevline(page-1);
	}
	move(0, 0);
	i = j = 0;
	epage = page;
	while (1) {
		if (idx == epage) {
			row = i;
			col = j;
		}
		p = ptr(epage);
		if (LINES <= i || ebuf <= p)
			break;
		if (*p != '\r') {
			addch(*p);
			j += *p == '\t' ? 8-(j&7) : 1;
		}
		if (*p == '\n' || COLS <= j) {
			++i;
			j = 0;
		}
		++epage;
	}
	clrtobot();
	if (++i < LINES)
		mvaddstr(i, 0, "<< EOF >>");
	move(row, col);
	refresh();
}

int
main(argc, argv)
int argc;
char **argv;
{
	int ch, i;
	egap = ebuf = buf + BUF;
	if (argc < 2)
		return (2);
	initscr();
	raw();
	noecho();
	idlok(stdscr, 1);
	if (0 < (i = open(filename = *++argv, 0))) {
		gap += read(i, buf, BUF);
		if (gap < buf)
			gap = buf;
		close(i);
	}
	top();
	while (!done) {
		display();
		i = 0; 
		ch = getch(); 
		while (key[i] != '\0' && ch != key[i])
			++i;
		(*func[i])();
	}
	endwin();
	return (0);
}
