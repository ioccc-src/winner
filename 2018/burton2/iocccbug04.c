// this shows the impact of " quotes with -k
char*dquote="dquote";
main(int ac, char **av) {
	if (ac > 1 && av[1][0] == '\"')
		printf(dquote);
	if (ac == 0)
		printf("int ac is zero\n");
}
