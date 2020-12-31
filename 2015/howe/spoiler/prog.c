/*
 * npdif.c
 *
 * Wu, Manber, Myers, Miller; August 1989;
 * "An O(NP) Sequence Comparison Algorithm"
 *
 * Public Domain 2015 by Anthony Howe.  No warranty.
 *
 * Synopsis: npdif <file1> <file2>
 *
 * Exit Status
 *	0	no difference
 *	1	difference
 *	2	error
 */

#define FAST
#define FNV64

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

#ifndef INIT_SIZE
#define INIT_SIZE		8196	/* Power of two. */
#endif

/**
 * FNV1a
 *
 * https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function
 * http://programmers.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed
 * http://www.isthe.com/chongo/tech/comp/fnv/index.html
 *
 *	Hash Size	Prime				Offset
 *	32-bit		16777619	0x01000193	2166136261		0x811C9DC5
 *	64-bit		1099511628211	0x100000001b3	14695981039346656037	0xCBF29CE34244AD25
 */
#ifdef FNV64

#define FNV_INIT		14695981039346656037ULL
#define FNV_PRIME		1099511628211ULL

typedef unsigned long long Hash;

#else /* FNV64 */
 
#define FNV_INIT		2166136261UL
#define FNV_PRIME		16777619UL

typedef unsigned long Hash;

#endif /* FNV64 */

typedef struct edit {
	int op;			/* 1 = insert, 0 = delete */
	int x;			/* Index into A. */
	int y;			/* Index into B. */
	long a;			/* seek into A */
	long b;			/* seek into B */
	struct edit *next;
} Edit;

typedef struct {
	int y;
	Edit *edit;
} Vertex;
	
typedef struct {
	long seek;
	Hash hash;
} HashLine;
		
typedef struct {
	size_t size;
	size_t length;
	HashLine base[1];
} HashArray;

static int debug;
static int invert;
static int print_distance;
static HashArray *A, *B;
static FILE *fpA, *fpB;
static Vertex *fp, *fp_base;

#define EXIT_ERROR		2

#define INFO(...)		{ if (0 < debug) warnx(__VA_ARGS__); }
#define DEBUG(...)		{ if (1 < debug) warnx(__VA_ARGS__); }
#define DUMP(...)		{ if (2 < debug) warnx(__VA_ARGS__); }

/*
 * Expand hash table.  
 */
HashArray *
hash_expand(HashArray *orig)
{
	size_t size;
	HashArray *copy;

	/* Size does not account for the initial base element.
	 * So you have 0 < size with a sentinel or 1 <= size.
	 */
	size = orig != NULL ? orig->size << 1 : INIT_SIZE;

	if (NULL == (copy = realloc(orig, sizeof (*orig) + size * sizeof (orig->base))))
		err(EXIT_ERROR, NULL);

	copy->size = size;
	if (orig == NULL)
		copy->length = 0;
	
	return copy;
}

/*
 * @param fp
 *	File to scan and hash by line.
 *
 * @return 
 *	Pointer to an 1-based array of hashed lines.
 */
HashArray *
hash_file(FILE *fp)
{
	Hash h;
	HashArray *hash;
	long lineno, offset, n;
	unsigned char buf[INIT_SIZE], *b;

	hash = hash_expand(NULL);
	
	/* Assume 1-base array. */
	lineno = 1;
	offset = 0;
	h = FNV_INIT;
	hash->base[lineno].seek = offset;
	while (0 < (n = fread(buf, 1, sizeof (buf), fp))) {
		b = buf;
		while (0 < n--) {
			h ^= *b;
#ifdef FAST

#ifdef FNV64
			/* 0x100000001b3 */
			h += (h<<1) + (h<<4) + (h<<5) + (h<<7) + (h<<8) + (h<<40);
#else /* FNV64 */
			/* 0x01000193 */
			h += (h<<1) + (h<<4) + (h<<7) + (h<<8) + (h<<24);
#endif /* FNV64 */
#else /* FAST */
			h *= FNV_PRIME;
#endif /* FAST */
			offset++;
			if (*b++ == '\n') {
				hash->base[lineno++].hash = h;
				if (hash->size <= lineno)
					hash = hash_expand(hash);
				hash->base[lineno].seek = offset;
				h = FNV_INIT;
			}
		}
	}
				
	/* Correct the length, base[1..length] inclusive. */	
	hash->length = lineno-1;
	rewind(fp);
	
	return hash;
}

/*
 * Open file.
 *
 * If filename is the standard input filename -, copy
 * standard input to a temporary file.  Return pointer
 * to the temporary file open for reading.
 *
 * If filename is some other filename then return a
 * pointer to a file stream ready for reading.
 *
 * Any errors, write error message and return NULL.
 */
FILE *
file(char *u)
{
	int i;
	FILE *fp;

	if (NULL == (fp = fopen(u, "r")) && 0 == strcmp("-", u)) {
		if ((fp = tmpfile()) != NULL) {
			while ((i = getchar()) != EOF)
				(void) fputc(i, fp);
			rewind(fp);
		}
	}

	if (NULL == fp) err(EXIT_ERROR, "%s", u);

	return fp;
}

void
echoline(FILE *fp)
{
	int ch;
	while ((ch = fgetc(fp)) != EOF) {
		(void) putchar(ch);						
		if (ch == '\n')
			break;
	}
}

Edit *
reverse_script(Edit *curr)
{
	Edit *a, *b;
	
	b = NULL;
	while (curr != NULL) {
		a = curr->next;
		curr->next = b;
		b = curr;
		curr = a;
	}
	
	return b;
}

void
dump_script(Edit *curr)
{
	Edit *a, *b;

	for (curr = reverse_script(curr); curr != NULL; ) {
		b = curr;
		if (curr->op) {
			do {
				a = b;
DEBUG("curr.x=%d curr.y=%d a.x=%d a.y=%d b.x=%d b.y=%d", curr->x, curr->y, a->x, a->y, b->x, b->y);			
				b = b->next;
			} while (b != NULL && b->op && a->y+1 == b->y);

			if (curr->y < a->y)
				(void) printf("%da%d,%d\n", curr->x, curr->y, a->y);
			else
				(void) printf("%da%d\n", curr->x, curr->y);
			(void) fseek(fpB, curr->b, SEEK_SET);
		
			for ( ; curr != b; curr = curr->next) {
				(void) printf("> ");
				echoline(fpB);
			}
		} else {
			do {
				a = b;
DEBUG("curr.x=%d curr.y=%d a.x=%d a.y=%d b.x=%d b.y=%d", curr->x, curr->y, a->x, a->y, b->x, b->y);			
				b = b->next;
			} while (b != NULL && !b->op && a->x+1 == b->x);

			if (curr->x < a->x)
				(void) printf("%d,%dd%d\n", curr->x, a->x, curr->y);
			else
				(void) printf("%dd%d\n", curr->x, curr->y);
			(void) fseek(fpA, curr->a, SEEK_SET);

			for ( ; curr != b; curr = curr->next) {
				(void) printf("< ");
				echoline(fpA);
			}
		}
	}	
}

void
snake(int k)
{
	/* fp[] holds the furthest y along diagonal k. */
	Vertex h = fp[k-1];
	Vertex v = fp[k+1];
	
	/* max(fp[k-1] + 1, fp[k+1]) */
	int x, y, op;
	Edit *prev;
	if (v.y < h.y+1) {
		op = 1;
		y = h.y+1;
		prev = h.edit;
	} else {
		op = 0;
		y = v.y;
		prev = v.edit;
	}

	/* Diagonal k = y - x of matrix [-(M+1), (N-1)], where
	 * row 0 and column 0 are initialised with sentenial -1.
	 *
	 * k-diagonal	= A and B match
	 * y-horizontal	= insert from B
	 * x-vertical	= delete from A
	 */
	x = y - k;
	DUMP("snake in k=%d y=%d x=%d", k, y, x);

	if (0 < y || 0 < x) {
		Edit *edit = malloc(sizeof (*edit));	
		edit->x = x;
		edit->y = y;		
		edit->next = prev;
		edit->op = op ^ invert;
		edit->a = A->base[x].seek;
		edit->b = B->base[y].seek;
		
		if (invert) {
			/* Swap seek offset to match the open files. */
			long c = edit->a;
			edit->a = edit->b;
			edit->b = c;

			/* Likewise swap line numbers to match seeks. */
			edit->x = y;
			edit->y = x;
		}
		
		fp[k].edit = edit;
		DUMP("edit op=%d x=%d y=%d", edit->op, edit->x, edit->y);
	}

	/* The algorithm assumes 1-based indexing, A[1..M] and B[1..N]. 
	 * NOTE no hash collision checking yet.
	 */
	while (x < A->length && y < B->length && A->base[x+1].hash == B->base[y+1].hash) {
		x++;
		y++;
	}
	
	fp[k].y = y;
	
	DUMP("snake out k=%d y=%d x=%d", k, y, x);
}

int
edit_distance(void)
{
	int k, p, delta;

	/* Swap A and B if N < M.  The edit distance will be the
	 * same, but edit script operations will be reversed.
	 */
	if (A->length > B->length) {
		void *tmp = A;
		A = B;
		B = tmp;
		invert = 1;
		DEBUG("swap A & B");
	}

	/* delta = N - M where A[1..M], B[1..N], and N >= M. */
	delta = B->length - A->length;
	
	/* From -(M+1).. 0 .. (N+1); up & lower sentinels and zero. */
	if (NULL == (fp_base = calloc(A->length + B->length + 3, sizeof (*fp))))
		err(EXIT_ERROR, NULL);		
		
	/* fp[-(M+1)..(N+1)] := -1 */		
	for (k = 0; k < A->length + B->length + 3; k++)
		fp_base[k].y = -1;
	
	/* Shift origin to (M+1). */
	fp = fp_base + A->length + 1;
	
	DEBUG("delta=%d M=%lu N=%lu fp.len=%lu", delta, A->length, B->length, (A->length + B->length + 3));		

	p = -1;
	do {
		p++;
		for (k = -p; k < delta; k++) {
			snake(k);
			DEBUG("1st fp[%d]=%d p=%d ", k, fp[k].y, p);		
		}
		for (k = delta + p; delta <= k; k--) {
			snake(k);
			DEBUG("2nd fp[%d]=%d p=%d ", k, fp[k].y, p);		
		}
	} while (fp[delta].y != B->length);

	if (!print_distance)
		dump_script(fp[delta].edit);
	free(fp_base);

	DEBUG("dist=%d delta=%d p=%d M=%lu N=%lu ", (delta < 0 ? -delta : delta) + 2 * p, delta, p, A->length, B->length);		

	return delta + 2 * p;
}

int
main(int argc, char **argv)
{
	int ch;

	while ((ch = getopt(argc, argv, "dv")) != -1) {
		switch (ch) {
		case 'd':
			print_distance = 1;
			break;
#ifndef NDEBUG
		case 'v':
			debug++;
			break;
#endif /* NDEBUG */
		default:
			optind = argc;
			break;
		}
	}

	if (argc <= optind)
		errx(EXIT_ERROR, "usage: %s [-d] file1 file2", argv[0]);

	fpA = file(argv[optind]);
	fpB = file(argv[optind+1]);

	if (NULL == (A = hash_file(fpA)))
		err(EXIT_ERROR, "%s", argv[optind]);
	if (NULL == (B = hash_file(fpB)))
		err(EXIT_ERROR, "%s", argv[optind+1]);

	ch = edit_distance();
	if (print_distance) printf("%d\n", ch);

#ifndef NDEBUG
	free(A);
	free(B);

	if (ferror(fpA))
		err(EXIT_ERROR, "%s", argv[optind]);
	fclose(fpA);

	if (ferror(fpB))
		err(EXIT_ERROR, "%s", argv[optind+1]);
	fclose(fpB);
#endif /* NDEBUG */

	return 0 < ch;
}
