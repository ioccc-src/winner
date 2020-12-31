main(int ac, char **av) {
	if (av[0][0] == '"') {
		switch (av[0][1]) {
		case 'a': printf("a\n"); break;
		case 'b': printf("b\n"); break;
		}
	}
		// comment one
		// comment two
	while (--ac > 0)
		printf("%d", ac);
	return 0;
}
