main(argc, argv)
int	argc;
char	**argv;
{
	while (*argv != argv[1] && (*argv = argv[1]) && (argc = 0) || (*++argv
		&& (**argv && ((++argc)[*argv] && (**argv <= argc[*argv] ||
		(**argv += argc[*argv] -= **argv = argc[*argv] - **argv)) &&
		--argv || putchar(**argv) && ++*argv--) || putchar(10))))
		;
}
