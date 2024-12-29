#define B break;
#define Q if(
#define R return
#define V getenv(
#define T "DOCUMENT_ROOT"
#define S snprintf(
#define C strcspn(u,
#include <fcntl.h>
#include <dirent.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#define Z				8192
char r[Z], q[Z], l[Z], w[Z], *o, *m = "404 Not Found", *e = "500 Error";
void
X(int t, char *u, long j)
{
				j = S 
								q, Z,
								"HTTP/1.0 %s\r\nContent-Length: %ld\r\n\r\n%s",
								u, j ? j : C ""), j ? "" : u
				);
				send(t, q, j, 0);
}
void
A(char *i, char *j)
{
				char *u;
				Q (u = strstr(o, i + 5)))
								sscanf(u + C ":") + 1, j, V i));
}
int
main(int c, char **p)
{
				int f, t, i;
				struct stat g;
				struct sockaddr_in a;
				char *v, *u;
								R 1;
				Q (v = V "SERVER_PORT")) == 0) {
								R 4;
				}
				i = (int) strtol(v, 0, 10);
				a.sin_addr.s_addr = htonl(INADDR_ANY);
				a.sin_port = htons((unsigned short) i);
				a.sin_family = AF_INET;
				Q (f = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
								R 5;
				}
				Q bind(f,  (void *) &a, sizeof a)) {
								R 6;
				}
				Q listen(f, 10)) {
								R 7;
				}
				for ( ; ; close(t)) {
								for ( ; waitpid(0, 0, WNOHANG) > 0; )
												;
								i = sizeof a;
								Q (t = accept(f,  (void *) &a, &i)) < 0)
												continue;
								Q fork())
												continue;
								for (f = i = 0; f < 2 && i < Z; i++) {
												Q recv(t, r + i, 1, 0) <= 0)
																R 1;
												Q r[i] == '\n')
																f++;
												Q r[i] == ':')
																f = 0;
												Q f)
																r[i] = r[i] == '-' ? '_' : toupper(r[i]);
								}
								Q Z <= i)
												B
								r[i] = 0;
								Q *r != 'G' && *r != 'H' && r[2] != 'S') {
												X(t, "501 Unsupported", 0);
												B
								}
								*l = 0;
								Q (v = strstr(r, "HOST:")))
												sscanf(v+5, " %255[^:\r\n]", l);
								S w, Z, T "=%s/%s", V T), l);
								putenv(w);
								u = r + 4 + (*r != 'G');
 								Q *u != '/' || strstr(u, "../")) {
												X(t, m, 0);
												B
								}
								u[i = C " ")] = 0;
								o = u + i + 1;
								i = C "?");
								Q u[i]) {
												S q, Z, "QUERY_STRING=%s", u+i+1);
												putenv(q);
												u[i] = 0;
								}
								S l, Z, "SCRIPT_FILENAME=%s%s", w+14, u);
								v = l+16;
								Q stat(v, &g) < 0) {
												X(t, m, 0);
												B
								}
								Q S_ISDIR(g.st_mode)) {
												struct dirent *d;
												DIR *D = opendir(v);
												for ( ; (d = readdir(D)); ) {
																Q !strncmp(d->d_name, "index.", 6)) {
																				strncat(v, d->d_name, Z-16);
																				stat(v, &g);
																				B
																}
												}
												closedir(D);
												Q d == 0) {
																X(t, m, 0);
																B
												}
								}
								Q *r != 'H') {
												Q g.st_mode & 0111) {
																putenv(l);
																sscanf(r, "%4s", V "REQUEST_METHOD"));
																sscanf(inet_ntoa(a.sin_addr), "%15s", V "REMOTE_ADDR"));
																A("HTTP_COOKIE", "%*[ \t]%80[^\r\n]");
																A("CONTENT_LENGTH", "%20s");
																A("CONTENT_TYPE", "%60s");
																dup2(t, 0);
																dup2(t, 1);
																Q system(v))
																				X(t, e, 0);
																B
												}
												Q (f = open(v, O_RDONLY)) < 0) {
																X(t, e, 0);
																B
												}
								}
								X(t, "200 OK", g.st_size);
								Q *r != 'H') {
												for ( ; 0 < (i = read(f, r, Z)); )
																send(t, r, i, 0);
								}
								B
				}
				shutdown(t, SHUT_WR);
				R 0;
}
