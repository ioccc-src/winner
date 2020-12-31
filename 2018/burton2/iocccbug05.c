// I is an identifier, not a reserved word
enum Foo {
	I = 1,
	O = 2
};
main(int ac, char**av) {
	for(--ac; *++av; )
		switch (*av[0]-'0') {
		case I: puts("input"); break;
		case O: puts("output"); break;
		default: puts("whatever"); break;
		}
}
