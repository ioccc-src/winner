/*
 * hibachi.c
 *
 * Limited implementation of RFC 2616 & CGI/1.1 specification.
 *
 * Public Domain 2002, 2004 by Anthony Howe.
 *
 * From http://eat.epicurious.com/dictionary/food/index.ssf?DEF_ID=2150
 *
 * 	[hih-BAH-chee]
 *
 * 	Japanese for "fire bowl", a hibachi is just that - a small
 * 	(generally cast-iron) container made for holding fuel
 * 	(usually charcoal). A grill that sits on top of the bowl
 * 	is used to cook various foods. Hibachis come in square,
 * 	oblong and round models. Because of their compact size,
 * 	they're completely portable.
 *
 * Usage: SERVER_PORT=<port> DOCUMENT_ROOT=<path> hibachi
 */

#define NDEBUG

/***********************************************************************
 *** No configuration below this point.
 ***********************************************************************/

#include <fcntl.h>
#include <dirent.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
/* #include <signal.h> */
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <ctype.h>

#define Z	8192

FILE *LOG;

char request[Z], query[Z], path[Z], droot[Z], *headers, *notfound = "404 Not Found", *error = "500 Error";

void
status(int client, char *u, long j)
{
	j = snprintf(
		query, Z,
/*		"HTTP/1.0 %s\r\nConnection: close\r\nContent-Length: %ld\r\n\r\n%s", */
		"HTTP/1.0 %s\r\nContent-Length: %ld\r\n\r\n%s",
		u, j != 0 ? j : strcspn(u, ""), j != 0 ? "" : u
	);
	(void) fprintf(LOG, "[%d] status length=%ld\n%s\n", getpid(), j, query);
	send(client, query, j, 0);
}

void
findAndSet(char *i, char *j)
{
	char *u;

	/* `i' is both a header name and an environment variable. Add +5
	 * to `i' in order to skip over `HTTP_' metavariable prefix. This
	 * doesn't interfer with the search for other headers that don't
	 * have an `HTTP_' prefix like `CONTENT_TYPE' and `CONTENT_LENGTH',
	 * because there is sufficiently enough of the header string left
	 * that is unique for the purpose of searching.
	 */
	if ((u = strstr(headers, i + 5)) != (char *) 0)
		sscanf(u + strcspn(u, ":") + 1, j, getenv(i));
	(void) fprintf(LOG, "[%d] %s=%s\n", getpid(), i, getenv(i));
}

int
main(int argc, char **argv)
{
	int fd, client, i;
	struct stat finfo;
	struct sockaddr_in addr;
	char *value, *uri;

	if ((LOG = fopen("hibachi.log", "a")) == (FILE *) 0)
		return 1;
		
	if ((value = getenv("SERVER_PORT")) == (char *) 0) {
		(void) fprintf(LOG, "[%d] SERVER_PORT not defined in environment\n", getpid());
		return 4;
	}

	i = (int) strtol(value, NULL, 10);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons((unsigned short) i);
	addr.sin_family = AF_INET;

	if ((fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
		(void) fprintf(LOG, "[%d] failed to create socket\n", getpid());
		return 5;
	}

	if (0 > bind(fd, /*(const struct sockaddr *) */ (void *) &addr, sizeof addr)) {
		(void) fprintf(LOG, "[%d] failed to bind to port\n", getpid());
		return 6;
	}

	if (0 > listen(fd, 10)) {
		(void) fprintf(LOG, "[%d] failed to listen on port\n", getpid());
		return 7;
	}

	(void) fprintf(LOG, "[%d] listening on port %s\n", getpid(), value);

	/* Use "kill" to terminate the parent server process. */
	for ( ; ; close(client)) {
		/* Reap zombie child processes. */
		for ( ; waitpid(0, NULL, WNOHANG) > 0; )
			;

		i = sizeof addr;
		if ((client = accept(fd, /*(const struct sockaddr *) */ (void *) &addr, &i)) < 0)
			continue;

#ifdef NDEBUG
		/* SunOS technique to avoid zombie processes. */
/*		signal(SIGCHLD, SIG_IGN); */

		if (fork() != 0)
			/* The parent can close the client connection on
			 * success to avoid leaking file handles and on
			 * error to refuse the client connection.
			 *
			 * Refuse the connection, RFC 2616 section 10.5.4
----
10.5.4 503 Service Unavailable

   The server is currently unable to handle the request due to a
   temporary overloading or maintenance of the server. The implication
   is that this is a temporary condition which will be alleviated after
   some delay. If known, the length of the delay MAY be indicated in a
   Retry-After header. If no Retry-After is given, the client SHOULD
   handle the response as it would for a 500 response.

      Note: The existence of the 503 status code does not imply that a
      server must use it when becoming overloaded. Some servers may wish
      to simply refuse the connection.
----
			 * Here we interpret "refuse the connection" as
			 * drop it without giving a reason. Amounts to
			 * the same.
			 */
			continue;

		/******************************************************
		 *** Child process.
		 ******************************************************/

		/* The child doesn't need a copy of the server port. */
/*		close(fd); */
#endif

		/* Read request and headers. Stop if we see two newlines. */
		for (fd = i = 0; fd < 2 && i < Z; i++) {
			if (recv(client, request + i, 1, 0) <= 0)
				/* On error, drop the connection hard. */
				return 1;

			/* The HTTP protocol states that the header names
			 * are case insensitive. Most browsers send them
			 * exactly as shown in RFC 2616 (capitial letters
			 * for first letter of each word), but Lynx doesn't
			 * For example "Content-Length" is sent by Lynx as
			 * "Content-length". This section of code converts
			 * the header names to one case for matching.
			 */
			if (request[i] == '\n')
				/* Count newlines AND lower case of header. */
				fd++;
			if (request[i] == ':')
				/* Don't touch header value. Doesn't work
				 * for headers spanning multiple lines. Rare.
				 */
				fd = 0;
			if (fd != 0)
				/* RFC 2616 BNF grammar for header field-name
				 * is defined to use the US-ASCII character set.
				 * However, we can't do "request[i] | 0x20" to
				 * fold uppper to lower case without testing
				 * to see if it is an alpha character.
				 */
				request[i] = request[i] == '-' ? '_' : toupper(request[i]);
		}

		if (Z <= i)
			/* Request buffer overflow, drop the connection.
			 * The request buffer should be large enough to
			 * hold all the headers and one full size Cookie.
			 * Cookies have a max. length of 4096 bytes.
			 *
			 * We really should return a 413, 500, or 503 error
			 * here. The fact that the buffer is full is like an
			 * "overloaded" server, so we take the shortcut
			 * offered by RFC 2616 section 10.5.4 paragraph 2.
			 */
			break;

		request[i] = '\0';
		(void) fprintf(LOG, "[%d] %s\n", getpid(), request);

		/* Identify the method by testing just one
		 * character position of the method name:
		 *
		 * OPTIONS	O
		 * GET    	G
		 * HEAD   	H
		 * POST   	  S
		 * PUT    	 U
		 * DELETE 	D
		 * TRACE  	T
		 * CONNECT	C
		 *
		 * Also make sure the request is NOT a
		 * proxy request.
		 */
		if (request[0] != 'G' && request[0] != 'H' && request[2] != 'S') {
			(void) fprintf(LOG, "[%d] 501 Method not implemented\n", getpid());
			status(client, "501 Unsupported", 0);
			break;
		}

		/* Determine document root for the virtual host. */
		*path = '\0';
		if ((value = strstr(request, "HOST:")) != (char *) 0)
			sscanf(value+5, " %255[^:\r\n]", path);

		snprintf(droot, Z, "DOCUMENT_ROOT" "=%s/%s", getenv("DOCUMENT_ROOT"), path);
		(void) fprintf(LOG, "[%d] %s\n", getpid(), droot);
		putenv(droot);
/*		chdir(droot+14); */

		/* Parse the request "METHOD /uri/pathinfo?query HTTP/1.1" */
		uri = request + 4 + (request[0] != 'G');

 		/* Disallow relative paths. A chroot() would be more
 		 * effective, but that requires root privileges and is
 		 * against IOCCC contest rules.
 		 *
 		 * NOTE that URI decoding of the path has NOT been
 		 * performed, so paths with sequences like "%2e%2e%2f"
 		 * won't be caught, but will fail below on the stat()
 		 * and return a 404.
 		 *
 		 * We do not decode the URI path partly because of contest
 		 * space issues, but there really is no good reason to 
 		 * encode characters that don't need an encoding, like dot
 		 * and slash. Sites that use stupid characters in file paths
 		 * and names like spaces, special punctuation, and accented
 		 * characters deserve the trouble they get from such practices.
 		 */
 		if (*uri != '/' || strstr(uri, "../") != (char *) 0) {
			(void) fprintf(LOG, "[%d] 403 Relative pathes and proxy requests forbidden [%s]\n", getpid(), uri);
			/* RFC 2616 section 10.4.4 403 Forbidden:
----
10.4.4 403 Forbidden

   The server understood the request, but is refusing to fulfill it.
   Authorization will not help and the request SHOULD NOT be repeated.
   If the request method was not HEAD and the server wishes to make
   public why the request has not been fulfilled, it SHOULD describe the
   reason for the refusal in the entity.  If the server does not wish to
   make this information available to the client, the status code 404
   (Not Found) can be used instead.
----
			 * The last sentence is significant here.
			 */
			status(client, notfound, 0);
			break;
		}

		/* End of request URI on space delimiter. */
		uri[i = strcspn(uri, " ")] = '\0';
		headers = uri + i + 1;

		/* Find end of URI or query delimiter. */
		i = strcspn(uri, "?");
		if (uri[i] != '\0') {
			snprintf(query, Z, "QUERY_STRING=%s", uri+i+1);
			(void) fprintf(LOG, "[%d] %s\n", getpid(), query);
			putenv(query);
			uri[i] = '\0';
		}

		/* Prepare SCRIPT_FILENAME. This variable is required by
		 * PHP/CGI in order to find the input file. PHP/CLI does
		 * not require it and is more like nph-CGI behaviour, but
		 * is sufficiently different from typical web usage to 
		 * confuse webmasters. 
		 *
		 * Use the value after the equals sign to test for file
		 * or directory existance (path+16).
		 */
		snprintf(path, Z, "SCRIPT_FILENAME=%s%s", droot+14, uri);
		(void) fprintf(LOG, "[%d] %s\n", getpid(), path);		
		value = path+16;
		(void) fprintf(LOG, "[%d] %s\n", getpid(), value);
		
		if (stat(value, &finfo) < 0) {
			(void) fprintf(LOG, "[%d] 404 File or directory %s does exist\n", getpid(), value);
			status(client, notfound, 0);
			break;
		}

		/* When a directory, look for the "index" file. */
		if (S_ISDIR(finfo.st_mode)) {
			struct dirent *d;
			DIR *D = opendir(value);
			for ( ; (d = readdir(D)) != (struct dirent *) 0; ) {
				if (0 == strncmp(d->d_name, "index.", 6)) {
					strncat(value, d->d_name, Z-16);
					stat(value, &finfo);
					break;
				}
			}
			closedir(D);

			if (d == (struct dirent *) 0) {
				/* We don't print directory listings. */
				(void) fprintf(LOG, "[%d] 404 Directory listing forbidden\n", getpid());
				/* RFC 2616 section 10.4.4 403 Forbidden, last sentence. */
				status(client, notfound, 0);
				break;
			}
			(void) fprintf(LOG, "[%d] path=%s\n", getpid(), value);
		}

		if (request[0] != 'H') {
			(void) fprintf(LOG, "[%d] mode=%o\n", getpid(), finfo.st_mode);
			if (finfo.st_mode & 0111) {
				/* Execute CGI, which is responsible for sending
				 * back the HTTP response line and headers (see
				 * CGI/1.1 specification "nph" prefix).
				 */

				/* Pass some of the request headers to the CGI.
				 * Overwrite in place the environment variables
				 * preallocated in the environment (see
				 * hibachi-start.sh).
				 */
				 
				putenv(path);

				/* Need this to identify type of request. */
				sscanf(request, "%4s", getenv("REQUEST_METHOD"));
				(void) fprintf(LOG, "[%d] REQUEST_METHOD='%s'\n", getpid(), getenv("REQUEST_METHOD"));

				/* Not sure we need this for most CGIs. */
				sscanf(inet_ntoa(addr.sin_addr), "%15s", getenv("REMOTE_ADDR"));
				(void) fprintf(LOG, "[%d] REMOTE_ADDR=%s\n", getpid(), getenv("REMOTE_ADDR"));

				/* These are needed if the CGI is to do anything
				 * useful.
				 */
				findAndSet("HTTP_COOKIE", "%*[ \t]%80[^\r\n]");
				findAndSet("CONTENT_LENGTH", "%20s");
				findAndSet("CONTENT_TYPE", "%60s");

				/* Redirect standard I/O for the CGI. */
				dup2(client, 0);
				dup2(client, 1);

				/* Call system() instead of execl() so that
				 * we come back here after the CGI call to
				 * properly close the connection. We don't
				 * need to escape shell meta characters,
				 * since the stat() above would have failed
				 * to find a file that did contained them.
				 *
				 * Of course anyone stupid enough to use
				 * shell meta characters for an executable
				 * filename should be shot.
				 */

				/* Note that Cygwin appears to have a bogus
				 * initial \r\n waiting on stdin, which was
				 * never sent by the client. I've seen this
				 * in other programs under Cygwin.
				 */
				if (system(value) != 0)
					status(client, error, 0);
				break;
			}

			if ((fd = open(value, O_RDONLY)) < 0) {
				(void) fprintf(LOG, "[%d] 500 Internal server error\n", getpid());
				status(client, error, 0);
				break;
			}
		}

		/* RFC 2616 section 7.2.1 paragraph 3 allows the Content-Type
		 * to be optional leaving the client to figure it out.
----
   Any HTTP/1.1 message containing an entity-body SHOULD include a
   Content-Type header field defining the media type of that body. If
   and only if the media type is not given by a Content-Type field, the
   recipient MAY attempt to guess the media type via inspection of its
   content and/or the name extension(s) of the URI used to identify the
   resource. If the media type remains unknown, the recipient SHOULD
   treat it as type "application/octet-stream".
----
		 * RFC 2119 defines SHOULD as strongly recommended, but not
		 * absolutely required given sufficient reason. I treat it
		 * more like OPTIONAL.
		 */

		status(client, "200 OK", finfo.st_size);
		(void) fprintf(LOG, "[%d] %s\n", getpid(), query);

		if (request[0] != 'H') {
			/* Send back a static file for GET or POST request.
			 *
			 * There may be input ready for a POST request, but
			 * it doesn't make any sense to read input and waste
			 * bandwidth for a non-CGI.
			 *
			 * Also RFC 2616 section 4.3 paragraph 4 makes reading
			 * a message body optional:
----
   The presence of a message-body in a request is signaled by the
   inclusion of a Content-Length or Transfer-Encoding header field in
   the request's message-headers. A message-body MUST NOT be included in
   a request if the specification of the request method (section 5.1.1)
   does not allow sending an entity-body in requests. A server SHOULD
   read and forward a message-body on any request; if the request method
   does not include defined semantics for an entity-body, then the
   message-body SHOULD be ignored when handling the request.
----
			 * RFC 2119 defines SHOULD as strongly recommended, but not
			 * absolutely required given sufficient reason. I treat it
			 * more like OPTIONAL.
			 */
			for ( ; 0 < (i = read(fd, request, Z)); )
				send(client, request, i, 0);
		}
/*		close(fd); */
		break;
	}

	/* Clean termination of the TCP connection from our end. */
	shutdown(client, SHUT_WR);
/*	close(client); */

	(void) fprintf(LOG, "[%d] end child\n\n", getpid());

	return 0;
}
