/*
 * Trival err.h
 */

#ifndef __err_h__
#define __err_h__

#ifdef __cplusplus
extern "C" {
#endif

#include <errno.h>
#include <string.h>
#include <stdarg.h>

#define warnx(...)	{ fprintf(stderr, __VA_ARGS__); fputc('\n', stderr); }
#define warn(...)	{ \
	fprintf(stderr, __VA_ARGS__); \
	fprintf(stderr, ": %s\n", strerror(errno)); \
}

#define vwarnx(fmt, args) { vfprintf(stderr, fmt, args); fputc('\n', stderr); }
#define vwarn(fmt, args)  { \
	vfprintf(stderr, fmt, args); \
	fprintf(stderr, "%s%s\n", (fmt) ? ": " : "", strerror(errno)); \
}

#define errx(ex, ...) { fprintf(stderr, __VA_ARGS__); fputc('\n', stderr); exit(ex); }
#define err(ex, ...)  { \
	fprintf(stderr, __VA_ARGS__); \
	fprintf(stderr, ": %s\n", strerror(errno)); \
	exit(ex); \
}

#define verrx(ex, fmt, args) { vfprintf(stderr, fmt, args); fputc('\n', stderr); exit(ex); }
#define verr(ex, fmt, args) { \
	vfprintf(stderr, fmt, args); \
	fprintf(stderr, "%s%s\n", (fmt) ? ": " : "", strerror(errno)); \
	exit(ex); \
}

#ifdef  __cplusplus
}
#endif

#endif /* __err_h__ */