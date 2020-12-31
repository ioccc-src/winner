	  // leading whitespace comment
main(int ac, char **av) {
	char foo[] = "line one\n\
	two\n\
	three\n";
	if (av[0][0] == '"') {
		switch (av[0][1]) {
		case 'a': printf("a\n"); break;
		case 'b': printf("b\n"); break;
		}
	}
	while (--ac > 0)
		printf("%d", ac);
	printf(foo);
	return 0;
}
