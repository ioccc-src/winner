#include <stdio.h>
#include <stdlib.h>
#include "a.out.h"

main(argc, argv) char **argv;
{
    register FILE *fp;
    register short pos = 0, c, n;
    register char *fmt = "";
    if (argc != 2) {
	fprintf (stderr, "Usage: %s file\n", argv[0]);
	exit (1);
    }

    if ((fp = fopen(argv[1], "r")) == NULL) {
	fprintf(stderr, "%s: can't open %s\n", argv[0], argv[1]);
	exit(2);
    }

    fseek (fp, (long) sizeof (struct exec), 0); 
    printf("/* portable between VAX and PDP11 */\n\n");
    printf ("short main[] = {\n");
    for (;;) {
	if (pos == 0)
	    printf("\t");

	c=getc(fp) & 0377;
	if (feof(fp)) break;
	n = getc(fp) << 8|c;

	switch (rand() % 5) {
	    case 0:
	    case 1:
		fmt = "%d"; break;
	    case 2:
		fmt = "%u"; break;
	    case 3:
		fmt = "0%o"; break;
	    case 4:
		fmt = "0x%x"; break;
	}

	if (n == '\\' || n == '\'') fmt = "'\\%c'";
	else if (32 <= n && n < 127 && (rand() % 4)) fmt = "'%c'";
	printf(n < 8 ? "%d" : fmt, n);
	printf(",");
	if (pos++ == 8) {
	    printf("\n");
	    pos = 0;
	}
	else printf(" ");

    }
    printf("};\n");
}
