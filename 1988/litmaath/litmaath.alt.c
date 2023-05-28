#include <stdio.h>
main(argc, argv)
int	argc;
char	**argv;
{
	while (*argv != argv[1] && (*argv = argv[1]) && (argc = 0) || (*++argv
		&& (**argv && ((++argc)[*argv] && (**argv <= argc[*argv] ||
		(**argv += argc[*argv] -= **argv = argc[*argv] - **argv)) &&
		--argv || putchar(**argv) && ++*argv--) || putchar(10))))
    fprintf(stderr,
     "argv=%lo *argv=%lo **argv=%c argv[1]=%lo *argv[1]=%c argc=%d\n",
     (long) argv, (long) *argv, *argv && **argv ? **argv : '@',
     (long) argv[1], argv[1] && *argv[1] ? *argv[1] : '@', argc);

		;
}
