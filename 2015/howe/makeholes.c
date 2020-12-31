/*
 * makeholes.c
 */
 
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <sys/stat.h>

static unsigned char hole = '@';
static unsigned long count = 100;

static const char usage[] = 
"usage: makeholes [-b value][-c char][-n count] file ...\n";

int
offcmp(const void *a, const void *b)
{
	return *(off_t *)a - *(off_t *)b;
}

void
process(const char *file)
{
	ssize_t x;
	int fd, rd;
	size_t size;
	struct stat sb;
	unsigned long n;
	off_t mask, *seeks;

	if (stat(file, &sb) != 0)
		return;
	if ((fd = open(file, O_WRONLY)) < 0)
		return;
	if ((rd = open("/dev/urandom", O_RDONLY)) < 0) 
		goto error1;
	size = count * sizeof (*seeks);
	if ((seeks = malloc(size)) == NULL)
		goto error2;

	for (x = 0; x < size; )
		x += read(rd, seeks+x, size-x);
	
	mask = (off_t)(~0UL >> 1);
	for (n = 0; n < count; n++) {
		seeks[n] &= mask;
		seeks[n] %= sb.st_size;
	}

	qsort(seeks, count, sizeof (*seeks), offcmp);

	for (n = 0; n < count; n++) {
		if (lseek(fd, seeks[n], SEEK_SET) < 0)
			break;
		if (write(fd, &hole, sizeof (hole)) != sizeof (hole))
			break;
	}

	free(seeks);
error2:
	(void) close(rd);
error1:
	(void) close(fd);
}

int
main(int argc, char **argv)
{
	int ch, argi;

	while ((ch = getopt(argc, argv, "b:c:n:")) != -1) {
		switch (ch) {
		case 'b':
			hole = (unsigned char) strtoul(optarg, NULL, 0);
			break;
		case 'c':
			hole = (unsigned char) *optarg;
			break;
		case 'n':
			count = strtoul(optarg, NULL, 10);
			break;
		default:
			optind = argc;
			break;
		}
	}

	if (argc <= optind) {
		(void) fprintf(stderr, usage);
		return EXIT_FAILURE;
	}

	for (argi = optind; argi < argc; argi++)
		process(argv[argi]);

	return EXIT_SUCCESS;
}

