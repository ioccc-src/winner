// bug shows under -k
//* int if while
main(int ac, char **av) {
	if (ac > 1)
		while(--ac) puts(*++av);
	else
		puts("none");
}
