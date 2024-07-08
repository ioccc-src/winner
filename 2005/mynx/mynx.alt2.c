/*
 * mynx.c
 *
 * Copyright 2005 by Anthony Howe. All rights reserved.
 */

#define LENGTH			512

/***********************************************************************
 *** No configuration below this point.
 ***********************************************************************/

#include <errno.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

#if defined(__WIN32__) || defined(__CYGWIN__)
#include <windows.h>
#include <winsock2.h>
#ifdef ORIGINAL_VERSION
#define EISCONN        	WSAEISCONN
#define EINPROGRESS		WSAEINPROGRESS
#define UPDATE_ERRNO		if (errno == 0)	errno = WSAGetLastError()
#endif
#else
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>
#define UPDATE_ERRNO
#define SOCKET			int
#define closesocket		close

/* The ioctl() TIOCGWINSZ call return the same information in the same
 * order for Linux, System V, abd *BSD, but for some stupid reason they
 * can't agree on a standard structure name. Fuck'em.
 *
 * Linux, System V:
 *
 * 	struct winsize {
 *		unsigned short ws_row;
 *		unsigned short ws_col;
 *		unsigned short ws_xpixel;
 *		unsigned short ws_ypixel;
 *	};
 *
 *
 * OpenBSD
 *
 *	struct ttysize {
 *		unsigned short  ts_lines;
 *		unsigned short  ts_cols;
 *		unsigned short  ts_xxx;
 *		unsigned short  ts_yyy;
 *	};
 */
#include <sys/ioctl.h>
#endif

#define peek(f)			ungetc(fgetc(f), f)

FILE *fp;

short winsz[4] = { 24, 80 };
int linksLength, bufferLength, row, port;
char *links[LENGTH], buffer[BUFSIZ], fmtbuf[BUFSIZ], entities[LENGTH][10], text[LENGTH], host[LENGTH];

int
entity(char *s)
{
	int n = 0;

	if (*s == '#')
		return (int) strtol(s+1, NULL, 0);

	while (n < LENGTH) {
		if (*entities[n] != '\0' && strcmp(s, entities[n]+1) == 0)
			return *entities[n];
		n++;
	}

	return '?';
}

/*
 * Line wrap print controller.
 */
void
printc(int ch)
{
	/* Flush current line buffer. */
	if (ch == '\n' || winsz[1] - 3 < bufferLength) {
		buffer[bufferLength] = '\0';
		buffer[bufferLength+1] = '\0';
		bufferLength = printf("%s", buffer);
		bufferLength = snprintf(
			buffer, BUFSIZ,
			"\n   %s",
			buffer + bufferLength + 1
		);
		row++;
	}

	/* Compact whitespace. */
	if (buffer[bufferLength-1] != ' ' || !isspace(ch)) {
		/* Append character to line wrap buffer. */
		buffer[bufferLength++] = isspace(ch) ? ' ' : ch;

		/* If we've exceed the screen width, wrap just before previous word. */
		if (winsz[1] - 3 < bufferLength)
			*strrchr(buffer, ' ') = '\0';
	}
}

void
prints(char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	vsnprintf(fmtbuf, LENGTH, fmt, args);
	fmt = fmtbuf;
	while (*fmt != '\0')
		printc(*fmt++);
	va_end(args);
}

/*
 * Find the next occurence of string. If the string is not found.
 * rewind to the file pointer to its starting point.
 *
 * @param fp
 *	File pointer to scan through.
 *
 * @param s
 *	The string to match. An astrisk '*' acts as  wildcard,
 *	scanning over zero or more bytes:
 *
 *	"abc"		match "abc" at the current offset
 *
 *	"*abc"		find "abc" from the current offset.
 *
 *	"abc*def"	match "abc", then find "def".
 *
 *	"*abc*def"	find "abc", then find "def"
 *
 * @return
 *	True on a successful match.
 */
int
fnext(char *s)
{
	int ch;
	char *t = s;
	long mark = ftell(fp);

	while (*t != '\0' && (ch = fgetc(fp)) != EOF) {
		if (*t == '*')
			s = t++;
		if (tolower(ch) != *t) {
			if (*s != '*')
				break;
			t = s;
		}

		t++;
	}

	if (*t != '\0')
		fseek(fp, mark, SEEK_SET);

	return *t == '\0';
}

/*
 * Flush the line wrap buffer and outdent the heading that
 * is to follow.
 */
void
head(char *s)
{
	if (4 < bufferLength)
		printc('\n');
	printc('\n');
	if (*s == 'h')
		bufferLength = 1;
}

/*
 * This used to be two functions. It handles the parsing of
 * <a href="URL">, <img alt="text", and <frame src="URL"> to
 * add links to the link table. It also handles line separation
 * for text formatting tags like </p>, <hr/>, <br/>, and some
 * some others (see tablep[] below).
 */
void
link(char *s)
{
	text[0] = '\0';
	fscanf(fp,
		peek(fp) == '"'
			? "\"%511[^\"]"
			: "'%511[^']",
		text
	);
	if (*s == 'a' || *s == 'f' || s[1] == 'f') {
		free(links[++linksLength]);
		links[linksLength] = strdup(text);
		prints(" [%d] ", linksLength);
	}

	if (*s != 'a')
		prints("%s%s\n", text, *s == 'b' || s[1] == 'h' ? "" : "\n");
	fnext("*>");
}

void *table[] = {
	"!--*-->"	,	NULL	,
	"a *href="	,	link	,	/* Assumes space after tag name */
	"ifr*src="	,	link	,
	"fra*src="	,	link	,
	/* If we search for "img*alt=" and the current tag has no alt
	 * attribute, then we could end up scanning over lots of text
	 * and tags until we find one. An <img> can only be assured to
	 * have a src attribute.
	 */
	"img*src="	,	link	,
	"p*>"		,	head	,	/* Closing tag not certain. */
	"bl*>"		,	head	,
	"br"		,	link	,
	"hr"		,	link	,
	"h*>"		,	head	,
	"/h"		,	link	,
	"/tr"		,	link	,
	"/dt"		,	link	,
	"/dd"		,	link	,
	"li*>"		,	head	,	/* Closing tag not certain. */
	"*>"		,	NULL	,	/* Skip other tags. */
	NULL		,	NULL
};

int
main(int argc, char **argv)
{
	int ch, n = 0;
	char *url = argv[1];

#if defined(__WIN32__) || defined(__CYGWIN__)
	WORD version;
	WSADATA wsaData;

	version = MAKEWORD(2, 2);
	if (WSAStartup(version, &wsaData) != 0)
		return 1;
#else
# ifdef TIOCGWINSZ
	ioctl(0, TIOCGWINSZ, winsz);
# endif
#endif

	fp = fopen("entities.txt", "r");
	if (fp != NULL) {
		while (fscanf(fp, "%s %d", entities[n]+1, &ch) == 2)
			*entities[n++] = ch;
		fclose(fp);
		n = 0;
	}

	while (url != NULL) {
		SOCKET fd = 0;
		struct hostent *he;
		struct sockaddr_in addr;

		linksLength = 0;
		bufferLength = 1;

		if (sscanf(url, "http://%255[^/]%n", host, &n) == 0 && *host == '\0') {
			/* Assume local file. */
			if ((fp = fopen(url, "rb")) == NULL)
				return 1;
			goto nextpage;
		}

		/* Parse the URL into host, port, URI. */
		if (0 < sscanf(host, "%*[^:]%n:%d", &ch, &port))
			host[ch] = '\0';
		else
			port = 80;

		/* Build the web site address. */
		he = gethostbyname(host);
		if (he == NULL)
			/* NOTE that Win32 does not handle IP address for the
			 * host name and so must be handled separately, before
			 * considering this a true error.
			 */
			return 1;

		memcpy(&addr.sin_addr.s_addr, he->h_addr, he->h_length);
		addr.sin_port = htons(/* (unsigned short) */ (short) port);
		addr.sin_family = he->h_addrtype;

		/* Create a really short lived cache file. */
		fp = tmpfile();
		if (fp == NULL)
			return 1;

#ifdef ORIGINAL_VERSION
		while (connect(fd = socket(addr.sin_family, SOCK_STREAM, 0),/* (struct sockaddr *) */ (void *) &addr, sizeof addr) != 0) {
			UPDATE_ERRNO;
			if (errno == EISCONN)
				break;
			if (errno != EINTR)
				goto error1;
		}
#else
		while (
			connect(
				fd = socket(
					addr.sin_family, SOCK_STREAM, 0
				),/* (struct sockaddr *) */ (void *) &addr, sizeof addr
			) != 0
			|| errno == EINTR
		)
			;

		/* This should work, because for EISCONN we break the loop
		 * and proceed to send the request. For other errors, we
		 * break the loop and generate another error for the send(),
		 * which by passes the response and closes the socket.
		 */
#endif

		n = snprintf(
			buffer, BUFSIZ,
			"GET %s%s HTTP/1.0\r\nHost: %s:%d\r\n\r\n",
			url[n] == '/' ? "" : "/", url+n, host, port
		);
		if (send(fd, buffer, n, 0) == n) {
			/* Cache the response. */
			while (0 < (n = recv(fd, buffer, BUFSIZ, 0)))
				fwrite(buffer, 1, n, fp);
		}
#ifdef ORIGINAL_VERSION
error1:
#else
#endif
		closesocket(fd);
		rewind(fp);

		/* We don't parse the response status or handle redirection,
		 * since RFC 2616 stipulates for most error responses SHOULD
		 * provide content explaining the error or a hypertext link
		 * for the user to follow for pre HTTP/1.1 software.
		 */

		(void) fnext("*\r\n\r\n");
nextpage:
		row = 3;

		/* The start of the buffer must contain a sentinel space,
		 * else the printc() line wrapping can seg.fault.
		 */
		buffer[0] = ' ';

		while (row < winsz[0] && (ch = fgetc(fp)) != EOF) {
			if (ch == '<') {
				void **p = table;
				while (*p != NULL) {
					if (fnext(*p)) {
						if (p[1] != NULL)
							(* (void (*)(char *))
							p[1])(*p);
						break;
					}
					p += 2;
				}
			} else {
				if (ch == '&') {
					fscanf(fp, "%9[^;];", text);
					ch = entity(text);
				}

				printc(isspace(ch) ? ' ' : ch);
			}
		}

		printf("\n? ");
		fflush(stdout);

		fgets(text, LENGTH, stdin);
		if (*text == '\n')
			goto nextpage;

		url = links[strtol(text, NULL, 0)];
		fclose(fp);
	}

	return 0;
}
