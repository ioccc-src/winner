int count;
main(argc, argv, env)
    char **argv, **env;
{
    if (count++ < 512) {
	main(1 & (env ? (int) env : argc) | argc * 2, argv, putchar(count % 32 ? atoi(1[argv]) >> (7 & argc << !env >> !env + 29) & 32 < count | count == 16 ? '#' : ' ' : '\n') % 10);
    }
}
